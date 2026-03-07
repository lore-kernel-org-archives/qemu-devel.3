Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5AFEFC9ECA
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 04:47:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyjYh-0006gI-EO; Fri, 06 Mar 2026 23:46:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYZ-0006bY-Hg
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:27 -0500
Received: from p-west3-cluster5-host11-snip4-1.eps.apple.com ([57.103.72.104]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1vyjYU-0004d1-Vv
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 23:46:24 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPS id
 8B32E18000AF; Sat,  7 Mar 2026 04:46:19 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1772858781; x=1775450781;
 bh=ZTFbv4C7Re38DOrPJX6UN+t/Y0O2Uc5rmvTJb8PU/co=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=E50+o8h8kGTYpXNZVqQLWvK81E8ymrpDz5j3rJN2XNtp+W5CCHsTCdYqwVivCanxjb0tzGESDVpdQ6+ujIMKVQtrbIb6NqfQCF6MZsPqJTDOTOsn0GYf7MjpZ9ThqP/okqOyZhsBF4rE5cxF0Cg1qOFP39yk23edtw28yCXCxCma9UKbcMkHDeA4bdsiCFOiuL7+0IrgRQ4XH+Jd+RPqXA4Ujdaau/4cf5IfVhHAbepgw9uU1aKtbN7mz3m3ZJ+vVOVshJnO697MzjcI56L8i9TJCbvVkiunpJLq65l3HHWm6Hbmy91uHcxW3Nm81H3142nHtsnE2b9CtakoPXmSNQ==
mail-alias-created-date: 1752046281608
Received: from localhost.localdomain (unknown [17.57.154.37])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-4 (Postfix) with ESMTPSA id
 92A581800103; Sat,  7 Mar 2026 04:46:14 +0000 (UTC)
From: Mohamed Mediouni <mohamed@unpredictable.fr>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alexander Graf <agraf@csgraf.de>, qemu-arm@nongnu.org,
 Mads Ynddal <mads@ynddal.dk>, Peter Xu <peterx@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PATCH v6 1/4] system: memory: convert some helpers to const
Date: Sat,  7 Mar 2026 05:46:05 +0100
Message-ID: <20260307044608.25486-2-mohamed@unpredictable.fr>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260307044608.25486-1-mohamed@unpredictable.fr>
References: <20260307044608.25486-1-mohamed@unpredictable.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Authority-Info-Out: v=2.4 cv=aZhsXBot c=1 sm=1 tr=0 ts=69abad9c
 cx=c_apl:c_pps:t_out a=qkKslKyYc0ctBTeLUVfTFg==:117 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=rYw44QAYRiXRCnslA04A:9
X-Proofpoint-GUID: kLT0F4_EFq4RDPt6g7N9--eqI3KHKqtv
X-Proofpoint-ORIG-GUID: kLT0F4_EFq4RDPt6g7N9--eqI3KHKqtv
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzA3MDA0MCBTYWx0ZWRfX9mhVqIC2gtTr
 odY2NBCQu9lxjMxWeJS2LbUWigtMVcq85pUKGdwIcBrGRXn3n3ycBfDwO6eO4hVFucR7Md4NTXn
 gYJa6jA+DrracvH4l/iwSJkzDLDKJ7nqsvkguh3Ms7UK+SyETMWqp9lR8KZKtnRO9iFe8ozjaTv
 YxIvkuIeMzDZIxpE7H0bBDyeUKruDaqhSOlZ/fI+Brki3HxB9XmtTvW4Qv9n7f2/L1Y1/JGpObH
 HPEVHsKLE1fl6vbM7LDeuxDf5des/G1coYAY71KIdVhmlifnM+ZL/ZP34nA2IMiQAg32BoiRNSA
 eQsR8of6a/KUWBuehwfautXE90PLUWLK9Ig+E+Pizj9NizQA2r7+GDTVsw245w=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-07_02,2026-03-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxlogscore=952 phishscore=0
 suspectscore=0 malwarescore=0 clxscore=1030 bulkscore=0 mlxscore=0
 classifier=spam authscore=0 adjust=0 reason=mlx scancount=1
 engine=8.22.0-2601150000 definitions=main-2603070040
