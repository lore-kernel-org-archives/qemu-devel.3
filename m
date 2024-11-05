Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8A0CDD3177B
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Nov 2024 18:02:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8NsN-0004kF-4e; Tue, 05 Nov 2024 13:01:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t8NsL-0004je-Gv; Tue, 05 Nov 2024 13:01:57 -0500
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t8NsJ-00045e-JA; Tue, 05 Nov 2024 13:01:57 -0500
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5HecWw023083;
 Tue, 5 Nov 2024 18:01:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=dbUUh5
 TSso3Dypp1NC5ZlxBvs/EIdaIxIpQvfBU7Fws=; b=q3x5cSUbx6j3TTBExjpXc6
 +906JXob0rIS9Cg7o1kSygpjftZA5QGvK3XaP/sZlAeOG8FwrCHmx5B8YD00WqKx
 1by3fqmzB5kRzZYJ/MYcLTuMO6ipp4nHxBLXgtezP1at9zriq/AkhWP0xluDx459
 Z6CtmYpI/317anq7rhxaXiUZjDzuizREogjvFo1dOlpJ9AAgcv2InSFs7BJ9B521
 en6xxL1M6pspcL9oGkTn7XG1I11Fv8c2zM/yehx9X8xRh1v6bxCU234UC3p3+kwH
 KpWxUp8P8I45waebl6U1L3sJ3fAMYMJ9xqFiTWZub0osgQUJzlIKRtCczSnLrOEA
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qqy5r2sm-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 18:01:51 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 4A5I1oxZ000861;
 Tue, 5 Nov 2024 18:01:50 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42qqy5r2sh-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 18:01:50 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A5CgF5O024314;
 Tue, 5 Nov 2024 18:01:49 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42p0mj4gw4-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 05 Nov 2024 18:01:49 +0000
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com
 [10.20.54.101])
 by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 4A5I1muR34800326
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Tue, 5 Nov 2024 18:01:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 335FA2004B;
 Tue,  5 Nov 2024 18:01:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8CD3F20040;
 Tue,  5 Nov 2024 18:01:47 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Tue,  5 Nov 2024 18:01:47 +0000 (GMT)
Message-ID: <9c8978b30e9b23c3eeee1a68dd4d61369bbbcc46.camel@linux.ibm.com>
Subject: Re: [PULL 02/67] target/ppc: Make divd[u] handler method decodetree
 compatible
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Michael Tokarev <mjt@tls.msk.ru>, Nicholas Piggin <npiggin@gmail.com>,
 qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, qemu-stable@nongnu.org, Richard Henderson
 <richard.henderson@linaro.org>, Philippe =?ISO-8859-1?Q?Mathieu-Daud=E9?=
 <philmd@linaro.org>
Date: Tue, 05 Nov 2024 19:01:47 +0100
In-Reply-To: <1a73699a-dce6-4197-8132-0d5a16971ef3@tls.msk.ru>
References: <20241104001900.682660-1-npiggin@gmail.com>
 <20241104001900.682660-3-npiggin@gmail.com>
 <1a73699a-dce6-4197-8132-0d5a16971ef3@tls.msk.ru>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: H_JqoxemfdNx1dX6ylQajvvMIGsTC4sA
X-Proofpoint-GUID: DfmuH5CEMFR_hTzCiLwTobqQToER1KRw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501
 bulkscore=0 impostorscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0
 mlxlogscore=618 mlxscore=0 phishscore=0 adultscore=0 malwarescore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050135
Received-SPF: pass client-ip=148.163.156.1; envelope-from=iii@linux.ibm.com;
 helo=mx0a-001b2d01.pphosted.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_LOW=-0.7,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, 2024-11-05 at 18:33 +0300, Michael Tokarev wrote:
> 04.11.2024 03:17, Nicholas Piggin wrote:
> > From: Ilya Leoshkevich <iii@linux.ibm.com>
> >=20
> > This is like commit 86e6202a57b1 ("target/ppc: Make divw[u] handler
> > method decodetree compatible."), but for gen_op_arith_divd().
>=20
> 86e6202a57b1 is v9.0.0-880-g86e6202a57b1, ie, it is in 9.1 only.
> So I wonder what should we do for older stable series (namely for
> 8.2 lts and 9.0), -- should we pick this one together with the
> mentioned 86e6202a57b1, or neither?
>=20
> A separate question is whenever it makes sense to pick these for 7.2?
>=20
> Thanks,
>=20
> /mjt

Come to think of it, I would recommend only the previous commit
("target/ppc: Set ctx->opcode for decode_insn32()") for stable. It
solves the whole class of potential problems like this one, and it
should apply to 7.2 as well.

The reason we also have this fix in the pull request is that long-term
the ctx->opcode field will be removed.

[...]

