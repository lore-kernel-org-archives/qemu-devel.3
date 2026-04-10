Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2135BF459EB
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 15:04:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBDPN-0005Lp-0G; Fri, 10 Apr 2026 11:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBDPL-0005LL-SY
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:04:31 -0400
Received: from mail-yx1-xb132.google.com ([2607:f8b0:4864:20::b132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wBDPK-0001LB-Ga
 for qemu-devel@nongnu.org; Fri, 10 Apr 2026 11:04:31 -0400
Received: by mail-yx1-xb132.google.com with SMTP id
 956f58d0204a3-6501e465a8eso2360096d50.1
 for <qemu-devel@nongnu.org>; Fri, 10 Apr 2026 08:04:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1775833469; cv=none;
 d=google.com; s=arc-20240605;
 b=MQ3rlfgAGljLqImMTW0GxINzdWCGUKURqV68k61LMdC9jGLVXSqG8nBcDqdnCUWrLK
 1tT46HSh0V4FHkk1VW68z3KmO0u8aTdX7rW6jag4HondLNJdbehcSFN3q2iMLqFzZu3p
 Vl/Wy+wz9lL9sBOhLVQzIb2ZbBF5D56+C/qavx11wN5IvvM7Yz1Za5561EL8zZEv1/b2
 RMXcN+vHqZxU+XdxHNGhdrl2iSbmbmey6deCg5ipAPIOTtHUtIbM3wkkYxrG/Pa23tDa
 SaJF2rtyGn4fK6Ixdpkc4IsXl2qgKF0nei7+08d67Z4ySp94Trls+kucf+LxpcSCIFp5
 Dspg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=6SQCY0tTnDDChZFId1z+GikYvHBYH0iXdjUWdU46GYs=;
 fh=+FLO+pFqkaqHtGKrfhVN/AnUXYYORgOdUQhcfDDqqUA=;
 b=I03Dz0j3W7ua5IfR7b5Hbw1cIwKe1K7gUh6Y4ISOj70EKZgHkLKxUPdFTYlhk3mwMR
 q30VFDrqOTatYEaF53wpneakTC+c+g1cy6Z5bDzEgjCTvmK7TQYOQbC1F6CysfbbpRct
 UmSDNW3jo/uuyZ0fl9uCytFgx+Bn3BvP/zUxcCBoPe8haadR78Clc+jZxJeTq+WInIO3
 ntPeTfAaeYWYDjxKCqlGU6/eLLjwvn/yHleG2UNTvwkll+8k6wJqa57JZhk4BUB0UhJM
 81Uk1D03wwJpyjaenH2ej0gz1PG2XRZv8/4qXSQV0w0FNvCvENGxQYHrzNli2tiMS2lb
 226w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775833469; x=1776438269; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6SQCY0tTnDDChZFId1z+GikYvHBYH0iXdjUWdU46GYs=;
 b=KSgO+4EPg1np58TLkFCF+dSKZhVnz8dPtmxMqle1S17xTFJqW5f08upUIVt6vxwowm
 wA1ltA5yDtjXQH+wuNqZwm7N+83yX7iU78AHK8hSfjMrykqFcSMnEyO5aIbhhIVuVMrV
 YkX+Ee3rtpBmt/W5IN79bJZeQKgd3Vi2IoTfW1ocGeIL7vmxIg7nb9uq8Pmjooyb3jAl
 ZF/QVcHhNvnbuZyzjJKpIusISs4FEMPdzZ8OaTUL278ewe7rxZVQbUWBzDoMA6XlIrzM
 O/3c6gOji2BCrTHp0FPBH4Knma0V3hzdLhuI+OHzRcXngzNZdaCJswksnjT+Ee0yo0gd
 2fFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775833469; x=1776438269;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6SQCY0tTnDDChZFId1z+GikYvHBYH0iXdjUWdU46GYs=;
 b=e88K6DfvoCAT58CRpkTstmxU6+8WcrCB78uqrbH+NFU4j7KIIy8Y3jUS5MCtrOiJUa
 DIAnJA6hI4mvoQTj4j1CTwUPS5nj7m4pEil518CNzqqCFv4+Tn0rKgJdy0ZXcLyNgqut
 B7/945N5lZf69ktwustrYkG2F5VRMyYikH1YlnFYJfPNgMv0dg1Pl2Zyqlsv+q4yV+fb
 hVSfgGRQ1I88dDfJEDdgkj30xRoszBrF/ew0DY+J/U7tv6qBMh/iO4zFSFlE2bB3Ef2g
 MaTGrJMrfh/pdKOjGFzQkvBxPSd2ldRqHqusNdmCFUnsu5DRlsP2k4OVtDu6xl0yEPSY
 tvNw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW8HYHtCxubjsqkJbcdQpGU6KT9TUON/vRawLRmrvXGAOYbITshnrU4NKsfENk/eSSScjsYyv3MqraT@nongnu.org
X-Gm-Message-State: AOJu0YysPTwyuhGKPQMHWpx2eZA/f5PjFzwW1LFmFVM+UBSGaJcL8UE/
 lvdg6+BY592S9qxE3aOxVlbgLYOe3gxT1k7Y8QKwnrbDUpoZB2pwTiMmuaoKF4+00G9I4nK7vxW
 ypKv0Br+xKo/20UQPfZ3OrZZqLpDfM1Uy834EF+7iXA==
X-Gm-Gg: AeBDievDjonG5r2yEgVLU7WYSdWK5XtqpkAqN883JSKrOYZB2PS61juSUfSgJR3R5vb
 vAiAwt653VQs5B7ABQmMUxDDJU9ajJyeV+1AYxwqKEld0IP+EmRmZDE2SiMgBcEBjT9OeTlC9nw
 0+Iz9bgrD8V6LSMwW4uR9dQxfmfShl2qsS1MVUN0XX3CLw9cLEpwX66+e2AeTtAmgEpTU5hkydL
 YYFjXYQMKr7ZzPvL/yUrIqxLQUNuCwdEMjfMq45ysaEmVTCe6zdikm2dUd8bsHLZ9abIsVMxBFy
 Un4nvYKA6zOJDWzMHmASKA179ghI7r0cOLbqYUaIcRF6bP1k4m51m8NXTg+8ttDBJGWfgGNIbqf
 bqQ==
X-Received: by 2002:a53:ac87:0:b0:650:77d0:8f7f with SMTP id
 956f58d0204a3-6519905c33cmr2623494d50.21.1775833468434; Fri, 10 Apr 2026
 08:04:28 -0700 (PDT)
MIME-Version: 1.0
References: <20260327111700.795099-1-peter.maydell@linaro.org>
 <20260327111700.795099-11-peter.maydell@linaro.org>
In-Reply-To: <20260327111700.795099-11-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 10 Apr 2026 16:04:16 +0100
X-Gm-Features: AQROBzB46PPWYaqNhobPPWhn1Q5ByeFwjQ7KYkNE6o2sxwvQFCAIXmSmpstEoZI
Message-ID: <CAFEAcA9L7gqa9FFRhWpcPF2Xmr4+OAX13he_McG_CV1xkDAzkw@mail.gmail.com>
Subject: Re: [PATCH v2 10/65] hw/intc/arm_gicv5: Implement IRS ID regs
To: qemu-arm@nongnu.org, qemu-devel@nongnu.org
Cc: Jonathan Cameron <jonathan.cameron@huawei.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb132.google.com
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

On Fri, 27 Mar 2026 at 11:17, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> Implement the IRS frame ID registers IRS_IDR[0-7], IRS_IIDR and
> IRS_AIDR.  These are all 32-bit registers.
>
> We make these fields in the GIC state struct rather than just
> hardcoding them in the register read function so that we can later
> code "do this only if X is implemented" as a test on the ID register
> value.
>
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> +/*
> + * There are no TRMs currently published for hardware implementations
> + * of GICv5 that we might identify ourselves as. Instead, we borrow
> + * the Arm Implementer code and pick an arbitrary product ID (ASCII "Q")
> + */
> +#define QEMU_GICV5_IMPLEMENTER 0x43b
> +#define QEMU_GICV5_PRODUCTID 0x51
> +#define QEMU_GICV5_REVISION 0
> +#define QEMU_GICV5_VARIANT 0

Apparently it would be better to use a PRODUCTID of 0xfff here,
as less likely to clash with any potential actual product IDs
allocated for this JEDEC Implementer code; so I will switch to that.

-- PMM

