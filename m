Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83C93E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 11:33:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY0cz-0006b3-4V; Tue, 23 Dec 2025 06:32:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY0cw-0006Z9-5K; Tue, 23 Dec 2025 06:32:30 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY0cu-0007yd-6u; Tue, 23 Dec 2025 06:32:29 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLFDgFw002075;
 Mon, 22 Dec 2025 10:49:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=2llqzcLOYjqdFWe97uYRTT115akg4L
 rHbSsmK9rhXf8=; b=Sp9rRCu6rr076dbEWhJOz3Q1tDL7LszvZZ4yXd+IsRBrJT
 jjX25CDxnx1FUaya+THgTGcX5c6Z+apEpDfZ/cNa/rCoCugvnAA6F2KTccmPdprw
 NwECikPU0AFRJcLZnXs62fizP19QN2yJI8JG4Zysc8+FMmsGNbxLgPERBSs8+SmH
 o/0MMzChdqpsRwjG71yizHAVj4NQpMWoB2Wck/S7MF+4IvwLlIKtpKgUXjvM01mw
 ZLflfgMY9sjdR/S4arHBfQqsh+bV/eC1E1egGfXihyTvJ3jGhuVnwsoHtPvWW7WV
 /tRL91OxlMEXvkmokZEDErSinZ//pxKc+Ov7Qv+A==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47j79-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:49:07 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMAh5MN024153;
 Mon, 22 Dec 2025 10:49:07 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47j76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:49:06 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM9dcSt005285;
 Mon, 22 Dec 2025 10:49:05 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4b67mjwhws-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:49:05 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMAn46G17367624
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 10:49:04 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 878AD58059;
 Mon, 22 Dec 2025 10:49:04 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E0D2058057;
 Mon, 22 Dec 2025 10:49:01 +0000 (GMT)
