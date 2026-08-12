Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D194C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Aug 2026 17:20:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuCbc-0001tJ-Cv; Wed, 12 Aug 2026 13:19:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZx-0000CB-Ui; Wed, 12 Aug 2026 13:17:27 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1wuCZu-0000re-JF; Wed, 12 Aug 2026 13:17:25 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67CH1eGE4088460; Wed, 12 Aug 2026 17:17:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=bIqvEqumVE6zjmRJH
 3V7MmfwDS0t6/wmZ5092Yrczhg=; b=MvCKsRHWXu60DiDQ4tu5mnOlNH0YnYi5Q
 Y2mPP3i0+4koziYBfcrkoT4LkKpxwGIuHzBRQFQwHR/kmpa5CTThWQelgP5b3Rnf
 CXdoVDD2dLsn8daftsazmpoi1sttvKBooxSLgxY6ro5Hof75Ac4Vy/9ejzHz3yua
 hEQ4LlQQ5tZflrl1tUEvRAxoyRuwQVlxO9snPiA1IQXL3tgV4tIdljdsNWmvSBV+
 yaY0xm7BGonOEJdnqQe5JXtnwn5dOGLPxs16OHUQqbMuX2yhGpTFbQ7yMj87fKcg
 VDA4WcerV16PJMR71Ykm0MWaUGgQ0764/LsSnFZ6UuQxAtaaFhfvQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvm9us32-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67CHBLA2017558;
 Wed, 12 Aug 2026 17:17:19 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxg9h72n1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 12 Aug 2026 17:17:19 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67CHHILL53543422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 12 Aug 2026 17:17:18 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 035F258051;
 Wed, 12 Aug 2026 17:17:18 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 623C25805C;
 Wed, 12 Aug 2026 17:17:17 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com.com (unknown
 [9.61.61.74]) by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 12 Aug 2026 17:17:17 +0000 (GMT)
From: Eric Farman <farman@linux.ibm.com>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Jared Rossi <jrossi@linux.ibm.com>,
 qemu-stable@nongnu.org, Eric Farman <farman@linux.ibm.com>
Subject: [PULL 10/15] pc-bios/s390-ccw: Fix off-by-one errors with loadparm
 and boot entries
Date: Wed, 12 Aug 2026 13:17:02 -0400
Message-ID: <20260812171707.1605637-11-farman@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260812171707.1605637-1-farman@linux.ibm.com>
References: <20260812171707.1605637-1-farman@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX41aLjnV7UFU9
 Na/QDAzf/Q2uRx58O6UAymq7oBC9WmARR+SELkra6wpqHfnu9vA51oYRDkuJPBvFVtV0HrjjR38
 nIjb3GZNci/iMiVl8qIESXiR6dfOOirx6I9OgJo2G29w3RXoFpVj4nrlVQ64a6//Q8bg0Wtanjw
 QySmyrTuTwmri6CcGtQ9CGlZf+OJbylf57Cq98IX/spp7wVTHibbJL56ykttM4obixue3G6Hwd3
 SP1u2lE1JeY6ECpyvuqnUcPUcgm+zmzctA0oYSw8IWeP6OUm1VypIRrWzuktELoIm7xbTwuq9Eb
 pACswDV+RE8Tal/91KzxQPrJn1yHukodlxr2W9prOUt/Np9yTqHyuZbfvjSOeCnVs9VQkbECwZq
 4T9aFwb+5rfbrPa9gA0GCki2f+ZMrnFwiY+49IkYQFAEqSFSoQztLEVMFFlyzzxbnUJj1Lzl7Ej
 SS2pcg5JQ6aO77TRnJA==
X-Proofpoint-ORIG-GUID: 8kqfQGbeq8bj5lNReq6NtCek_9wqWNsr
X-Proofpoint-Spam-Info: AW1haW4tMjYwODEyMDEzOCBTYWx0ZWRfX0LWhU2FHIJcf
 NfKwT3SbnyGO0KAtOVVrV7oqn/8aLGANSr4kEOqWodKAkCYIYZsOiPBfYag+TAuXcF7iFtO4BPj
 1NpdjeB+VEKFxGObjVpwG4BWYZX/Uls=
X-Authority-Analysis: v=2.4 cv=IfK3n2qa c=1 sm=1 tr=0 ts=6a7caaa0 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8
 a=VFx-KdROuyEcXuZeOuwA:9 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-GUID: 8kqfQGbeq8bj5lNReq6NtCek_9wqWNsr
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
Reviewed-by: Matthew Rosato <mjrosato@linux.ibm.com>
Link: https://lore.kernel.org/qemu-devel/20260728223013.4047042-1-jrossi@linux.ibm.com
Signed-off-by: Eric Farman <farman@linux.ibm.com>
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
index f6030a6071..25aac91d45 100644
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
2.55.0


