Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D26A0FF8867
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 20:20:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHSRe-0001E5-EP; Mon, 27 Apr 2026 16:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wHSRa-0001DA-SH; Mon, 27 Apr 2026 16:20:39 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wHSRZ-0008SE-C2; Mon, 27 Apr 2026 16:20:38 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 63R7oEY61895497; Mon, 27 Apr 2026 20:20:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=45xQP5OgGv8NwGuTvXtuISloDiOZ34uXHQNkR0hBd78=; b=HEHOZEadUK/A
 IleM5Np2X38KDzcvmmllslDTdNgWwwjSm27hLQalTxmxeaECRhQQ1E6mYbiJ68J7
 MFZczQW9h4xmm5jh2p353ZESw+uA3I/sliVVuws16y6t297lwXQHI+jnx+HGivfI
 0qm8xDOlTw0QvXMBFt9miIQL2dVyJTnw6VBiUTLYijWF81gBbWSrQCb8wPHVO3C6
 GdLOpHvaHkRKPN3FRR3r5p0mXrNEiv1bbI+GWQtfNh2tB7H1xTMMkwlNERWIQzPf
 7KHXVzp3uUYxrNoXy3hqyFCSaLcFl6aCfc8TpO3YuC1JGk23BQWxPyZ8SAldGrtu
 Zx0SOiw6GA==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4drm1dsgn4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:20:35 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63RK8jdj017154;
 Mon, 27 Apr 2026 20:20:34 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4ds9eh6qfp-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 27 Apr 2026 20:20:34 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (smtpav06.dal12v.mail.ibm.com
 [10.241.53.105])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 63RKKXZw25756280
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 27 Apr 2026 20:20:33 GMT
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D69D35805D;
 Mon, 27 Apr 2026 20:20:33 +0000 (GMT)
Received: from smtpav06.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 7F82C58043;
 Mon, 27 Apr 2026 20:20:33 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav06.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 27 Apr 2026 20:20:33 +0000 (GMT)
Message-ID: <43155ca34a6d250c8ed455a7c78887e1dfc62283.camel@linux.ibm.com>
Subject: Re: [PATCH 37/41] hw/ppc/pnv: drop extra ref on PHB after adding as
 child
From: Miles Glenn <milesg@linux.ibm.com>
To: =?ISO-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: armbru@redhat.com, Nicholas Piggin <npiggin@gmail.com>, Aditya Gupta
 <adityag@linux.ibm.com>, qemu-ppc@nongnu.org
Date: Mon, 27 Apr 2026 15:20:33 -0500
In-Reply-To: <20260427-qom-tests-v1-37-c413f3605311@redhat.com>
References: <20260427-qom-tests-v1-0-c413f3605311@redhat.com>
 <20260427-qom-tests-v1-37-c413f3605311@redhat.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: RXtfZXaKhfguhi-nNvKYlhp6AuZKJC3o
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDI3MDIxNiBTYWx0ZWRfX6GlOioOcgW2U
 b1C61SdIxOduyuXA15RO393HVL3rA5Z0yeVlnGq5LK51hMpAHE3P5HLIMA9/iObgUWtahLD89Za
 5l80a9LtkSeEzff7OSzhCRGulD51HrXNXH6w8N5RHfYxxk6Ay9R2LvVXt/h2u6XaWBR8asTdxEp
 p+AfttPa6BAGFce6cvLfcvIBIhXoOPaHKDVBY3pDZIbGz12dJL5EwigVsx57YHSSZVwmh5YAjoE
 3pP7vdHHP7wqMQ8KM4I8LGeYCehCZCndWxfB14eFCiUFRxQgEan1qVcDN+ec5QcP2UE25YDusYD
 ZpEza7PF9QmM0RXnCcgBBYKAR+ixJsf5RorIMujS883gaVQq0NmndpVKt071X0lj+ziiNHWTFcO
 8YZYNOgSqy6rOV9oo6nM47oNLpW9VGJ5tnyd4F5vej0rkS5K4GiZG/w5z4hzckJREcCReFSO3C6
 J09IUkyslG/cyHx12ig==
X-Authority-Analysis: v=2.4 cv=VZLH+lp9 c=1 sm=1 tr=0 ts=69efc513 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8
 a=20KFwNOVAAAA:8 a=uozdTTcig5jTw1E28QsA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: domT5kWHgwWAPCJoMN_QfccbVeBpVcLH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-27_04,2026-04-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 suspectscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 spamscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604200000 definitions=main-2604270216
Received-SPF: pass client-ip=148.163.158.5; envelope-from=milesg@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
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

On Mon, 2026-04-27 at 23:42 +0400, Marc-André Lureau wrote:
> object_new() returns an object with refcount 1, and
> object_property_add_child() adds another reference. The initial
> reference must be dropped so the parent becomes the sole owner,
> otherwise the PHB objects leak when the chip is destroyed.
> 
> Fixes: 0d512c7120a2 ("ppc/pnv: turn chip8->phbs[] into a PnvPHB* array")
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>  hw/ppc/pnv.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/hw/ppc/pnv.c b/hw/ppc/pnv.c
> index 524563dcfc2..476255b722f 100644
> --- a/hw/ppc/pnv.c
> +++ b/hw/ppc/pnv.c
> @@ -1590,6 +1590,7 @@ static void pnv_chip_power8_instance_init(Object *obj)
>               */
>              object_property_add_child(obj, "phb[*]", phb);
>              chip8->phbs[i] = PNV_PHB(phb);
> +            object_unref(phb);
>          }
>      }
>  
> 


