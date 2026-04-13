Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80962F34C49
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 12:11:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCG7R-0001Ft-Uq; Mon, 13 Apr 2026 08:10:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCG7O-0001FU-2r
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:10:18 -0400
Received: from mail-yx1-xb135.google.com ([2607:f8b0:4864:20::b135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wCG7M-0006zo-Hp
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 08:10:17 -0400
Received: by mail-yx1-xb135.google.com with SMTP id
 956f58d0204a3-6501418152cso3830095d50.0
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 05:10:15 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1776082215; cv=none;
 d=google.com; s=arc-20240605;
 b=goLQOt/ocWYyhzj67w+MPqRRpFV9xMZ0VWaNFHdqn4fI9VeBH9gY3C2epqcH2gYjbh
 ZWSR4MwwZT7MU6phrC+r7EaBujc92GuuEGMwuGWF3RS1+r+KxHgJ2PX5mBrXisgM8NUA
 8T2iG0B34JevT1a1wmwUc0nZvD1vPEFnWBCenqc0/X3bwVwOAIp9070YIPxhQg6/g2ya
 yzIlkAVJKZ+G/wPMVWYw/up1loQ6bguNWz1HRZ9wwaX8vN4hBbw/S6hL85RwLvsZc9O4
 Q5wNQ32fXA68tySOKPc6BztUWSW4G6bxGztVsbhCXsDHPXhQqAIcE0MhwH17FmvO1ZEZ
 y47A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
 fh=nuDyw2AaQVMu/z3gTSY9tFXBGNPo8PzzGimxbuSOXjs=;
 b=ii8M3a/HBAbIuathslgOjOZoxna+1BOOG0JYHOde49s3SMdkOj/SnIhdUKRjJHLkE4
 Gw+MTZnauvreYT04MAzd1KYYxsLXqL4oAfi+/+P14uMfqmPWy0DRHv5nd3MKh90HTB98
 V27OSjxySPRSP37SV2XPcwVFmwAEDma26AmO4QI1h/eP70t1lyiUpX0V1kdBx3ho2XfV
 /HzoXeF/Nm1QrdJF+++HBUoRMndZbBBN6LA9WvOodgYpoK6ixCqv1nbpgkbQg9mhMD8t
 sBRTqabv8KcJdRswntrxRW7RAZ7BvmAcqN1SH5hEpWjGT0S7eZSojwUQM3ceU62pheRh
 tKug==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776082215; x=1776687015; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
 b=n3kwoOSLWhsngl6TEgT5hSdUK+BeW2EDPVDoT6vPlSKrPabolu+hUUQEoXEtER+X7y
 VRh0EP/HR3NtID0GyRKDfveTZjjoq2TMIgC77J9XBgJQjiby22qQvxl0yI+XOl37PhVj
 ghTx9U1tODFZa/iN3aunAlfAr4vnRFg+ylILMJNAmIWxVWv80Imax8KnmhFSk/e9z7CM
 voqM7OIa5OMbS8SX4ujPGMmD5XK30wilV/TM4STyMTnkLIY2BCz1G9tPqKu6ZHsRqe0N
 Rr5x/H6lJAnP9f61TXUMhf/gKeDVrAtvIhLiwWBki5R24GmD50VTA1RkqMS0BS5qB7Xu
 /avw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776082215; x=1776687015;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=d0l7uKyUGAFvL6R4w6MO2qwL5tFfxbP6Pv5jSvZFfDc=;
 b=LC4genpPt6XjiqoWhZgPQrN7D3R6/YspvuQmBxSCVP3ojtMsJjoo5FQuNaqu/mdZNe
 kReRBtH1DvZUFXtGbJo1lISpkpRk4Y6gyWuSl8sgv87ulFKZuYOYUb40PcNAqXrUL9+p
 ylGc2sl6M/0Z4RGImZwETNVULAnZasGnRfzvDBkcs5V7FT+ZLDtY2Blp5xxqyv+rvx7l
 I7m0FwiTOkT9UhT1VXIEhP8d5rsz56Cv4qdmo7VRrw7qc3a7208dvJFO2sCkqRTxkw4W
 G9PDojx8Id/TGwhY6nSUq3iA+vn2ZKoC9JlQEquKhf7PCmZqsZAs/OWgHgQLvaaHWGF4
 CIEg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+NCwbcwZKa7FHa56Cf5d5bpJ0vJjVF5aiqG3QvEIWND4WwBu0YzbwoKojLNbC1SKmokIM6FaEd3Y7i@nongnu.org
X-Gm-Message-State: AOJu0YxcrZ1QuPE6vZja99PqVoRW+ivpaOwfVUBrT02vEkgQK3GLDisQ
 DkqKEVhFRezGNxpuu0G7xpe4mvSSiG+cJbE7hoIGPrGAtenq1qlzV963RPeXm3fYyMEgqAbmamk
 QE266s49XGyoE8v3f6n5EF7FxWfkXj1+nJLZepS6+cw==
X-Gm-Gg: AeBDietPq5WNnSX51YULrtuNNtX22Qg41w5PrFEGvO6Cq820A3ETVFMszyjqwUWg3fV
 vPteUkrNhfZYkmkbIM240RevFfKSlSSPyuUfZY30wmUmQ6gOfGuuTr1TbYqgT1cEZe3UeM3tmxR
 UZo+F6NkwZ/jsYh0fW8fVBd/nZFaWa2mDkG79WJFrzfNtGC+GwcsVXgELebvyPDYOKn0aSInHci
 U4tSyOqX8AJYvBXZYnJeLORUFNJ/rzH+bFw2R4oZ9HoBYdNWfSZ2fsD3OmdM9PI1AhszBftDONB
 kcfk2Yg/Uz16VCiYAit9/4sv/qlLVlQwJiXYDqzIJfruelCRA+7m2s2kEfJ8gSIPP68=
X-Received: by 2002:a05:690e:4841:b0:650:211f:1d4 with SMTP id
 956f58d0204a3-65198b82095mr8882405d50.47.1776082214947; Mon, 13 Apr 2026
 05:10:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260413090010.60339-1-anisinha@redhat.com>
In-Reply-To: <20260413090010.60339-1-anisinha@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 13 Apr 2026 13:10:03 +0100
X-Gm-Features: AQROBzBUIwljeF7bsJTwC19zV3JnLe8AM7zwfh_wplD60WBQv9RPuRuBSo4bXGw
Message-ID: <CAFEAcA8CcD+8Hn2++X5FnyYcsDLV4J=tFg5BAd_sRJmCw+nVkg@mail.gmail.com>
Subject: Re: [PATCH for-11.0] accel/kvm: return early from kvm_irqchip_create
 if kvm does not support irqchip
To: Ani Sinha <anisinha@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Misbah Anjum N <misanjum@linux.ibm.com>, 
 Gautam Menghani <gautam@linux.ibm.com>, Fabiano Rosas <farosas@suse.de>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb135.google.com
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

On Mon, 13 Apr 2026 at 10:01, Ani Sinha <anisinha@redhat.com> wrote:
>
> During refactoring of kvm_irqchip_create(), the refactored code was returning
> early from do_kvm_irqchip_create() function if the required capabilities were
> not present in KVM. This was not translating to an early return from
> kvm_irqchip_create() as was the case before refactoring. This is because,
> do_kvm_irqchip_create() did not have a means to notify the caller of the lack
> of kvm capabilities. Fix this by making do_notify_irqchip_create() return
> EOPNOTSUPP error when required capabilities are absent and then the caller
> can check the return code and return early.

As a fix intended for 11.0 at this point in the release cycle,
it would be helpful if the commit message stated what the
user-visible consqeuences of this bug are. That helps in
identifying whether this really does need to go into 11.0
(i.e. whether it is release-critical).

> Fixes: 98884e0cc1 ("accel/kvm: add changes required to support KVM VM file descriptor change")
> Reported-by: Misbah Anjum N <misanjum@linux.ibm.com>
> Reported-by: Gautam Menghani <gautam@linux.ibm.com>
> Suggested-by: Fabiano Rosas <farosas@suse.de>
> Suggested-by: Harsh Prateek Bora <harshpb@linux.ibm.com>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

as the minimal fix for the logic-bug introduced by 98884e0cc1.

thanks
-- PMM

