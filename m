Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD6C3CCA471
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Oct 2025 15:47:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v5nQ2-0002nv-3Y; Mon, 06 Oct 2025 11:46:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nPi-0002f2-O4; Mon, 06 Oct 2025 11:46:15 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kowal@linux.ibm.com>)
 id 1v5nPY-0008Oq-KD; Mon, 06 Oct 2025 11:46:14 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 596ATCl5021607;
 Mon, 6 Oct 2025 15:46:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=ZQl+PfGWTw7Lp/I+2v0Y9BbD5y03hS
 ie24SJraCFJHo=; b=V0wbyfHxaysx1OMJEb/3g8qA1oODOJSXZE6gXFXHLuee2A
 Ph++BDT+flkwYZBeWJO0hGS6qvAwHYjY+0JVTEyyXglbS35+8SW+8MMxOZwJmpPI
 S/LHQk0i50bWZGgrqxcey/8qt/eMXZAORVWHW2tSc+si5ucqfDtexxh0Nv1i48cn
 nUsUZhXeIlLkilWsYgAbUPkelX7/wDuzxvPivC9S4MHTH0kc+Y5ZbgI3BMXQxpFw
 zFm8aPVyN3BSDuX7pdrP/dBsLaPOoKl1EMHLIcAxsARFb3fx6E5KYewF1DNuKhTV
 22M4LP4HtO+vnUt/FTXh7HKVmvu0hCG3GLeTYMmg==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gtasf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:01 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 596FU0uo004089;
 Mon, 6 Oct 2025 15:46:00 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49ju3gtasa-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:46:00 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 596E3dPd013252;
 Mon, 6 Oct 2025 15:45:59 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 49kg4jem1v-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Oct 2025 15:45:59 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 596Fjwmu32375544
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Oct 2025 15:45:58 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 909AB58055;
 Mon,  6 Oct 2025 15:45:58 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0B62B58043;
 Mon,  6 Oct 2025 15:45:58 +0000 (GMT)
Received: from [9.10.80.187] (unknown [9.10.80.187])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Oct 2025 15:45:57 +0000 (GMT)
Content-Type: multipart/alternative;
 boundary="------------nVuPPYoj8LyFO7WqWVJfSARb"
Message-ID: <8297a074-48eb-4b27-bf80-530d7a9165de@linux.ibm.com>
Date: Mon, 6 Oct 2025 10:45:57 -0500
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 2/8] ppc/pnv: Introduce Power11 PowerNV machine
To: Aditya Gupta <adityag@linux.ibm.com>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
Cc: Mahesh J Salgaonkar <mahesh@linux.ibm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Gautam Menghani <gautam@linux.ibm.com>, Miles Glenn <milesg@linux.ibm.com>,
 Ganesh Goudar <ganeshgr@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
References: <20250925173049.891406-1-adityag@linux.ibm.com>
 <20250925173049.891406-3-adityag@linux.ibm.com>
Content-Language: en-US
From: Mike Kowal <kowal@linux.ibm.com>
In-Reply-To: <20250925173049.891406-3-adityag@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA0MDAxOCBTYWx0ZWRfX7fIVDjrgSZQt
 fn3EzATn1gVgpPKuHNNoTEmme9Vc6E1zinNGQ7mxInCF4araxCSQ9LEmN9fEt1dAE2JM3tuIzUe
 aGsCyecMfNAtER70nPGZF5+YoYm8IoImn13fs46VzM0Al2JhKwBoiWy9EbWks1MFUU+3qBTjyZg
 v994exxVWGzvm5QpCUAHtUGhRh+f0dbN25PEQ8XKc3grfzo/TeB27lVv3mony7uu3xuv3dSJsnu
 upCGTkiCqOG5zszz1vk7uxoRw1t0JVHqHQkNT3SM4bXDFt+2xB9KH19/XiWXpukGyli3i6/knQ7
 9iG3Se5qD5Z9CXsXyFbVolkFwpQf56H/p2b0EUqLO60Y4DIQcTIATBSYALKJwiSgzEOqar4Xbob
 YbhyLASOieh/sBCxWy4Eh30abf42mg==
X-Authority-Analysis: v=2.4 cv=I4dohdgg c=1 sm=1 tr=0 ts=68e3e439 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=r77TgQKjGQsHNAKrUKIA:9 a=VnNF1IyMAAAA:8 a=20KFwNOVAAAA:8
 a=1UR8Im32czIPWn87Am4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=0il2isBTLgtUhG5GGzUA:9 a=aGqWdGhd_JU3wt19:21 a=_W_S_7VecoQA:10
 a=lqcHg5cX4UMA:10
X-Proofpoint-GUID: RLdOfra7oYQbCTpuPSVHh8jkjBS8DDFu
X-Proofpoint-ORIG-GUID: xUsi5DiOFbSSar66VRfhmvMrifEo-zQn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-06_05,2025-10-02_03,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 lowpriorityscore=0 malwarescore=0 adultscore=0 spamscore=0
 bulkscore=0 suspectscore=0 clxscore=1015 priorityscore=1501 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2509150000 definitions=main-2510040018
