Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81055C55182
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Aug 2026 14:11:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wqtNu-0007Xt-OS; Mon, 03 Aug 2026 10:11:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqtNs-0007VG-TH
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:11:16 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <flamboyant.h.01@gmail.com>)
 id 1wqtNp-0001bg-SV
 for qemu-devel@nongnu.org; Mon, 03 Aug 2026 10:11:16 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-667923d86a7so4938882d50.0
 for <qemu-devel@nongnu.org>; Mon, 03 Aug 2026 07:11:12 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1785766272; cv=none;
 d=google.com; s=arc-20260327;
 b=ZWWcaTUpmBn9R5uC4nJMyzFGjOMaEzXKsj4MfJqpmmxsiVRNP3LFHqNHPPephvU8KX
 6r5OCXxtcZw2VvAcW7hqWaHZx5GBP0i5IkbVB4QvQhPTDij4s7AooKTM6JZxHeJ2mq43
 chvtUKzeQnZgcNsdlPUXj4UpdMMDXXWGmV62ReBcNGQGFC2PL61WQoE1AQIJTDizm/uf
 8tkzZ3Jvt35azc9TyWPquM1Ux7xDgokL9VNJ4gHn1gobSDMaZsJoF2XBsMqSByBxuKX7
 4VUiMe9rV/+4/7JqoHxbh0Ky3+OMG/ZcQzS/DdnhKm8fx7/KCtKYYiEoTSV69/yOap1u
 12lg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=KomXBvQnd+/xc7v2TsLXIX6R8D5PEtg9gotg8LORFd0=;
 fh=ILgvEJtXNNzERvp+6ipCQeM+y5xfHDw18f581vt86gU=;
 b=Bd0UHKT23qnXPUdBK6QT7K79sDCK2c3+ChJ2VsNd0f1qJXEAbfqqYojtIWxoQqlIY4
 id4MAHJ3DGbMe1C7NUcIWPsUt53xqpQzht1AZjDGN/pqvBvb+L1oLUkxSrN4lcTQJ3xB
 cQdZLbcT/mnImycIPnsllZpEoaJJ1mHyx7J19A8eM6I9Vkkezs2tdI863hcUfXyMdDv9
 vpzq4B6BET9eDB7ZpVuiS+eEjEA3jtyO0GhQi8XegwwzpqtwgQK/eaQuma2EE99rbcqS
 tUd11aNgbC5ZCdwvBZzeVTw2+8u78cBBnXgX18UBicjqvThmne8+hqcMcdKjuKyvfv98
 ceZw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785766272; x=1786371072; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=KomXBvQnd+/xc7v2TsLXIX6R8D5PEtg9gotg8LORFd0=;
 b=J9zPYg9wAzkIN/4OqCI+ZdO5jPTXx6AQIiTcwggEKYL3VZ9uHBeo02+uytNmGF7d5a
 geQp8clbW+0fB4StnvLovOdq0Q+59nUWHPtLtF/woawf5TPkoO8VanlN5+9fQ3ionj1i
 jXll+4pjYueq0LV1YL3RPWG9uKcwFgxHQu6EnXsYRpvOMNB+O8XQjjPLvwk7v844WAeC
 coE3hRQIU1BoxBNNCZYchG1jUtWU6L7AWL/QmmRzLtms1jC6V8WDKkue/pFIbSfpV+zZ
 VOrZGJjlmGjZ3+dmhhvhUYa9kcjqwKQ3Q9sR0HcWO03WqPMdkNX+xTQAhimFz5ZQhIPB
 k5Cg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785766272; x=1786371072;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=KomXBvQnd+/xc7v2TsLXIX6R8D5PEtg9gotg8LORFd0=;
 b=c6Q6kzX6895GCPgrmJOoKAQpeCLp26ySi4QVnWA+aCbRTS/lmkHo7w/k/d3iZHAQTU
 mZ1ojzauL0Cx1RbH+qC81YA9f8kbMHCqZadeC+TcCE7n28MtqMofZYLIz+07l6AU6x3+
 5BA77F7qsDcmZfZVHPTHeDqnBCeIz9OvPBSPCkv11VHcpBgRI5qu5rc0m5rFTCRsAv/L
 VLIyBkP360trw693KykUkK2S4wL5jLVxM6Amx69gnQ4/5hSkZjfPtJR2DZWl0EtiKaR6
 XdO2b4sDaogWNdYmQL6ZQa+hlIzwEhn97jlk9HjGVGi3gp+95Cwd3JgOTPp4kMtT067f
 caCw==
