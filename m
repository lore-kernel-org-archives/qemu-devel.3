Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EFE1C5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 12:46:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtPOG-00048V-3F; Mon, 10 Aug 2026 08:46:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wtPNd-00044i-Ga
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 08:45:27 -0400
Received: from mail-ed1-x533.google.com ([2a00:1450:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <wafgo01@gmail.com>) id 1wtPNb-0007bl-EQ
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 08:45:24 -0400
Received: by mail-ed1-x533.google.com with SMTP id
 4fb4d7f45d1cf-6a0a4a17f91so2827241a12.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786365921; x=1786970721; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfhdNFipSZRqPS4pPyjA4J8l2tPQ/gtSWhKLZK4KL/M=;
 b=Jhz5di6U4Ok23jeGR67sFeDiq8r2FK9Q8wXI5x7NkmYctpZi7zmOJPm6U1dhQfr8Cj
 PRStIMY/p5GW7wLnP9auY9uONLj3RCVHUHztv9w+epbLXKPyZLYyyWRvhslF5MJ5Qib0
 E6lxonxzVnR6aI9REHIdcFmQoALlc3G948JsH+uwrmfNmaakgzCrn029WDM6T6LHoduC
 XSS8FISELb1DC3gbhr0JyIah62JuQGg3oIS0Lyp08G+Syrsjj7G7EpFnmHH3WfteAnHp
 IHyVRx5QzLVAVbnEryLyWAPvoc5ZYANFjKcIrxDsHVpWtytjSgFLSXhesN7GSUH6FT1G
 Tgbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786365921; x=1786970721;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OfhdNFipSZRqPS4pPyjA4J8l2tPQ/gtSWhKLZK4KL/M=;
 b=mMk2kxkjdAvJ/A8GRMZIHJqDvUTKDD+mi6KTqBmL//ZSntzIXD2x9TxcDO32I5oz7+
 ZrwnmZJHb67B0ryICED/GRHCkKTTr37f4bldc913PNxeCUhLD75lRi8xsrOIDbzN5Lrg
 J3xc2NvoHg1HgRAJPmsnNXEdUajvBRcQBCEjYFNtiECAn4Ty8VtfQC3rRnnl+sYw/zwg
 c4O2SfNDMXTS26AMcz3On6wJE4InkGXV5lmOa0CAh11T+kEMigAwHchjCplrFwfqzJh2
 O5zEFxgy6LoVxXJk8pfEJCiWUYwj1y8ug9Gr+8KtG6VX8EJndI+jcMiJ4IiWxeUUyubA
 uXMw==
X-Gm-Message-State: AOJu0YyYnqg8DrzAMDyNx/F901iRzXRmGV3jCjNvwY/BxhcfESDdwwyN
 +4vW64XZRjGRGyCQEwfsfsdcWUlPmqoYYuKxQ/YUg0X0edlsDNm5/SM9
X-Gm-Gg: AR+sD13OEafH+TwZ+fo5S7T7ek1UAMm5qKIUNrOzFoCP5qlNJ9k2Epieu1ALFG2CAye
 /wqaqtguAglVOwQs+nEjxq84s6hfNhd4ordcnpOVY+AZBjs5v0djG2q2uhyyc/kJFKdVBAvvOVf
 KrrFduYRHcEprVLsPXQ31xxPkYVdH2WWdE66UZlkqN/O52sLzc/tqChWe21Dwkc7u3jIY4evXAB
 gv4a1PVEuivzR7VJQrtS/aYh9eKHt2FWCZc8e0hclhz+Lc+YWJzblf7XzVHowpQpfSR1/1pF4vU
 YmCAJuuA/GsUP6k8NlAQlI0wv5xmBGnd1w4DozR+tuGfnzCZNL57Rjpr7AD+oxMQCJsfV48cVoY
 hetJo9NIyIzU3jaDPSaL7qnf1COma7f49e6wp+pYlL2KCUsuUeQh21fxGWiPmBRFHWM09Us7g7u
 c6Rz0ptepVRr2BsF8Sm7UBUczfJwYngOHS3R9Z2X3Ube+jO+eDQMj+LQh5vsM6jQ65NkQBS8iOs
 1xcUaZkKl/5BRfQ30OCJeIxX6OiSd9CAw==
X-Received: by 2002:a17:907:80b:b0:c16:66dc:3ab7 with SMTP id
 a640c23a62f3a-c20c67c947bmr75497666b.10.1786365920654; 
 Mon, 10 Aug 2026 05:45:20 -0700 (PDT)
Received: from DE-PF5B95TD.embedded.cmblu.dev ([87.129.199.250])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c2080c910aesm391823266b.30.2026.08.10.05.45.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 05:45:19 -0700 (PDT)
From: Wadim Mueller <wafgo01@gmail.com>
To: Bin Meng <bmeng.cn@gmail.com>
Cc: qemu-devel@nongnu.org,
	philmd@linaro.org,
	qemu-block@nongnu.org
Subject: Re: [PATCH] hw/sd/sdhci: complete non-interrupt ADMA descriptor
 chains in one pass
Date: Mon, 10 Aug 2026 14:45:14 +0200
Message-ID: <20260810124519.34501-1-wafgo01@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CAEUhbmVE4j_+havPFTLgHs26FiqWPyRmeU1bjrVpPD0ZQ-Rtaw@mail.gmail.com>
References: <20260804081459.8007-1-wafgo01@gmail.com>
 <CAEUhbmVOkPeMzZGpgJ6WMk07xmf9oGL25jp7uw3uQtPt4LE93g@mail.gmail.com>
 <20260805080540.323431-1-wafgo01@gmail.com>
 <CAEUhbmVE4j_+havPFTLgHs26FiqWPyRmeU1bjrVpPD0ZQ-Rtaw@mail.gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::533;
 envelope-from=wafgo01@gmail.com; helo=mail-ed1-x533.google.com
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

Hi Bin,

Thanks for the 513930 pointer -- that was exactly the missing piece, and
it changes my earlier result, so let me correct the record first.

With "hw/sd: sdhci: Fix SDMA boundary bug" (513930) applied first, series
515264 builds on my tree (I applied 513930 patch 1 + 515264 patches
07-12; I dropped 13/26 "keep high-capacity memory blocks at 512" -- it
didn't apply on my older hw/sd/sd.c and is orthogonal to the ADMA path).
Re-running the same AM64x reproducer, 15 hands-off boots each:

  baseline (before either change):              7/15 time out
  your series (513930 + 515264 07-12):          0/15
  my patch (complete non-INT chains in a pass): 0/15

So your series *does* fix the AM64x case -- my earlier "10/15" number was
from my crude hand-approximation of patch 12 alone on the old base, which
(as I feared) simply wasn't representative. Apologies for the noise; the
real series resolves it here, same as my patch.

As promised, the reproducer -- I kept it free of any proprietary bits:

 - The machine is public in my QEMU fork:
     https://github.com/wafgo/qemu  branch cmblu/corenode
   (an "am64-virt" TI AM64x board). Build qemu-system-aarch64 from it;
   to observe the original failure, revert my fix commit cad8b499
   ("fix(sdhci): complete non-int adma chains in one pass").

 - A small image-free qtest on that branch,
   tests/qtest/am64-adma-pacing-test.c, drives an ADMA2 read on am64-virt
   and counts how many SDHC_TRANSFER_DELAY virtual-clock steps the chain
   takes to complete: 0 with either fix in place, >0 (the sliced,
   timer-paced transfer) without. It reproduces the *mechanism*
   deterministically, no guest image needed.

Since your series fixes this, my standalone patch is effectively
superseded -- please feel free to drop it in favour of 515264, I don't
think a separate fix is needed.

The one thing possibly worth keeping is the pacing regression test. As
written it targets my fork's am64-virt, so it isn't directly
mainline-able; if a test that catches this ADMA virtual-clock pacing
would be useful upstream, I'd be glad to port it to an in-tree SDHCI
machine -- e.g. the Icicle Kit where you hit the same "Timeout for
status update", or the xilinx-zynq SDHCI you just added a test for in
513930. Would that be worthwhile, and which board would you prefer?

Thanks again for the help,
Wadim

