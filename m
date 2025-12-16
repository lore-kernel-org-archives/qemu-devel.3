Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4AC7D609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:49:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYEl-000449-7h; Tue, 16 Dec 2025 11:49:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYEi-000433-Or; Tue, 16 Dec 2025 11:49:20 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYEg-0000c1-Ra; Tue, 16 Dec 2025 11:49:20 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGC1mGv029165;
 Tue, 16 Dec 2025 16:49:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=edItOK+T/9x4eBU9q775Qr+LTRr8sX
 IqcslynM5hyJg=; b=ZOeTkK57rO5DSM0HpAvNARypeNiNuj6JHj6ncX3dWhBjNa
 GOGeHrkPO4dyHsOmdCqED3CL5cIUeqZICiWRp93HgXLpcjkghacF6B5tX+hgoEVw
 yv/8s1XvH6qEGT9ZCZVBy1ub8ESmuw+Jw3z/0WT7N89G7nYTQyptGNlA0+OV35lG
 OnKXCGpecPq6Gdgzr12y+AYZW08GznSTFxy7otTAiF1dB7oaygUwL8mrliz6kT5P
 6213QMSzHgCca2zdONu/YjyCKoEh7VffWxOvWh+evWGJFg56tNFBztyeMmvVTtMX
 5PtWyxDFPiXdCBV/fMeiicHUOM8bFuo1936lMUwg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkypsn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:49:14 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGnDFV025595;
 Tue, 16 Dec 2025 16:49:13 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkypsh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:49:13 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGFCsLk005690;
 Tue, 16 Dec 2025 16:49:12 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1tgnv0he-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:49:12 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGnBvB39190856
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:49:11 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8253158052;
 Tue, 16 Dec 2025 16:49:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B907A58056;
 Tue, 16 Dec 2025 16:49:10 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:49:10 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------O30MsbR3Ay0Go9hneti6x2kv"
Message-ID: <2bbffee3-6a1a-4bd9-9dde-91f57c58a411@linux.ibm.com>
Date: Tue, 16 Dec 2025 10:49:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 7/7] hw/ppc: Add VMSTATE information to PnvPsi
To: milesg@linux.ibm.com, Caleb Schlossin <calebs@linux.ibm.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-8-calebs@linux.ibm.com>
 <2570f988a46615022b9180b2aad228a733e3b7ff.camel@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <2570f988a46615022b9180b2aad228a733e3b7ff.camel@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: YXu02etxMjSP3yfHbt1TxcpDEeMoilPT
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69418d8a cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=eDkLXcaQSEDiTH1ZAsEA:9 a=QEXdDO2ut3YA:10
 a=OW9FX9VIyzILtHTHIfsA:9 a=YA9Eye4rJ7QrCEPl:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: 7NXAEo80CxsEF0a-gYXZoKdWFlg6pmLf
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfXxMWdnH99T9U/
 yXYqwRLS7ORAuagozfaDqRNzpY/EsKI31fC+0fHvSiC9m/pvP8CpCAEs9i8+jlO8r+REVr8Wfca
 szzebUI3bpODf80PNx2VjTLds9iwQYyEdbTmEmFUZLdDhInFkGp+v2HWaNrrQUFpVMI+rhzapLF
 iIOGtpf6W1ZY7bQaqIPgBj0b484Xrm5lRbGiea+Df+zc1SrRUouRojld3i3PGzhW/kx0wxVHWKt
 2FnYiWf2RNJjRzfVeFmngcSjVlJVPVRpV5YbBJrvTzkLuOpS/6EqMV1JAoqrNeUOW1LWCWIDQ4y
 otxuxXtup2KJfSb6Judncs5a2ULtDf47KEZd2fZYETHPRX+K5xIGUxV3R5FuV3C0xZn9ay85Vsc
 Jlt5/OocUq/oWkQ86zBNUwuR7DxnPw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1011 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=kowal@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a multi-part message in MIME format.
