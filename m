Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF918C4345F
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Apr 2024 21:57:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzkcK-00086u-S2; Wed, 24 Apr 2024 17:57:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzkcI-00086c-Kh; Wed, 24 Apr 2024 17:57:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzkcG-0003ia-JU; Wed, 24 Apr 2024 17:57:26 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OLkC7Y028001; Wed, 24 Apr 2024 21:57:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : content-transfer-encoding : mime-version; s=pp1;
 bh=uaMPw63nIfu1JfJoaW90reNX4nwtZbK7G4tbPPYh4lw=;
 b=QAjirQxcgkv8zSblxXLNs3jDWopIJAwOSBwN8ZVERx4+GXllp2BQNs0ni+G5tetnsMN4
 HyLHOb23Rpa2JG63K+flV/3ajJxAjq5lyho5Gf4QAHLQ7vTiXtHM1lc1juMu3Nr3X5O5
 YlidsE739HtBobZn9XCLnFHLDLbZZV0MAauqQhHOja4J/zm+lcMHDGKTmY19OOyJCzzB
 4VusYO50E0RAwHaAQ3ePRg2n/YQWEPXIenYXiymBNATmd2LnIvdAHwOtyTFzAiMboPGB
 kX0C2jDhsfFETAwmPx342u1FH9xtnXavIwQonODY/2HgdoGm/XZVGpPgbl3003ZDU5ei GQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqa0jr1qm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 21:57:13 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43OLvDXv011760;
 Wed, 24 Apr 2024 21:57:13 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xqa0jr1qf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 21:57:13 +0000
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43OLLFZh015343; Wed, 24 Apr 2024 21:57:11 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xmshme2vd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 24 Apr 2024 21:57:11 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43OLv8eq16581324
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 24 Apr 2024 21:57:11 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E16175805E;
 Wed, 24 Apr 2024 21:57:08 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5DEDB58056;
 Wed, 24 Apr 2024 21:57:08 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 24 Apr 2024 21:57:08 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v3 0/2] query-cpu-model-expansion: report deprecated features
Date: Wed, 24 Apr 2024 17:56:31 -0400
Message-ID: <20240424215633.48906-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: xZglCcHHLqGwKDfnqJMMpTx6bChedPvM
X-Proofpoint-GUID: a-IbC4bcQTuLOqBxDDujyONoUsVWuHhz
Content-Transfer-Encoding: 8bit
X-Proofpoint-UnRewURL: 0 URL was un-rewritten
MIME-Version: 1.0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-24_19,2024-04-24_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015
 priorityscore=1501 malwarescore=0 bulkscore=0 phishscore=0 suspectscore=0
 lowpriorityscore=0 spamscore=0 adultscore=0 mlxscore=0 impostorscore=0
 mlxlogscore=944 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404240113
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Previous version here (different subject line): 
https://mail.gnu.org/archive/html/qemu-devel/2024-04/msg03200.html

Changelog

    v3
        - removed optional disable-deprecated-feats argument
        - added deprecated-props array to CpuModelInfo struct
        - amended cover letter language to reflect design

    v2 
        - removed "static-recommended" expansion type
        - implemented optional disable-deprecated-feats argument

---

The current implementation of query-cpu-model-expansion is lacking a way to retrieve
CPU models with properties (i.e. features) that are flagged as deprecated. To remedy
this, a list of deprecated-props has been appended to the CpuModelInfo struct, and
will currently be reported by a query-cpu-model-expansion.

Check patch #2 description for an example output.

A simple interface is designed that contains an array of feature bits that are flagged
as deprecated. This list may be easily populated with more features in the future.

    void s390_get_deprecated_features(S390FeatBitmap features)
    {
        static const int feats[] = {
             /* CSSKE is deprecated on newer generations */
             S390_FEAT_CONDITIONAL_SSKE,
             S390_FEAT_BPB,
             /* Deprecated on z16 */
             S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
             S390_FEAT_TRANSACTIONAL_EXE
        };
        int i;

        for (i = 0; i < ARRAY_SIZE(feats); i++) {
            set_bit(feats[i], features);
        }
    }

Use case example:

Newer s390 machines may signal the end-of-support for particular CPU features,
rendering guests operating with older CPU models incapable of running on
said machines. A manual effort to disable certain CPU features would be
required.

Reporting a list of deprecated features allows the user / management app to
take the next steps to ensure the guest is defined in a way that ensures
a migration in the future.

Collin L. Walling (2):
  target/s390x: report deprecated-props in cpu-model-expansion reply
  target/s390x: flag te and cte as deprecated

 qapi/machine-target.json         |  5 ++++-
 target/s390x/cpu_features.c      | 17 +++++++++++++++++
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_models_sysemu.c |  6 ++++++
 4 files changed, 28 insertions(+), 1 deletion(-)

-- 
2.43.0


