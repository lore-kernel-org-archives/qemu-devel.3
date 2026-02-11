Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AF1DEA3F27
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Feb 2026 15:45:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqCP8-0005hV-SH; Wed, 11 Feb 2026 10:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richie@linux.ibm.com>)
 id 1vqCP7-0005hM-Ii
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:45:25 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richie@linux.ibm.com>)
 id 1vqCP5-00021Z-Ka
 for qemu-devel@nongnu.org; Wed, 11 Feb 2026 10:45:25 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 61BBxPPu3145172; Wed, 11 Feb 2026 15:45:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=k4DueH5MERMADcv8bkqciwdD8JujQM81biD3ngoE/
 s4=; b=bULdNKRaD4rG/pRl1WlBsZHI/+9LopY15sD/OuAjzyBdWvnVgMPeYOFqg
 YFSWmyK5u3UCxVHrTMvMzeaLG6l7+hXQAttWn+dPyetBEjbGKGgHYkcxzW0NaUV9
 y29MyfPWtNUO4U8Jw4SdO1zPdg22zlt4GHh86iTz1R0B94hGCxrXLoLCVts19nZp
 eqbph46t4GxXauWjDnxSchT75evakbPRPdXF4eL+IR8DfcDETl1TvvVGMQDkxer7
 P+Q+XN5uekrP9sA9+ZZ7dNcdmnOLLJW7u7bqR1fH0gjoxNDqfZVFi5H+phCWlXTj
 qnizWeF4XpoIQ1Bw2/h6J2HIOHkJg==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c696v7ake-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Feb 2026 15:45:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 61BF5mgc019225;
 Wed, 11 Feb 2026 15:45:09 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c6hxk673p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Feb 2026 15:45:09 +0000
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 61BFj7w427918896
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Feb 2026 15:45:07 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 96D282004B;
 Wed, 11 Feb 2026 15:45:07 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7537D20040;
 Wed, 11 Feb 2026 15:45:07 +0000 (GMT)
Received: from t35lp33.lnxne.boe (unknown [9.87.84.240])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Feb 2026 15:45:07 +0000 (GMT)
From: Richie Buturla <richie@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: groug@kaod.org, qemu_oss@crudebyte.com
Subject: [PATCH] hw/9pfs: fix data race in v9fs_mark_fids_unreclaim()
Date: Wed, 11 Feb 2026 16:44:50 +0100
Message-ID: <20260211154450.254338-1-richie@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: OeQVBY1u-OXYJTORQZe9BdpFlONVYknn
X-Proofpoint-ORIG-GUID: OeQVBY1u-OXYJTORQZe9BdpFlONVYknn
X-Authority-Analysis: v=2.4 cv=JdWxbEKV c=1 sm=1 tr=0 ts=698ca406 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22 a=Mpw57Om8IfrbqaoTuvik:22
 a=GgsMoib0sEa3-_RKJdDe:22 a=p0WdMEafAAAA:8 a=VnNF1IyMAAAA:8
 a=weyarag8D_LuGCx9tH8A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjExMDExOCBTYWx0ZWRfX3BYdtwRguRPy
 u/JuCD1SoikGh9Qod7/lYqLkMlmQm2usuguho2Uy+QNNUTNb7DLNWf6flf5OAP3Edw1H+LBxTSN
 mCEXoy0HTId4quIAbPEjmoIe4Nnx4PUmJB6Y4gYMUrq2VzeVy5xdSNjPmsK+2Ap+/qoeGr/bEkr
 TDNZ1pWYBtSmRqZqsZy77iqAraG1oJ09ydGUqC43+mki9WN8IIRYA1PlNCm/s0TgEejLocC/ZSH
 jdliBzeMi+8mMkzaSwU73s9goHrWgiOMjhqtCrSfwqHObYjIoenbYf57gL128lCmL3VkeqJkpaa
 gcmpptGtjLD02GZZNNgRJ2Ik3E70cOyNOFZYYvUjc8YwvJbT9JbOLMLCrk+lzqeSXJPADNILTvq
 ygZrGiTIIYBixJCgyzWZAs7aknLvuEXgQ7WG8CRUM/Y+ubXVqGaHY98ff+071iP68zisnvK+a4J
 AIeL3T1PZ8wKOqxpjpQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-11_02,2026-02-11_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 clxscore=1011 impostorscore=0 bulkscore=0
 lowpriorityscore=0 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2601150000
 definitions=main-2602110118
Received-SPF: pass client-ip=148.163.158.5; envelope-from=richie@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

A data race between v9fs_mark_fids_unreclaim() and v9fs_path_copy()
causes an inconsistent read of fidp->path. In v9fs_path_copy(), the
path size is set before the data pointer is allocated, creating a
window where size is non-zero but data is NULL.

v9fs_co_open2() holds a write lock during path modifications,
but v9fs_mark_fids_unreclaim() was not acquiring a read
lock, allowing it to race.

Fix by holding the path read lock during FID table iteration.

Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3300
Signed-off-by: Richie Buturla <richie@linux.ibm.com>
---
 hw/9pfs/9p.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/hw/9pfs/9p.c b/hw/9pfs/9p.c
index 6fbe604ce8..02366f43a8 100644
--- a/hw/9pfs/9p.c
+++ b/hw/9pfs/9p.c
@@ -560,6 +560,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             sizeof(V9fsFidState *), 1);
     gint i;

+    v9fs_path_read_lock(s);
     g_hash_table_iter_init(&iter, s->fids);

     /*
@@ -580,6 +581,7 @@ static int coroutine_fn v9fs_mark_fids_unreclaim(V9fsPDU *pdu, V9fsPath *path)
             g_array_append_val(to_reopen, fidp);
         }
     }
+    v9fs_path_unlock(s);

     for (i = 0; i < to_reopen->len; i++) {
         fidp = g_array_index(to_reopen, V9fsFidState*, i);
--
2.51.0