--------------O30MsbR3Ay0Go9hneti6x2kv
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 12/16/2025 10:24 AM, Miles Glenn wrote:
> Reviewed-by: Glenn Miles<milesg@linux.ibm.com>
>
> Thanks,
>
> Glenn
>
> On Tue, 2025-12-16 at 09:13 -0600, Caleb Schlossin wrote:
>> PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
>> to the device class and a post_load() method to restore dynamic data items and
>> memory region mappings.
>>
>> Signed-off-by: Michael Kowal<kowal@linux.ibm.com>
>> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
>> ---
>>   hw/ppc/pnv_psi.c | 36 ++++++++++++++++++++++++++++++++++--
>>   1 file changed, 34 insertions(+), 2 deletions(-)
>>
>> diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
>> index 5d947d8b52..67bc911e4b 100644
>> --- a/hw/ppc/pnv_psi.c
>> +++ b/hw/ppc/pnv_psi.c
>> @@ -25,6 +25,7 @@
>>   #include "qemu/module.h"
>>   #include "system/reset.h"
>>   #include "qapi/error.h"
>> +#include "migration/vmstate.h"
>>   
>>   
>>   #include "hw/ppc/fdt.h"
>> @@ -130,12 +131,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
>>   {
>>       PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
>>       MemoryRegion *sysmem = get_system_memory();
>> -    uint64_t old = psi->regs[PSIHB_XSCOM_BAR];
>>   
>>       psi->regs[PSIHB_XSCOM_BAR] = bar & (ppc->bar_mask | PSIHB_BAR_EN);
>>   
>>       /* Update MR, always remove it first */
>> -    if (old & PSIHB_BAR_EN) {
>> +    if (memory_region_is_mapped(&psi->regs_mr)) {
>>           memory_region_del_subregion(sysmem, &psi->regs_mr);
>>       }
>>   
>> @@ -919,6 +919,37 @@ static const TypeInfo pnv_psi_power9_info = {
>>       },
>>   };
>>   
>> +static int vmstate_pnv_psi_post_load(void *opaque, int version_id)
>> +{
>> +    PnvPsi *psi = PNV_PSI(opaque);
>> +    Pnv9Psi *psi9 = PNV9_PSI(psi);
>> +    MemoryRegion   *sysmem = get_system_memory();
>> +    uint64_t esb_bar;
>> +    hwaddr esb_addr;
>> +
>> +    /* Set the ESB MMIO mapping */
>> +    esb_bar = psi->regs[PSIHB_REG(PSIHB9_ESB_CI_BASE)];
>> +
>> +    if (esb_bar & PSIHB9_ESB_CI_VALID) {
>> +        esb_addr = esb_bar & PSIHB9_ESB_CI_ADDR_MASK;
>> +        memory_region_add_subregion(sysmem, esb_addr,
>> +                                    &psi9->source.esb_mmio);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static const VMStateDescription vmstate_pnv_psi = {
>> +    .name = TYPE_PNV_PSI,
>> +    .version_id = 1,
>> +    .minimum_version_id = 1,
>> +    .post_load = vmstate_pnv_psi_post_load,
>> +    .fields = (const VMStateField[]) {
>> +        VMSTATE_UINT64_ARRAY(regs, PnvPsi, PSIHB_XSCOM_MAX),
>> +        VMSTATE_END_OF_LIST()
>> +    }
>> +};
>> +
>>   static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
>>   {
>>       DeviceClass *dc = DEVICE_CLASS(klass);
>> @@ -926,6 +957,7 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
>>       static const char compat[] = "ibm,power10-psihb-x\0ibm,psihb-x";
>>   
>>       dc->desc    = "PowerNV PSI Controller POWER10";
>> +    dc->vmsd = &vmstate_pnv_psi;
>>   
>>       ppc->xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
>>       ppc->xscom_size = PNV10_XSCOM_PSIHB_SIZE;
--------------O30MsbR3Ay0Go9hneti6x2kv
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 7bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p>
    </p>
    <div
style="font-family: &quot;Consolas&quot;; font-size: 11.0pt; color: #000000;background-color: #FFFFFF; font-style: normal; font-weight: normal; text-decoration: none;">
      <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>

Thanks, MAK
</pre>
    </div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/16/2025 10:24 AM, Miles Glenn
      wrote:<br>
    </div>
    <blockquote type="cite"
cite="mid:2570f988a46615022b9180b2aad228a733e3b7ff.camel@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">Reviewed-by: Glenn Miles <a class="moz-txt-link-rfc2396E" href="mailto:milesg@linux.ibm.com">&lt;milesg@linux.ibm.com&gt;</a>

Thanks,

Glenn

On Tue, 2025-12-16 at 09:13 -0600, Caleb Schlossin wrote:
</pre>
      <blockquote type="cite">
        <pre wrap="" class="moz-quote-pre">PnvPsi needs to be able to save/load snapshots.  Add VMSTATE information
to the device class and a post_load() method to restore dynamic data items and
memory region mappings.

Signed-off-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_psi.c | 36 ++++++++++++++++++++++++++++++++++--
 1 file changed, 34 insertions(+), 2 deletions(-)

diff --git a/hw/ppc/pnv_psi.c b/hw/ppc/pnv_psi.c
index 5d947d8b52..67bc911e4b 100644
--- a/hw/ppc/pnv_psi.c
+++ b/hw/ppc/pnv_psi.c
@@ -25,6 +25,7 @@
 #include "qemu/module.h"
 #include "system/reset.h"
 #include "qapi/error.h"
+#include "migration/vmstate.h"
 
 
 #include "hw/ppc/fdt.h"
@@ -130,12 +131,11 @@ static void pnv_psi_set_bar(PnvPsi *psi, uint64_t bar)
 {
     PnvPsiClass *ppc = PNV_PSI_GET_CLASS(psi);
     MemoryRegion *sysmem = get_system_memory();
-    uint64_t old = psi-&gt;regs[PSIHB_XSCOM_BAR];
 
     psi-&gt;regs[PSIHB_XSCOM_BAR] = bar &amp; (ppc-&gt;bar_mask | PSIHB_BAR_EN);
 
     /* Update MR, always remove it first */
-    if (old &amp; PSIHB_BAR_EN) {
+    if (memory_region_is_mapped(&amp;psi-&gt;regs_mr)) {
         memory_region_del_subregion(sysmem, &amp;psi-&gt;regs_mr);
     }
 
@@ -919,6 +919,37 @@ static const TypeInfo pnv_psi_power9_info = {
     },
 };
 
+static int vmstate_pnv_psi_post_load(void *opaque, int version_id)
+{
+    PnvPsi *psi = PNV_PSI(opaque);
+    Pnv9Psi *psi9 = PNV9_PSI(psi);
+    MemoryRegion   *sysmem = get_system_memory();
+    uint64_t esb_bar;
+    hwaddr esb_addr;
+
+    /* Set the ESB MMIO mapping */
+    esb_bar = psi-&gt;regs[PSIHB_REG(PSIHB9_ESB_CI_BASE)];
+
+    if (esb_bar &amp; PSIHB9_ESB_CI_VALID) {
+        esb_addr = esb_bar &amp; PSIHB9_ESB_CI_ADDR_MASK;
+        memory_region_add_subregion(sysmem, esb_addr,
+                                    &amp;psi9-&gt;source.esb_mmio);
+    }
+
+    return 0;
+}
+
+static const VMStateDescription vmstate_pnv_psi = {
+    .name = TYPE_PNV_PSI,
+    .version_id = 1,
+    .minimum_version_id = 1,
+    .post_load = vmstate_pnv_psi_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_UINT64_ARRAY(regs, PnvPsi, PSIHB_XSCOM_MAX),
+        VMSTATE_END_OF_LIST()
+    }
+};
+
 static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -926,6 +957,7 @@ static void pnv_psi_power10_class_init(ObjectClass *klass, const void *data)
     static const char compat[] = "ibm,power10-psihb-x\0ibm,psihb-x";
 
     dc-&gt;desc    = "PowerNV PSI Controller POWER10";
+    dc-&gt;vmsd = &amp;vmstate_pnv_psi;
 
     ppc-&gt;xscom_pcba = PNV10_XSCOM_PSIHB_BASE;
     ppc-&gt;xscom_size = PNV10_XSCOM_PSIHB_SIZE;
</pre>
      </blockquote>
      <pre wrap="" class="moz-quote-pre">
</pre>
    </blockquote>
  </body>
</html>

--------------O30MsbR3Ay0Go9hneti6x2kv--


