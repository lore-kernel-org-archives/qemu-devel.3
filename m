Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B058EC5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 15:25:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwLgI-00024I-Vs; Tue, 18 Aug 2026 11:24:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wwLgG-00023Y-LA; Tue, 18 Aug 2026 11:24:48 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <milesg@linux.ibm.com>)
 id 1wwLgE-0006xd-EB; Tue, 18 Aug 2026 11:24:48 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67IE3kMx2831485; Tue, 18 Aug 2026 15:24:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:reply-to:subject:to; s=pp1;
 bh=RqeLQtWEBKeWwEUkNHTZiytmiwSzfN6a+5UwbsFsFZ8=; b=UJwJAGpSTNcb
 4Rh4bcuNBsP5mDa8+zkW982gAW5Vy2Zfi+8lVdzDHAefiSbPAJW81RgNQVJiaJTk
 jwVnNocTTpTkoxDefJLHQC1A55l1vQiC88iN1KlsME5WGYZc7xajSyjvzibcGiKo
 lS/sC9ksUk8/z/U2iuiKp0aE6oT9PtIxfABuhozocFXgufSkZ4DiAo/C8n9KNH0F
 IVijdz8DavKaoyEkPx6thlhqexfQwBL6GCRy9ird+4fRI4g1zs/YA9KQvuyT6/jF
 TD/7aep3iJT4PaS+R3AtVDVPnYoPPf1YPeIFwinTcEDjiXil9s6UmOvObKv0qkE6
 VVqm0dT6Ng==
