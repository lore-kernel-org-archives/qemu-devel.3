Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82183C53219
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 22:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woqJg-0004xZ-8T; Tue, 28 Jul 2026 18:30:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1woqJa-0004wq-Qi; Tue, 28 Jul 2026 18:30:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jrossi@linux.ibm.com>)
 id 1woqJZ-0001CW-3t; Tue, 28 Jul 2026 18:30:22 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66SLHt4j2236906; Tue, 28 Jul 2026 22:30:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:message-id:mime-version
 :subject:to; s=pp1; bh=wEKwJLxIVZu6K9/CDfPeeHLrdBXEY/qacRx54B5Y8
 2g=; b=fdVBCCyfMLzNjnydqmpRKRGQn0wN82hsTM/rgCcKBLfuIdDbl4Q1sXULG
 YNsVloi6VqIgJYixdvR9J0uY3oD4BKa+9h8pJkcz/YXjUi44EEESlifn9XV9ny9w
 ug/J7T+WcLWhIR3Yq2Mofk5kqVyyvHN00uVwfQXd/dSUf/nPRbvhDAmmWgoII7wk
 ytUl5ZCl5NqFbKnMSfW5c9cKsdKtUNa95xKmV6fWbBSzTnNrQw+68v51OzlKqDsZ
 rSTcAJqqn3JNKPU6FLyrI2vpRK8JXxVTxi6PR9zfcI2+ZAt3QRdQdjgJdxI2y+oI
 l3y6gqu8MU4ndJJJ86f++j+OMIhiw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0nq5ut-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 22:30:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66SMQJHu015104;
 Tue, 28 Jul 2026 22:30:17 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yhc451-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 28 Jul 2026 22:30:17 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66SMUGAs60293478
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 28 Jul 2026 22:30:16 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 01A495805A;
 Tue, 28 Jul 2026 22:30:16 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E06D85805C;
 Tue, 28 Jul 2026 22:30:14 +0000 (GMT)
Received: from t15.ibmuc.com (unknown [9.61.152.208])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 28 Jul 2026 22:30:14 +0000 (GMT)
From: jrossi@linux.ibm.com
To: qemu-devel@nongnu.org, qemu-s390x@nongnu.org, cohuck@redhat.com,
 mjrosato@linux.ibm.com
Cc: farman@linux.ibm.com, jrossi@linux.ibm.com, zycai@linux.ibm.com,
 jjherne@linux.ibm.com, borntraeger@linux.ibm.com, jdaley@linux.ibm.com,
 qemu-stable@nongnu.org
Subject: [PATCH qemu] pc-bios/s390-ccw: Fix off-by-one errors with loadparm
 and boot entries
Date: Tue, 28 Jul 2026 18:30:13 -0400
Message-ID: <20260728223013.4047042-1-jrossi@linux.ibm.com>
X-Mailer: git-send-email 2.43.5
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI4MDE5MCBTYWx0ZWRfX0476Dxtejv03
 sdHQqpVg/sDuKMAFBd3OxUP16g6OevH8t2aP1eQv/A+j3UIZG+wLIUbEiVwBmtsMeaOEaUX4mEd
 T+EAWBsTTVIuhCy2nvdSXgSZwo9z+KY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI4MDE5MCBTYWx0ZWRfX855wROg8vcVz
 Mrn1zsnXOipkLl8ma3cm9KRfwWXMBFZFluGe+sMcCTkDpjsABEKAob2Dye4LcyhWM67ORJ9gsB9
 1MM6n8xZ6r26u31lHvi0EGwOajnK88zhYO9bhzSh9hNa6nCDndSev9gbPU+WNFpow8y6EdWJLtR
 OB9Ht21oLG5493U0N2qmnMpw48a3PGmaNLV22pmKTzcSqsc7PrQCZiXyjCTkxICNk8LaD83NwFD
 dJf+iQkiq/iNzIk0/L4BY/T87ftRERHS377M2dnt+tWTaOdICY/q5f6Unh9IMEjz9RdDVEkQVsd
 6zpb+a/GViAlb4wA1rHWYKUJ1Ze3a10Qc+aBffFHFT/D8Ka6H+ycuGIklMn5np9r98VZD54SZlg
 ZQUBr3vg2sZyOjv5AAJ/JC5nQ+iy3j/6lZTsM1giNiRQFJ8xO04C+fX9LTXR43k08mIkDNMVFH0
 gSv60WD3s2P+C0YM0aQ==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a692d79 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=kCIrWdday8tkOiwSnjsA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: ezECWE2dCbospXA2-kO1TtuzY4CV1QvB
X-Proofpoint-ORIG-GUID: ezECWE2dCbospXA2-kO1TtuzY4CV1QvB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-28_06,2026-07-28_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1011 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607280190
Received-SPF: pass client-ip=148.163.158.5; envelope-from=jrossi@linux.ibm.com;
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

From: Jared Rossi <jrossi@linux.ibm.com>

