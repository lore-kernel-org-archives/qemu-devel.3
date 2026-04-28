Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87E31FF885D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 09:34:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHepF-0003Sz-AR; Tue, 28 Apr 2026 05:33:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHepB-0003Pv-No
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:49 -0400
Received: from mail-wm1-x333.google.com ([2a00:1450:4864:20::333])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wHepA-0007Rt-1i
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 05:33:49 -0400
Received: by mail-wm1-x333.google.com with SMTP id
 5b1f17b1804b1-488e1a8ac40so137997275e9.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 02:33:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1777368826; x=1777973626; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oIPgICtUT5mEW768v6oe59XIzNRMnfU3f85R7Lwvkp8=;
 b=ChUf3TpwErRjFtnd1jx33aEyljcZ0yBYDyG8DO1dOd0ZY/Uug6HZp49azaogAYwHY6
 19K+KEzSp26z5EdSqOPZC6XTERMUj4BfoDk+cuZcXQtsjOGR8I/OCykY4o090sehHhMW
 Sh8xTqIVMDHO0XUSY9RkbbCTPfbrkXE2Fd3RUcDxtkYHlRJtjZZtUn/Y36kAyP3bh0+d
 l+3h35Xgi1EBg7ci+0Pvoya1NOKtzSelumfK3E/MoPjFvBldo+diOlUvbo+CWXU+JqsW
 rAiTryuNySaTGUdE8bWzONIlR2XpGPBqss7UFts+nBGMp8vGxZPSzws3lTPdmataOxIX
 +jIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777368826; x=1777973626;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=oIPgICtUT5mEW768v6oe59XIzNRMnfU3f85R7Lwvkp8=;
 b=DeC0F/4Sn+0rYmz1bmGy58VDcInEhLdO4XPtmlxuG6asx7g7lkqwsG4k7pZ71NKJR7
 iDww7FgPbxpdmjZKuRX7s3BAre5YsiBqyBSox4YtI9PbUSxooNU+LmJiExFXXsjqmQfG
 jJGfMU3DW9m9m7loK2ls2zMIoX7qrPd5W+Chr/ffbGFnsxbtSve6WLxP7AuBxNnwxX4h
 Yjgxui7+VITPlSZ4momkbP71PeaMJJzVky9ax7IjxwV9pBJTJnOVIzj5A/YLIzFBuZlS
 K9xRry8zH2HchxmVPvRu33vgIUogGTJ3jC4568tVciVFSlsMGAI09XBwSFOhoXmiESF6
 ya7w==
X-Gm-Message-State: AOJu0YwER50P2s84M2zRiMBB3dsQrXO+NQBZOUwFyM/T+O3GkF4YzIAJ
 xNP2KS/hCOHR7DyHPqDbNj/ciQS4yhubZsrKPerjFYiVMi0VgG8/UNKx4kK6IkNouN5KrzdDe+d
 yLSYI
X-Gm-Gg: AeBDievJxCtZVJdjiSph3uECxozMjdgalDznE0tsPB25OQH/cQTVdjnoxA13PxhF1C8
 uLQG2Bx53xgxJHW7urnPqi6m/Ox7egrNwSduWjuBR9CusDbYRYoUFpt0AnPpJKQMrvMzlLkLWMT
 1tBkgl1FZB9/AlVwfFsG7laYCijrpSaP1WoMVxjh71QFyURer+R8acrkR0t/nsZL6gQ9meQa+Sn
 SBYcmp3ATzxuL6vggGH+JAiVCdLUFNsTWWE3vC7jfWdQwypJD56S7HrI5I+Mr/gPyXd0bHtOQmd
 7bod6wOzCJDDz5semC162bjJCW7bPXQr2hGke3D7up+ZBa5eHCyyKdbANNw13aLlR1U17dBSPHc
 0Tn3uMLASwyS2FhZ0SkD/1nsG3Bdz81W0a2klB1JRDOaA5AsfrU89SQWoRoMe5N1RP9WSEltdD3
 UAt3GVK9exN47eZfhzXr29p0kak5WdWhEcUQOBAF9HBBWXgWuY/OsuPX/2c3MS58wruZCu+AciE
 Du9uqrJ0HNtgZW5PHfXnEsK5cc8Jl2xKLmDn4rSAQ==
X-Received: by 2002:a05:600c:a013:b0:48a:563c:c8e0 with SMTP id
 5b1f17b1804b1-48a77ad5a89mr38930575e9.1.1777368826507; 
 Tue, 28 Apr 2026 02:33:46 -0700 (PDT)
Received: from lanath.. (wildly.archaic.org.uk. [81.2.115.145])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a774d7a1fsm19665595e9.4.2026.04.28.02.33.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Apr 2026 02:33:45 -0700 (PDT)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-devel@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <daniel.barboza@oss.qualcomm.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Chao Liu <chao.liu.zevorn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Max Filippov <jcmvbkbc@gmail.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-riscv@nongnu.org, qemu-arm@nongnu.org
Subject: [PATCH 4/4] system/memory: assert on invalid MemoryRegionOps
 .unaligned combo
Date: Tue, 28 Apr 2026 10:33:39 +0100
Message-ID: <20260428093339.2087081-5-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260428093339.2087081-1-peter.maydell@linaro.org>
References: <20260428093339.2087081-1-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::333;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x333.google.com
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

From: CJ Chen <cjchen@igel.co.jp>

When it comes to this pattern: .valid.unaligned = false and
impl.unaligned = true, is effectlvely contradictory. The .valid
structure indicates that unaligned access should be rejected at
the access validation phase, yet .impl suggests the underlying
device implementation can handle unaligned operations. As a result,
the upper-layer code will never even reach the .impl logic.

Add an assertion that the MemoryRegionOps doesn't specify
this invalid combination.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Suggested-by: Peter Xu <peterx@redhat.com>
Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: tweaked commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
---
 system/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/memory.c b/system/memory.c
index 225bbe38c3..739ba11da6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1573,6 +1573,7 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
                            const MemoryRegionOps *ops, void *opaque,
                            const char *name, uint64_t size)
 {
+    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
 }
-- 
2.43.0


