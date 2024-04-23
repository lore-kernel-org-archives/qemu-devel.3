Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7351DC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Apr 2024 21:08:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rzNMy-0006Va-M4; Tue, 23 Apr 2024 17:08:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzNMa-0006RI-M6; Tue, 23 Apr 2024 17:07:41 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1rzNMY-0006a3-C6; Tue, 23 Apr 2024 17:07:40 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NKRTwO018024; Tue, 23 Apr 2024 21:07:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=from : to : cc : subject
 : date : message-id : mime-version : content-transfer-encoding; s=pp1;
 bh=Ln1rPf08cFA+wzdW+6K1pnQBxCrVei0vWQyo2IkFsmM=;
 b=qctq7s3uM/kqsEmPuzTNOAghf195ymFNdQnWDCyOAKQtSel2NK23ZmEO7eUsTIDoLIbG
 esnSqALeFzvcmOPQ5nzMnud2UgqxRuGCVubC9xrcD1Nhewc0/Oy3r59PWUJI9+UyXwm9
 seM0FNHNMo+yjEl4GZXSw0sbUlZUgBi4Y279vFOXbBxbgkxy4vhslaXbmh5kfTz8bbvx
 v/r+QDwxvpJMONyj5F3+oRa1J4+Y2cRTWOmR+AEpDVGgiwSrDlW6EqU9pb1Yn3XNfjwe
 5iPpFlJrI97hKXWmoivJsZppmZP0s7BLHkFKL+mXyDri3c6Z60fdwiLQpLRx5VrccuqY LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpm1mg38x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:27 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43NL5AUj011102;
 Tue, 23 Apr 2024 21:07:26 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3xpm1mg38u-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:26 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 43NKKoBr023065; Tue, 23 Apr 2024 21:07:25 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3xms1p006k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 23 Apr 2024 21:07:25 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 43NL7M3C36045552
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 23 Apr 2024 21:07:25 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D498F58052;
 Tue, 23 Apr 2024 21:07:22 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 521405805A;
 Tue, 23 Apr 2024 21:07:22 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 23 Apr 2024 21:07:22 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: thuth@redhat.com, david@redhat.com, wangyanan55@huawei.com,
 philmd@linaro.org, marcel.apfelbaum@gmail.com, eduardo@habkost.net,
 armbru@redhat.com, Collin Walling <walling@linux.ibm.com>
Subject: [PATCH v2 0/3] query-cpu-model-expansion: add
 disable-deprecated-feats arg
Date: Tue, 23 Apr 2024 17:06:52 -0400
Message-ID: <20240423210655.66656-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: RhYs_nyUl3QR4XPG1PxG9y3oAwTVc2hJ
X-Proofpoint-ORIG-GUID: tlvlCInA7z0KZkNl8JkxqpLJBS8krw_D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-23_16,2024-04-23_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 mlxlogscore=999
 adultscore=0 priorityscore=1501 impostorscore=0 spamscore=0 bulkscore=0
 lowpriorityscore=0 mlxscore=0 malwarescore=0 phishscore=0 suspectscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2404010000
 definitions=main-2404230053
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

The current implementation of query-cpu-model-expansion is lacking a way to
conditionally retrieve CPU models with properties (i.e. features) that are
flagged as deprecated set to disabled. To remedy this, a new optional boolean
"disable-deprecated-feats" argument has been added to the query.

Here is a sample QMP command that includes this new argument:

    { "execute": "query-cpu-model-expansion", "arguments": { "type": "full", "model": { "name": "host" }, "disable-deprecated-features": true}}

This patchset adds full support for this argument on s390x. A simple interface is
designed that contains an array of feature bits that are flagged for deprecation.
This list may be easily populated with more features in the future.

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

For architectures that support model expansion but do not support the new arg,
an error message will print to stdio if this option is present.

Use case example:

Newer s390 machines may signal the end-of-support for particular CPU features,
rendering guests operating with older CPU models incapable of running on
said machines. A manual effort to disable certain CPU features would be
required.

This feature may alleviate this issue by allowing for a query of a CPU model
with deprecated features listed in the props response paired with false. The
caller of this query may use this information to explicitly disable these
features for the guest's CPU model, ensuring a safe migration to the next
generation if desired.

I have developed a way for libvirt to make use of this functionality, but I
will hold back review on those patches until a QEMU interface is agreed upon.

Collin L. Walling (3):
  cpu-models: add "disable-deprecated-feats" option to cpu model
    expansion
  target/s390x: add support for "disable-deprecated-feats" expansion
    option
  target/s390x: flag te and cte as deprecated

 qapi/machine-target.json         |  7 ++++++-
 target/arm/arm-qmp-cmds.c        |  7 +++++++
 target/i386/cpu-sysemu.c         |  7 +++++++
 target/s390x/cpu_features.c      | 17 +++++++++++++++++
 target/s390x/cpu_features.h      |  1 +
 target/s390x/cpu_models_sysemu.c | 17 ++++++++++++++---
 6 files changed, 52 insertions(+), 4 deletions(-)

-- 
2.43.0


