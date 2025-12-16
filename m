Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DBBAD609CE
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 17:09:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVYXK-0004RG-Fd; Tue, 16 Dec 2025 12:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYXG-0004QJ-47; Tue, 16 Dec 2025 12:08:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1vVYXD-0004WO-QH; Tue, 16 Dec 2025 12:08:29 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGEtFM7029661;
 Tue, 16 Dec 2025 17:08:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=3088E47XVN6ALJ/jGT5xtUd71bL4Jy
 7ERqP5MUPa/7M=; b=g7qs+moJcWNfmaK14tuT6Il1cp48jSDS5rwysDKtlZUgS1
 VnKv9cktvVWRbK9Cyi8E6If7bdd8tbdwoIE8k8vnmNnDEPjGtp1v6WgrwFvAvHX3
 GsI9+awIwOoDf3ovKvTJOsLl43bPuDziVt7yMv/vqFP/S0N0G9B9YovbeUAPSFTv
 3ifFl4aVWOBdITsyXajA8rrt/RurJUdKdckQ9k/GxaDccLxGrHDgz5VJRnWy4q5W
 z/hYF6YZo5T0lCy6fbzaBO1+KSzKzh+3Dra1bnWLQJfxVz3u/Qb6c7I4ORqXbI2T
 2Jec9kCgFUky1n2n9/TXJ9ChkdUj2jV5udRQvVdA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv8ehc-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:08:24 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGH8NkD019796;
 Tue, 16 Dec 2025 17:08:23 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0ytv8eh3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:08:23 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGGA04P012806;
 Tue, 16 Dec 2025 17:08:22 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b1juy5qme-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 17:08:22 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGH8Loi30868158
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 17:08:21 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3257658050;
 Tue, 16 Dec 2025 17:08:21 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D84858045;
 Tue, 16 Dec 2025 17:08:20 +0000 (GMT)
Received: from [9.10.80.59] (unknown [9.10.80.59])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 17:08:20 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------ddCTTjFt7Igg8QArTnFyNUXM"
Message-ID: <0b41d9bb-18a6-4b03-8b43-a6a405a075bb@linux.ibm.com>
Date: Tue, 16 Dec 2025 11:08:20 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 6/7] hw/ppc: pnv_chiptod.c add vmstate support
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me,
 chalapathi.v@linux.ibm.com, angeloj@linux.ibm.com
References: <20251216151359.418708-1-calebs@linux.ibm.com>
 <20251216151359.418708-7-calebs@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20251216151359.418708-7-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAyMyBTYWx0ZWRfX6WtsOZn++bgB
 Ep7lgsuQxLz5E0Qsp3V7re90i0FdHM+ct1j6FsMfeZR8inQn/FOA2npWixXPqoW86IXz2D8NjQu
 dPv4q98iGTNtpD7ydZF2pTE756OlseYw7Vci7T6ltiiZs29qVWw9R3S43is3L9/xHf92RV5awBC
 6w4FD01WU0FV8VlNoqCOknVQAR9rFYxDCrIBNLIEsQy+JEndGQInrnjpEmggk+XT6FcOsyTrVNq
 zRYUVUbKNxsbZDPqHO0lSwJ3X5rC9DG09x+BeJ3tQP2Ho+uSBIeFuJtrAeombYnyUqP+tKMiNRW
 R+UzyMaFlE4cs6PNhyaktvl59/JvU0t9cyOivR19C0gXbV5oSqjEt1TPnfAzvK4Ty0TOf7bihOy
 Be5Ecng3UDqG6g2/iXmJq/MdSFmv1w==
X-Proofpoint-ORIG-GUID: 05P1jI9qm8gX1g_0gEwqktME5pcISbK4
X-Authority-Analysis: v=2.4 cv=QtRTHFyd c=1 sm=1 tr=0 ts=69419208 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=tmTWbWnje4imn2JSegEA:9 a=QEXdDO2ut3YA:10
 a=2tKvrj9r5tddppBGlX0A:9 a=uv4-jtJmVzp5Cqxx:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: _FKmrg9ySgTt85owWrxpBsA0GzHfB3Gd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 impostorscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130023
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
--------------ddCTTjFt7Igg8QArTnFyNUXM
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>

Thanks, MAK


