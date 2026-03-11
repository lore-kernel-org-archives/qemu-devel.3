Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C749112583E
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Mar 2026 15:12:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0LB7-0006uU-Kh; Wed, 11 Mar 2026 11:08:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w0L7I-0008F6-PS; Wed, 11 Mar 2026 11:05:00 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1w0L7F-0004KO-SR; Wed, 11 Mar 2026 11:04:55 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62BE70AK1572387; Wed, 11 Mar 2026 15:04:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=5UkwA6
 5NDcfG4zekk3u7IT2HErsWxOHJHQSwR0iqfyo=; b=UrF11rEDVpa+I4slcR0iNm
 ohwY5NG0kFHRH6xizYKifLuvsTV2841q4DjTXGpveKuKcDSYWDLQ1LUwca0ehouN
 VzHICIuYuwHOPV/QiJ7W1UIR6B0yDRkIOTnJGGxKKqOaDdAqOFsQNvQRARGwrWuN
 nmslcuQ0ac38WHGWVBpiviSgmEtg/tiLWBpumSVLtWSiFz2D6nnONVVgCPrbxxi3
 zAkf3s8ZnC3z6V7A/oTjVnlsLm2AM7gf1TowxW8PCuqdXhKQ97cAw5OS66gRdsnA
 Eh5b4PsOkXv1WYjZNYBJLDejq1T3lh5QG1cR671wSrO1AsR8vVOkcYfn3rxC8FPA
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4crcuygg9c-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 15:04:46 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62BC4Tw4015629;
 Wed, 11 Mar 2026 15:04:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4crybndx4a-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 11 Mar 2026 15:04:45 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 62BF4fxh24248860
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 11 Mar 2026 15:04:41 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 4766B20049;
 Wed, 11 Mar 2026 15:04:41 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 254B720040;
 Wed, 11 Mar 2026 15:04:39 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.21.199])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 11 Mar 2026 15:04:38 +0000 (GMT)
Message-ID: <9961a4e3b69cdc9fb1b6852143b4ea8e784d01ee.camel@linux.ibm.com>
Subject: Re: [PATCH v2] ppc/pnv: fix dumpdtb option
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, npiggin@gmail.com,
 milesg@linux.ibm.com, Aditya Gupta <adityag@linux.ibm.com>, Harsh Prateek
 Bora	 <harshpb@linux.ibm.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, qemu-stable@nongnu.org
Date: Wed, 11 Mar 2026 20:34:38 +0530
In-Reply-To: <CAFEAcA-MHLyKvJcbSpEGQz74dgFLJm2Bhda2=xSgXigdU=32eg@mail.gmail.com>
References: <20260311143549.118720-1-shivangu@linux.ibm.com>
 <CAFEAcA-MHLyKvJcbSpEGQz74dgFLJm2Bhda2=xSgXigdU=32eg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=EK4LElZC c=1 sm=1 tr=0 ts=69b1848f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VwQbUJbxAAAA:8
 a=KKAkSRfTAAAA:8 a=VnNF1IyMAAAA:8 a=69wJf7TsAAAA:8 a=olr8_b_11Gw2Ed3HJgkA:9
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzExMDEyNyBTYWx0ZWRfX2v703zZhNDZk
 gb7QR8Z0e9e0rtSEnm49icaB0E6WyroNeYj0OswQnzQfwdkFJTIyJElN8jXeIPiywWeBHjZgZaA
 rn5kmYdhzTPRVmygQxHYvFtBehg4oi3MtBVMofZdPSEjJKHrYnG64X8T9FznzdKj8dyBiZgRViJ
 sH4T6tnDuwRVvzalAQlCil4ss8zkJpvo35sKF+5swfK0S/4m9eP5R7ljAzxGCkrG4Tcp83WkAUx
 ogKfp7XgZC0WP2itdMaZC1qGZTOu0SL8Py5L6aqb2aOxg4VSnTqajEU2vNFkwt6VzV8XzNsMdaL
 owqSTsmW6Ds852pXPmA//2qq0j28HYsyilXo6T6+GsOE4cdhwjFanHtrYBKBByI+4GBE+MyLMxQ
 e7QeM3AxqgQZWoQnbkCTL+Snjm1WAByMD8jjQ1PaIhc2Y5xc/qQbYU6e/tCFjkp0tVwS53HQ/sj
 52C2cnqn7DfbjJIJQ7g==
X-Proofpoint-GUID: WREC7kpYs32cHmEa7GtBE_P7hQO1qzgp
X-Proofpoint-ORIG-GUID: 1VIgejm_vXPrOjynI1zaR0BvYyxemP3D
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-11_02,2026-03-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 lowpriorityscore=0 spamscore=0 suspectscore=0 clxscore=1015
 bulkscore=0 impostorscore=0 priorityscore=1501 malwarescore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2602130000 definitions=main-2603110127
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Wed, 2026-03-11 at 14:57 +0000, Peter Maydell wrote:
> On Wed, 11 Mar 2026 at 14:36, Shivang Upadhyay
> <shivangu@linux.ibm.com> wrote:
> >=20
> > The '-machine dumpdtb' command line option stopped working on
> > PowerPC/pnv systems after recent design change [1].
> >=20
> > Fixing this by generating fdt blob in `pnv_init`.
> >=20
> > [1]
> > https://lore.kernel.org/qemu-devel/20250206151214.2947842-1-peter.mayde=
ll@linaro.org/
> >=20
> > Cc: Aditya Gupta <adityag@linux.ibm.com>
> > Cc: Harsh Prateek Bora <harshpb@linux.ibm.com>
> > Cc: Peter Maydell <peter.maydell@linaro.org>
> > Cc: BALATON Zoltan <balaton@eik.bme.hu>
> > Cc: qemu-stable@nongnu.org
> > Fixes: 8fd2518ef2f8d34 ("hw: Centralize handling of -machine
> > dumpdtb option")
> > Signed-off-by: Shivang Upadhyay <shivangu@linux.ibm.com>
> >=20
> > ---
>=20
> Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

Thanks.

~shivang.

