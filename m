Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82620C43458
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Jul 2026 22:01:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wjOiS-0002hJ-VU; Mon, 13 Jul 2026 18:01:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wjOiR-0002gp-2g; Mon, 13 Jul 2026 18:01:31 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vishalc@linux.ibm.com>)
 id 1wjOiP-0005fC-4a; Mon, 13 Jul 2026 18:01:30 -0400
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66DJBop51463685; Mon, 13 Jul 2026 22:01:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=8/LdM8
 0BhIAUPB1Zu9oT1Q9GiBEytD/JjdeqTRJQtOU=; b=o1pHoHUJYcNquP/laUMJ++
 rGIFtm1ORYKk36B45N5exz8HsQfIxlF6Qq2h3TRnM3NJbaNlIDm7hzePpeljJBbw
 JzeEPPrVA/0h8J7/1Tn2WtfHy46zxd22JSUZQUnQ4tC0PpYUBvpGoQpPyrnnIIxI
 3BnvrE/SIKqQthS1X/CUfqdIQp8WbNx935tvz3nVm8WWC1mLHJRaM6V0YdTEbeiS
 m+7AFVw6blqvik0jnKIC+8Hu3+hz9cGZfFi/q9oh6f96rpOjEqQkikjJC7qXWsBq
 96qHgPWQOSqqoBqy1WowqVKOp36gji3aWv2jKkHfy374FqdMcgrVsdbHaMS91TYw
 ==
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fcv333gnx-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 22:01:26 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DLnb5R005015;
 Mon, 13 Jul 2026 22:01:25 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fc05pyyex-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 13 Jul 2026 22:01:25 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 66DM1L7s33423638
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 13 Jul 2026 22:01:21 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AAAFE2005A;
 Mon, 13 Jul 2026 22:01:21 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id D70342004E;
 Mon, 13 Jul 2026 22:01:18 +0000 (GMT)
Received: from linux.ibm.com (unknown [9.124.216.204])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon, 13 Jul 2026 22:01:18 +0000 (GMT)
Date: Tue, 14 Jul 2026 03:31:15 +0530
From: Vishal Chourasia <vishalc@linux.ibm.com>
To: Chinmay Rath <rathc@linux.ibm.com>
Cc: qemu-ppc@nongnu.org, qemu-devel@nongnu.org, milesg@linux.ibm.com,
 harshpb@linux.ibm.com, Vishal Chourasia <Vishal.Chourasia2@ibm.com>
Subject: Re: [RFC PATCH v2] target/ppc: Move system call and rfi instructions
 to decodetree
Message-ID: <alVgK6V_DTmLZ18J@linux.ibm.com>
References: <ca4dfe89-78ea-4fc1-bb0c-71650ca2d8f8@linux.ibm.com>
 <20260528105907.623794-2-vishalc@linux.ibm.com>
 <0ad6b162-086f-4357-b16c-a2988dde7844@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0ad6b162-086f-4357-b16c-a2988dde7844@linux.ibm.com>
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDIyMyBTYWx0ZWRfX4gFtWC33mtyJ
 aybeFNmVjRIlPp7+5cQ2N9WUFmHS/idSnhpJrR3p56eX0/Lr2LUHoLT/cmzAC5fAfkP9MVy62nZ
 WGy0hAoGtMBbUZg1jjfgb+4BDji7kJc=