The loadparm may optionally be used to select a boot entry, with the
intended range being 0 through 31 inclusive, for a total of 32 entries.
Previously, MAX_BOOT_ENTRIES was defined as 31, indicating that it was
intended to correspond to the index of the boot entry rather than the
count; however, some guards also used MAX_BOOT_ENTRIES as a count of the
maximum allowed entries, which resulted in a mismatch between the intended
and actual range such that index 31 could never be used in practice.

Move the definition of MAX_BOOT_ENTRIES to qipl.h so it is shared and
change the value to 32, representing a count of the maximum number of
allowed boot entries and allowing the loadparm to accept values 0 through
31 as intended.  Update some instances in the netboot code where
MAX_BOOT_ENTRIES was used as the max index so that all guards treat
MAX_BOOT_ENTRIES as a count across all boot methods.

Cc: qemu-stable@nongnu.org
Fixes: 806315279d5c ("pc-bios/s390-ccw: Remove panics from ECKD IPL path")
Signed-off-by: Jared Rossi <jrossi@linux.ibm.com>
---
 include/hw/s390x/ipl/qipl.h |  2 ++
 pc-bios/s390-ccw/netmain.c  | 11 +++++++----
 pc-bios/s390-ccw/s390-ccw.h |  2 --
 3 files changed, 9 insertions(+), 6 deletions(-)

diff --git a/include/hw/s390x/ipl/qipl.h b/include/hw/s390x/ipl/qipl.h
index 8d3c83a80b..b390f2f112 100644
--- a/include/hw/s390x/ipl/qipl.h
+++ b/include/hw/s390x/ipl/qipl.h
@@ -20,6 +20,8 @@
 #define LOADPARM_LEN    8
 #define NO_LOADPARM "\0\0\0\0\0\0\0\0"
 
+#define MAX_BOOT_ENTRIES  32
+
 enum S390IplType {
     S390_IPL_TYPE_FCP = 0x00,
     S390_IPL_TYPE_CCW = 0x02,
diff --git a/pc-bios/s390-ccw/netmain.c b/pc-bios/s390-ccw/netmain.c
index 651cedf6ef..791854fce0 100644
--- a/pc-bios/s390-ccw/netmain.c
+++ b/pc-bios/s390-ccw/netmain.c
@@ -40,6 +40,9 @@
 #define DEFAULT_BOOT_RETRIES 10
 #define DEFAULT_TFTP_RETRIES 20
 
+/* Index 0 is reserved for default alias, start PXE cfg indices at 1 */
+#define PXECFG_MAX              (MAX_BOOT_ENTRIES - 1)
+
 extern char _start[];
 
 #define KERNEL_ADDR             ((void *)0L)
@@ -381,13 +384,13 @@ static int net_select_and_load_kernel(filename_ip_t *fn_ip,
 
 static int net_try_pxelinux_cfg(filename_ip_t *fn_ip)
 {
-    struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
+    struct pl_cfg_entry entries[PXECFG_MAX];
     int num_ent, def_ent = 0;
 
     num_ent = pxelinux_load_parse_cfg(fn_ip, mac, get_uuid(),
                                       DEFAULT_TFTP_RETRIES,
                                       cfgbuf, sizeof(cfgbuf),
-                                      entries, MAX_BOOT_ENTRIES, &def_ent);
+                                      entries, PXECFG_MAX, &def_ent);
 
     return net_select_and_load_kernel(fn_ip, num_ent, def_ent, entries);
 }
@@ -470,11 +473,11 @@ static int net_try_direct_tftp_load(filename_ip_t *fn_ip)
          * a magic comment string.
          */
         if (!strncasecmp("# pxelinux", cfgbuf, 10)) {
-            struct pl_cfg_entry entries[MAX_BOOT_ENTRIES];
+            struct pl_cfg_entry entries[PXECFG_MAX];
             int num_ent, def_ent = 0;
 
             num_ent = pxelinux_parse_cfg(cfgbuf, sizeof(cfgbuf), entries,
-                                         MAX_BOOT_ENTRIES, &def_ent);
+                                         PXECFG_MAX, &def_ent);
             return net_select_and_load_kernel(fn_ip, num_ent, def_ent,
                                               entries);
         }
diff --git a/pc-bios/s390-ccw/s390-ccw.h b/pc-bios/s390-ccw/s390-ccw.h
index 1e1f71775e..d0498e2944 100644
--- a/pc-bios/s390-ccw/s390-ccw.h
+++ b/pc-bios/s390-ccw/s390-ccw.h
@@ -82,8 +82,6 @@ int menu_get_enum_boot_index(bool *valid_entries);
 bool menu_is_enabled_enum(void);
 int menu_get_boot_index(bool *valid_entries);
 
-#define MAX_BOOT_ENTRIES  31
-
 __attribute__ ((__noreturn__))
 static inline void panic(const char *string)
 {
-- 
2.54.0


