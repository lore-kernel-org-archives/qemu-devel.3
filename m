Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6799C88E6E
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Sep 2026 15:34:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x68h9-0000Vu-Qq; Mon, 14 Sep 2026 11:34:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cam@linux.ibm.com>) id 1x67sR-0007tF-UM
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:41:49 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cam@linux.ibm.com>) id 1x67sO-000471-20
 for qemu-devel@nongnu.org; Mon, 14 Sep 2026 10:41:47 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68EEThC42306801; Mon, 14 Sep 2026 14:41:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=pp1; bh=CD4r3HeiBL6fnZLcIeeSeamtU+oO
 4tY5tEoikVpvY88=; b=GL7sVnwVdJxbKXnKic3ydbv8tRZ4tpglo2Dil2hNycgH
 fxTtyBEJh7YO+KExhED2bvgEYpfoEtnw4L440MCLt7fnPktkonCbHOTiDcGYK9Xu
 X1UlC8j/wjWNJ+LBk2oHiWjeUjuCX49K5n5Kd8xfRohzY3PYBs7QfeIoL4zZi+oc
 nSZ8YukCIgis0TS5zdFE0PTbJ3bYMcgQlDFxNdbFNCc4GYuWFOPGad/V2i2sp/zq
 CeP31AyilguYNjjmpV6LMXxuyePkaRQuDdtzw1M/925t3OzTr5oPU1ojgkrnorH0
 twQauZysq7djaaRBJuYa9PPbxtJCRA5xbKMvr26gMg==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmxf4t24f-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 14:41:31 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68ED54rH2298657; Mon, 14 Sep 2026 14:41:30 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gnj2jxkdu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 14 Sep 2026 14:41:30 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68EEfTB612976688
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 14 Sep 2026 14:41:29 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E86BE58056;
 Mon, 14 Sep 2026 14:41:28 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4A96F5803F;
 Mon, 14 Sep 2026 14:41:28 +0000 (GMT)
Received: from localhost.localdomain (unknown [9.61.34.124])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 14 Sep 2026 14:41:28 +0000 (GMT)
From: Cam Miller <cam@linux.ibm.com>
Date: Mon, 14 Sep 2026 10:39:40 -0400
Subject: [PATCH] system/ram-discard-manager: fix
 offset_within_address_space in replay_by_populated_state()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260914-vmem_fix-v1-1-f69ef04a07b0@linux.ibm.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDS0MT3bLc1Nz4tMwK3WQLgxRzU1Nzw8REMyWg8oKiVKAw2Kjo2NpaAIz
 H3cFaAAAA
X-Change-ID: 20260914-vmem_fix-c80d75571aa6
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Peter Xu <peterx@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 David Hildenbrand <david@kernel.org>,
 Boris Fiuczynski <fiuczy@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>, Cam Miller <cam@linux.ibm.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1789396888; l=5156;
 i=cam@linux.ibm.com; s=20260914; h=from:subject:message-id;
 bh=lj/Ha5JigU5FReq0GQMxO5Sgzbq/beZtmQNUNuy4EFI=;
 b=0hgyuiV9rHGMXt3mnXRTtjO183Ue//0ZQohKlZlKzNJrBF52qPaO4EC+bQybrVXHsc9DIrmAN
 98meQZ9sYkiDhPnuR6X4EVjO4/brsUFY8Bb2gPXz7Kav/3kcoqZmXRe
X-Developer-Key: i=cam@linux.ibm.com; a=ed25519;
 pk=hYUWUUTeypJyPcaAD0ddbYHhhzqy5jl7iMQD+G5s4hM=
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Xk59accv-ONPShFQTnvKqqHdPnkhsfmQ
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfX4Y+LvVbUiA2l
 9PNKl+eDqraUjWCxqKdaTzlac5q6s5mJqVRkWnH+bcVBM66LBKQEN/1dNZxXS8cfl2OW0rXk3L5
 ucuiUVFVXM6vHcYDtgTkNBYgom+SqUM=
X-Authority-Analysis: v=2.4 cv=cvgOAF4i c=1 sm=1 tr=0 ts=6aa8079b cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=jn8I2yiD5M9h5jQta8IA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: Xk59accv-ONPShFQTnvKqqHdPnkhsfmQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE0MDIwMSBTYWx0ZWRfXygW8jXXtl4hJ
 bJjL2Zn2ZuyxX7Yv170qw7ByednVlfKk2Fci3sDHGoWjcqyr0aOIYVxFSyfbExpAN3DaCWWQ1Ax
 AJrSpQosDmC/WI6Y1QQk8jWU1TZkYldS2dHGOC/SkD002+BL0puT8nH3frfyLDg0ZHsOVmqeIxm
 Q5qIkYTnH/WFQoI39Sn2PMt4zWzxH387+Tzro21pV+mIpmVfHuiuwQT2l7HYOzFXZ0FIz6ieDuZ
 xWo/YrhyrQU7ACGidamordU72gXcVxctKhR7ouPiC7jh1BnFcQ5Hm1IHdIkRuwhi26dnaiKbdMY
 Wby/Ee+RMSLKWUWW/hC71Dy0m+uRo+FEIYSj2aKVWOrByX4szxkKY9bKD7uhnlld+vHRzt0jMtw
 jLbFU45QNIYfpouldRRHyou78CH0hYVRgETid7QtnD5AyBue2qa//7PFe27MUV7gR7wZokSKbpJ
 HQEIMQgyEgdEuAAajKw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-14_03,2026-09-14_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 lowpriorityscore=0 clxscore=1011 priorityscore=1501
 suspectscore=0 bulkscore=0 impostorscore=0 phishscore=0 spamscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609140201
