Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5B54606A337
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:36:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=C5U6NtxU
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWi4M-0005H3-94; Thu, 26 Nov 2026 17:35:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi4K-0005G6-Fc
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:35:56 -0500
Received: from ms-2002b-snip6-11.eps.apple.com ([2a01:b747:3002:204::15]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi4H-0007PW-1G
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:35:55 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 25C09180010E; Thu, 26 Nov 2026 22:35:50 +0000 (UTC)
X-ICL-RepId: 01a21a00-31bf-7cc6-84fc-0809406eb7c7
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795732551; x=1827268551;
 bh=xhgty6eqGmcEpNmsO7RwVgtegKJTs3yyndFkiNi/VHc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=C5U6NtxUdCQXRcI9geZy8vzjsn1qoyGca/6gtngwljqH9h43hAW0DjamA5eSrkniuMiSuP4aizfbVAn+ZuPFT0vo5y8ZQOpbtJBr148KnuuxOryTniym8gIKLxVuyqE+ADFwoHzOJ478WRNK+ll9nPxM9n9hKbnfZDH3lvUS6exV+paXmp6jh5BGcreOXk7s3HX9Sbl8gU9Kf3p2z3DdjBajnJBRiIxv2mjEy5EffZhFOtWrFErE1HJV0NMGdGA1jRJ2bMCN6KifvgTWY0OqC9brZvxNGxt4SemZPSkK+jX/lX7RvBwy3VN7KNQM5/Ojla/B5YZ7A2zPO4vkp3P9Uw==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 516CE1800129; Thu, 26 Nov 2026 22:35:48 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 2/3] accel/tcg: Factor icount_to_virtual_ns() out
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126222530.62175-3-philmd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:35:37 +0100
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <570C5409-93FE-4642-B343-5230A9C72CD2@unpredictable.fr>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
 <20261126222530.62175-3-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX+syDcMk+hAnU
 54qooB5S0TNjbgS9dz23i7m4xNQnbPNB2J8c3l+UhHc5ZWwSOWJUIamfNp454kqOyyZqNrypd66
 YGlvFsSCeAb8Iwb+mvIQ9uXDPZo7hXTBx75ALUREE1Rg+dNqaHorfsLNymJELWWsGp8YZDrQMTd
 vx1s5WD6EuwuWFt/aHiUAlpKgmpJ8Uy8te4nxGjCG9gQhphQfHdSgHiE6sohkrH21RyVhVryeFo
 E27FpBSo4yDDotF2tyAwo2zOs6f8SEVLcJDNPADyjBK786CcS4hY5V3Q5tI5DyVOSUur8x2nkeF
 t+3pNAg3XWLR7vCCpluBaVWFqfKP2KZjtUeWxLo0J3RrfDpml2AQ4eIVWkhGDw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX0MqXtZXpEaiv
 PeQDws4cju+RhzTnCPwQxubclz/kcNyo5B1IzKIghyQrAxbNAf2LJEAkgqgk4jr7aLpoirdGUuV
 7xytJ4LhWpXsLeLKtGmtQSg2Aols8UA=
X-Proofpoint-ORIG-GUID: h37LwJHfo1taFWDjpuNiSq_VYvQb_0FX
X-Proofpoint-GUID: h37LwJHfo1taFWDjpuNiSq_VYvQb_0FX
X-Authority-Info-Out: v=2.4 cv=QsvLTlyd c=1 sm=1 tr=0 ts=6b08b446
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=51JdnUhQRHFq8RItG6ly:22 a=H7SFQoNpLJNAuO5utOd4:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=1dvAypkPtfvtFV3HS8MA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABQz4ED4uoDVKyveeD98ZyjBUnI8/wRxOuwrntiOspQxZEcXoOI08ZtKv9OA5eb5
 bK4zmjEcPDPVh81VKZs7w/RMbWAkl9kaQgcghG68Ukf4idYJJEn6+SZf0wk7LiLYZ+wXwf
 6L6Wa0k33kuWJhNO9A522B8sEhddLw+dTWM6VeHVdlvYitwhtBIT502WARqzQfnbiZgl6W
 sGJ7xsaWSIkcUrISGvTbvqk5uUcNJGu98xUekBDAtNwYFnNFq6W2Y2NT4jU5hNPBnnVrkz
 AMI8wtLPH4BGAoAJuShv4CkFylhD4Tajmab/OzR5RnSqv82dFLAnMxseRFlGpfpTSFWCNz
 l6M1TeLQG7pJ6k6pVjw+OIKTtIOwVQ3L9Sln06XhsMyUE2ulpEjN4vnUZjZyEE4c/rqJ45
 4AJxZox+6eAwf2inUiCJF4gLhl9yWAg6z2wU71SQzsT1Fum1VE49hRVA8sEmTxdIAOdnI9
 jMN7qZ/s+zgA67OTuElVZNWf2a8fRemJOtxiOiVCa6n/mh3M2bFS/L2EMe2lULHdtb1JGj
 Uj8e/FTfOoXErElY+H0/2VXn40tflOcpr+YGFI97gDbYPW2Scu/1F85sKOt0NGoTRTlRuO
 SwVIxt7mhhRKTIeACgLzLETYBJ5KMQf2Q6gOdPJfauE/BH1svRTXouty34padGyVdI17Ea
 GZPA7D9k8Inv5THYqc5a5dFZpNNjZpXVKCHfXFIdLMy+fQq3pP162ccXjN/TARNrO+Ckvm
 K07mhuspNtc++YkeVaOHsI82raDe0A+d5X8nw0mY++k2hBefzXuOxdRcMKECjz6YFJaURd
 yObw5XAKKg==
Received-SPF: pass client-ip=2a01:b747:3002:204::15;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1



> On 26. Nov 2026, at 23:25, Philippe Mathieu-Daud=C3=A9 =
<philmd@oss.qualcomm.com> wrote:
>=20
> Extract the QEMU_CLOCK_VIRTUAL computation from icount_get_locked(),
> to reuse it in a following commit.
>=20
> No functional change.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>
> ---
> accel/tcg/icount-common.c | 9 +++++++--
> 1 file changed, 7 insertions(+), 2 deletions(-)
>=20
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index a11f2397489b..b52d22f3a1cf 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -119,6 +119,12 @@ static CPUState *icount_running_cpu(void)
>     return cpu;
> }
>=20
> +/* Convert @icount executed instructions to QEMU_CLOCK_VIRTUAL ns */
> +static int64_t icount_to_virtual_ns(int64_t icount)
> +{
> +    return qatomic_read(&timers_state.qemu_icount_bias) + =
icount_to_ns(icount);
> +}
> +
> static int64_t icount_get_raw_locked(void)
> {
>     CPUState *cpu =3D icount_running_cpu();
> @@ -133,8 +139,7 @@ static int64_t icount_get_raw_locked(void)
>=20
> static int64_t icount_get_locked(void)
> {
> -    int64_t icount =3D icount_get_raw_locked();
> -    return qatomic_read(&timers_state.qemu_icount_bias) + =
icount_to_ns(icount);
> +    return icount_to_virtual_ns(icount_get_raw_locked());
> }
>=20
> int64_t icount_get_raw(void)
> --=20
> 2.55.0
>=20
>=20


