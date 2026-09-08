Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16317C79F82
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 17:41:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3zoT-00078g-BX; Tue, 08 Sep 2026 13:40:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3zoM-000789-RJ
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 13:40:47 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3zoL-00016Y-90
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 13:40:46 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-857ff9fef54so45955997b3.1
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 10:40:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788889244; cv=none;
 d=google.com; s=arc-20260327;
 b=GeXfAsbjtpuMfNngZU3pn/7fkxDPKvM9tLxMxztq2cPoBDsr0Y2mCsCMNKp7CzHlPA
 pWmiwLKmrff334JDkbtBoT+DUVKXXHywQgsPxBn6Lm+KbbGsr+dubRlMVFpeqfNvs9U/
 4jJfk5Zf6bME6cffDBJApOAfLPBvQhlVDHNrRz8b2QumCrecaCdpqkD8gJ4PWO5BYWYG
 TLF2dGLONTwp9NP/lG89vfZzhshm+c8gaXRJXKv0ZI3oImHOcY9QaBz8OLKNobhTrP7A
 LmbqIn0vcvy282eZmuNyS6OgqyC2tmKakhrRCMJlbY6VfrJ0wANkKddaMkJwjhpAmeX5
 fHDA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=mDZeK/hP5+0CyeUFwevSlRMIrpib5V78bSozvkyPg8k=;
 fh=AvdUgREFPBGnLKtDjjPes0731VMeA8MKp16N55VMDg4=;
 b=dpDTRB3aVP23zlkCbeav0I8cOJiS7KM8yb99A+OgRLpN21JRTEw2HkMelNx4prc7wH
 dxPlvtBaL2P7/JUZBTaWLOO34ON7Qrw7X/pr7l4pmbjCMEysJfReVyb8pdbe9BnJJSND
 Iul9d8v6wv7R89JGQdzx/jGFQfefahxD1/sDHmEC7hyDCqnOkhOXsCTZ5ANd9lrYQYB+
 LT6mBLz/OImBNVc7YYRsevmZkaj9tGwEPcXXogERpDHpm8Qr9LmXf+sp9ZHu5A30OemC
 k8AGC6TWM1XffNBGKgCsqFUosef1xAxttZkzNtXJU7c0r4w2/ZxANojKfmZohENbAtGZ
 2LGw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788889244; x=1789494044; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=mDZeK/hP5+0CyeUFwevSlRMIrpib5V78bSozvkyPg8k=;
 b=cheeLuLvN94TrroNe8fKyluYKC2CxXgs4rYzneIVsXp3yGzoR7/I1IBWAIHaXYIJ3I
 bmi66cRh5faYBJuT+SK5mWQb7TtZdWxvR9q2tbdtMkBFDmCclHFRDKds8O4p1a/a7jeR
 hryy8tPlVf4oUHHtPrlHQOGffazHbXPXhdyg3Qh2W+FiArd6xkX4xd9YCYrmpQU9AiUo
 A7MmUH9+jka8YcE5mAuKdxNNx8cJB9NWxgHaF/+eMkr6h+gRRaK3BYKC7Q+Vp5z3z3Gt
 HDolRUZgKQvgOSWNiY+K763hldkS4d0wHtabwRQgRNl/ThktmBtt3JGNhaHVpujREfcY
 LGlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788889244; x=1789494044;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=mDZeK/hP5+0CyeUFwevSlRMIrpib5V78bSozvkyPg8k=;
 b=NXhyxonS7d3EnIOHZeAJfuvxg5xEWmzyZSE7uK+I40dHbbVzVKIYejvM5xHGIYp8zQ
 HQtOVSQUPgG19d3JID9JoQH4oGFmCKnBKLrNUIFKo/5IudERfQqfY3yT8jy/mIaWhMIG
 YkU9HyWVRH/gm+d6YFcSedyOTh5B9hEWFtZGBUsx84zluL05F1kgae2Rp/XizM/igr34
 W8GCY5a44ONg0wrw+s2Cd5lp6F7QlD5kTfhUPsEY930rHzcVStyfxaa2uqQGvnGOL8R0
 jPyTp7XjV+9Ini64ySbgjXwgV4iZ1NOvcP62v9acykbjEzw7tKysGmoH36PJO4DR62JC
 eAew==
