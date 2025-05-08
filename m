Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DD24C3ABBE
	for <qemu-devel@archiver.kernel.org>; Thu,  8 May 2025 22:52:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDA5C-00040X-Pe; Thu, 08 May 2025 18:51:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA58-0003z1-JI; Thu, 08 May 2025 18:51:10 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <zycai@linux.ibm.com>)
 id 1uDA55-0006Qa-5u; Thu, 08 May 2025 18:51:09 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 548KEFMC011690;
 Thu, 8 May 2025 22:51:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=pp1; bh=0ZD9XJCQfrh90bN9M
 GwZfxuM/WALYaGskFQ2d+0EVgo=; b=jSePKUZ1/r22OrO4FwcuEmIs3OruG2g5h
 nW7bLxkYK+LYFP3649KUlAy9G48APyNTBIUF9dIR01AmOq4i5F7yujC1JGFEZHy/
 BN43cFD2c9yWrzXMcAF22gbvQc1ZPBz4wyxZgAyNEeu1ZO1QpdVHOZwnVDETMgH6
 oN7ex+xj5jK6NAFsHNzHzJlYTD0xMeIBwjUZBYrPXfHkPQHVaEtq2yNBuTZPfR09
 gI/6sV2FhNFG4Z3/khRA6LfNmkVzVKKa3ZeJsDxwUSN0JUPcgMlYpcaP/JDJRcu+
 V0NZyB/sFD8ARVcVOWmdghHBH+EX1J98bo0pUPIqtYJMfSMjfrU9g==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46gu2t3at2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:05 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 548LrX50002738;
 Thu, 8 May 2025 22:51:04 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46dxfp835s-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 May 2025 22:51:04 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 548Mp3bF26018464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 May 2025 22:51:03 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D6F15805B;
 Thu,  8 May 2025 22:51:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E351D5804B;
 Thu,  8 May 2025 22:51:01 +0000 (GMT)
Received: from fedora-workstation.ibmuc.com (unknown [9.61.11.238])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 May 2025 22:51:01 +0000 (GMT)
From: Zhuoying Cai <zycai@linux.ibm.com>
To: thuth@redhat.com, richard.henderson@linaro.org, david@redhat.com,
 pbonzini@redhat.com
Cc: walling@linux.ibm.com, jjherne@linux.ibm.com, jrossi@linux.ibm.com,
 fiuczy@linux.ibm.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 farman@linux.ibm.com, iii@linux.ibm.com, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org, zycai@linux.ibm.com
Subject: [PATCH v2 01/25] Add -boot-certificates to s390-ccw-virtio machine
 type option
Date: Thu,  8 May 2025 18:50:17 -0400
Message-ID: <20250508225042.313672-2-zycai@linux.ibm.com>
X-Mailer: git-send-email 2.49.0
In-Reply-To: <20250508225042.313672-1-zycai@linux.ibm.com>
References: <20250508225042.313672-1-zycai@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NLnV+16g c=1 sm=1 tr=0 ts=681d3559 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=Jktn0zzf6qNn0GHakZsA:9
X-Proofpoint-ORIG-GUID: iXG-utNofHM3t_HoRt4D-S6gs3iKXWHr
X-Proofpoint-GUID: iXG-utNofHM3t_HoRt4D-S6gs3iKXWHr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTA4MDIwNSBTYWx0ZWRfX/6Z4G5mMlMHM
 HwTEksyDJVDqi0JjElG+elIevaECeWwFyRlMISMwiKmglAYTI1hb4UPk9f2/MG+jzy/SAMyYBuA
 cJDms50CwRxHHrqyBoVF0RuYTcKbCC4UaU45PyjxwJ0D6wDa/AtumfVWGYNc02CZaqXl7kOpgDq
 HZ9cVasTNyhp+LQBwM37OPgzYqxShDuNuTwcRWKPcLFF8WULvLsITFpfVIY+z6b2PcuJB++9lPp
 aj4tIjtsW7N6ra64rAtqmqHQU8kIpZs0wksm9avZbvp7zXRCuuaih6RGTJku2Rv/V72chy8JboH
 Dzr9BICcpSZ5NVaFRAktOJhr3rLVCve2rgoAa/venGSiVNXnDW6yoJ4k1xZQ3SGUbCTwRSxQW1T
 3BlBUKE+aS3juoKdQ1q7Nvm5FEESGo/Tn3TOntXKyrcsukFa/Bey6NrDuwDJbFFZSTEf9JSd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-08_07,2025-05-08_04,2025-02-21_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 suspectscore=0
 mlxlogscore=999 phishscore=0 mlxscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 spamscore=0 malwarescore=0 priorityscore=1501
 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.19.0-2504070000
 definitions=main-2505080205
