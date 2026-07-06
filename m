Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E914DC43458
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Jul 2026 19:09:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wgogG-00029O-9Z; Mon, 06 Jul 2026 15:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wgogE-00028Q-FC; Mon, 06 Jul 2026 15:08:34 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alifm@linux.ibm.com>)
 id 1wgogC-0002ox-Hr; Mon, 06 Jul 2026 15:08:34 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 666FIFYQ611299; Mon, 6 Jul 2026 19:08:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=BYz2Zb
 KCUyw5mx2zyA0GaEA+7MqBZUw/VHB5LohFTms=; b=euOchtTcFDyHWAMNF+hFpY
 ILgs5neZhksy8YuE5zmirqaIQDlFJuqM1Idzka22v0Ys9qCxNm1HO/I/r/H6BMwT
 EIV1MGLzIRK31AHFHuhCX7Ylv96sfhTc1lkammoESAUe8bcV8dQt5czykxeulExf
 grEvMdEW0VvLctw37RphKcf2AW/FyRwZRD3sNp02l/JQ5UiwK/abAppL9aWEfN1p
 MANY0ie/wNixR89fvNBmMxd9ESFkOchxsrXqdMkL2FPkqOf+tDRe+1jNayDpnz7f
 bcn0njNhQoDBxMjxH76RuK8369U4vGAEzS5uvQkq/XPxCuGF13sZ5JkWOt/ctCRA
 ==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sp3k254-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 19:08:28 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666J4kMb024989;
 Mon, 6 Jul 2026 19:08:27 GMT
Received: from smtprelay03.dal12v.mail.ibm.com ([172.16.1.5])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvvy1sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 06 Jul 2026 19:08:27 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (smtpav02.dal12v.mail.ibm.com
 [10.241.53.101])
 by smtprelay03.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 666J8Qsk32899640
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 6 Jul 2026 19:08:26 GMT
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1D7DB5805A;
 Mon,  6 Jul 2026 19:08:26 +0000 (GMT)
Received: from smtpav02.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2F94458051;
 Mon,  6 Jul 2026 19:08:25 +0000 (GMT)
Received: from [9.61.247.63] (unknown [9.61.247.63])
 by smtpav02.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Mon,  6 Jul 2026 19:08:25 +0000 (GMT)
Message-ID: <2938d320-422e-43dc-b301-8bf9cebf1e75@linux.ibm.com>
Date: Mon, 6 Jul 2026 12:08:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/5] s390x/ioinst: Require strict length and format for
 SEI CHSC handler
To: Christian Borntraeger <borntraeger@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, qemu-s390x <qemu-s390x@nongnu.org>,
 Halil Pasic <pasic@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>, Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 David Hildenbrand <david@kernel.org>, qemu-stable@nongnu.org
References: <20260706091909.864405-1-borntraeger@linux.ibm.com>
 <20260706091909.864405-5-borntraeger@linux.ibm.com>
Content-Language: en-US
From: Farhan Ali <alifm@linux.ibm.com>
In-Reply-To: <20260706091909.864405-5-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=KsJ9H2WN c=1 sm=1 tr=0 ts=6a4bfd2c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=69wJf7TsAAAA:8 a=A6sDTTX4-35vUAUVURIA:9 a=QEXdDO2ut3YA:10
 a=Fg1AiH1G6rFz08G2ETeA:22
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE5MCBTYWx0ZWRfX0WJ+uH8vPvYf
 4AbCWQOPDDXORyMYeU6qK3bXz115t6+RthhzDyZ+L+NDQubSeN22P1a/N2y5kqoS0e2A0PAp87j
 wCpkP/NcjBCTfZk88Atks6Na3yL+MsA=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE5MCBTYWx0ZWRfX0GK4+0aFBZF3
 F2zql4BIL/h70Q7YC3BZuMviYeP86SytUV6IQ06Svk7++hS/5WMI7ywPawjx4SisIdM7BrBDg4D
 gxU6v4T1OzpSmboMvGm0iE3yhbwA62qmAjlPNO0XVDEOAjPacZg/ocl3Xdhrw/kcnjWSAcIaj5k
 Yf3ukswcj432zlw5BWhVyECKPqmwxTAuNxXmpKP1woe3QRx5lAyytk3aKaBDC5bSgciZIXYRyP6
 NcfQ9/BVDrBWP5VshwRZ/f07NH9XbtP9YIB/bCru8PTuOVJcSAROtYYgBMhjttsougu60BO3aql
 IGsoalOGacjIJByCiOCGeog4zyzHN4YD3W/bNFGnfpPax8r+TsSU0izIybs4trKv6nc6gkxtWq6
 EEIz6JTbmXChrpjnIs4mapCzX5y8eZNpT8Zf6R+iEzo33TVjagoMeRiMZ9ZzdSonnXixH6uEJo0
 r0IAsRy15w0TCy4rIoQ==
X-Proofpoint-ORIG-GUID: VX7i0hodm294oo5e9QHAeq_cpC3wEEjN
X-Proofpoint-GUID: VX7i0hodm294oo5e9QHAeq_cpC3wEEjN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_02,2026-07-06_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 malwarescore=0 spamscore=0 adultscore=0 clxscore=1015
 suspectscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060190
Received-SPF: pass client-ip=148.163.156.1; envelope-from=alifm@linux.ibm.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org


On 7/6/2026 2:19 AM, Christian Borntraeger wrote:
> From: Matthew Rosato<mjrosato@linux.ibm.com>
>
> Ensure SEI commands that are received are of the appropriate length and
> format before handling.
>
> Cc:qemu-stable@nongnu.org
> Fixes: 8cba80c3a0 ("s390: Add PCI bus support")
> Reviewed-by: Christian Borntraeger<borntraeger@linux.ibm.com>
> Signed-off-by: Matthew Rosato<mjrosato@linux.ibm.com>

Reviewed-by: Farhan Ali<alifm@linux.ibm.com>



