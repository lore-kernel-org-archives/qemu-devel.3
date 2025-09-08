Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 586ADCAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 12:28:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvaxt-0001KM-6K; Mon, 08 Sep 2025 08:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaxi-0001Iu-1v
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:27:10 -0400
Received: from p-east1-cluster6-host2-snip4-6.eps.apple.com ([57.103.90.147]
 helo=outbound.ci.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mads@ynddal.dk>) id 1uvaxZ-0003Ed-QP
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 08:27:09 -0400
Received: from outbound.ci.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-3 (Postfix) with ESMTPS id
 963681804027; Mon,  8 Sep 2025 12:26:53 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ynddal.dk; s=sig1;
 bh=kCNTTu1CzhPyNqYp7vTZzRhhqfIIeHdmF+tKe0C+Z7E=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=lox3rf0GiIXMvWJEumgld8Bt3lAxjbLQ2Nm2dLwQsCqrnAltekkjQ74g+tTNKkzHizJxPUlKVHzQUfARBOC3g/p89v2nPBjealam+zJN+C6HYGNyfPJKgwaktw7T3CSftTL3XYg59gdxdvUsDBNTnDMnbA8pMTKaeFpNj1hsnnHsWUS2xGzwX8SiBlxJMDVQ3V8cCMlIsCk1y5KSSmYt79/DdMGCyYg5UUOkKo61INYjh0YG1JKB1+oVCh3zxeGf1T4DeUfxPdwaFQmt/rRdPnnP+uTah8FXT6Uam2VkpQFeAEPnyH2w1Z1Yo56+mZZZM1J/Imatl2aXNElRv56btA==
mail-alias-created-date: 1632407063367
Received: from smtpclient.apple (ci-asmtp-me-k8s.p00.prod.me.com
 [17.57.156.36])
 by p00-icloudmta-asmtp-us-central-1k-60-percent-3 (Postfix) with ESMTPSA id
 5FCB518000BE; Mon,  8 Sep 2025 12:26:51 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3826.700.81\))
Subject: Re: [PATCH 18/24] target/arm/hvf: Keep calling hv_vcpu_run() in loop
From: Mads Ynddal <mads@ynddal.dk>
In-Reply-To: <20250903100702.16726-19-philmd@linaro.org>
Date: Mon, 8 Sep 2025 14:26:39 +0200
Cc: qemu-devel@nongnu.org, Alexander Graf <agraf@csgraf.de>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-arm@nongnu.org,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Peter Maydell <peter.maydell@linaro.org>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Stefan Hajnoczi <stefanha@redhat.com>, Cameron Esfahani <dirty@apple.com>,
 Roman Bolshakov <rbolshakov@ddn.com>, Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E1EA7ABD-000E-454E-A49F-E8FB5572F831@ynddal.dk>
References: <20250903100702.16726-1-philmd@linaro.org>
 <20250903100702.16726-19-philmd@linaro.org>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
X-Mailer: Apple Mail (2.3826.700.81)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUwOTA4MDEyNSBTYWx0ZWRfX/0XhKcst9JXG
 rhVNRNdekemwQa5ullvBed+QgwY8snyECPRjx4oQ1XS0kPF0iD4c+owyCp8CjmOklqJT1wJLhXR
 zQlt3wjaJtPb0EsweI8T4t0EFLHhW0/5gBeCb6UcY3QZiXLF2J78EyJW3ERZbd63/o0CsriBcq0
 LZqJY1Bxu+M2mU/3JsTFj1NRd7sCDgWitPW8T3NsERSc6b3rEcYOS+2VTTCHITWWMU/AUW2VNCG
 LNF4+W5gU5o2UeIeQyzGAJm6WWyRGf+lXR8LYZPriMhLGho+HPwUq6WXcVopwIw66Du5uQeSQ=
X-Proofpoint-GUID: 7iwonXxGSYKr4Ihx5ydk3Om_Y-Di_XfG
X-Proofpoint-ORIG-GUID: 7iwonXxGSYKr4Ihx5ydk3Om_Y-Di_XfG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-09-08_04,2025-09-08_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 spamscore=0
 mlxlogscore=730 mlxscore=0 adultscore=0 malwarescore=0 suspectscore=0
 phishscore=0 bulkscore=0 clxscore=1030 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.22.0-2506270000 definitions=main-2509080125
X-JNJ: AAAAAAABkx3VQMUymAitfQ3g7uClA5DDDLQwK5N1qaR1HSQalej6ETQ1aBlz7dQF1KZ+hVABipeHXlz3Z+DJObOm0vMn2TaT4zcD5WfMHt42fh6K2GEFSFc0sb7xCBUz8yKGXUsY4CcZFIEpuT2fCXOGSDSVX8o/N0MmGKx1pwRmAwZ+R+NMs5PCHafo8XwWOi6/ZV/gXUEl1Odx20LN+f3BXyAprwgg/yKxI8aCEMKh6E7rB0fhJWGz206EgB5BjWJvPAIyoo8c942fxHFYgvOvLiJDpHsyR/WzbIiFJl8DlWfYoDV/TB20rc2Lcm+b2L+VC4mUNLajIsNMOi7FP1s10PlTKVFiFgPToLhs5oSsPlZSOORKgFsRUxrtVk4ho2cs+gfsvAHm0Mnjwb6syku9s0WOZvy3DXq3pWiNlDj4O62CmEcU7GZQud5fKSC2eOuVuMwnmmTG8flO4Y1qrUbyRYJiW68va17ho2Ti/xN14Ufn4GWMyNwrD4G8p5ouU2MdfBeO5Pfe2CyvFRDDgMndhxbLo/HwOV8UHywurdaIfITJTyXzleeS+O5mJmmqEVOmFHfqZfvgHQv3YLDKcg2fZlljYbA8Zc9D11I7yjiQyW1n17BqVsDY1es/pYudCmmV/n6YDMoe0MP3zQ/N7AZl1leD9m0D5gu5U7NEjFlRWcxz6s4yJHLf/LOLs/PR0JfDZ/9IRI5mZkqpgFJZu7s+Fg==
Received-SPF: pass client-ip=57.103.90.147; envelope-from=mads@ynddal.dk;
 helo=outbound.ci.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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


> On 3 Sep 2025, at 12.06, Philippe Mathieu-Daud=C3=A9 =
<philmd@linaro.org> wrote:
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> target/arm/hvf/hvf.c | 40 +++++++++++++++++++++-------------------
> 1 file changed, 21 insertions(+), 19 deletions(-)

It'd be nice with a commit message justifying the need for the change. I
assume performance?

Besides that:
Reviewed-by: Mads Ynddal <mads@ynddal.dk>=

