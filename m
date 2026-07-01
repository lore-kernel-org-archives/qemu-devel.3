Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D776BC43327
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Jul 2026 08:45:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weqZe-0001mp-Qw; Wed, 01 Jul 2026 04:45:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weqZa-0001lk-RV; Wed, 01 Jul 2026 04:45:36 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weqZY-00011E-Qw; Wed, 01 Jul 2026 04:45:34 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6618IjLQ236558; Wed, 1 Jul 2026 08:45:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=
 content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=IQSnUL
 xubPIV+FpUGTCILHoC53DEBk7df8J3eQkc3ak=; b=B9lPbx/Po72rR5vYGRmay5
 m6aYyVLW8lrjLmhcAB5DIFzd/qHyuDjkI3a1/I6b++F1B7fK2qIZ8Yb5yXeL4xt6
 eSFWrih6qsoz09M0J0gOV9QonWJ30mckp6j+lwjxUxB1YI1AMXRcy5B4b/9OcD3q
 gyMMFVHY/CDnR58RAUfOFRtDycpjGzrySJe4zhgfGjgfvcaLynvLkP58E5TddB40
 s8tbTP7LyUcrKa2DuJayRVY/mZKR1hT7Zki+YiUYRnTvB8nY+1sp0yAqRPVozD3S
 9XE2SGPWMJZOatQdDhqPDnRep+kNDJRIHUB43HamQzhB+21kPP0lJKHw9urs+ecw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa35xr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 08:45:30 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6618Ym9w017666;
 Wed, 1 Jul 2026 08:45:29 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2ruqen4h-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 01 Jul 2026 08:45:29 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com
 [10.20.54.105])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 6618jQat47382836
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 1 Jul 2026 08:45:26 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 160B02004B;
 Wed,  1 Jul 2026 08:45:26 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9B37D20040;
 Wed,  1 Jul 2026 08:45:24 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.123.12.247])
 by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed,  1 Jul 2026 08:45:24 +0000 (GMT)
Message-ID: <f197b0818d6734de7ca4b389315facb0d41130e9.camel@linux.ibm.com>
Subject: Re: [PATCH v3 1/2] ppc/pnv: avoid regenerating DTB if external DTB
 is present
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: adityag@linux.ibm.com, harshpb@linux.ibm.com, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, milesg@linux.ibm.com, npiggin@gmail.com
Date: Wed, 01 Jul 2026 14:15:23 +0530
In-Reply-To: <20260630172158.2d40c4a9-97-amachhiw@linux.ibm.com>
References: <20260630103508.254000-1-shivangu@linux.ibm.com>
 <20260630103508.254000-2-shivangu@linux.ibm.com>
 <20260630172158.2d40c4a9-97-amachhiw@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX/BnH9UjJZXYd
 X9bEKN8YcqDLeee2tx9+3+Aol9vbQHIAxr36SZD2II2QT75kv/IxD3/a+tg9rOmIzl3+/o8OdVN
 6WLY742/z+U+whH91HVNBH30xsgKljAt2+3TnGuOVzTbTwmoo+kA4kqKFuqk0IvfFG2NwNWE8RJ
 RBTlaLwcSlC+u1B5DEWAEgiiUAjHT8Yf7y/+pQm6tG3mVehkkrqYA3qVb1hv7lj3m9A227kEqAK
 3NISRI7tD5OuKr5re7cmz/jL2W0j/4XQ5hgG00eMgEwt3KySeuvjWPj6uZJi4lWyL1m8+cgvmm6
 GiHDA4euZbtZzyTY3ph9U/u1cKUjoj003q/HGKHilHTUJHxRDho13uj9EqWbovVAjdnBZwuYRh6
 UxOhba32iRmedyXHsd01YJHBp1oCbtJKjOZGn8yWsiY0R8YjntEIePCEyb3RdO9TJ7XF91YOMzB
 4g3TQDYLJ5AKDm1t2NQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzAxMDA4NCBTYWx0ZWRfX90xzU0ISwkyJ
 WbbNBucYvE4aXyxXObJDcsDsRmTiaccmOhm+bv2kr+PTJWua5MZQkb4n7LVBL/JmYWcijjKcg4e
 4Yui+K6jIfdhEgYt95BgediyBMBcwtI=
X-Proofpoint-GUID: rfx70XWA8dXxfzzhzBJ4ZdQA6cTm65gg
X-Proofpoint-ORIG-GUID: v9-Dl4vi3oSfFK1SQtHTLkj7iyuw2iAq
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a44d3aa cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8
 a=xEDVpvJxk-5VxwPUaT4A:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-07-01_02,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607010084
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

On Tue, 2026-06-30 at 17:23 +0530, Amit Machhiwal wrote:
> LGTM.
>=20
> Reviewed-by: Amit Machhiwal <amachhiw@linux.ibm.com>
>=20
> ~Amit
Thanks

~Shivang

