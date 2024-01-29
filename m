Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24AC5C47DA9
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jan 2024 19:50:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rUXdc-0001IU-IA; Mon, 29 Jan 2024 14:49:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUXdb-0001IJ-81
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:49:47 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rUXdX-0007U5-9X
 for qemu-devel@nongnu.org; Mon, 29 Jan 2024 14:49:46 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-51028fadfe2so3547057e87.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jan 2024 11:49:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1706557780; x=1707162580; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+mDhQA/fFDvBSnXmxm9ChK1XRDRmk/nT8miOc6gpmXo=;
 b=ktkTycBf/9vrR183QX479NrmtFI8rZNJ7xZDQepjwvtfjxo8tyEyBV6/8yBwXsu/lw
 Zkidx72AA+xPkVb6s9A862gHjp+cZX+DnHXhLlqd0JoWokAghpY6ad7D69F3g74wDcq2
 jGy7hzp0cGAwJBTRncccGamq6doRHR/P3xw0xQFpLZFPAk7MI7c0qXz/tjH3RyhxQa6x
 6Qq8zdpfbg39FVH3GoIiNvgMUOgS51b8eC0upWOilObndUPXKkLMTI7lJdpwzi/Li5qu
 0O1IBggpzTghkoogbXjOURO274GGnF5L0WevRzmMEeFDUCOVr1etmd3Uc83ZWQF35qvQ
 JmTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706557780; x=1707162580;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=+mDhQA/fFDvBSnXmxm9ChK1XRDRmk/nT8miOc6gpmXo=;
 b=M0Bb79mL01fNiN9XvenPIP/b1kJveVqbqb7axqRFbq+zgokBmzcFGcZGO1aBoPrTNd
 KRLj/usabsii+zjFG8H7x44n67WPJLvd4L95NMOqM4fRsZiSEY2F6E+zCMvXFhJFPW85
 MmUzlzpkaYneSVAf6AqT7D4zSQkONV/sFAFOG+8s3q2SScHRfLcrbxeeeU9A3dsvu1RY
 Dr0Ptb0J+sonvb9Q985VAdYfodz3U/u8q3sxNGBWW1KIM6dkm5cl776LdAQya44U3O10
 1w1Fle9gW1lGe/2ddm583Dq2CsLvqA2t4M3vHpZDBDg/siEok3Uj4SmDot4shYw6fWSL
 JTqw==
X-Gm-Message-State: AOJu0Yy+w1ckXEnbVl1dTrxUHF56ncCG1E/RyKTgPgqOHXcMwxRPaprZ
 cAsiiPR0Fw/KvN3qA/I9ugYPLe0+xKNUMgL0TLj5MlNNxD0AxewK6OlXSFf5CEg=
X-Google-Smtp-Source: AGHT+IFyzHmGt2qZcvO6rf1Yzc39ciYiGV7Xbj8Fmrn5DunaHMt8kxxYORm+cHPsZ7beVaREFyJCQw==
X-Received: by 2002:a19:8c04:0:b0:511:fa9:867d with SMTP id
 o4-20020a198c04000000b005110fa9867dmr2500558lfd.56.1706557780017; 
 Mon, 29 Jan 2024 11:49:40 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 q13-20020a05600c46cd00b0040e89ade84bsm14991154wmo.4.2024.01.29.11.49.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jan 2024 11:49:39 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 0A20E5F9D1;
 Mon, 29 Jan 2024 19:49:39 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-arm@nongnu.org,  qemu-block@nongnu.org,
 peter.maydell@linaro.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v3 1/6] hw/arm/strongarm.c: convert DPRINTF to trace
 events and guest errors
In-Reply-To: <39db71dd87bf2007cf7812f3d91dde53887f1f2f.1706544115.git.manos.pitsidianakis@linaro.org>
 (Manos Pitsidianakis's message of "Mon, 29 Jan 2024 18:09:36 +0200")
References: <cover.1706544115.git.manos.pitsidianakis@linaro.org>
 <39db71dd87bf2007cf7812f3d91dde53887f1f2f.1706544115.git.manos.pitsidianakis@linaro.org>
User-Agent: mu4e 1.11.27; emacs 29.1
Date: Mon, 29 Jan 2024 19:49:38 +0000
Message-ID: <87sf2frkbx.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=alex.bennee@linaro.org; helo=mail-lf1-x12f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Manos Pitsidianakis <manos.pitsidianakis@linaro.org> writes:

> Tracing DPRINTFs to stderr might not be desired. A developer that relies
> on trace events should be able to opt-in to each trace event and rely on
> QEMU's log redirection, instead of stderr by default.
>
> This commit converts DPRINTFs in this file that are used for tracing
> into trace events. DPRINTFs that report guest errors are logged with
> LOG_GUEST_ERROR.#
>
> Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

