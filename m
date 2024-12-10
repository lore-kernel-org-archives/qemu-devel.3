Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85987E77180
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Dec 2024 19:06:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tL5YS-0000nW-9R; Tue, 10 Dec 2024 14:05:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5YJ-0000b3-RF
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:05:48 -0500
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <jean-philippe@linaro.org>)
 id 1tL5YH-0000D7-UI
 for qemu-devel@nongnu.org; Tue, 10 Dec 2024 14:05:47 -0500
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-434fa6bf744so15745775e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Dec 2024 11:05:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733857544; x=1734462344; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=FUhO7L73rAFYqnN487zaubYbkA7yCmNMZJD4kkzOVBk=;
 b=dWhRG4X2Vm9ky4vn898uKlRC03fEscwr3ZT8/upsrVt4VTqLByV3/4ypN4yumI2nsh
 j8Cr1X8W+0EUKgtsNkZ3KjsyY8nh5Q6mR7j5p+k7BMbau/E0oSCsqRAbUAr5kKcw6pi1
 YisbvecgyP0P1sUXQEAxUqLVZZlTd4eASrtLElby9JPPFawVYidRJSj6S2UbMDUHDZah
 dRaI0OIYPcCl9RM952vDiHTmTJHQ6dulE1dY6DaIdnR1CDKx/fQMOR6ttVDuWtx+W+wX
 3aYWlPzE24HUeCg7VTfYoFWJKY+gBLJ3Em+HMJDn9FDSqi1ByZ2z02xDpAI2JECLJxVM
 HwxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733857544; x=1734462344;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=FUhO7L73rAFYqnN487zaubYbkA7yCmNMZJD4kkzOVBk=;
 b=PTs+BCXYA3AOX6vDwbwE9506miqpMfnTZNcShdCjFufq7brmO3APc2cuI02UdAFi1p
 aByrN0o83N1tgMuErmhU/1G7xQ/wvxaJYTi6VL13gsJfWwEjuvM9zSMsVbw/nyR7+rBx
 iMafXPtPgEf7SXX6KWceMTnVQPLDoKCyLAGWHMGm4Jndk0ELm6IuYZhLiCE7gDwvdokU
 dmUGpxulBLHi5A8jJgJPLsCWBr0WyLXGqPmMUOB+os3L10W95WexLe8KuB6Fx6NQl+Vq
 NrlPyT+XjqUK/tEkcH1Sr3jDKTfbFYUkD7obOfEgAsboXvtYYHST54q8oJiMiPtIQRNt
 iZtA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWyx7EnI0r3xBWLnkSZ/mpq+D7ID13n2Qg6axtvzpgNlahdV7RRhNovcyGSwB813vtj43AOoDcfVght@nongnu.org
X-Gm-Message-State: AOJu0YzjzjXT1XIcDrEzcwg48EWXMBDczhyehohWsfqF7ecU0/BFE5sv
 t0IhhMU8bwHJP39on4EYkqJFFbYK4ThOEzdie4H6syHSRlmrFaglgLElSrIHLhE=
X-Gm-Gg: ASbGncv6cHPVefkr2+H0iuowjmUuDETcnQA359DD8OUD49sjLlE58afMU6ER58F3kan
 rAeW7mp2fg4Vw94jUns0fvBJwpSfIUtejHjTo6/ZTTv0EbAGYEZSP44mkOxHgBosgx9IQhNrVqP
 gHiX+60ZSEWHSTNcI68Kd9AzZxhLxeBDc7sJpZBSpwnlGyF+8gQW2TyDl260rT/0hNfdzAHoI2V
 NW/h4NT75oVoA4OhAibO3B8aTp2+9QiKL8SXTjxxva5aqB0KOhU
X-Google-Smtp-Source: AGHT+IGHP9NKXqyshDEEuDJaV+qjtNexC4Gg2BTqEvF5wXGD4PIunDPgrF0AHbA/f7v2BGg4H8Fakw==
X-Received: by 2002:a05:600c:1d01:b0:434:a852:ba6d with SMTP id
 5b1f17b1804b1-434fff69fb9mr51023125e9.9.1733857544405; 
 Tue, 10 Dec 2024 11:05:44 -0800 (PST)
