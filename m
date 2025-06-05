Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A08DFC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 21:04:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uNHkW-0002dR-TZ; Thu, 05 Jun 2025 17:03:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uNHkS-0002c6-Qo; Thu, 05 Jun 2025 17:03:40 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uNHkQ-0003GL-JN; Thu, 05 Jun 2025 17:03:40 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 555Er86v022794;
 Thu, 5 Jun 2025 21:03:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=puzd1kd0yklIvH57H9PNpehaBQCRawidCxxa8GuPr80=; b=dOZwRIywgCN6
 9YMe6WOM/pafvbeHN4zjFmmOSpeReUjXtE1AMUyh5ypgKgZ35eSZFBWGrfFWBOCg
 63nCa7Qchwz8HQomAjX0aPV62NxgHyM1j2HCSkbObPe9FluWf+aOFDpJ/TdkEBwY
 p0QP6FKVRRy4XX6ncatyWYmng2RZON5E1Wl4hzbU2B1v5oqHozBbFyIoqJz9G0v9
 652HZkr3sFGGrWAIH0hOsh3ZHDxmENrDNKdt2jGZVuDEM+rRgyyeKfB0liKL1tuz
 It+DIN9ayuIIxy4lyWu9dfzRTrY7fFR/hLxEsN6KQouiOqQJZTp6jFv4LQDrRb0B
 E8OHoVhdag==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 471gf034dx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 21:03:32 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 555H4GMW031650;
 Thu, 5 Jun 2025 21:03:31 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 470cg06ntk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Jun 2025 21:03:31 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 555L3VSx28836406
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Jun 2025 21:03:31 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id F0D9B58059;
 Thu,  5 Jun 2025 21:03:30 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 762C75805E;
 Thu,  5 Jun 2025 21:03:30 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Jun 2025 21:03:30 +0000 (GMT)
Message-ID: <09c3fae7563bb32237862a71414a14f725d052e4.camel@linux.ibm.com>
Subject: Re: [PATCH 1/4] hw/gpio/pca9552: Avoid using g_newa()
From: Miles Glenn <milesg@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau
 <marcandre.lureau@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Stefan Berger
 <stefanb@linux.vnet.ibm.com>, "Daniel P ." =?ISO-8859-1?Q?Berrang=E9?=
 <berrange@redhat.com>
Date: Thu, 05 Jun 2025 16:03:30 -0500
In-Reply-To: <20250605193540.59874-2-philmd@linaro.org>
References: <20250605193540.59874-1-philmd@linaro.org>
 <20250605193540.59874-2-philmd@linaro.org>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Pq2TbxM3 c=1 sm=1 tr=0 ts=68420625 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6IFa9wvqVegA:10 a=VnNF1IyMAAAA:8 a=KKAkSRfTAAAA:8
 a=BRqcx2DXgZmGtgVnd2oA:9 a=3ZKOabzyN94A:10
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNjA1MDE5MCBTYWx0ZWRfX2K77JXVYCiUO
 7Hai/4mzTVOTcJ2fDmKHk2kNZfZMQlnQhIYJHJV6KxRBoGSaapWPmWZSLixWASM5dsKQxFn19ki
 hWwVf/oCXqoWZGb1yQ5/cEWhLVtkKsWwXukPi095/SBv2IJjdh4VXeKloRPUIEod3ml+cPAqSgM
 IpKJ43W5K//OHk3GowwmT2qze/zy94G+jZrEScIxeBjDtNePtKVbCOkDJaSql5s+nXpSd7cBQVC
 els0E5kNiijlQAUA96VxfRkFJD8i2Nb2f1BG5XksehABJJb8mw2b9iBUCvifQDRaCXgOGj23Eqy
 LBWb7G5LT331SgKqoCkVZZwjvbgPBKoUaqmn3yobdDOwP/hQx1kf9Tfx6jZiql3EyGoJ6W3qc89
 Ax0itbUQ4lc34atQyHKNWSSWcFrKthcgQ+chtqZ8/hySmYHdNg6U9Uk5mq7dCho6bktaNRJy
X-Proofpoint-GUID: bppj7D4z7TJLtO-TdKDTmwUe2OOYyzcE
X-Proofpoint-ORIG-GUID: bppj7D4z7TJLtO-TdKDTmwUe2OOYyzcE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-05_06,2025-06-05_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0
 lowpriorityscore=0 clxscore=1011 malwarescore=0 mlxlogscore=884
 phishscore=0 bulkscore=0 spamscore=0 suspectscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505280000
 definitions=main-2506050190
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Thanks!

Glenn

On Thu, 2025-06-05 at 21:35 +0200, Philippe Mathieu-Daudé wrote:
> We have pin_count <= PCA955X_PIN_COUNT_MAX. Having
> PCA955X_PIN_COUNT_MAX = 16, it is safe to explicitly
> allocate the char buffer on the stack, without g_newa().
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>  hw/gpio/pca9552.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/gpio/pca9552.c b/hw/gpio/pca9552.c
> index d65c0a2e90f..1e10238b2e0 100644
> --- a/hw/gpio/pca9552.c
> +++ b/hw/gpio/pca9552.c
> @@ -76,7 +76,7 @@ static void pca955x_display_pins_status(PCA955xState *s,
>          return;
>      }
>      if (trace_event_get_state_backends(TRACE_PCA955X_GPIO_STATUS)) {
> -        char *buf = g_newa(char, k->pin_count + 1);
> +        char buf[PCA955X_PIN_COUNT_MAX + 1];
>  
>          for (i = 0; i < k->pin_count; i++) {
>              if (extract32(pins_status, i, 1)) {


