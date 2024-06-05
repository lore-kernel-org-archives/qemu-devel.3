Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F79CC41513
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Jun 2024 11:27:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sEon9-0005Vm-3p; Wed, 05 Jun 2024 07:26:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEon6-0005VV-Ub
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:53 -0400
Received: from mail-lf1-x132.google.com ([2a00:1450:4864:20::132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <phil@philjordan.eu>)
 id 1sEon5-0003MQ-D7
 for qemu-devel@nongnu.org; Wed, 05 Jun 2024 07:26:52 -0400
Received: by mail-lf1-x132.google.com with SMTP id
 2adb3069b0e04-52b7ffd9f6eso6721566e87.3
 for <qemu-devel@nongnu.org>; Wed, 05 Jun 2024 04:26:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=philjordan-eu.20230601.gappssmtp.com; s=20230601; t=1717586810; x=1718191610;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MUadvBu0a4VCVhDucQlZlHVU1F0bWouqcdkwO50PULs=;
 b=hJcui3DVXnwen+GMCbf/k/my8D9PNmHjRwkKFgjN9rVWkoDLpgaPX1TvqI/zHt8evl
 IO1F5RZ+WGRKHHRWeetz0S4e+pYWBJW1vmhFHWikTr35vMTzY0dKD6c7MHMOgSiiP4Xm
 BKBPS74cIMK9OAnpHYjpEiwZoWODNYR1yYZTEFkDmuoeGYMLE1FV2d3vyJ+bcZ4FwYU+
 STytIDOn66Wm5VQQ7Hwilj8l4GgRyYrAqVnAU/1B/94HnkqLBYu+TfPl+R8z8Y+myfGl
 XhTX17aBBr+zaXWNXdnYjBNK5bKvlhs3maAZCYscV7QWQFNhSEivMw8ptwUYZ4+9xqzW
 w5/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1717586810; x=1718191610;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MUadvBu0a4VCVhDucQlZlHVU1F0bWouqcdkwO50PULs=;
 b=kuwz/PUb/KNrgrNQsrxTtRvNqu9KTAx8xVrwExrXmz7sTm/DrRCKY7R8ohfJ3Pnm8+
 JylBdhgPAbC3QZxNkkjUWMmdWhawhKsiBIarPIiKMaLrAiH9J+0TwGzSPN4x3ekiIaAe
 fI84qM43ckd6BAKcRZtngHvP2o8azc28/418HHFGYzL54R5bDVS8wMYFuy2RninrCYZc
 ltNtG5wgFAZY7M07L5GlzIxF7039bA+o7oTnWPEquhI7Qrm4Sg/wXVRjq49YVHfRHf6r
 omPIB9sZqp/5Ibo7Pq905JtYOC7MFH+0AGkk9BapT1g+D+QpWIKn0/VZ4V3c5F0ltw44
 WS3A==
X-Gm-Message-State: AOJu0YxMomf+Gzhi39QUg72zvEIbVHg2ARIP63wOxGR0JE5/UZQNiQeC
 ZINh4XhF5gJoIQPMRUtCrIoo1RFq+yLgfz+Hg9S6Ijd4/yVZDBe6vaXwyhR75+OnFAB+EED/3Sk
 =
X-Google-Smtp-Source: AGHT+IE2yxdv84exD7e0ulqEMKBK5XcEodr0VMamdUn/fuYbTCsBTzwMjHnrW1qhnm6kSzoqmdQIpQ==
X-Received: by 2002:ac2:46c4:0:b0:520:5261:9cd0 with SMTP id
 2adb3069b0e04-52bab4f9084mr1314803e87.57.1717586809737; 
 Wed, 05 Jun 2024 04:26:49 -0700 (PDT)
Received: from localhost.localdomain (89-104-8-249.customer.bnet.at.
 [89.104.8.249]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-57a51023af4sm7111335a12.29.2024.06.05.04.26.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Jun 2024 04:26:49 -0700 (PDT)
From: Phil Dennis-Jordan <phil@philjordan.eu>
To: qemu-devel@nongnu.org
Cc: dirty@apple.com, rbolshakov@ddn.com, lists@philjordan.eu,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Roman Bolshakov <roman@roolebo.dev>
Subject: [PATCH v3 4/7] i386/hvf: Fixes dirty memory tracking by page
 granularity RX->RWX change
Date: Wed,  5 Jun 2024 13:25:53 +0200
Message-Id: <20240605112556.43193-5-phil@philjordan.eu>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20240605112556.43193-1-phil@philjordan.eu>
References: <20240605112556.43193-1-phil@philjordan.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: neutral client-ip=2a00:1450:4864:20::132;
 envelope-from=phil@philjordan.eu; helo=mail-lf1-x132.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NEUTRAL=0.779, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

When using x86 macOS Hypervisor.framework as accelerator, detection of
dirty memory regions is implemented by marking logged memory region
slots as read-only in the EPT, then setting the dirty flag when a
guest write causes a fault. The area marked dirty should then be marked
writable in order for subsequent writes to succeed without a VM exit.

However, dirty bits are tracked on a per-page basis, whereas the fault
handler was marking the whole logged memory region as writable. This
change fixes the fault handler so only the protection of the single
faulting page is marked as dirty.

(Note: the dirty page tracking appeared to work despite this error
because HVF’s hv_vcpu_run() function generated unnecessary EPT fault
exits, which ended up causing the dirty marking handler to run even
when the memory region had been marked RW. When using
hv_vcpu_run_until(), a change planned for a subsequent commit, these
spurious exits no longer occur, so dirty memory tracking malfunctions.)

Additionally, the dirty page is set to permit code execution, the same
as all other guest memory; changing memory protection from RX to RW not
RWX appears to have been an oversight.

Signed-off-by: Phil Dennis-Jordan <phil@philjordan.eu>
Reviewed-by: Roman Bolshakov <roman@roolebo.dev>
Tested-by: Roman Bolshakov <roman@roolebo.dev>
---
 target/i386/hvf/hvf.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/target/i386/hvf/hvf.c b/target/i386/hvf/hvf.c
index e6e916225b..268c5734d5 100644
--- a/target/i386/hvf/hvf.c
+++ b/target/i386/hvf/hvf.c
@@ -135,9 +135,10 @@ static bool ept_emulation_fault(hvf_slot *slot, uint64_t gpa, uint64_t ept_qual)
 
     if (write && slot) {
         if (slot->flags & HVF_SLOT_LOG) {
+            uint64_t dirty_page_start = gpa & ~(TARGET_PAGE_SIZE - 1u);
             memory_region_set_dirty(slot->region, gpa - slot->start, 1);
-            hv_vm_protect((hv_gpaddr_t)slot->start, (size_t)slot->size,
-                          HV_MEMORY_READ | HV_MEMORY_WRITE);
+            hv_vm_protect(dirty_page_start, TARGET_PAGE_SIZE,
+                          HV_MEMORY_READ | HV_MEMORY_WRITE | HV_MEMORY_EXEC);
         }
     }
 
-- 
2.36.1


