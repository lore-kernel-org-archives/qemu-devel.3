Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AA0606A335
	for <qemu-devel@archiver.kernel.org>; Thu, 26 Nov 2026 22:36:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=lt/wa2y6
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWi4w-0005hf-A5; Thu, 26 Nov 2026 17:36:35 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi4t-0005gQ-GD
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:36:31 -0500
Received: from ms-2001i-snip6-11.eps.apple.com ([2a01:b747:3002:203::5b]
 helo=outbound.ms.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWi4s-0007Rh-04
 for qemu-devel@nongnu.org; Thu, 26 Nov 2026 17:36:31 -0500
Received: from outbound.ms.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPS id
 AC10D180010E; Thu, 26 Nov 2026 22:36:26 +0000 (UTC)
X-ICL-RepId: 01a21a00-c068-7b79-aaff-3dc6d50f5517
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795732589; x=1827268589;
 bh=si46+t3MXB0pUbqgfCu4lRNHiWNgsKCqOPQiOY3W/hc=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=lt/wa2y6Sf0H8hli+DBKgAhYqMx1vOrVcjAcohPEQMNCy+kksd3Kea81YvuyPlJGQWb3Os9rRxnuKEoOlpFWErhawblhY71ryHDhgfh5TMfACzm1idT2NN5dCMa7/UFTTtWnm8qPzBxKwYOKjHkn3a0K7vR54DklnAOrVRmIU1kid/Quo4Um+67gfTNQHKdpO9VImItjOFugOgNsOTrSbQFna9hYZhJQKgp7hrnu1asneLVxOKo2y1CXsVNvdjN+LuBqW036YPhhGVx3nLpWQA+cbfIAToqLcsjPsbOmvk0zsjIu2W6wpXupuqe4TqLK1NPDoB086+shVFUQ6vVhnA==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.156.208.39])
 by p00-icloudmta-asmtp-us-west-3a-60-percent-0 (Postfix) with ESMTPSA id
 B893218000A4; Thu, 26 Nov 2026 22:36:24 +0000 (UTC)
Content-Type: text/plain;
	charset=utf-8
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH 1/3] accel/tcg: Factor icount_running_cpu() out
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261126222530.62175-2-philmd@oss.qualcomm.com>
Date: Thu, 26 Nov 2026 23:36:14 +0100
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-riscv@nongnu.org, TANG Tiancheng <lyndra@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <9491AA01-4CF7-41F2-A97C-2D494568EF36@unpredictable.fr>
References: <20261126222530.62175-1-philmd@oss.qualcomm.com>
 <20261126222530.62175-2-philmd@oss.qualcomm.com>
To: =?utf-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX7/NxSIcL98vJ
 cKwVEWRopADSvC3/eM5/H+VlJFUntanu4panuw3WU/FO9g1YoqdZNvNdeGw0QZ0A8fB/95gTyhR
 2GF1FYB/uCAwReKnCNAbjzyhjha+rPP4eScXGOPwWj3z58kgL9p4JYTMQpXE4QQoCd8R8DJmPYz
 XV4CfU46g4q0mMIikof9f9MPNLpgHzSo80LFHpfXs4ConeTTdJP3aG+5IaNB9IFrCSccJla8Bk4
 OwCrrQHWmjIjvvmMH0YbC8oQXYPdohzJa0oPyhWVxlYWBRzPoJ2mdYI2SoGT0YYlkSb9LIKxf7W
 eKJzFiciVsKsXblEQ67htZ6EFvRpgk6H7cmCyb6441pUtuzJYgw7M659rOileg=
X-Proofpoint-GUID: Ha7puIfJb9B36Qh8ICgFtwLgiZKTB4Ck
X-Proofpoint-ORIG-GUID: Ha7puIfJb9B36Qh8ICgFtwLgiZKTB4Ck
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI2MDA4OSBTYWx0ZWRfX0aVHYJGCwf9Z
 ATYdbKYC87hlUgdxvV6xulyaIqzXTB4J0puVJngmn+W9dyVaA448HDmu+Kn29iR2xHXPtaFnzw/
 cLFpi2dg7GS9HkNkclYp7+BR9hrN8pU=
