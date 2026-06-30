Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018B4C43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 18:02:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wecmS-0005Iv-R5; Tue, 30 Jun 2026 14:01:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wecmL-0005Hy-Oy; Tue, 30 Jun 2026 14:01:52 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1wecmK-0002Dp-CR; Tue, 30 Jun 2026 14:01:49 -0400
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEJ1I12172253; Tue, 30 Jun 2026 18:01:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=0YnN8u
 1p3qoq9Y+gxa+D7gDVaDKGHMCtCkBlAjRc4ls=; b=o7xqQaeN5GGRXFrVxMesLJ
 jcxn7quMnMkOUzD8bStkiUjLMSk3OCzJv3P8D1IDPu0Ph46EsJbXqbDzYhs9I7i3
 cjoLFocmyTlUqXuHq0iuOPqWG4uGx4B/p0ywgO72kTuCK+Ysq7baaS0oT39s4M87
 +VRiBNcxJpvTeyLPFdpN54iVsYJ0x6JKxvc8YzTrdZnUWBhCL2NhecuxjJq22qAQ
 0wH6G+v7yudvGbCLKHwfSxNp2kswEjbcHfsejlxLNNdT2glnIKJUDm9iQIUT5lwn
 weCAfR11x6pqvXjooUPEOPB4efttlzf1YKuqnUDi5JQYmM1dbPuHvc/OZS+hBw+A
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qa03y6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:01:36 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UHnmpV013093;
 Tue, 30 Jun 2026 18:01:35 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhbh0r-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 18:01:35 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com
 [10.20.54.104])
 by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UI1VZl23724532
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 18:01:31 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 333662004B;
 Tue, 30 Jun 2026 18:01:31 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 9373320040;
 Tue, 30 Jun 2026 18:01:26 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.22.48])
 by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 18:01:26 +0000 (GMT)
Message-ID: <c20ec34b5d5546fa174a6a54309b01cd3c283062.camel@linux.ibm.com>
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
Date: Tue, 30 Jun 2026 23:31:25 +0530
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
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX8SMhxQ/nXgOq
 qAn7KqYHo3hRIX34Rank1Q3ZuU5aInnEItfLkVQLj+xZC6fhtTu+4JdW4mWuYD1H/VJD5MVJbM1
 YvSmyqyBqUIb/JPuqoPHUC8SrBDLQ7Mn3hllDoNI2sY//d+U9uS1vxWm24xR3kPUcWL9rYVVLAl
 8j2RxcFneDvt20rF0+ATfPeAR74ySY49GlkQddt9fLHXXGHXLMGlcpdwlKL1MKESgjALavPblQs
 FmTD/mKWfYxVIG4pDOwFFSv4illcnioqZLcD77mR8E1n82jegMIMfUQJ1ooEOHIzZ94JxV14ON8
 oJdg8H9yu4yeU0uiWxjTSJDw7Bm0/4gKGz+3Exo1u5vyBjk1jtHXnjQWN6qnr7cjzY1eqdsc9GS
 AFVP95kAA5pBWDNNnyS+ikrebMxlDf9kLa1/Z7eMtGSK/DDPKLe4TXNQesFZQuZ8iYYBTjsjKw8
 TX97iSg6mLbpSGkxBCg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDE3MCBTYWx0ZWRfX88fRh/DXkJxO
 67s6kJ0/pwiW3wRq9Lp1iseJUQ9PJf8suMGcP6/2J4gb3tBfjCAhPUxzbskvaoNVBJUvkgZLPAe
 EDckfxaKI9LXaVwt5yaozh4pPJCN93Y=
X-Proofpoint-GUID: xiqbCyAA9QqI3PBfCdflhy7b-l7iNEu5
X-Proofpoint-ORIG-GUID: LM52eAl8aLWzzompMIx65iliBUxCSw4F
X-Authority-Analysis: v=2.4 cv=WZ88rUhX c=1 sm=1 tr=0 ts=6a440480 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SAecnqFXDQIbCjAi4w0A:9
 a=QEXdDO2ut3YA:10
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 adultscore=0 phishscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 priorityscore=1501 lowpriorityscore=0 suspectscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2606300170
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

On Tue, 2026-06-30 at 10:31 -0700, Richard Henderson wrote:
>=20
> I think it would be better to use IntervalTree, so that we don't have
> to keep that second=20
> tree of pages.=C2=A0 Obviously, IntervalTree can query an interval, which
> takes care of=20
> querying for entries within a page.
>=20
I will read about InteralTrees.
Thanks for the suggestion.
>=20
> r~

~Shivang

