Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44AC6C28B30
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 08:22:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trYN8-0006S1-1k; Mon, 10 Mar 2025 04:20:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trYN5-0006RQ-UW; Mon, 10 Mar 2025 04:20:24 -0400
Received: from mail-pj1-x102f.google.com ([2607:f8b0:4864:20::102f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1trYMy-0004Ow-Bm; Mon, 10 Mar 2025 04:20:23 -0400
Received: by mail-pj1-x102f.google.com with SMTP id
 98e67ed59e1d1-2feb96064e4so7676984a91.1; 
 Mon, 10 Mar 2025 01:20:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741594813; x=1742199613; darn=nongnu.org;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=F7+dPjBTRCbhblzblyjO1734E7lUFfjAC/pEeQZUCi8=;
 b=cAJ2lFzNS7V3Thwlv2YKYayY9lhf83BePSZfV2MoCEsIot4GK+w0HnpQXmGU64LeiZ
 wsNReOXXVugXzB/RYLxAYxyrRQi9CBbHrBFj/7RKF+A/FBU9Hlm/ckGyxH73dCbIHmG6
 pgLjjCCEH+HhoNUsrKJQ4K9aOPDjMtL13M9PDOvjJVSoqYcEBfc4eW5a52DSgZrAls++
 B0YJsCb208GFkLdfsC9E3JEV8z9o8DUTJzyl6Qx+5P9ktWoBTQWafyj7Dl1BWGB3fh/l
 q2hPhKCqxMYU/fvcJssb0DVzenbtyFp3mAe7IJoi10sEcTm+og1Ju4Qr6GN2Zh4Oscm1
 hGyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741594813; x=1742199613;
 h=in-reply-to:references:cc:to:from:subject:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=F7+dPjBTRCbhblzblyjO1734E7lUFfjAC/pEeQZUCi8=;
 b=LbLxaUldTOjb+A73dLO770FjvsIJl+92YteilZhp7fIJj/iJFUvYTiQZ5JQ+wTBJO3
 ldRA8Tqnw8fXMUXZR/kZS0n9eFk4vQ/3b14oB2/hfgll9QGwmAZuHucoMjGh3lXqy5pw
 Ndp9sJrVcxEcPaxsFKYL6jP9gs+KJt9YCrNEtwOgaIfHOZwldUUXgP5YDLw/xQwNrpe3
 red2eFyxnKlpUE4OIVv4XgAVdVktMp4U+NCmue3sKG+J7vEwgpGk0Vog+rDpr+tNP/j2
 q2ds5WPixO+e//ptM/i5sJrC3VCYnxWNLX6/ZFVi1qQvBhYDMkyoreS27M/My/omWjZc
 taHQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVp35H1oKAIPyOBoyZXGq0q1QzFl8kjW9un0VzbR/QpxPN5LRpG1TiC0uU2vI5fdUwFc27da6VJc9RX@nongnu.org
X-Gm-Message-State: AOJu0YyPaWg32o9qCrN1ayuMDXVTKmABFaPWvmvn1aKpsPHsXu5sjcB1
 siFNStC+nln8vkJr6Dh2x9+o1Q4udQ0ui+GqmOn+seeG1M8b7n9F
X-Gm-Gg: ASbGncvy7aTt+L3h9yjjntJMKx7ep62zgkYseVyPSyhsQTzu0dIT3Mf1y7EZa0Q4FU3
 nZnPXN981z8hYqqSGGxCtQwQ368ee9jAfsdJCTBcqnR3VNkZuS1FBB1k/HzZEpiVuqJmEV6V0Pd
 gTuWZ9JUe4Uzulua456oWbAMdgxc0QaWCRK9j65Df5IX0EVZcVRo+WhKnKWpqo1TaSPnG8qG9ev
 Z7KxV8yPXQi6dVOUobPXfuL+YRBsH0uPBLd4Dblwkep06T/JKlq941XMyRNODycxkRHNIsfAcF7
 rU8DyKQbijmChxWDXR4dv7MLqHUb0iko+qjXOza0
X-Google-Smtp-Source: AGHT+IEU5yY5vd8BU5gJRxKM/L0k5QDyQyR+QpaYZUJItt58JNvfgK6Zma77e1lR+xluvchpNHMApw==
X-Received: by 2002:a17:90b:1d52:b0:2ff:6f88:b04a with SMTP id
 98e67ed59e1d1-2ff7ce8222emr21587947a91.15.1741594813353; 
 Mon, 10 Mar 2025 01:20:13 -0700 (PDT)
Received: from localhost ([118.208.151.101]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2ff4e75edb2sm10379271a91.4.2025.03.10.01.20.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 10 Mar 2025 01:20:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Mon, 10 Mar 2025 18:20:06 +1000
Message-Id: <D8CFU0Q5U2XG.39DSTTJRN6GBU@gmail.com>
Subject: Re: [PATCH v2 14/14] qtest/xive: Add test of pool interrupts
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "Michael Kowal" <kowal@linux.ibm.com>, <qemu-devel@nongnu.org>
Cc: <qemu-ppc@nongnu.org>, <fbarrat@linux.ibm.com>, <milesg@linux.ibm.com>,
 <danielhb413@gmail.com>, <david@gibson.dropbear.id.au>,
 <harshpb@linux.ibm.com>, <thuth@redhat.com>, <lvivier@redhat.com>,
 <pbonzini@redhat.com>
X-Mailer: aerc 0.19.0
References: <20241210000527.9541-1-kowal@linux.ibm.com>
 <20241210000527.9541-25-kowal@linux.ibm.com>
In-Reply-To: <20241210000527.9541-25-kowal@linux.ibm.com>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102f;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue Dec 10, 2024 at 10:05 AM AEST, Michael Kowal wrote:
> From: Glenn Miles <milesg@linux.ibm.com>
>
> Added new test for pool interrupts.  Removed all printfs from pnv-xive2-*=
 qtests.
>
> Signed-off-by: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>

This looks good. I split the remove-printfs into its own patch.

I would like to see the irq test code merged into one that can
just select CAM rings by argument because it's mostly duplicated.
Should then be able to add an OS ring test with the same code too.
But okay for now.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> ---
>  tests/qtest/pnv-xive2-flush-sync.c |  6 +-
>  tests/qtest/pnv-xive2-nvpg_bar.c   |  7 +--
>  tests/qtest/pnv-xive2-test.c       | 98 +++++++++++++++++++++++++++---
>  3 files changed, 94 insertions(+), 17 deletions(-)
>
> diff --git a/tests/qtest/pnv-xive2-flush-sync.c b/tests/qtest/pnv-xive2-f=
lush-sync.c
> index 3b32446adb..142826bad0 100644
> --- a/tests/qtest/pnv-xive2-flush-sync.c
> +++ b/tests/qtest/pnv-xive2-flush-sync.c
> @@ -178,14 +178,14 @@ void test_flush_sync_inject(QTestState *qts)
>      int test_nr;
>      uint8_t byte;
> =20
> -    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -    printf("# Starting cache flush/queue sync injection tests...\n");
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Starting cache flush/queue sync injection tests...")=
;
> =20
>      for (test_nr =3D 0; test_nr < sizeof(xive_inject_tests);
>           test_nr++) {
>          int op_type =3D xive_inject_tests[test_nr];
> =20
> -        printf("# Running test %d\n", test_nr);
> +        g_test_message("Running test %d", test_nr);
> =20
>          /* start with status byte set to 0 */
>          clr_sync(qts, src_pir, ic_topo_id, op_type);
> diff --git a/tests/qtest/pnv-xive2-nvpg_bar.c b/tests/qtest/pnv-xive2-nvp=
g_bar.c
> index 10d4962d1e..8481a70f22 100644
> --- a/tests/qtest/pnv-xive2-nvpg_bar.c
> +++ b/tests/qtest/pnv-xive2-nvpg_bar.c
> @@ -4,8 +4,7 @@
>   *
>   * Copyright (c) 2024, IBM Corporation.
>   *
> - * This work is licensed under the terms of the GNU GPL, version 2 or
> - * later. See the COPYING file in the top-level directory.
> + * SPDX-License-Identifier: GPL-2.0-or-later
>   */
>  #include "qemu/osdep.h"
>  #include "libqtest.h"
> @@ -78,8 +77,8 @@ void test_nvpg_bar(QTestState *qts)
>      uint32_t count, delta;
>      uint8_t i;
> =20
> -    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -    printf("# Testing NVPG BAR operations\n");
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Testing NVPG BAR operations");
> =20
>      set_nvg(qts, group_target, 0);
>      set_nvp(qts, nvp_target, 0x04);
> diff --git a/tests/qtest/pnv-xive2-test.c b/tests/qtest/pnv-xive2-test.c
> index a0e9f19313..5313d4ef18 100644
> --- a/tests/qtest/pnv-xive2-test.c
> +++ b/tests/qtest/pnv-xive2-test.c
> @@ -4,6 +4,7 @@
>   *  - Test 'Pull Thread Context to Odd Thread Reporting Line'
>   *  - Test irq to hardware group
>   *  - Test irq to hardware group going through backlog
> + *  - Test irq to pool thread
>   *
>   * Copyright (c) 2024, IBM Corporation.
>   *
> @@ -220,8 +221,8 @@ static void test_hw_irq(QTestState *qts)
>      uint16_t reg16;
>      uint8_t pq, nsr, cppr;
> =20
> -    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -    printf("# Testing irq %d to hardware thread %d\n", irq, target_pir);
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Testing irq %d to hardware thread %d", irq, target_p=
ir);
> =20
>      /* irq config */
>      set_eas(qts, irq, end_index, irq_data);
> @@ -266,6 +267,79 @@ static void test_hw_irq(QTestState *qts)
>      g_assert_cmphex(cppr, =3D=3D, 0xFF);
>  }
> =20
> +static void test_pool_irq(QTestState *qts)
> +{
> +    uint32_t irq =3D 2;
> +    uint32_t irq_data =3D 0x600d0d06;
> +    uint32_t end_index =3D 5;
> +    uint32_t target_pir =3D 1;
> +    uint32_t target_nvp =3D 0x100 + target_pir;
> +    uint8_t priority =3D 5;
> +    uint32_t reg32;
> +    uint16_t reg16;
> +    uint8_t pq, nsr, cppr, ipb;
> +
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Testing irq %d to pool thread %d", irq, target_pir);
> +
> +    /* irq config */
> +    set_eas(qts, irq, end_index, irq_data);
> +    set_end(qts, end_index, target_nvp, priority, false /* group */);
> +
> +    /* enable and trigger irq */
> +    get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_SET_PQ_00);
> +    set_esb(qts, irq, XIVE_TRIGGER_PAGE, 0, 0);
> +
> +    /* check irq is raised on cpu */
> +    pq =3D get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
> +    g_assert_cmpuint(pq, =3D=3D, XIVE_ESB_PENDING);
> +
> +    /* check TIMA values in the PHYS ring (shared by POOL ring) */
> +    reg32 =3D get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
> +    nsr =3D reg32 >> 24;
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x40);
> +    g_assert_cmphex(cppr, =3D=3D, 0xFF);
> +
> +    /* check TIMA values in the POOL ring */
> +    reg32 =3D get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD0);
> +    nsr =3D reg32 >> 24;
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    ipb =3D (reg32 >> 8) & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0);
> +    g_assert_cmphex(cppr, =3D=3D, 0);
> +    g_assert_cmphex(ipb, =3D=3D, 0x80 >> priority);
> +
> +    /* ack the irq */
> +    reg16 =3D get_tima16(qts, target_pir, TM_SPC_ACK_HV_REG);
> +    nsr =3D reg16 >> 8;
> +    cppr =3D reg16 & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x40);
> +    g_assert_cmphex(cppr, =3D=3D, priority);
> +
> +    /* check irq data is what was configured */
> +    reg32 =3D qtest_readl(qts, xive_get_queue_addr(end_index));
> +    g_assert_cmphex((reg32 & 0x7fffffff), =3D=3D, (irq_data & 0x7fffffff=
));
> +
> +    /* check IPB is cleared in the POOL ring */
> +    reg32 =3D get_tima32(qts, target_pir, TM_QW2_HV_POOL + TM_WORD0);
> +    ipb =3D (reg32 >> 8) & 0xFF;
> +    g_assert_cmphex(ipb, =3D=3D, 0);
> +
> +    /* End Of Interrupt */
> +    set_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_STORE_EOI, 0);
> +    pq =3D get_esb(qts, irq, XIVE_EOI_PAGE, XIVE_ESB_GET);
> +    g_assert_cmpuint(pq, =3D=3D, XIVE_ESB_RESET);
> +
> +    /* reset CPPR */
> +    set_tima8(qts, target_pir, TM_QW3_HV_PHYS + TM_CPPR, 0xFF);
> +    reg32 =3D get_tima32(qts, target_pir, TM_QW3_HV_PHYS + TM_WORD0);
> +    nsr =3D reg32 >> 24;
> +    cppr =3D (reg32 >> 16) & 0xFF;
> +    g_assert_cmphex(nsr, =3D=3D, 0x00);
> +    g_assert_cmphex(cppr, =3D=3D, 0xFF);
> +}
> +
>  #define XIVE_ODD_CL 0x80
>  static void test_pull_thread_ctx_to_odd_thread_cl(QTestState *qts)
>  {
> @@ -278,8 +352,9 @@ static void test_pull_thread_ctx_to_odd_thread_cl(QTe=
stState *qts)
>      uint32_t cl_word;
>      uint32_t word2;
> =20
> -    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -    printf("# Testing 'Pull Thread Context to Odd Thread Reporting Line'=
\n");
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Testing 'Pull Thread Context to Odd Thread Reporting=
 " \
> +                   "Line'");
> =20
>      /* clear odd cache line prior to pull operation */
>      memset(cl_pair, 0, sizeof(cl_pair));
> @@ -330,8 +405,8 @@ static void test_hw_group_irq(QTestState *qts)
>      uint16_t reg16;
>      uint8_t pq, nsr, cppr;
> =20
> -    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -    printf("# Testing irq %d to hardware group of size 4\n", irq);
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Testing irq %d to hardware group of size 4", irq);
> =20
>      /* irq config */
>      set_eas(qts, irq, end_index, irq_data);
> @@ -395,10 +470,10 @@ static void test_hw_group_irq_backlog(QTestState *q=
ts)
>      uint16_t reg16;
>      uint8_t pq, nsr, cppr, lsmfb, i;
> =20
> -    printf("# =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D\n");
> -    printf("# Testing irq %d to hardware group of size 4 going through "=
 \
> -           "backlog\n",
> -           irq);
> +    g_test_message("=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D");
> +    g_test_message("Testing irq %d to hardware group of size 4 going " \
> +                   "through backlog",
> +                   irq);
> =20
>      /*
>       * set current priority of all threads in the group to something
> @@ -484,6 +559,9 @@ static void test_xive(void)
>      /* omit reset_state here and use settings from test_hw_irq */
>      test_pull_thread_ctx_to_odd_thread_cl(qts);
> =20
> +    reset_state(qts);
> +    test_pool_irq(qts);
> +
>      reset_state(qts);
>      test_hw_group_irq(qts);
> =20


