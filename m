Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0012C44511
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 15:48:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkOJz-0005fi-Hx; Thu, 16 Jul 2026 11:48:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOJw-0005cB-VV; Thu, 16 Jul 2026 11:48:22 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkOJv-0002VQ-IS; Thu, 16 Jul 2026 11:48:20 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDgKCg3349087; Thu, 16 Jul 2026 15:47:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=mhVd0jzuyRZiiePdzIr/rja6e5pVRznTnY5Fu8iNP7U=; b=P9ZeupYKKCsf
 7d2KF4H2lWtD1O12BR3y/Iaxj4Tp5dFXnve9DWcfeyq5ppJQWJXkTJvhZIMzZNYT
 74Cviqt6OqCsE/h95STkzhsGs47g3Kpg9Nbzfr7OW86F2DFgUO0Pwbs7JY7SpzQm
 Q9ttpF8zy1CkVpGdf1HT0GgSO1pyNEx92alUx3Gzyfhd/v5qNgbLykjP/vthqg4B
 oiGxm3FbUZr/v9MvLZHKP3KGF95LVhhMYz1HV58iiVT5+1iFNXbrJ+iJQ8FhxPae
 tHNfu5STqp6gZAAQZl5swRFEkxDrQ11IFIPB9SzToKNJupww5sociZAfZcF/w29Y
 UdJDfZbY9A==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc0yuj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:47:55 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GFYak5003141;
 Thu, 16 Jul 2026 15:47:55 GMT
Received: from smtprelay04.wdc07v.mail.ibm.com ([172.16.1.71])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc1nhnm41-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 15:47:55 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay04.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GFlsNj37094138
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 15:47:54 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5088058068;
 Thu, 16 Jul 2026 15:47:54 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 891305805A;
 Thu, 16 Jul 2026 15:47:53 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 15:47:53 +0000 (GMT)
Message-ID: <e60839240e04c1243c2ba3e5449ae241c48f8733.camel@linux.ibm.com>
Subject: Re: [PATCH 18/29] hw/gpio: pca9554: expose pin%d as a string property
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
Date: Thu, 16 Jul 2026 10:47:53 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-18-82a63fead90c@free.fr>
References: <20260709-catalina-upgrade-v1-0-82a63fead90c@free.fr>
 <20260709-catalina-upgrade-v1-18-82a63fead90c@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58fd2c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=N7nTd0MHQuZND135gA8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX/Y30k3jvs3op
 ysPO426z750dVchOPqGghSQDx6iM1mP/PLRpHn+DtaFZErDROM2BZzWtXsGqSetAwALe0ohf3pG
 B9r6F+gHK3VBhAwRa77ZgkhJr+TOoCvho7UgBMiMLR+uJhVODRIyP4SW0qOprt1EB6GiHspxaeA
 PAJWAtWLZs2KLxgqlzF2gMjNOtcIWlTQiw+7uQIzIEUBdWABDu9deWZypR7GeruGrXuD05eki0V
 BCqzdbSC9WmRSmDIOY9bfxq8eGtUVtiiuU8jV+c9jpgU78zzyXnwfEPsrnZndG9nn+EVMse+Yrs
 WcjCqJkzQ+B+xF8gZiIW3Ilzt5WAdMD++hLPRQd/4RhVBO6AlBW8kTZq+nIgC8miS8jS6yimkh1
 4Qwov1n/rORgDCQtxHpLjGfBW7o2tYutd4UICRZ2Wa8gpJkXSFKElPThGSQP8iDM8022Emuo10h
 B+EYPWGuJwiIkWaT8rQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE2MSBTYWx0ZWRfX2IwZ1lNfqLtk
 FidBF2NEKNJOwGh/l1FhdtPKWbBkQ2HNUxsKXmhlHVKgqLIR0OXe+kRZeF23EtIieXp2iQM6dqw
 gyATsE1fp5hfndW5dNyiAmZMQPqLfYc=
X-Proofpoint-GUID: 1h-a-cfN6gysNa_BkYc5WcUEzRNHNDBk
X-Proofpoint-ORIG-GUID: aAnHQia2S0THevIvBscI60TCHYhiADY0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160161
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
> The pinN properties are accessed with visit_type_str() (values "low" and
> "high"), but were registered as type "bool", so introspection advertised
> a boolean while the accessors require a string. Register them as "str",
> matching the PCA9555 GPIO variant.
> 
> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9554.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9554.c b/hw/gpio/pca9554.c
> index d4746719f9..904698cdce 100644
> --- a/hw/gpio/pca9554.c
> +++ b/hw/gpio/pca9554.c
> @@ -280,7 +280,7 @@ static void pca9554_initfn(Object *obj)
>          char *name;
>  
>          name = g_strdup_printf("pin%d", pin);
> -        object_property_add(obj, name, "bool", pca9554_get_pin, pca9554_set_pin,
> +        object_property_add(obj, name, "str", pca9554_get_pin, pca9554_set_pin,
>                              NULL, NULL);
>          g_free(name);
>      }
> 


