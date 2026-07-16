Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DDD3C4450A
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jul 2026 13:49:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wkMRu-0004Zp-Sd; Thu, 16 Jul 2026 09:48:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMRo-0004Yf-Ud; Thu, 16 Jul 2026 09:48:21 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wkMRm-0007kV-Ty; Thu, 16 Jul 2026 09:48:20 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66GDfirG3284440; Thu, 16 Jul 2026 13:48:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=rMeV24f77jcgDsebZCnnAnwM+JcAiwqX+E8EZBr+eeY=; b=p5OWQJoaPdGC
 BvbzV1uGBiH9PXwHP9ONJQI6yIvd8e5+BL3kVe8bzvox9MsPxPCFTQwk8yQjLo5t
 muxseEisv6TAmpmIeNPXym6TDzLpjhAsqFLIBPk74w4zLBBeBcymGZesjLFnsH7M
 BvyJmqGHaa2okPWLW1aVqkOc2vmtLNFuwtCpIgWpji92GfXJAgcPjGAc/vvjhIJx
 qPftwMLNWXT0nqdEvfhlX2QyjjTGFRBLjlg0+9rAg+NmQItDdbijFvz6xxFxNyIc
 lhIqe8eXVAAwXXSZuP/G8rJbU3lgaVHBu0bhihtzj252tswIo18XcT/wgujYe+iM
 9S1Khb06Bw==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbf2agd9b-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:48:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66GDYZgn001654;
 Thu, 16 Jul 2026 13:47:59 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hwdbx5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 16 Jul 2026 13:47:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66GDlxi633620706
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 16 Jul 2026 13:47:59 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 24BC05805A;
 Thu, 16 Jul 2026 13:47:59 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 51DE058052;
 Thu, 16 Jul 2026 13:47:58 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 16 Jul 2026 13:47:58 +0000 (GMT)
Message-ID: <c3781910d771ae2a566cfad8f11a0d84a34c8751.camel@linux.ibm.com>
Subject: Re: [PATCH 08/29] hw/gpio: pca9552: conform GPIO command handling
 to the datasheet
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
Date: Thu, 16 Jul 2026 08:47:58 -0500
In-Reply-To: <20260709-catalina-upgrade-v1-8-814575bc076b@free.fr>
References: <20260709-catalina-upgrade-v1-0-814575bc076b@free.fr>
 <20260709-catalina-upgrade-v1-8-814575bc076b@free.fr>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX33Kk91Q2A/EK
 mYYTasjHY8MlvQ3qcMD0ixlSlVHXYmu4ys30bcDfub2uz2Z13G9Y7xDvRViq+IHZK1Iw0DDtu7Y
 km0sK7CrJ581XLhh8bpgGZDvbuGQQW4=
X-Proofpoint-GUID: Lg7v-DrpV99JOyK9LEiyASN-9XCjz_E1
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzE2MDE0MSBTYWx0ZWRfX0Raz35RwkhA6
 8K2P8COEYytvAg+0w29LxqBvkEsccUUHbzqsLLRGNO5J65njR6iq7vxkhSm5SWFo9Bll+vbgVPX
 BUzNXlSUshwCraC5LnTn0QbyHcAaUk4OEidjPce+bqhWDPGLhDjg5fq8KWgtHIK5ZzjyisH/EsS
 I9vXxMo0pjm/9Uwmo8I17mtAujodQIB4bXkS2sGfYYCAE7wLX5VyLp/9XC0y4tcrHL8D6R55xSY
 7dRZXLM1RFk3SliA87BN/DMbuUDdr8EnPPn7w68kxzc2NkFbnyBoUqpvDb+mhg4N7UbF6YNR5Ws
 dsQd1Xn5SYZ196ji7hMO/2AaD9Nhe3mpRgvWt1M4kMcC0k8eT0PWjIUP2lUW9uPVPaq4uedg9PK
 ior0iBiq3OBjatNxX4MYcBz7p5D/HU7eVPW4czi52+Ns/05AZ3viKhOgyd9eUVWAEp/mejEiWPS
 Yv93+dYyRFOQMmIN9AA==
