Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF446C43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 16:03:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiDh0-0008Kz-Sb; Fri, 10 Jul 2026 12:03:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDgz-0008JP-71
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:03:09 -0400
Received: from mail-yx1-xb12b.google.com ([2607:f8b0:4864:20::b12b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wiDgx-0004Wi-5A
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 12:03:08 -0400
Received: by mail-yx1-xb12b.google.com with SMTP id
 956f58d0204a3-664e3ed58bcso3304382d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 09:03:06 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1783699385; cv=none;
 d=google.com; s=arc-20260327;
 b=dIm8NsAEK4++JPxPA2xDUyFnYS1wJmeAXpbaNlifeS1pxHkDiXKfvfW119cs6vIWm5
 QIQfnr1IXz73cFl2PLyPSOjRS255YNMsC5MyknYWeawI8aAVGe9mCK+E8xrYY7v+2R9/
 ndqUTCsEj216WaVmGbry/d21QXG6uYhu/FMf041ujlbOigCpY+tNXIYpmAO54KFTLkDf
 OGS/+HyjPgyUZ93gZ6++Bip9mA8tlcbCZlG8KhgxvMdp4h4IORJOMENGH0gdj0QjY1mS
 FERwMjv89GCWbsoKanu/14B3SLcI2lHNI/lbAiwXEuAmPaiP94OMLd0a8oCecJIixYnI
 Xt3g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
 bh=C4Gs7/5bjNBtEqp/BTEAIxi2Dwb+uoso76U0rWkUORg=;
 fh=yxaAGfWycof4JxXdWp2QLuOyxznVY86vFN8SI3CECUA=;
 b=Crt/KMVI9aFlDJKTTqNx+vBlWMZnVDKGYPh4Q1hBZktOY+8FauDQ2CnUQmDctE0os/
 ptZ7aORpBh9wOYkeEcmpjj7qMaBtY1NQUDNrsww9zz77VWGeai65yOQBZdTmFP2yvgU1
 IQVJYln+OuWXZPmPIzd+0LZ361QofB+zw1Job6MngODjtDy/kIk4C76f5ALzUVOD2Bj9
 C4L1V4K1KWplD25Zk9D08s1PsmpSt9Z0oPGjdj6GksiqODbEjmq0ceO+WtBGDZknQMgf
 J2JOQO86JEqIjXPPgjWwjYzpyg9ZbCEBsqgP5fsGcWV/O+T+BF5Dt/ux6CKAllgizNiH
 eNCQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1783699385; x=1784304185; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:mime-version:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=C4Gs7/5bjNBtEqp/BTEAIxi2Dwb+uoso76U0rWkUORg=;
 b=Sqm5PENmWyLEQWrM7i7Diz+WfkYausaJ6QqNgij6bA9ID1hG59E6chU2QjICMAZ5Gp
 GXnbFjp4KCC8YalrKadRw30xis2bj6qAw9p3OivsGPWpKqfGPni4J0DN/GMJcaJ6/bQo
 NRq6KlPkXpyZlXJqC8O3SP4cScpo1q3/nkPOhcWeriA0vvCMDB5sxlDX1K5PR0IRMFB8
 qVcEKU4bWMeE7uhPrLn5pq+0XJJkWhkzHea1Z4SHxZ1HUMcM8uIyip4RcJkK3L/GQyHk
 Gzm/Vy6PkA1RwJ+SFRzPYiOlb4RmrTq2xyhQEFyj/hRW6XtaWjBMhx3a627A3vLRqEnC
 AFgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783699385; x=1784304185;
 h=content-type:cc:to:subject:message-id:date:from:mime-version
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=C4Gs7/5bjNBtEqp/BTEAIxi2Dwb+uoso76U0rWkUORg=;
 b=ZYXdrcZHbL+7JsiD+odCPTnXv62Bzgn5VIIBvlf8/f9MjfcjsPVnPxnDXx3acwULm1
 NazA6MP5YPkOYKPPZE1ocoPFUytQofUe5IquNjYBzdSnTtxXJON5YzVZwhWJDg2x3Z3N
 iv+c1ooEYCiSjPmnmX6juAZlGdPl6vyMC5KZJsl9F1Qtxf6+HvWtg3oOAfpbtS4Fv/N6
 X/Y+NoYE39mK7hR01/Zp45FnbzblboMvOrhmAVEYtZdspKtr3FhOwYzmu90BFgUbXAWI
 djlZWqn46m4gui4hnHgin3RnRZJv8dQj7HnXj5zr/PcRxj9b/ZM3NlmWbY5pQMxpqhRK
 zhsA==
X-Gm-Message-State: AOJu0YyGFKbOZ0aPL4LvMiKHXvHxM19JfpGh4DVTp1Q4xZlHVzfTZJJB
 6MUmq+SF+/8IfXRFyaOcQWSL9BtflE/bUzEpYxcnTRmP6Ey3K4/1XYZQENlffBrPb6nsjzfCCNZ
 vUoUDLy4Yit5Vujuu+2O0ekLKvMLF09saIT1P2bVCSmwB6GmkHDhtZTI=
X-Gm-Gg: AfdE7cn9RhGKdykX3/qqszDT2xMDq5Mpkai+OswIfFO93TMJ0rIhMlYFIodCzlpjDtb
 /EcY8BINp6Ay0IMpqS4gaxSVn+q2QaOkAKOE/XqgTto6+YbBQFHL7ZMibA9Ho2iswHCZ/yv5co/
 NkNGUWXkK4+0rEhdnKS/j0R9mMe86+O/xv9Lek4BgixxH6rKinvcwWZSaceRiFcJF8jX2uhyEcx
 fSq40oFx1jEj9FzDJ9XGSzRJOevPbWMKgAbi9lhuECXg99xr1MODs5zsUwhIkybbuktn5vcJLlJ
 Ptv9Np0s6dHEoy0cibDOHXvlx26vg2j8NOH9YjdaJinMl8uSGIic+Vlm
X-Received: by 2002:a05:690e:4892:20b0:667:a025:89a7 with SMTP id
 956f58d0204a3-667c601147emr2122955d50.11.1783699384866; Fri, 10 Jul 2026
 09:03:04 -0700 (PDT)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Jul 2026 17:02:53 +0100
X-Gm-Features: AUfX_mwcbvQur4SKJ8lmkt20QYEVLdjk3dB2_z3J0r-PQREy6Sl2T2a4_HjsN-o
Message-ID: <CAFEAcA_zmc=Vvs38Qos_gecCmGAbRgDQF-0+x85Ja66nsqrHxA@mail.gmail.com>
Subject: what is qemu_system_guest_panicked() for?
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Pedro Barbuda <pbarbuda@microsoft.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Nicholas Piggin <npiggin@gmail.com>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, Cornelia Huck <cohuck@redhat.com>, 
 Eric Farman <farman@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>, 
 "Daniel P. Berrange" <berrange@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12b;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12b.google.com
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

(cc list is a random mix of maintainers of code that calls this
function, Paolo as "main loop maintainer" and a few others who
I thought might have an opinion.)

We have a qemu_system_guest_panicked() function which causes QEMU
to report this to the user and do one of a couple of possible options
(shutdown, pause the VM, do nothing). This seems mostly intended for
"the guest OS told us by some mechanism that it just panicked". But
we use it more widely than that...

Cases which are "the guest told us about a panic":
 - accel/kvm/kvm-all.c handling of the KVM_EXIT_SYSTEM_EVENT SEV_TERM
   and CRASH subtypes
 - the pvpanic device
 - the spapr ibm,os-term RTAS call
 - x86 kvm: tdx_panicked_on_fatal_error()
 - x86 xen: the SHUTDOWN_crash shutdown subtype

Cases which are not:
 - hw/spapr/rtas.c: if the FDT has no RTAS address during system reset
 - hw/spapr/spapr_events.c: if we wanted to deliver a machine check
   exception to the guest but the FDT has no RTAS address
 - hw/spapr/spapr_events.c: if we want to deliver a machine check
   but the guest is still dealing with a previous machine check
 - arm whpx, if we get an unknown/unexpected exit code trying to run the VM
 - x86 nvmm, for an unknown/unexpected VM exit code
 - ppc TCG, in powerpc_checkstop(), for a machine check exception I think
 - s390_handle_wait(): not sure exactly what this is
 - s390 unmanageable_intercept(): again not sure, think this is where
   the guest has gone off the rails and we can't keep running

At least one or two of the above have comments to the effect that
they don't want to use e.g. cpu_abort() because they want to give
the user the ability to examine the VM after this unrecoverable
guest error, rather than just exiting QEMU.

So I guess my question is, is it OK to mash these two categories of
"we can't keep running the VM" together, or should we define a new
one for the "unrecoverable guest error" case, or do we already have
some better thing to do that I missed?

In particular, "do nothing" might be a reasonable response for the
user to configure to a guest panic notification, since the guest will
presumably stick the vcpu into a do-nothing loop, but "do nothing"
doesn't make sense for "unrecoverable guest error" because we'll
probably then sit in QEMU in a tight loop retrying whatever it
was that failed.

If we had some kind of qemu_system_unrecoverable_guest_error() then
we could maybe convert some uses of cpu_abort() over to that (though
uses of cpu_abort() are a very mixed bunch, some of which should be
LOG_UNIMP or LOG_GUEST_ERROR and continue and some of which should
be straightforward assertions, as well as some which might be this
new exit case).

(This query was prompted by a patch for arm whpx which adds a new
qemu_system_guest_panicked() call for an unhandled VM exit situation.)

thanks
-- PMM

