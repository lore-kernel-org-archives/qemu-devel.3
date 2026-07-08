Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 119CEC43458
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jul 2026 20:23:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1whYmp-0006J0-O5; Wed, 08 Jul 2026 16:22:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1whYmo-0006Ii-9y; Wed, 08 Jul 2026 16:22:26 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1whYmm-0005y8-AA; Wed, 08 Jul 2026 16:22:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 668KIPX94097036; Wed, 8 Jul 2026 20:22:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=vBN1KZ1XJJo3fHGWkABpafMoFJFwuU3a59vbxOcu4
 9o=; b=USUiMi1xZ+Zf/B/8/6eoYIyYf4AIG5OWca8PYqZFiuhC2heksB/bumJOl
 PpQmm4QCBYurVZfj/3zZ5vd4lj9AJFRtRpQsr+umO3BIVP0JU1/tbOGAQjtqDkbx
 USKa2BoIoDO1Q7jyTR2alJ0ll9M7/0PBYENalIDx3reT8Odj8stAQ3I94Ccv1Q17
 U/7i06W2J2LdP622tDxyUvOXnABI5SJei6od+dQxA/CZ7A82YIXwc+8xOhRPfLTk
 YDjuQIEovYpyGtxUf1VCM740zFWGi7iZtZT4JIXXznJqvdt2xTzjPNYHprNogZGF
 pdhVmatIk4UZBAOxNlNZe6nMEEZCA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4x8ta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 20:22:17 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 668KJcZF023213;
 Wed, 8 Jul 2026 20:22:11 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqg9kbu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 08 Jul 2026 20:22:11 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 668KLaQW30540386
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 8 Jul 2026 20:21:36 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1AEC058059;
 Wed,  8 Jul 2026 20:22:10 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 44FB25805D;
 Wed,  8 Jul 2026 20:22:09 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.pok.ibm.com (unknown
 [9.12.68.85]) by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  8 Jul 2026 20:22:09 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-s390x@nongnu.org, qemu-devel@nongnu.org
Cc: mjrosato@linux.ibm.com, farman@linux.ibm.com, cohuck@redhat.com,
 david@kernel.org, iii@linux.ibm.com, richard.henderson@linaro.org
Subject: [PATCH] target/s390x: query-cpu-definitions filter deprecated features
Date: Wed,  8 Jul 2026 16:21:49 -0400
Message-ID: <20260708202149.103063-1-walling@linux.ibm.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SZLRLH_-KKt_hz5DhWCTe42qU3TyH6Nr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA4MDE5OSBTYWx0ZWRfX5mrG4cRjasQ7
 DI1e9MF1TDM9+WMjrhq9ST36zRIpwviLLqubZjCjqRqtFqaviE5stjbQuSAY4DBYj8ZS8AuY3Z2
 KOQcfM2RBVQA6lOtievidyCxqxWQVDlh7kCJWXrwhqKZGqQj4nDAT2n4gHGs/an7h3duD5bn2Vj
 ZZq+e7nsFR3b+bAAvGCu/YMgbVed/Bu8n8ispE+Q7XlNMOR6mqN9A33LWaQd3dipote1R9mFmX3
 cXDRRKjld03BxlofpYCbNndnTemPQGYTMqAOVV89Gd5RgmG4e9b3xQbbAUwJxjQ/0tUJ1D+jnRx
 e3pu4YOJnJBjMVKwuemqCb9Q8ZVkWQbk0+JTBTNUkrgibzoaosHlERwdIsywBQbxCWM6WFmSCOQ
 QgsQYJ2PL15igyHIGGnX/Dvm7r5ohiYamN5Jj1I3F4hhvIeh21G/v4WOgtMyhiQNnHJJB8HPEfm
 7HlqePOjtHlAENjUnTg==
X-Proofpoint-ORIG-GUID: SZLRLH_-KKt_hz5DhWCTe42qU3TyH6Nr
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4eb179 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=uQ6BdIDjWomqmLFhcD0A:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA4MDE5OSBTYWx0ZWRfX0V7HlETNYYhp
 ZKI4nu/tfcrm1hHRfywOIZZvwNS9DwPkq+qnj10BNaBn3xU/kJrjsG7GTwcgL7D/nezqbXUYA2Z
 U9PiLoM2sNFdTbXkJHTD8cTbNRz8XfM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-08_04,2026-07-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607080199
Received-SPF: pass client-ip=148.163.156.1; envelope-from=walling@linux.ibm.com;
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

Part of the query-cpu-definitions return payload includes an array of
of "unavailable-features" which helps determine if the CPU model is
compatible with the system's configuration.  When a KVM guest is
using a CPU model with deprecated features disabled,
query-cpu-definitions will claim that certain models are incompatible
due to these features missing.

Since deprecated features are preferred to be disabled for s390 CPU
models, lets filter them out from the "missing" features list.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
---

Examples output of query-cpu-definitions ran on a gen17a host:

WithOUT patch:

```
{
  "return": [
    {
      "name": "z13",
      "typename": "z13-s390x-cpu",
      "unavailable-features": [
        "csske"
      ],
      "static": false,
      "migration-safe": true,
      "deprecated": false
    },
    ...
```

WITH patch:

```
{
  "return": [
    {
      "name": "z13",
      "typename": "z13-s390x-cpu",
      "unavailable-features": [],
      "static": false,
      "migration-safe": true,
      "deprecated": false
    },
    ...
```

---

 target/s390x/cpu_models_system.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/target/s390x/cpu_models_system.c b/target/s390x/cpu_models_system.c
index 5b846048675..f2f6b00b547 100644
--- a/target/s390x/cpu_models_system.c
+++ b/target/s390x/cpu_models_system.c
@@ -28,6 +28,7 @@ static void check_unavailable_features(const S390CPUModel *max_model,
                                        strList **unavailable)
 {
     S390FeatBitmap missing;
+    S390FeatBitmap deprecated_feats;
 
     /* check general model compatibility */
     if (max_model->def->gen < model->def->gen ||
@@ -39,6 +40,13 @@ static void check_unavailable_features(const S390CPUModel *max_model,
     /* detect missing features if any to properly report them */
     bitmap_andnot(missing, model->features, max_model->features,
                   S390_FEAT_MAX);
+
+    /* deprecated features are optional so do not report them as missing */
+    bitmap_zero(deprecated_feats, S390_FEAT_MAX);
+    s390_get_deprecated_features(deprecated_feats);
+
+    bitmap_andnot(missing, missing, deprecated_feats, S390_FEAT_MAX);
+
     if (!bitmap_empty(missing, S390_FEAT_MAX)) {
         s390_feat_bitmap_to_ascii(missing, unavailable, list_add_feat);
     }
-- 
2.54.0


