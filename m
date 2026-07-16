Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8BA7C44501
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 12:58:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkLeu-00085J-58; Thu, 16 Jul 2026 08:57:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLeq-00084E-7y; Thu, 16 Jul 2026 08:57:44 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkLeo-0001jF-89; Thu, 16 Jul 2026 08:57:43 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GABo5M1019571; Thu, 16 Jul 2026 12:57:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=9/mfQgoJkOYvRny2bpFgjKxT28PvB3isTobzU9OKyEg=; b=fQod8zmrbU9D
 dv2KHvtqAlo5d1FpXFZfZs/3e8goqzq/507127ScUKsPEhUGHnncUncdefxb72tw
 c6jfj2Rovnew8Rxs+q/KH++/TFkfDFJES/g2IBo+l+S/2kYeMtEHYxrsOMcxU777
 0gLropxxxjq5AkidB3dWgKEP6N4sNEKxYO7FYbUt49fE5WGXNpyM1J1MSTRN0mUP
 ixDn4de+vDBKsyBSYVBwWpDMF1fHpZTbnLv3YUBFi+JE8AUcuFbtXjfHFDK6kzvU
 32Tyf1aTrpCMT7LdOG0N/nzT4UIL/Rxz3C4BJufuo/XfldDY3/0/LebFReYyStOX
 W5vYdP2cfQ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv33he02-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:57:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GCnamm022917;
 Thu, 16 Jul 2026 12:57:16 GMT
Received: from smtprelay05.dal12v.mail.ibm.com ([172.16.1.7])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc2cgmu4p-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 12:57:16 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay05.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GCvFru29754016
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 12:57:15 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 40E9658065;
 Thu, 16 Jul 2026 12:57:15 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1127958063;
 Thu, 16 Jul 2026 12:57:14 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 12:57:13 +0000 (GMT)
Message-ID: <a090ddec3b1d3d9b3e737a5c9158d4ba69fe61ae.camel@linux.ibm.com>
Subject: Re: [PATCH 02/29] hw/gpio: pca9552: move PCA955xState definition
 out of the header
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
Date: Thu, 16 Jul 2026 07:57:13 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-2-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-2-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX/PxD76UreRxd
 0d4gTmBzV8iY78kE4w2RGNrxTHJRiIdTU0Wd1eVmasXVJr72bSjg+l6PZo170BVkKguynpBxP97
 TrMaGnNA5u3jIDxVz5vlW3IUVVcfhyI=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a58d52d cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=8AirrxEcAAAA:8
 a=VnNF1IyMAAAA:8 a=wxtTKPZJDoS4x3clT7EA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=ST-jHhOKWsTCqRlWije3:22
