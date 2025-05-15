Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FB77C3DA6D
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 15:52:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFas3-0000X3-V9; Thu, 15 May 2025 11:51:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFarx-0000NR-Ar; Thu, 15 May 2025 11:51:40 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFars-00076W-AE; Thu, 15 May 2025 11:51:36 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgGQj002606;
 Thu, 15 May 2025 15:51:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=bb76EGushOB8klMmBVskrxUzYz4mlCvxy41Gm7tRr3M=; b=j6WSZem/xPU6
 K0WpxmcCgQNlAGVH2qaqOU1i0UR+Sn5sCrY1x5+WwIuQOULHD6TwGIfgj5QV4MBD
 lZb9WHc6r78D7eYkN6+zrSnc6rtplES2sqnEtJ12Optb/9Hrig4Y0FaU42iV2zkG
 uhyQFScU+MhH9PlXtke8LemQN6sLau8Wm9TQhcfF93Gp+u+XqH3sMziReV59GMJo
 46TTQ7CcrxGQQD4UQ3QW8k3nYhAFcF3J0CZZwDhkj+OP6jqclkUjiAepTZ7niLFU
 Oe3FMm7aW91iZVKy6IYL1ZuycXMwWaLPk8KuZnCLn2C3Z638Ya4lillfzkTvJOT0
 SuHCC5rZfw==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nerh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:51:28 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FFTPpS011769;
 Thu, 15 May 2025 15:51:27 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46n0v6nere-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:51:27 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FDY9lB019455;
 Thu, 15 May 2025 15:51:27 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 46mbfru2b3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 15:51:27 +0000
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FFpQOi20775522
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 15:51:26 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0DB4B5805F;
 Thu, 15 May 2025 15:51:26 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7ACD95805C;
 Thu, 15 May 2025 15:51:25 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 15:51:25 +0000 (GMT)
Message-ID: <abfaf4a88e44accff68653df159fbc28cf45d7e6.camel@linux.ibm.com>
Subject: Re: [PATCH 19/50] pnv/xive2: VC_ENDC_WATCH_SPEC regs should read
 back WATCH_FULL
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 10:51:25 -0500
In-Reply-To: <20250512031100.439842-20-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-20-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=IqAecK/g c=1 sm=1 tr=0 ts=68260d80 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=OIwot2dQPgAvwoVT6JIA:9 a=QEXdDO2ut3YA:10
 a=gZLHJPz4sbkA:10
X-Proofpoint-ORIG-GUID: HYhE7hOPaWqkQLAkuOD9RbjxkRrnzPps
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE1NSBTYWx0ZWRfX8eQ0GzaEWjyB
 rWMr3SoE1LRA8NcFgglvg7X3FA2VIFm8RsBPBI4XTETpJvj05kshLWTmvIx4M+qYvee2z4jc2nu
 ILISguaSca0qH/cfHebR3sldgp403tyFIi55p6HPNwES4QZZB3L2N5/2LEBBQ+TcMrU9iFpvVz3
 kZXeIlUedTbYeUphnj3X/zi06Bcicja2nKcF8knB2//lUksezOqHcUwe2nQ/yulgkfw3HbL/wjS
 ScpQRIjRnaA/hUhNGtqqz4BQM/EdVIDJhwlHuZQNlWk6hcZaTO9R+yoDiS4scX5oUZKMRQfLU11
 aC2cqdU8FBAoGa7tA3ZWZPKxZf2mVo0jKi646JY9sL7R+ln01RuxLGbpJ89KEEqlUdtwstMZd2q
 qmHwxstM091nO7xZPvOw8fL52OxzzYZ/zZXv7BZgm/F0pJ3q9Q4nlgEbAzKITtmy6xoa5/h3
X-Proofpoint-GUID: uX6NV4BRftpcZnvB-J6yJOWO9bGko6an
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_06,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxscore=0 malwarescore=0
 adultscore=0 lowpriorityscore=0 phishscore=0 impostorscore=0
 priorityscore=1501 clxscore=1015 spamscore=0 mlxlogscore=891 bulkscore=0
 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150155
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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
> Firmware expects to read back the WATCH_FULL bit from the VC_ENDC_WATCH_SPEC
> register, so don't clear it on read.
> 
> Don't bother clearing the reads-as-zero CONFLICT bit because it's masked
> at write already.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/pnv_xive2.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/hw/intc/pnv_xive2.c b/hw/intc/pnv_xive2.c
> index fcf5b2e75c..3c26cd6b77 100644
> --- a/hw/intc/pnv_xive2.c
> +++ b/hw/intc/pnv_xive2.c
> @@ -1329,7 +1329,6 @@ static uint64_t pnv_xive2_ic_vc_read(void *opaque, hwaddr offset,
>      case VC_ENDC_WATCH2_SPEC:
>      case VC_ENDC_WATCH3_SPEC:
>          watch_engine = (offset - VC_ENDC_WATCH0_SPEC) >> 6;
> -        xive->vc_regs[reg] &= ~(VC_ENDC_WATCH_FULL | VC_ENDC_WATCH_CONFLICT);
>          pnv_xive2_endc_cache_watch_release(xive, watch_engine);
>          val = xive->vc_regs[reg];
>          break;