X-Authority-Info-Out: v=2.4 cv=XZAcX455 c=1 sm=1 tr=0 ts=6b08b46b
 cx=c_apl:c_pps:t_out a=kRaGL2Q7qLiahLf3O6OaIA==:117
 a=kRaGL2Q7qLiahLf3O6OaIA==:17 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=wbbCu9YnSpm8ZdSLOl1R:22 a=_mclknXjrhVi08tC7Eh6:22
 a=EUspDBNiAAAA:8 a=KKAkSRfTAAAA:8 a=1dvAypkPtfvtFV3HS8MA:9 a=QEXdDO2ut3YA:10
 a=cvBusfyB2V15izCimMoJ:22
X-JNJ: AAAAAAABy5uRbtx0BBkoYvuFH27LmmeJ4tVlX4RW/FbfmuiN9wUmIv99o+KAVta+yLj7fM
 ma7/BdFk+dX7ng7kqnMmZ9ngln/hxYAdpAWuEdq+jvjZHAisl5OSbN7yD8xufi5jDeRt7Z
 4NYJEb2IH0LOkdC5CN5sFoHTDhrmoPqJTZGxCoAyYJGvfLs/5fxoXPlPcVM8MpWGx2/pEP
 R0syy1DvrfHO7eTpIGzPxHhDY+hmC3GDxMIPc4XUAAgrb13HxnS1KuAcEkQXo3WUSzepi4
 8wC2hxk/nNFG/4mLMluu8eUu+UA/2Dc7Z8R5J/MZcH905QmNjCvvMiiL95dWe37fLi2AoZ
 DBNdcEjz4UsMPJU5/Vo9FLqzD8c92DAqrGzDKZ5x8LRFBEFmxw5rhKhIZOhJW8Cn+dufL8
 G18MCLq/T6Odr0piO/KKxYnflVBBogrpXSjyeyT/OZRL+kB8sQqSkJunVsQNR+um7eFCcp
 LhIFO/t673chk6T+CmjrVdKqeOOwDFjZovF/4AEpngzU7YZ0i5VkpFhSY/oJBlboSt1nAn
 J7kVPfCJsBdWTykBFGcWuAGP42undfUE/5MUJx/qkjNBemgm0WlK2p+BFhl6kNpuoeQ62W
 Rbc1LWm4TPeUF6mfptMPXK3lg+U+KUBzjhOhyq2UhejlM9CfLcFeh8ih+/VimlSvn9axde
 UnFKToIhLZxp7GLNC1A7YUBVn8lpjFAyA8vyyox7aB+NcK0SiA6FbUfF4i+FFdN35fbgO+
 yglkTmmQvooHDbUYXietuHSum52vkaQCnfFBRGaSDr/vE2CYdR6x8YYTERrMDy+nQ20CP6
 1zJSm10=
Received-SPF: pass client-ip=2a01:b747:3002:203::5b;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.ms.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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
> Extract the running vCPU check from icount_get_raw_locked(),
> to reuse it in a following commit.
>=20
> No functional change.
>=20
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>

> ---
> accel/tcg/icount-common.c | 23 +++++++++++++++++------
> 1 file changed, 17 insertions(+), 6 deletions(-)
>=20
> diff --git a/accel/tcg/icount-common.c b/accel/tcg/icount-common.c
> index b1b6c005fe71..a11f2397489b 100644
> --- a/accel/tcg/icount-common.c
> +++ b/accel/tcg/icount-common.c
> @@ -104,15 +104,26 @@ void icount_update(CPUState *cpu)
>                          &timers_state.vm_clock_lock);
> }
>=20
> -static int64_t icount_get_raw_locked(void)
> +/* Return the running vCPU of this thread, if any, checking it may do =
I/O */
> +static CPUState *icount_running_cpu(void)
> {
>     CPUState *cpu =3D current_cpu;
>=20
> -    if (cpu && cpu->running) {
> -        if (!cpu->neg.can_do_io) {
> -            error_report("Bad icount read");
> -            exit(1);
> -        }
> +    if (!cpu || !cpu->running) {
> +        return NULL;
> +    }
> +    if (!cpu->neg.can_do_io) {
> +        error_report("Bad icount read");
> +        exit(1);
> +    }
> +    return cpu;
> +}
> +
> +static int64_t icount_get_raw_locked(void)
> +{
> +    CPUState *cpu =3D icount_running_cpu();
> +
> +    if (cpu) {
>         /* Take into account what has run */
>         icount_update_locked(cpu);
>     }
> --=20
> 2.55.0
>=20
>=20


