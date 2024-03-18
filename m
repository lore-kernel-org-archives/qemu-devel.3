Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEA0BC54E5D
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Mar 2024 18:17:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rmHX4-0000N0-Hu; Mon, 18 Mar 2024 14:16:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rmHX1-0000MD-Rs; Mon, 18 Mar 2024 14:16:19 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rmHWy-0002TN-S7; Mon, 18 Mar 2024 14:16:18 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IHfaJY012761; Mon, 18 Mar 2024 18:16:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=x+2+C/wdmIuQMxQNZFIKEYER90cpmH6hKJ2Mdu2L8XU=;
 b=VvunnAwDFrowY2aiPg8OWYAqZFCwMR9RVSGpnqrAt6T6THVCZiB2SJ8a6qHwThKGQzGy
 t4h+nJ/PPeD+NcybMB3NYrEb7y25utM34UAExiOnbD7L+6XHCU6nFlfpQmMeyNThGOjV
 20Jmcs01CqVqKO0FWpvtOrRmlm/CJC0VPTfCwVi4mdfSJ3x5yYBdpBP/KQfMw3R/Lbcl
 pBD2hRXF3zf1RlIStXMzqcdLn4Ol9uQwPNU8cvwpzjmrCDAne+4F8jR8OqDfnLU5vBbu
 zHXa84hZqQi9bIiiIJoSAnvN9mE9mjrp7insmIB31Yj1AiI3tw7CrPiwyfMBa7qZ04hX 3w== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxt3r07m7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 18:16:12 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42IICb8l021283;
 Mon, 18 Mar 2024 18:16:12 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3wxt3r07m5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 18:16:12 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42IHMWAX017218; Mon, 18 Mar 2024 18:16:11 GMT
Received: from smtprelay02.dal12v.mail.ibm.com ([172.16.1.4])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwnrt2ryr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 18 Mar 2024 18:16:11 +0000
Received: from smtpav03.dal12v.mail.ibm.com (smtpav03.dal12v.mail.ibm.com
 [10.241.53.102])
 by smtprelay02.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42IIG9I019464738
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 18 Mar 2024 18:16:11 GMT
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 6EEA658056;
 Mon, 18 Mar 2024 18:16:09 +0000 (GMT)
Received: from smtpav03.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4AB9F5803F;
 Mon, 18 Mar 2024 18:16:09 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav03.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 18 Mar 2024 18:16:09 +0000 (GMT)
Message-ID: <6f9acf388883bfe15e27ee26dcacff91f330e485.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: I2C controller is not user creatable
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Nicholas Piggin <npiggin@gmail.com>, Thomas Huth
 <thuth@redhat.com>
Date: Mon, 18 Mar 2024 13:16:09 -0500
In-Reply-To: <20240318155844.224193-1-clg@redhat.com>
References: <20240318155844.224193-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: SIaHDDoPcJvQ3yCaVDQQv8hhdWMHeYWa
X-Proofpoint-ORIG-GUID: Qququ7e4bIcGeqp1asjI77A2i837M4E_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-18_12,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 suspectscore=0 malwarescore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 phishscore=0 clxscore=1015 impostorscore=0 lowpriorityscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2403140000 definitions=main-2403180138
Received-SPF: none client-ip=148.163.158.5;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_NONE=0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, 2024-03-18 at 16:58 +0100, Cédric Le Goater wrote:

Thanks for fixing that!

-Glenn

Reviewed-by: Glenn Miles <milesg@linux.vnet.ibm.com>

> The I2C controller is a subunit of the processor. Make it so and
> avoid
> QEMU crashes.
> 
>   $ build/qemu-system-ppc64 -S -machine powernv9 -device pnv-i2c
>   qemu-system-ppc64: ../hw/ppc/pnv_i2c.c:521: pnv_i2c_realize:
> Assertion `i2c->chip' failed.
>   Aborted (core dumped)
> 
> Fixes: 263b81ee15af ("ppc/pnv: Add an I2C controller model")
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Reported-by: Thomas Huth <thuth@redhat.com>
> Reviewed-by: Thomas Huth <thuth@redhat.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/ppc/pnv_i2c.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/hw/ppc/pnv_i2c.c b/hw/ppc/pnv_i2c.c
> index
> 4581cc5e5d4645ab3e358d983a633e33a214c425..eec5047ce83f842108b53a6e2bd
> 9869a81f14ac1 100644
> --- a/hw/ppc/pnv_i2c.c
> +++ b/hw/ppc/pnv_i2c.c
> @@ -557,6 +557,9 @@ static void pnv_i2c_class_init(ObjectClass
> *klass, void *data)
> 
>      xscomc->dt_xscom = pnv_i2c_dt_xscom;
> 
> +    /* Reason: This device is part of the CPU and cannot be used
> separately */
> +    dc->user_creatable = false;
> +
>      dc->desc = "PowerNV I2C";
>      dc->realize = pnv_i2c_realize;
>      device_class_set_props(dc, pnv_i2c_properties);


