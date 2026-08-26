Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1299CC5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 13:17:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzDVO-00064k-HG; Wed, 26 Aug 2026 09:17:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzDVM-00064Q-HS; Wed, 26 Aug 2026 09:17:24 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <amachhiw@linux.ibm.com>)
 id 1wzDVK-00024V-De; Wed, 26 Aug 2026 09:17:24 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67QCWE4r3978199; Wed, 26 Aug 2026 13:17:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=F/nGq2
 fkRpBII/TlbzOm15LI/rrjFpxpZcTOVF3EhMo=; b=e/1Z8LayEvDQ3aurRrQ/tq
 uRHpXAs271EVbl9MMB+gTLMsbnCP12j13x+zIpn97Djb/9vi3dcZxB6pwvFbfbLF
 8Ju1fibwhXTJ/7qyXNxrc2GrW851c408NcqZNGKjgupVY+jWpT6jo2Zn/VEvSUEr
 fJg7MTdpkDgQnma74VN8gl9FokjuRuI7wNr9kFNy8R3nWGoCOLc2Bne1bx7P15SD
 awkFc0x8iuvD1RwoqcYwBKMrv6ts624xKW0ZzJwi418uorL5yh8EsIehUk0bBOBD
 WUir8QkMrnvr3VwmrD1DxIFuPwihduYSPxcGPJKmo9jZWCu0TQ6mbO0MSjTnECzg
 ==
Received: from ppma21.wdc07v.mail.ibm.com
 (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g73946u2f-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 13:17:18 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67QDBGmO010032;
 Wed, 26 Aug 2026 13:17:17 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4g7q3k23ej-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 26 Aug 2026 13:17:17 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 67QDHDR646661910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 26 Aug 2026 13:17:13 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5489520043;
 Wed, 26 Aug 2026 13:17:13 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 779D920040;
 Wed, 26 Aug 2026 13:17:11 +0000 (GMT)
Received: from fedora (unknown [9.5.7.39])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Wed, 26 Aug 2026 13:17:11 +0000 (GMT)
Date: Wed, 26 Aug 2026 18:47:14 +0530
From: Amit Machhiwal <amachhiw@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, npiggin@gmail.com, richard.henderson@linaro.org,
 nikhilks@linux.ibm.com, Amit Machhiwal <amachhiw@linux.ibm.com>
Subject: Re: [PATCH v2 03/37] target/ppc: Convert cache instructions to
 decodetree
Message-ID: <20260826184321.64dbc67f-23-amachhiw@linux.ibm.com>
Mail-Followup-To: Chinmay Rath <rathc@linux.ibm.com>, 
 qemu-devel@nongnu.org, qemu-ppc@nongnu.org, harshpb@linux.ibm.com,
 milesg@linux.ibm.com, 
 npiggin@gmail.com, richard.henderson@linaro.org, nikhilks@linux.ibm.com
References: <20260826050923.74756-1-rathc@linux.ibm.com>
 <20260826050923.74756-4-rathc@linux.ibm.com>
 <20260826153132.6c0e83d2-05-amachhiw@linux.ibm.com>
 <b919f52c-f8ac-4a28-a9cd-f776bb498281@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <b919f52c-f8ac-4a28-a9cd-f776bb498281@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: e-vHfRKXJmpsOwmq0jlMrF8Ib2qMsoLB
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX3QJBtQ+1Yy6s
 TeRF+PX3bayD9tWmTH2ipdeeZaxeQMXu5Iy9p1xsh61CQCqSLEy1c/i34+b2HrerOkBkA+RrUx8
 s9GDgR/K+KJL0/SgH9ZcYLL+qBWDw/QAEOWcfFEIBTMWekOoSKVjSs2kH8E+WDgjSJU9SNKr7Pz
 rnMd/nPHuZc6v6KU8anqNC/mwoaH7iEckiJU+KVqbgKkJw3MMJevUW0VPnjyIjlJkSTcIm8Fze2
 O/7jt/47L4fMBPiHLhyIw9Cd/physP+RDeI7nLdQ6InJG3hiawGiDFL4CBJmDdWM9y1WmuE0rq1
 wS13t+wZmaQlCfX5K4Rb69aZpp/RFQm9/iYC+iirtN7ccBnSjbf7J5ti+lZQ7O6v18BooJw7uoS
 UFm4Xy6uhElIHlGCNQd47LxeQ5/poybpgTxqmBGBMWZoodpNZJs1xoQDQrTia6vg/o9gISXeuDG
 AXpUU+m9dcocQVTXsDA==
X-Authority-Analysis: v=2.4 cv=Y/nIdBeN c=1 sm=1 tr=0 ts=6a8ee75f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8
 a=hBl9zLAC4UxrTPpw9pcA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwODI2MDEwOCBTYWx0ZWRfX1277H9Zd1wUo
 OPzCaR21323Xm8ptzgQGw6QD8Uf0zpPIqOpqmy7HYzEeiTro+Upz3Z1ecRz0njxeUWC6LuvWoFl
 r4RotUyT+noVSHkWntDlQbR+04Trn1s=
X-Proofpoint-ORIG-GUID: 9WXTD8FNH4gA15L-U2hzGwlixCPWlU6O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-26_03,2026-08-26_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 priorityscore=1501 adultscore=0 bulkscore=0
 suspectscore=0 malwarescore=0 clxscore=1015 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608260108
Received-SPF: pass client-ip=148.163.156.1;
 envelope-from=amachhiw@linux.ibm.com; helo=mx0a-001b2d01.pphosted.com
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

On 2026/08/26 06:39 PM, Chinmay Rath wrote:
> 
> On 8/26/26 15:50, Amit Machhiwal wrote:
> > On 2026/08/26 10:38 AM, Chinmay Rath wrote:
> > > From: Nikhil Kumar Singh <nikhilks@linux.ibm.com>
> > > 

<snip>

> > > +
> > > +DST             011111 ----- ..... ..... 0101010110 -   @X_ea
> > > +DSTST           011111 ----- ..... ..... 0101110110 -   @X_ea
> > Per **PowerISA v3.1 §4.3.2.1**, dst, dstst, and dss are obsolete and
> > must be treated as no-ops independent of whether Vector instructions are
> > available. The new REQUIRE_INSNS_FLAGS(ctx, ALTIVEC) guard in all three
> > handlers is incorrect — it causes these opcodes to be treated as illegal
> > instructions on non-Altivec CPUs, contradicting the ISA mandate. These
> > handlers should unconditionally return true with no flag check, matching
> > the ISA's "always a no-op" requirement. The ra == 0 INVAL check in
> > trans_DST and trans_DSTST should also be dropped for the same reason —
> > if the instruction is a no-op, the operand constraint has no effect.
> Thanks Amit !
> This is very informative. There are many such instances in QEMU code where
> insns haven't been updated as per the newer ISA.
> Though, I'd like to point out that the REQUIRE_INSNS_FLAGS(ctx, ALTIVEC)
> guard in those insns is not new. This was already present as in the code, I
> will mark it with [A] below for reference.
> This patch simply intends to move the insn to decodetree keeping the
> existing logic intact. The translation logic and flag checks remain same for
> these 3 pointed out insns. I'd like to take up your suggestion here and post
> a folllow-up patch to update those insns as per the new ISA. Would that be
> okay ? Or would you prefer the insn's correction as per the ISA in this same
> decodetree movement patch ?

I did notice that this check already existed before this movement and I
don't see it as a blocker for this series. It would make sense to fix
such places in follow up patches.

~Amit

