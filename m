Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87280C021B2
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Feb 2025 15:47:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tl8lh-00067k-Di; Thu, 20 Feb 2025 10:47:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tl8ld-00066G-3A
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:47:13 -0500
Received: from mail-ej1-x62f.google.com ([2a00:1450:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tl8lZ-0003u3-Df
 for qemu-devel@nongnu.org; Thu, 20 Feb 2025 10:47:10 -0500
Received: by mail-ej1-x62f.google.com with SMTP id
 a640c23a62f3a-abb75200275so178251366b.3
 for <qemu-devel@nongnu.org>; Thu, 20 Feb 2025 07:47:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740066428; x=1740671228; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7krl3Qelxn9mWpfIWbv4HV/eN+bZn+/MOCWknkZCxc=;
 b=vbFQLlBQzlj7TGxHo9fVUjN3tH9UZ1q+WxEKPBcGvGCbxDBFYC6PSmxRyfyn6K1Owv
 FtLoHAbAnsxdgTU7l8dBrsFFL8JjE/xIMzwAK0teg8t6MP7K3zhcddiu07J691Ov7Eoz
 8+fgulkyFPvb6h4MaN4d12+B2nVGC5CLdIHN7ExkI8sat5QU6LxOmXohOc4n31tWw5q3
 fxd/3pkShqGiup6BNxaNHb6BgbRqLdLf3MEWLjCmU9Sg4J5e/+Ud+7OjR0Qqh8NByZwm
 0PBt1Y89FI+a3cNjPrEeGKRmIUAu6hXg2mwEjuffDEbggdOQGh8Q39YA/HDK7Ad8K2B9
 kNnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740066428; x=1740671228;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=F7krl3Qelxn9mWpfIWbv4HV/eN+bZn+/MOCWknkZCxc=;
 b=dhZSW3/vMu/Jyj5DTs3EwRPnpfw23LBCMOUDInrCLXGRxcQua+OlP0aeD5cdQpTrS3
 yP0tpAqfHhtVUfto/yyVQuAeRoYMrDwIx0BeLxsy6yD4euMYHugQTkEfvWxbBqDu3zgn
 RUv+509/Smh+k+gMdpyPYt4Uz7jIFnrmNKRfIlr3Q7U5H/kCW28BZmyJMoa7A9aEAtDR
 vVYnNSmL4ogN+qjOgdcg0sZSo7vfxMpeYMyI87VvXbzTR+Wgr5L8sdt4EGCg/2DFYSgb
 LpK8hOa09mLwEqACBS/X7vzP1gclvDMbloGudWjnDElpfEIcHsqaZmhW881SkRXM2Isr
 aFpA==
X-Gm-Message-State: AOJu0Yy7nLcZ4Cd/r/pWKmpBXJM71m4AwlbOsTrrKkqzV+YhNUU88T9f
 sQLuRgtzOrOMkudfyzp0HsUm/0wy68kIGMBTPfEEhL2tjf+hTGtj/T9haF+L7EM=
X-Gm-Gg: ASbGncs9QeYzvhQ4OTV3Spl0OoB6JTSualeBqz/m/6VWvlY164k3Hajty2lbnfG6us9
 DkJob0x+0xAKxvDJaaXRyy5eQvXhH2LOwz3mBIQUUAdpLMMfFGlcXyYoIKOi/rc4s85OQJ0x61h
 Bvt0wIZirU8+0VMdEG9S2R5j0PXJC8Ja9bFUu23rDATL0bOJie0pNlVGrgiUHuCYcR+MznGLiEf
 c1fHICIVMjSTVTYdsuQTVQSBVKbp3A2EvQ5pxCKEV+ZYIUA37vilodzc/iet2+oClNkzdLFRC46
 CA8icBzWKSoCTUOcMg==
X-Google-Smtp-Source: AGHT+IGeZyRybgghFgQ7YGp9+qWgWs3qG+kNhTj7FbRRMVrGvhyf5nU7P3TAroVt8i5Xrmh5zsseog==
X-Received: by 2002:a17:907:944b:b0:ab7:5a5c:93f6 with SMTP id
 a640c23a62f3a-abbf3ade00emr314308166b.32.1740066427646; 
 Thu, 20 Feb 2025 07:47:07 -0800 (PST)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abb843451b1sm978564666b.42.2025.02.20.07.47.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Feb 2025 07:47:07 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 2BEE85F8AC;
 Thu, 20 Feb 2025 15:47:05 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-s390x@nongnu.org,  qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>
Subject: Re: [PATCH 0/4] testing/next (aarch64 virt gpu tests)
In-Reply-To: <CAFEAcA8Tz97tUBLXD00XkzrbWu3ncOS7tciwkY_Pjq2-jCtBpw@mail.gmail.com>
 (Peter Maydell's message of "Thu, 20 Feb 2025 13:37:35 +0000")
References: <20250219150009.1662688-1-alex.bennee@linaro.org>
 <CAFEAcA8Tz97tUBLXD00XkzrbWu3ncOS7tciwkY_Pjq2-jCtBpw@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Thu, 20 Feb 2025 15:47:05 +0000
Message-ID: <871pvsk492.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62f;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62f.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 19 Feb 2025 at 15:00, Alex Benn=C3=A9e <alex.bennee@linaro.org> w=
rote:
>>
>> Hi,
>>
>> As I was looking at the native context patches I realised our existing
>> GPU testing is a little sparse. I took the opportunity to split the
>> test from the main virt test and then extend it to exercise the 3
>> current display modes (virgl, virgl+blobs, vulkan).
>>
>> I've added some additional validation to ensure we have the devices we
>> expect before we start. It doesn't currently address the reported
>> clang issues but hopefully it will help narrow down what fails and
>> what works.
>>
>> Once I've built some new buildroot images I'll re-spin with a while
>> bunch of additional test binaries available.
>
> Running on a non-sanitizer debug build, I found that
> aarch64_virt_with_virgl_gpu hit the timeout. Looking at the
> output the last thing printed is
> 2025-02-20 11:46:36,864: [shadow] <default>: FPS: 45 FrameTime: 22.585 ms
> That timestamp is 4 minutes into the test run, and the same
> [shadow] test takes over 2 minutes on the with_virgil_blobs_gpu
> test, so it looks like it just hit the 360s timeout and might
> well have finished OK if it had been allowed to keep running.

On my system it takes ~43s to run the plain virgl_gpu test. About 2.5s
to boot the kernel and setup the env and approx 40s to run through each
test. The -b:duration=3D1.0 limits each of the 33 scenes to 1s of runtime.

I'm guessing something in your setup is stalling the scene and instead
of reaching its time limit it stalls and takes more than 1s to recover.

> Actually I'm surprised the other one didn't hit a timeout,
> because its log timestamps show it running from 11:35:03,896
> to 11:42:26,468 which is definitely more than 360s.
>
> Is there a less time-intensive test of the virgl code
> we can use? check-functional already has way too many
> tests that take minutes to run...

I am building a newer rootfs with more testing tools on it so we could
preface with simpler tests and bail early if say the drm device node
can't be seen.

That said I worked quite hard on keeping the runtime bellow 60s and the
benefit of the glmark/vkmark tests is they run through a number of
different scenarios so hopefully exercise a range of the API. It also
has the benefit easily detecting the end from stdout whereas the simpler
tests tend to draw a triangle and then loop forever until you hit
Ctrl-C.


>
> -- PMM

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