Received-SPF: pass client-ip=148.163.158.5; envelope-from=zycai@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add -boot-certificates as a parameter of s390-ccw-virtio machine type option.

The `-boot-certificates /path/dir:/path/file` option is implemented
to provide path to either a directory or a single certificate.

Multiple paths can be delineated using a colon.

Signed-off-by: Zhuoying Cai <zycai@linux.ibm.com>
---
 hw/s390x/s390-virtio-ccw.c         | 22 ++++++++++++++++++++++
 include/hw/s390x/s390-virtio-ccw.h |  1 +
 qemu-options.hx                    |  7 ++++++-
 3 files changed, 29 insertions(+), 1 deletion(-)

diff --git a/hw/s390x/s390-virtio-ccw.c b/hw/s390x/s390-virtio-ccw.c
index 192feb128b..f82f78255a 100644
--- a/hw/s390x/s390-virtio-ccw.c
+++ b/hw/s390x/s390-virtio-ccw.c
@@ -824,6 +824,22 @@ static void machine_set_loadparm(Object *obj, Visitor *v,
     s390_ipl_fmt_loadparm(ms->loadparm, val, errp);
 }
 
+static inline char *machine_get_boot_certificates(Object *obj, Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    return g_strdup(ms->boot_certificates);
+}
+
+static void machine_set_boot_certificates(Object *obj, const char *str,
+                                          Error **errp)
+{
+    S390CcwMachineState *ms = S390_CCW_MACHINE(obj);
+
+    g_free(ms->boot_certificates);
+    ms->boot_certificates = g_strdup(str);
+}
+
 static void ccw_machine_class_init(ObjectClass *oc, const void *data)
 {
     MachineClass *mc = MACHINE_CLASS(oc);
@@ -878,6 +894,12 @@ static void ccw_machine_class_init(ObjectClass *oc, const void *data)
             "Up to 8 chars in set of [A-Za-z0-9. ] (lower case chars converted"
             " to upper case) to pass to machine loader, boot manager,"
             " and guest kernel");
+
+    object_class_property_add_str(oc, "boot-certificates",
+                                  machine_get_boot_certificates,
+                                  machine_set_boot_certificates);
+    object_class_property_set_description(oc, "boot-certificates",
+            "provide path to a direcotry or a single certificate for secure boot");
 }
 
 static inline void s390_machine_initfn(Object *obj)
diff --git a/include/hw/s390x/s390-virtio-ccw.h b/include/hw/s390x/s390-virtio-ccw.h
index fc4112fbf5..ed25939243 100644
--- a/include/hw/s390x/s390-virtio-ccw.h
+++ b/include/hw/s390x/s390-virtio-ccw.h
@@ -31,6 +31,7 @@ struct S390CcwMachineState {
     uint8_t loadparm[8];
     uint64_t memory_limit;
     uint64_t max_pagesize;
+    char *boot_certificates;
 
     SCLPDevice *sclp;
 };
diff --git a/qemu-options.hx b/qemu-options.hx
index dc694a99a3..e592f6a757 100644
--- a/qemu-options.hx
+++ b/qemu-options.hx
@@ -43,7 +43,8 @@ DEF("machine", HAS_ARG, QEMU_OPTION_machine, \
 #endif
     "                memory-backend='backend-id' specifies explicitly provided backend for main RAM (default=none)\n"
     "                cxl-fmw.0.targets.0=firsttarget,cxl-fmw.0.targets.1=secondtarget,cxl-fmw.0.size=size[,cxl-fmw.0.interleave-granularity=granularity]\n"
-    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n",
+    "                smp-cache.0.cache=cachename,smp-cache.0.topology=topologylevel\n"
+    "                boot-certificates='/path/directory:/path/file' provide a path to a directory or a boot certificate\n",
     QEMU_ARCH_ALL)
 SRST
 ``-machine [type=]name[,prop=value[,...]]``
@@ -200,6 +201,10 @@ SRST
         ::
 
             -machine smp-cache.0.cache=l1d,smp-cache.0.topology=core,smp-cache.1.cache=l1i,smp-cache.1.topology=core
+
+    ``boot-certificates='/path/directory:/path/file'``
+        Provide a path to a directory or a boot certificate on s390-ccw host.
+        A colon may be used to delineate multiple paths.
 ERST
 
 DEF("M", HAS_ARG, QEMU_OPTION_M,
-- 
2.49.0