X-Gm-Message-State: AOJu0YxF8CvJH+X5OBOant1wbSGL2wNsOWdtyM535CWaFfFCTr1JuTJC
 cfvlY7mFTy1x/2uL4M5YE6W3kOmYOeAsfKVLvh8kmQE6NQBfO9PfOoaXa1eaujHNL9n7U6RK6CB
 bvwS1r+QQSTybPIUEUh6DRrk0s0FdjKg=
X-Gm-Gg: AR+sD11JA86DM+coRWNwHQi1pD90bxm5s60wk6MIwKUgjDfz0Mrv7w0FwvD0YNypUL2
 EtW7jZSKZiCxZ23s/GL3WPcELGP8xz2wMc0RvP3Mzk5LfAQe5qCSnEqtF2RQmYuqhM2vV+HPbF6
 ZO8JowdC03k2x+gXzfoED8XMQaainTajlzFds5eN9tpc5iOeh9DkRuhxI5xKV7CM20AnV+CCCyZ
 yeuNiXbXZCgFRrwaiNqRYaz/tAnEEvjm6pljeyjUdDScj3JRGWg+uKflw3XA+lDiCtltRHEs9qG
 +0Ot7EWSdjxTYZey4e0mndmSQ+QZtqSpBnJGFmwSXqQkxg9DgogVyo8=
X-Received: by 2002:a53:c04b:0:20b0:668:42e8:87c5 with SMTP id
 956f58d0204a3-66945be038amr10575698d50.6.1785766271655; Mon, 03 Aug 2026
 07:11:11 -0700 (PDT)
MIME-Version: 1.0
References: <20260801192848.30606-1-flamboyant.h.01@gmail.com>
 <20260801192848.30606-2-flamboyant.h.01@gmail.com>
 <am_1N3eEBeSROBYe@ChaodeMacBook-Pro.local>
In-Reply-To: <am_1N3eEBeSROBYe@ChaodeMacBook-Pro.local>
From: Kangjie Huang <flamboyant.h.01@gmail.com>
Date: Mon, 3 Aug 2026 22:11:00 +0800
X-Gm-Features: AUfX_mxI5LpxqkPzOSLGessKSYRTMNWexDsZX4L6Tq-XskUsJ55pErPtCqMm52U
Message-ID: <CAAW0U4ZzN75qtxVF9ivcryBdeLwn7xVEKnkX-VYJ7zoVQfiTkg@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] hw/ssi: Add Synopsys DesignWare SSI standard PIO
 controller
To: Chao Liu <chao.liu@processmission.com>
Cc: qemu-devel@nongnu.org, qemu-riscv@nongnu.org, 
 Bin Meng <bmeng.cn@gmail.com>, Alistair Francis <alistair.francis@wdc.com>, 
 Alistair Francis <alistair@alistair23.me>, Palmer Dabbelt <palmer@dabbelt.com>,
 Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Paolo Bonzini <pbonzini@redhat.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Kangjie Huang <flamboyant.h.01@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=flamboyant.h.01@gmail.com; helo=mail-yx1-xb12c.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

Hi
Chao Liu <chao.liu@processmission.com> =E4=BA=8E2026=E5=B9=B48=E6=9C=883=E6=
=97=A5=E5=91=A8=E4=B8=80 10:10=E5=86=99=E9=81=93=EF=BC=9A

> Could you share a stable public link to the DesignWare SSI datasheet here=
?

Sorry, but I don't have a stable public link to share. Synopsys
doesn't publish the DesignWare SSI databook for public download; it's
gated behind myDesignWare registration.

As for the other Synopsys peripherals, I haven't seen any public links
to Synopsys IP documentation either - not for the existing QEMU models
(DWC2/DWC3 USB, DesignWare I2C, DesignWare PCIe host, etc.) or
anywhere else.

I actually referenced for this implementation:

- K230 TRM (Canaan official; includes the DWC SSI 1.01a register
descriptions): https://github.com/revyos/external-docs/blob/master/K230/en-=
us/K230_Technical_Reference_Manual_V0.3.1_20241118.pdf

- Intel Arria 10 HPS TRM, Chapter 20 (Intel official; DW APB SSI
registers) https://www.intel.com/content/www/us/en/docs/programmable/683711=
/21-2/hard-processor-system-technical-reference.html

- Intel HPS Technical Reference Manual:
https://www.intel.com/content/www/us/en/docs/programmable/683222/22-4/hard-=
processor-system-technical-reference.html

- Linux kernel DW SPI driver,
  - DT binding:
https://github.com/torvalds/linux/blob/master/Documentation/devicetree/bind=
ings/spi/snps,dw-apb-ssi.yaml
  - Driver header (PSSI/HSSI CTRLR0 ):
https://github.com/torvalds/linux/blob/master/drivers/spi/spi-dw.h
  - Driver core
https://github.com/torvalds/linux/blob/master/drivers/spi/spi-dw-core.c