Received: from ppma22.wdc07v.mail.ibm.com
 (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqs35x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 15:24:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IFBJAq003006;
 Tue, 18 Aug 2026 15:24:40 GMT
Received: from smtprelay07.wdc07v.mail.ibm.com ([172.16.1.74])
 by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g32tw4130-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 18 Aug 2026 15:24:40 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (smtpav05.dal12v.mail.ibm.com
 [10.241.53.104])
 by smtprelay07.wdc07v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67IFOcID28574394
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 18 Aug 2026 15:24:39 GMT
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B171658052;
 Tue, 18 Aug 2026 15:24:38 +0000 (GMT)
Received: from smtpav05.dal12v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 3C4D258056;
 Tue, 18 Aug 2026 15:24:38 +0000 (GMT)
Received: from mambor8.rchland.ibm.com (unknown [9.10.239.198])
 by smtpav05.dal12v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 18 Aug 2026 15:24:38 +0000 (GMT)
Message-ID: <beddd6b3bfaf489909dc907d19931b6e3376bdf9.camel@linux.ibm.com>
Subject: Re: [PATCH 7/7] target/ppc: Add ICBT support for ISA version 2.07
From: Miles Glenn <milesg@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org, npiggin@gmail.com, harshpb@linux.ibm.com,
 tommusta@gmail.com
Cc: richard.henderson@linaro.org, shivangu@linux.ibm.com, tasmiya@linux.ibm.com
Date: Tue, 18 Aug 2026 10:24:37 -0500
In-Reply-To: <c51d7573-0555-4e66-84ec-c470ef176125@linux.ibm.com>
References: <20260715125634.2107320-1-rathc@linux.ibm.com>
 <20260715125634.2107320-8-rathc@linux.ibm.com>
 <4131f802840910b277f6e0a681ce7e51e8a9dddb.camel@linux.ibm.com>
 <c51d7573-0555-4e66-84ec-c470ef176125@linux.ibm.com>
Organization: IBM
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5 (3.28.5-27.el8_10) 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDExMCBTYWx0ZWRfX/O3w1ArDQJ0e
 zHbecdno/zx50X4XWdQUL6t2czH9V1ZMR4U4danovJ+wjhNe6MIGefTmBxcI4kXtumptAig6B7P
 xLixCU/Ke4puqe/xkNSDvZZ0qtLY8QCYIzTtHrcknNoDTZ3G4WZcVswQqhsp0og+17IiEu3f/cP
 Ci+FJ81NLJaGd62n/LXojGPWxFWjcE3DiqCzDNLF5+FF7kcoLZvCN64CBbVDD2+DdWztk560jsr
 hNYxTlPPFJmhZNs05VYw8fbgyFtjll1gBiuoScLEaEDTsUAs5P8DqQnoAPgvAQWpHHSXvLsP9cV
 WYhqMDSCYFdZ7FzIbjQuIPSj7ux1rAJMNlTNoLnIif6ZYnOsgcOuhkw3bb9V0TAZPV2iK4nR48F
 dWdycMR9t+DwP4Mf9TgQp1jKjth1du88fHD+7O5D3wU/a3iMiy+qWyJVjvwA96s59TsaxSFdN50
 wV1xeaOGIG2HtNqcO9Q==
X-Proofpoint-ORIG-GUID: CELu1WhUUy4KSPeUJFhZrxTtwZDGIjz7
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDExMCBTYWx0ZWRfX5qgymDava6Nc
 THlVpmhKIWlcL+QIfd+LJ9PVqetCha6hNFGta2SQ1WNk7gCVzljC7docKSuYs0mqsRwKKlUZc1J
 PfPmZgjGID2HRuuSN9itFmqRa53Haak=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a847939 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=qUNxuMBKM11VF0ggjTYA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: TO5L94GRGkJr56AUoHm4GfuT0Iiu2Smc
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180110
Received-SPF: pass client-ip=148.163.156.1; envelope-from=milesg@linux.ibm.com;
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
Reply-To: milesg@linux.ibm.com
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Reviewed-by: Glenn Miles <milesg@linux.ibm.com>

Thanks,

Glenn

On Tue, 2026-08-18 at 12:33 +0530, Chinmay Rath wrote:
> On 8/17/26 21:26, Miles Glenn wrote:
> > Seems like you are fixing a bug here.  Does this require a "Fixes" tag?
> Hi Glenn,
> 
> Thanks for reviewing the patches in the series !
> 
> I wouldn't consider this a bug since this particular patch does not fix 
> any wrong or missing behavior from a specific commit. The new 
> modifications to the ICBT instruction in the recent ISA versions were 
> simply not incorporated in the qemu code. So no previous commit is truly 
> at fault here.
> 
> Tasmiya had observed certain HTX workload being run in TCG env caused 
> illegal instruction error, due to ICBT not supported as expected in the 
> latest ISA; which brought this to our attention.
> 
> Regards,
> Chinmay
> > Thanks,
> > 
> > Glenn
> > 
> > On Wed, 2026-07-15 at 18:26 +0530, Chinmay Rath wrote:
> > > The summary of changes in Power ISA version 2.07B mentions :
> > > "ICBT instruction has been moved from the Embedded category
> > > to the Base category".
> > > Updating ICBT flag for the same.
> > > 
> > > While we are at it, correct the invalid mask as per the ISA as well.
> > > 
> > > Signed-off-by: Chinmay Rath <rathc@linux.ibm.com>
> > > ---
> > >   target/ppc/translate.c | 4 ++--
> > >   1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/target/ppc/translate.c b/target/ppc/translate.c
> > > index 8dab54ccee..3cd849c706 100644
> > > --- a/target/ppc/translate.c
> > > +++ b/target/ppc/translate.c
> > > @@ -4559,8 +4559,8 @@ GEN_HANDLER2_E(tlbilx_booke206, "tlbilx", 0x1F, 0x12, 0x00, 0x03800001,
> > >   GEN_HANDLER(wrtee, 0x1F, 0x03, 0x04, 0x000FFC01, PPC_WRTEE),
> > >   GEN_HANDLER(wrteei, 0x1F, 0x03, 0x05, 0x000E7C01, PPC_WRTEE),
> > >   GEN_HANDLER(dlmzb, 0x1F, 0x0E, 0x02, 0x00000000, PPC_440_SPEC),
> > > -GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x03E00001,
> > > -               PPC_BOOKE, PPC2_BOOKE206),
> > > +GEN_HANDLER2_E(icbt_440, "icbt", 0x1F, 0x16, 0x00, 0x02000001,
> > > +               PPC_BOOKE, (PPC2_BOOKE206 | PPC2_ISA207)),
> > >   GEN_HANDLER2(icbt_440, "icbt", 0x1F, 0x06, 0x08, 0x03E00001,
> > >                PPC_440_SPEC),
> > >   GEN_HANDLER(mfvscr, 0x04, 0x2, 0x18, 0x001ff800, PPC_ALTIVEC),