On 12/16/2025 9:13 AM, Caleb Schlossin wrote:
> - Added pre_save and post_load methods to handle slave_pc_target and tod_state
>
> Signed-off-by: Angelo Jaramillo<angelo.jaramillo@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_chiptod.c         | 38 ++++++++++++++++++++++++++++++++++++
>   include/hw/ppc/pnv_chiptod.h |  2 ++
>   2 files changed, 40 insertions(+)
>
> diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
> index f887a18cde..9dc5942ca0 100644
> --- a/hw/ppc/pnv_chiptod.c
> +++ b/hw/ppc/pnv_chiptod.c
> @@ -37,6 +37,7 @@
>   #include "hw/ppc/pnv_core.h"
>   #include "hw/ppc/pnv_xscom.h"
>   #include "hw/ppc/pnv_chiptod.h"
> +#include "migration/vmstate.h"
>   #include "trace.h"
>   
>   #include <libfdt.h>
> @@ -341,6 +342,8 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
>                             " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
>                             " invalid slave address\n", val);
>           }
> +        /* Write slave_pc_target to a uint64_t variable for vmstate support. */
> +        chiptod->tx_ttype_ctrl = val;
>           break;
>       case TOD_ERROR_REG:
>           chiptod->tod_error &= ~val;
> @@ -613,6 +616,40 @@ static void pnv_chiptod_unrealize(DeviceState *dev)
>       qemu_unregister_reset(pnv_chiptod_reset, chiptod);
>   }
>   
> +static int vmstate_pnv_chiptod_pre_save(void *opaque)
> +{
> +    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
> +    chiptod->tod_state_val = (uint8_t)chiptod->tod_state;
> +    return 0;
> +}
> +
> +static int vmstate_pnv_chiptod_post_load(void *opaque)
> +{
> +    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
> +    if (chiptod->tx_ttype_ctrl != 0) {
> +        pnv_chiptod_xscom_write(chiptod, TOD_TX_TTYPE_CTRL_REG << 3,
> +                                chiptod->tx_ttype_ctrl, 8);
> +    }
> +    chiptod->tod_state = (enum tod_state)chiptod->tod_state_val;
> +    return 0;
> +}
> +
> +static const VMStateDescription pnv_chiptod_vmstate = {
> +    .name = TYPE_PNV_CHIPTOD,
> +    .version_id = 1,
> +    .pre_save = vmstate_pnv_chiptod_pre_save,
> +    .pre_load = vmstate_pnv_chiptod_post_load,
> +    .fields = (const VMStateField[]) {
> +        VMSTATE_BOOL(primary, PnvChipTOD),
> +        VMSTATE_BOOL(secondary, PnvChipTOD),
> +        VMSTATE_UINT64(tod_error, PnvChipTOD),
> +        VMSTATE_UINT64(pss_mss_ctrl_reg, PnvChipTOD),
> +        VMSTATE_UINT64(tx_ttype_ctrl, PnvChipTOD),
> +        VMSTATE_UINT8(tod_state_val, PnvChipTOD),
> +        VMSTATE_END_OF_LIST(),
> +    },
> +};
> +
>   static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
>   {
>       DeviceClass *dc = DEVICE_CLASS(klass);
> @@ -621,6 +658,7 @@ static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
>       dc->unrealize = pnv_chiptod_unrealize;
>       dc->desc = "PowerNV ChipTOD Controller";
>       dc->user_creatable = false;
> +    dc->vmsd = &pnv_chiptod_vmstate;
>   }
>   
>   static const TypeInfo pnv_chiptod_type_info = {
> diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
> index 466b06560a..3e5e3b02b2 100644
> --- a/include/hw/ppc/pnv_chiptod.h
> +++ b/include/hw/ppc/pnv_chiptod.h
> @@ -41,6 +41,8 @@ struct PnvChipTOD {
>       uint64_t tod_error;
>       uint64_t pss_mss_ctrl_reg;
>       PnvCore *slave_pc_target;
> +    uint64_t tx_ttype_ctrl;
> +    uint8_t tod_state_val;
>   };
>   
>   struct PnvChipTODClass {
--------------ddCTTjFt7Igg8QArTnFyNUXM
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

Thanks, MAK</pre>
    </div>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 12/16/2025 9:13 AM, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251216151359.418708-7-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">- Added pre_save and post_load methods to handle slave_pc_target and tod_state

Signed-off-by: Angelo Jaramillo <a class="moz-txt-link-rfc2396E" href="mailto:angelo.jaramillo@linux.ibm.com">&lt;angelo.jaramillo@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_chiptod.c         | 38 ++++++++++++++++++++++++++++++++++++
 include/hw/ppc/pnv_chiptod.h |  2 ++
 2 files changed, 40 insertions(+)

diff --git a/hw/ppc/pnv_chiptod.c b/hw/ppc/pnv_chiptod.c
index f887a18cde..9dc5942ca0 100644
--- a/hw/ppc/pnv_chiptod.c
+++ b/hw/ppc/pnv_chiptod.c
@@ -37,6 +37,7 @@
 #include "hw/ppc/pnv_core.h"
 #include "hw/ppc/pnv_xscom.h"
 #include "hw/ppc/pnv_chiptod.h"
+#include "migration/vmstate.h"
 #include "trace.h"
 
 #include &lt;libfdt.h&gt;
@@ -341,6 +342,8 @@ static void pnv_chiptod_xscom_write(void *opaque, hwaddr addr,
                           " TOD_TX_TTYPE_CTRL_REG val 0x%" PRIx64
                           " invalid slave address\n", val);
         }
+        /* Write slave_pc_target to a uint64_t variable for vmstate support. */
+        chiptod-&gt;tx_ttype_ctrl = val;
         break;
     case TOD_ERROR_REG:
         chiptod-&gt;tod_error &amp;= ~val;
@@ -613,6 +616,40 @@ static void pnv_chiptod_unrealize(DeviceState *dev)
     qemu_unregister_reset(pnv_chiptod_reset, chiptod);
 }
 
