Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B5F606A31A
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Oct 2026 09:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=iJBnkplt
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xJSln-0001WX-QN; Wed, 21 Oct 2026 05:38:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJSll-0001WA-Pn
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 05:38:01 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xJSlk-0006QC-AT
 for qemu-devel@nongnu.org; Wed, 21 Oct 2026 05:38:01 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-8b0dba37a7fso4449417b3.0
 for <qemu-devel@nongnu.org>; Wed, 21 Oct 2026 02:37:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792575479; cv=none;
 d=google.com; s=arc-20260327;
 b=QKY/4B0jekMAChCBUXPoMkru65v63Kw49JoqjKTFqgWZsGL8v8lT8fts9cSfCOfaA8
 +OvdKsHtqLYS1aq8xVRdT+nEnV9gnhJ0Y7KFFQ5QdAvhWXQYMiYmy3+jSLBXYP4Ip+5J
 bD80SnR7a6suICEslkJV7bjlS34WrCLD54W4OR5QZHfl1PEbh8j1N+7ZWYGUm86mM34J
 4bW+ayQyniMktGJY1/sPySu/GYHw2Ed+K2ionGwduolQRKuYqdGfmkzxHHwftrLfWGtc
 vcyxYFI9ASIbzqR8QLy2beBNLuuu6wrdnY6+3InKEPlexIIEnQgVtTv1BoYPC6ZeWvQD
 hv4w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=gut2OwYZ9tHUA86vIuwPk6XRH+27gwVl8H6XpCIpM6c=;
 fh=K95cGjj4oVMmNnC//U0VuAmnYHzVBGhdA0URPgJB4jU=;
 b=j3UZkg9jxwW5R4IlTxzdOt9GwOVPd2s9I1YV7908i/N/msW/S1kTH1An8FUOwmcU9Z
 VHK8vlMnTLNoRgDJrmDaOQfWmd6MFnr3Qr11hqQQw3w5zoDLXfxcnfkofYCKDjLZiA5a
 8SrnL32eYPpyo0B4kBhH/1ty8hEoU6olH/NGuKPzivY9/IUP3Vh5WMRVDiDl1neWlvLD
 4nYcuK/PQ1qjnGe02IuGm7P36COKn3nYSy+3TEz0VQ88gSJag12/bT47ilYqGxbkcKys
 T40kpzlMqM/DevDO9smrcMRkR2sJu+auyrDEtywm2wRw6e6R5yjNOrHS4J4WCIyqZwXd
 BuTw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792575479; x=1793180279; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=gut2OwYZ9tHUA86vIuwPk6XRH+27gwVl8H6XpCIpM6c=;
 b=iJBnkpltasNaN1+eqjMf9p3A5NLUgC0YCIs6k66Xf2E76+QGHsrHeIT2ZVy0jFMwcl
 4KpO9/tknWcZGbcg3fiZyp7cB3NybBmKZZNhJGsmGlBp6iH455c6hZGyQUVm+a51n9FD
 RnvsXCLDOAHhcrFKJ9o0vIAcTz6TUatJCLuaDKMEJzY4SM5hqMgTIxxonmc47OWbvsrV
 U9nvahdVHoPfqPtZdUHTOGRGRX+W5nQS3cYul8LLhwLGcwLeYFPiRIwG/wZI5Tqfy9MR
 2GQRANhq0PSWgJIkR8jxKHpU2hAy7pKjit7bRsB6bl+vu4m+tSLzaF//5hWgUp73jOtu
 sjPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792575479; x=1793180279;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gut2OwYZ9tHUA86vIuwPk6XRH+27gwVl8H6XpCIpM6c=;
 b=AZmuORnFhE6KqwcnajUc/EqsCJpGxnOPot9IlnEzpzAm9ic0xTNv1cWshY/x856FBx
 F4+uLo9/C5/tkQqmNu+L27J9t2Jd8UAsjZXIz70pe9tRPW2DWoaXlWKtVPOBxMpaihIS
 yuWZEmnTWiia+jLoYHcg7cJ7wu7xNZa+jYSRZwOxCaNil4Vr3tyH9w+ajoDbhry7Clxv
 B66/ZlnoU18jds4H75NWCgt3sbKCPQHwtGMItNouC1ZyxRYdAKQcW0yk2pu8CLykWoBw
 7loG2gocW8JXpi7VZjXwrWkvwREpEtNcZyaEf+hAMKShcMseaLQPBL42mxb+lGejLnz4
 KSeg==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ9+AcZq8Xpb1Ok6ddGfcfEDtbUzsCWqYd9Se1UNqMnSs5HEd7eIyMCWRAH7wb+/Pjnl6n4h3UiCOs@nongnu.org
X-Gm-Message-State: AFq9FYLZydZrSQD+dqkPd/mzdJOkUtd3UdRpvX3wsK76UUmUj/V+cQIN
 qScp1787ZOIcOUK5BrhrPq11XojUau3cYtSWzFbvfKmwjv13tqocijcrn9XZkk68N/p6rzBwpdW
 m0b7lXGbN4gIwGow39He4PIEZz3dDaTReiXaF65pHSA==
