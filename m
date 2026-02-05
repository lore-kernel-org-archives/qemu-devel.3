Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB3BECD9AF
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Feb 2026 21:50:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vo7EN-0002w2-Sp; Thu, 05 Feb 2026 16:49:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo7EM-0002vH-EZ; Thu, 05 Feb 2026 16:49:42 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <farman@linux.ibm.com>)
 id 1vo7EK-00062p-O0; Thu, 05 Feb 2026 16:49:42 -0500
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 615Kc3cs016214;
 Thu, 5 Feb 2026 21:49:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=4gWLXv
 ZVK7/0QpaxDAeOKeJT1NrAdGe71Uv3bjRizuY=; b=eBfgKpDoxVv1HpecV+k9ee
 9zkyQ+4oBq9h9OAl1MuhnBJiXuQzELUmM8jFHsclTLBP2Wazr4kvxtQXv7jUGVFl
 o1nPQyCYnZW0Zx3GkJwOjyn89kJpefyIn43m+FYZZC/TEtuSgZu4WS5Q75wYwORj
 LVkJ36QfQm8LdWf/6V5ZBYA9ClWRfFcv2RvREOnSIdOXN1rSPKCSophi3nXr+45B
 /7DJZnyyjhoLRWfd0BdvGRel+1PYCLlUFZuBr5O2tge18voxA9lXq5Lr/BY49AU5
 FA3je3Tmx6Y/Mbm6LgW/pQdkIrQpqmrPGWIZo6khgzrdW1SW73EMrP9iZcHb7l2g
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4c19f6rywx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:49:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 615Jc4Zx029052;
 Thu, 5 Feb 2026 21:49:35 GMT
Received: from smtprelay06.dal12v.mail.ibm.com ([172.16.1.8])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4c1v2skpy6-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 05 Feb 2026 21:49:35 +0000
Received: from smtpav01.wdc07v.mail.ibm.com (smtpav01.wdc07v.mail.ibm.com
 [10.39.53.228])
 by smtprelay06.dal12v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 615LnX3q22938168
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Thu, 5 Feb 2026 21:49:33 GMT
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 5994158055;
 Thu,  5 Feb 2026 21:49:33 +0000 (GMT)
Received: from smtpav01.wdc07v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CAB6658063;
 Thu,  5 Feb 2026 21:49:31 +0000 (GMT)
Received: from li-479af74c-31f9-11b2-a85c-e4ddee11713b.ibm.com (unknown
 [9.61.132.67]) by smtpav01.wdc07v.mail.ibm.com (Postfix) with ESMTP;
 Thu,  5 Feb 2026 21:49:31 +0000 (GMT)
Message-ID: <1c30cbc9f0c04b3da5a48bc20f8d9cacfeb11911.camel@linux.ibm.com>
Subject: Re: [PATCH v2 3/9] target/s390x: Replace %target_ulong -> %vaddr
 where appropriate
From: Eric Farman <farman@linux.ibm.com>
To: Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, Matthew Rosato	
 <mjrosato@linux.ibm.com>, Halil Pasic <pasic@linux.ibm.com>, David
 Hildenbrand	 <david@kernel.org>, Thomas Huth <thuth@redhat.com>,
 qemu-s390x@nongnu.org, Anton Johansson	 <anjo@rev.ng>, Richard Henderson
 <richard.henderson@linaro.org>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Ilya Leoshkevich <iii@linux.ibm.com>
Date: Thu, 05 Feb 2026 16:49:31 -0500
In-Reply-To: <4eb5b630-dad5-4cd8-97a6-d1d4a3499400@linaro.org>
References: <20260204182722.44062-1-philmd@linaro.org>
 <20260204182722.44062-4-philmd@linaro.org>
 <2827f8b28c4a654cb1b37eaf1313a1d63fb58f05.camel@linux.ibm.com>
 <4eb5b630-dad5-4cd8-97a6-d1d4a3499400@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.58.2 (3.58.2-1.fc43) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: bnkhkAC7wwOnrSBN-yUa2JHdUXYGLxkI
