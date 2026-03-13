Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16197105F799
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 11:22:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w10aS-000201-Ib; Fri, 13 Mar 2026 07:21:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w10aM-0001zS-Ax
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:21:42 -0400
Received: from mail-yx1-xb12e.google.com ([2607:f8b0:4864:20::b12e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w10aK-00010A-LJ
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 07:21:41 -0400
Received: by mail-yx1-xb12e.google.com with SMTP id
 956f58d0204a3-64c9cabfe5dso2739919d50.0
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 04:21:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1773400899; cv=none;
 d=google.com; s=arc-20240605;
 b=SUhP8gA+Pg9xGqUM1r8Sf517Gq7cbeHPmc4VKgsdeH3gMGNbTEzr8H76n8vrx2jiSs
 d0PA+JYIY/G4yEtaFBSafAZG3Ei93pX8S2OC5S/isvAXLFL38tOmYu30s8jyLNEpEyrg
 jiCMB9UTYgWXTebI7dStucMiw40Tkkkjv/Be2liXBZ0P05K1mAR8V1Bi3rHnRwThN/qt
 1UUUxWVOPubqO3sydiJ3rU3SfzUv4Qn/9OLpVzpV0ar3QVdrcverABJe2Yp4Vv2aHkbM
 xRtoBMZPmPg0q2QOTRbMXBUDq2rDa6Q126wEujTpl9Vu0YNDFPXB9ANtqwBDVLJdQkx4
 8KYw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=i7MHIa8+zCWa/p9y55Rg5QzXjj1VBh6YPCxDmtb04N8=;
 fh=TI5KUJ7nZ5i/oZzH/JVeDu8repzAGZFnBS9WrD4PI+g=;
 b=D/qNke5ZQvBJWRhKvz9h4sTC1C5bfFgbsc5jliGY+OljqHPnAxBKnoYh3HtR7YaIuv
 ncXOf38AzsY4ltCclwWnXMyVdh84V8441TY/nqeCZ8EbudNEaL+wBjAPcwjmSz/Z3nxD
 PU51giH0GQWAUumhQaqabTkBcYV2jB08yx0UWvBoywL4Jkq+GM6co1TzK6zAt0Bi66+U
 azCGlTCo+SJSdyyCwQTr6zJV4pkk7IqvovBdE/oMqYT9VrXE/OlXcxmb1fUT4fNIPqPV
 4yqjQHbC9cI7N7mvgjGYE66zeEo6hfz8cDllLEIritA5pAnCpWSBSA4oclgQwfA2I7jv
 sCJA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773400899; x=1774005699; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=i7MHIa8+zCWa/p9y55Rg5QzXjj1VBh6YPCxDmtb04N8=;
 b=f2eYEdVsYtyHQfiPwqW7vVvLWxX6HSQlqyol8Qa8yA0uisZ4eHGtlEZF7tQQbwt+oL
 n9BxUmSuJO73WLS4tzNzmNRGQ+2KgNKByjZAzgIaK+rHky20Qd/s7+3NehKwxhSLCeKv
 o2dkdzQPTiSwso83KV03asiZxyWMMnOOQcOVSVxbcCeoU3z+Cuuo11hBBdqwz0VmUd+U
 t4bCmSR9dOxyC469I9psGgdPk36TvBfg6Bwp9i1WB8tZSVsMYcaDMaCPBVWO34TQcfw9
 aLuA1lCReywBg/WlzV0nb79jFDd08DEcwzqmGXMXbPer+6uHFQywhbPbRbVyPLEMBr2/
 ieHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773400899; x=1774005699;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i7MHIa8+zCWa/p9y55Rg5QzXjj1VBh6YPCxDmtb04N8=;
 b=Z2hHOLHUmz63RqPYBeIVEeBaOIaCOSrm7jpF4wfPlusklX2k61zPLG/Iz4pf6udR0I
 hNO4KJJ7A/IxToHU117rKfpJZXq9k4N9OkzbXnLt8IKYVaXOAYm5F8F3+SB4UoBLvIVg
 qXusGa69Nd3FYknRniwiQHlojwZ0IPJ8xuqEYqFQrgkyt833QHM+dc50AJc4gxsPooth
 fwrWzW2jzjMnP+RcHCsXnX2ljm5isoG4uGk/LgvcmhSCFRPEFBQ8J1IS3OQ8aUXoXp7w
 VLzYGYEROMjz/7XVpzo4pK1xmmU81og+GAr4Sm/ye3r2YH0CQs9pOgeW6rVxHiiSmuSQ
 BbQg==
X-Gm-Message-State: AOJu0YwjyL1LpZ/jYHX0zuG68QjDVmW9R/ZwxCYikjNvMphXSwNrr5Ar
 xH/OWeiMLPXZqx+Wyb1NEPtnsVCeykTlxdGji/+F6RfqZIcp4imY40jKwsNkvOXW+wwSYkeW7fn
 wTffIzs25Mw3B8ExPX0L71I++JHk0eD15lMz2qdniAQ==
X-Gm-Gg: ATEYQzz9TH9Qen6dCF+1LKzWlVPvy9Bp/p377Yz0EcWEYMZdkdQz0Ic9+sbmMNJONsZ
 jsbZwefLClwdzkxZlD6PjgjKQ0dXUjn8g91zrcwQhlkPmUPUlt1UwmV4WPvWJP5x4LcSBZjsxKQ
 zpNmNmLR94sPfwHgFS9UnQS1PtSqmHv15CByx8UOslTM+YW0Eb8/KtY9pgydoOlYDvURGSf8Ewe
 ZPJbx0ZZDe3/URFiKOhp/vP1ycZvu+ZGPzw/z6RgZRDghoAXyneuKow9KSAdmiGq5N6YSvfjq7A
 GMkqtrhJFJh4WZV5CpbHdoT5c7oapaJqkAlAu76D5rWnd/ngq9z5rZEt9Sc2wGINJGo=
X-Received: by 2002:a53:8581:0:b0:64a:d5b1:f899 with SMTP id
 956f58d0204a3-64e6287021bmr2196407d50.36.1773400899094; Fri, 13 Mar 2026
 04:21:39 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1773236195.git.1774596582@qq.com>
 <tencent_7A1227883216A4103DA25F5A585E86DFE307@qq.com>
In-Reply-To: <tencent_7A1227883216A4103DA25F5A585E86DFE307@qq.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 13 Mar 2026 11:21:27 +0000
X-Gm-Features: AaiRm502Be4IkcFLcBJtFsipIg0rjAboayLuc5jK9wxT6XPXjlrdlfp-jvMZisQ
Message-ID: <CAFEAcA-N_2FiPze83xt_4Y4+SfEfhpxB_MFsW365Ot4euvXnmQ@mail.gmail.com>
Subject: Re: [PATCH v1 1/3] An interrupt is generated after the DMA transfer
 complete.
To: 1774596582@qq.com
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12e.google.com
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

On Wed, 11 Mar 2026 at 14:25, <1774596582@qq.com> wrote:
>
> From: TaoDing <1774596582@qq.com>
>
> PL080 cannot trigger interrupt correctly. Reproduce this problem in a simple way.
>
> In the versatilpb board, the interrupt output of pl080 is connected to the 17th interrupt input of pl190.
> By reading the status register of pl190, determined whether there is an interrupt generated for the corresponding input.
>
> The basic address of pl080 is 0x10130000, and the basic address of pl190 is 0x10140000.
> Read the value of the address through the qemu monitor.
>
> Configuration
>     ../configure --target-list=arm-softmmu --enable-debug
> Reproducer
>     ./qemu-system-arm -M versatilepb -m 128M -nographic -S \
>     -device loader,addr=0x00000000,data=0x11223344,data-len=4 \
>     -device loader,addr=0x00001000,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130030,data=0x00000001,data-len=4 \
>     -device loader,addr=0x10130100,data=0x00000000,data-len=4 \
>     -device loader,addr=0x10130104,data=0x00001000,data-len=4 \
>     -device loader,addr=0x10130108,data=0x00000000,data-len=4 \
>     -device loader,addr=0x1013010C,data=0x9e4bf001,data-len=4 \
>     -device loader,addr=0x10130110,data=0x0000c001,data-len=4
>
> Qemu monitor
>     (qemu) xp /1wx 0x10140008
>     10140008: 0x00000000
>
> The result correctly after fixed
>     (qemu) xp /1wx 0x10140008
>     10140008: 0x00020000
>
>
> ---
>  hw/dma/pl080.c | 1 +
>  1 file changed, 1 insertion(+)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

