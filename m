Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0970CC44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:53:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLas-0005He-SM; Thu, 16 Jul 2026 08:53:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLaq-0005Gz-PQ; Thu, 16 Jul 2026 08:53:36 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLap-0001Am-6C; Thu, 16 Jul 2026 08:53:36 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GAC4Zh2911044; Thu, 16 Jul 2026 12:53:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=Y+qfRd8lgecJumlgCJf+iMlye7iFg4lRTbAcaZLgc64=; b=PgcsR8Rkd6rM
 vRjJdnoKMOznFbLE3TdX8Ud9Nu7qLEfT1GLmnOYgcQyCZ0ejuTiSZMcU0XD0edO+
 3pDtdoga9YnM0TE7o+ZYsnxCx6GzLCaEoS3xofgZVWxxJirmarkxtGZk6uISJuUr
 PsDcWkOgKvsgLXP0Ac+A/TyH5GYB/GsFbyg4q3ZY7iaDl+9JAMinkb/ZX8ZIIbIa
 RrsgLz8gl1Wf6k6PtxbDGFeJj7nlQKB2gGA7YK7CQA8W9FC6EtaGGKfb2tbthlZI
 UXmGBBqwIW0g7AruQFCFbdYBf5dwaw2RnVhpABUqxyknWXiX0C+73q8xAzK/zbh3
 4hjQ0AxzPg==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepxrve6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:53:07 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GCnevU001088;
 Thu, 16 Jul 2026 12:53:06 GMT
Received: from smtprelay04.dal12v.mail.ibm.com ([172.16.1.6])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qd7sb-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:53:06 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay04.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GCr59L26149542
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:53:06 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B397558061;
 Thu, 16 Jul 2026 12:53:05 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6F71A58059;
 Thu, 16 Jul 2026 12:53:04 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 12:53:04 +0000 (GMT)
Message-ID: <9cf6674bede56d2a2874368f5ee917e34833865f.camel@linux.ibm.com>
Subject: Re: [PATCH 01/29] hw/gpio: pca9552: register types with DEFINE_TYPES()
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
Date: Thu, 16 Jul 2026 07:53:03 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-1-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-1-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: LZP33w89SQIIcB_IMjS7uWikWLTUPyms
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX40yqGnML+SWh
 24RwvP+D7nNeYYgHZDGe59eckcOdNY7MR/5OQQ5+fB+xfKO/lnX59unrqAjXSdY0b1AgFcBiyK4
 pF4405lOF3PJl5pGqUdhco7md9qrhAY=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX24w+YUG/E+mV
 qRSZQoAFC2nyaaLW3BuHJpzaGtot5XFmwWR5FaoOvtgCNeILpZrctqLQOX5rBT/43E10YQ2RFfi
 SMHchC3TzOcIQ81CMCdegzf6Gt+5OWQV9XVf6cuTEKXIraitC/sxzilmFhEsgy6qvMPQmaeVgdw
 pWtAdn0g/rwZ2BUAxOkuhJqJTM1+KzDgQy5VeY74ojMA18IBQSUnXq18hvc5iJ996hLx7+TGC3V
 zLcmzz+REmpG0VN+7r4aIeDxsXdPgqYJaEtKZP18dPHGJkYXtZY0veqWdNqWhd+6Z0S2+GYda8m
 R2UpoujaXOHM1nbn18hnwJJEmIwUFuYZRAEliiOuG2I8nXDYpGpn1/b58l9xkCmAyxgNJgPjVXP
 LGLTsjZXIj/wxPxP+icGS4ktlHvrJsJTOxQEX8/SCIE3XOzl37XvJgel9Xxx8A3uToGM+bYLHcL
 CibCRSYF/BuHA5WZAXA==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a58d434 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=v9K0EUKEbaSusLC01C0A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: HCx-9lPcuUz1SkbeJwOyvOaO6UdQGIy9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160131
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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
> Replace the separate TypeInfo definitions and pca955x_register_types()
> registration function with a single type array registered through the
> DEFINE_TYPES() macro, to prepare addition of new PCA955x-derived devices.
> 
> No functional change.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 49 +++++++++++++++++++++----------------------------
>  1 file changed, 21 insertions(+), 28 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index b13ac9fd9c..50e868a6e9 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -492,16 +492,6 @@ static void pca955x_class_init(ObjectClass *klass, const void *data)
>      device_class_set_props(dc, pca955x_properties);
>  }
>  
> -static const TypeInfo pca955x_info = {
> -    .name          = TYPE_PCA955X,
> -    .parent        = TYPE_I2C_SLAVE,
> -    .instance_init = pca955x_initfn,
> -    .instance_size = sizeof(PCA955xState),
> -    .class_init    = pca955x_class_init,
> -    .class_size    = sizeof(PCA955xClass),
> -    .abstract      = true,
> -};
> -
>  static void pca9552_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> @@ -526,23 +516,26 @@ static void pca9535_class_init(ObjectClass *oc, const void *data)
>      pc->has_led_support = false;
>  }
>  
> -static const TypeInfo pca9552_info = {
> -    .name          = TYPE_PCA9552,
> -    .parent        = TYPE_PCA955X,
> -    .class_init    = pca9552_class_init,
> +static const TypeInfo pca955x_types[] = {
> +    {
> +        .name          = TYPE_PCA955X,
> +        .parent        = TYPE_I2C_SLAVE,
> +        .instance_init = pca955x_initfn,
> +        .instance_size = sizeof(PCA955xState),
> +        .class_init    = pca955x_class_init,
> +        .class_size    = sizeof(PCA955xClass),
> +        .abstract      = true,
> +    },
> +    {
> +        .name          = TYPE_PCA9552,
> +        .parent        = TYPE_PCA955X,
> +        .class_init    = pca9552_class_init,
> +    },
> +    {
> +        .name          = TYPE_PCA9535,
> +        .parent        = TYPE_PCA955X,
> +        .class_init    = pca9535_class_init,
> +    }
>  };
>  
> -static const TypeInfo pca9535_info = {
> -    .name          = TYPE_PCA9535,
> -    .parent        = TYPE_PCA955X,
> -    .class_init    = pca9535_class_init,
> -};
> -
> -static void pca955x_register_types(void)
> -{
> -    type_register_static(&pca955x_info);
> -    type_register_static(&pca9552_info);
> -    type_register_static(&pca9535_info);
> -}
> -
> -type_init(pca955x_register_types)
> +DEFINE_TYPES(pca955x_types)
> 


