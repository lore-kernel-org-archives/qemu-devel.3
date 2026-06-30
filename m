Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 22D0BC43327
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:18:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wed2A-0000Na-FB; Tue, 30 Jun 2026 14:18:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wed28-0000NM-53; Tue, 30 Jun 2026 14:18:08 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wed26-0006nd-I8; Tue, 30 Jun 2026 14:18:07 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIFCl2288459; Tue, 30 Jun 2026 18:17:59 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=uqKMWx
 kDSpVtLRT2Q2AxHSoiyBO6kT8HdU2l+MtRkIM=; b=FHdhajkt4WGaR8CRu9BHGB
 lij7kPiPl7cYxk5fGFcvEoz6gJ17P3L8fNUOdJDV6DqmxvUtELDohjGbLi+aBOHH
 WAL8YIGAZjc9d3vYq52UafgWaEJXNML59L4YtJilvnpYO+GxN1hi2MxR2pWGOoeE
 kM5ZaR+xMdOnXOlBVBcPcTDkzFeoZ6/roPjF5qq/GiIntG80KkT37LYhXUovJYpe
 b4VppWpFPjoB9x/sPGQVkSbSvFURThCmTaIXJJOyiQOLxlfSmoXCbFmr2hTlJqUm
 z3XtAiNYRz0rdfpeptIiUwDnQB6vX1sXdssm1Mr8Z8mbg5taqLeD+Oj9ihro7M1A
 ==
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26pe0fxw-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:17:59 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UI4aDi020382;
 Tue, 30 Jun 2026 18:17:57 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f2u2gbgp4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:17:57 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UIHsmM62259464
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 18:17:54 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 1638520043;
 Tue, 30 Jun 2026 18:17:54 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 72B8120040;
 Tue, 30 Jun 2026 18:17:49 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.22.48])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 18:17:49 +0000 (GMT)
Message-ID: <470cc3fdd99cfb62b41ed0238550a2b4f4fc4929.camel@linux.ibm.com>
Subject: Re: [RFC PATCH 1/2] accel/tcg: use GTree for faster breakpoint lookups
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 pbarbuda@microsoft.com, mohamed@unpredictable.fr
Cc: pbonzini@redhat.com, philmd@mailo.com, zhao1.liu@intel.com,
 laurent@vivier.eu, deller@gmx.de, pierrick.bouvier@oss.qualcomm.com,
 palmer@dabbelt.com, alistair.francis@wdc.com, liwei1518@gmail.com,
 daniel.barboza@oss.qualcomm.com, zhiwei_liu@linux.alibaba.com,
 chao.liu.zevorn@gmail.com, qemu-riscv@nongnu.org, rathc@linux.ibm.com,
 harshpb@linux.ibm.com, adityag@linux.ibm.com
Date: Tue, 30 Jun 2026 23:47:48 +0530
In-Reply-To: <187d9a11-b1d0-44fa-bf91-43b723063a44@linaro.org>
References: <20260630171555.114844-1-shivangu@linux.ibm.com>
 <20260630171555.114844-2-shivangu@linux.ibm.com>
 <187d9a11-b1d0-44fa-bf91-43b723063a44@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 7BteIhalfyh8xvRIlcrWAxVA6kp_UpE-
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfXwDWsvq2ZezEm
 lTwB3lD2xflJVs2DnGDFrhOJqJsl/sa6nEyvsapKtpWsVWhb3gz94cazklNv4+neGhIDM0DO4bw
 tv7WXeQ53w6UUUkeRRO8sZ9rTT+9E14=
X-Authority-Analysis: v=2.4 cv=edsNubEH c=1 sm=1 tr=0 ts=6a440857 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=jfeNv2Vnnl0YCIFMb-4A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX4XvYe1Zqok0+
 KSlDzafyLEQ6D/wA1RCzlvJjZziB2W+Cl5utJoCySndZWtTR7T6X66QQMB6jhwaQnWIGMcoB2Qf
 A1T7CTYwZTqtmf3WODJ17vkawGJU9sgC6eXB0HVaTZzub/FgnT4uPCvgBkYqT9/ZFNyLj3aA/z7
 Ef8suEWc0Pu6CBoScKpr/rX6GC5cBgyXh6I5xNUFRvREQAHCVX9o0xFxwWTXevjmLedtWrVcFZG
 2lhIQ1XwFGsEhYCYMaOS+xgKviTDSjsNhHsthOecPUg4epmPk3cIof62swqp5qArVW7C+FISD1k
 pm5QLWXQRh8rc2vNjJe36lWNspzxYHZN3neut+S+K8f1yP5mlXkeGiU1zyPS0JXDyko/2IoilpN
 WpPQXEn5xmXTh5k9PeMnjlA/t0cGjT6N7xJL1oFPkuaEOHwLOiDpIbnkvZYGtaHlLdYrz6l7HUi
 VTpe2oQ7mCldbAlQoqA==
X-Proofpoint-ORIG-GUID: kMilMdYcRn9luEhTw3qCwKoh9C9yVFXo
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 malwarescore=0 adultscore=0 impostorscore=0 bulkscore=0
 spamscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300170
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=shivangu@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On Tue, 2026-06-30 at 10:31 -0700, Richard Henderson wrote:
> > =C2=A0=C2=A0 6 files changed, 118 insertions(+), 45 deletions(-)
>=20
> I think it would be better to use IntervalTree, so that we don't have
> to keep that second=20
> tree of pages.=C2=A0 Obviously, IntervalTree can query an interval, which
> takes care of=20
> querying for entries within a page.
>=20
>=20
> r~

As per my initial understanding of Interval trees, The primary goal of
them would be store intervals, and then query with point/intervals. But
current usecase is storing points and querring with intervals? maybe i
can be wrong with this idea.

Maybe i can just use cpu->breakpoint tree to find out page match, with
using lower_bound on the `pc & TARGET_PAGE_MASK` and find if the bp->pc
< (pc & TARGET_PAGE_MASK + PAGESIZE)?=20

~Shivang.

