Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F9B8CCA46C
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 16:06:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkQq-0002c9-NU; Fri, 16 Oct 2026 12:05:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkQZ-0002b8-He
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:05:09 -0400
Received: from mail-yw1-x112c.google.com ([2607:f8b0:4864:20::112c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkQX-0000YX-9g
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 12:05:03 -0400
Received: by mail-yw1-x112c.google.com with SMTP id
 00721157ae682-8ab38a051aaso645997b3.3
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 09:04:59 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166699; cv=none;
 d=google.com; s=arc-20260327;
 b=RR7qbSLsv21Ihl/Ad4Vnvo+XSf7hIbsIcoJpA3M3oA5sQygXJuEP002e8xYgUPIMd8
 pIoxapEWtyp1IYUHlVICQxYDIpP4ooERvkCbQpt3kuX/wOMXa5CR/Gj4f2x523EsABRV
 Cf1kjmJFPcWghW4cLYhShhmzbUuxTfADrTYIJ4wc1RrepYd6q9xgbNzzEITXr/kK65UF
 qseegNnnqHVnUBZvZyergO8bxXe4qViOlDq90Zv4u7iql3hBgxBJom7dql4CYNIOrVRi
 k1lbpswZuVLWsmTj/D+HfPyL/+G476hghxWFiEh5xkWzuHIjY+WGmHJk92F/UPG7Usrj
 37ng==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=oHZaaHBa8nXusX2kfKrl6y8KNB9X+UZvV+PXu8W417Y=;
 fh=pF7zMuEIRZHGHMP5/TOQukw6Kpej5ToZ7MVo57CvgGw=;
 b=O+h9PL3v25vKJwrGSv246YkpUP30P9x+8AjR00HApUIBY4XY+2EhsJ39V9EWAylmCa
 +K26A1TMjx+YgR3Cer/8zVxLjfKrkEWc+QcBgwCmCdT/7p/6Xa6eNnXsfnmZQyBmUCor
 m3uiCCL1SxipxHqf6+CvC4MetGARXALS/XbvAvpQvMtSGx4EKbbcGs/HWkzBCNKIQzsm
 hxCRB6c1jv/1cw+gkgf1aeta2Jjp4OBtrDvXmDxhewA8G+Zl0SwWulCEmEbbid6OwLWP
 lh025/8k2NxDkCcrCmVfaNR6MHve/FG2h95FOVAIDXgx7oTReo+JOWwE0tCgEl415H96
 yyKw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166699; x=1792771499; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=oHZaaHBa8nXusX2kfKrl6y8KNB9X+UZvV+PXu8W417Y=;
 b=f2S5oTLHUhM8NegZS8udOCI3SsRC9plSdRNvAxolRX5tnOOX3HrPTOW2yARUerYnKp
 V0SutLNLfOkZI1u70dKRyRje9DJ1I8jqeKkljPN3ky7Wq6jDgA5hj5kEWt0VmVcCN19N
 ZgMv4wUUahCmDk7SoQkBbp0zsmOZVmnafnI0gQ8t7yHI9X73VLQ9fgJAxIPI3Ic8aYLV
 RriTvdXvEcRQn6VdDt0SeCnWJCP9Fu3ZkfmtWDmqHD2/najVdOi2E3Cs7/QNnd7FUZQU
 0BNbRfrBaQ3utAdXXlAjL+1iYBxoEygVFv1+JaD7M88NgHHoPk8oczT9oN9TMoGhvw0v
 sk1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166699; x=1792771499;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=oHZaaHBa8nXusX2kfKrl6y8KNB9X+UZvV+PXu8W417Y=;
 b=RtOOyX4GE4/zLNL9Yhy19HSoOExAHuw/sTYjC/rJqx6YcWVbSvYhuEcUdnQGLHX7Es
 fQ3HV41HdOa3Ka4HcnnoY2wRS+rWxQsQfCOEHUMJEespRSQTGzK8/sBY4dVYx6aWR4TM
 IlrTTQrScerSBJA03dYoEfuLwDI5o8yNPCzy64Lg4ZMX5SszyDhkIrZb+CiXBRLB2mDZ
 5J/5OhG27wey9YZNvvbDrfmswDYK3yDpU4Y6kw2lcL4dNyAEQv9vj7WCtAgoGaFF3vnK
 mY2D+ZpUJ8aPn31qNknRQgF6LV+uqESNVv6UUfzamgQ6djIEdVbk6w9BivsxjqW7/PmZ
 5mlg==
X-Forwarded-Encrypted: i=1;
 AKwUvBygPILi2mG5YLrMXved4Y3oJ02X8hi0SUETNVhGBkLDVH6D0FU6aM1dpYT4gFENaHyVQT2OokPtW89S@nongnu.org
X-Gm-Message-State: AFq9FYLMHOe6lQh15T+UHAdvvH7oFDEj2dgHJAYEdIdh1RoBoxg5vxR1
 Zcd0R8Q3TK97T+9ot0fYBMaHQvFeIc0mIwTeh0I5IxPZ3gkkYCtIEAJR6u2xF3O/pVxb7W3kN1H
 7GLZcnizDv9Hyswma0i6jPv5DeOVddq9gni6CvTvYJg==
X-Gm-Gg: AYBFou0bTJP92kl8HQyGyll5XVyQk2hOtKy6yJvT9t77RycDUj0armVMcUJ4JDZB/V8
 G5sQqikOKEz96mnLeHPpg4YjPA4dVk3RvEUHQF1p5HVlXOiBbadmM2e6QvcNDk+mY/avjvYXh4L
 5lqCm7ERSICLghIfeWPcp3XPWfoOi1tVXGjvUmm659Hn22P0OYl9JdG6f9RmPUXcnhHL7rDE5Ss
 MAy8aZHS9PIGbxn0b4b3YDEQr/xd7qQ7P7BZTTtTpaN4qjAVlYQRjEK6IvxBOABpedDB7DlxsDY
 tbUdlRvILMWBKIDmbhxcqgRou4P0vj3O6xQFAsEWAyrPFJGBDuildEqqpI9HMgXELNfyvoOCyGj
 OjRx3E3pkkjCjVmwrwdpUEIANm1X1WGIZ5JLD9NOW88KPP8r9bQ0=
X-Received: by 2002:a05:690c:6f83:b0:8b0:e207:34b4 with SMTP id
 00721157ae682-8b0f21aeb87mr1772277b3.18.1792166698679; Fri, 16 Oct 2026
 09:04:58 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-20-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-20-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 17:04:46 +0100
X-Gm-Features: AclHuK85P2rMZqG6EDXy88iBDY0zAJ9NcmkQt_m8qD6NH9SZYu0OY-RxFihenIw
Message-ID: <CAFEAcA-JxCnmwSnMoEu2UWGX_wmoynMK7nC8OX85thxV=Dq-sg@mail.gmail.com>
Subject: Re: [PATCH v2 19/27] i8259.c: properly cascade secondary i8259 from
 primary i8259
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
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

On Fri, 16 Oct 2026 at 15:24, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Currently the cascaded output from the secondary i8259 is returned directly in
> the pass_irqs[] array, instead of being connected to the relevant input of the
> primary i8259.
>
> This is a bug fix since in a cascaded configuration on real hardware it is
> possible (although unlikely) that the cascaded input from the secondary i8259
> can be masked on the primary i8259.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> ---
>  hw/intc/i8259.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/hw/intc/i8259.c b/hw/intc/i8259.c
> index bfe01067b7..5f90edbe60 100644
> --- a/hw/intc/i8259.c
> +++ b/hw/intc/i8259.c
> @@ -519,7 +519,8 @@ static void i8259_pic_realize(DeviceState *dev, Error **errp)
>      }
>
>      /* Wire up secondary cascade */
> -    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
> +    qdev_connect_gpio_out(sec_dev, 0,
> +                          qdev_get_gpio_in(pri_dev, 2));

Looking at this again, I'm not sure how this is a bugfix.
Quoting patch 18, this is the code at this point, just
for context:

+    for (i = 0; i < 8; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);
+    }
+
+    qdev_connect_gpio_out(pri_dev, 0, &s->i8259_primary_out_irq);
+
+    /* Secondary */
+    sec_dev = DEVICE(&s->i8259[1]);
+    qdev_prop_set_uint32(sec_dev, "iobase", 0xa0);
+    qdev_prop_set_uint32(sec_dev, "elcr_addr", 0x4d1);
+    qdev_prop_set_uint8(sec_dev, "elcr_mask", 0xde);
+    if (!isa_realize_and_unref(ISA_DEVICE(sec_dev), s->isabus, errp)) {
+        return;
+    }
+
+    /* Wire up secondary cascade */
+    qdev_connect_gpio_out(sec_dev, 0, s->pass_irqs[2]);
+
+    for (i = 8; i < ISA_NUM_IRQS; i++) {
+        s->pass_irqs[i] = qdev_get_gpio_in(sec_dev, i - 8);
+    }

So before this patch, we connect sec_dev's gpio output 0 to
s->pass_irqs[2]. The loop earlier in the code set that up:
        s->pass_irqs[i] = qdev_get_gpio_in(pri_dev, i);

Now we have:

> +    qdev_connect_gpio_out(sec_dev, 0,
> +                          qdev_get_gpio_in(pri_dev, 2));

Isn't that exactly the same thing?

I think it is indeed a bit clearer to directly grab the
pri_dev input rather than pulling it back out of
pass_irqs[2], but I don't think there's any behaviour
change here.

thanks
-- PMM

