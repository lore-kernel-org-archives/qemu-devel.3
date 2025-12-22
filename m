Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91443E6F079
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 10:53:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY00K-0005bw-9Z; Tue, 23 Dec 2025 05:52:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY00J-0005bc-5j; Tue, 23 Dec 2025 05:52:35 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chalapathi.v@inux.ibm.com>)
 id 1vY00H-0006zH-Jp; Tue, 23 Dec 2025 05:52:34 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BLJFNx2002926;
 Mon, 22 Dec 2025 10:43:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=hZnG8v
 tQxH8gqWcWmYqmMjQ7DQM27p8b9g13b9M2IBE=; b=H+rimTjPCxJRYRPDBbsH7e
 dLGQUBKRVgmjXudh9aSIrS2o0KfydG+hVipT2e+caw3pc6QteaYBc0dacxQ/XBIR
 kMBmlOo7DF6BfZiaNqSYxm0lhAJpCHTZGHEfHK2oDQa5FZYEYEmnqjvs17W4CB+u
 LhX6t2AJIQXp+ByKl/OnP82zncivdRWcABe/fzqEMjmVpGmuKBDpw/fuy5HphpJs
 jsSufPuCt/Q0MwkUJwkbXG/qV5g24pqkGtq0IrC7HCvhLZwwrXAQQUeIJ3jFtL+L
 MigsXtlq1QINSqEvaMkXwJOGRrU+iJ2VZ4W0HkzufXnER2GwBVh2EsEiLYbAwMbw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47hca-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:43:35 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BMAhZNl024818;
 Mon, 22 Dec 2025 10:43:35 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b5kh47hc7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:43:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BM8wF4q001098;
 Mon, 22 Dec 2025 10:43:34 GMT
Received: from smtprelay03.wdc07v.mail.ibm.com ([172.16.1.70])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b664s5qus-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 22 Dec 2025 10:43:34 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay03.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BMAhGTC19006026
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 22 Dec 2025 10:43:16 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5105458058;
 Mon, 22 Dec 2025 10:43:32 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9363058057;
 Mon, 22 Dec 2025 10:43:29 +0000 (GMT)
Received: from [9.43.97.98] (unknown [9.43.97.98])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 22 Dec 2025 10:43:29 +0000 (GMT)
Message-ID: <e9ae1f87-abda-4d77-be62-226d6fd5e2a7@inux.ibm.com>
Date: Mon, 22 Dec 2025 16:13:28 +0530
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 milesg@linux.ibm.com, alistair@alistair23.me, chalapathi.v@linux.ibm.com
References: <20251216154503.2263755-1-calebs@linux.ibm.com>
Content-Language: en-US
From: Chalapathi V <chalapathi.v@inux.ibm.com>
In-Reply-To: <20251216154503.2263755-1-calebs@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=bulBxUai c=1 sm=1 tr=0 ts=694920d7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=CJKrucV5HHBk1qxaKX0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: P-5w_e8fMIWHkEZ0dCzlm4Z2g5FwyVaZ
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjIyMDA5MyBTYWx0ZWRfX9MLmE6AMweIP
 Tib4zXeT426n1cZLmes8AuNMG6XdbgfU5H2kyl40idIdfWM9odUjb2IKHBWeEKfT2f/uD65Mhgx
 8BQQiGvqLhl7UlOIMvdLJyWVeKx8z9K121jtMVcn/3G7lQwml1WCXMjD9J2meY/wSI5TY/Awtfb
 lSm4R1V/QFIeuT4SiEDuTCiQbrIfcBpZn6foQbOjA+ML1SkSjfZ85V1aHr1HM270yqikj2B3/oN
 Fa1hqvcBFZ+Q+/L8nOiHjofTjpzRwxUpWuhcObE9GIOlaXy/DmZ2+ctWF3gA+nJtbesC7FtLbfH
 MsFh11caEQpdS+GfF2KFPZ+kGWoe19vSbTWjHYxmu994QtnHeAJJ5aEA042iqB/ZWz2Dkuhx3Dp
 MJ4GSMJvY7z4zMubYqvABMORSy7MBa/M6DNDmt6I4udnKd7I6EkLwZ6Lhd8viKFBXhohXIfmyOf
 YvuaMSye+XXyhX8l/cg==
X-Proofpoint-GUID: 7klp1qRqgPHVRPwCnruNB7GiL7_OgTrE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-21_05,2025-12-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 suspectscore=0 clxscore=1034 lowpriorityscore=0
 priorityscore=1501 spamscore=0 malwarescore=0 bulkscore=0 phishscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2512120000
 definitions=main-2512220093
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=chalapathi.v@inux.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Chalapathi V<chalapathi.v@linux.ibm.com>

On 16/12/25 9:15 pm, Caleb Schlossin wrote:
> unrealize should free the fifo8 memory that was allocated by realize.
>
> Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>   hw/ssi/pnv_spi.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index f40e8836b9..5db440be9a 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -1176,6 +1176,13 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
>                             s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
>   }
>   
> +static void pnv_spi_unrealize(DeviceState *dev)
> +{
> +    PnvSpi *s = PNV_SPI(dev);
> +    fifo8_destroy(&s->tx_fifo);
> +    fifo8_destroy(&s->rx_fifo);
> +}
> +
>   static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
>                                int offset)
>   {
> @@ -1208,6 +1215,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>   
>       dc->desc = "PowerNV SPI";
>       dc->realize = pnv_spi_realize;
> +    dc->unrealize = pnv_spi_unrealize;
>       device_class_set_legacy_reset(dc, do_reset);
>       device_class_set_props(dc, pnv_spi_properties);
>   }

