Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01476606A321
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Nov 2026 14:37:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=unpredictable.fr header.i=@unpredictable.fr header.a=rsa-sha256 header.s=sig1 header.b=Szh3Pu+W
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xWE7V-0003ye-Rh; Wed, 25 Nov 2026 09:37:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWE7R-0003xY-KQ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:37:09 -0500
Received: from qs-2004i-snip6-1.eps.apple.com ([2a01:b747:3006:206::54]
 helo=outbound.qs.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mohamed@unpredictable.fr>)
 id 1xWE7N-0005o3-UQ
 for qemu-devel@nongnu.org; Wed, 25 Nov 2026 09:37:08 -0500
Received: from outbound.qs.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPS id
 271F730014B4; Wed, 25 Nov 2026 14:36:58 +0000 (UTC)
X-ICL-RepId: 01a21323-6dd0-7524-ad22-b9649eec0396
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=unpredictable.fr;
 s=sig1; t=1795617422; x=1827153422;
 bh=bKtuop1Ori5viHmdg0XdS3v5HtkQ90tUVK/pJmlZ+pI=;
 h=Content-Type:Mime-Version:Subject:From:Date:Message-Id:To:x-icloud-hme;
 b=Szh3Pu+Wk1eDzz6PR+uz4RFPpUJJa4L37JGem3DCiUx+8lSP6RQnrVD+ENM1I++adwEHYpM23cdIsuebj8Pr+J8ydzDGKUNHIMbwE2digINsBkeDsujqcX0YZ7XXSg29sk+X86MO/v0yEVTmjoDtFyPHPttIpbIfUuNNK45mrIEJVMIeMX6huGssI3/VKjE25DBOUJsW9zWbpRx/9xfgrgBUB5A9VOJoegW91YGAQgkfsOx0G3Ay2y1E3cLJck8vVwnBQXp6h6DJHFwCs+lCqM05SGvigkkAAG5rZkZQMNmzXbKGTojM0x2vCjwJ4Xa0aAdrRwCi915CtN0L3ASC1w==
mail-alias-created-date: 1752046281608
Received: from smtpclient.apple (unknown [17.57.155.37])
 by p00-icloudmta-asmtp-us-east-2d-10-percent-2 (Postfix) with ESMTPSA id
 EFDF830011B7; Wed, 25 Nov 2026 14:36:56 +0000 (UTC)
Content-Type: text/plain;
	charset=us-ascii
X-Archived-By: <archiver.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.200.71.1.16\))
Subject: Re: [PATCH] target/i386/mshv: set hypercall MSR runtime-unsafe
From: Mohamed Mediouni <mohamed@unpredictable.fr>
In-Reply-To: <20261125143211.51151-1-magnuskulke@linux.microsoft.com>
Date: Wed, 25 Nov 2026 15:36:44 +0100
Cc: qemu-devel@nongnu.org,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <dblanzeanu@linux.microsoft.com>,
 Wei Liu <wei.liu@kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Doru_Bl=C3=A2nzeanu?= <doru.blanzeanu@microsoft.com>,
 Wei Liu <liuwe@microsoft.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <E44BA68E-A9CE-43DF-B954-403B5F9CB900@unpredictable.fr>
References: <20261125143211.51151-1-magnuskulke@linux.microsoft.com>
To: Magnus Kulke <magnuskulke@linux.microsoft.com>
X-Mailer: Apple Mail (2.3901.200.71.1.16)
X-Authority-Info-Out: v=2.4 cv=Y7JtIReN c=1 sm=1 tr=0 ts=6b06f28c
 cx=c_apl:c_pps:t_out a=bsP7O+dXZ5uKcj+dsLqiMw==:117
 a=bsP7O+dXZ5uKcj+dsLqiMw==:17 a=kj9zAlcOel0A:10 a=zJRp6_cAMcgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Lz8lNifEoAKVmCoaIBl5:22 a=qoRLEZb8q2pKxhZBWFtH:22
 a=yMhMjlubAAAA:8 a=KKAkSRfTAAAA:8 a=ilBeI5KL0s2H7XRJ8O8A:9 a=CjuIK1q_8ugA:10
 a=cvBusfyB2V15izCimMoJ:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX3qKsblZ64DY8
 cb6jhskcw6SgkRk0xz/nAMWAdLBk8POJwAVrbEAyqt+QiRRwmHZtEio4uryG+rFTuJTTUgLEjwP
 1PvK4weTP2U6CvX7j+xWu1iFtN4PpNBQgKbA09HKwmjSjj9S7LxRWXnW0xznJgJRsyzbq10uM8l
 NYl//6YYz4mK3JZVZzcVT1gpq/SZ1E5B1gA6exJVwv5i1+yEBtZ1OP/5u5ZrcaMrDb2pcLBlT7j
 bhGBZysPD+FMAPJDrJcZq1BWUUjlHlpUD+wooVi9DNYE2pru6mt0sB2mLKsJUGUe0Zc7fvwZaCY
 /4avGnx2KVvJRHI5daKOvxVJc4oXw8TNgNV62RIxZtIF2y6wD8i/uPMqrk8kNw=
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTI1MDA1OCBTYWx0ZWRfX82j6yxZL+9FA
 AyIKNoT1zwJZ/EmiedvMRom/wmYDYPN4epuWeqqD1IxBDq/EtOfquU1x2bEBe1hvh/abXYJpm1z
 JnObvqxXhewICVEy/8Ka3SLxThMtgdw=
