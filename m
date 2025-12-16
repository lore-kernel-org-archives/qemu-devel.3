Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81430D609C2
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Dec 2025 16:27:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vVXt8-0006Q9-LZ; Tue, 16 Dec 2025 11:27:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVXt6-0006Po-VD; Tue, 16 Dec 2025 11:27:00 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1vVXt5-0002MC-HL; Tue, 16 Dec 2025 11:27:00 -0500
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGA0YIC031125;
 Tue, 16 Dec 2025 16:26:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=irzhMXWYvjosKYccpK/cvSXWobH9DxTYWEFBzHFMbEA=; b=i7f/vzFgmmvA
 ufrQ92ETwM67W3IurS2h150Oqg7dhotNUtg6FHzbfI8zeNSBRsqfZ/uDi1q/vL0d
 5iU2rEZ60pdNv5a0ODe/j/T9I34B8nl7BKC90HaaiQpqlziznMNNKdEX/rj0K/TN
 9OZTQzgJ8nIcswbbCLcfgFnnz05lrtnE3nRoDTOBfc3JtWm3YTDD3v8J/pdzXc2V
 WmSvkwrZO2VZH0D97u+tULbgN7+QBQK73euZmtx6uSoBq0oOHVyx+31Mt9cbeGKb
 kryOc2m6HaPZUqX9o+nttmVrV7ou0iLj0bSseUd62k/4d+CivN9EwpKFjYJdWDr6
 lvwgcL4QlA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkyj2g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:26:56 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5BGGBniW006668;
 Tue, 16 Dec 2025 16:26:55 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4b0xjkyj2c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:26:55 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5BGFu1Fw026746;
 Tue, 16 Dec 2025 16:26:54 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4b1jfsdfgh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 16 Dec 2025 16:26:54 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 5BGGQsvj30933636
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 16 Dec 2025 16:26:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id EEFD358056;
 Tue, 16 Dec 2025 16:26:53 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 964475803F;
 Tue, 16 Dec 2025 16:26:53 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 16 Dec 2025 16:26:53 +0000 (GMT)
Message-ID: <7edad6d6817f8fa6a92ee9920bdd99c0ff296d8c.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
From: Miles Glenn <milesg@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, npiggin@gmail.com, adityag@linux.ibm.com,
 alistair@alistair23.me, chalapathi.v@linux.ibm.com
Date: Tue, 16 Dec 2025 10:26:53 -0600
In-Reply-To: <20251216154503.2263755-1-calebs@linux.ibm.com>
References: <20251216154503.2263755-1-calebs@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UZo9mUpuOu-eRgvb7J2mMwYJV7dQP-uG
X-Authority-Analysis: v=2.4 cv=CLgnnBrD c=1 sm=1 tr=0 ts=69418850 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=wP3pNCr1ah4A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8 a=CJKrucV5HHBk1qxaKX0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: h3o8UxtNjyCHt9MnqvJtEMsdqnBspx4M
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMjEzMDAwOSBTYWx0ZWRfX55mOZM8WZSie
 5EprE9BmfytvUr27UFNThI3vqEDsJpbkV+NOhncL5hVCiyhwPeFmuk7/RDTblxCo+MHclwa9vas
 QzfCRRwmwV6LqLWfuAPqqALhmj1yKUsW7aw3dqEgf1P0nPIxRrTMg6x8q31oL+smK3y6xYd870+
 11upiuxzQ1qYzfowg0mCkBVMc0W8bzZPuNOXkg5T81cEnI0pHwZKvRCjK7K1B6Wn1y5yB3Jnohw
 anBhl4jwMtb5suVrQz5E6Ei4rLl5AiJwaW8tyNLvxwHGMrZy4NuwwJ5n7yi8jeux1HNxLc/OSXI
 HhiOOsZ4LdTx5oif62+y8nWWbyl9FneRcN5pKk+JGT06NKMuSlOAbTqa8OwBtRo/e048n8fTQVM
 IgLgoczwYso/ywO78IKRiT7GgVGReg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-12-16_02,2025-12-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 clxscore=1015 lowpriorityscore=0 malwarescore=0 suspectscore=0
 phishscore=0 priorityscore=1501 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2512130009
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Thanks,

Glenn

On Tue, 2025-12-16 at 09:45 -0600, Caleb Schlossin wrote:
> unrealize should free the fifo8 memory that was allocated by realize.
> 
> Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ssi/pnv_spi.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/ssi/pnv_spi.c b/hw/ssi/pnv_spi.c
> index f40e8836b9..5db440be9a 100644
> --- a/hw/ssi/pnv_spi.c
> +++ b/hw/ssi/pnv_spi.c
> @@ -1176,6 +1176,13 @@ static void pnv_spi_realize(DeviceState *dev, Error **errp)
>                            s, "xscom-spi", PNV10_XSCOM_PIB_SPIC_SIZE);
>  }
>  
> +static void pnv_spi_unrealize(DeviceState *dev)
> +{
> +    PnvSpi *s = PNV_SPI(dev);
> +    fifo8_destroy(&s->tx_fifo);
> +    fifo8_destroy(&s->rx_fifo);
> +}
> +
>  static int pnv_spi_dt_xscom(PnvXScomInterface *dev, void *fdt,
>                               int offset)
>  {
> @@ -1208,6 +1215,7 @@ static void pnv_spi_class_init(ObjectClass *klass, const void *data)
>  
>      dc->desc = "PowerNV SPI";
>      dc->realize = pnv_spi_realize;
> +    dc->unrealize = pnv_spi_unrealize;
>      device_class_set_legacy_reset(dc, do_reset);
>      device_class_set_props(dc, pnv_spi_properties);
>  }


