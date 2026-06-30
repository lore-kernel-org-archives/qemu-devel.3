Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5844C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:03:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wecnS-0005tf-W6; Tue, 30 Jun 2026 14:02:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wecnR-0005tN-Lg; Tue, 30 Jun 2026 14:02:57 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wecnQ-0002UE-46; Tue, 30 Jun 2026 14:02:57 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEImd62171336; Tue, 30 Jun 2026 18:02:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=d8qBvz
 Z53NR1lsgbfGaSGiWg5a8D5RzciJLz1jQcXjk=; b=WxNbZGOpnpWCZ0qJYnuiqn
 +F7I8BA/U9hxJ6ruzwLOQdSkpoytf1cTbDSg6xRXlnDGcNHA+LE7yuae2aIHk7WP
 HhsaVEFXwubBb5vUMbmvBy37RiIdMZ6L5syezyjckiCTboDu6cSm29J8VlyefSbk
 JcXaQ+O2YECo30t3G0TWo+zfzvB5LKasY6I3mAOj9dC/INUGGT3WoEyc+wgkLtia
 E3ivznb6cimrYBRVuYVbEeexO8ZAJsWhYf5GkTSG4nksH/qIHOYx12laIn+liE/e
 pLxmqadactWPzLuU6i0S9BVs9u5uJ+KwNoD+6oTLqULM3C8m7+BscvfIiW+WOZUQ
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26rf02bx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:02:29 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UHndDF012176;
 Tue, 30 Jun 2026 18:02:28 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhbh76-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:02:28 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UI2O4O42205506
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 18:02:24 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 303142004B;
 Tue, 30 Jun 2026 18:02:24 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 315D620040;
 Tue, 30 Jun 2026 18:02:19 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.22.48])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 18:02:18 +0000 (GMT)
Message-ID: <36e264cd2a26d04716a54fc95faa7abf9a925916.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 2/2] riscv/debug: migrate debug_check_breakpoint to
 use GTree breakpoints
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
In-Reply-To: <7a1ac883-82d0-441a-817f-440875f71afe@linaro.org>
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
 <20260630171555.114844-3-shivangu@linux.ibm.com>
 <7a1ac883-82d0-441a-817f-440875f71afe@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
Date: Tue, 30 Jun 2026 23:23:38 +0530
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=a4kAM0SF c=1 sm=1 tr=0 ts=6a4404b5 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=V8glGbnc2Ofi9Qvn3v5h:22 a=ZpYWSNbrAvm0fTdKT3EA:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: iU6oT997aqP50Pas22LqWpLeZHc6s3lN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX+dgcBapPooF1
 1ceT7VD6k4eGHM+08IZ9BJdXhDVmrBAz9GzBy03kB2c87Hsv8Mhoo01Y8LE0nxHY5MCK3T0S0Qm
 97OSCTfdJSZAeV7IIK9DHYdaxX/OPAIlvROcMSrzCzKDlmYdotBC2jaWSVqSYaL4QaBhQUZ//Rc
 t1O9B4DMiAPMN6Pr8D1Tjc8GME8PsFdmkW0LlGcGOpPARSPU+QBwRyOecn4aEqpsOeZxAu/ZFPe
 AldHQcr6DJRDpd5TJLNnrnBFpe4/6NT9+wVthsvMeWWf3HkhnGfdLd3N9+Jx/t3pd1XZ5atxuj1
 zKjvh2rHJ8D9uAz2ot1W7LpAKXAj0xDF6U+OvwABCJs/CB1naL/GeHEUZBp2rlmgdF8FlO0vCOw
 uOcQmWrHnwY9w7ycnZvn3WV+8HRJfeq6x9R51Q7b1Ac9voufgsxPmCeVT1GBiqnBQ5dmtwFyoCE
 cbQsY5RBC/l4xKGZZxg==
X-Proofpoint-GUID: UM3FZ4KkAYeCqmUTJ_KkESOFvBy732UF
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX3AJPWvS1acnh
 azTdnr7/zTvJTc4LNOtC1jIZrEDCEDBXMIOOlkeP/GzlDZDa2jIBF1GnDBDWQQcT8Jdk1w12L4B
 vjd99hwoJ3WDNKh7PZuvAs0mpYikXos=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 lowpriorityscore=0 impostorscore=0
 spamscore=0 priorityscore=1501 adultscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300170
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

On Tue, 2026-06-30 at 10:33 -0700, Richard Henderson wrote:
> (1) This can't be a separate patch, because the first patch can't
> compile

Sure, Ill fix that. Its just that found this riscv case, only in all
archs build, so it put it saperatly. ill squash it with main patch.

> (2) You can't use a global variable for bp_found.
>=20

I could'nt find any looping mechanism in GTree. I think there is only
g_tree_foreach. Maybe i can pass it as `user_data`.

>=20
> r~

Regards
~Shivang.