X-Gm-Message-State: AFuF++kLbXvocXX/zjIFImrdIEy5m1V+AsY92ZiIahK6dpl20oyg3YML
 n9yWxqS8zCBm12t9aDQLlVe6+K6qv8DNFcWWMesNnpYS79hmw5qLdJ7b81/EElZAjRlwmaRLcSL
 fS/hEkDGPxVNK5+U31Mj9aohdSyErwE8W7crcmMnIqRbNr/T7ma5S8OU=
X-Gm-Gg: AYBFou2mz/4zR1FEhiEneRlQe+uj+No2Vyy8j02rv+eASdSg3RA4NHVAzxR6AKjXTgj
 rXeN39yK4obh5c2yMhWdE1vW+TX7Ykl6JDCI2QxjQOS8GRuaQ11pxopam6d2as3ZXgk8UwnTnwn
 sM/i2SmrhyznHt5zRW/cix7M+d/AvCc7wzobZ1fCzp3P9ieHhDYA6d2VPgDZXv2jJHWRb7CvkPU
 2xeock65Fp9qA1m+8+t7zeewcpB9xuvWP8joojFy1JZc38rUH5gojJTTdPnfEcOCfu2snUa80Z2
 qsjFDT4QXpVwWjTfVMJ+rvUOijr6T9h12uXefvK0XIoe6n8cW4BnnnENwELUpZXXCjryUDhKI0t
 O0ov4MIEssxGHgvttTamBkpAKbj9h
X-Received: by 2002:a05:690c:c50e:b0:873:5bb2:6c04 with SMTP id
 00721157ae682-8735bb26ce9mr80339727b3.46.1788889243813; Tue, 08 Sep 2026
 10:40:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260906222551.3712954-1-brian.cain@oss.qualcomm.com>
 <20260906222551.3712954-2-brian.cain@oss.qualcomm.com>
In-Reply-To: <20260906222551.3712954-2-brian.cain@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 18:40:32 +0100
X-Gm-Features: AcwNN1VfuIeBfcirKdMNoAIt5b-CHBaUe6U9l5HO9WiLThdX_pSPk_dXrWr4qqc
Message-ID: <CAFEAcA92z5Hqn=Rb8dH+e8-G_WUSnhruYooq_fDzEC_VYiithA@mail.gmail.com>
Subject: Re: [PATCH 1/3] target/hexagon: Fix semihosting OPEN filename handling
To: Brian Cain <brian.cain@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112c.google.com
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

On Sun, 6 Sept 2026 at 23:25, Brian Cain <brian.cain@oss.qualcomm.com> wrote:
>
> HEX_SYS_OPEN copied guest bytes into a fixed-size buffer until it found a NUL.
> A missing terminator could overrun that buffer, so use lock_user_string() instead.

Do you have a link to the specification for these hexagon semihosting
calls? Looking at this patch I'm wondering if maybe I steered you
a bit wrong with suggesting lock_user_string():

> @@ -461,31 +462,14 @@ static void sim_handle_trap0(CPUHexagonState *env)
>
>      case HEX_SYS_OPEN:
>      {
> -        char filename[BUFSIZ];
> +        char *filename;
>          target_ulong physical_filename_addr;
>          unsigned int filemode;
> -        int length;
>          int real_openmode;
>          int ret, err = 0;
> -        int i = 0;
>
>          hexagon_read_memory(env, swi_info, 4, &physical_filename_addr, retaddr);
>          hexagon_read_memory(env, swi_info + 4, 4, &filemode, retaddr);
> -        hexagon_read_memory(env, swi_info + 8, 4, &length, retaddr);

We no longer do anything with the length argument, which seems
like it might not be right.

If we know the (max) length of the string, then perhaps
lock_user() (which takes a length argument) would fit better.

thanks
-- PMM

