Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 601D6D715DE
	for <qemu-devel@archiver.kernel.org>; Sat, 24 Jan 2026 12:21:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjcdD-0001wW-VN; Sat, 24 Jan 2026 07:20:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjccz-0001on-Gb; Sat, 24 Jan 2026 07:20:33 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <adityag@linux.ibm.com>)
 id 1vjccx-00037o-St; Sat, 24 Jan 2026 07:20:33 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60O7uFlq017529;
 Sat, 24 Jan 2026 12:20:30 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-type:date:from:in-reply-to:message-id:mime-version
 :references:subject:to; s=pp1; bh=X07UQWbhWYUknVC1nvLZgkTB224We1
 5krHwS/c4Uhbs=; b=okzRZkRFO9yy1Aqikvpyf+2Y2Qs+vu3TaTEEGsuSxSYdC8
 3P7SALB0CH3/rXdYLa97iOzaDm5wwxorXkIcWh1XQE4pdhO1LKO9WbMPNPYOuHg1
 B5gmXEpEV/OacQlEHzCFegCf6HkRMaT+oRhV6AaKwiXTVy7D8i8y16SaFH4mpXhk
 2CBtSfGa7pUHgccs0Et/48YXXfVgYOvSX/uT9eA1ZLiP4P60qgQdIIqMjugys1Gz
 KHoK3UHUhei4RHDtl2a8wRUllqch+6h3HTViTPrYTY1CiRzQ2EZzPEqWDnnafJgZ
 9dEPZXWji/8udZ/w3TPwIe6xjqCnmuX91xiwV/8g==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6hdba-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:20:29 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60OCKThZ013955;
 Sat, 24 Jan 2026 12:20:29 GMT
Received: from ppma11.dal12v.mail.ibm.com
 (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvnk6hdb7-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:20:29 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
 by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60OA8XA9006451;
 Sat, 24 Jan 2026 12:20:28 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4brqf257c1-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Sat, 24 Jan 2026 12:20:28 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 60OCKO2r58196236
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Sat, 24 Jan 2026 12:20:24 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 98A982004F;
 Sat, 24 Jan 2026 12:20:24 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D4E062004B;
 Sat, 24 Jan 2026 12:20:21 +0000 (GMT)
Received: from li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com (unknown
 [9.39.25.49]) by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Sat, 24 Jan 2026 12:20:21 +0000 (GMT)
Date: Sat, 24 Jan 2026 17:50:18 +0530
From: Aditya Gupta <adityag@linux.ibm.com>
To: Caleb Schlossin <calebs@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, chalapathi.v@linux.ibm.com
Subject: Re: [PATCH 3/4] ppc/pnv: Add unimplemented quad and core regs
Message-ID: <aXS4a0KAZ-MrHnjq@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20251218200353.301866-1-calebs@linux.ibm.com>
 <20251218200353.301866-4-calebs@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251218200353.301866-4-calebs@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: cg_Y_21o6SD1gqifS_Rs5_S7G0yXtDqC
X-Proofpoint-ORIG-GUID: E0VMGapCOFM0ftjfia6DmEq0Q83hA7at
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI0MDA5OCBTYWx0ZWRfX/rxUJhYCsgDA
 MWUrOf2GSVOJ5gS0j3leBfgG+YZMpTiyl8DGk5f5iqOvyn5gvjdoyw42YccFenLkl0qq6HqdAeX
 I2b5y9BZ8jjLW/KbKm3EEajGBi81vQnSE+1H6P6/AnhGQF9F9G1wie5WBg/Qd8rIqCxwiWCsFhE
 rQMCvn3UycGe70UrS5YcGxZpryt3wy44334rJ+Cb0wc3NNOiz4a5Fg3v8DiTCidFZKUOierEprG
 fP0KK4/OHktQFvGz+JXOaYuVkz9iCOqUGw8ZacHLYFQc5VyVtWJOMtMwTPBsw5t7BmhRg5xt0Sr
 wuZhB6Gz5QzkGQcUnEgA/UtfCKiA4OX+bTLFhtB2y0FXTzlsNK02ZhXXqNiKfUNA4EQpFg6awWx
 7aqT11z/mqXdlOUYdCtXEKbUKlzKaeREGfrAsJWo58vU5rp0GmuzJhKrwz19ydn+ndvKZcpEE21
 48wG3dDq5Q5lScV8+ow==
X-Authority-Analysis: v=2.4 cv=AMiVTGgp c=1 sm=1 tr=0 ts=6974b90d cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=kj9zAlcOel0A:10 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=qH1C6u0V_5AcyNmT3agA:9 a=CjuIK1q_8ugA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.20,FMLib:17.12.100.49
 definitions=2026-01-24_02,2026-01-22_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 spamscore=0 phishscore=0 bulkscore=0 suspectscore=0
 adultscore=0 clxscore=1015 priorityscore=1501 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2601240098
Received-SPF: pass client-ip=148.163.156.1; envelope-from=adityag@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 25/12/18 02:03PM, Caleb Schlossin wrote:
> This commit adds the read/write functionality for few core and
> quad registers.
> 
> Signed-off-by: Chalapathi V <chalapathi.v@linux.ibm.com>
> Signed-off-by: Caleb Schlossin <calebs@linux.ibm.com>
> ---
>  hw/ppc/pnv_core.c | 81 +++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 81 insertions(+)
> 
> > <...snip...>
> 
> @@ -589,6 +653,23 @@ static void pnv_quad_power10_xscom_write(void *opaque, hwaddr addr,
>      uint32_t offset = addr >> 3;
>  
>      switch (offset) {
> +    case P10_XSCOM_EQ0_MODE_REG1:
> +    case P10_XSCOM_EQ0_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ0_HTM_MODE:
> +    case P10_XSCOM_EQ0_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ1_MODE_REG1:
> +    case P10_XSCOM_EQ1_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ1_HTM_MODE:
> +    case P10_XSCOM_EQ1_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ2_MODE_REG1:
> +    case P10_XSCOM_EQ2_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ2_HTM_MODE:
> +    case P10_XSCOM_EQ2_HTM_IMA_PDBAR:
> +    case P10_XSCOM_EQ3_MODE_REG1:
> +    case P10_XSCOM_EQ3_NCU_SPEC_BAR_REG:
> +    case P10_XSCOM_EQ3_HTM_MODE:
> +    case P10_XSCOM_EQ3_HTM_IMA_PDBAR:
> +        break;
>      default:
>          qemu_log_mask(LOG_UNIMP, "%s: unimp write 0x%08x\n", __func__,
>                        offset);

Similar to patch 1, we are masking a warning. Though I don't have strong
opposition here, as many of these regs will likely never be implemented
in qemu, like the fir and those eq xscoms etc.
Hence, looks good to me:

Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>

Thanks,
- Aditya G


