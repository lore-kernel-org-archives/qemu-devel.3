Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3A5DED149D9
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Oct 2024 17:47:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t4OOA-0007rh-DB; Fri, 25 Oct 2024 13:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t4OO8-0007qy-1v; Fri, 25 Oct 2024 13:46:16 -0400
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <iii@linux.ibm.com>)
 id 1t4OO6-000126-9m; Fri, 25 Oct 2024 13:46:15 -0400
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49P5u6Xv004002;
 Fri, 25 Oct 2024 17:45:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pp1; bh=krDHAk
 bzmR22kwJkOs/Fzwt9voQIBLZhbIDmZMcII/4=; b=g12Fq9s1DML1ZJTL5i9BMF
 qaZCo5yTzrSxhrUtv5+sVmm9yTw+vrBlgUr525HK2Dy3b4yOantiEotvzCNoVryn
 6V1z9fBLRFX48vYF+i16+3NUGQqz0yuX9y+VADKnXZuyN2IQjvyA8eheLCmzFU/G
 CIWyWekF+9hCVooVwaIpNcGyrUD5tzaT6MQtCZuTDfyf5wHraaaMkSn97P+PnInW
 iibe76vZvxJr+ND5JcsFwD/zshSKY6nYNm71MufSYdK5bR495rXFjyl6LsD1pN1k
 ksLIOs1g0Vkmqb0oP6OBEeTnT7DguWTyJFlu6rcLO7GeG8rbSCCTZhc/ZEdcqjzw
 ==
Received: from pps.reinject (localhost [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g5kxk9fr-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:45:56 +0000 (GMT)
Received: from m0360083.ppops.net (m0360083.ppops.net [127.0.0.1])
 by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49PHjtHw006356;
 Fri, 25 Oct 2024 17:45:55 GMT
Received: from ppma13.dal12v.mail.ibm.com
 (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
 by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42g5kxk9fq-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:45:55 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
 by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49PHDmLK012615;
 Fri, 25 Oct 2024 17:45:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
 by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 42emhfpy25-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 25 Oct 2024 17:45:54 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com
 [10.20.54.100])
 by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 49PHjq4B37683512
 (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
 Fri, 25 Oct 2024 17:45:52 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id AF5C820040;
 Fri, 25 Oct 2024 17:45:52 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
 by IMSVA (Postfix) with ESMTP id CF99C20043;
 Fri, 25 Oct 2024 17:45:49 +0000 (GMT)
Received: from [127.0.0.1] (unknown [9.152.108.100])
 by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
 Fri, 25 Oct 2024 17:45:49 +0000 (GMT)
Message-ID: <eae6bd6b38ad972c792739eb05c7ee92c1e9242f.camel@linux.ibm.com>
Subject: Re: [PATCH 07/21] target/s390x: Explicitly set 2-NaN propagation rule
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org
Cc: Alex =?ISO-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>, Richard
 Henderson <richard.henderson@linaro.org>, Philippe
 =?ISO-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>, Song Gao
 <gaosong@loongson.cn>, Eduardo Habkost <eduardo@habkost.net>, "Edgar E.
 Iglesias" <edgar.iglesias@gmail.com>, Jiaxun Yang
 <jiaxun.yang@flygoat.com>, Aleksandar Rikalo <arikalo@gmail.com>, Stafford
 Horne <shorne@gmail.com>, Nicholas Piggin <npiggin@gmail.com>, Daniel
 Henrique Barboza <danielhb413@gmail.com>, Yoshinori Sato
 <ysato@users.sourceforge.jp>, David Hildenbrand <david@redhat.com>, Thomas
 Huth <thuth@redhat.com>, Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>,
 Max Filippov <jcmvbkbc@gmail.com>, qemu-ppc@nongnu.org,
 qemu-s390x@nongnu.org
Date: Fri, 25 Oct 2024 19:45:49 +0200
In-Reply-To: <20241025141254.2141506-8-peter.maydell@linaro.org>
References: <20241025141254.2141506-1-peter.maydell@linaro.org>
 <20241025141254.2141506-8-peter.maydell@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.52.4 (3.52.4-1.fc40) 
MIME-Version: 1.0
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: A0BlXL4U1OOiXL4FIBcs_TBHoOuqwKse
X-Proofpoint-GUID: nCmk0rsFG3-nq-YUXtU1E03tH7hR33LS
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 mlxlogscore=909
 malwarescore=0 spamscore=0 bulkscore=0 priorityscore=1501 impostorscore=0
 suspectscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 adultscore=0
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410250134
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

On Fri, 2024-10-25 at 15:12 +0100, Peter Maydell wrote:
> Set the 2-NaN propagation rule explicitly in env->fpu_status.
>=20
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
> =C2=A0target/s390x/cpu.c=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0 | 1 +
> =C2=A0fpu/softfloat-specialize.c.inc | 5 ++---
> =C2=A02 files changed, 3 insertions(+), 3 deletions(-)
>=20
> diff --git a/target/s390x/cpu.c b/target/s390x/cpu.c
> index 4e41a3dff59..514c70f3010 100644
> --- a/target/s390x/cpu.c
> +++ b/target/s390x/cpu.c
> @@ -205,6 +205,7 @@ static void s390_cpu_reset_hold(Object *obj,
> ResetType type)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* tininess for underflo=
w is detected before rounding */
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_float_detect_tinines=
s(float_tininess_before_rounding,
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 &env->fpu_status)=
;
> +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 set_float_2nan_prop_rule(floa=
t_2nan_prop_s_ab, &env-
> >fpu_status);
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /* fall through */
> =C2=A0=C2=A0=C2=A0=C2=A0 case RESET_TYPE_S390_CPU_NORMAL:
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 env->psw.mask &=3D ~PSW_=
MASK_RI;
> diff --git a/fpu/softfloat-specialize.c.inc b/fpu/softfloat-
> specialize.c.inc
> index 4e51cf8d083..a0c740e544d 100644
> --- a/fpu/softfloat-specialize.c.inc
> +++ b/fpu/softfloat-specialize.c.inc
> @@ -403,10 +403,9 @@ static int pickNaN(FloatClass a_cls, FloatClass
> b_cls,
> =C2=A0#if defined(TARGET_AVR) || defined(TARGET_HEXAGON) \
> =C2=A0=C2=A0=C2=A0=C2=A0 || defined(TARGET_RISCV) || defined(TARGET_SH4) =
\
> =C2=A0=C2=A0=C2=A0=C2=A0 || defined(TARGET_TRICORE) || defined(TARGET_ARM=
) ||
> defined(TARGET_MIPS) \
> -=C2=A0=C2=A0=C2=A0 || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA=
)
> +=C2=A0=C2=A0=C2=A0 || defined(TARGET_LOONGARCH64) || defined(TARGET_HPPA=
) \
> +=C2=A0=C2=A0=C2=A0 || defined(TARGET_S390X)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 g_assert_not_reached();
> -#elif defined(TARGET_S390X)
> -=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 rule =3D float_2nan_prop_s_ab=
;
> =C2=A0#elif defined(TARGET_PPC) || defined(TARGET_M68K)
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 /*
> =C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 * PowerPC propagat=
ion rules:

Reviewed-by: Ilya Leoshkevich <iii@linux.ibm.com>

Thanks!

