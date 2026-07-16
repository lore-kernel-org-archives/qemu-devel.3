Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A635DC4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:35:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMF2-0000A6-M6; Thu, 16 Jul 2026 09:35:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMF0-00008X-Nz; Thu, 16 Jul 2026 09:35:06 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMEz-0006Ls-3f; Thu, 16 Jul 2026 09:35:06 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GACETw2899651; Thu, 16 Jul 2026 13:34:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=PWhn8kjzB6tgkFhA+CaZlszuNPUfISD3CsgkMvC2iOU=; b=mHy3I25U5ep8
 sttL6D6t18CrXEjZlrMwXsMVl2ijkXGBdYiES0BiRvxIIcrBxFtO9KJsU7BrtWqG
 7CcFfFyFpyheqv6FzaMi+d1vjfa92RtG6LP4VWm7DGhNzkjp0mrSDaC77uMfYsAM
 gJO/myJidVSSygpHCC5DjumCUUx4JwgQzuTD70WZ2NW7i8kIp8dTF5xU0+eXj5Ma
 J9PhR6Oa1ofkdgYC0Om1XH2KvmTLa3lGZ3supfV+hkySlX4OYNACCtoFSqpkUjKW
 EGABTe3IfYPnSxyhprN0tXiMUqvnjj5VRznss2WShffJLGVRL4VbInC1ePoUo9C/
 LBf1cqO9SA==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbegc0c7q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:34:46 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDYghu017683;
 Thu, 16 Jul 2026 13:34:45 GMT
Received: from smtprelay02.wdc07v.mail.ibm.com ([172.16.1.69])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05qddbe-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:34:45 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (smtpav04.wdc07v.mail.ibm.com
 [10.39.53.231])
 by smtprelay02.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDYjAe23724660
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:34:45 GMT
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F034D58052;
 Thu, 16 Jul 2026 13:34:44 +0000 (GMT)
Received: from smtpav04.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B271D58062;
 Thu, 16 Jul 2026 13:34:43 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:34:43 +0000 (GMT)
Message-ID: <f7c436451ade74baed3087c9c6dd4bee554d1ed2.camel@linux.ibm.com>
Subject: Re: [PATCH 06/29] hw/gpio: pca9552: use the Resettable interface
 instead of legacy reset
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
Date: Thu, 16 Jul 2026 08:34:43 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-6-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-6-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=fOcJG5ae c=1 sm=1 tr=0 ts=6a58ddf7 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8
 a=ayuSXJ0DrvFcvoGZ-b4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfX6CH33atjACOE
 HuOFoEes/mqS4xumow2muTS1oTq+nbXrIuazqDKzxKFAJzC3Tk/NUfcO+hbXNdCts+5UZ1y8tzM
 RBJWuQaXGCEBRxijJztZ5baGltC9gW/mER9GquT8BDwf73wY8YGama0mVWMj19MVYQsQqDZA8q8
 /VlCrYzf7uNjJwFL4wufQxmb397SlFrkWWjLtpufBWLjrMbZhfHsxj7ZRpyeUxg8zaLF+gMravG
 JoFdP39xk0DmWRm0UcqngsLewZRKV+/QWzfxFMuqPaE1NMOt8KSXhrm94YcGQ8RkOV7p/IujyMg
 IXYcCUOY5QcZSOFkDkhGUmpmG43D4eJUfYDYMTV+nfhQArDSdVjTdFCVt/6DvN84s82chBFgs0K
 LyB3e34+ApnMNWGaY67HlI2JqTlLviXDVrZ2grUjtOmaIsNNPdnDCj3Yf2hluBbKhVkU4WLHP52
 Be8dCvM3mkri9gx6A+Q==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzNiBTYWx0ZWRfX0O+qR8OZjrxz
 2ExfeVGLqcXGvrQxZhOnepS6urCp4h4d+q5GVu4Mt650YXQnYgjS2MZqwQ4B37rmd/b3JAn8qgh
 g0bHbfN6iLDCuigOkziYZw7i3bWY3zY=
X-Proofpoint-GUID: CwP99NTpaWgqnEUOR43pCJ5Nos7VYalF
X-Proofpoint-ORIG-GUID: EP2twkZXyQdvM6SuE4EfN1TlJXiwlkGK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 bulkscore=0 impostorscore=0 suspectscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607160136
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
> Convert the PCA9552 and PCA9535/PCA9555 reset handlers from the legacy
> device reset hook to the Resettable interface: move each reset body into
> a ResettableHoldPhase handler and register it through the class's
> ResettableClass::phases.hold instead of device_class_set_legacy_reset().
> 
> No functional change.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 14 ++++++++------
>  1 file changed, 8 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 3b9b63eb17..66f699bf6a 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -406,9 +406,9 @@ static const VMStateDescription pca9552_vmstate = {
>      }
>  };
>  
> -static void pca9552_reset(DeviceState *dev)
> +static void pca9552_reset_hold(Object *obj, ResetType type)
>  {
> -    PCA955xState *s = PCA955X(dev);
> +    PCA955xState *s = PCA955X(obj);
>  
>      s->regs[PCA9552_PSC0] = 0xFF;
>      s->regs[PCA9552_PWM0] = 0x80;
> @@ -426,9 +426,9 @@ static void pca9552_reset(DeviceState *dev)
>      s->len = 0;
>  }
>  
> -static void pca9535_reset(DeviceState *dev)
> +static void pca9535_reset_hold(Object *obj, ResetType type)
>  {
> -    PCA955xState *s = PCA955X(dev);
> +    PCA955xState *s = PCA955X(obj);
>  
>      s->regs[PCA9535_INPUT0] = 0xFF;   /* All inputs high (pull-ups) */
>      s->regs[PCA9535_INPUT1] = 0xFF;   /* All inputs high (pull-ups) */
> @@ -514,9 +514,10 @@ static void pca955x_class_init(ObjectClass *klass, const void *data)
>  static void pca9552_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
>      PCA955xClass *pc = PCA955X_CLASS(oc);
>  
> -    device_class_set_legacy_reset(dc, pca9552_reset);
> +    rc->phases.hold = pca9552_reset_hold;
>      dc->vmsd = &pca9552_vmstate;
>      pc->max_reg = PCA9552_LS3;
>      pc->pin_count = 16;
> @@ -526,9 +527,10 @@ static void pca9552_class_init(ObjectClass *oc, const void *data)
>  static void pca95x5_class_init(ObjectClass *oc, const void *data)
>  {
>      DeviceClass *dc = DEVICE_CLASS(oc);
> +    ResettableClass *rc = RESETTABLE_CLASS(oc);
>      PCA955xClass *pc = PCA955X_CLASS(oc);
>  
> -    device_class_set_legacy_reset(dc, pca9535_reset);
> +    rc->phases.hold = pca9535_reset_hold;
>      dc->vmsd = &pca9552_vmstate;
>      pc->max_reg = PCA9535_CONFIG1;
>      pc->pin_count = 16;
> 