X-Proofpoint-ORIG-GUID: BPg1ws8iUDXygQ1PXLQoz_HaDy4JWN0Z
X-Proofpoint-GUID: BPg1ws8iUDXygQ1PXLQoz_HaDy4JWN0Z
X-JNJ: AAAAAAAB25e/b+uzUVsXYQmqHUXbHv8N3IUwJMMSffY9KrnDTpSv55cdJrX23/VzMR0WqD
 M+Lzm58/rOrboSW7DN3Zyniy2l0+J3ekHZzbYFlBKCVoCeyOdCd2jhPmu3lY4/lxCfxqRc
 exXunCfJ7lOoH0kbD1V/EtHhL8n3GKznuxKRv58aQYEHXa8lQx8XPDTVq8DmJAtvALX88q
 HUEjtaS/IK6nlVkRRjS0PsRAtsfecPTKJO3Y8QMI+y7NK6ZO4kesBqE8k+DwAYAVOAz7Dp
 BgWmfPMqH+8M5/gppRRC5MN5PL2bnyXes+1LQsj7zF+jt8nAJMZ6Btcbnz5gqmMCsGm1Pt
 HSTLrHMnUHHGIJcR/fTSzBuTL8cBIdXLc3ybYVw+41tqZL3JHnq12PYK8bS8n7FF2RH5xR
 +lPRU6ILBsKx4bWhoQYGr7jqiEkVrIC7wT3ZlLS1I3wcWhQv3ZeIPyUIBZk7qffLXxEp5m
 XI2Z7GI0N6nPxRua2RcUis3XyewRMNsgmRHuhEDsjAbEqYwF7AdCUUpFoHBsYaaRWejgQc
 y8xve6BNTJveb3YUPeinjRxuXpWvrr3mHifW9qdiTSdqvV/vAp5b2H8Cza2ynNxo6WctO0
 dXnow0KDFvJjVv+jd1Ni8pce1tR3uFeOHqD35+sV1OubFhkj9zfYJa4f417fCwm/NidCZx
 /vKGlUIdHYeT/iQH4I5s9bUkFsAkBh0vWZnvVAY0NJqQ6H7/ZSeB9HXAeTQhpj8zBD11Zk
 SmvY4F9DsdpNueFnOv/L/grHoy0SyqlNNJpChSNhjEr8vIkRwx7JMS+srgeVuujRx0mWC8
 g/t7jtfc6j/29ZhI/V/8RqX4DvcXZwb9VSPtzqFciDQYFm4iuosrtAbogrPwr1h02LIthe
 5UP6Wag24/TdAUJc5YMthKeJQxlFH5hEsGZSsfl6LirJPSCtboYCJOy9RbuFaOJDO4bz2g
 FsMcK5JNpX+69JeChJtv5MtOoqnXf3Zgy+1s5FsNEXfYY08vNSGDUrERsdE9HBC1fqtsGx
 7wCUgzXhdQEhVpxCcOODb7D9xpSRP7x02RVWcv6KgJB0vMOgsFiZsbbHXMSBCV/RJaC0Ld
 /QO9Vd5vq4b8806KsFPrlfucGTgag9f5RFNW3pWqb7lTuGM4uqFNDW/Tyapx7CvQh0aemC
 2QljoJfg0O565Bw10BEiqGh+KH1MbnPoV1koaAIjAecIglBI7cf32MLieN+UpYrYw0UfgT
 nmalVpUqrMeSgF5/5u8hVFio632GL6PKv9XUSy6ZJby7ifAMyK6NcA5QZDySRR0DuJjTTu
 7NxBZI0QAdqcewgELd9+5FjFibZVMwSj9pUSCDq7YswwU86yBY0957+FnEwUZRapf+EWvD
 GWqDhmQrdnEtg4XjLIIcjCABDsjs3vch2nztzX/y4iYkRp81+aPh8sqfLHnwKz6kqqSO8t
 1McZ86F0EPWCwKF/E/zHjUXAqCv5xk
Received-SPF: pass client-ip=2a01:b747:3006:206::54;
 envelope-from=mohamed@unpredictable.fr; helo=outbound.qs.icloud.com
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



> On 25. Nov 2026, at 15:32, Magnus Kulke =
<magnuskulke@linux.microsoft.com> wrote:
>=20
> Windows locks HV_X64_REGISTER_HYPERCALL after configuring it, so =
writing
> back even the same value will fail. Hence we mark it as not runtime =
safe,
> so e.g. an "info registers" command will not fail to writeback the =
MSRs.
>=20
> Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>

Reviewed-by: Mohamed Mediouni <mohamed.mediouni@linaro.org>
> ---
> target/i386/mshv/msr.c | 2 ++
> 1 file changed, 2 insertions(+)
>=20
> diff --git a/target/i386/mshv/msr.c b/target/i386/mshv/msr.c
> index a06844cc99..5696b7eb83 100644
> --- a/target/i386/mshv/msr.c
> +++ b/target/i386/mshv/msr.c
> @@ -332,6 +332,8 @@ static bool msr_is_runtime_safe(uint32_t name)
>      * while the guest's timer is not frozen.
>      */
>     case HV_X64_REGISTER_TSC:
> +    /* Once locked, the hypercall MSR rejects writes even w/ the same =
value */
> +    case HV_X64_REGISTER_HYPERCALL:
>         return false;
>     default:
>         return true;
> --=20
> 2.34.1
>=20
>=20