Received-SPF: pass client-ip=148.163.156.1; envelope-from=kowal@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, HTML_MESSAGE=0.001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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
--------------nVuPPYoj8LyFO7WqWVJfSARb
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 9/25/2025 12:30 PM, Aditya Gupta wrote:
> The Powernv11 machine doesn't have XIVE & PHBs as of now
>
> XIVE2 interface and PHB5 added in later patches to Powernv11 machine
>
> Also add mention of Power11 to powernv documentation
>
> Note: A difference from P10's and P11's machine_class_init is, in P11
> different number of PHBs cannot be used on the command line, ie. the
> following line does NOT exist in pnv_machine_power11_class_init, which
> existed in case of Power10:
>
>      machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);

Reviewed-by: Michael Kowal<kowal@linux.ibm.com>


> Reviewed-by: Cédric Le Goater<clg@redhat.com>
> Signed-off-by: Aditya Gupta<adityag@linux.ibm.com>
> ---
>   docs/system/ppc/powernv.rst |  9 +++++----
>   hw/ppc/pnv.c                | 34 ++++++++++++++++++++++++++++++++++
>   2 files changed, 39 insertions(+), 4 deletions(-)
>
> diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
> index f3ec2cc69c0d..5154794cc8cd 100644
> --- a/docs/system/ppc/powernv.rst
> +++ b/docs/system/ppc/powernv.rst
> @@ -1,5 +1,5 @@
> -PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``)
> -==================================================================
> +PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``, ``powernv11``)
> +================================================================================
>   
>   PowerNV (as Non-Virtualized) is the "bare metal" platform using the
>   OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can
> @@ -15,11 +15,12 @@ beyond the scope of what QEMU addresses today.
>   Supported devices
>   -----------------
>   
> - * Multi processor support for POWER8, POWER8NVL and POWER9.
> + * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
>    * XSCOM, serial communication sideband bus to configure chiplets.
>    * Simple LPC Controller.
>    * Processor Service Interface (PSI) Controller.
> - * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
> + * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &
> +   Power11).
>    * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
>    * Simple OCC is an on-chip micro-controller used for power management tasks.
>    * iBT device to handle BMC communication, with the internal BMC simulator
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 77136091bbca..423954ba7e0c 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -3235,6 +3235,35 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
>       pmc->i2c_init = pnv_rainier_i2c_init;
>   }
>   
> +static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
> +{
> +    MachineClass *mc = MACHINE_CLASS(oc);
> +    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
> +    static const char compat[] = "qemu,powernv11\0ibm,powernv";
> +
> +    pmc->compat = compat;
> +    pmc->compat_size = sizeof(compat);
> +    pmc->max_smt_threads = 4;
> +    pmc->has_lpar_per_thread = true;
> +    pmc->quirk_tb_big_core = true;
> +    pmc->dt_power_mgt = pnv_dt_power_mgt;
> +
> +    mc->desc = "IBM PowerNV (Non-Virtualized) Power11";
> +    mc->default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
> +
> +    object_class_property_add_bool(oc, "big-core",
> +                                   pnv_machine_get_big_core,
> +                                   pnv_machine_set_big_core);
> +    object_class_property_set_description(oc, "big-core",
> +                              "Use big-core (aka fused-core) mode");
> +
> +    object_class_property_add_bool(oc, "lpar-per-core",
> +                                   pnv_machine_get_lpar_per_core,
> +                                   pnv_machine_set_lpar_per_core);
> +    object_class_property_set_description(oc, "lpar-per-core",
> +                              "Use 1 LPAR per core mode");
> +}
> +
>   static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
>   {
>       CPUPPCState *env = cpu_env(cs);
> @@ -3348,6 +3377,11 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
>       }
>   
>   static const TypeInfo types[] = {
> +    {
> +        .name          = MACHINE_TYPE_NAME("powernv11"),
> +        .parent        = TYPE_PNV_MACHINE,
> +        .class_init    = pnv_machine_power11_class_init,
> +    },
>       {
>           .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
>           .parent        = MACHINE_TYPE_NAME("powernv10"),
--------------nVuPPYoj8LyFO7WqWVJfSARb
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: 8bit

<!DOCTYPE html>
<html>
  <head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  </head>
  <body>
    <p><br>
    </p>
    <div class="moz-cite-prefix">On 9/25/2025 12:30 PM, Aditya Gupta
      wrote:<br>
    </div>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-3-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">The Powernv11 machine doesn't have XIVE &amp; PHBs as of now

XIVE2 interface and PHB5 added in later patches to Powernv11 machine

Also add mention of Power11 to powernv documentation

Note: A difference from P10's and P11's machine_class_init is, in P11
different number of PHBs cannot be used on the command line, ie. the
following line does NOT exist in pnv_machine_power11_class_init, which
existed in case of Power10:

    machine_class_allow_dynamic_sysbus_dev(mc, TYPE_PNV_PHB);
</pre>
    </blockquote>
    <pre>Reviewed-by: Michael Kowal <a class="moz-txt-link-rfc2396E" href="mailto:kowal@linux.ibm.com">&lt;kowal@linux.ibm.com&gt;</a></pre>
    <p><br>
    </p>
    <blockquote type="cite"
      cite="mid:20250925173049.891406-3-adityag@linux.ibm.com">
      <pre wrap="" class="moz-quote-pre">
Reviewed-by: Cédric Le Goater <a class="moz-txt-link-rfc2396E" href="mailto:clg@redhat.com">&lt;clg@redhat.com&gt;</a>
Signed-off-by: Aditya Gupta <a class="moz-txt-link-rfc2396E" href="mailto:adityag@linux.ibm.com">&lt;adityag@linux.ibm.com&gt;</a>
---
 docs/system/ppc/powernv.rst |  9 +++++----
 hw/ppc/pnv.c                | 34 ++++++++++++++++++++++++++++++++++
 2 files changed, 39 insertions(+), 4 deletions(-)

diff --git a/docs/system/ppc/powernv.rst b/docs/system/ppc/powernv.rst
index f3ec2cc69c0d..5154794cc8cd 100644
--- a/docs/system/ppc/powernv.rst
+++ b/docs/system/ppc/powernv.rst
@@ -1,5 +1,5 @@
-PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``)
-==================================================================
+PowerNV family boards (``powernv8``, ``powernv9``, ``powernv10``, ``powernv11``)
+================================================================================
 
 PowerNV (as Non-Virtualized) is the "bare metal" platform using the
 OPAL firmware. It runs Linux on IBM and OpenPOWER systems and it can
@@ -15,11 +15,12 @@ beyond the scope of what QEMU addresses today.
 Supported devices
 -----------------
 
- * Multi processor support for POWER8, POWER8NVL and POWER9.
+ * Multi processor support for POWER8, POWER8NVL, POWER9, Power10 and Power11.
  * XSCOM, serial communication sideband bus to configure chiplets.
  * Simple LPC Controller.
  * Processor Service Interface (PSI) Controller.
- * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10).
+ * Interrupt Controller, XICS (POWER8) and XIVE (POWER9) and XIVE2 (Power10 &amp;
+   Power11).
  * POWER8 PHB3 PCIe Host bridge and POWER9 PHB4 PCIe Host bridge.
  * Simple OCC is an on-chip micro-controller used for power management tasks.
  * iBT device to handle BMC communication, with the internal BMC simulator
diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
index 77136091bbca..423954ba7e0c 100644
--- a/hw/ppc/pnv.c
+++ b/hw/ppc/pnv.c
@@ -3235,6 +3235,35 @@ static void pnv_machine_p10_rainier_class_init(ObjectClass *oc,
     pmc-&gt;i2c_init = pnv_rainier_i2c_init;
 }
 
+static void pnv_machine_power11_class_init(ObjectClass *oc, const void *data)
+{
+    MachineClass *mc = MACHINE_CLASS(oc);
+    PnvMachineClass *pmc = PNV_MACHINE_CLASS(oc);
+    static const char compat[] = "qemu,powernv11\0ibm,powernv";
+
+    pmc-&gt;compat = compat;
+    pmc-&gt;compat_size = sizeof(compat);
+    pmc-&gt;max_smt_threads = 4;
+    pmc-&gt;has_lpar_per_thread = true;
+    pmc-&gt;quirk_tb_big_core = true;
+    pmc-&gt;dt_power_mgt = pnv_dt_power_mgt;
+
+    mc-&gt;desc = "IBM PowerNV (Non-Virtualized) Power11";
+    mc-&gt;default_cpu_type = POWERPC_CPU_TYPE_NAME("power11_v2.0");
+
+    object_class_property_add_bool(oc, "big-core",
+                                   pnv_machine_get_big_core,
+                                   pnv_machine_set_big_core);
+    object_class_property_set_description(oc, "big-core",
+                              "Use big-core (aka fused-core) mode");
+
+    object_class_property_add_bool(oc, "lpar-per-core",
+                                   pnv_machine_get_lpar_per_core,
+                                   pnv_machine_set_lpar_per_core);
+    object_class_property_set_description(oc, "lpar-per-core",
+                              "Use 1 LPAR per core mode");
+}
+
 static void pnv_cpu_do_nmi_on_cpu(CPUState *cs, run_on_cpu_data arg)
 {
     CPUPPCState *env = cpu_env(cs);
@@ -3348,6 +3377,11 @@ static void pnv_machine_class_init(ObjectClass *oc, const void *data)
     }
 
 static const TypeInfo types[] = {
+    {
+        .name          = MACHINE_TYPE_NAME("powernv11"),
+        .parent        = TYPE_PNV_MACHINE,
+        .class_init    = pnv_machine_power11_class_init,
+    },
     {
         .name          = MACHINE_TYPE_NAME("powernv10-rainier"),
         .parent        = MACHINE_TYPE_NAME("powernv10"),
</pre>
    </blockquote>
  </body>
</html>

--------------nVuPPYoj8LyFO7WqWVJfSARb--


