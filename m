Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BE41CA5FD4
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Oct 2026 14:27:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xCeCv-0001JQ-8G; Fri, 02 Oct 2026 10:25:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCl-0001DL-0N
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:45 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanb@linux.ibm.com>)
 id 1xCeCh-0001nW-88
 for qemu-devel@nongnu.org; Fri, 02 Oct 2026 10:25:42 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DZWuK673075; Fri, 2 Oct 2026 14:25:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=r2kp70
 5iSlmanjcpoa52cTcw54Vr97ibiWZGUoIXRpg=; b=VPrnF6wKC8d49Bt8+/w/9X
 ppzFhhi0TaWuUERxHUvnyewslZeJQLlCo8rDPav03EJZzxdkXXmttXOz+NE5joTB
 RbB/fzARLTpHC0xgVHYuEKko5Gac+wS/7+8FrtGP5HwFwTPALNESh8iXLTOzSeYG
 yprvOreXhBOUBiSo2o1kaSZWFs5tOeF+ug/I+33jnxyxoDPFrfkeX+R32wf+OPml
 GRhAVcBeRSLNiivfVQ6VLsACbHnOUlzCf0nih1wqTOvYoyNTmhrbPJoayCkbMspf
 zIRuJ1ryRaorfD3CQtcCX3LIxJt2AO0ZSVj/QdVyD7ishHwSAdSkEUDAT6dBGqpQ
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5supj-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:31 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 692DHV961296242; Fri, 2 Oct 2026 14:25:30 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pmjgd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 02 Oct 2026 14:25:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 692EPUxH30474496
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 2 Oct 2026 14:25:30 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 454D05805D;
 Fri,  2 Oct 2026 14:25:30 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AC7A95805A;
 Fri,  2 Oct 2026 14:25:29 +0000 (GMT)
Received: from sbct-3.pok.ibm.com (unknown [9.47.158.153])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Fri,  2 Oct 2026 14:25:29 +0000 (GMT)
From: Stefan Berger <stefanb@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: armenon@redhat.com, marcandre.lureau@gmail.com,
 Stefan Berger <stefanb@linux.ibm.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PATCH v3 06/10] hw/tpm: crb: Do not clear internal buffers when
 backend is busy
Date: Fri,  2 Oct 2026 10:25:12 -0400
Message-ID: <20261002142516.2063735-7-stefanb@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261002142516.2063735-1-stefanb@linux.ibm.com>
References: <20261002142516.2063735-1-stefanb@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfXyPTzcoqNP1mH
 RHOrl2aiRBC/0HTQj8TcNle+1tRnR4ncsCTImlfHjIdgygUr2Jx+JOgt34cRPFueTDklHWxmDhY
 ds9G3Qedm/x3qqYvjwC5d6Zo0tvhJRU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAyMDA1NiBTYWx0ZWRfXx2LcwcKKNrSp
 GKacFipB+jqLdw9SKcApAASDP/s+kb+h+YNi/1Nz1SYXLbYQdoNX/hUY7sjJqDiwry1f22gNBfH
 CgAmhqk9ubRdx/92QF/b2A5OnxB3jNpoQnoC+qJzuSkYGa021O8xncQHU+QrkeiHcT9kDHEf533
 PTWmjjjfIytyK7WfDoRpPBFsCFYtu3fpYBKkiQLihvSoLiSxpKfFP8LBmH+swojQPvqBSGWkCfN
 du2+VRkvTnluOqW6hHSmvSyw9SotC90FqhVCHui8nRyVfOQNFiliSXSFjdYUldHRDqsuO2V0hdE
 wcnfO4xB9N+CaYxR/UJ+TDbnfwMM+vrqeM51zQ5wFl23pxzmt7V9pb+nihsjVKYLC8l1JhC1HI/
 YxASWq8PjsXSgqX23PU2Xa3R7KUdWTPQKnRKnkvaAmgAGt1HQKwK/6Sc3oZHNU+VhiBjnXv6wJ/
 e4Qq1rG/Uvey+n1b3bQ==
X-Proofpoint-GUID: 5RB9i7ASl4RzZlqp_dA9NyEzd2ZyaAWt
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abfbedb cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=20KFwNOVAAAA:8
 a=VnNF1IyMAAAA:8 a=BuBLyuNp-ztxktVGuZUA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: l-RBSxYXUUl19nFU-KiTws-VrOrk8Hs0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_04,2026-10-01_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610020056
Received-SPF: pass client-ip=148.163.156.1; envelope-from=stefanb@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

While the backend (thread) is accessing the request and response buffers,
do not clear those buffers upon a command cancellation. Also, per CRB spec
the TPM is expected to either return a normal command response (command
could not be cancelled) or an error response indicating TPM_RC_CANCELED.
So the response buffer must be able to receive a response as normal.

Fixes: 29315d22b259 ("hw/tpm: Add internal buffer state for chunking")
Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Stefan Berger <stefanb@linux.ibm.com>
---
 hw/tpm/tpm_crb.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/hw/tpm/tpm_crb.c b/hw/tpm/tpm_crb.c
index 54fa2042b5..daf451aa56 100644
--- a/hw/tpm/tpm_crb.c
+++ b/hw/tpm/tpm_crb.c
@@ -219,7 +219,6 @@ static void tpm_crb_mmio_write(void *opaque, hwaddr addr,
             if (s->regs[R_CRB_CTRL_START] & CRB_START_INVOKE) {
                 tpm_backend_cancel_cmd(s->tpmbe);
             }
-            tpm_crb_clear_internal_buffers(s);
         }
         break;
     case A_CRB_CTRL_START:
-- 
2.55.0


