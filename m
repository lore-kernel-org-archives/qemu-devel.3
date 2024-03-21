Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7339CD11C2
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Mar 2024 16:09:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnKxo-0004Jz-1h; Thu, 21 Mar 2024 12:08:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rnKxm-0004JM-AD; Thu, 21 Mar 2024 12:08:18 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.vnet.ibm.com>)
 id 1rnKxk-00072z-AL; Thu, 21 Mar 2024 12:08:18 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 42LFUUBC023858; Thu, 21 Mar 2024 16:08:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 mime-version : content-transfer-encoding; s=pp1;
 bh=nwNJakuMyWSK7rkCKFentytHbPa7vHV9BOo01hnT5rg=;
 b=Fu72FVCiLkz65hMrsnYoZFzGlRALJx6dLzDM2oGR661KSyks6qaZhqshBuS/qZQQVtk4
 AFe4kiD3KPpHwYDJlVM9258K0lkf643W9zoapmBeFRkx8A12AVkEMFtvuPuOQZNb0wL6
 UMwIEImJ+n568Vaw+Ybm8iiWrvuxewVIofe/dtxE9M4FGEawGhXlabwybGHvlN7Gpr2k
 GTVDQJdUSYyB6QOOK291fic4uA5t4oqE6hmhjLk77y86ylIP+oKknEA51VIaTVYaiujc
 SgpOPUSidOlD2/qm2zlSmrEaj9qZaFTaCQliRoAYrkNliTzXxUPTLQaBV4QRW9cAvjA+ Zg== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0n6wrmvq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 16:08:11 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 42LG8BFv022036;
 Thu, 21 Mar 2024 16:08:11 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3x0n6wrmvn-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 16:08:11 +0000
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 42LDukZF002815; Thu, 21 Mar 2024 16:08:10 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 3wwrf2wtgj-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 21 Mar 2024 16:08:10 +0000
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 42LG87Ak47383134
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 21 Mar 2024 16:08:10 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E4F3658068;
 Thu, 21 Mar 2024 16:08:07 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CC3F05805D;
 Thu, 21 Mar 2024 16:08:07 +0000 (GMT)
Received: from mamboa4.aus.stglabs.ibm.com (unknown [9.3.84.87])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 21 Mar 2024 16:08:07 +0000 (GMT)
Message-ID: <c383d6f489022a47c6a87a250f4d44938d9ede6b.camel@linux.vnet.ibm.com>
Subject: Re: [PATCH] misc/pca9554: Fix check of pin range value in property
 accessors
From: Miles Glenn <milesg@linux.vnet.ibm.com>
To: =?ISO-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-ppc@nongnu.org, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Date: Thu, 21 Mar 2024 11:08:07 -0500
In-Reply-To: <20240321160154.901829-1-clg@redhat.com>
References: <20240321160154.901829-1-clg@redhat.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-18.el8) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: B3jzi-GSzQPl1U2D8Zyx97hZamK3y1Zm
X-Proofpoint-ORIG-GUID: dlpMsCxE5Nc-ID67klwF-5E-y0_vurIe
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-21_10,2024-03-21_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011
 lowpriorityscore=0 adultscore=0 impostorscore=0 mlxscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 mlxlogscore=999 spamscore=0
 phishscore=0 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.12.0-2403140000 definitions=main-2403210117
Received-SPF: none client-ip=148.163.156.1;
 envelope-from=milesg@linux.vnet.ibm.com; helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On Thu, 2024-03-21 at 17:01 +0100, Cédric Le Goater wrote:
> Coverity detected an "Integer handling" issue with the pin value :
> 
>   In expression "state >> pin", right shifting "state" by more than 7
>   bits always yields zero.  The shift amount, "pin", is as much as 8.
> 
> In practice, this should not happen because the properties "pin8" and
> above are not created. Nevertheless, fix the range to avoid this
> warning.
> 
> Fixes: CID 1534917
> Fixes: de0c7d543bca ("misc: Add a pca9554 GPIO device model")
> Cc: Glenn Miles <milesg@linux.vnet.ibm.com>
> Signed-off-by: Cédric Le Goater <clg@redhat.com>
> ---
>  hw/misc/pca9554.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/hw/misc/pca9554.c b/hw/misc/pca9554.c
> index
> 778b32e4430a8b618322c26b1b185ed3ead97cc4..5e31696797d9564666ece6fe177
> 37ee2a9733e96 100644
> --- a/hw/misc/pca9554.c
> +++ b/hw/misc/pca9554.c
> @@ -160,7 +160,7 @@ static void pca9554_get_pin(Object *obj, Visitor
> *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> +    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
>          error_setg(errp, "%s invalid pin %s", __func__, name);
>          return;
>      }
> @@ -187,7 +187,7 @@ static void pca9554_set_pin(Object *obj, Visitor
> *v, const char *name,
>          error_setg(errp, "%s: error reading %s", __func__, name);
>          return;
>      }
> -    if (pin < 0 || pin > PCA9554_PIN_COUNT) {
> +    if (pin < 0 || pin >= PCA9554_PIN_COUNT) {
>          error_setg(errp, "%s invalid pin %s", __func__, name);
>          return;
>      }

Thanks, Cédric!  I guess I should be running coverity myself.

-Glenn

Reviewed-by: Glenn Miles <milesg@linux.vnet.ibm.com>


