Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 351B9C87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 14:40:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhqnb-0007Qh-Lu; Fri, 01 Aug 2025 10:31:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4308a69be5=kbusch@meta.com>)
 id 1uhqhO-0005RO-HN
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:32 -0400
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <prvs=4308a69be5=kbusch@meta.com>)
 id 1uhqhK-0002es-0l
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 10:25:29 -0400
Received: from pps.filterd (m0044010.ppops.net [127.0.0.1])
 by mx0a-00082601.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 571E5Fjf015646
 for <qemu-devel@nongnu.org>; Fri, 1 Aug 2025 07:25:15 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=s2048-2025-q2; bh=3K1rEKbK4jOcJhrePD
 PVRMUiu8CTHWSOt03oR9yd6jQ=; b=azeUtV0souXp0U/YoPdoGvaMiUDHDgTFfH
 8G7QbvPb0tKeDh1hX/ASC3fajOAd9vMDqJjWcYTEMNjyqLByFxnWiFresquMucV0
 qcexATT7QcLJ4SmV9zVsLYKpZYqkTTBPDKuIldkhAvnYT9lv69d0Cobd/pL7LPwq
 bvB8byfLe9oP73SpoRzyM4bzroBooNkWc+tf3BAYVjCBYkedEX3Q4t9RrM9AO6gB
 d+Tsp1SgcL8nCnYvb9taME+NmT1GsyhW9uUM34URS7TFyi7VKj8bwVv26FaGkkdB
 pmsfc09gAeByBqnjXcqPVq566NSWp9nffgtDjYAoZCHU2dkc1usQ==
Received: from mail.thefacebook.com ([163.114.134.16])
 by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 488rk2j4u5-3
 (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 07:25:15 -0700 (PDT)
Received: from twshared52133.15.frc2.facebook.com (2620:10d:c085:208::7cb7) by
 mail.thefacebook.com (2620:10d:c08b:78::c78f) with Microsoft SMTP
 Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.17; Fri, 1 Aug 2025 14:25:14 +0000
Received: by devbig197.nha3.facebook.com (Postfix, from userid 544533)
 id EDF3C2D1491; Fri,  1 Aug 2025 07:24:59 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <qemu-devel@nongnu.org>, <its@irrelevant.dk>, <qemu-block@nongnu.org>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH] hw/nvme: cap MDTS value for internal limitation
Date: Fri, 1 Aug 2025 07:24:57 -0700
Message-ID: <20250801142457.3012213-1-kbusch@meta.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Authority-Analysis: v=2.4 cv=cfLSrmDM c=1 sm=1 tr=0 ts=688cce4b cx=c_pps
 a=CB4LiSf2rd0gKozIdrpkBw==:117 a=CB4LiSf2rd0gKozIdrpkBw==:17
 a=2OwXVqhp2XgA:10 a=VwQbUJbxAAAA:8 a=byK5x53OG_9qB8zXzpQA:9
X-Proofpoint-ORIG-GUID: ZnkIsau4PpdldGX9lOTYZJNBEBp9D1eQ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwODAxMDEwOSBTYWx0ZWRfX4vm3ECwM92oe
 fYteg48qcrqcHoyX/215TqClJ3VlUcmrmYBbv+FQtqPpjqBhU65uwa9N42YrRyxqZaDh+GQBmf0
 xR1/Qj9y2jiZOpCosCgXNHUCu7FgVkvx+UK/otZKLF0q5o8ylcU5paxInhnvZz9DrvBFEs6o0SA
 1uV23f9MAg4exURxmPpaj3CzPVdaOL1w/manCdUiRSW8eTyOJFeIQcsZ6gjwb6dFSMk5wD4SJWo
 WKgUh063P0R4DbdXHZiw+VtIU8XX5a8BE7U4lcE5W60Iv6fU2dLfQu+iL+BGr170MqrGeSBWAWT
 uQWXLNUhjjMZcIVywMj1G2CWPmPwk3NlMTc8T0MUy3cvse38W1cMAkDHsHgFBJdmBlKmy9c1mdc
 DbGhaYp8oP4/TbaIgQzzgMU25ZmnWonZrEftzRgJx7BkOoqw5nrq6KJr75ZXZcrDQoYYJmzm
X-Proofpoint-GUID: ZnkIsau4PpdldGX9lOTYZJNBEBp9D1eQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-01_04,2025-08-01_01,2025-03-28_01
Received-SPF: pass client-ip=67.231.145.42;
 envelope-from=prvs=4308a69be5=kbusch@meta.com; helo=mx0a-00082601.pphosted.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Keith Busch <kbusch@kernel.org>

The emulated device had let the user set whatever max transfers size
they wanted, including no limit. However the device does have an
internal limit of 1024 segments. NVMe doesn't report max segments,
though. This is implicitly inferred based on the MDTS and MPSMIN values.

IOV_MAX is currently 1024 which 4k PRPs can exceed with 2MB transfers.
Don't allow MDTS values that can exceed this, otherwise users risk
seeing "internal error" status to their otherwise protocol compliant
commands.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 hw/nvme/ctrl.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/hw/nvme/ctrl.c b/hw/nvme/ctrl.c
index e764ec7683..5bfb773b5a 100644
--- a/hw/nvme/ctrl.c
+++ b/hw/nvme/ctrl.c
@@ -8335,6 +8335,11 @@ static bool nvme_check_params(NvmeCtrl *n, Error *=
*errp)
         host_memory_backend_set_mapped(n->pmr.dev, true);
     }
=20
+    if (!n->params.mdts || ((1 << n->params.mdts) + 1) > IOV_MAX) {
+        error_setg(errp, "mdts exceeds IOV_MAX");
+        return false;
+    }
+
     if (n->params.zasl > n->params.mdts) {
         error_setg(errp, "zoned.zasl (Zone Append Size Limit) must be le=
ss "
                    "than or equal to mdts (Maximum Data Transfer Size)")=
;
--=20
2.47.3


