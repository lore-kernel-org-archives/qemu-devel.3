Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28DC9D58D66
	for <qemu-devel@archiver.kernel.org>; Mon, 25 Nov 2024 16:28:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFbwu-0001Wc-FC; Mon, 25 Nov 2024 11:28:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFbwk-0001VN-8y; Mon, 25 Nov 2024 11:28:23 -0500
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1tFbwh-0003h9-8s; Mon, 25 Nov 2024 11:28:21 -0500
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AP7qBNC006932;
 Mon, 25 Nov 2024 16:28:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=czuRct9bVgCyrRsWo0I2SnhwUMDu+RUJfPopxcnyuAQ=; b=X5TYo/LxUn67
 05GcYQ/AtpVTzZkkeCCxDC03vQTNrZ+L1tl82ATQqS92KU8LpS8Puhghl5SFoYc2
 fYgzVBWRifM8nNlNv4bVguZyIUJl3yrr44Zrd15TkjIeyY9HN3oY312yBUkN8suS
 Kdeesr0haiHrT1Ir1tou8nGg7Po/9CKRsVc2i0iPHB6WSnQpR+jqYHQwNTMqHipx
 QXLAe2A92Ic8R5YSFOUJcb75gD39Yh8ffjjhwKh40ZWDznr+f8UDR5CZnol8zyHU
 2Usp8s91ft7/vHFh00Pfdf72xEfEVIUaG8jGyIbYwr/1miKAFQ/fUkKv7ffOlzlZ
 r+/uTIIKrQ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d215ph-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:28:15 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4APGSEE6015201;
 Mon, 25 Nov 2024 16:28:14 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4338d215pg-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:28:14 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4APEYOOq008785;
 Mon, 25 Nov 2024 16:28:13 GMT
Received: from smtprelay06.wdc07v.mail.ibm.com ([172.16.1.73])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 433scrtv1j-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 25 Nov 2024 16:28:13 +0000
Received: from smtpav04.dal12v.mail.ibm.com (smtpav04.dal12v.mail.ibm.com
 [10.241.53.103])
 by smtprelay06.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4APGSCYw14090870
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 25 Nov 2024 16:28:12 GMT
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1509558062;
 Mon, 25 Nov 2024 16:28:12 +0000 (GMT)
Received: from smtpav04.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CE9045805E;
 Mon, 25 Nov 2024 16:28:11 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav04.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 25 Nov 2024 16:28:11 +0000 (GMT)
Message-ID: <613eb9bb44df7bac82244a3dfae35d8bcf4a4d83.camel@linux.ibm.com>
Subject: Re: [PATCH 4/4] ppc/pnv: Add xscom- prefix to pervasive-control
 region name
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, Chalapathi V <chalapathi.v@linux.ibm.com>, Harsh
 Prateek Bora <harshpb@linux.ibm.com>
Date: Mon, 25 Nov 2024 10:28:11 -0600
In-Reply-To: <20241125132042.325734-5-npiggin@gmail.com>
References: <20241125132042.325734-1-npiggin@gmail.com>
 <20241125132042.325734-5-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-22.el8_8.2) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: ER_G7GNo4rwtDhG83DHx_fMgR28f9y6X
X-Proofpoint-ORIG-GUID: Kvy4NpVsDNoBqPXLVGFFMoA4vvXyhqt6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 malwarescore=0 mlxscore=0 suspectscore=0 phishscore=0 mlxlogscore=744
 spamscore=0 clxscore=1015 adultscore=0 lowpriorityscore=0 impostorscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411250138
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H2=-0.93, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 2024-11-25 at 23:20 +1000, Nicholas Piggin wrote:
> By convention, xscom regions get a xscom- prefix.
> 
> Fixes: 1adf24708bf7 ("hw/ppc: Add pnv nest pervasive common chiplet
> model")
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/ppc/pnv_nest_pervasive.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/hw/ppc/pnv_nest_pervasive.c
> b/hw/ppc/pnv_nest_pervasive.c
> index 77476753a4..780fa69dde 100644
> --- a/hw/ppc/pnv_nest_pervasive.c
> +++ b/hw/ppc/pnv_nest_pervasive.c
> @@ -177,7 +177,7 @@ static void
> pnv_nest_pervasive_realize(DeviceState *dev, Error **errp)
>      pnv_xscom_region_init(&nest_pervasive->xscom_ctrl_regs_mr,
>                            OBJECT(nest_pervasive),
>                            &pnv_nest_pervasive_control_xscom_ops,
> -                          nest_pervasive, "pervasive-control",
> +                          nest_pervasive, "xscom-pervasive-control",
>                            PNV10_XSCOM_CHIPLET_CTRL_REGS_SIZE);
>  }
>  