Received: from [9.43.97.98] (unknown [9.43.97.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 10:49:01 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------kzndGBMiBHth53GLTE29Op05"
Message-ID: <03780c5c-a0d6-43c6-acbb-48543d954e83@inux.ibm.com>
Date: Mon, 22 Dec 2025 16:19:00 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] ppc/pnv: Add OCC FLAG registers
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-5-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251218200353.301866-5-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=69492223 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=r77TgQKjGQsHNAKrUKIA:9
 a=VnNF1IyMAAAA:8 a=gJvJ13wZk_tzsm1i31wA:9 a=lqcHg5cX4UMA:10 a=QEXdDO2ut3YA:10
 a=C6aVSkDANSdmHkZ1WT0A:9 a=_W_S_7VecoQA:10
X-Proofpoint-ORIG-GUID: mEq__4130UnqXHniFseVDznJl3XSZ53O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5OCBTYWx0ZWRfXwVrU053zAViJ
 AY9AVmxTYyDsxGBf2IJcgwuAYd2R1BmH6QlK7SCs6RBem6+fTuJmOA4jbjPVj3COt1OamT2XsYu
 +kN0tl01dQPAsPrgqyQYOBldfyujITIbDcwfJE1aF6nl8ympiMvzEPKUso/HhY9+Ee88jsxR/ba
 G0WPkwZv/eL9YHZRGUfKciKGHKn2bVl6bu65i3JRX06+d/OX/5Yd2QRLy2P0WXPQQ2ho0pO1Ou4
 bKuTtPapxEAAdnMsxnL9Ef7ezXaXr8HFr6EyalyeVtEL99mYcTjESFU4cEkFmjQaS+te727aa4p
 0x0eHX3bm/6TCswsx7BAkIz7sc6/YpTpNR+3i3KgevW4LmTBvEwelKhGbZ9hsPYL9CGq3Ixap6J
 sOXTRRJabxG2FxT6vFsS3TWn4jfpgh67hcfKuS49GpWQs16HqMOjldbJOCpG5LI6BDwJUp04Gwa
 3FFwzGGpgQqrK+bR14Q==
X-Proofpoint-GUID: rDh7DlklemHnQ8DMs8BDDTNQpnQWLh_h
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1034 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220098
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_NONE=0.001 autolearn=ham autolearn_force=no
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
--------------kzndGBMiBHth53GLTE29Op05
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Reviewed-by: Chalapathi V <chalapathi.v@linux.ibm.com 
<mailto:milesg@linux.ibm.com>


On 19/12/25 1:33 am, Caleb Schlossin wrote:
> OCCFLG are scratch registers that can be shared with OCC firmware.
> Log reads and writes to the registers as a reminder when we run
> into more OCC code.
>
> Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c
>
> Signed-off-by: Chalapathi V<chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin<calebs@linux.ibm.com>
> ---
>   hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
>   include/hw/ppc/pnv_occ.h |  4 +++
>   2 files changed, 56 insertions(+), 3 deletions(-)
>
> diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
> index 24b789c191..e605ae0fbc 100644
> --- a/hw/ppc/pnv_occ.c
> +++ b/hw/ppc/pnv_occ.c
> @@ -195,6 +195,49 @@ static const TypeInfo pnv_occ_power8_type_info = {
>   #define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
>   #define P9_OCB_OCI_OCCMISC_OR           0x6082
>   
> +/* OCC scratch registers for flag setting */
> +#define P9_OCCFLG0                      0x60ac
> +#define P9_OCCFLG7_OR                   0x60c3
> +
> +enum ScomType {
> +    SCOM_TYPE_RW          = 0,
> +    SCOM_TYPE_WO_CLEAR    = 1,
> +    SCOM_TYPE_WO_OR       = 2,
> +};
> +
> +static void rw_occ_flag_regs(PnvOCC *occ, uint32_t offset, bool read,
> +        uint64_t *val)
> +{
> +    int flag_num;
> +    int flag_type;
> +
> +    /*
> +     * Each OCCFLG register has SCOM0 - RW, SCOM1 - WO_CLEAR, SCOM2 - WO_OR
> +     * hence devide by 3 to get flag index and mod 3 to get SCOM type.
> +     */
> +    flag_num = (offset - P9_OCCFLG0) / 3;
> +    flag_type = (offset - P9_OCCFLG0) % 3;
> +
> +    if (read) {
> +        if (flag_type) {
> +            qemu_log_mask(LOG_GUEST_ERROR, "OCC: Write only register: Ox%"
> +                      PRIx32 "\n", offset);
> +            return;
> +        }
> +        *val = occ->occflags[flag_num];
> +    } else {
> +        switch (flag_type) {
> +        case SCOM_TYPE_RW:
> +            occ->occflags[flag_num] = *val;
> +            break;
> +        case SCOM_TYPE_WO_CLEAR:
> +            occ->occflags[flag_num] &= ~(*val);
> +            break;
> +        case SCOM_TYPE_WO_OR:
> +            occ->occflags[flag_num] |= *val;
> +        }
> +    }
> +}
>   
>   static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
>                                             unsigned size)
> @@ -207,8 +250,11 @@ static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
>       case P9_OCB_OCI_OCCMISC:
>           val = occ->occmisc;
>           break;
> +    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
> +        rw_occ_flag_regs(occ, offset, 1, &val);
> +        break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register read: Ox%"
>                         HWADDR_PRIx "\n", addr >> 3);
>       }
>       return val;
> @@ -229,9 +275,12 @@ static void pnv_occ_power9_xscom_write(void *opaque, hwaddr addr,
>           break;
>       case P9_OCB_OCI_OCCMISC:
>           pnv_occ_set_misc(occ, val);
> -       break;
> +        break;
> +    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
> +        rw_occ_flag_regs(occ, offset, 0, &val);
> +        break;
>       default:
> -        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
> +        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register write: Ox%"
>                         HWADDR_PRIx "\n", addr >> 3);
>       }
>   }
> diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
> index 013ea2e53e..8c9f1416eb 100644
> --- a/include/hw/ppc/pnv_occ.h
> +++ b/include/hw/ppc/pnv_occ.h
> @@ -47,6 +47,10 @@ struct PnvOCC {
>       /* OCC Misc interrupt */
>       uint64_t occmisc;
>   
> +    /* OCC Flags */
> +#define NR_FLAG_REGS 8
> +    uint32_t occflags[NR_FLAG_REGS];
> +
>       qemu_irq psi_irq;
>   
>       /* OCCs operate on regions of HOMER memory */
--------------kzndGBMiBHth53GLTE29Op05
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
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US">Reviewed-by:
      Chalapathi V <a href="mailto:milesg@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com</a></p>
    <p style="margin:0in;font-family:Calibri;font-size:11.0pt"
      lang="en-US"><br>
    </p>
    <div class="moz-cite-prefix">On 19/12/25 1:33 am, Caleb Schlossin
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20251218200353.301866-5-calebs@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">OCCFLG are scratch registers that can be shared with OCC firmware.
Log reads and writes to the registers as a reminder when we run
into more OCC code.

Add RW, WO_CLEAR and WO_OR SCOM Type enums in pnv_occ.c

Signed-off-by: Chalapathi V <a class="moz-txt-link-rfc2396E" href="mailto:chalapathi.v@linux.ibm.com">&lt;chalapathi.v@linux.ibm.com&gt;</a>
Signed-off-by: Caleb Schlossin <a class="moz-txt-link-rfc2396E" href="mailto:calebs@linux.ibm.com">&lt;calebs@linux.ibm.com&gt;</a>
---
 hw/ppc/pnv_occ.c         | 55 +++++++++++++++++++++++++++++++++++++---
 include/hw/ppc/pnv_occ.h |  4 +++
 2 files changed, 56 insertions(+), 3 deletions(-)

diff --git a/hw/ppc/pnv_occ.c b/hw/ppc/pnv_occ.c
index 24b789c191..e605ae0fbc 100644
--- a/hw/ppc/pnv_occ.c
+++ b/hw/ppc/pnv_occ.c
@@ -195,6 +195,49 @@ static const TypeInfo pnv_occ_power8_type_info = {
 #define P9_OCB_OCI_OCCMISC_CLEAR        0x6081
 #define P9_OCB_OCI_OCCMISC_OR           0x6082
 
+/* OCC scratch registers for flag setting */
+#define P9_OCCFLG0                      0x60ac
+#define P9_OCCFLG7_OR                   0x60c3
+
+enum ScomType {
+    SCOM_TYPE_RW          = 0,
+    SCOM_TYPE_WO_CLEAR    = 1,
+    SCOM_TYPE_WO_OR       = 2,
+};
+
+static void rw_occ_flag_regs(PnvOCC *occ, uint32_t offset, bool read,
+        uint64_t *val)
+{
+    int flag_num;
+    int flag_type;
+
+    /*
+     * Each OCCFLG register has SCOM0 - RW, SCOM1 - WO_CLEAR, SCOM2 - WO_OR
+     * hence devide by 3 to get flag index and mod 3 to get SCOM type.
+     */
+    flag_num = (offset - P9_OCCFLG0) / 3;
+    flag_type = (offset - P9_OCCFLG0) % 3;
+
+    if (read) {
+        if (flag_type) {
+            qemu_log_mask(LOG_GUEST_ERROR, "OCC: Write only register: Ox%"
+                      PRIx32 "\n", offset);
+            return;
+        }
+        *val = occ-&gt;occflags[flag_num];
+    } else {
+        switch (flag_type) {
+        case SCOM_TYPE_RW:
+            occ-&gt;occflags[flag_num] = *val;
+            break;
+        case SCOM_TYPE_WO_CLEAR:
+            occ-&gt;occflags[flag_num] &amp;= ~(*val);
+            break;
+        case SCOM_TYPE_WO_OR:
+            occ-&gt;occflags[flag_num] |= *val;
+        }
+    }
+}
 
 static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
                                           unsigned size)
@@ -207,8 +250,11 @@ static uint64_t pnv_occ_power9_xscom_read(void *opaque, hwaddr addr,
     case P9_OCB_OCI_OCCMISC:
         val = occ-&gt;occmisc;
         break;
+    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
+        rw_occ_flag_regs(occ, offset, 1, &amp;val);
+        break;
     default:
-        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register read: Ox%"
                       HWADDR_PRIx "\n", addr &gt;&gt; 3);
     }
     return val;
