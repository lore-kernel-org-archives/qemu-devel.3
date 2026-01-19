Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77FF0CA5FEE
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Jan 2026 07:00:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vhjEJ-0002Qf-JC; Mon, 19 Jan 2026 01:59:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhjCV-00023O-Gu; Mon, 19 Jan 2026 01:57:48 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vhjCR-0007F9-6U; Mon, 19 Jan 2026 01:57:23 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60J08nZB000928;
 Mon, 19 Jan 2026 06:57:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=LRMEI0Z23YEhVO7xYVe+NCrN4hut8/
 fvFsUTai5Qo34=; b=aX6j3Iro+L2641yKoVxPL2y3ejiElRC22YRYOyDnHSMBUo
 UE1OPkBbR8DlAfb0Dgj9OTCYM1L6boB3VeWAr+iC4tuRsljxnshF+LZebnfBqc/w
 3fkqsP0CTH/RjGe19R8gs/oLvwYOb9N6ZwIJzr7V04dmj9qrEME4HnTVCgWfqqoZ
 PkY1jsRmHKlcDtXMzPY9wLCvyMqs7sR1FRCbbFvdxkvG5MfibVbALY/P6EaPmJl1
 gTp3fsrkORIR2YlBrTS+fVgcNUxlwbd6DIh3jfMSU/QH2h3bQ7pp9B6BAVVlak62
 VcQVFg1pi3Mqs7c2YICLEk3n0aEE2XxDQQ4OLRSA==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rprxp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 06:57:12 +0000 (GMT)
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60J6u2TD003874;
 Mon, 19 Jan 2026 06:57:12 GMT
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4br23rprxf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 06:57:12 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60J6n6OH016636;
 Mon, 19 Jan 2026 06:57:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4brn4xn9r5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 19 Jan 2026 06:57:10 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60J6v6jF25821654
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 19 Jan 2026 06:57:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CCA0C20040;
 Mon, 19 Jan 2026 06:57:06 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9E7D2004B;
 Mon, 19 Jan 2026 06:57:03 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.21.137]) by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 19 Jan 2026 06:57:03 +0000 (GMT)
Date: Mon, 19 Jan 2026 12:27:01 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, alistair@alistair23.me, chalapathi.v@linux.ibm.com
Subject: Re: [PATCH] hw/ssi/pnv_spi: Fix fifo8 memory leak on unrealize
Message-ID: <aW3VANPAcyejWJ4Y@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251216154503.2263755-1-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251216154503.2263755-1-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: WslDuQaAowY03uiNjep2rprANE2H3A9W
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTE5MDA1MCBTYWx0ZWRfX3qxD/WD8lAV6
 s9q6vXCyR6V9uQhG+WSBgZOblUWvuMTAutLK3hsN86GkDL73mcbFOSrvQYZo13sgxMej7XWwobc
 Gr2WLltbSVPmfWFQUAuN58TIG1YSkHOMO8j5Dlk4ykJxtRi6GN98DTjXH8i/U/H2eu+tAmgBK6X
 n0+24uaO+7Z0kdM0S1FUjUUs7PSBiVcX7L2CVTmEWUOnGVoLa3SrKxrautIrZJ5NsDp08gVVTDZ
 6iEyDWL3j1bY5kmdKzmPnysy32LQgKKmvLgqLPUR2y9z6V2D1DCJULaAIOEC6msTe/yM2WJI5zQ
 8o385WTEGrIXw+lSQODNQRd3LRTaxwE4bSpmrDXhkP7LT/UzI05NtgVaHfooqu8agMb5+ygRGkD
 6C97vUE3T45i4QOWGFqm4qxRIJUrSVG2eCZdwQgcuf0x3C3iVsRpQ5WfxEHF08NbXS0jowE1Fq3
 Cyl+4oFM55kLsLggYDA==
X-Authority-Analysis: v=2.4 cv=J9SnLQnS c=1 sm=1 tr=0 ts=696dd5c8 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=pGLkceISAAAA:8 a=VnNF1IyMAAAA:8 a=CJKrucV5HHBk1qxaKX0A:9 a=CjuIK1q_8ugA:10
X-Proofpoint-ORIG-GUID: KZyx51qkM7F9fF_ARyZxskKqSXRQAKFp
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2026-01-19_01,2026-01-18_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 adultscore=0 suspectscore=0 spamscore=0
 lowpriorityscore=0 malwarescore=0 clxscore=1015 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601190050
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/12/16 09:45AM, Caleb Schlossin wrote:
> unrealize should free the fifo8 memory that was allocated by realize.
> 
> Fixes: 17befecda85 ("hw/ssi/pnv_spi: Replace PnvXferBuffer with Fifo8 structure")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>

Hello Caleb,

Sorry for the delayed review. The patch currently doesn't apply on
upstream, as there was a merge conflict with vmstate patch and this.

Can you send a v2, rebased on upstream ?

Thank you,
- Aditya G

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
> -- 
> 2.47.3
> 

