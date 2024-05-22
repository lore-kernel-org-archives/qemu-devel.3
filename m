Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 672B6C25B78
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 22:51:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9unL-0007vf-5a; Wed, 22 May 2024 18:50:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1s9unI-0007ta-Oz; Wed, 22 May 2024 18:50:48 -0400
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1s9unF-0000Q2-IP; Wed, 22 May 2024 18:50:48 -0400
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MMP4Oe032015; Wed, 22 May 2024 22:50:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com;
 h=message-id : subject :
 from : to : cc : date : in-reply-to : references : content-type :
 content-transfer-encoding : mime-version; s=pp1;
 bh=RmYTwyVjJ9084/4w+5d9o+YB2EYeWRZMhWJLAHeJAFU=;
 b=b+Zvr+dpPyDhLc3stuOVrqa1l+whRt9b6/yUrre14A+l5gdelo+kjY9R3vVQPpj+Bvmi
 GQkoY78aKDjn5YOJY4qWoIidxl1RL9X7GMLAlf5e5+V6ZLTFf9rh5OrZUnwsQHyIbesS
 2uNQsrrTjNMN9dhvFa/Nrme3+2opgexspKJ9yhE/LHnj0eCmmlhveA/wUs/+0EMekVet
 oDrf6hBjh5CtZuVSWcyBsehwaAS27L6Q2CobH7eUNJpxIW9saLYWN9HWDS2+5FYvO9wY
 Ao5v/bKYtJaVkR81HM+xxhFJ/cBA9e9tR+iz3ar+0d/gzAPGZi+Kw2I2T9yKsHA+Rgnb JQ== 
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9qwn87yt-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 22:50:42 +0000
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
 by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 44MMogaw003319;
 Wed, 22 May 2024 22:50:42 GMT
Received: from ppma12.dal12v.mail.ibm.com
 (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 3y9qwn87yr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 22:50:42 +0000
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
 by ppma12.dal12v.mail.ibm.com (8.17.1.19/8.17.1.19) with ESMTP id
 44MJjT4W022112; Wed, 22 May 2024 22:45:41 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
 by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 3y76ntxsww-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 22 May 2024 22:45:41 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com
 [10.20.54.103])
 by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 44MMjch751905004
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Wed, 22 May 2024 22:45:40 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id E9ED72004B;
 Wed, 22 May 2024 22:45:37 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id 8D70E20040;
 Wed, 22 May 2024 22:45:37 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Wed, 22 May 2024 22:45:37 +0000 (GMT)
Message-ID: <b1d64ce0bce9241f62a3db44b92b74d47c833979.camel@linux.ibm.com>
Subject: Re: [PATCH 09/14] target/s390x: Raise exception from helper_per_branch
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, david@redhat.com, thuth@redhat.com
Date: Thu, 23 May 2024 00:45:37 +0200
In-Reply-To: <20240502054417.234340-10-richard.henderson@linaro.org>
References: <20240502054417.234340-1-richard.henderson@linaro.org>
 <20240502054417.234340-10-richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TJOz9MVoY9b-k4JExNVyWbENJMG6Jawj
X-Proofpoint-ORIG-GUID: 2UurbKJKyR-zWo7T5iBcUuqTd-a9oH-A
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.12.28.16
 definitions=2024-05-22_12,2024-05-22_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0
 impostorscore=0 phishscore=0 priorityscore=1501 mlxlogscore=909
 suspectscore=0 malwarescore=0 clxscore=1015 adultscore=0 bulkscore=0
 mlxscore=0 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2405010000 definitions=main-2405220159
Received-SPF: pass client-ip=148.163.158.5; envelope-from=iii@linux.ibm.com;
 helo=mx0b-001b2d01.pphosted.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 2024-05-01 at 22:44 -0700, Richard Henderson wrote:
> Drop from argument, since gbea has always been updated with
> this address.=C2=A0 Add ilen argument for setting int_pgm_ilen.
> Use update_cc_op before calling per_branch.
>=20
> By raising the exception here, we need not call
> per_check_exception later, which means we can clean up the
> normal non-exception branch path.
>=20
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
> =C2=A0target/s390x/helper.h=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0 |=C2=A0 2 +-
> =C2=A0target/s390x/tcg/misc_helper.c | 15 +++++++----
> =C2=A0target/s390x/tcg/translate.c=C2=A0=C2=A0 | 48 ++++++++++++---------=
-----------
> --
> =C2=A03 files changed, 27 insertions(+), 38 deletions(-)

[...]

> =C2=A0static bool use_goto_tb(DisasContext *s, uint64_t dest)
> =C2=A0{
> -=C2=A0=C2=A0=C2=A0 if (unlikely(s->base.tb->flags & FLAG_MASK_PER_BRANCH=
)) {
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 return false;
> -=C2=A0=C2=A0=C2=A0 }

Why was this required in the first place and why can we remove it now?


