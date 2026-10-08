Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A1CACA6015
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 22:03:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEwD4-0000uW-1M; Thu, 08 Oct 2026 18:03:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xEwCJ-0000rC-BA; Thu, 08 Oct 2026 18:02:50 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <walling@linux.ibm.com>)
 id 1xEwCH-0006Bg-ES; Thu, 08 Oct 2026 18:02:42 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L65mE2296365; Thu, 8 Oct 2026 22:02:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=cnSBFnQr6QcyzY/Qo
 Fx71b2uj5smX7GWXTVEocx00JA=; b=MxCxCn2CchZcUl2vz39iMkD2MSBefdk87
 33wWFEnkFv4+seLWrIvgIm/S8h+GTVbocaAJ7ZifAt+587/so9074P/DwLyzIKsf
 CfWDgwegLs5/+KQwW/kAfeoiKExh2HYHGJ1pvge02RXcx2gI3Cn4ZlAgYvGWxLbo
 igoVVyefuYvF1GvRLV+U/zbRJL/CmqhW0fovipC6KJ5g8oVO6w/ibvhWny1xlusz
 5+2Jne2M28j9JuePcBGLuuDkypdu1nt8gEWud3WqNX3oIchPfjZepc4qJ6r+ci+X
 L+AITUF37opcKOSnZ6Os3JAT8ZsUz/otM0f5z//azCyIugdl/R49A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw6ddy-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 22:02:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698L2d9g4079150; Thu, 8 Oct 2026 22:02:35 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h6hsngctw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 22:02:35 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698M2X2Z54591754
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 22:02:33 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B9C4458050;
 Thu,  8 Oct 2026 22:02:33 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B607658045;
 Thu,  8 Oct 2026 22:02:32 +0000 (GMT)
Received: from li-d664314c-3171-11b2-a85c-fa8047ef35bd.ibm.com.com (unknown
 [9.67.122.67]) by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 22:02:32 +0000 (GMT)
From: Collin Walling <walling@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org
Cc: Hendrik Brueckner <brueckner@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>
Subject: [PATCH v1 2/2] target/s390x: mark feats dependent on deprecated feats
 as deprecated
Date: Thu,  8 Oct 2026 17:59:56 -0400
Message-ID: <20261008215956.164881-3-walling@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20261008215956.164881-1-walling@linux.ibm.com>
References: <20261008215956.164881-1-walling@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA4NiBTYWx0ZWRfXwPVQl8sBoMok
 YToDBBbl09B4F9fmG30FIesRdT9bcQRx+hZ1MWkhy/8HrqP7BT76iV2Euef0LRvvJjW/P8YzKTL
 /MCWMYUIJv4ahjpdpOJ8S9zpk4ZXxdM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA4NiBTYWx0ZWRfX+1xfGAZc03Hn
 W2fnqrObGSyE8ltcwrYDwJS/uA32Jl+cETmU+KrGx+MdA88v13sMnPyz/9oK4srm3Ig13SABOpt
 viyugCKpOxflpi6jLhl6jYNDgA9T1v6mCy91eW1JQL6jUuEVTb3FrvmH6Sf0MrnlwwxiH02et08
 vTPxC1guKyRxKLz4tb12fOD1WkwNy3Af4zzYkw4xdCwKaP7iisjns9rmek9+Fqm9x1N3kaMnpnm
 YTRrzVxShCF7XRXYYKl8kphngBa4DiS7kyLh2iRjcE5gve7L+pLoExmRbK53Z8ffVhd12TVNU7a
 DWPLRIB9COFEMqnIJvjRUyZ8ZhK0HS/mOlaXxVXr3amgWCUzaYDPzqL9Y0pW8uz+gvn3cnk6xC+
 muNzePqoHE1MhQAcqVKDaFs/2JBEazPUPIduRE+Hc/pkbErci+Kc+CWUWkkIt6o4JIdxkcpy68/
 PIf9pRu7TVjw3TVjp7A==
X-Proofpoint-GUID: _ZQhpnuvxigjsVS8pARfRrOaCIzBnImU
X-Proofpoint-ORIG-GUID: _ZQhpnuvxigjsVS8pARfRrOaCIzBnImU
X-Authority-Analysis: v=2.4 cv=XcwcX455 c=1 sm=1 tr=0 ts=6ac812fb cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=7lbl0O4M1_givT_7rIwA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_07,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 lowpriorityscore=0 priorityscore=1501 phishscore=0
 malwarescore=0 bulkscore=0 adultscore=0 spamscore=0 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610020000
 definitions=main-2610080086
Received-SPF: pass client-ip=148.163.158.5; envelope-from=walling@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

There are certain CPU model features that depend on other features
that are flagged for deprecation. For example `ineff_nc_tx` depends
on the `te` deprecated feature.

If a user defines a VM with the current list of deprecated features
disabled, the following is observed:

	warning: 'ineff_nc_tx' requires 'te'

In some cases, this will cause a VM to crash or it may refuse to
start.

To alleviate this, add these "dependent features" to the deprecated
features list. This allows the user to see *all* features that should
be disabled to ensure a successful migration to a host system that
does not support certain deprecated features.

Signed-off-by: Collin Walling <walling@linux.ibm.com>
Reviewed-by: Hendrik Brueckner <brueckner@linux.ibm.com>
---
 target/s390x/cpu_features.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/target/s390x/cpu_features.c b/target/s390x/cpu_features.c
index 20f9947c7be..297c8129e2d 100644
--- a/target/s390x/cpu_features.c
+++ b/target/s390x/cpu_features.c
@@ -359,11 +359,20 @@ void s390_get_deprecated_features(S390FeatBitmap features)
          S390_FEAT_CONSTRAINT_TRANSACTIONAL_EXE,
          S390_FEAT_TRANSACTIONAL_EXE
     };
-    int i;
+    int i, j;
 
     for (i = 0; i < ARRAY_SIZE(feats); i++) {
         set_bit(feats[i], features);
     }
+
+    /* Mark features that depend on feats[] */
+    for (i = 0; i < ARRAY_SIZE(feats); i++) {
+        for (j = 0; j < s390_feat_deps_len; j++) {
+            if (s390_feat_deps[j][1] == feats[i]) {
+                set_bit(s390_feat_deps[j][0], features);
+            }
+        }
+    }
 }
 
 #define FEAT_GROUP_INIT(_name, _group, _desc)        \
-- 
2.55.0


