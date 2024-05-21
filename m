Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5444EC25B74
	for <qemu-devel@archiver.kernel.org>; Tue, 21 May 2024 16:41:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9SYK-0002Z6-KS; Tue, 21 May 2024 12:41:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9SYD-0002XQ-CL; Tue, 21 May 2024 12:41:21 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s9SYB-0000hD-23; Tue, 21 May 2024 12:41:20 -0400
Received: from pps.filterd (m0353728.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LGetUs005872; Tue, 21 May 2024 16:41:16 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=fUb4csHg/gUW40OkXqM2pa1qzzKpuUdrj4yi5fdS+7A=;
 b=P+Mv5LVuQD+jP4CfDVLqPe0+OMKtLBuQc6FioCCjmYccHGP3znONz99Vg936m5TYAZ4y
 1sa7EPmSTyOLNZnjEYU/axJPmXxRh0+o5tVjrywofjCZFQQ9zq4I27n6AKkfNCxrGref
 HcNsALrAjkyV3g3puBxCNHS3ziEIH3aoe/YuyCDeEtx3CiiIANh51rQ/GS15MIyOcrPR
 u7AhEPRcwqvn2k6OQRYVp5pO6DfEy5Ur2nHIOZ+AyUrk9LNvuuTzneymX6e8ZLXZRrmY
 9dg9Hh7mdsK/AAogmwW+/mXWrfUA/RQi5KBv2l7sFbj9QJwP6oLIfAxpsBNDBMuB06jm LQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8y53r0ww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:41:15 +0000
Received: from m0353728.ppops.net (m0353728.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44LGfFGI006953;
 Tue, 21 May 2024 16:41:15 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y8y53r0wr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:41:15 +0000
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44LE55et000898; Tue, 21 May 2024 16:41:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 3y77206xmu-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 21 May 2024 16:41:13 +0000
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44LGfBEY64815472
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 21 May 2024 16:41:13 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8BCFA58045;
 Tue, 21 May 2024 16:41:11 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2848758054;
 Tue, 21 May 2024 16:41:11 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 21 May 2024 16:41:11 +0000 (GMT)
Message-ID: <8aebdcbb3feed5b943ca8dc09fae11720447d287.camel@linux.ibm.com>
Subject: Re: [PATCH v2 10/12] target/ppc: Implement LDBAR, TTR SPRs
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>, Chinmay Rath
 <rathc@linux.ibm.com>
Date: Tue, 21 May 2024 11:41:10 -0500
In-Reply-To: <20240521013029.30082-11-npiggin@gmail.com>
References: <20240521013029.30082-1-npiggin@gmail.com>
 <20240521013029.30082-11-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: WMkLgNJ8b-wbb77Eb6C1ieIfLuVterLo
X-Proofpoint-GUID: L-jm1UoorKA7hjUX82JMPBTCw5idcx-e
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-21_10,2024-05-21_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0
 mlxscore=0 clxscore=1015 malwarescore=0 mlxlogscore=967 lowpriorityscore=0
 priorityscore=1501 suspectscore=0 spamscore=0 bulkscore=0 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2405010000
 definitions=main-2405210126
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
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
> LDBAR, TTR are a Power-specific SPRs. These simple implementations
> are enough for IBM proprietary firmware for now.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  target/ppc/cpu.h      |  2 ++
>  target/ppc/cpu_init.c | 10 ++++++++++
>  2 files changed, 12 insertions(+)
> 
> diff --git a/target/ppc/cpu.h b/target/ppc/cpu.h
> index 141cbefb4c..823be85d03 100644
> --- a/target/ppc/cpu.h
> +++ b/target/ppc/cpu.h
> @@ -2098,6 +2098,7 @@ void ppc_compat_add_property(Object *obj, const
> char *name,
>  #define SPR_DEXCR             (0x33C)
>  #define SPR_IC                (0x350)
>  #define SPR_VTB               (0x351)
> +#define SPR_LDBAR             (0x352)
>  #define SPR_MMCRC             (0x353)
>  #define SPR_PSSCR             (0x357)
>  #define SPR_440_INV0          (0x370)
> @@ -2144,6 +2145,7 @@ void ppc_compat_add_property(Object *obj, const
> char *name,
>  #define SPR_440_IVLIM         (0x399)
>  #define SPR_TSCR              (0x399)
>  #define SPR_750_DMAU          (0x39A)
> +#define SPR_POWER_TTR         (0x39A)
>  #define SPR_750_DMAL          (0x39B)
>  #define SPR_440_RSTCFG        (0x39B)
>  #define SPR_BOOKE_DCDBTRL     (0x39C)
> diff --git a/target/ppc/cpu_init.c b/target/ppc/cpu_init.c
> index 023b58a3ac..7f2f8e5a4a 100644
> --- a/target/ppc/cpu_init.c
> +++ b/target/ppc/cpu_init.c
> @@ -5784,6 +5784,16 @@ static void
> register_power_common_book4_sprs(CPUPPCState *env)
>                   &spr_access_nop, &spr_write_generic,
>                   &spr_access_nop, &spr_write_generic,
>                   0x00000000);
> +    spr_register_hv(env, SPR_LDBAR, "LDBAR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_core_lpar_write_generic,
> +                 0x00000000);
> +    spr_register_hv(env, SPR_POWER_TTR, "TTR",
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 SPR_NOACCESS, SPR_NOACCESS,
> +                 &spr_read_generic, &spr_core_write_generic,
> +                 0x00000000);
>  #endif
>  }
>  