X-Authority-Analysis: v=2.4 cv=Mp1iLWae c=1 sm=1 tr=0 ts=6a556036 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=8nJEP1OIZ-IA:10 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=hSGomXLIhli_EKBvHAAA:9 a=3ZKOabzyN94A:10 a=wPNLvfGTeEIA:10
X-Proofpoint-GUID: pL0q54r7dDqOhcePByrD4HXh2hHR3p7b
X-Proofpoint-ORIG-GUID: pL0q54r7dDqOhcePByrD4HXh2hHR3p7b
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDIyMyBTYWx0ZWRfX9ck2pTXP4jjh
 JJF76Dchf2Dtpa6uNWrycVpXEjZ17HpTNPplBxJ4j7Raa092sVliNw2SQHUL/0y2CPzLiFn3hwE
 Uvao/UIdRiIXd4JlNL1fO/RL6XrdwU8qfyWr28l+wsdkf2yC0rAfXVwh3ePcvijykmEX/Q8cj8e
 79nUn9tuYEuaiILCwVOZz86EYCrkx3M8gZwjfJh06RBiv8Hqz/UvaWHMEgc3i/YR5b8Vxh7Jb/K
 TV3ZjvcMIRrtI0W7B098luHuNk95neXbHGrwSrWSXd5UdmxiOvGgp6eUm1qo1f3gLPBEQlG3tTO
 sOPZX1IMJ9xJ1DzSCUGs4HPMAeXE0+s9pQod/4qpjdi6uBLeEvGWcJrgNl+AlDnLBSeOxnR+SQa
 6bzCbff7m7o1XvboarIOis0pSsE+Gfea93fAJ2ba/bh71WL2HMr86EcqVet+7UtJOlT7K8/+6kT
 bQihmmdqG+MhnDGdXUw==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_05,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0
 impostorscore=0 priorityscore=1501 suspectscore=0 clxscore=1015 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130223
Received-SPF: pass client-ip=148.163.156.1; envelope-from=vishalc@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01, SPF_HELO_NONE=0.001,
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

