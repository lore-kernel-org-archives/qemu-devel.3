Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22B7EC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 15:37:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDIC-0002A0-P9; Fri, 10 Jul 2026 11:37:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDIB-00029N-G5
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:37:31 -0400
Received: from mail-yx1-xb12a.google.com ([2607:f8b0:4864:20::b12a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDIA-0005sq-2v
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 11:37:31 -0400
Received: by mail-yx1-xb12a.google.com with SMTP id
 956f58d0204a3-6675db463b9so974157d50.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 08:37:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783697849; cv=none;
 d=google.com; s=arc-20260327;
 b=iBWEMIdBFqiePirLxHchhh8IT/HcLtfqNavYiDoWUjDjwVPoARk94X8I+SbvCE/hBZ
 4GdqvLhHrzE/HS9HGPukKmEWx8hQdrfPLiZATromNsqGb3vvzJ9cobZ0zTfqGJj069Th
 KFgE89CTiN8wRFB5/ymHDMGNmL4MdmsDeReDT3Ev8pZcYwsSNv635DAjIUQoGwVE4xdG
 Pk2A5D7IeB2i1PCORq2jgWc/lQq240ZRmgVLfNVEYLuTlvQDb4E00fBxI5EJ8uuHauDT
 c8LYvcHssHR9sOWHe0Dur/NwcmdWu526O2M6XZKUr+lHXkQLB23vSSIkiXrh89BaFeTK
 GSQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Ag4xZwJH7gb8h0r+0qSJVFucgFXmp4y/0lv0QiWfd2E=;
 fh=SRsBcQge+NwcX+9yi1dK5ZdC1U2Y2fTBPVZfMkPwrjg=;
 b=fdRYjyL8BPV9dg24JzqW+SnUIVaPAsIQL5Q23rtF3T7oU9klqsS0s7g3rKyoCJOYyy
 ikU8J9ZT8t42wA+3sTSgyzrf9WtzHpl5KHB9+LUCUp6Re8LI+O3BiKgxlijyqYdOrFNy
 jTilHsVv9Q/k1BEH5tsFFf+VVshqBrL+A2Bjw0XXfR9uplnbEAJ5f3bHZaVght6WSRwS
 Js/tk+UzA1z1T2cmSbk7ngSM/LUu5wy160Pjfp960i3W4ZK1b/OGTCwCJBF5Tvy3XRO/
 XrS5XL/aYwPSOVGbcAyyQFgtds1wEV72J3aHwM5L33LGXHVm2nmR2Ng6KJTTYnoot0Qd
 pfAQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783697849; x=1784302649; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Ag4xZwJH7gb8h0r+0qSJVFucgFXmp4y/0lv0QiWfd2E=;
 b=N+f9ljeW+HETTvmarfJyOpoaqnMd2FmpcWpdJ53Zo+AruF8m/6qt8WeRGNyid+Wl1w
 GbhbQcto+wNVjpyGc9y3DAriAYfT77oD15QoGimc8mRzzPjJBocs1rPvRVRlzJraj58k
 bivyIL9JIO2ZVyUROcVLYIq+1fcnzEB8roT6u6QBTGEarH0mc+ZffLF0vqKvO9kvjdnF
 3f2bROb8fcAlxyuJ3Rqoje4VdIru3GlFukVRQgSJJOY5FzHjPsUybCyip4tRbfNvPSUJ
 HnlocbsMzSsGDMXgu+e+BZEOGQ+Cwxw5Sra4YBINAELBwZzml8HphYieKfTwJ4rwPIZ6
 n4tQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783697849; x=1784302649;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Ag4xZwJH7gb8h0r+0qSJVFucgFXmp4y/0lv0QiWfd2E=;
 b=Cs2IgNRXW4Kz1KP0AZ/1sBxWMzI1vjvVqYPVYQYMVqh3IAT+4l68W3bG4cW2I1bl/K
 ACEdBoMsgdaBMos+a1wy3f5he2kCqkrL7UuS2A7JTdZm1lqIDwuFbF4SwW29TZ7kZlum
 jZ0i0PPJGEKKYr1NF/taZsvR0CuVETOgsbHCUntA9MfEDl5IrE2SJsGa1BTSYG4hS9I1
 0dJpg3WF8yyUXy6pkf5fLIUy7VHSFNW4+d6zOyxVqD2M6ihBs9JJ6p2dCQUc2ZVr9+RG
 4efEp8BpFDrq2nKOwYnF4FwoW/j9l3FJ4Sa6BmZKtESNpsfoIQwe6dl0fJ4Wu+AEnC2I
 gUTg==
X-Gm-Message-State: AOJu0Yw82tbm4RNzGOaclcyR/1r5CkV4wilsm0LBa+IDbzMdQZVrvWdU
 SGEgjbbjcY517v8Gt8Wk+lUSesbcG4whPhpy/i+eRsu/NQ3Jq0GxFGIx8jHdfWqjSMrOb5SsBNH
 nEvuQE4tuaCHVeCJSncab/gg3/tZR2Br3fBI2uaKOgg==
X-Gm-Gg: AfdE7ckEXRA8DFUVJxGO+23jzA3oLq9y5bg9UgbKgqsthFQutz7e9CvaUq8AlB/pBbg
 B0CgeJ8mFm6i8hG003LAwA7BSZhBmuOlMa59GnlJf7f0WnGHUYPRCi6FQRcgYLXgQ8V/WQqusJP
 6Xni9pFw8Xt+KpAp8rrYRWFYu+5dOJkjrA7rPIIaLAUtXnw7ywYczmWPQj9mAkk4TMIZAcj/j/M
 BJ/rA94Nag3FJkHnPEUqmEPR8jFM60NlN2a76BEE7rGE1FRUy4+MCUwiQzMpjj3qcn+A3fRy9KI
 GtdvAX/FdSjdajofxBTCQypjRgea4yCwN2yigOjYtAjkq8A9m1NCYJz9zDoYuj0C5og=
X-Received: by 2002:a53:acc9:0:20b0:664:ae6a:ef3 with SMTP id
 956f58d0204a3-6679f1c3a41mr6846637d50.81.1783697848598; Fri, 10 Jul 2026
 08:37:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
In-Reply-To: <20260623-guest-panic-unhandle-v1-1-6adfb6d4221e@ooseel.net>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 16:37:15 +0100
X-Gm-Features: AVVi8CfOawhLWs7Bm1-Vsh0ZNUpgz_FdkFUJ8b3Xi-rODP0bkwZT9YqljhRRhiY
Message-ID: <CAFEAcA9LCRKmU+r77zGp+4Rgd-uaZLPnoPPQDSfG8X5eeiynJA@mail.gmail.com>
Subject: Re: [PATCH] target/arm/hvf: panic the guest if an unhandled exception
 occurs
To: Leesoo Ahn <lsahn@ooseel.net>
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 qemu-arm@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, 23 Jun 2026 at 13:56, Leesoo Ahn <lsahn@ooseel.net> wrote:
>
> It's worth cleaning up all resources that the guest taking and to quit
> if an exception in el1 could not be resolved.
>
> Otherwise, the guest will get in the infinite black-hole by
> unmodified pc.
>
> Signed-off-by: Leesoo Ahn <lsahn@ooseel.net>
> ---
>  target/arm/hvf/hvf.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/target/arm/hvf/hvf.c b/target/arm/hvf/hvf.c
> index 8b902c6882..4358cf90e8 100644
> --- a/target/arm/hvf/hvf.c
> +++ b/target/arm/hvf/hvf.c
> @@ -2533,6 +2533,7 @@ static int hvf_handle_exception(CPUState *cpu, hv_vcpu_exit_exception_t *excp)
>          cpu_synchronize_state(cpu);
>          trace_hvf_exit(syndrome, ec, env->pc);
>          error_report("0x%llx: unhandled exception ec=0x%x", env->pc, ec);
> +        qemu_system_guest_panicked(cpu_get_crash_info(cpu));
>      }

We should do something here, but my question is whether
qemu_system_guest_panicked() is the right thing. We mostly
use that for "the guest OS wants to tell QEMU that it has
panicked, so QEMU can reflect that to the user and perhaps
reboot or exit", though we do in a few places use it for
things that are more like "we don't handle this case". I'm
not sure exactly what the right thing to do here is, though.

-- PMM

