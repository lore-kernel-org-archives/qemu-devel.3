Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4FAECA600D
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Oct 2026 18:43:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEt5E-00076X-OH; Thu, 08 Oct 2026 14:43:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEt59-00074a-MS; Thu, 08 Oct 2026 14:43:07 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1xEt58-00050e-22; Thu, 08 Oct 2026 14:43:07 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HZQ5q197221; Thu, 8 Oct 2026 18:43:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=bdFEie4P4Rfe4+nT4USX4cl8L21lZ+OcpPSzewK+ivc=; b=i/2OaFxuxKLq
 zsYkrP+j0Ea046dxLh+elbmIpgpIOGbiKxOrnYC/QgqidkOwU4iTJo+HWJfXbOdS
 DEJfrsLETrWufDB3M6tWwmKbj8vUcowK5/Iu1HZVbpdvTu1umiTVtpjkNEoUQ+4B
 6RCHdW9RFHzAdoTMC4Jdk1GoZUhWulhBhEhregx5bNnMTtOgHqFBje4bFi0/yArR
 QC3qcUdBUVsA+nyUvBvFsBTDHeRYOTtimpFs2Q6Qs+yQmccZ/AmdQH9SId0Valhn
 2Ts18o1AQnuymthgz1VZUN/2ZCqUaRWi8FX3VcsXO3MZiCYlk48OqzLWFHjqbfaP
 uEG18m1W1w==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h5xjw5xmk-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 18:43:02 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 698HldvN3802948; Thu, 8 Oct 2026 18:43:01 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4h5s34wex5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 08 Oct 2026 18:43:01 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (smtpav06.wdc07v.mail.ibm.com
 [10.39.53.233])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 698Ih0Ir32572064
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 8 Oct 2026 18:43:00 GMT
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 900455804E;
 Thu,  8 Oct 2026 18:43:00 +0000 (GMT)
Received: from smtpav06.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 85C585803F;
 Thu,  8 Oct 2026 18:42:59 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  8 Oct 2026 18:42:59 +0000 (GMT)
Message-ID: <2456f502c974d0fcc09e4e29e2756b4f26d23b3d.camel@linux.ibm.com>
Subject: Re: [PATCH 06/10] target/ppc/gdbstub: Replace gdb_get_regl() by
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
Date: Thu, 08 Oct 2026 13:42:59 -0500
In-Reply-To: <20261007232326.66240-7-philmd@oss.qualcomm.com>
References: <20261007232326.66240-1-philmd@oss.qualcomm.com>
 <20261007232326.66240-7-philmd@oss.qualcomm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: G2vvVZX4HaiZVmpu3vdphOgVrRiTEZd0
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfX/DZnkgwedx3I
 BiYHdkW2hq94BNy1s3GAiUkFcA0x5ZEE5xn2YqtfowgQgV+DLcqdUYEYJFU5FAQO0ho0477tArz
 k1kV8ZgtLrXB7JLktKRsN+k07q9bjotaxL3QgOifrJHPuvOge4xirK1jnlNPRsN3ZJRv6lbYbsr
 t5ZvSO8eJjEBEgWL7Je4BhpgFOgNFZRoaY4HpEMhQIFb0D24SgBMzhF7yJbh8/YmsAy4QCWJHAV
 RXvacWJAjnoVvbYI6FxqbiaTxIYLrBohDU6ZypsTkdkRbCLdHYZCPtipCYwQ48cVD1aJsuoJWMQ
 D/596qW/E4qGq5Z8B4bZNeb0n2s5Fgd0b7hxESlW9BqJrwjCndHgYnoWGWOk8d6fvqU+sAUTpcN
 KuFC7J2SW2I+fuIfsgo2DgqrXbr5zJoIodatlSTfq69iEaxoKC9em/L9BOnxADYaALLCsw8jutl
 YHFqo5UWeAVas3m3VGw==
X-Authority-Analysis: v=2.4 cv=cIt1IVeN c=1 sm=1 tr=0 ts=6ac7e437 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=EUspDBNiAAAA:8 a=faDQGt5goccKK3UQXQYA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDA4MDA3NCBTYWx0ZWRfXxHTPvjWzIp1D
 fdwyybiXfAis4l0W8ZaAebFa4y9SGam5riKr2fFgtnipLNplpsRm69AmtDTKO+e73STBhJ3DiNq
 a90jGv3JPRSt0zdUADNXAmbLIF8pWbc=
X-Proofpoint-ORIG-GUID: Y7q7is2_8rIjwERjJa5wfdiMDlh7a1hw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-08_06,2026-10-08_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 malwarescore=0 priorityscore=1501 adultscore=0 impostorscore=0
 lowpriorityscore=0 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0
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
> Inline the deprecated gdb_get_regl() as ppc_gdb_get_regl(),
> replacing the target_long_bits() check by a ppc_env_is_64bit()
> one.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@oss.qualcomm.com>
> ---
>  target/ppc/gdbstub.c | 19 +++++++++++++------
>  1 file changed, 13 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/gdbstub.c b/target/ppc/gdbstub.c
> index ee02be63ce8..0071c2b3bab 100644
> --- a/target/ppc/gdbstub.c
> +++ b/target/ppc/gdbstub.c
> @@ -53,6 +53,13 @@ static unsigned ppc_gdb_register_len(const CPUPPCState *env, int n)
>      }
>  }
>  
> +static inline int ppc_gdb_get_regl(const CPUPPCState *env,
> +                                   GByteArray *buf, uint64_t val)
> +{
> +    return ppc_env_is_64bit(env) ? gdb_get_reg64(buf, val)
> +                                 : gdb_get_reg32(buf, val);
> +}
> +
>  /*
>   * We need to present the registers to gdb in the "current" memory
>   * ordering.  For user-only mode we get this for free;
> @@ -98,14 +105,14 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>  
>      if (n < 32) {
>          /* gprs */
> -        gdb_get_regl(buf, env->gpr[n]);
> +        ppc_gdb_get_regl(env, buf, env->gpr[n]);
>      } else {
>          switch (n) {
>          case 64:
> -            gdb_get_regl(buf, env->nip);
> +            ppc_gdb_get_regl(env, buf, env->nip);
>              break;
>          case 65:
> -            gdb_get_regl(buf, env->msr);
> +            ppc_gdb_get_regl(env, buf, env->msr);
>              break;
>          case 66:
>              {
> @@ -114,10 +121,10 @@ int ppc_cpu_gdb_read_register(CPUState *cs, GByteArray *buf, int n)
>                  break;
>              }
>          case 67:
> -            gdb_get_regl(buf, env->lr);
> +            ppc_gdb_get_regl(env, buf, env->lr);
>              break;
>          case 68:
> -            gdb_get_regl(buf, env->ctr);
> +            ppc_gdb_get_regl(env, buf, env->ctr);
>              break;
>          case 69:
>              gdb_get_reg32(buf, cpu_read_xer(env));
> @@ -281,7 +288,7 @@ static int gdb_get_spr_reg(CPUState *cs, GByteArray *buf, int n)
>      default:
>          val = env->spr[reg];
>      }
> -    gdb_get_regl(buf, val);
> +    ppc_gdb_get_regl(env, buf, val);
>  
>      ppc_maybe_bswap_register(env, gdb_get_reg_ptr(buf, len), len);
>      return len;


