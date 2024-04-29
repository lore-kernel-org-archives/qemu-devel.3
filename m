Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26AE8C04FFE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Apr 2024 19:12:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1WPs-0004EV-AI; Mon, 29 Apr 2024 15:11:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s1WPU-00047M-Fr; Mon, 29 Apr 2024 15:11:33 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1s1WPS-0004aT-Eh; Mon, 29 Apr 2024 15:11:32 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TJ2SG7025694; Mon, 29 Apr 2024 19:11:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=8rvU3L+SOSQqcnC0NXFvJLw6d5FrsDmjaI0fIUEl2nQ=;
 b=oS3scqVP02TsnFzYx4i4OCBErXhe/CE8QRVawkx+3Zx9k0Xf4QmFkwXevaW2X5nQlQn5
 YvLY1PH423cnNFhTuEZH6CIf4Qiu0/65OpjeNc7aLIiAnEB2Dnot3TWQERDpDan6EWWV
 +Ag088dAaFVjjuDz1Ei0ZKXIJd9FpZ73oA0DFSGsLoAVB2rWx1VdobdWiNRMFPhWiWgQ
 f6H/sYAFjqGBN4oso0dmB4jr+4xGbqy9M1mEMFQKyxz2kseQL6sRAib65z+O2KVmeZKD
 os7hPSuWICFH9ZpNi8Wj9Sv9PFAymbiq4VEgMjDB/fZXdRzqnob9yQKhVdTKgn3vzIJ3 Lw== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xthbtr0sp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 19:11:19 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43TJBJ3P007569;
 Mon, 29 Apr 2024 19:11:19 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xthbtr0sn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 19:11:19 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43TIDRXH003000; Mon, 29 Apr 2024 19:11:17 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xscpp9308-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Apr 2024 19:11:17 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43TJBF4814156322
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Apr 2024 19:11:17 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2446858060;
 Mon, 29 Apr 2024 19:11:15 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8F5CA58056;
 Mon, 29 Apr 2024 19:11:14 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Apr 2024 19:11:14 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v4 0/2] query-cpu-model-expansion: report deprecated features
Date: Mon, 29 Apr 2024 15:10:57 -0400
Message-ID: <20240429191059.11806-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: ulh0Rs1wOeXvnMsh3TgJkoFZcIqPjqFi
X-Proofpoint-GUID: 7OsyLCXpBPZyGZKmGYaqQMHxoDwGBr3R
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-29_16,2024-04-29_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 malwarescore=0 mlxscore=0
 lowpriorityscore=0 mlxlogscore=962 impostorscore=0 bulkscore=0 spamscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2404010000 definitions=main-2404290125
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

Changelog

    v4
        - updated cover letter to show example output
        - deprecated features are now a subset of the full CPU model's
            list of features
            - value: 
                1. no longer listing the deprecated features for CPU
                     models that never had these features available in the
                     first place
                2. deprecated features will not show up for future CPU 
                     models that out-right drop these features
        - updated qapi documentation
            - now reflects that these props are a subset of the full
                model's definition of properties
            - added Since: tag to deprecated-props (assuming 9.1)

    v3
        - removed optional disable-deprecated-feats argument
        - added deprecated-props array to CpuModelInfo struct
        - amended cover letter language to reflect design

    v2 
        - removed "static-recommended" expansion type
        - implemented optional disable-deprecated-feats argument

---

The current implementation of query-cpu-model-expansion is lacking a way to retrieve
CPU models with properties (i.e. features) that are flagged as deprecated.  To remedy
this, a list of deprecated-props has been appended to the CpuModelInfo struct, and
will currently be reported by a query-cpu-model-expansion.  The features reported in
the output are a subset of the full CPU model expansion.

Output example with host-model (z14):

{
  "execute": "query-cpu-model-expansion",
  "arguments": {
    "type": "static",
    "model": {
      "name": "host"
    }
  }
}
{
  "return": {
    "model": {
      "name": "z14.2-base",
      "deprecated-props": [
        "bpb",
        "te",
        "cte",
        "csske"
      ],
      "props": {
        "aen": true,
        "cmmnt": true,
        "aefsi": true,
        "diag318": true,
        "mepoch": true,
        "msa8": true,
        "msa7": true,
        "msa6": true,
        "msa5": true,
        "msa4": true,
        "msa3": true,
        "msa2": true,
        "msa1": true,
        "sthyi": true,
        "edat": true,
        "ri": true,
        "edat2": true,
        "etoken": true,
        "vx": true,
        "ipter": true,
        "mepochptff": true,
        "ap": true,
        "vxeh": true,
        "vxpd": true,
        "esop": true,
        "apqi": true,
        "apft": true,
        "els": true,
        "iep": true,
        "apqci": true,
        "cte": true,
        "ais": true,
        "bpb": true,
        "ctop": true,
        "gs": true,
        "ppa15": true,
        "zpci": true,
        "sea_esop2": true,
        "te": true,
        "cmm": true
      }
    }
  }
}

Example output with an older CPU model:

{
  "execute": "query-cpu-model-expansion",
  "arguments": {
    "type": "static",
    "model": {
      "name": "z10EC"
    }
  }
}
{
  "return": {
    "model": {
      "name": "z10EC-base",
      "deprecated-props": [
        "bpb",
        "csske"
      ],
      "props": {
        "msa2": true,
        "msa1": true,
        "sthyi": true,
        "edat": true,
        "cmm": true
      }
    }
  }
}

A simple interface is designed that contains an array of feature bits that are flagged
as deprecated.  This list may be easily populated with more features in the future.

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
said machines.  A manual effort to disable certain CPU features would be
required.

Reporting a list of deprecated features allows the user / management app to
take the next steps to ensure the guest is defined in a way that ensures
a migration in the future.

Collin L. Walling (2):
  target/s390x: report deprecated-props in cpu-model-expansion reply
  target/s390x: flag te and cte as deprecated

 qapi/machine-target.json         |  7 ++++++-
 target/s390x/cpu_features.c      | 17 +++++++++++++++++
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_models_sysemu.c |  8 ++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)

-- 
2.43.0


