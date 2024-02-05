Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E7CC4828D
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Feb 2024 18:49:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rX40m-0007Bz-Ex; Mon, 05 Feb 2024 13:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX40c-00079S-FL; Mon, 05 Feb 2024 13:47:58 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1rX40Y-0004Jl-8v; Mon, 05 Feb 2024 13:47:58 -0500
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 415IMYfP005824; Mon, 5 Feb 2024 18:47:51 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=date : from : to : cc :
 subject : message-id : references : mime-version : content-type :
 in-reply-to; s=pp1; bh=vUvmbUlvubqCTN8LImq/LIdGC98p95KDIvyQ7hM+Sic=;
 b=m6UtASWosa2KvN/U4KT0dzkcXGE2Ozzhl79/Jc0tCihbGZTIo2tmCfAiNk26v5ZXRhYI
 Ff4kYUgnAonRFB/GV+NL4Qndacv7lKZd8lPsfQu07P7AycOcg3dPxj9lyRYpheuL+oNV
 ox6UvpotIJkCnwLvzF3lssjuUqObDFBMsisp4ohwssCvdi535RWEB7gBpzhISnCcl43N
 bBGLPYcxKJ6OlmlrNPtfUZgVM70tcAaIC5f78RszQHo8p3MQyTVeYUQcg/njcO1XBSRS
 eNKtl4OzAR4j2jYRC8Og1d/xLSlkq13MHG0JdYBPFqmSknf0Sq1/LLr1sTIaq3PSoplM BQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34w0ggtm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:47:51 +0000
Received: from m0353729.ppops.net (m0353729.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 415IMMTO005272;
 Mon, 5 Feb 2024 18:47:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3w34w0ggsk-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:47:50 +0000
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 415I17V5008487; Mon, 5 Feb 2024 18:47:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 3w221jswm9-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 05 Feb 2024 18:47:48 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 415Illl428049910
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Mon, 5 Feb 2024 18:47:47 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 2E8B520043;
 Mon,  5 Feb 2024 18:47:47 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id B84D220040;
 Mon,  5 Feb 2024 18:47:46 +0000 (GMT)
Received: from heavy (unknown [9.171.57.170])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
 Mon,  5 Feb 2024 18:47:46 +0000 (GMT)
Date: Mon, 5 Feb 2024 19:47:45 +0100
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Thomas Huth <thuth@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 David Hildenbrand <david@redhat.com>
Cc: qemu-s390x@nongnu.org, qemu-devel@nongnu.org,
 Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
Subject: Re: Re: [PATCH v4 2/4] target/s390x: Emulate CVB, CVBY and CVBG
Message-ID: <kclyl3vhymcuxpe6nvxfkwgjp3kqiafqzejfuugwioeadsh7z6@gfnmhezsict7>
References: <20240202141318.95962-1-iii@linux.ibm.com>
 <20240202141318.95962-3-iii@linux.ibm.com>
 <8a9f3802-af41-4189-94b7-c09e5b9617d9@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8a9f3802-af41-4189-94b7-c09e5b9617d9@redhat.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: j4C4Fv4Hu55lZl6EzvJcWotQxGvX8eIz
X-Proofpoint-ORIG-GUID: scEGKDsVnbfbup7znVSGWMvYeydbHWh_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-05_12,2024-01-31_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 phishscore=0 spamscore=0
 lowpriorityscore=0 impostorscore=0 mlxlogscore=518 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311290000 definitions=main-2402050141
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 05, 2024 at 06:04:27PM +0100, Thomas Huth wrote:
> On 02/02/2024 15.11, Ilya Leoshkevich wrote:
> > Convert to Binary - counterparts of the already implemented Convert
> > to Decimal (CVD*) instructions.
> > Example from the Principles of Operation: 25594C becomes 63FA.
> > 
> > Co-developed-by: Pavel Zbitskiy <pavel.zbitskiy@gmail.com>
> > Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
> > ---
> >   target/s390x/helper.h            |  2 +
> >   target/s390x/tcg/insn-data.h.inc |  4 ++
> >   target/s390x/tcg/int_helper.c    | 72 ++++++++++++++++++++++++++++++++
> >   target/s390x/tcg/translate.c     | 16 +++++++
> >   4 files changed, 94 insertions(+)

[...]

> > +uint64_t HELPER(cvbg)(CPUS390XState *env, Int128 dec)
> > +{
> > +    uint64_t dec64[] = {int128_getlo(dec), int128_gethi(dec)};
> > +    int64_t bin = 0, pow10, tmp;
> > +    int digit, i, sign;
> > +
> > +    sign = dec64[0] & 0xf;
> > +    if (sign < 0xa) {
> > +        tcg_s390_data_exception(env, 0, GETPC());
> > +    }
> > +    dec64[0] >>= 4;
> > +    pow10 = (sign == 0xb || sign == 0xd) ? -1 : 1;
> > +
> > +    for (i = 1; i < 20; i++) {
> > +        digit = dec64[i >> 4] & 0xf;
> > +        if (digit > 0x9) {
> > +            tcg_s390_data_exception(env, 0, GETPC());
> > +        }
> > +        dec64[i >> 4] >>= 4;
> > +        tmp = pow10 * digit;
> > +        if (digit && ((tmp ^ pow10) < 0)) {
> 
> That tmp ^ pow10 caused some frowning for me first, but it's just a check
> whether the sign changed, right? ... a comment in front of the line might be
> helpful.

Good point about writing a comment, I tried to elaborate why checking
the sign is justified, and realized that it's actually redundant.
The int64_t bounds are roughly +-9.2E+18, and the last pow10 value in
this loop is +-1E+18. The multiplication cannot overflow.

> > +            tcg_s390_program_interrupt(env, PGM_FIXPT_DIVIDE, GETPC());
> > +        }
> > +        tmp = bin + tmp;
> > +        if (bin && ((tmp ^ bin) < 0)) {

The addition, however, can, e.g., bin=9E+17 and tmp=9E+18.
So I'll send a v5 without the first check and with a comment.

[...]

