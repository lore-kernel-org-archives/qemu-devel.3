Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A9ECA600C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt39-00059n-7P; Thu, 08 Oct 2026 14:41:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEt37-000592-Fv; Thu, 08 Oct 2026 14:41:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEt34-0004iM-R0; Thu, 08 Oct 2026 14:41:01 -0400
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HZSb21967373; Thu, 8 Oct 2026 18:40:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=1qCjC7TCnd5Dq5W+iqG95esyxIkmMDl4Wnxxa0cfDRE=; b=YH+pMYklUE6d
 VhtJmI1gyGXRc+xd96oYS1rTz5o07YhS/kY8yCvz3D/nJ6amhbuHVJVYRStGdH90
 ixbS+sEq+DQGhNjCCsOZWz3zhpgkWUK7L5DiehV9xhnl4KLZ09rg/dIzUllgOY+x
 STNEwngstpRWi/AOyntKvyGdiwh65k51Wky5lEPexCSvAX7Biqyo5L0EeRlyPOAg
 +0gz7KsuebNe3YCM12uWsS2Zmnz96vSZs69U2FDQBopIOriaKq4I7azttbS9JSDL
 lXoMSksAHkbXXdgu9+TvQswGCKzDlEQe2L64U7Z5vYHC/g+ko47RUyOfJ0fYkdrz
 loVTQiyCkw==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjvdwac-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 18:40:54 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HWmDs3846246; Thu, 8 Oct 2026 18:40:53 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h3dhh4nfd-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 18:40:53 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698Ieqax31916674
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 18:40:52 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 299FD58059;
 Thu,  8 Oct 2026 18:40:52 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0D2258043;
 Thu,  8 Oct 2026 18:40:50 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 18:40:50 +0000 (GMT)
Message-ID: <74feac838fc31a375c4bbadc0edd46bb2f3da6c7.camel@linux.ibm.com>
Subject: Re: [PATCH 05/10] target/ppc/gdbstub: Replace target_long_bits() by
 ppc_env_is_64bit()
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv@nongnu.org, Pierrick
 Bouvier <pierrick.bouvier@oss.qualcomm.com>, Alex =?ISO-8859-1?Q?Benn=E9e?=
 <alex.bennee@linaro.org>, Richard Henderson <richard.henderson@linaro.org>,
 Anton Johansson <anjo@rev.ng>, qemu-ppc@nongnu.org, Yonggang Luo
 <luoyonggang@gmail.com>, Chinmay Rath <rathc@linux.ibm.com>, Nicholas
 Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>
Date: Thu, 08 Oct 2026 13:40:50 -0500
In-Reply-To: <20261007232326.66240-6-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
 <20261007232326.66240-6-philmd@oss.qualcomm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: KehO7_dYfZlQdJjhkjK4FSWgGtAX2j47
X-Proofpoint-ORIG-GUID: e9g3tFJP0-o835xKX0rumduY8r4KO5dk
X-Authority-Analysis: v=2.4 cv=H8NOUOYi c=1 sm=1 tr=0 ts=6ac7e3b7 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=faDQGt5goccKK3UQXQYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX8xWGXMmgJu7e
 AwkhOu3FPrQr7ZPZY8vsPFxHd28K3IMMJOesU7orWAhMkBrRyU6JnLYeuIlitbFRlCIyiHbb0g1
 AxlkMdL7WDJe/bcWGknz4fow9D8d0DoLPclcgbcBIU2o3cKHq1Cx89eY/lrmh6Jv36+QDWf81LW
 n3LrPbxx+SwXZehp67klSi68AUbutMjoKCPHKtqDY+6oX/8sTheJPWYNH7GMKpnkZgg5NKM/jGy
 7+KzIwl7cx/c0TTU2ar0cCaiaD4g/8tsg5C9qa4yRcKblY2DteLwFmNuw4OA6XUFzhh7yxPqiX7
 QEUQC667OD9IxXEbpHUebCgsgNfjpSRZqD6wSltj6iTjuXk0d6qhjS8vfZth6J5G1s/d6TzUUlU
 Eck4ODK/0KVYe08CrqspK+Y5+k7/JpSqgNUrmEPFCnWb711wYSPcKTWQ0iV7DT29l6OdkkJMmZ7
 IctrOZrnGcMRdr1tNrw==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX0ic91mx0w+Zv
 5wY5LpKlKqrL+iCggthHpY1LCv8PTC8uWLAdcraya0A434Rfoqft45uOcWcJoKO4aR55sQq6VDl
 6Rwr7TVdThooocW+0iaJ1shLJIVJKm4=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0
 clxscore=1011 spamscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610020000 definitions=main-2610080074
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Thu, 2026-10-08 at 01:23 +0200, Philippe Mathieu-Daudé wrote:
> Add a gdb_get_reg_bits() helper deriving the register width from
> ppc_env_is_64bit(), and use it instead of target_long_bits() and
> TARGET_LONG_SIZE.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/ppc/gdbstub.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index 4d622c5cad5..ee02be63ce8 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -23,12 +23,17 @@
>  #include "gdbstub/helpers.h"
>  #include "internal.h"
>  
> -static unsigned ppc_gdb_register_len(int n)
> +static int gdb_get_reg_bits(const CPUPPCState *env)
> +{
> +    return ppc_env_is_64bit(env) ? 64 : 32;
> +}
> +
> +static unsigned ppc_gdb_register_len(const CPUPPCState *env, int n)
>  {
>      switch (n) {
>      case 0 ... 31:
>          /* gprs */
> -        return target_long_bits() / 8;
> +        return gdb_get_reg_bits(env) / 8;
>      case 66:
>          /* cr */
>      case 69:
> @@ -42,7 +47,7 @@ static unsigned ppc_gdb_register_len(int n)
>          /* lr */
>      case 68:
>          /* ctr */
> -        return target_long_bits() / 8;
> +        return gdb_get_reg_bits(env) / 8;
>      default:
>          return 0;
>      }
> @@ -85,7 +90,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>  {
>      CPUPPCState *env = cpu_env(cs);
>      uint8_t *mem_buf;
> -    unsigned r = ppc_gdb_register_len(n);
> +    unsigned r = ppc_gdb_register_len(env, n);
>  
>      if (!r) {
>          return r;
> @@ -127,7 +132,7 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>  int ppc_cpu_gdb_write_register(CPUState *cs, uint8_t *mem_buf, int n)
>  {
>      CPUPPCState *env = cpu_env(cs);
> -    unsigned r = ppc_gdb_register_len(n);
> +    unsigned r = ppc_gdb_register_len(env, n);
>  
>      if (!r) {
>          return r;
> @@ -251,7 +256,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
>          return 0;
>      }
>  
> -    len = TARGET_LONG_SIZE;
> +    len = gdb_get_reg_bits(env) / 8;
>  
>      /* Handle those SPRs that are not part of the env->spr[] array */
>      target_ulong val;
> @@ -294,7 +299,7 @@ static int gdb_set_spr_reg(CPUState *cs, uint8_t *mem_buf, int n)
>          return 0;
>      }
>  
> -    len = TARGET_LONG_SIZE;
> +    len = gdb_get_reg_bits(env) / 8;
>      ppc_maybe_bswap_register(env, mem_buf, len);
>  
>      /* Handle those SPRs that are not part of the env->spr[] array */


