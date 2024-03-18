Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20F43C54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 10:04:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rm9r3-0000Qy-Jk; Mon, 18 Mar 2024 06:04:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9qy-0000PK-Bz
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:04:24 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rm9qv-0005Y2-MF
 for qemu-devel@nongnu.org; Mon, 18 Mar 2024 06:04:24 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2d4a901e284so16902131fa.1
 for <qemu-devel@nongnu.org>; Mon, 18 Mar 2024 03:04:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1710756260; x=1711361060; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=et/UXpKNaqp4THlT+MHUtlJUxfAWwk+TDbvMKEdOZ28=;
 b=J4MGxZYHO66NnVOGGFlSthdj/WLLaOBRcoIshqHX6XQZl4PIjHMh/0E8wat8f2TUgn
 8v750T/sgdj8Zhf8oUikU8tyhcLAF8C1yxDoLbIKrRONGxmsXMyiL81EBRloMJngtTe0
 TqJlm2JNwPusD9+vto83slk1ITg6oGOSZSzsaiKWy+PmTN5g5oW60E1IwFbX/eCB/28w
 h7v7gzGE9x4dJToOQE7FN0MPuKmfUNwI+sueOk1JddDNlrCj7gBJK+Tw6bFfeYI3kqOX
 hrjUdcuHOYQBWVmO1pLwgI72iGeuShud6LW9OzEO6CQvaSG83a/sswLDXT4rPTkAW0mb
 QsYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1710756260; x=1711361060;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=et/UXpKNaqp4THlT+MHUtlJUxfAWwk+TDbvMKEdOZ28=;
 b=HP6b2cgMRVKKDK/GOUtP2E8dYrxXlglgoPgWiLuBMARt2YhnWoaAvHs7mO8a1UiNY8
 z6OeC8WKXEuMFYqdClirgeko8W+DBpFa/TyBaz23xyJQz6/lnZ8W64TltXfZP+MadMig
 teia1/j0O61fKABlkeQVAV5uUPI2QFXCP5nZ3n95U2KCkGplF1S4uKvtksbwpZJ9aF/o
 1g9wApAHb5Wi4zbmlBTviipNQAe5FiRWaW+qxLQZXmfNa6iy9PZFBZSEzYFdhqx52Cl4
 ki6vvd3BbxpRT9nOGHcEgC8vWFyk1V3GxN5A2gPmygYfbm/uJK6+dSAoZ7V97Eq8Egts
 4WGw==
X-Gm-Message-State: AOJu0YwrQDT3n6HOgnE0BNNlM6O2VVo7VEo+3VxqnldCeLKfuXk+vUVT
 jOpHjFec0TrcHlIqllc0skTjWjB1sr02jILq4W6VC8IL1MbID0sSHQQ1meg8Cbs=
X-Google-Smtp-Source: AGHT+IHGmSHsWUVa8gdZALAYiby3+xAopzjw71ycey9qpopQAvqiX2Z0wmGbGMLPrp4qMfr+9WTByw==
X-Received: by 2002:a2e:95d3:0:b0:2d4:68ef:c714 with SMTP id
 y19-20020a2e95d3000000b002d468efc714mr5193327ljh.38.1710756259731; 
 Mon, 18 Mar 2024 03:04:19 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 o19-20020a17090611d300b00a46bd891b5bsm1063734eja.225.2024.03.18.03.04.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 Mar 2024 03:04:19 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id C48B75F7DF;
 Mon, 18 Mar 2024 10:04:18 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org,  pierrick.bouvier@linaro.org
Subject: Re: [PATCH 05/22] plugins: Move function pointer in qemu_plugin_dyn_cb
In-Reply-To: <20240316015720.3661236-6-richard.henderson@linaro.org> (Richard
 Henderson's message of "Fri, 15 Mar 2024 15:57:03 -1000")
References: <20240316015720.3661236-1-richard.henderson@linaro.org>
 <20240316015720.3661236-6-richard.henderson@linaro.org>
User-Agent: mu4e 1.12.2; emacs 29.2
Date: Mon, 18 Mar 2024 10:04:18 +0000
Message-ID: <871q87onz1.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=alex.bennee@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> The out-of-line function pointer is mutually exclusive
> with inline expansion, so move it into the union.
> Wrap the pointer in a structure named 'regular' to match
> PLUGIN_CB_REGULAR.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

