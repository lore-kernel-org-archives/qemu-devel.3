Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11E89C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 19:10:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmIMv-0006O5-SB; Mon, 18 Mar 2024 15:09:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmIMu-0006ME-6F
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:09:56 -0400
Received: from mail-ed1-x529.google.com ([2a00:1450:4864:20::529])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rmIMp-0005U6-1e
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 15:09:55 -0400
Received: by mail-ed1-x529.google.com with SMTP id
 4fb4d7f45d1cf-568a53d2ce0so5613623a12.0
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 12:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710788989; x=1711393789; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VLYf7s7P+Mim+8t5ghEMSPa+MOoPiELoDWkf/l84dqU=;
 b=JBK9VcMFN7RhBXj7+gTholgq5CGuMRC5SjlAIUXaSqsh3lvakV17wiH5XI80Bhhj30
 h+1C51+APVypLbnuVcd6E/9RxRCEjoc6nUpSxirkeXXb/WXoH6k2tJEm4swmSQiWmty5
 WN87ybCHWSxq1f0VHlgKeas+ksKq2z4BwLYDPK6zZqH1/zAohDvWjmV7XUtxtazYNKTj
 MgEaF4VMf0Ryzk5F32Imhu00qf59I223RI6UpR+7Vyh36jnK/RWB0JoNpibqdNgtVmc4
 QyGi1LAncgeITqxH+q/x4fSsQKfd5omnU8ZL1b2Tz+oMwTy9LV3RTH9D1urm84J2cWJJ
 46aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710788989; x=1711393789;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VLYf7s7P+Mim+8t5ghEMSPa+MOoPiELoDWkf/l84dqU=;
 b=V1jlhxtgPupdYw0GnQQg3FgHZSqIamn1j0LCbrQXVTZZIhIxsudtL/1Lj7LGkIrZzB
 Y70WZ+Vewgl53OC9sGviGYM1jlrA70tJhjUXKOF+rwfl2pWp+1N5JAdwYrelfX0eN5pF
 e0FL1CY0ch0u6+lMZxqZDY+oCtUZ1yXnwsdZmh7QIQszxAFA/K+ulk8pop3oyXKrSyLk
 kbseOnUM/WntTjXBokSoYIXHzsP/NUCnoJpUn1tXrZzJsTE5+EeXM95/rX5CLivRe0xB
 PN7/GGLOP7O6j2T98gO3UN3MVlKkilAfHtHK2oKZN48jhfcGk6ICigGTeXv9yWNjzpqF
 u3mQ==
X-Gm-Message-State: AOJu0YwipJLfTx2wUa5Cjha44fbcwysff5yxGT3WAwow63MHpgK3xQ/X
 oE9oTaXQyF1Hlly8Q4BvguuEDM70v+hvMMT87HThwQz2fVi3th5+tIMXLN4srM8=
X-Google-Smtp-Source: AGHT+IHms/5bwKG2MrWZWuH+Ul4vRgofpnOUQdg5CjvhEjfVWX6+z5gkUcww0gmOXyo+edtylzdLkA==
X-Received: by 2002:a17:906:3750:b0:a46:ac55:8e69 with SMTP id
 e16-20020a170906375000b00a46ac558e69mr4465744ejc.14.1710788988795; 
 Mon, 18 Mar 2024 12:09:48 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 hg25-20020a1709072cd900b00a469be48551sm3458270ejc.45.2024.03.18.12.09.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 12:09:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C7CEC5F7B5;
 Mon, 18 Mar 2024 19:09:47 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 21/22] plugins: Inline plugin_gen_empty_callback
In-Reply-To: <20240316015720.3661236-22-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:19 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-22-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 19:09:47 +0000
Message-ID: <87cyrr5pc4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::529;
 envelope-from=alex.bennee@linaro.org; helo=mail-ed1-x529.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Richard Henderson <richard.henderson@linaro.org> writes:

> Each caller can use tcg_gen_plugin_cb directly.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