X-Authority-Analysis: v=2.4 cv=drTWylg4 c=1 sm=1 tr=0 ts=69851070 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=HzLeVaNsDn8A:10 a=VkNPw1HP01LnGYTKEx00:22
 a=KKAkSRfTAAAA:8 a=RP4XjpLoLUt4lZ2d1cgA:9 a=NqO74GWdXPXpGKcKHaDJD/ajO6k=:19
 a=QEXdDO2ut3YA:10 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-ORIG-GUID: bnkhkAC7wwOnrSBN-yUa2JHdUXYGLxkI
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMjA1MDE2MyBTYWx0ZWRfXwfSv6UYteAKr
 +QDYDBqzvjlThNZgtREof6smIIy0+Y6Ditc2W8lKsyDHcLanfScM5EEt+UxB441qjyWP4KbRYnf
 GUVRmuQC/YEDaZoMJmAy16RT8eMuO2K4e1eFaFjT6ZDm6d5xzkxCM5hDJ+VRO5Ss6vHFOVsRjL+
 RD7ZSMMLdWxKItSYD6I9F/l65jBpMx/9F6fobVUUHclmkwmfXpdS6dIyn4H2F4GhA+FF3QSp5hs
 ceOP8cgjVYa8f2eq+lfgDdM0I7ef5w+0qMxYVIVMytoFPEY29oPncpkbAzH/IPsTZWhOEEzXhV7
 IV86SmC9J2NWNNn9FTZPgONl7FPVav7ksPUCws5JtlPoBxSW5IwAmFPhmlf2UYC90WYawnFod6v
 WfL3BCl6dyVIInPc5ygvanxTOcmHy1nTdRX97vwX2oaQ3GWJBDiCMwXqOn58Tgy5cLTNiHwZ8dm
 sXOEPKznRvcqe6zdweA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-02-05_05,2026-02-05_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 clxscore=1015 spamscore=0 malwarescore=0 bulkscore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2601150000
 definitions=main-2602050163
Received-SPF: pass client-ip=148.163.156.1; envelope-from=farman@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, 2026-02-05 at 22:37 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> Hi Eric,
>=20
> On 5/2/26 22:23, Eric Farman wrote:
> > On Wed, 2026-02-04 at 19:27 +0100, Philippe Mathieu-Daud=C3=A9 wrote:
> > > Use the %vaddr type for virtual addresses.
> > >=20
> > > Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> > > ---
> > >   target/s390x/s390x-internal.h  | 5 +++--
> > >   target/s390x/helper.c          | 2 +-
> > >   target/s390x/mmu_helper.c      | 6 +++---
> > >   target/s390x/tcg/excp_helper.c | 3 ++-
> > >   4 files changed, 9 insertions(+), 7 deletions(-)
>=20
>=20
> > > @@ -376,9 +377,9 @@ void probe_write_access(CPUS390XState *env, uint6=
4_t addr, uint64_t len,
> > >   bool mmu_absolute_addr_valid(target_ulong addr, bool is_write);
> > >   /* Special access mode only valid for mmu_translate() */
> > >   #define MMU_S390_LRA        -1
> > > -int mmu_translate(CPUS390XState *env, target_ulong vaddr, int rw, ui=
nt64_t asc,
> > > +int mmu_translate(CPUS390XState *env, vaddr vaddr, int rw, uint64_t =
asc,
> > >                     target_ulong *raddr, int *flags, uint64_t *tec);
> > > -int mmu_translate_real(CPUS390XState *env, target_ulong raddr, int r=
w,
> > > +int mmu_translate_real(CPUS390XState *env, vaddr raddr, int rw,
> >=20
> > I think this one should remain target_ulong, and become hwaddr in the n=
ext patch, no?
>=20
> Without s390x background, I don't understand well what real addresses
> are. IFAICT the single caller s390_cpu_tlb_fill() provides a virtual
> address. But then indeed mmu_real2abs() consumes a hwaddr as real addr.

Hi Philippe,

Ah, I didn't go the other direction (my bad). The usage of "real" here is k=
ind of halfway between
virtual and -really- real. I suspect the caller is mistaken here, but I thi=
nk that's a research
project for tomorrow.


>=20
> >=20
> > >                          target_ulong *addr, int *flags, uint64_t *te=
c);
> > >  =20
> > >  =20

