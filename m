Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A4DC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:07:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLnF-0001uc-2G; Thu, 16 Jul 2026 09:06:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLnD-0001u2-CN; Thu, 16 Jul 2026 09:06:23 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLnB-0002e5-Pl; Thu, 16 Jul 2026 09:06:23 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GABsqW2899219; Thu, 16 Jul 2026 13:05:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=/0s3cUaEIujnBBo7EGiJgq+I7AZDGLffugwLuwROwtM=; b=QjfNNrftZfpm
 qvVSEftT7AMz6LGjRVoxL0xqJJ32CHNkV9E1SFVYvG/ur0wMQ6OfQwC46gO+F50z
 0192O8UZFgNft0W0ZWMfj8AdvoYFng2CjDLi02mBJ/TlUKyaZsFF/lTu0rk3nrqO
 0i5AXzvwRmNge2iDaBW122tyj8UdZB9p8xfltdBejvGkNKgjzQIL/TpPQPTy+aUi
 oHseEK+ZT+kByzDmgPkIu9eyGlmX1tFevuV4h/4JBMFsG97GhqmyrGB+0CQiJVOd
 cpP60cnwhBOkDFPLM9QHWYvj5kOw9PFP8VL237vdL/EsJyhj1xTc57+EbhiC4R/X
 5oEQDZIBsQ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc07x6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:05:50 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GD4d4H017378;
 Thu, 16 Jul 2026 13:05:49 GMT
Received: from smtprelay05.wdc07v.mail.ibm.com ([172.16.1.72])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qd9pq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:05:49 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (smtpav03.wdc07v.mail.ibm.com
 [10.39.53.230])
 by smtprelay05.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GD5mqe34669208
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:05:48 GMT
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6D1E65805D;
 Thu, 16 Jul 2026 13:05:48 +0000 (GMT)
Received: from smtpav03.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 27FA35805F;
 Thu, 16 Jul 2026 13:05:47 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:05:47 +0000 (GMT)
Message-ID: <b71a45056d81dd068b0ce5100a7f007d10d0ff67.camel@linux.ibm.com>
Subject: Re: [PATCH 05/29] hw/gpio: pca9552: declare pca9555 device as an
 alias of pca9535 device
From: Miles Glenn <milesg@linux.ibm.com>
To: Emmanuel Blot <emmanuel.blot@free.fr>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>, Steven Lee
 <steven_lee@aspeedtech.com>, Troy Lee <leetroy@gmail.com>, Jamin Lin
 <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, Andrew
 Jeffery <andrew@codeconstruct.com.au>, Joel Stanley <joel@jms.id.au>, Corey
 Minyard <cminyard@mvista.com>
Date: Thu, 16 Jul 2026 08:05:46 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-5-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-5-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58d72e cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=wsvIPkopN6-YJcbqhKEA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX/WUcJERELTCc
 GWkTfK/2EzUS7w61oOxHtgiJfwdBRXaao4aqDNguuXR/cjjZhZhqdqu0jmvCmk0cc0UPLbWQZ2C
 fwc44F4/f2fPgP02p2My3NWsshkSRo52M+A02pE83M14OQCvKGAgFkou+3U99MnU4jNP3Ceh/mJ
 iStA7t7XO0hEBhzXYyumg7+9LxpSZUbl6Jli+9my7Z7qbVI2I8jPsijbdgIWe2rcsxywLotlG7T
 EBAY0b3A2NK7kee0mkpQ5dEuesMftfRk9bNBy2IXo5XD561TjDPHigGd7UR2ie3JTcVCp2VAqs7
 nsCp8MV2txyUt0q2Ii5NcrP8C29mkbeHQKIPpjOTlmdj8i/5iCsBHIr/fBVPRtH9nOwuNsgsjDG
 4dLp4Xl6HC6RLF+WiSwZ5nQJoYdKDRlXXcImN1+UktBi95pnBYClIdsT48RQlKoGNaIgE5DzPAL
 zWDK88TF856E3TtL9Fw==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX9xP56dJjLMaA
 /EcUerAOBZj9tWM1ecLHUXROM16M7OoS7TQR6Sda/0Fx3i8WU8qXani62fZ4d2m//1uyWaSCjN6
 pFtEdhCJmd4V/babXDO9CqwuhO2c4U0=
X-Proofpoint-GUID: N6RFUG5seI__LM_1ZdNRNS9Zyw4FOHYB
X-Proofpoint-ORIG-GUID: niGm4X6PH0NgI7xk1xBPkz0Lptnbx4C2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160131
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Thu, 2026-07-09 at 17:23 +0200, Emmanuel Blot wrote:
> PCA9555 HW is mostly identical to PCA9535.
> PCA9555 HW features pull-up resistors that are not available on PCA9535.
> 
> Pull-up are not handled by current PCA955x implementation and PCA9535
> already initializes input as Hi-Z.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c         | 9 +++++++--
>  include/hw/gpio/pca9552.h | 1 +
>  2 files changed, 8 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index ffeb438d2a..3b9b63eb17 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -523,7 +523,7 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
>      pc->has_led_support = true;
>  }
>  
> -static void pca9535_class_init(ObjectClass *oc, const void *data)
> +static void pca95x5_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
>      PCA955xClass *pc = PCA955X_CLASS(oc);
> @@ -553,7 +553,12 @@ static const TypeInfo pca955x_types[] = {
>      {
>          .name          = TYPE_PCA9535,
>          .parent        = TYPE_PCA955X,
> -        .class_init    = pca9535_class_init,
> +        .class_init    = pca95x5_class_init,
> +    },
> +    {
> +        .name          = TYPE_PCA9555,
> +        .parent        = TYPE_PCA955X,
> +        .class_init    = pca95x5_class_init,
>      }
>  };
>  
> diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
> index 71479ea000..5299c13829 100644
> --- a/include/hw/gpio/pca9552.h
> +++ b/include/hw/gpio/pca9552.h
> @@ -13,5 +13,6 @@
>  #define TYPE_PCA955X "pca955x"
>  #define TYPE_PCA9552 "pca9552"
>  #define TYPE_PCA9535 "pca9535"
> +#define TYPE_PCA9555 "pca9555"
>  
>  #endif
> 


