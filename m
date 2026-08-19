Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC3D3C5DF81
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:04:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwgt0-0003Dv-VJ; Wed, 19 Aug 2026 10:03:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwgsy-0003Dh-ES
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:03:20 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wwgsw-0005X9-Vq
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:03:20 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-4921eed3fa2so10227635e9.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787148197; x=1787752997; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v1uLQJKaDEO9rPQhNbhsqBghhQaM7OjpGXeVPjrZzrI=;
 b=T9Mmbq13QZL0eaODnuHlTRNt8JobJ2tpMF2xHBN6Q6SWvVuIPr6DDvrEW3/4T7uVc5
 /iCDFVwhj6sc5OZtA78SE+JuC0joyWBXQr+mre3JDD1SzzeDXbdsaY+3keOywKb9KlyF
 yIL/QQC2NEX6Inno0PYX2aVmRWmYEyf3Wtv/HoesZUjNRlloYAcf5zAF9Hhf1aWv84t2
 Hxc2g1bx13gl5SDKu3l2EOT4FitW1XCfIqF+5f/fC3nWsMLZTN7xs5VsGTkMsaWTCrzH
 U+OM/XMPV613TSjMHoLPSr7N/4um1zQdSXgVP6aE+ko3V01Ec/Z/YKSEOViIOzgeyd8P
 fZXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787148197; x=1787752997;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=v1uLQJKaDEO9rPQhNbhsqBghhQaM7OjpGXeVPjrZzrI=;
 b=QJpaQdEnzHLAc+vPw8N/XIMlHPOI4+GDhA5Byux4yylR+G25s9Y9fByfgjh8FpJimW
 F3ncoUzSkF77JOQjPlEccvY3K/BzCWpkm9Yu33a9ge2tvym5z95PeqAtrfKz4gTX3gQn
 bF75oqGcuQLY7vdvk6Njg2BqeW2hx52jXZ885g+L19M34FaTUNhl9AnaOOAQ7FFh/Eej
 Pre3IifXLmfMgJJYnosN+cTnkxINyYEPOju6D2z2dhpizomVvJzT1/3wxB0XoSxVpYyh
 7q66NcFVY1wdPRDv2+nDzVeqQAWibE2biAvvWmMq3zhUrX0kJlUEL1hOTR62sMTUwrEJ
 dT0Q==
X-Gm-Message-State: AOJu0YyvXXzrPMH6GzhOCLjhwFdmFqat3/S6/82kRO4Ymw0BWaOqoP3l
 wCH7pka4DCSOb2unNy9dhAgfk0rNoqZBzIZohpTJDdZUnDUVYYZez3x6EaG4Jf5opX8=
X-Gm-Gg: AR+sD13567YeqlYJK3OSM+9jtwEHsNUmrKlTI6kR5HNChrnTBkJSzjn0mjfbpZIMvP9
 sYLc3vg5r5lHlo4z+f8WunXK9UHMXWIdQ8xAO9mTf1LrFPuXJHRNpns5deQ0KaoQxiQSd5Ls6V2
 KTGRjqwLCbYfc7sL+3BPKvmqvVvKEDO0GIdR+pjQGr2NAg04oKn2q8SL2m+3Ik2X9dq/Q95j/lQ
 vv3jGI4sTOQ1WtkgFGk58USRoqt9E+mG/uMrDOkDcdlZ8GaDcjCLsGCJx5DRg+GVYlcZqp7N4gN
 m3HW3yIxhK71FohSL+zlhT+WyaoII9ikYbHNmm/EvdidSc4ISi/yJHFIyN1nB5hEY45NcdBPCNA
 e3vZNDf4qCSTIyhLI05Lym74wBo4t/LdzeV/g+lMQ/8NLb3kh5WJ86ayYIUthvqPQOw64O5dLyi
 YD1Xli2QoxRvBnrW2hz4wm589mz8dk30Tt3KwRT2diN4oCFxq7cLFgvEaAl/oH
X-Received: by 2002:a05:600c:4ec9:b0:495:6e68:5df2 with SMTP id
 5b1f17b1804b1-499aa1e33femr75547005e9.12.1787148197060; 
 Wed, 19 Aug 2026 07:03:17 -0700 (PDT)
Received: from draig.lan ([185.124.0.156]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0dd5fcsm70182795e9.14.2026.08.19.07.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 19 Aug 2026 07:03:16 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 21F805F805;
 Wed, 19 Aug 2026 15:03:15 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Laurent Vivier
 <laurent@vivier.eu>,  Richard Henderson <richard.henderson@linaro.org>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Helge
 Deller <deller@gmx.de>,  Paolo Bonzini <pbonzini@redhat.com>,  Brian Cain
 <brian.cain@oss.qualcomm.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Peter Maydell
 <peter.maydell@linaro.org>,  Ilya Leoshkevich <iii@linux.ibm.com>,  Aniket
 Sahu <asahu1x@linux.ibm.com>
Subject: Re: [PATCH v7 004/104] meson: bump minimal version to 1.6.0
In-Reply-To: <20260818192309.22169-5-pierrick.bouvier@oss.qualcomm.com>
 (Pierrick Bouvier's message of "Tue, 18 Aug 2026 19:21:28 +0000")
References: <20260818192309.22169-1-pierrick.bouvier@oss.qualcomm.com>
 <20260818192309.22169-5-pierrick.bouvier@oss.qualcomm.com>
User-Agent: mu4e 1.14.3; emacs 30.1
Date: Wed, 19 Aug 2026 15:03:15 +0100
Message-ID: <87a4qiqkbg.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com> writes:

> Without it, we'll get the following warning:
> WARNING: Project specifies a minimum meson_version '>=3D1.5.0' but uses f=
eatures which were added in newer versions:
>  * 1.6.0: {'test with external_program in args'}
>
> Which we require because of how we build iteratively our test command
> line.
>
> Tested-by: Aniket Sahu <asahu1x@linux.ibm.com>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