X-Proofpoint-ORIG-GUID: c2ucjzh_OgB7MXUmHVXW4ju0sawQiHx2
X-Authority-Analysis: v=2.4 cv=PvajqQM3 c=1 sm=1 tr=0 ts=6a58e111 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=6fD1RVXCq0XIch8PuH4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-16_05,2026-07-15_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 bulkscore=0 impostorscore=0 adultscore=0
 clxscore=1015 lowpriorityscore=0 spamscore=0 suspectscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607160141
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
> The PCA9535/PCA9555 GPIO expanders share the PCA955X command dispatch
> path with the PCA9552 LED blinker, but their register access differs from
> the LED variant:
> 
>   - Auto-increment happens on every access and toggles bit 0 so the
>     pointer stays within the addressed register pair (input, output,
>     polarity, config); there is no AI enable bit.
> 
>   - The command byte only decodes 3 bits, so addresses beyond the last
>     register alias back into the 8-register window instead of faulting.
> 
> Branch the auto-increment and command-decode logic on has_led_support so
> the GPIO variants follow their datasheet while the PCA9552 behaviour is
> left untouched.
> 
> Signed-off-by: Emmanuel Blot <emmanuel.blot@free.fr>
> ---
>  hw/gpio/pca9552.c | 37 +++++++++++++++++++++++++++++++------
>  1 file changed, 31 insertions(+), 6 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 24f6465415..54a5945d92 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -259,14 +259,26 @@ static void pca955x_write(PCA955xState *s, uint8_t reg, uint8_t data)
>  }
>  
>  /*
> - * When Auto-Increment is on, the register address is incremented
> - * after each byte is sent to or received by the device. The index
> - * rollovers to 0 when the maximum register address is reached.
> + * Advance the command pointer after each byte sent to or received from the
> + * device.
> + *
> + * The LED variant auto-increments only when the AI bit (bit 4) is set in the
> + * command byte, rolling over to 0 once the maximum register address is
> + * reached.
> + *
> + * The GPIO variants auto-increment on every access, toggling bit 0 so the
> + * pointer stays within the addressed register pair
> + * (input/output/polarity/config), as specified by their datasheet.
>   */
>  static void pca955x_autoinc(PCA955xState *s)
>  {
>      PCA955xClass *k = PCA955X_GET_CLASS(s);
>  
> +    if (!k->has_led_support) {
> +        s->pointer ^= 0x1;
> +        return;
> +    }
> +
>      if (s->pointer != 0xFF && s->pointer & PCA9552_AUTOINC) {
>          uint8_t reg = s->pointer & 0xf;
>  
> @@ -275,12 +287,25 @@ static void pca955x_autoinc(PCA955xState *s)
>      }
>  }
>  
> +/*
> + * The LED variant addresses its registers with a 4-bit command field, while
> + * the GPIO variants only decode 3 bits (the command wraps into the 8-register
> + * window).
> + */
> +static inline uint8_t pca955x_cmd_reg(PCA955xState *s)
> +{
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
> +
> +    return s->pointer & (k->has_led_support ? 0xf : 0x7);
> +}
> +
>  static uint8_t pca955x_recv(I2CSlave *i2c)
>  {
>      PCA955xState *s = PCA955X(i2c);
> +    PCA955xClass *k = PCA955X_GET_CLASS(s);
>      uint8_t ret;
>  
> -    ret = pca955x_read(s, s->pointer & 0xf);
> +    ret = pca955x_read(s, pca955x_cmd_reg(s));
>  
>      /*
>       * From the Specs:
> @@ -292,7 +317,7 @@ static uint8_t pca955x_recv(I2CSlave *i2c)
>       * I don't know what should be done in this case, so throw an
>       * error.
>       */
> -    if (s->pointer == PCA9552_AUTOINC) {
> +    if (k->has_led_support && s->pointer == PCA9552_AUTOINC) {
>          qemu_log_mask(LOG_GUEST_ERROR,
>                        "%s: Autoincrement read starting with register 0\n",
>                        __func__);
> @@ -312,7 +337,7 @@ static int pca955x_send(I2CSlave *i2c, uint8_t data)
>          s->pointer = data;
>          s->len++;
>      } else {
> -        pca955x_write(s, s->pointer & 0xf, data);
> +        pca955x_write(s, pca955x_cmd_reg(s), data);
>  
>          pca955x_autoinc(s);
>      }
> 


