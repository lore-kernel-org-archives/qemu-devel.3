Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59852C98314
	for <qemu-devel@archiver.kernel.org>; Thu, 24 Sep 2026 13:18:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x9jLK-0001Cx-0s; Thu, 24 Sep 2026 09:18:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9jLF-0001Aj-07; Thu, 24 Sep 2026 09:18:25 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1x9jLC-0003te-TT; Thu, 24 Sep 2026 09:18:24 -0400
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OC68wr2221127; Thu, 24 Sep 2026 13:18:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=FuMcox
 NgBqJ4PhHpEtTppPhvo2E3JjnKuShe1ptx/MU=; b=gWoLPNVK7n8tc9aAFIehhy
 8pePQMTDQRzAS8FD3edyDWYAFDPb/2gzNqnfyK947zmnCzYPKYBSo6Ergnd+bGFc
 5hG2gZHRjdA2E64JOA/zm0rGjlKMozkVzjzNw2rulPIFJzy4xSebMYR60iPOmLvO
 dCZyepVEJFA6vIWuksbwnHBPL0pqxmRUqj9slGiLwRHyg4BFZ8OpiAWm+oMMZcRi
 Rc4EuOybzEzMVHU6wgN7KYHKdkvOX0g+mzmm9mZtgsU4BxITTz8/vbjDiJ9H7uom
 slnnzen9k9bVuC/Qzi/l3V69Ga+um7ZD2dzXHRUcC9K/1PKhMeS64qDappb8SHdg
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gskdvgjrg-1
 (version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:18:20 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id
 68OCHnGh2047307; Thu, 24 Sep 2026 13:18:19 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gvbe1x081-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 13:18:19 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com
 [10.20.54.106])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 68ODIFpc46006642
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 24 Sep 2026 13:18:15 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5A0D920043;
 Thu, 24 Sep 2026 13:18:15 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E7F6720040;
 Thu, 24 Sep 2026 13:18:11 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.19.125])
 by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Thu, 24 Sep 2026 13:18:11 +0000 (GMT)
Message-ID: <3f6eab78009d96f7eca3e3e8657c8b804dcd3714.camel@linux.ibm.com>
Subject: Re: [PATCH] target/ppc: Stop vCPU thread before calling
 parent_unrealize
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, sourabhjain@linux.ibm.com,
 rathc@linux.ibm.com, npiggin@gmail.com, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com,
 richard.henderson@linaro.org, sshegde@linux.ibm.com,
 srikar@linux.ibm.com, amachhiw@linux.ibm.com
Date: Thu, 24 Sep 2026 18:48:10 +0530
In-Reply-To: <arTpfPWGBLa2YlXF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260923121444.154175-1-shivangu@linux.ibm.com>
 <arTpfPWGBLa2YlXF@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: jjkcg8b4n0yBqrS5Q2RkodCFwlpPnr6K
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfXzYGRt+uv9diN
 mOt0KVi0cXCjrjGl3izBWQA2/DFxfbfnXw/YvM7TfvWEE3m1C/ed7EmdqtRkei/2V1wVHkflctV
 YD4PYZJPEgoxouuU7/hmrstRAZTNx4c=
X-Authority-Analysis: v=2.4 cv=FLiOVOos c=1 sm=1 tr=0 ts=6ab5231c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=RzCfie-kr_QcCd8fBx8p:22 a=pGLkceISAAAA:8
 a=SY9DgSKdxip53Jy9IuwA:9 a=QEXdDO2ut3YA:10 a=jbrNdEKIzwoA:10
X-Proofpoint-GUID: pvapHIYI-jfMK9Exsagj4SFxj9k9OtqX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDA1NCBTYWx0ZWRfX+bq2Hym4hWa1
 pi4unjA9PYVJ16Lsr1RoHUUoyMsVmHIowWvB6r5rAjyLOnybVa4DEbSM1QGD+jF5+LnnWEljfdi
 3vD6HMouvFSwcVMYKGWroXakEzFUiu9YVnlwvF4WXzzyQi3m7hr+/UVqZMBx6w1yYxfyRqJyFEX
 Bq9aml5ZZ1MSf0UgiapMMkH6julA+ObvaYIb/98WLukG3kUtYgtTgwGgAJ7Y0SZJWFor8JTIEFy
 rQlY31VKyk3TpIyl6IOCvLwhTdCJ432RHWNWUcdfR0vY9aELZly8y3Wz4L7xUCWso01/ZVCwoXA
 iXpzZ/TK6UDATTiJePnhk+oPOwNFgOJmpTmR0l/k2puenU9OXrqnnd4p8v6UZQBtUpMcU/8ScuB
 rXDZsrGDPPf14shMzUukgfD/T0YDoP+Wim0ol8w1BTaDzp7vAYwdNSsok3bTac+KOSpu2F7+azQ
 zF3XyWsEu+OakAQMjSg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-24_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 phishscore=0 spamscore=0 clxscore=1015
 suspectscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609240054
Received-SPF: pass client-ip=148.163.158.5;
 envelope-from=shivangu@linux.ibm.com; helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
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

On Thu, 2026-09-24 at 14:42 +0530, Mukesh Kumar Chaurasiya wrote:
> Makes Sense.
>=20
> Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Thanks for your review Mukesh :)

~Shivang.