Received-SPF: pass client-ip=148.163.156.1; envelope-from=cam@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-Mailman-Approved-At: Mon, 14 Sep 2026 11:32:48 -0400
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

Fix bug inside replay_by_populated_state() that forgets to initialize
MemoryRegionSection field offset_within_address_space. Follow the
established pattern of calling memory_region_section_intersect_range()
to accomplish this task.

Prior to commit cc9c77f4ddf0 ("system/memory: implement
RamDiscardManager multi-source aggregation"),
replay_by_populated_state() had called
memory_region_section_intersect_range() in order to initialize
interdependent fields offset_within_address_space, offset_within_region,
and size together, as shown below.

    s->offset_within_address_space += start - s->offset_within_region;
    s->offset_within_region = start;
    s->size = int128_sub(end, int128_make64(start));

cc9c77f4ddf0 reimplements replay_by_populated_state() initializing the
fields of the given MemoryRegionSection instance by hand instead of via
memory_region_section_intersect_range(). In doing so, it leaves
offset_within_address_space uninitialized for some reason, as you can
see below.

    MemoryRegionSection subsection = {
        .mr = section->mr,
        .offset_within_region = offset,
        .size = int128_make64(MIN(granularity, end_offset - offset)),
    };

Consequently offset_within_address_space defaults to GPA 0x0, which is
incorrect. For example, on s390x, base RAM begins at GPA 0x0 and it is
problematic to report that a virtio-iommu MR section lives there
instead.

cc9c77f4ddf0 deliberately calls memory_region_section_intersect_range()
from other related code paths inside the same file, namely
replay_source_by_state() and rdl_populate_cb()/rdl_discard_cb(). It is
unclear why the new replay_by_populated_state() implementation does not
conform to this same pattern.

The effects of the bug include qemu crashes on multiple architectures.
The following assertion failure occurs when driving the
guest_phys_blocks_append() code path, for guests with virtio-mem device
that has some memory plugged.

    DBG: guest_phys_block_add_section: predecessor->target_end=280000000 target_start=0
    **
    ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
    Bail out! ERROR:../system/memory_mapping.c:222:guest_phys_block_add_section: assertion failed: (predecessor->target_end <= target_start)
    2026-09-11 16:03:57.405+0000: shutting down, reason=crashed

This crash can be triggered on x86 via the dump-guest-memory QMP
command. The same crash can be triggered on s390x by restoring VM State
that has been migrated to a local file. (I used libvirt to manage this
migration restore operation, namely command virsh managedsave then virsh
start.) Applying the fix resolved the crash on both platforms.

Fixes: cc9c77f4ddf0 ("system/memory: implement RamDiscardManager multi-source aggregation")
Reported-by: Boris Fiuczynski <fiuczy@linux.ibm.com>
Signed-off-by: Cam Miller <cam@linux.ibm.com>
---
 system/ram-discard-manager.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/system/ram-discard-manager.c b/system/ram-discard-manager.c
index 4e8816e5a2..e9a609e5cd 100644
--- a/system/ram-discard-manager.c
+++ b/system/ram-discard-manager.c
@@ -238,14 +238,15 @@ static int replay_by_populated_state(const RamDiscardManager *rdm,
             }
         } else {
             if (in_run) {
-                MemoryRegionSection run_section = {
-                    .mr = section->mr,
-                    .offset_within_region = run_start,
-                    .size = int128_make64(offset - run_start),
-                };
-                ret = replay_fn(&run_section, user_opaque);
-                if (ret) {
-                    return ret;
+                MemoryRegionSection run_section = *section;
+
+                if (memory_region_section_intersect_range(&run_section,
+                                                          run_start,
+                                                          offset - run_start)) {
+                    ret = replay_fn(&run_section, user_opaque);
+                    if (ret) {
+                        return ret;
+                    }
                 }
                 in_run = false;
             }
@@ -257,12 +258,12 @@ static int replay_by_populated_state(const RamDiscardManager *rdm,
     }
 
     if (in_run) {
-        MemoryRegionSection run_section = {
-            .mr = section->mr,
-            .offset_within_region = run_start,
-            .size = int128_make64(end_offset - run_start),
-        };
-        ret = replay_fn(&run_section, user_opaque);
+        MemoryRegionSection run_section = *section;
+
+        if (memory_region_section_intersect_range(&run_section, run_start,
+                                                  end_offset - run_start)) {
+            ret = replay_fn(&run_section, user_opaque);
+        }
     }
 
     return ret;

---
base-commit: 2242ae1f7bdcf76e78cf8a987118952fc6c9a469
change-id: 20260914-vmem_fix-c80d75571aa6

Best regards,
-- 
Cam Miller <cam@linux.ibm.com>


