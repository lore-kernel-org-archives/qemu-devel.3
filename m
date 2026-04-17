Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3964F8DFF9
	for <qemu-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:35:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDn2w-0007BO-T8; Fri, 17 Apr 2026 13:32:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2L-0006kC-16
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:30 -0400
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wDn2F-00023T-Rl
 for qemu-devel@nongnu.org; Fri, 17 Apr 2026 13:31:22 -0400
Received: by mail-wm1-x334.google.com with SMTP id
 5b1f17b1804b1-488afb0427eso11675735e9.1
 for <qemu-devel@nongnu.org>; Fri, 17 Apr 2026 10:31:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776447077; x=1777051877; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zwAS7ZT+4GzIr0Ax+jfMns5onR8BsHM96TfH2Ah3gOw=;
 b=Pk/sCSTQWMV8Ubx4sHHac9RGirQNpPqCxE+HVSVHiS/SEmKY6cph9xy8PIO4uLBlHP
 X74i2zpM5kThNHpOBUe5L4SL56inAvM+7jaPXbfZT4F1yGTYl9zKCs0ozK1xPzdWOE8W
 0myznrJi+zspWkn4eiFNLH3rH7tKPg/kWDb7pLZpf3X6n3sfh+NE535qO4chpBPXlTo6
 q5osqA4KMl/BV5T3BGltfzYjHgKyI1+g64Y8A4TGCG2ksxgIWQtqU8hEq3FdI+Q7IVeT
 SN7CLsBSoPABKWtvL9c1Kns2CwPudATycY/RMa4uZ6ArsWJw8uks2CqxIcbreD6DIRh1
 QVLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776447077; x=1777051877;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zwAS7ZT+4GzIr0Ax+jfMns5onR8BsHM96TfH2Ah3gOw=;
 b=VF4Qg8kuvEL/pZ+c9feHFa0VaOKzSCb1PDuHHm5kpMtluMlSn2/y+XgUG044UDX/n9
 i7MgdciAs2snhrAs8HYGcDLA4Oj3aU2WS7TSJIv3InCPJv0XAy27seHyL6Yy5xyRv8bh
 Ro2Gg7ilcKrKZYFbjPP3BRnynYCORM1D+5kltjTFI79a19OkgoQ/0Nmz6eK36mhhpCMo
 M2MkK+Ado/NJNv+dElcVggRfGrn2tyNcY28JIn4pwGGbcF55QK3mUn7O1NIGGckWMvWB
 J+xTruaOxvf7QYHhD/FKtrPSiWwsL0Oa4TDOLo8hIX4+RwQ4AJVU2Qvxynz9slByebvN
 0YVw==
X-Forwarded-Encrypted: i=1;
 AFNElJ8icoDHX7ZWWIHH5Dcw9ENsZCWywsmdzx29iBeb0hKXOoq4VkPKdQEMl3ZmS54yKrI/7iJtbi2HIplM@nongnu.org
X-Gm-Message-State: AOJu0YyNGQw/gUIpH8d6u1CDoInaxLdDA0Vwq2PMTBa5GeZKksh/MYQC
 EP2jNUMqWCLzFu9dMSGtUeQYPlCIZa/L0qDm0xr75PLl1JClpMx7jdTnOqDu0/Rj2GE=
X-Gm-Gg: AeBDiev8PBR6U4PivJxe6IGg9Rf8YhGwHPnF3HLNj/QkKSbN7/mr7qZXql31LVsILBw
 YcjYuRM0wB4apLo3TyhQs8yDTiArGSYA/EdOrYEhv7JM+pqGa1Pl6xBbqSSaWI+HX/zcFFbHJ5P
 I8ZjcQAOSazootD35CO76/PTDnhmEuCSZrl+W4QbnBBTYA40y/T5yCx2spOg2VuNyImywjyyZwM
 s5CPZWfHJDKYUUt/fh5GSSjFgbmZIfWR65AE5FbDVd6H/ucWn8XkMKhJRSOh7X//mYecVmNQXKi
 ex4qftV3oje0GdOwWOPbbJjZoim3uHs0dWgbvRk/Ezm38G0bNsivN4f2LSizUYOFJtsx0TlnYrc
 6xESS4dNaYgzVHzdL16Hky8ZrgxymWm0hmU52FXvsUgZ0AP9M71GAD6La6zBLhjVOe3jYwkKGlb
 7KgNH8EpNx5WZB5VkcDp11OgKsWzvAVAoiVszIDZykYWa2ujzM235hbHl2f5Pi6SRB5mHHAkzRZ
 PbsMn9pTF/A91uK963HjMyJhChjbVwSqpQk4fsx7w==
X-Received: by 2002:a05:600d:8447:b0:487:338:b4f3 with SMTP id
 5b1f17b1804b1-488fb778734mr47380405e9.17.1776447075887; 
 Fri, 17 Apr 2026 10:31:15 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43fe4e4ffa8sm5819650f8f.35.2026.04.17.10.31.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:31:14 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-riscv@nongnu.org, qemu-s390x@nongnu.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, Peter Xu <peterx@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Subject: [PATCH 05/17] target/x86: Make get_phys_page_attrs_debug handle
 non-page-aligned addrs
Date: Fri, 17 Apr 2026 18:30:53 +0100
Message-ID: <20260417173105.1648172-6-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417173105.1648172-1-peter.maydell@linaro.org>
References: <20260417173105.1648172-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::334;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x334.google.com
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

Currently our implementations of SysemuCPUOps::get_phys_page_debug
and SysemuCPUOps::get_phys_page_attrs_debug are a mix of "accepts a
non-page-aligned virtual address and returns the corresponding
non-page-aligned physical address" and "only returns a page-aligned
physical address".  This is awkward for callsites, which in practice
all want the physical address for an arbitrary virtual address and
have to work around the possibility of getting a page-aligned
address, and it doesn't account for protection being possibly on a
sub-page-sized granularity.  We want to standardize on the
implementation having to handle non-page-aligned addresses.

For x86 this is simple: we just need to stop rounding down the
input address to a TARGET_PAGE boundary when calculating the
result to return.

Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 target/i386/helper.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/helper.c b/target/i386/helper.c
index c397a6fde5..108b02396d 100644
--- a/target/i386/helper.c
+++ b/target/i386/helper.c
@@ -372,7 +372,7 @@ hwaddr x86_cpu_get_phys_page_attrs_debug(CPUState *cs, vaddr addr,
 out:
 #endif
     pte &= PG_ADDRESS_MASK & ~(page_size - 1);
-    page_offset = (addr & TARGET_PAGE_MASK) & (page_size - 1);
+    page_offset = addr & (page_size - 1);
     return pte | page_offset;
 }
 
-- 
2.43.0