X-Gm-Gg: AYBFou1y3Utgz+PeHwKmeuaJrcVhunNzGfRJXY5LSl9t07TYkDB1FbJ4nXYjFmmmTv6
 d1oEdjisYbrjt/w1oDcqMofcXLm34bjNV5ni+jcB/MQOQ3XTJXOhpopaGlGr2+OTp2EsCDOtBHj
 YwfxM3xNvxlcYpF65tx/ZE5MZIiLziPLkD+IEOqN/V6Ix4+T+Fgh7wMCu9yZ+mePAnK+6LsP2If
 lh7/3BWk76f7AhmtC/eY4RzdqJdpdjOorKzfyZATpMM23UoNpnNuRuTVRJ9zUIK7LTVBAX67M8j
 Q6EoxomGSWO1wvLw3dVMBhn301fY1JmvHwOW+3HvkCOykQ+PDkCZxb6dD9M5T2N+6756Vgc6wB2
 +qGoV/cGSdoO8DvVxoDKQvDK5vG7N4brfLnoxbADfw1KXnBj/au85TG6Wk6LicXmdAYNjRLxRaZ
 Rc018H+HvQykz+Q+htXpU/
X-Received: by 2002:a05:690c:c1c7:20b0:8b0:a8f3:bf69 with SMTP id
 00721157ae682-8b133fa1ba5mr5063237b3.12.1792575478618; Wed, 21 Oct 2026
 02:37:58 -0700 (PDT)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261021033615.3619988-1-maobibo@loongson.cn>
In-Reply-To: <20261021033615.3619988-1-maobibo@loongson.cn>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Wed, 21 Oct 2026 10:37:47 +0100
X-Gm-Features: AclHuK-DJLULJiQWeZ8zZSttjwDJvT_rJnp95J0rkAX-urHTvJKq1Bkgv5iryXg
Message-ID: <CAFEAcA9nv=q8u-_MbpOZ0qRnFZ9thpWo46qiGZLznRd88mLJvA@mail.gmail.com>
Subject: Re: [PATCH] hw/intc: Acess LoongArch irqchip data with align method
To: Bibo Mao <maobibo@loongson.cn>
Cc: Song Gao <17746591750@163.com>, Xianglai Li <lixianglai@loongson.cn>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Wed, 21 Oct 2026 at 04:34, Bibo Mao <maobibo@loongson.cn> wrote:
>
> With the clang sanitizer configured with
> "--enable-ubsan --cc=clang --cxx=clang++" and run 'make check'. The
> test-hmp test falls over with this backtrace:
>     ../../hw/intc/loongarch_extioi.c:439:33: runtime error: load of
> misaligned address 0x5b0a281448b4 for type 'uint64_t' (aka 'unsigned
> long'), which requires 8 byte alignment.
>
> Here LoongArch irqchip information is accessed by its natual aligned
> method, and here is output of command 'info pic'
> loongarch_ipi:
>   CPU 0   status=0x0 en=0xffffffff
>           MBX[6] 0x00082270
>   CPU 1   status=0x0 en=0xffffffff
>   CPU 2   status=0x0 en=0xffffffff
>   CPU 3   status=0x0 en=0xffffffff
> loongarch_pic:
>   mask     0xffffffffffffff7b msi_en 0xffffffffffffffff edge 0x0000000000000080 clr    0x0000000000000000
>   last_irr 0x0000000000000040 irr    0x0000000000000040 isr  0x0000000000000000 polary 0x0000000000000000
>   MSI map:
>     [ 0 -  3] 0x00 0x01 0x02 0x03
>     ...
>     [60 - 63] 0x3c 0x3d 0x3e 0x3f
> loongarch.extioi:
>   ISR     0x00000000 0x00000000 0x00000000 0x00000000
>           0x00000000 0x00000000 0x00000000 0x00000000
>   ENABLE  0xffffffff 0xffffffff 0xffffffff 0xffffffff
>           0xffffffff 0xffffffff 0xffffffff 0xffffffff
>   IPMAP   0x02020202 0x02020202
>   IRQ route:
>     [0   - 15 ] 0x01010101 0x01010101 0x01010101 0x01010101
>     ...
>     [240 - 255] 0x01010101 0x01010101 0x01010101 0x01010101
>
> Fixes: 970657e490c0 ("hw/intc/loongarch_extioi: Add extioi interrupt status display")
> Fixes: 761eb76a3bc7 ("hw/intc/loongarch_ipi: Add ipi interrupt status display")
> Fixes: 82f472fa380a ("hw/intc/loongarch_pch_pic: Add pic interrupt status display")
> Signed-off-by: Bibo Mao <maobibo@loongson.cn>
> ---
>  hw/intc/loongarch_extioi.c  | 51 ++++++++++++++++++++++++-------------
>  hw/intc/loongarch_ipi.c     |  9 ++++---
>  hw/intc/loongarch_pch_pic.c | 28 +++++++++++---------
>  3 files changed, 55 insertions(+), 33 deletions(-)
>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