X-Proofpoint-GUID: jvJ5Q_ZjdRFpNvJs4LJyrEyYaeQM4gNA
X-Proofpoint-ORIG-GUID: hxuby97HUj03fmHlnAJWgapRXxrkbnxy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDEzMSBTYWx0ZWRfX/RH4Z3aFstgb
 kDQj4SMHgU7sZ1Yc2lZmWq8GRJUYB6HPeMlQpf3eZYogpRnTGdIUvKaC3SEQrNB0gBo5ixzNxyg
 vP9xroKCwEQbak/Rw0grq+0eyFRu1J6omONZHq8FkDpRudIT9vJrIlyodLvfx2f8qk8jbOCmPny
 +nrrWPCWBd94ylVG9ZaQMDsj0jV4vJBbUeblGUG4rLytarCvdFJcLFUwL8Udo/OWgWX55yDnDBK
 Mt+nASk9mnEfKoP85fr2Q+mNxBaE0VHv+ABG2EeFk1aDfyJjmiqxNpzuDoj5sr2suBxR88yd8ux
 jG7SFEnQFfAN9nOROp+r2xxh/98DNqDMEOugRhcnE1UnOHcAjTHaZaqxyZm8a2/pH4jAxaeU+Qu
 /VCDi8SURa2D4eIhzAofvemrzn9j9Yt5ggjWYFl20ENYs4ZGq8ODABtCG/sJ/5tkuiJBc2A66vP
 tiOvpL7aJWcbPvqYYFQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_04,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
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
> Nothing outside pca9552.c uses the PCA955xState structure, its instance
> checker, or the PCA955X_NR_REGS/PCA955X_PIN_COUNT_MAX defines: the board
> files and qtests only rely on the TYPE_* name macros (and the register
> macros in pca9552_regs.h).
> 
> Move the state structure and the size defines into pca9552.c, leaving
> pca9552.h with just the type-name macros. While at it, replace the
> separate DECLARE_INSTANCE_CHECKER and DECLARE_CLASS_CHECKERS declarations
> with a single OBJECT_DECLARE_TYPE().
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c         | 29 ++++++++++++++++++++++++-----
>  include/hw/gpio/pca9552.h | 30 ++++--------------------------
>  2 files changed, 28 insertions(+), 31 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 50e868a6e9a..36bc4f86edb 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -1,7 +1,10 @@
>  /*
> - * PCA9552 I2C LED blinker
> + * PCA955X I2C LED blinker and I/O expanders
>   *
>   *     https://www.nxp.com/docs/en/application-note/AN264.pdf
> + *     https://www.nxp.com/docs/en/data-sheet/PCA9552.pdf
> + *     https://www.nxp.com/docs/en/data-sheet/PCA9555.pdf
> + *     https://www.nxp.com/docs/en/data-sheet/PCA9535_PCA9535C.pdf
>   *
>   * Copyright (c) 2017-2018, IBM Corporation.
>   * Copyright (c) 2020 Philippe Mathieu-Daudé
> @@ -12,9 +15,9 @@
>  
>  #include "qemu/osdep.h"
>  #include "qemu/log.h"
> -#include "qemu/module.h"
>  #include "qemu/bitops.h"
>  #include "hw/core/qdev-properties.h"
> +#include "hw/i2c/i2c.h"
>  #include "hw/gpio/pca9552.h"
>  #include "hw/gpio/pca9552_regs.h"
>  #include "hw/core/irq.h"
> @@ -24,6 +27,25 @@
>  #include "trace.h"
>  #include "qom/object.h"
>  
> +#define PCA955X_NR_REGS 10
> +#define PCA955X_PIN_COUNT_MAX 16
> +
> +OBJECT_DECLARE_TYPE(PCA955xState, PCA955xClass, PCA955X)
> +
> +struct PCA955xState {
> +    /*< private >*/
> +    I2CSlave i2c;
> +    /*< public >*/
> +
> +    uint8_t len;
> +    uint8_t pointer;
> +
> +    uint8_t regs[PCA955X_NR_REGS];
> +    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
> +    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
> +    char *description; /* For debugging purpose only */
> +};
> +
>  struct PCA955xClass {
>      /*< private >*/
>      I2CSlaveClass parent_class;
> @@ -33,10 +55,7 @@ struct PCA955xClass {
>      uint8_t max_reg;
>      bool has_led_support;
>  };
> -typedef struct PCA955xClass PCA955xClass;
>  
> -DECLARE_CLASS_CHECKERS(PCA955xClass, PCA955X,
> -                       TYPE_PCA955X)
>  /*
>   * Note:  The LED_ON and LED_OFF configuration values for the PCA955X
>   *        chips are the reverse of the PCA953X family of chips.
> diff --git a/include/hw/gpio/pca9552.h b/include/hw/gpio/pca9552.h
> index 43b175235d2..71479ea0006 100644
> --- a/include/hw/gpio/pca9552.h
> +++ b/include/hw/gpio/pca9552.h
> @@ -1,39 +1,17 @@
>  /*
> - * PCA9552 I2C LED blinker
> + * PCA955X I2C LED blinker and I/O expanders
>   *
>   * Copyright (c) 2017-2018, IBM Corporation.
>   *
>   * This work is licensed under the terms of the GNU GPL, version 2 or
>   * later. See the COPYING file in the top-level directory.
>   */
> -#ifndef PCA9552_H
> -#define PCA9552_H
>  
> -#include "hw/i2c/i2c.h"
> -#include "qom/object.h"
> +#ifndef HW_GPIO_PCA9552_H
> +#define HW_GPIO_PCA9552_H
>  
> -#define TYPE_PCA9552 "pca9552"
>  #define TYPE_PCA955X "pca955x"
> +#define TYPE_PCA9552 "pca9552"
>  #define TYPE_PCA9535 "pca9535"
> -typedef struct PCA955xState PCA955xState;
> -DECLARE_INSTANCE_CHECKER(PCA955xState, PCA955X,
> -                         TYPE_PCA955X)
> -
> -#define PCA955X_NR_REGS 10
> -#define PCA955X_PIN_COUNT_MAX 16
> -
> -struct PCA955xState {
> -    /*< private >*/
> -    I2CSlave i2c;
> -    /*< public >*/
> -
> -    uint8_t len;
> -    uint8_t pointer;
> -
> -    uint8_t regs[PCA955X_NR_REGS];
> -    qemu_irq gpio_out[PCA955X_PIN_COUNT_MAX];
> -    uint8_t ext_state[PCA955X_PIN_COUNT_MAX];
> -    char *description; /* For debugging purpose only */
> -};
>  
>  #endif
> 


