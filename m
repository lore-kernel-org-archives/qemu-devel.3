Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14FADC25B7C
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 15:57:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9RrF-0001dg-Av; Tue, 21 May 2024 11:56:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RrE-0001cD-3K; Tue, 21 May 2024 11:56:56 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9RrC-0000bJ-Ht; Tue, 21 May 2024 11:56:55 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LFGdoF012631; Tue, 21 May 2024 15:56:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=cDfmERDC5u4fKXYJylBblcDK+dH1ZwQ0v1EINeSaxCQ=;
 b=oJl16Q9C/utrGICEOVsXxJASyOyZhdD29hSiT7TtBB2a2puyQUFYGCKxwXL8V/9zyrP4
 9BG22Iz+5YAHt7TCqECLxsrqiyFAfvJTC0rrGFTuRCDmGB8NrJPpddi3H8Vh/4Lxl/d3
 V0UhII2CQQiS4UAzIQYag2XNyPjU5J0DtDPHL3eTyFLo2p1OJ1ZN46U20C/cN6eyW1Io
 2fNLIZ5+FkNrgsO78SOfBaQdZnY41LBowD9eN0amzDAz2FXuRMmzJQDWfynpGqrfdclw
 CCeTW6g2k3SfURQIEUGJtGmJkK14yht3rP1/C+80XrYsv28LoF74k9/fJZBAL6RajrzH FA== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8x3t03kh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:56:52 +0000
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LFuqFn010206;
 Tue, 21 May 2024 15:56:52 GMT
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8x3t03kf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:56:52 +0000
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LETlM5023565; Tue, 21 May 2024 15:56:51 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77np6jta-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 15:56:51 +0000
Received: from smtpav05.wdc07v.mail.ibm.com (smtpav05.wdc07v.mail.ibm.com
 [10.39.53.232])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LFumV226739382
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 15:56:51 GMT
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A669C58043;
 Tue, 21 May 2024 15:56:48 +0000 (GMT)
Received: from smtpav05.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 36BDB58065;
 Tue, 21 May 2024 15:56:48 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav05.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 15:56:48 +0000 (GMT)
Message-ID: <3e0d2db28acb84af56916a6c4f59f58bd0b01cfb.camel@linux.ibm.com>
Subject: Re: [PATCH v2 08/12] target/ppc: Add SMT support to simple SPRs
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 10:56:47 -0500
In-Reply-To: <20240521013029.30082-9-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-9-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: Ym13_ngTq0CIEarEz38OhrNUEDsrzQjX
X-Proofpoint-ORIG-GUID: m4r3gzWTzPFCdpQink585L5ssmNrWyvn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_09,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 mlxscore=0
 mlxlogscore=933 phishscore=0 clxscore=1015 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405210119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Thanks,

Glenn

On Tue, 2024-05-21 at 11:30 +1000, Nicholas Piggin wrote:
> AMOR, MMCRC, HRMOR, TSCR, HMEER, RPR SPRs are per-core or per-LPAR
> registers with simple (generic) implementations.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu_init.c | 12 ++++++------
>  1 file changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 7684a59d75..023b58a3ac 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -246,7 +246,7 @@ static void register_amr_sprs(CPUPPCState *env)
>      spr_register_hv(env, SPR_AMOR, "AMOR",
>                      SPR_NOACCESS, SPR_NOACCESS,
>                      SPR_NOACCESS, SPR_NOACCESS,
> -                    &spr_read_generic, &spr_write_generic,
> +                    &spr_read_generic, &spr_core_lpar_write_generic,
>                      0);
>  #endif /* !CONFIG_USER_ONLY */
>  }
> @@ -5489,7 +5489,7 @@ static void
> register_book3s_ids_sprs(CPUPPCState *env)
>      spr_register_hv(env, SPR_MMCRC, "MMCRC",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic32,
> +                 &spr_read_generic, &spr_core_write_generic32,
>                   0x00000000);
>      spr_register_hv(env, SPR_MMCRH, "MMCRH",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -5529,7 +5529,7 @@ static void
> register_book3s_ids_sprs(CPUPPCState *env)
>      spr_register_hv(env, SPR_HRMOR, "HRMOR",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> +                 &spr_read_generic, &spr_core_write_generic,
>                   0x00000000);
>  }
>  
> @@ -5757,7 +5757,7 @@ static void
> register_power_common_book4_sprs(CPUPPCState *env)
>      spr_register_hv(env, SPR_TSCR, "TSCR",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic32,
> +                 &spr_read_generic, &spr_core_write_generic32,
>                   0x00000000);
>      spr_register_hv(env, SPR_HMER, "HMER",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -5767,7 +5767,7 @@ static void
> register_power_common_book4_sprs(CPUPPCState *env)
>      spr_register_hv(env, SPR_HMEER, "HMEER",
>                   SPR_NOACCESS, SPR_NOACCESS,
>                   SPR_NOACCESS, SPR_NOACCESS,
> -                 &spr_read_generic, &spr_write_generic,
> +                 &spr_read_generic, &spr_core_write_generic,
>                   0x00000000);
>      spr_register_hv(env, SPR_TFMR, "TFMR",
>                   SPR_NOACCESS, SPR_NOACCESS,
> @@ -5843,7 +5843,7 @@ static void
> register_power8_rpr_sprs(CPUPPCState *env)
>      spr_register_hv(env, SPR_RPR, "RPR",
>                      SPR_NOACCESS, SPR_NOACCESS,
>                      SPR_NOACCESS, SPR_NOACCESS,
> -                    &spr_read_generic, &spr_write_generic,
> +                    &spr_read_generic, &spr_core_write_generic,
>                      0x00000103070F1F3F);
>  #endif
>  }


