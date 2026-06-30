Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51B7BC43458
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jun 2026 15:18:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weaDs-0005xY-2f; Tue, 30 Jun 2026 11:18:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weaDq-0005x2-11; Tue, 30 Jun 2026 11:18:02 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shivangu@linux.ibm.com>)
 id 1weaDn-0000tw-0R; Tue, 30 Jun 2026 11:18:01 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 65UEIKJS2428612; Tue, 30 Jun 2026 15:17:57 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=db7ZgF
 e9TDq+Z8zJDr+K9KY2PiGFoiasvPoLMejQO/o=; b=Z1jFROu5GZ6AItQAEvDlTo
 UZdfKY2gVVpTbE/gKNlztbKGHX9JC1Avl13sVdbRm1cL3FvWLPMerm2BalySzKlq
 BlznKJQd7cNvm/iP8PddhCaKXfmuT8Fz34ODjXt8svw+GtVorTaQzJ6Dmxg43Irz
 rj70fkW+YQm6T10D5b6SDqHeO9mnFuk5Xbk0cW2n0jOVFVOtk/ZHdvyov+GF8Y+M
 IOjR7jhhEJxR1INW9Go323wLDBojyWiyErfHgsv1SFytm1QsQUGUBEacFiqljHBL
 ug7MBPNzY2pCXtPL2pi8evN2NQmihNlmR98dmVi74G4085lCMVn06Wb8YEMDBB0Q
 ==
Received: from ppma23.wdc07v.mail.ibm.com
 (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f26qfygm5-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 15:17:56 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
 by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65UF4cLb018433;
 Tue, 30 Jun 2026 15:17:55 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
 by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f2tbhat96-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 30 Jun 2026 15:17:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 65UFHprR50004398
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 30 Jun 2026 15:17:51 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 77A3220040;
 Tue, 30 Jun 2026 15:17:51 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E62B82004B;
 Tue, 30 Jun 2026 15:17:49 +0000 (GMT)
Received: from shivang.upadyay (unknown [9.39.22.216])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue, 30 Jun 2026 15:17:49 +0000 (GMT)
Message-ID: <e4808991c1a6e324a3461fbcff199bd9fe14768b.camel@linux.ibm.com>
Subject: Re: [RFC PATCH v2] target/ppc: Convert cache instructions to
 decodetree
From: Shivang Upadhyay <shivangu@linux.ibm.com>
To: Nikhil Kumar Singh <nikhilks@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: rathc@linux.ibm.com
Date: Tue, 30 Jun 2026 20:47:43 +0530
In-Reply-To: <20260630144210.148159-1-nikhilks@linux.ibm.com>
References: <20260520160728.2283628-4-rathc@linux.ibm.com>
 <20260630144210.148159-1-nikhilks@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.3 (3.58.3-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=RYqgzVtv c=1 sm=1 tr=0 ts=6a43de24 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=IkcTkHD0fZMA:10 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=syXIhHOfpIr89EnvoDAA:9 a=QEXdDO2ut3YA:10
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfX4a7U0SMVRPEr
 yMACc3ZjR0Q9olE2gVnCO1M9OaiYRG3V/jFBWtPvI9YtajbP2mARtXyPQJN168MJO5ZVgl2FeDN
 KrS9PJh/qfw1QCJVscC4nSzjSgLxYA8=
X-Proofpoint-GUID: KxAErtoMaAf-ysE-_JXRWW1aFHkkIBoP
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjMwMDEzOSBTYWx0ZWRfXxQWC09sBgn54
 gHedXWg/FIASQ5QjqBKD8nbNLh7dLsJpaXvsrGAmEewytkpNmXFtvJRYUDhIb6aqCd7pS4OOfMv
 avEiNlhxU2OpoHUL2sNCuXRGHbwpGls4d4f4WhPfbNEHpf/INRG8EaGe8P02pqrtcaRCPi3Ppda
 ZxOpPEzvMNNN2cu29TfMpJkByl1MHJK5jxY5o+GwDUUL8QTmPLaOWXQlNw1nzf0liLNLmrRSQmc
 7D9mX+K2BGrLMt4OI8zg3IDn0lrx38F6G3XP73KaDRrfm0b6iXUPzqb8knYALhbPulcp5IwaHmI
 XxH4rxMg/j14Jg6G0Tlc2SMDrDjeqWIM5LgH2UEAe00Ki9p234vUCPwCRDh/4JXWAaxPVF8XmC3
 3M1MYjjZ/rLg5qFKEOMNgdDuN0naIdM3N3G23uYHxex9vV9DnK2D8Y9DZizerBSTxeGoRYeA6Du
 DhufIVIE4BJVls3RWwA==
X-Proofpoint-ORIG-GUID: KxAErtoMaAf-ysE-_JXRWW1aFHkkIBoP
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-30_04,2026-06-26_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 impostorscore=0 malwarescore=0 spamscore=0 lowpriorityscore=0
 adultscore=0 priorityscore=1501 suspectscore=0 bulkscore=0 clxscore=1015
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2606300139
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

On Tue, 2026-06-30 at 20:12 +0530, Nikhil Kumar Singh wrote:
> +=C2=A0=C2=A0=C2=A0 REQUIRE_INSNS_FLAGS(ctx, CACHE);
> +
> +=C2=A0=C2=A0=C2=A0 /*
> +=C2=A0=C2=A0=C2=A0=C2=A0 * As per PowerISA v3.1, the L field (mapped to =
a->rt in X-form)
> +=C2=A0=C2=A0=C2=A0=C2=A0 * can have values 0, 1, 3, 4, or 6. Other value=
s are Undefined
> Behavior (UB).
> +=C2=A0=C2=A0=C2=A0=C2=A0 */
> +=C2=A0=C2=A0=C2=A0 switch (a->rt) {
> +=C2=A0=C2=A0=C2=A0 case 0: /* dcbf */
> +=C2=A0=C2=A0=C2=A0 case 1: /* dcbfl */
> +=C2=A0=C2=A0=C2=A0 case 3: /* dcbflp */
> +=C2=A0=C2=A0=C2=A0 case 4: /* dcbfps */
> +=C2=A0=C2=A0=C2=A0 case 6: /* dcbstps */
Thanks for this addition Nikhil.

Reviewed-by: Shivang Upadhyay <shivangu@linux.ibm.com>

~Shivang.