On Mon, Jul 06, 2026 at 03:44:29PM +0530, Chinmay Rath wrote:
> 
> On 5/28/26 16:29, Vishal Chourasia wrote:
> > From: Vishal Chourasia <Vishal.Chourasia2@ibm.com>
> > 
> > Moving the following instructions to decodetree specification:
> >      sc, scv                         : SC-form
> >      rfi, rfid, rfscv, hrfid         : XL-form
> > 
> > This builds upon the previous work that moved mfmsr and mtmsr[d]
> > instructions to decodetree.
> > 
> > The changes were verified by validating that the tcg ops generated by
> > those instructions remain the same, which were captured with the
> > `-d in_asm,op` flag, and also by booting a pseries qemu guest.
> > 
> > This also includes improvements from review feedback:
> > - Rename helpers to uppercase (RFI/RFID/RFSCV/HRFID) to match ISA mnemonics
> > - Add TRANS_FLAGS_NOT() and TRANS64_FLAGS() macro variants
> > - Add REQUIRE_INSNS_FLAGS_NOT() check for flag exclusion
> > - Specify lev field as uint8_t in SC instruction format
> > - Remove redundant masking in SCV since lev is already 7-bit
> > - Replace TARGET_PPC64 ifdefs with REQUIRE_64BIT() macro
> > - Gate SC, SCV, RFI, RFID, RFSCV, and HRFID with appropriate flags
> > - Replace runtime is_book3s_arch2x() check in RFI with TRANS_FLAGS_NOT(SEGMENT_64B)
> > - Consolidate CONFIG_USER_ONLY guards into single block
> > 
> > Signed-off-by: Vishal Chourasia <vishalc@linux.ibm.com>
> > ---
> > 
> > v2: In v1, do_rfi() path effectively only implemented the instruction
> > for user-only and 64-bit builds, so on qemu-system-ppc every rfi was
> > translated as invalid. This trapped OpenBIOS in exception return paths
> > and caused the boot/tests to hang. In v2 restore the 32-bit system
> > emulation rfi path while keeping rfid, hrfid, and rfscv 64-bit-only.
> 
> Hi Vishal,
> 
> Thanks for fixing this. I had some queries :
> 
> > 
> >   target/ppc/helper.h                  |   8 +-
> >   target/ppc/insn32.decode             |  11 +++
> >   target/ppc/tcg-excp_helper.c         |   8 +-
> >   target/ppc/translate.c               | 139 ++++-----------------------
> >   target/ppc/translate/misc-impl.c.inc | 100 +++++++++++++++++++
> >   5 files changed, 139 insertions(+), 127 deletions(-)
> > 
<snip>
> > @@ -4566,21 +4482,6 @@ GEN_HANDLER(rlwnm, 0x17, 0xFF, 0xFF, 0x00000000, PPC_INTEGER),
> >   GEN_HANDLER_E(dform39, 0x39, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
> >   /* handles stfdp, stxsd, stxssp */
> >   GEN_HANDLER_E(dform3D, 0x3D, 0xFF, 0xFF, 0x00000000, PPC_NONE, PPC2_ISA205),
> > -/* ISA v3.0 changed the extended opcode from 62 to 30 */
> > -GEN_HANDLER(rfi, 0x13, 0x12, 0x01, 0x03FF8001, PPC_FLOW),
> Above PPC_FLOW flag is missing in the new code it seems. I
> have pointed it out at the relevant TRANS macro as well.
> > -#if defined(TARGET_PPC64)
> > -GEN_HANDLER(rfid, 0x13, 0x12, 0x00, 0x03FF8001, PPC_64B),
> > -#if !defined(CONFIG_USER_ONLY)
> > -/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
> > -GEN_HANDLER_E(scv, 0x11, 0x10, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
> > -GEN_HANDLER_E(scv, 0x11, 0x00, 0xFF, 0x03FFF01E, PPC_NONE, PPC2_ISA300),
> > -GEN_HANDLER_E(rfscv, 0x13, 0x12, 0x02, 0x03FF8001, PPC_NONE, PPC2_ISA300),
> > -#endif
> > -GEN_HANDLER(hrfid, 0x13, 0x12, 0x08, 0x03FF8001, PPC_64H),
> Above PPC_64H flag is missing in the new code it seems. I have
> pointed it out at the relevant TRANS macro as well.
> > -#endif
> > -/* Top bit of opc2 corresponds with low bit of LEV, so use two handlers */
> > -GEN_HANDLER(sc, 0x11, 0x11, 0xFF, 0x03FFF01D, PPC_FLOW),
> > -GEN_HANDLER(sc, 0x11, 0x01, 0xFF, 0x03FFF01D, PPC_FLOW),
> >   GEN_HANDLER(mcrxr, 0x1F, 0x00, 0x10, 0x007FF801, PPC_MISC),
> >   GEN_HANDLER(mfspr, 0x1F, 0x13, 0x0A, 0x00000001, PPC_MISC),
> >   GEN_HANDLER(mftb, 0x1F, 0x13, 0x0B, 0x00000001, PPC_MFTB),
<snip>
> > +
> > +static bool do_rfi(DisasContext *ctx, arg_RFID *a, int kind)
> > +{
> > +#if defined(CONFIG_USER_ONLY)
> > +    gen_priv_opc(ctx);
> > +    return true;
> > +#else
> > +    void (*helper)(TCGv_ptr);
> > +
> > +    switch (kind) {
> > +    case RFI:
> > +        if (is_book3s_arch2x(ctx)) {
> > +            gen_invalid(ctx);
> > +            return true;
> > +        }
> Since you are already using TRANS_FLAGS_NOT, is it still
> necessary to have the above check ? Or, better yet,  from the
> other way around, since you have this check, is it necessary
> to introduce and have the TRANS_FLAGS_NOT macro at all ?
> I felt both are doing the same job. Let me if I am missing something.
No, you are not. Latter should be the preferred approach. I will address
it in the next version.

> > +        REQUIRE_SV(ctx);
> > +        helper = gen_helper_RFI;
> > +        break;
> > +#if defined(TARGET_PPC64)
> > +    case HRFID:
> > +        REQUIRE_HV(ctx);
> > +        helper = gen_helper_HRFID;
> > +        break;
> > +    case RFID:
> > +        REQUIRE_SV(ctx);
> > +        helper = gen_helper_RFID;
> > +        break;
> > +    case RFSCV:
> > +        REQUIRE_SV(ctx);
> > +        helper = gen_helper_RFSCV;
> > +        break;
> > +#endif
> > +    default:
> > +        gen_invalid(ctx);
> > +        return true;
> > +    }
> > +
<snip>
> > +
> > +TRANS_FLAGS_NOT(SEGMENT_64B, RFI, do_rfi, RFI)
> > +TRANS64(RFID, do_rfi, RFID)
> > +TRANS64(HRFID, do_rfi, HRFID)
> > +TRANS64_FLAGS2(ISA300, RFSCV, do_rfi, RFSCV)
> Looks like we have dropped some flag checks :
> RFI is missing PPC_FLOW and HRFID is missing PPC_64H
> 
Yes, I missed adding those flags. Thank you for pointing out.
And, apologies for the delay in response.

I will post another version shortly.

Thanks,
Vishal