Received: from myrica ([2.221.137.100]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-434da1133cesm204251025e9.34.2024.12.10.11.05.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Dec 2024 11:05:43 -0800 (PST)
Date: Tue, 10 Dec 2024 19:06:08 +0000
From: Jean-Philippe Brucker <jean-philippe@linaro.org>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: peter.maydell@linaro.org, richard.henderson@linaro.org,
 qemu-arm@nongnu.org, qemu-devel@nongnu.org, alex.bennee@linaro.org
Subject: Re: [PATCH v3 03/26] target/arm/kvm: Return immediately on error in
 kvm_arch_init()
Message-ID: <20241210190608.GC1212502@myrica>
References: <20241125195626.856992-2-jean-philippe@linaro.org>
 <20241125195626.856992-5-jean-philippe@linaro.org>
 <d130d7d2-acff-4dfe-97f7-346174fa079f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <d130d7d2-acff-4dfe-97f7-346174fa079f@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=jean-philippe@linaro.org; helo=mail-wm1-x32a.google.com
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

On Thu, Dec 05, 2024 at 10:47:13PM +0100, Philippe Mathieu-Daudé wrote:
> Hi Jean-Philippe,
> 
> On 25/11/24 20:56, Jean-Philippe Brucker wrote:
> > Returning an error to kvm_init() is fatal anyway, no need to continue
> > the initialization.
> > 
> > Signed-off-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> > ---
> >   target/arm/kvm.c | 9 +++++----
> >   1 file changed, 5 insertions(+), 4 deletions(-)
> > 
> > diff --git a/target/arm/kvm.c b/target/arm/kvm.c
> > index 8bdf4abeb6..95bcecf804 100644
> > --- a/target/arm/kvm.c
> > +++ b/target/arm/kvm.c
> > @@ -563,7 +563,7 @@ int kvm_arch_get_default_type(MachineState *ms)
> >   int kvm_arch_init(MachineState *ms, KVMState *s)
> >   {
> > -    int ret = 0;
> > +    int ret;
> 
> With your change we can reduce this variable scope ...
> 
> >       /* For ARM interrupt delivery is always asynchronous,
> >        * whether we are using an in-kernel VGIC or not.
> >        */
> > @@ -585,7 +585,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >           !kvm_check_extension(s, KVM_CAP_ARM_IRQ_LINE_LAYOUT_2)) {
> >           error_report("Using more than 256 vcpus requires a host kernel "
> >                        "with KVM_CAP_ARM_IRQ_LINE_LAYOUT_2");
> > -        ret = -EINVAL;
> > +        return -EINVAL;
> >       }
> >       if (kvm_check_extension(s, KVM_CAP_ARM_NISV_TO_USER)) {
> > @@ -607,13 +607,14 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >               warn_report("Eager Page Split support not available");
> >           } else if (!(s->kvm_eager_split_size & sizes)) {
> >               error_report("Eager Page Split requested chunk size not valid");
> > -            ret = -EINVAL;
> > +            return -EINVAL;
> >           } else {
> >               ret = kvm_vm_enable_cap(s, KVM_CAP_ARM_EAGER_SPLIT_CHUNK_SIZE, 0,
> >                                       s->kvm_eager_split_size);
> 
> ... by declaring it here.

Ah right, but next patch immediately reuses ret:

@@ -627,7 +627,12 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
     hw_breakpoints = g_array_sized_new(true, true,
                                        sizeof(HWBreakpoint), max_hw_bps);

-    return 0;
+    ret = kvm_arm_rme_init(ms);
+    if (ret) {
+        error_report("Failed to enable RME: %s", strerror(-ret));
+    }
+
+    return ret;
 }


> 
> Otherwise:
> 
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Thank you!

> 
> >               if (ret < 0) {
> >                   error_report("Enabling of Eager Page Split failed: %s",
> >                                strerror(-ret));
> > +                return ret;
> >               }
> >           }
> >       }
> > @@ -626,7 +627,7 @@ int kvm_arch_init(MachineState *ms, KVMState *s)
> >       hw_breakpoints = g_array_sized_new(true, true,
> >                                          sizeof(HWBreakpoint), max_hw_bps);
> > -    return ret;
> > +    return 0;
> >   }
> >   unsigned long kvm_arch_vcpu_id(CPUState *cpu)
> 