+static int vmstate_pnv_chiptod_pre_save(void *opaque)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    chiptod-&gt;tod_state_val = (uint8_t)chiptod-&gt;tod_state;
+    return 0;
+}
+
+static int vmstate_pnv_chiptod_post_load(void *opaque)
+{
+    PnvChipTOD *chiptod = PNV_CHIPTOD(opaque);
+    if (chiptod-&gt;tx_ttype_ctrl != 0) {
+        pnv_chiptod_xscom_write(chiptod, TOD_TX_TTYPE_CTRL_REG &lt;&lt; 3,
+                                chiptod-&gt;tx_ttype_ctrl, 8);
+    }
+    chiptod-&gt;tod_state = (enum tod_state)chiptod-&gt;tod_state_val;
+    return 0;
+}
+
+static const VMStateDescription pnv_chiptod_vmstate = {
+    .name = TYPE_PNV_CHIPTOD,
+    .version_id = 1,
+    .pre_save = vmstate_pnv_chiptod_pre_save,
+    .pre_load = vmstate_pnv_chiptod_post_load,
+    .fields = (const VMStateField[]) {
+        VMSTATE_BOOL(primary, PnvChipTOD),
+        VMSTATE_BOOL(secondary, PnvChipTOD),
+        VMSTATE_UINT64(tod_error, PnvChipTOD),
+        VMSTATE_UINT64(pss_mss_ctrl_reg, PnvChipTOD),
+        VMSTATE_UINT64(tx_ttype_ctrl, PnvChipTOD),
+        VMSTATE_UINT8(tod_state_val, PnvChipTOD),
+        VMSTATE_END_OF_LIST(),
+    },
+};
+
 static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
 {
     DeviceClass *dc = DEVICE_CLASS(klass);
@@ -621,6 +658,7 @@ static void pnv_chiptod_class_init(ObjectClass *klass, const void *data)
     dc-&gt;unrealize = pnv_chiptod_unrealize;
     dc-&gt;desc = "PowerNV ChipTOD Controller";
     dc-&gt;user_creatable = false;
+    dc-&gt;vmsd = &amp;pnv_chiptod_vmstate;
 }
 
 static const TypeInfo pnv_chiptod_type_info = {
diff --git a/include/hw/ppc/pnv_chiptod.h b/include/hw/ppc/pnv_chiptod.h
index 466b06560a..3e5e3b02b2 100644
--- a/include/hw/ppc/pnv_chiptod.h
+++ b/include/hw/ppc/pnv_chiptod.h
@@ -41,6 +41,8 @@ struct PnvChipTOD {
     uint64_t tod_error;
     uint64_t pss_mss_ctrl_reg;
     PnvCore *slave_pc_target;
+    uint64_t tx_ttype_ctrl;
+    uint8_t tod_state_val;
 };
 
 struct PnvChipTODClass {
</pre>
    </blockquote>
  </body>
</html>

--------------ddCTTjFt7Igg8QArTnFyNUXM--


