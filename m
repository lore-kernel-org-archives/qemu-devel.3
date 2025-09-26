Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0078CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 15:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2AaG-0006tk-84; Fri, 26 Sep 2025 11:42:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2AaA-0006tO-Qv
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:42:02 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1v2Aa2-00015b-G5
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 11:42:01 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-45ed646b656so17238175e9.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 08:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758901309; x=1759506109; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=r82CAHTP19Wj/973byj/XPVTH+KNSFk9AgINZEkYWBM=;
 b=IAD7y7ZMhKGrfgGLQDpAxG+gsnBf/omYzuOQiNXQX7aCGkfra0x+4YGAefPXIlEIRE
 IaDfrpCnNy4cjLhq1PtQzA5wPah+bYWd27ojszQx5377Shv1WXHiBCLVGPlHU6dp6uVc
 HLwReVeOsDJQ1ghdTcXk2lXQfqTMCjsWWDGzZFjri7LadBB0yrFoy69bk/8oenUv7JJZ
 qe2L5b+575gEbMkVTNjJXekBDJ52OsyagjeUaXH5+uDjXvyCdycAdObgNU+ALJdxqh7S
 WoyiE9r1w8676GP13E2QdV+7wYtWsRQyeLMRwAiSiAQlwclh/Xl7Qck4cF/z9oaAA/QT
 FIAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758901309; x=1759506109;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=r82CAHTP19Wj/973byj/XPVTH+KNSFk9AgINZEkYWBM=;
 b=gdOM6tACqdcyx9aKbXcK1gbGRDrYhJrUjWjsv9yiSO7ZjDnoWIbC6OKEIUf/MZx3sJ
 6Zz8JWbP+8QnQg7Cg7iGjdu2lB48GWqUQL8GAFC/2Fux7wHI7CxRbHtfZMLAzDR2QVJY
 x9LiLRBKjKw2Yau0WW1lOIhahE9AjwAYWoKKyZvUn4VSZ6ij0MVXQFDB4zdLxSLqBCb5
 tsm9erdKkTjMcOohQGN2BZyzR3PTP7VlgarphbGqKrXwFA25Lum+ncI3JS35NqTQF4XM
 q4kRFY4WCbNIBdDizP15hKKbYV1KSV0hVXaDJ2ozMBK+yBlsTvRyd5uw+jXnaF/WLLyN
 4/uQ==
X-Gm-Message-State: AOJu0YxpEee7TC86n2Qzt7PBR3b4h9hh8qw3mDMCAJnL42UlxBG/Ackr
 vN9TO1VdAungOP6Srqhacu3RN2HJdUEVSYYPLbApHkTdbV5Lb/zzpE+CvuBXuGJIHRA=
X-Gm-Gg: ASbGncsLn2HY6XKw7gT24OJ+byBkdbv6p5HX7w2FHJ2XGISI3voDi88U16JO+mtz+Kx
 h/w/IeNT7GFFTuA17BXPsXPXn3JSmlhDsIcZE79MD+MpE/Re13e56biosbuYExD3mEbyVTszLxD
 Lr+hIPmsOGCEWkCW+jW9ipF73EnkhpA4C7YCpbRkLzAPXF7ByV0g1GoPP8jU8QyBAQGuxCg+bMv
 V8ajB9esdACPfDhZMtqLkCw+4GsPkqKGKzb6niQeUg2w3CZ63AIK7+KcCvJExNT9nsZn0FmYuZv
 CFBEolysY8WJv3icrNu0S2qaClVW/nIO5ViPjvtywk57eNQd3A+40aNDokdMGKulYeRpRvT8ZRP
 Y8abVLfqQdhlFs2i9t1+/JBU=
X-Google-Smtp-Source: AGHT+IEJEqCr9/DMPrtKLPp6gXFVO1BAHwyxhW3ZchP98VSwlvqxcN37isJcjbUKKOG+mdMHcgxPyg==
X-Received: by 2002:a5d:5c84:0:b0:3eb:a237:a051 with SMTP id
 ffacd0b85a97d-40e4dabf2bemr7105150f8f.58.1758901308989; 
 Fri, 26 Sep 2025 08:41:48 -0700 (PDT)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc82f2965sm7439725f8f.55.2025.09.26.08.41.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 26 Sep 2025 08:41:48 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 22F435F7C3;
 Fri, 26 Sep 2025 16:41:47 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Kyle Evans
 <kevans@freebsd.org>,  Yonggang Luo <luoyonggang@gmail.com>,  Li-Wen Hsu
 <lwhsu@freebsd.org>,  Thomas Huth <thuth@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Warner Losh <imp@bsdimp.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>,  devel@lists.libvirt.org,
 qemu-rust@nongnu.org,  Kohei Tokunaga <ktokunaga.mail@gmail.com>
Subject: Re: [PATCH v2 04/27] scripts/archive-source: silence subprojects
 downloads
In-Reply-To: <20250924120426.2158655-5-marcandre.lureau@redhat.com> (marcandre
 lureau's message of "Wed, 24 Sep 2025 16:04:01 +0400")
References: <20250924120426.2158655-1-marcandre.lureau@redhat.com>
 <20250924120426.2158655-5-marcandre.lureau@redhat.com>
User-Agent: mu4e 1.12.12; emacs 30.1
Date: Fri, 26 Sep 2025 16:41:47 +0100
Message-ID: <87cy7di5l0.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

marcandre.lureau@redhat.com writes:

> From: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> It's too verbose.
>
> Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

