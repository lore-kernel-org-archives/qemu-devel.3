Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A500C2D0CD
	for <qemu-devel@archiver.kernel.org>; Thu, 15 May 2025 16:15:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uFbF4-0006Km-Iq; Thu, 15 May 2025 12:15:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbEx-0006Ij-EY; Thu, 15 May 2025 12:15:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1uFbEv-0001gM-JP; Thu, 15 May 2025 12:15:23 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54FCgAff004678;
 Thu, 15 May 2025 16:15:18 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=rEnSMV2iYEZ2R+P4TLKcKuClkFv5fZ9GNOw/RpVoLG4=; b=lEhS2TQgN0T8
 a6xGcog6U+/zJX4Mqt8KBNeVztxqJqbnm0D4xV8QlByspwfiG1AvHNhRlZgrfm4i
 YazJPPXh+jjximFysZGa8LRD5MSPGkZVVKfkpaCu0+AZE48M2tJapHJIzMQUchp0
 WadgCwwKUDGYG3yBktxyl69FUPxWlaGRyQJe7rC5rYkmluoUd8UCm5aIpJvUGtOr
 ESRa9NEdbEyYsj0+vbpAjJHFEP30RxNt7idDVWWCC8lHzz0WbAzNCZTF6xTv0aOD
 F3YZP/zebUOFfon5V0+W9e4iTpK08BzEp45pEUahqwo45GNsuOM0GHHOTZB74eZ5
 yKiDvIteag==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt7ed-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:15:18 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 54FGEiW7026686;
 Thu, 15 May 2025 16:15:18 GMT
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 46ndfjt7e9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:15:17 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 54FE40vg024279;
 Thu, 15 May 2025 16:15:17 GMT
Received: from smtprelay07.dal12v.mail.ibm.com ([172.16.1.9])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 46mbfsb5u2-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 15 May 2025 16:15:17 +0000
Received: from smtpav02.wdc07v.mail.ibm.com (smtpav02.wdc07v.mail.ibm.com
 [10.39.53.229])
 by smtprelay07.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 54FGFGTY6947354
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 15 May 2025 16:15:16 GMT
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id DF4B658061;
 Thu, 15 May 2025 16:15:15 +0000 (GMT)
Received: from smtpav02.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 55C265805D;
 Thu, 15 May 2025 16:15:15 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav02.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 15 May 2025 16:15:15 +0000 (GMT)
Message-ID: <86fec34079e7fc3b6c16afa276cc9f3df96d19b7.camel@linux.ibm.com>
Subject: Re: [PATCH 47/50] ppc/xive2: Implement POOL LGS push TIMA op
From: Miles Glenn <milesg@linux.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org
Cc: qemu-devel@nongnu.org, =?ISO-8859-1?Q?Fr=E9d=E9ric?= Barrat
 <fbarrat@linux.ibm.com>, Michael Kowal <kowal@linux.ibm.com>, Caleb
 Schlossin <calebs@linux.vnet.ibm.com>
Date: Thu, 15 May 2025 11:15:14 -0500
In-Reply-To: <20250512031100.439842-48-npiggin@gmail.com>
References: <20250512031100.439842-1-npiggin@gmail.com>
 <20250512031100.439842-48-npiggin@gmail.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: pVDJH722tF4OSLxkZq8LUNNpBnlbynnf
X-Authority-Analysis: v=2.4 cv=ecg9f6EH c=1 sm=1 tr=0 ts=68261316 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=dt9VzEwgFbYA:10 a=VnNF1IyMAAAA:8 a=pGLkceISAAAA:8
 a=s_r7pROeAOtUuJ4LlHUA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: sWj9nOHGWMhpG8DCtRFHwOr91UzppYgY
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwNTE1MDE2MCBTYWx0ZWRfXzu/achqSD7cV
 qpRNW0QwOLuTUDDenTYUDVLLQcNjXu/4J1NvTL6O2HV8MLYkTkedvDlptyfZpqlwD4OSxpNcldr
 v1JE8erSEcpaql6zkYnujvdHU+7SWooZD23GuW5nEURKjWRle0kzMOXsaEy8gonrPK+dZOLRBOC
 zsmwngIvc1gxo9MAEe8a0nAhzYF8rZK7QofyWGGMSjjZ29wgfh7DXqY6SzhNZqZrD9TaOJgR4Ct
 LQd2DPgXCHtLu/QdaL2ISAjBkakIBArnLc3S3IR2h+eTYH5zhgvCWhNzel6FeQaf2hIHbG/8f9t
 xu8WFotPc5tftG6/Pl+O13l0VSDZYDw+X9t4Gn1xo5n3aNb2G0sWZyWaMsiEbuYOF8LIvJiYmyP
 Jcj0XQvhJi6Afeu/Um59xOSPpnw+vfp3ARUHiYU7PjUGHr+dzRLEQHePu8n2Vfm89y3fdwUn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-05-15_07,2025-05-15_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=999
 impostorscore=0 spamscore=0 clxscore=1015 malwarescore=0 mlxscore=0
 lowpriorityscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 phishscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2505070000
 definitions=main-2505150160
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Mon, 2025-05-12 at 13:10 +1000, Nicholas Piggin wrote:
> Implement set LGS for the POOL ring.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  hw/intc/xive.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/hw/intc/xive.c b/hw/intc/xive.c
> index dc64edf13d..807a1c1c34 100644
> --- a/hw/intc/xive.c
> +++ b/hw/intc/xive.c
> @@ -532,6 +532,12 @@ static void xive_tm_set_os_lgs(XivePresenter *xptr, XiveTCTX *tctx,
>      xive_tctx_set_lgs(tctx, TM_QW1_OS, value & 0xff);
>  }
>  
> +static void xive_tm_set_pool_lgs(XivePresenter *xptr, XiveTCTX *tctx,
> +                          hwaddr offset, uint64_t value, unsigned size)
> +{
> +    xive_tctx_set_lgs(tctx, TM_QW2_HV_POOL, value & 0xff);
> +}
> +
>  /*
>   * Adjust the PIPR to allow a CPU to process event queues of other
>   * priorities during one physical interrupt cycle.
> @@ -737,6 +743,8 @@ static const XiveTmOp xive2_tm_operations[] = {
>        xive2_tm_push_pool_ctx, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_WORD2, 8, true, true,
>        xive2_tm_push_pool_ctx, NULL },
> +    { XIVE_TM_HV_PAGE, TM_QW2_HV_POOL + TM_LGS,   1, true, true,
> +      xive_tm_set_pool_lgs, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_CPPR,  1, true, true,
>        xive2_tm_set_hv_cppr, NULL },
>      { XIVE_TM_HV_PAGE, TM_QW3_HV_PHYS + TM_WORD2, 1, true, true,