X-JNJ: AAAAAAABtgF+RlKqM20iKeAtXWkfCYUg9q5DUbUjsBbxDvKLZdNyZiSDHyC5kMLoHpSn5eOLH4ybB756EqtBGSYw0nG30gtu0mbOdpZaiYCnVFDBR9+nV5LxFTQLlCRP9U73xLXysv3yKYsKGlrMjdfW41LelotX2Z7jpBRy86ebMQogl5v/5ZKhOJXSxxmHetzxdNKtCfRFwzmWczhB4/bqMIYj3ghnjRCLoPn/2sU32KAi+uet6FbOxLz8QupX7P5BCLQ8mZlSacPsSBABms5HRtgbxOgvsA898SomJLKquwGLwfSms9jWsxH3C2s8M5wmGKF5ahTDPzwELinB/O6q0ynVkA782zSO92Di1iYFet/sIHAC14wa3yygDY6sBu6Fk45yQEvB0lUZP2Vq2WVMLsARfHa7DTeUao+OLhfLIXfKRv3L/OkrcNr7A3dwJWxhP1OLmunhDyq8YDUtagc9OA7q8jXBcnmBvUaXGQZoYPxzGfOJhCAgdwykauDoyQOACd0rI2tL0dCR2SCp2FNGwaBZdBqoYA1AtcrauvTtMiq2478BCNslODGypMZMlbl9+/apWHwBmKhs64xDKNBIiXBtIUqwp3upKrTIjMVCNQLBBxA837U/GrrCS7t+PzilhMTfM0SZTxNozNsgwn55WzFQO5w7To4wbXlLWdZjafRuG+/GKd34PUR2gXavZeEuVVzWLkcbiA2xJFmzZF9SBBj4X/Py3t9dl/sQ/ZOOJricqE5DpK1uzXHQmJfBbkwNXv+J/+ikPLICezi7zVL4S8JM8e5FqxIf1+1yM5A8gAcB
Received-SPF: pass client-ip=57.103.72.104;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Seemed to be a better alternative than making flatview_for_each_range pass non-const
pointers.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
---
 include/system/memory.h | 14 +++++++-------
 system/memory.c         |  6 +++---
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/include/system/memory.h b/include/system/memory.h
index 0562af3136..1a140ef203 100644
--- a/include/system/memory.h
+++ b/include/system/memory.h
@@ -1339,7 +1339,7 @@ void memory_region_init(MemoryRegion *mr,
  *
  * @mr: the #MemoryRegion
  */
-void memory_region_ref(MemoryRegion *mr);
+void memory_region_ref(const MemoryRegion *mr);
 
 /**
  * memory_region_unref: Remove 1 to a memory region's reference count
@@ -1765,7 +1765,7 @@ uint64_t memory_region_size(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_ram(MemoryRegion *mr)
+static inline bool memory_region_is_ram(const MemoryRegion *mr)
 {
     return mr->ram;
 }
@@ -1777,7 +1777,7 @@ static inline bool memory_region_is_ram(MemoryRegion *mr)
  *
  * @mr: the memory region being queried
  */
-bool memory_region_is_ram_device(MemoryRegion *mr);
+bool memory_region_is_ram_device(const MemoryRegion *mr);
 
 /**
  * memory_region_is_romd: check whether a memory region is in ROMD mode
@@ -1787,7 +1787,7 @@ bool memory_region_is_ram_device(MemoryRegion *mr);
  *
  * @mr: the memory region being queried
  */
-static inline bool memory_region_is_romd(MemoryRegion *mr)
+static inline bool memory_region_is_romd(const MemoryRegion *mr)
 {
     return mr->rom_device && mr->romd_mode;
 }
@@ -2071,7 +2071,7 @@ MemoryRegion *memory_region_from_host(void *ptr, ram_addr_t *offset);
  *
  * @mr: the memory region being queried.
  */
-void *memory_region_get_ram_ptr(MemoryRegion *mr);
+void *memory_region_get_ram_ptr(const MemoryRegion *mr);
 
 /* memory_region_ram_resize: Resize a RAM region.
  *
@@ -2967,7 +2967,7 @@ void *qemu_map_ram_ptr(RAMBlock *ram_block, ram_addr_t addr);
 int memory_access_size(MemoryRegion *mr, unsigned l, hwaddr addr);
 bool prepare_mmio_access(MemoryRegion *mr);
 
-static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
+static inline bool memory_region_supports_direct_access(const MemoryRegion *mr)
 {
     /* ROM DEVICE regions only allow direct access if in ROMD mode. */
     if (memory_region_is_romd(mr)) {
@@ -2984,7 +2984,7 @@ static inline bool memory_region_supports_direct_access(MemoryRegion *mr)
     return !memory_region_is_ram_device(mr);
 }
 
-static inline bool memory_access_is_direct(MemoryRegion *mr, bool is_write,
+static inline bool memory_access_is_direct(const MemoryRegion *mr, bool is_write,
                                            MemTxAttrs attrs)
 {
     if (!memory_region_supports_direct_access(mr)) {
diff --git a/system/memory.c b/system/memory.c
index c51d0798a8..eb515fbee4 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1825,7 +1825,7 @@ Object *memory_region_owner(MemoryRegion *mr)
     return obj->parent;
 }
 
-void memory_region_ref(MemoryRegion *mr)
+void memory_region_ref(const MemoryRegion *mr)
 {
     /* MMIO callbacks most likely will access data that belongs
      * to the owner, hence the need to ref/unref the owner whenever
@@ -1866,7 +1866,7 @@ const char *memory_region_name(const MemoryRegion *mr)
     return mr->name;
 }
 
-bool memory_region_is_ram_device(MemoryRegion *mr)
+bool memory_region_is_ram_device(const MemoryRegion *mr)
 {
     return mr->ram_device;
 }
@@ -2415,7 +2415,7 @@ int memory_region_get_fd(MemoryRegion *mr)
     return mr->ram_block->fd;
 }
 
-void *memory_region_get_ram_ptr(MemoryRegion *mr)
+void *memory_region_get_ram_ptr(const MemoryRegion *mr)
 {
     uint64_t offset = 0;
 
-- 
2.50.1 (Apple Git-155)


