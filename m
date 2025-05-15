Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A7CC2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:45:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFaiN-00058u-Fl; Thu, 15 May 2025 11:41:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFai8-0004uu-0y; Thu, 15 May 2025 11:41:29 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFai0-0005zB-Na; Thu, 15 May 2025 11:41:27 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCg4Zg004735;
 Thu, 15 May 2025 15:41:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=8G6dQGfbJS6mL5ZWHNtGFdVyH+8WuRRIFuT2tiGvUtw=; b=AFDlcukVq+1+
 Cd+4QwKGYb8PC4CCieMAMYh7+7q7zAEy8cbRaq/bnMsp8o1wfKLVhtiGEIp979wo
 sj28WusBM/PSbI7vxKMVBEAzkjezH7/I/KfYD5S9axG2Pip9oNKZBs46RmaebqGe
 chygtnmy3qGeNf8+K0Q0C+kLXGvn6fg5gKLZBSEarPwLITQ5w/YeOWOr7FGM0vcM
 vX5HoFUlPW59zRNJokTxx4HiDbhtqFuTphCaWwstRphyvOntFzikG/IjzvzQTsux
 3rulqI741i11VHEEU/82liekPxwmsqUFS7iu/pYRD/NuLXOaCuyPkn2MUJCSnPvy
 h9tsQaNLmA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2v57-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:41:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFfCwr013853;
 Thu, 15 May 2025 15:41:12 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46navu2v55-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:41:12 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE8T4O024281;
 Thu, 15 May 2025 15:41:11 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb0rj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:41:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFf9kr31982286
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:41:09 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B8C4758043;
 Thu, 15 May 2025 15:41:09 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 606C158055;
 Thu, 15 May 2025 15:41:09 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:41:09 +0000 (GMT)
Message-ID: <a8d2f0c6392d4b7918e8eb87a5b0ec4f65f84326.camel@linux.ibm.com>
Subject: Re: [PATCH 07/50] ppc/xive2: Reset Generation Flipped bit on END
 Cache Watch
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:41:09 -0500
In-Reply-To: <20250512031100.439842-8-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-8-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: -2qw1m5wWPGJomI4zsSJiv6IUBaaU6CI
X-Authority-Analysis: v=2.4 cv=XK4wSRhE c=1 sm=1 tr=0 ts=68260b18 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=u5XRYQ9GfIdERzJa8uoA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: DfvAENBixb9VOz-SzfNE6Ea9XGnU98nu
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX0kmkRYufV1Hg
 s2cJ2s5VxWlbnA79hQXfYidgItaVr24Qsc+q/XEeKMVJf9X3w7VdaZteHDbFB0L+Ej1nyNH70lg
 0m7K662ET8RyzSqfJBCxEIfQfdQbGd79/QFtQUxDMfQ4czouwvp+hj7nPd418TQLNPEytPqQK9g
 2gQn8DJ/jQ29A1GGcyNrPXCiZsgsaQPm84Fp8qGrtJ2seDQHrlV7CzNWYEyhP8IPZkp5dHlM6Nr
 dRIaB8/FmfsSnsQbnUAzJ4AvZLsoPxKYVmw1hmC0GmCMUhK7fiNrnqk79FNpB4gEBixpqPaxc8C
 4j58E9mOuRHQCjoUfJ9j3m/GMlF5hNCei01RXcQkzyaDaSk2zfz8EDCTwlvMZAeOEbqNGJzkAHp
 Up/sh0N7DTfgNN0NnC+ZruVGmCZZWvVYOIyw1psG4cTTXuSlcNd71P5XhUYClJzabKIJCdlp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0
 mlxscore=0 bulkscore=0 mlxlogscore=999 clxscore=1015 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 impostorscore=0 adultscore=0
 malwarescore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> From: Michael Kowal <kowal@linux.ibm.com>
> 
> When the END Event Queue wraps the END EQ Generation bit is flipped and the
> Generation Flipped bit is set to one.  On a END cache Watch read operation,
> the Generation Flipped bit needs to be reset.
> 
> While debugging an error modified END not valid error messages to include
> the method since all were the same.
> 
> Signed-off-by: Michael Kowal <kowal@linux.ibm.com>
> ---
>  hw/intc/pnv_xive2.c | 3 ++-
>  hw/intc/xive2.c     | 4 ++--
>  2 files changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index 30b4ab2efe..72cdf0f20c 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1325,10 +1325,11 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>      case VC_ENDC_WATCH3_DATA0:
>          /*
>           * Load DATA registers from cache with data requested by the
> -         * SPEC register
> +         * SPEC register.  Clear gen_flipped bit in word 1.
>           */
>          watch_engine = (offset - VC_ENDC_WATCH0_DATA0) >> 6;
>          pnv_xive2_end_cache_load(xive, watch_engine);
> +        xive->vc_regs[reg] &= ~(uint64_t)END2_W1_GEN_FLIPPED;
>          val = xive->vc_regs[reg];
>          break;
>  
> diff --git a/hw/intc/xive2.c b/hw/intc/xive2.c
> index 4dd04a0398..453fe37f18 100644
> --- a/hw/intc/xive2.c
> +++ b/hw/intc/xive2.c
> @@ -374,8 +374,8 @@ static void xive2_end_enqueue(Xive2End *end, uint32_t data)
>          qgen ^= 1;
>          end->w1 = xive_set_field32(END2_W1_GENERATION, end->w1, qgen);
>  
> -        /* TODO(PowerNV): reset GF bit on a cache watch operation */
> -        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, qgen);
> +        /* Set gen flipped to 1, it gets reset on a cache watch operation */
> +        end->w1 = xive_set_field32(END2_W1_GEN_FLIPPED, end->w1, 1);
>      }
>      end->w1 = xive_set_field32(END2_W1_PAGE_OFF, end->w1, qindex);
>  }


