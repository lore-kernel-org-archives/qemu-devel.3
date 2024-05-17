Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44C20C04FFE
	for <qemu-devel@archiver.kernel.org>; Fri, 17 May 2024 17:34:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s81SP-0007TS-GR; Fri, 17 May 2024 13:33:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s81SN-0007T1-CL; Fri, 17 May 2024 13:33:23 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1s81SL-0008Qr-Jo; Fri, 17 May 2024 13:33:23 -0400
Received: from pps.filterd (m0353726.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HHK6TK014399; Fri, 17 May 2024 17:33:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : reply-to : to : cc : date : in-reply-to : references : content-type
 : mime-version : content-transfer-encoding; s=pp1;
 bh=X5BgXqBb+KrkL1FdRXGwawCVw6PTVstSLWgxlp8enWc=;
 b=WXxEFFGh8Ruw9TGyiho/r2F2+iu+orm2/nvtv+ye4SIYW/hTCzax+xvliYcn7AuILCyY
 yD7wMfRDM+sSJD8ukw6b0SAIiOpckHXYwn+b8P/JY4X1v496JJjEJL2fK1xcER+FmaaN
 4BVR6iLdxR/B7pLDUbUi/N/adEGvTtlyQ+z8EEW7u9+BZXoUEXfDv/6xHfyajYJljKMG
 3fUB1qbaQ32K+rnuV9VWqQz4B/GfE5VgFf1vXoOEhyKXJGQnV5HS3WITb2VQq+JmxNnD
 CV31Q0eazv67I4YGGPrum73LxTKxrvmnNBFQBLjWL9BJtyCBTx9jL4ZQ6SNhZ5Vth2Yy KQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6b4tr2a3-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 17:33:16 +0000
Received: from m0353726.ppops.net (m0353726.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44HHXGVp006434;
 Fri, 17 May 2024 17:33:16 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y6b4tr2a1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 17:33:16 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44HGCrCm006027; Fri, 17 May 2024 17:33:15 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y2nq38wqf-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 17 May 2024 17:33:15 +0000
Received: from smtpav01.dal12v.mail.ibm.com (smtpav01.dal12v.mail.ibm.com
 [10.241.53.100])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44HHXADZ43123422
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 17 May 2024 17:33:12 GMT
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F1B158057;
 Fri, 17 May 2024 17:33:10 +0000 (GMT)
Received: from smtpav01.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 0A0D85805D;
 Fri, 17 May 2024 17:33:10 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav01.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 17 May 2024 17:33:09 +0000 (GMT)
Message-ID: <ddbf79c11113635432ace82e0904068a2c8c8fa8.camel@linux.ibm.com>
Subject: Re: [PATCH v3 3/5] hw/block: Add Microchip's 25CSM04 to m25p80
From: Miles Glenn <milesg@linux.ibm.com>
To: qemu-devel@nongnu.org, qemu-ppc@nongnu.org
Cc: fbarrat@linux.ibm.com, npiggin@gmail.com, clg@kaod.org, calebs@us.ibm.com, 
 chalapathi.v@ibm.com, chalapathi.v@linux.ibm.com,
 saif.abrar@linux.vnet.ibm.com, dantan@us.ibm.com
Date: Fri, 17 May 2024 12:33:09 -0500
In-Reply-To: <20240516163304.25191-4-chalapathi.v@linux.ibm.com>
References: <20240516163304.25191-1-chalapathi.v@linux.ibm.com>
 <20240516163304.25191-4-chalapathi.v@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: z9PucBwND-rRLoq_ln4v9pji27lPfIhM
X-Proofpoint-ORIG-GUID: J1O7R-po7NOvpwOEGD0XSWEirCJWYB48
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-17_07,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 spamscore=0
 clxscore=1015 suspectscore=0 malwarescore=0 impostorscore=0
 mlxlogscore=849 lowpriorityscore=0 bulkscore=0 priorityscore=1501
 phishscore=0 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405170136
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

-Glenn

On Thu, 2024-05-16 at 11:33 -0500, Chalapathi V wrote:
> Add Microchip's 25CSM04 Serial EEPROM to m25p80.  25CSM04 provides 4
> Mbits
> of Serial EEPROM utilizing the Serial Peripheral Interface (SPI)
> compatible
> bus. The device is organized as 524288 bytes of 8 bits each
> (512Kbyte) and
> is optimized for use in consumer and industrial applications where
> reliable
> and dependable nonvolatile memory storage is essential.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> ---
>  hw/block/m25p80.c | 3 +++
>  hw/ppc/Kconfig    | 1 +
>  2 files changed, 4 insertions(+)
> 
> diff --git a/hw/block/m25p80.c b/hw/block/m25p80.c
> index 8dec134832..824a6c5c60 100644
> --- a/hw/block/m25p80.c
> +++ b/hw/block/m25p80.c
> @@ -357,6 +357,9 @@ static const FlashPartInfo known_devices[] = {
>        .sfdp_read = m25p80_sfdp_w25q512jv },
>      { INFO("w25q01jvq",   0xef4021,      0,  64 << 10, 2048, ER_4K),
>        .sfdp_read = m25p80_sfdp_w25q01jvq },
> +
> +    /* Microchip */
> +    { INFO("25csm04",      0x29cc00,      0x100,  64 << 10,  8, 0)
> },
>  };
>  
>  typedef enum {
> diff --git a/hw/ppc/Kconfig b/hw/ppc/Kconfig
> index 6f9670b377..a93430b734 100644
> --- a/hw/ppc/Kconfig
> +++ b/hw/ppc/Kconfig
> @@ -40,6 +40,7 @@ config POWERNV
>      select PCA9552
>      select PCA9554
>      select SSI
> +    select SSI_M25P80
>  
>  config PPC405
>      bool


