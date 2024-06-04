Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA9DFC25B7E
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Jun 2024 12:44:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sETVf-0003BD-H6; Tue, 04 Jun 2024 08:43:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sETVd-0003Ay-Qo
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:43:26 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sETVb-0002nB-Uu
 for qemu-devel@nongnu.org; Tue, 04 Jun 2024 08:43:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-4212a3e82b6so27183225e9.0
 for <qemu-devel@nongnu.org>; Tue, 04 Jun 2024 05:43:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1717505001; x=1718109801; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=iQOQZ9lCHciRwZ8vodyMBMEuOcdnx61nDKZ/B6c0wOo=;
 b=i/D0nSIdrUHhVPdI21p4+jixpQ5lqsTbTXhsa6oMQ9Xyq4Gs/cmgiUhHxmiUp9f2Rt
 xD7lWEDlXt5MJff8pg8M6lmF1J3WD+BFsgIVfXdMINHmVYrZF4BSEo62CbXNjZd3Hcsz
 jqY11yqYiCa3NFo7psg812HGPL3zK8Bl/rHFNLzDv8k7pNlQ1DsH0YJar84rBmcrN/cZ
 LUWEkQjVIW1cXeiv9LH2S/82H/ZXOkYwPOyi72PrbJD/COHs7fbIY0C7ybx0vcPf84N9
 8mYbpzckRKZu/jvF+4/TIuNf2G7YN0Udt1nuaTOEtwW1V/j3J/bgcj0vEijjKAeeTdyB
 p+FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717505001; x=1718109801;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=iQOQZ9lCHciRwZ8vodyMBMEuOcdnx61nDKZ/B6c0wOo=;
 b=O8taQK2U7i2rrAJTMQeEpKLmdgKcLFtzUPEitYoVz6WmemFruBRt4P5OQZVa+r11iO
 9yylm9MLOdY0CQFHGLdRmpZsmo88P5LU2F3Z3FuIOMWfeNFUmjYceFRgRkZvaY00o8xO
 TowtK5T3WDXCC2QJAn3RXfXVydO6EH6zthaGMb7Ti4wb7QOCYimEkGbA1AgvSWmjcUNR
 /y3tXPhUaZQtvXk816+VCfmgdkCtLD5Cq5ljgEGPGBjHPw4mLRK4GtEvIRmx+68qMpUc
 atw/UeCTe6by42crfchOZVOI0mWrvr577UJfWzbY+LnEBA5T/m0aEhEh0OYO+Wxvjj28
 XZoQ==
X-Gm-Message-State: AOJu0Yzae2RYeu6DgrCYj0VkM2x4GfBTBqeQgxHXixTWFH/O0op4Dc+6
 U9DFSgLN6OXkczi+T69lojEscby3GM49ycjPYXXCNNgr2zkm4ojiYzHpREHPivs=
X-Google-Smtp-Source: AGHT+IH16NvasI4yWXyuYMFnhlHNSDETvBoqzl+rps87NhJLLLEFJCRESr6vSPVv0t1yPwOT1dr5+w==
X-Received: by 2002:a5d:4e83:0:b0:356:4809:1a7e with SMTP id
 ffacd0b85a97d-35e7c57e389mr2259225f8f.34.1717505001263; 
 Tue, 04 Jun 2024 05:43:21 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-35dd066b47asm11390030f8f.112.2024.06.04.05.43.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Jun 2024 05:43:20 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 4240C5F839;
 Tue,  4 Jun 2024 13:43:20 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH] mips64el-softmmu: Enable MTTCG
In-Reply-To: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com> (Jiaxun
 Yang's message of "Sat, 11 May 2024 21:26:35 +0100")
References: <20240511-mips_mttcg-v1-1-1b71d9b85234@flygoat.com>
Date: Tue, 04 Jun 2024 13:43:20 +0100
Message-ID: <87h6e8g9p3.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x32a.google.com
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

Jiaxun Yang <jiaxun.yang@flygoat.com> writes:

> MTTCG was disabled in a092a9554771 ("configure: disable MTTCG
> for MIPS guests") due to test case instability.
>
> I was able to reproduce this issue with in latest QEMU and look
> into reason behind that.
>
> What actually happend is kernel's CP0 timer synchronisation
> mechanism assumed a consistent latency in memory access between
> cores, which TCG can't guarantee. Thus there is a huge drift in
> count value between cores, and in early kernel versions CP0 timer
> is always used as sched_clock.
>
> sched_clock drift back on some cores triggered RCU watchdog in
> some extreme cases.
>
> This can be resolved by setting clocksource to MIPS, which allows
> clocksource to drift together with sched_clock. However this will
> leed to other problems after boot.
>
> Another option would beupdating kernel to later version, which
> will use GIC as sched_clock.

I'm a little uncomfortable about making the success of MTTCG depend on
the user options passed to the kernel.

How come a non-icount run depends on how many instructions are being run
on each core? Why is time not based on the wallclock time and by
definition synced between all cores?

> In non-MTTCG build, the execution is slow enough so kernel won't
> observe back drifts.
>
> Test results:
>
> With clocksource=3DMIPS
> ```
>  ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>     -display none -vga none -serial mon:stdio \
>     -machine malta -kernel ./vmlinux-4.7.0-rc1.I6400 \
>     -cpu I6400 -smp 8 -vga std \
>     -append "printk.time=3D0 clocksource=3DMIPS console=3Dtty0 console=3D=
ttyS0 panic=3D-1" \
>     --no-reboot
>
> 100, 0, PASS, 5.258126, 100, 100, -
> Results summary:
> 0: 100 times (100.00%), avg time 6.508 (55.53 varience/7.45 deviation)
> Ran command 100 times, 100 passes
> ```
>
> With linux-next:
> ```
>  ~/tmp/retry/retry.py -n 100 -c -- ./qemu-system-mips64el \
>     -display none -vga none -serial mon:stdio \
>     -machine malta -kernel ~/linux-next/vmlinux \
>     -cpu I6400 -smp 8 -vga std \
>     -append "printk.time=3D0 console=3Dtty0 console=3DttyS0 panic=3D-1" \
>     --no-reboot
>
> 100, 0, PASS, 4.507921, 100, 100, -
> Results summary:
> 0: 100 times (100.00%), avg time 4.233 (0.04 varience/0.21 deviation)
> Ran command 100 times, 100 passes
> ```
>
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> ---
> I'll leave the test case alone as it's already marked as
> QEMU_TEST_FLAKY_TESTS

We should ensure we have some testing enabled if we switch this on. Was
the FLAKY test marked for MTTCG issues or something else?

> ---
>  configs/targets/mips64el-softmmu.mak | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/configs/targets/mips64el-softmmu.mak b/configs/targets/mips6=
4el-softmmu.mak
> index 8d9ab3ddc4b1..199b1d909a7d 100644
> --- a/configs/targets/mips64el-softmmu.mak
> +++ b/configs/targets/mips64el-softmmu.mak
> @@ -1,3 +1,4 @@
>  TARGET_ARCH=3Dmips64
>  TARGET_BASE_ARCH=3Dmips
> +TARGET_SUPPORTS_MTTCG=3Dy
>  TARGET_NEED_FDT=3Dy
>
> ---
> base-commit: 248f6f62df073a3b4158fd0093863ab885feabb5
> change-id: 20240511-mips_mttcg-47a6b19074b3
>
> Best regards,

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

