Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C2160D43341
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Nov 2024 11:21:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t90ZP-0000xN-5K; Thu, 07 Nov 2024 06:20:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t90ZN-0000x4-Tz
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:20:57 -0500
Received: from mail-ed1-x52a.google.com ([2a00:1450:4864:20::52a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t90ZG-0004gM-0o
 for qemu-devel@nongnu.org; Thu, 07 Nov 2024 06:20:57 -0500
Received: by mail-ed1-x52a.google.com with SMTP id
 4fb4d7f45d1cf-5c9c28c1e63so970326a12.0
 for <qemu-devel@nongnu.org>; Thu, 07 Nov 2024 03:20:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730978447; x=1731583247; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=T8cxeuFF/AL0mAa6xYsoq7y+uetrAc/tdhCwjx2rYFM=;
 b=BLGVGJZJTqQoGXIZjTzslCSFULV57xvjlmKs4YN7mo2V7HUyHJKXgPrBc+8Rv5qA6W
 /RWlAO+9Cmuj61Uwe496CyTZ2v6aQ6eVMXNGxQhQ+EM1CTBygxnQK3uEnnzqC8dFhUgq
 2djkHooP4FUzMAeqfNSLK/vs4uXLcZXBD9sOLZO75XmV3bkmmlLTUDLTLUbRJLt3QNZX
 p4ANqO3Xc5p/E3T017RZksBNrsL5cUj6q/pN4ZX+yQo8BzDx+S2K7+NlhJoWskYmLz40
 ZlxO/Q4e4rf8o2H+GLKXbsaJYNGnPmLmATh2KGCNRPmwvJYSLUal0/OgDdZLXtGVq5x8
 aW8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730978447; x=1731583247;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=T8cxeuFF/AL0mAa6xYsoq7y+uetrAc/tdhCwjx2rYFM=;
 b=U+ZNaKwf1Zlx1vCay6z5NPX3qSddnjns73lSPX/b5n7KcQtTRrVsJvUs915lOl0WMP
 V1afbUp4Jt8/eVUyNMHBjVWxwcz2EZhB268iEE+CEo4jFV9UWBvvgd4jFd5S1Hle4HO1
 bmjnYtaWPxxLVLkljcir+rFYQjBgaX3bww9+P9HqsEmjHRsfoUwJFRWsxj5d9V+SSWhr
 OVqTHynxgW65qNWKb2T+ygrBWkUi3O34bk6F+iioafu6DalXaPQPu+QgUwnAvwaXZ65/
 MNmBoZAQXR5x2NxehZgRFP15x4510ojg3GhdeF9bLHItJ07rkF2yd0amj5szMn6oi65L
 TVEQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVYqQz2JeRx2yegfU9+vcGw4+PM9hZJHE+WxF9stUm1QaF/H91RE4bGspG6d08vfjOKxv9159Rz0Xe7@nongnu.org
X-Gm-Message-State: AOJu0Ywz+xghODk8WBEMhRpPBOKTl+gA7zqiWB6Iuih1cYi2bEUQoEkq
 zEYRIlRP4qwi0YbXUi3zOpH9FKu9GSbNSrf1jhTkvAVDki6ZdKT7SfzuYIhIv8o2BAp73OoxdVw
 UdVSkEwxDKShHECehrpnb3sY4vTeS5zUrVPNF5A==
X-Google-Smtp-Source: AGHT+IH51c5v2Lqf+yfHLPHUrD+cJgquHVLmTQcKEzMHtOZG/PxcGNKHzf7oklLBzSZb5YSCTyFhV1TSwq4diO3d548=
X-Received: by 2002:a05:6402:26d1:b0:5ca:1598:195b with SMTP id
 4fb4d7f45d1cf-5cf05a1f8f7mr953990a12.28.1730978446825; Thu, 07 Nov 2024
 03:20:46 -0800 (PST)
MIME-Version: 1.0
References: <ZylIIkk7k69QIBmn@p100>
In-Reply-To: <ZylIIkk7k69QIBmn@p100>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 7 Nov 2024 11:20:35 +0000
Message-ID: <CAFEAcA8qdUPBcHz+h+CBGFO1LP07BuKV6XiJuvJUQZuPfg0=YQ@mail.gmail.com>
Subject: Re: [PATCH v2] target/hppa: Add CPU reset method
To: Helge Deller <deller@kernel.org>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52a;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52a.google.com
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On Mon, 4 Nov 2024 at 22:18, Helge Deller <deller@kernel.org> wrote:
>
> Add the CPU reset method, which resets all CPU registers and the TLB to
> zero. Then the CPU will switch to 32-bit mode (PSW_W bit is not set) and
> start execution at address 0xf0000004.
> Although we currently want to zero out all values in the CPUHPPAState
> struct, add the end_reset_fields marker in case the state structs gets
> extended with other variables later on which should not be reset.
>
> Signed-off-by: Helge Deller <deller@gmx.de>
>
> V2: (based on feedback by Peter Maydell)
> - Add end_reset_fields marker
> - call reset function in hppa_cpu_initfn()
>
> diff --git a/target/hppa/cpu.c b/target/hppa/cpu.c
> index c38439c180..d12bf65021 100644
> --- a/target/hppa/cpu.c
> +++ b/target/hppa/cpu.c
> @@ -194,13 +194,8 @@ static void hppa_cpu_realizefn(DeviceState *dev, Error **errp)
>
>  static void hppa_cpu_initfn(Object *obj)
>  {
> -    CPUState *cs = CPU(obj);
> -    HPPACPU *cpu = HPPA_CPU(obj);
> -    CPUHPPAState *env = &cpu->env;
> -
> -    cs->exception_index = -1;
> -    cpu_hppa_loaded_fr0(env);
> -    cpu_hppa_put_psw(env, PSW_W);
> +    /* inital values loaded via reset in hppa_cpu_reset_hold() */
> +    resettable_reset(obj, RESET_TYPE_COLD);

You can't call reset from the CPU initfn (among other
things, the CPU object isn't fully constructed until
its realize method has been called).

CPU reset is rather awkward at the moment because it
doesn't happen automatically (because CPUs are not
subtypes of Device). So generally the way it works at
the moment is that the machine model code arranges to
reset the CPU object "manually". For Arm we do this
as part of setting up the CPU for however we're booting
the kernel in hw/arm/boot.c. It looks to me like for
HPPA the best place would be to call cpu_reset() in
hppa_machine_reset(), in the loop just before doing
the other CPU setup like calling cpu_set_pc().

>  }


Otherwise this looks good.

thanks
-- PMM

