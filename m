Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 32E7AC43327
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 14:35:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weD4z-0005Ef-2X; Mon, 29 Jun 2026 10:35:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1weD4Z-0004yn-Uz; Mon, 29 Jun 2026 10:35:01 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1weD4X-0001MX-6s; Mon, 29 Jun 2026 10:34:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65TAmF5x3181429; Mon, 29 Jun 2026 14:34:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=I6PvIoTKNCHAoj5y28jgY4fqsLOrU8VqUhtl+cA5bzc=; b=OiK23nzFVCZk
 1Il2X4EUOiDkcVD0VsSrFS8lTZTRLQaNw44liyoEZQIbux4qaSLzxk/8kaqcOOOj
 t0otOSMO9PkxrOVJUwb/bncbBHlOOZvEvwHWZ0j0XXdYjdXTWutUfZRSD2WET3p+
 yeLvE4ErQhpXkLBdYbXjCHxZOWIohJWHCO6LVEJW0++C58Nm7mnECeH89B1XZoja
 aKTRkqJCIdQLcODi4FEBBXpZeaQTsHD1zz/YySQjw03Ceo0hoaqaa56a4Gs5IbMt
 UE8fCTkDajbxXHttOYaFDCQw/uNYN44Krob7Gba6igQzvYo1jCwbV0QoMNoM0foC
 zjtIBQCgYQ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfswa2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 14:34:33 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65TEJhsH027908;
 Mon, 29 Jun 2026 14:34:32 GMT
Received: from smtprelay01.wdc07v.mail.ibm.com ([172.16.1.68])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbh5wa7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 29 Jun 2026 14:34:32 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay01.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65TEYV8v61538650
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 29 Jun 2026 14:34:32 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id A6A6B5805E;
 Mon, 29 Jun 2026 14:34:31 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A2075805D;
 Mon, 29 Jun 2026 14:34:31 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 29 Jun 2026 14:34:31 +0000 (GMT)
Message-ID: <c03cc164b52661b163361dca3a15fc2f5ff09b50.camel@linux.ibm.com>
Subject: Re: [PATCH] hw/gpio/pca9552: fix off-by-one in QOM led index
 validation
From: Miles Glenn <milesg@linux.ibm.com>
To: yujun <yujun@kylinos.cn>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>
Date: Mon, 29 Jun 2026 09:34:31 -0500
In-Reply-To: <20260629074133.187549-1-yujun@kylinos.cn>
References: <20260629074133.187549-1-yujun@kylinos.cn>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a428279 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BAimntSKH6pzpO6s080A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjI5MDExOSBTYWx0ZWRfX3o6EnLTQP3Lv
 ZKjCsuhoaB2gcmO3SZiAzzOs8r2mhAxr0i+tcN5RAg3IPGzfHJUi1g2g6aV/C/+C6cPFExu5lHi
 Z7TWdeunjBQQ4DJqfbGKK00Z0REbRxM=
X-Proofpoint-GUID: kvn2rFMyqVQMzrf4aY1oAoCAg5D0ge6d
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjI5MDExOSBTYWx0ZWRfX/RKGWkLURDa5
 yu/DDLfaH4iocC55SUR1G/ryEItZZUeKWg1yg+YyEdFwxkfugk3Tow8H2kiKwcU9x2mQop8SszQ
 3Mx4qbWwqKJtpF9++zk7GPIhoLa3qM+hhKWoAJwy0ICRCocs44swz9xTlprPVdUlktoxvwEndeN
 PplnH4Gtw5c1r/fY/6ytPEswTwhpKZ2GxtjYYELMnp+zw6UhOiWzeNFiJSuG34kBdAVO4ghx0Q2
 6uh6DRX9q2f7n/NygM933F+TcWy/XoROmZichYbn/E+n0xMW1gc3DpRTWpuUHdiPd76a7wtgxvd
 I4qqTUFO/k/Yd62nqvdyeMo5aH7qcXDt0O/l6mr5R7cU/k7gD3cdtt4Ip+jkgIszJ6hXTAPrQzm
 Fg0mmS8EVuEuezznZYL8yRy/oHosN7LOoeH7XU9Qsr54IFhz14Rm96EhAO1jdd9hX8C9VkVs4mK
 Fg7Ymx18BwPhd0ZzvFg==
X-Proofpoint-ORIG-GUID: kvn2rFMyqVQMzrf4aY1oAoCAg5D0ge6d
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-29_03,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1011
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606290119
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Mon, 2026-06-29 at 15:41 +0800, yujun wrote:
> pca955x_get_led() and pca955x_set_led() accept led indices equal to
> pin_count, but valid indices are 0..pin_count-1.  For a 16-pin device,
> led16 passes the current check and then accesses an LS register past
> max_reg.
> 
> Use the same >= pin_count bounds check as pca9554_set_pin() and the
> gpio input handler assert in this file.
> 
> Fixes: a90d8f84674 ("misc/pca9552: Add qom set and get")
> Signed-off-by: yujun <yujun@kylinos.cn>
> ---
>  hw/gpio/pca9552.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index 472d8ad957..b13ac9fd9c 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -311,8 +311,8 @@ static void pca955x_get_led(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (led < 0 || led > k->pin_count) {
> -        error_setg(errp, "%s invalid led %s", __func__, name);
> +    if (led < 0 || led >= k->pin_count) {
> +        error_setg(errp, "%s: invalid led %s", __func__, name);
>          return;
>      }
>      /*
> @@ -352,8 +352,8 @@ static void pca955x_set_led(Object *obj, Visitor *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (led < 0 || led > k->pin_count) {
> -        error_setg(errp, "%s invalid led %s", __func__, name);
> +    if (led < 0 || led >= k->pin_count) {
> +        error_setg(errp, "%s: invalid led %s", __func__, name);
>          return;
>      }
>  