@@ -229,9 +275,12 @@ static void pnv_occ_power9_xscom_write(void *opaque, hwaddr addr,
         break;
     case P9_OCB_OCI_OCCMISC:
         pnv_occ_set_misc(occ, val);
-       break;
+        break;
+    case P9_OCCFLG0 ... P9_OCCFLG7_OR:
+        rw_occ_flag_regs(occ, offset, 0, &amp;val);
+        break;
     default:
-        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register: Ox%"
+        qemu_log_mask(LOG_UNIMP, "OCC Unimplemented register write: Ox%"
                       HWADDR_PRIx "\n", addr &gt;&gt; 3);
     }
 }
diff --git a/include/hw/ppc/pnv_occ.h b/include/hw/ppc/pnv_occ.h
index 013ea2e53e..8c9f1416eb 100644
--- a/include/hw/ppc/pnv_occ.h
+++ b/include/hw/ppc/pnv_occ.h
@@ -47,6 +47,10 @@ struct PnvOCC {
     /* OCC Misc interrupt */
     uint64_t occmisc;
 
+    /* OCC Flags */
+#define NR_FLAG_REGS 8
+    uint32_t occflags[NR_FLAG_REGS];
+
     qemu_irq psi_irq;
 
     /* OCCs operate on regions of HOMER memory */
</pre>
    </blockquote>
  </body>
</html>

--------------kzndGBMiBHth53GLTE29Op05--


