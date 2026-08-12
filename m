Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 071B7C5B56A
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:19:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCb2-0000md-Mg; Wed, 12 Aug 2026 13:18:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZw-0000BI-6h; Wed, 12 Aug 2026 13:17:25 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZt-0000qn-CL; Wed, 12 Aug 2026 13:17:23 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1X314088095; Wed, 12 Aug 2026 17:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=tKEcQzRy7FjgxVEka
 NvxNwpQ96rGVzRmn+OAUpHIq+4=; b=raGrfJdhl4IotgL2viQ+SmeojiZaJc5LY
 C3YaFrdfmxAiXcZbYw8Te3aPhnpKWsblAVWEi7roZBOeUtEI2z8OTpbz8r4Xx0bo
 KDCL9NZ/38AyNKAxuruJWMcYrHG+UIDTFihwrA6bDUbQwAQYpmRCyzK2OVfh+LLa
 /CSbBzr1Vzy5tfhIgx3F3k/KD2tl4zzw54dCc4Xtvv8lgWWn/OVfM78SnU6kHZA6
 90+2POlt5ZOiuIAXAkmF8MtNlXVkJT746sA1KUQ4QmwqeC3r338K+50p8kUqoHCr
 fYLh+RLcu6vbLPr6zVTlRMdFQw7m0SQttPhKE1kGTsQYxZTSSTc4g==
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9us2x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:19 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBGX7025460;
 Wed, 12 Aug 2026 17:17:18 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxhfy6x8a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHGkt40305396
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:16 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F35A58051;
 Wed, 12 Aug 2026 17:17:16 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DE9FE5805C;
 Wed, 12 Aug 2026 17:17:15 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:15 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Joshua Daley <jdaley@linux.ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 08/15] pc-bios/s390-ccw: bounds-check zipl menu entry index
 before array write
Date: Wed, 12 Aug 2026 13:17:00 -0400
Message-ID: <20260812171707.1605637-9-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX7UpoPgHhQP8V
 tDem8sRYVPDSVqInV0N+vYkDdbivqtvYyPRcXcYLsWEp05aIlHJ74EwvVNrpQ1Nlpjv7kQ94K9r
 o4CQjDLN8+P+rG5pi7j4zCzFYI2PB8IEQ5Y0F0U4PCQdCNc6cz/ufyKMQoBD2NiCObKFY2hvxxI
 nAKt/HOdKZCppARxQ9DIRhljw31Foa/KoYAJ9vk4OPvGxFEXkTlESG5hsnVdEC0abLeJDycm7Aq
 Tg5sZ8yESlGxlxGVvUEYHw2QsMgK7r5/70StY9+oVQkWgqF6FzU3xFG0x+m0JfhgXHY5G/JaeWo
 0MrY3OQK9XsyxJTHHobPss2lrE2Mhm/EZHa8SW0i/mzJCP2FS2gAeohPtEUSBWvJNwbkdYJ9m29
 q6yHl6+ni6jaCQlnOWvN4tzy5qt2GFqipYVcwI+ww5kjHfZ5N5qQXxL1IFL2fFdCyLCCufFjwL3
 p3laHTUT1KxNPAuZWyg==
X-Proofpoint-ORIG-GUID: rOR-EdBGBWGJaDrD8SXddFel0KglBctt
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfXyHgZDkDUAqEg
 69Y6wFbWkxozgEQdlJs91poQq3JKg2R9W6JZM5YKPn0BrSMuQjuhJZFAYyB1iIbjt9Q7zla0Zc/
 /A4TfV7uG6+xb5gUgnlFT5k49Bh1uBU=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7caa9f cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=K1TfFEnDoUzuEk3QFlUA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: rOR-EdBGBWGJaDrD8SXddFel0KglBctt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-12_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 impostorscore=0 bulkscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 malwarescore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608120138
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
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

From: Joshua Daley <jdaley@linux.ibm.com>

menu_get_zipl_boot_index() iterates NUL-separated strings from the
zipl stage-2 boot-menu block, passes each to zipl_print_entry() which
converts EBCDIC to ASCII and returns atoi(), then writes true into
valid_entries[entry]. valid_entries is a MAX_BOOT_ENTRIES element
stack array, but entry was never bounds-checked, so a crafted on-disk
value could index arbitrarily beyond the array.

Fix this in two places:

- zipl_print_entry() now validates that the first significant character
  (after an optional leading space) is a digit. Entries that fail this
  check return -1 without printing.

- menu_get_zipl_boot_index() skips any entry whose index is outside
  [0, MAX_BOOT_ENTRIES) before writing to valid_entries[].

Fixes: 7385e947fc65 ("pc-bios/s390-ccw: fix non-sequential boot entries (eckd)")
Cc: qemu-stable@nongnu.org
Signed-off-by: Joshua Daley <jdaley@linux.ibm.com>
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Reviewed-by: Eric Farman <farman@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260727115052.24289-5-borntraeger@linux.ibm.com
[farman@linux.ibm.com: Added qemu-stable]
Signed-off-by: Eric Farman <farman@linux.ibm.com>
---
 pc-bios/s390-ccw/menu.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/pc-bios/s390-ccw/menu.c b/pc-bios/s390-ccw/menu.c
index eeaff78f87..b6a9a56d46 100644
--- a/pc-bios/s390-ccw/menu.c
+++ b/pc-bios/s390-ccw/menu.c
@@ -176,18 +176,24 @@ int menu_get_boot_index(bool *valid_entries)
     return boot_index;
 }
 
-/* Returns the entry number that was printed */
+/* Returns the entry number that was printed, or -1 on invalid entry */
 static int zipl_print_entry(const char *data, size_t len)
 {
     char buf[len + 2];
+    const char *p;
 
     ebcdic_to_ascii(data, buf, len);
     buf[len] = '\n';
     buf[len + 1] = '\0';
 
+    p = (buf[0] == ' ') ? buf + 1 : buf;
+    if (!isdigit((unsigned char)*p)) {
+        return -1;
+    }
+
     printf("%s", buf);
 
-    return buf[0] == ' ' ? atoi(buf + 1) : atoi(buf);
+    return atoi(p);
 }
 
 int menu_get_zipl_boot_index(const char *menu_data)
@@ -216,6 +222,9 @@ int menu_get_zipl_boot_index(const char *menu_data)
         entry = zipl_print_entry(menu_data, len);
         menu_data += len + 1;
 
+        if (entry < 0 || entry >= MAX_BOOT_ENTRIES) {
+            continue;
+        }
         valid_entries[entry] = true;
 
         if (entry == 0) {
-- 
2.55.0


