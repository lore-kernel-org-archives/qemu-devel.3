Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85CD8C5B572
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 15:56:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvzh4-0005wE-Rg; Mon, 17 Aug 2026 11:56:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzh3-0005vx-AY; Mon, 17 Aug 2026 11:56:09 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wvzh0-0005Ni-3d; Mon, 17 Aug 2026 11:56:09 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67HFg7KS699072; Mon, 17 Aug 2026 15:56:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=nkkiJrZ7HoOQKObl1EQMdWLCMmynkoLxAf9SabZljps=; b=UiiV6LxdqjBB
 /MwuFRvEsrRAPVkjADPBWtA3uDuUYrpxihvvUz+R8uAX21gB6pW8amvf0j7AxVbW
 SMBYBnfAh3fVngx+cG6HA+RlktQRXTQa8TPUxPg6XI9HDYVsBucZg4aWBbdgDIdF
 7tfEWKk4Vwd66+QTORmuKAzxNwtl7rS40qXRCfftaH1XMl5gaShh85uMatkNaUqp
 nyG3xIT5M0pXjpdIqbCEdGrIP8eOu4DtHdkOHkOOgMscqYP0p21ZSYjvyyiTmzUm
 rhxWcQzv/O68Dh21NnbHAbGk7jEP2GUKYiink735b5I/OoYErHGF2gbMF1nTO54l
 T42gLq52xA==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2ehe2v0w-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:56:03 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67HFgWlx013735;
 Mon, 17 Aug 2026 15:56:03 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g34ng6f12-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 17 Aug 2026 15:56:03 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67HFu2WB27329206
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 17 Aug 2026 15:56:02 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EDC4358063;
 Mon, 17 Aug 2026 15:56:01 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 452B458055;
 Mon, 17 Aug 2026 15:56:01 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 17 Aug 2026 15:56:01 +0000 (GMT)
Message-ID: <4131f802840910b277f6e0a681ce7e51e8a9dddb.camel@linux.ibm.com>
Subject: Re: [PATCH 7/7] target/ppc: Add ICBT support for ISA version 2.07
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, shivangu@linux.ibm.com
Date: Mon, 17 Aug 2026 10:56:00 -0500
In-Reply-To: <20260715125634.2107320-8-rathc@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-8-rathc@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfX6QAxV5zvRRQN
 LBaJYQ8eiu5sQ4IF/M5xTU0LYg5uCrFE4LnnMRncItAj+vm63zn1aIkNamgAQrpJqSHiluNZr3O
 50Kv35j+YYjGMa8qeJKNwGIYfFe6Mq4gh/udb4055BUIIJhSfCDcVEXjAWvbKvj1LouxCa7dQv+
 17WZ56uRo511N1Gdat4JQ21z6A1u1FUE2nVDMq36ZV9+t4S1vjf6OAhxjopRv2WIC/X+EzANvSh
 fyqj7iQOSJKtkTySQyyUcwHcE/tho7+g2yrfl1kKw83a11+QvsGUbuF4pbTfVriKxM1cLha9/3K
 iRc+d67pKqAdQEJhCM3qIU6f0g0RbG10z82Q/QsyrMt79XJ1uIw5/dPCmnqZLwr/xCqcRwKU0Qn
 IVqzOQIl6C2ryntAJPdOBT+T8kVSf1/Yvn5cD01mpZwF9ZviRrWsuLhl1cBZAaKOagovM47njSk
 S0NEBxKbq4tkQtopmrA==
X-Authority-Analysis: v=2.4 cv=DY8nbPtW c=1 sm=1 tr=0 ts=6a832f14 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=6UGtalZkPfNYZ1rZEPkA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sKrffkgpNCTGiAITpmYaPf20QkIflgLa
X-Proofpoint-GUID: s9VJsejbB81N084spjLDwAdwPZbAKkNB
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE3MDExOSBTYWx0ZWRfXzJY0nke51S2u
 K7qIyQxUEa9ItVny0BRRgd9F4kLtpqbroD2445+7hmjy2/G6hE4LZBPgyORB3ShYXiYDGEoflIL
 E2yw7OplNp0L7MvCcGN+vMPThVIeeRk=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-17_02,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 clxscore=1015 spamscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 lowpriorityscore=0 phishscore=0 suspectscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608170119
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

Seems like you are fixing a bug here.  Does this require a "Fixes" tag?

Thanks,

Glenn

On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
> The summary of changes in Power ISA version 2.07B mentions :
> "ICBT instruction has been moved from the Embedded category
> to the Base category".
> Updating ICBT flag for the same.
> 
> While we are at it, correct the invalid mask as per the ISA as well.
> 
> Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> ---
>  target/ppc/translate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> index 8dab54ccee..3cd849c706 100644
> --- a/target/ppc/translate.c
> +++ b/target/ppc/translate.c
> @@ -4559,8 +4559,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
>  GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
>  GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
>  GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
> -GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
> -               PPC_BOOKE, PPC2_BOOKE206),
> +GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
> +               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
>  GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
>               PPC_440_SPEC),
>  GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),


