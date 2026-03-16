Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D77EEFCBBB
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Mar 2026 06:09:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w218o-0002D8-RI; Mon, 16 Mar 2026 02:09:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w218m-0002C7-TT; Mon, 16 Mar 2026 02:09:24 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w218l-0008VY-Ev; Mon, 16 Mar 2026 02:09:24 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62FKUBZD706946; Mon, 16 Mar 2026 06:09:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d34HtI
 lyz0nYcFK/AMxR3VM6sPUODbMAsVQ/bK1fibg=; b=V8jeuhI5WtJSCfRM+t/ffD
 iIbeb+kyBo8SvYoaSBxVipv0Eh9x8RgwBpKxtq8SHlBP7BOdfb1HDhEOmTD1TGRR
 9/2X/LI49dXSU0546N2YBPXxOtsvxJ+AsbuxyReKt7yTsBhlwa9dLKtY44WBFIt+
 Lp+yy6g396ACHfsEJAIMK7+2Hqfj9n/FtJH8S6QxtZ1qCiDcH9eVDs/JBJACNGqr
 O/DGeLBxKoqd6IFBbEUaZKunCLnmoFaXxWhSp4NwJEeS6YQa5u8Mp4EczZyJuQ5h
 CgMOVvsiBAxbUrK29knzHK5SIQ3XYzw5nsekYJR7fhO6ZPUVqOleprIfmX3GjeZw
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cvw3hpc13-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 06:09:12 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62G5QOLM015601;
 Mon, 16 Mar 2026 06:09:12 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4cwk0n3nb9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 16 Mar 2026 06:09:12 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62G698cS52297988
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 16 Mar 2026 06:09:08 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D4222004F;
 Mon, 16 Mar 2026 06:09:08 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 718722004E;
 Mon, 16 Mar 2026 06:09:06 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Mon, 16 Mar 2026 06:09:06 +0000 (GMT)
Message-ID: <ae8da984cf172b6a8f75f61e0938f2c29e3aeef2.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Aditya Gupta <adityag@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Harsh Prateek Bora <harshpb@linux.ibm.com>, Peter
 Maydell	 <peter.maydell@linaro.org>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Date: Mon, 16 Mar 2026 11:39:05 +0530
In-Reply-To: <abPy6W6-_putw9Tz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <abPy6W6-_putw9Tz@li-3c92a0cc-27cf-11b2-a85c-b804d9ca68fa.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: vMxnStYjKAy-Gg1E_F6yvS_hSfoQ6y1b
X-Proofpoint-ORIG-GUID: 8UdbXHqpH0y0v_To-dn7q1jUVvUr9XLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE2MDA0MSBTYWx0ZWRfX+o2E7KMRUMBt
 Duvc4+7sb41onubmWDIefiTrAgS9yZlK5niOdJSnTh43/TGiYBOhrHzHTFeqKGPTXneg5Pk2OW/
 fJl5xlARFxdfCk9lRSV7xOW7jmOUV1soKM+p0+EQADP9zG1JyrM8wdAZlkkAYGRHkS/waWLKcCG
 q88CNdLsjzU/iDsGse0i8/whbQqX29rWl4Zv24vaU4vQJdKAiHdHLVs7UxWW8dYjhcR4zE5ijNR
 i4QpWub3VB/M5/arLG3Ul/G/nVszOxvwZ1ja+pxw9/C0ARVQIAH90yy5N2yo60rwDpWxtUTsd96
 qKKgBkk9LrHQDuJw1Ao3JWwybm7yAkYdrU2wFJx5YZL0F1Q0N/niCj3e6nHWmTIrRWZxCwlAkQ5
 LKYWOQQ2IC8kBApXB66WaBoWWrBqNMgNZJz8n4AAB3JYXIMroLZhbaEaUmToNbPc4kGnitM8VzR
 6RyhUCROY9hb6cKhynw==
X-Authority-Analysis: v=2.4 cv=Hf8ZjyE8 c=1 sm=1 tr=0 ts=69b79e89 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=13-aQ6eR0b4uENYIoH8A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-16_02,2026-03-13_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0 bulkscore=0
 suspectscore=0 priorityscore=1501 spamscore=0 adultscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2603050001 definitions=main-2603160041
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Fri, 2026-03-13 at 16:50 +0530, Aditya Gupta wrote:
>=20
> Looks good to me.
>=20
> Reviewed-by: Aditya Gupta <adityag@linux.ibm.com>
>=20
> Thanks,
> - Aditya G
Thanks Aditya.

~Shivang.

