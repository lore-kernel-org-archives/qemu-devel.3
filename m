Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 324BBC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 11:37:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wi9XY-00031m-Rl; Fri, 10 Jul 2026 07:37:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wi9XW-00031I-RQ
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:37:06 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1wi9XO-0007O2-As
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 07:37:00 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-493c52cde9eso6958925e9.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 04:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783683415; x=1784288215; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oivPX7yTSeilm1mH8034IryAEq5BTBoQ+MeovhJTMNQ=;
 b=vBoB04NL/Q+9XtMeiFC5iXXTvGLSHk80VkZl1l/wihKW5lvw2PwrRd0afwOpV6r1/J
 jNcOzaHcYQhhSr8AUTFpadvVkSuQXtlrptQ/hIpjpNPfkUngH3KxRjmTJ7KRPm24HwQQ
 xCR3yE4wq34/dy0mLdT7Yk9XCu6PXXzHRXfp0/5Ia2xJoxBedMcPkAIGBrI9ebCAuu2u
 Rxga9lDTmdQbhvT3ZOdyOCwBRo48qVV4rar10wp0xmq/GsALhz9VpgisrziHBCklcSmb
 Lgcphn+fx1Lgu9NoMyTHrFCowcPD45by6Oed0LKSffFCLrE69rSYJJJ/KIuQGpVqwl5S
 nN4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783683415; x=1784288215;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :user-agent:references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oivPX7yTSeilm1mH8034IryAEq5BTBoQ+MeovhJTMNQ=;
 b=F0G2a0V9dKTZ6r0guuHZtjVcNKOWFq8ziNeQ/N73dGImUHgdmse2v9hE7ug5l9Stf6
 c6UYQ6+QP0Kk50jFA4RyjjAOF/NTlTl7ZWU8yLvOAg18/7fl2f1I9rrGGQbzPyQIh+4x
 +6tO3YSrtU+0sLWJGcS7aYD1i1Vhu11G84jN5P0wTdJ03GCIAQLWxdn5G0KDizsjujWX
 PcPuV8CvmsjXZm4eV/TfYFYXT27of8bBgq6u48fFtBzM7dV4XnxgRbMsM/Upcd8HiY8x
 ST0RnkR9VpM6Qujj2gw+bBbULCVoYelgH8a3+YNJiWBhSAXb/640qax0uUYehgrx8Nfn
 2ObQ==
X-Gm-Message-State: AOJu0YyZ7spP4DF95h+ivSF3JTgnxv6u/zJMJ0a0z9rAQqwo2wFI0jpi
 cKIKc9cw15d+yxFAU23S8N1xh8ggGnZTMSMsOlIE+FeYKj++1DYNzg4eVQL+Ydg8s30=
X-Gm-Gg: AfdE7cnXzY3sWR7ddYH6GKrhG0tmVj1eHOm/G+32hi6QVMspSTauuEhUk43+JwG6/YY
 j3lEogZzJOdRBk9Lg1+yK4FCiJiExd96moPKpjmMoaz8DgEZh1Ny31lm2gj6eoqUVJ+r1egf4Ab
 8aoN5EWPXE/QV2N6ocut8Iew9dVLtoIt8bYX17ag5FJMpsd1XUM7wSBg8W9zQMMVtz+JJATOeYl
 Z3e5uwZqJL2ebb8w0qxvG/ezOxtFqBQEPREu3HAl0XV5eQpTfbxnPlGhs6pxXByiqUM+Dy0I9fB
 bdvobl32FdoozqRcHN/8thvoX16UTJ6r6JKGi4oKdFYVDwW5sWQ6xLeIFQokd6jAVW+V0o7KSLO
 c73GIj73XC9I+u+tDzaoeKan4XZwy6B1kX4t7x+RZgZPZRZizuBeOIA5EyV40KdNaWGeYyBDSER
 z3q5xzCa4UJlS5tFkJdkTLXHk=
X-Received: by 2002:a05:600c:8b74:b0:493:f6f6:bcb1 with SMTP id
 5b1f17b1804b1-493f6f6bd0dmr6387235e9.25.1783683415149; 
 Fri, 10 Jul 2026 04:36:55 -0700 (PDT)
Received: from draig.lan ([185.124.0.114]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493f567eadfsm30254975e9.6.2026.07.10.04.36.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jul 2026 04:36:53 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id AEFDE5F7C0;
 Fri, 10 Jul 2026 12:36:52 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Thomas
 Huth <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH v2 3/4] tests/docker: allow display of docker output
In-Reply-To: <20260210163556.713841-4-berrange@redhat.com> ("Daniel P.
 =?utf-8?Q?Berrang=C3=A9=22's?= message of "Tue, 10 Feb 2026 16:35:55
 +0000")
References: <20260210163556.713841-1-berrange@redhat.com>
 <20260210163556.713841-4-berrange@redhat.com>
User-Agent: mu4e 1.14.2; emacs 30.1
Date: Fri, 10 Jul 2026 12:36:52 +0100
Message-ID: <87qzlbqdnv.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x332.google.com
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> The --quiet command is used with docker unless V=3D1 is passed to make,
> and as a result stdout from docker is never visible by default, making
> it hard to diagnose failures building / running containers.
>
> Meanwhile passing V=3D1 is undesirable as that makes the entire build
> system verbose.
>
> Introduce a $(DOCKER_V) make variable which is initialized from $(V)
>
> It is thus possible to display docker output without also enabling
> make verbose output.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

