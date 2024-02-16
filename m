Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C551C48260
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Feb 2024 06:03:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rarJ9-0004P7-0P; Fri, 16 Feb 2024 01:02:47 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rarIx-0004Oh-PK
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:02:36 -0500
Received: from mout.gmx.net ([212.227.17.21])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1rarIu-0003Ro-1w
 for qemu-devel@nongnu.org; Fri, 16 Feb 2024 01:02:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.de; s=s31663417;
 t=1708063334; x=1708668134; i=deller@gmx.de;
 bh=Bg6N6tFmypX/tz+PSALX8PsXjdS6sXfyYawKdcPmKDw=;
 h=X-UI-Sender-Class:Date:Subject:To:Cc:References:From:
 In-Reply-To;
 b=NFAGgnd4x2sgLKEdcLwCKFuAzuMwu3yltG4f0axSxpbzwXyFiGaSDT93oi5BWGaC
 Mrac/XIheDPcBumQY+RNVF928jVq7Nu/8NveunwD9hbmnPAGyHmoQNJUkNfP2+zjT
 K5KYxy3EJctG8ns6QJPb5h8el46ofu/HLFStwn1bS+d6CvfzVYvkuBiukg/SIh99B
 aPOkLL4LyJ/QDBrGk2tJGCrqG5gO4t0E72U/OB78TpkBL+WD4B4NGgGM1OtcRs3ZA
 69zft9lB7QBXrtbG2+arJkaLsIokQMThJiKkwVjXjhHEGCSJvddSpCNWbiS3ryujB
 uYBDNF4NuPNC3jdyrA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.55] ([94.134.148.214]) by mail.gmx.net (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1Mof9F-1rCjt91q3t-00p7zA; Fri, 16
 Feb 2024 07:02:14 +0100
Message-ID: <649d9876-52db-4b73-8316-f6067e0a75e3@gmx.de>
Date: Fri, 16 Feb 2024 07:54:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] target: hppa: Fix unaligned double word accesses for
 hppa64
Content-Language: en-US
To: Charlie Jenkins <charlie@rivosinc.com>, Guenter Roeck <linux@roeck-us.net>
Cc: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20240216053415.2163286-1-linux@roeck-us.net>
 <Zc75oNNSPx5n2ODr@ghost>
From: Helge Deller <deller@gmx.de>
Autocrypt: addr=deller@gmx.de; keydata=
 xsFNBF3Ia3MBEAD3nmWzMgQByYAWnb9cNqspnkb2GLVKzhoH2QD4eRpyDLA/3smlClbeKkWT
 HLnjgkbPFDmcmCz5V0Wv1mKYRClAHPCIBIJgyICqqUZo2qGmKstUx3pFAiztlXBANpRECgwJ
 r+8w6mkccOM9GhoPU0vMaD/UVJcJQzvrxVHO8EHS36aUkjKd6cOpdVbCt3qx8cEhCmaFEO6u
 CL+k5AZQoABbFQEBocZE1/lSYzaHkcHrjn4cQjc3CffXnUVYwlo8EYOtAHgMDC39s9a7S90L
 69l6G73lYBD/Br5lnDPlG6dKfGFZZpQ1h8/x+Qz366Ojfq9MuuRJg7ZQpe6foiOtqwKym/zV
 dVvSdOOc5sHSpfwu5+BVAAyBd6hw4NddlAQUjHSRs3zJ9OfrEx2d3mIfXZ7+pMhZ7qX0Axlq
 Lq+B5cfLpzkPAgKn11tfXFxP+hcPHIts0bnDz4EEp+HraW+oRCH2m57Y9zhcJTOJaLw4YpTY
 GRUlF076vZ2Hz/xMEvIJddRGId7UXZgH9a32NDf+BUjWEZvFt1wFSW1r7zb7oGCwZMy2LI/G
 aHQv/N0NeFMd28z+deyxd0k1CGefHJuJcOJDVtcE1rGQ43aDhWSpXvXKDj42vFD2We6uIo9D
 1VNre2+uAxFzqqf026H6cH8hin9Vnx7p3uq3Dka/Y/qmRFnKVQARAQABzRxIZWxnZSBEZWxs
 ZXIgPGRlbGxlckBnbXguZGU+wsGRBBMBCAA7AhsDBQsJCAcCBhUKCQgLAgQWAgMBAh4BAheA
 FiEERUSCKCzZENvvPSX4Pl89BKeiRgMFAl3J1zsCGQEACgkQPl89BKeiRgNK7xAAg6kJTPje
 uBm9PJTUxXaoaLJFXbYdSPfXhqX/BI9Xi2VzhwC2nSmizdFbeobQBTtRIz5LPhjk95t11q0s
 uP5htzNISPpwxiYZGKrNnXfcPlziI2bUtlz4ke34cLK6MIl1kbS0/kJBxhiXyvyTWk2JmkMi
 REjR84lCMAoJd1OM9XGFOg94BT5aLlEKFcld9qj7B4UFpma8RbRUpUWdo0omAEgrnhaKJwV8
 qt0ULaF/kyP5qbI8iA2PAvIjq73dA4LNKdMFPG7Rw8yITQ1Vi0DlDgDT2RLvKxEQC0o3C6O4
 iQq7qamsThLK0JSDRdLDnq6Phv+Yahd7sDMYuk3gIdoyczRkXzncWAYq7XTWl7nZYBVXG1D8
 gkdclsnHzEKpTQIzn/rGyZshsjL4pxVUIpw/vdfx8oNRLKj7iduf11g2kFP71e9v2PP94ik3
 Xi9oszP+fP770J0B8QM8w745BrcQm41SsILjArK+5mMHrYhM4ZFN7aipK3UXDNs3vjN+t0zi
 qErzlrxXtsX4J6nqjs/mF9frVkpv7OTAzj7pjFHv0Bu8pRm4AyW6Y5/H6jOup6nkJdP/AFDu
 5ImdlA0jhr3iLk9s9WnjBUHyMYu+HD7qR3yhX6uWxg2oB2FWVMRLXbPEt2hRGq09rVQS7DBy
 dbZgPwou7pD8MTfQhGmDJFKm2jvOwU0EXchrcwEQAOsDQjdtPeaRt8EP2pc8tG+g9eiiX9Sh
 rX87SLSeKF6uHpEJ3VbhafIU6A7hy7RcIJnQz0hEUdXjH774B8YD3JKnAtfAyuIU2/rOGa/v
 UN4BY6U6TVIOv9piVQByBthGQh4YHhePSKtPzK9Pv/6rd8H3IWnJK/dXiUDQllkedrENXrZp
 eLUjhyp94ooo9XqRl44YqlsrSUh+BzW7wqwfmu26UjmAzIZYVCPCq5IjD96QrhLf6naY6En3
 ++tqCAWPkqKvWfRdXPOz4GK08uhcBp3jZHTVkcbo5qahVpv8Y8mzOvSIAxnIjb+cklVxjyY9
 dVlrhfKiK5L+zA2fWUreVBqLs1SjfHm5OGuQ2qqzVcMYJGH/uisJn22VXB1c48yYyGv2HUN5
 lC1JHQUV9734I5cczA2Gfo27nTHy3zANj4hy+s/q1adzvn7hMokU7OehwKrNXafFfwWVK3OG
 1dSjWtgIv5KJi1XZk5TV6JlPZSqj4D8pUwIx3KSp0cD7xTEZATRfc47Yc+cyKcXG034tNEAc
 xZNTR1kMi9njdxc1wzM9T6pspTtA0vuD3ee94Dg+nDrH1As24uwfFLguiILPzpl0kLaPYYgB
 wumlL2nGcB6RVRRFMiAS5uOTEk+sJ/tRiQwO3K8vmaECaNJRfJC7weH+jww1Dzo0f1TP6rUa
 fTBRABEBAAHCwXYEGAEIACAWIQRFRIIoLNkQ2+89Jfg+Xz0Ep6JGAwUCXchrcwIbDAAKCRA+
 Xz0Ep6JGAxtdEAC54NQMBwjUNqBNCMsh6WrwQwbg9tkJw718QHPw43gKFSxFIYzdBzD/YMPH
 l+2fFiefvmI4uNDjlyCITGSM+T6b8cA7YAKvZhzJyJSS7pRzsIKGjhk7zADL1+PJei9p9idy
 RbmFKo0dAL+ac0t/EZULHGPuIiavWLgwYLVoUEBwz86ZtEtVmDmEsj8ryWw75ZIarNDhV74s
 BdM2ffUJk3+vWe25BPcJiaZkTuFt+xt2CdbvpZv3IPrEkp9GAKof2hHdFCRKMtgxBo8Kao6p
 Ws/Vv68FusAi94ySuZT3fp1xGWWf5+1jX4ylC//w0Rj85QihTpA2MylORUNFvH0MRJx4mlFk
 XN6G+5jIIJhG46LUucQ28+VyEDNcGL3tarnkw8ngEhAbnvMJ2RTx8vGh7PssKaGzAUmNNZiG
 MB4mPKqvDZ02j1wp7vthQcOEg08z1+XHXb8ZZKST7yTVa5P89JymGE8CBGdQaAXnqYK3/yWf
 FwRDcGV6nxanxZGKEkSHHOm8jHwvQWvPP73pvuPBEPtKGLzbgd7OOcGZWtq2hNC6cRtsRdDx
 4TAGMCz4j238m+2mdbdhRh3iBnWT5yPFfnv/2IjFAk+sdix1Mrr+LIDF++kiekeq0yUpDdc4
 ExBy2xf6dd+tuFFBp3/VDN4U0UfG4QJ2fg19zE5Z8dS4jGIbLg==
In-Reply-To: <Zc75oNNSPx5n2ODr@ghost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:h/buh9lLAP9RSXwYl2+rs7d1ZZco1mv/fH1yKtJ1xUnmYJMMmB+
 KZMcpzyOlhon7FiG9PVeua+1ofIDQJcXql/zUfIfGWxsnuNsP6a/+O3woGvtPuP74+GVUUI
 WQzRzgwiLnbo24a3HfT9HI/S6F4vJmzycRQ6sRj1zdhCnT5x5/BFUbgHxcH60ikQF41i/MZ
 SqlQPooQDr9gZuDgAdymw==
UI-OutboundReport: notjunk:1;M01:P0:37e8T6hLZho=;Tuhz6VQfV5obLErJoyzxzCaoCj9
 D2oiD/hcQNNOT4rMjl8vcku/rGDcGuLn5pgqwemtcXRvHDHCdkbpEKmtqschRm9hVfe4xPjDC
 ydOXmSToOUAjcCLqscGY1SyxZVZqP1YJG4lme6QofgenrcFqgcMDHfZ9Ahn++hnOuhMX9PowA
 pYjxFlCfVF6H9V/XBoeNxMcIKQnwe3A2562rWTCcmO9EFWF//fAgpHCuDj/sOyhY+pnaQFN8R
 /Namwou9VeslRbGlU4wb3gid/pra3tjmDK6XZ5DaKlXUaGok3pgrdigRSZMq17CAriv7GfX7H
 4rC/Xfzxny5M+MnqKCoTi/BRcLyt4EGQx894uS+Ra5lc2jonn8JPRZbocoqR5uZC4mc/wyXR1
 /WaSpTce6yOmWdP7WwnHUQjTcsz6kuYn8EuboRR5aAfrt7iji6p2GhXQqc+iPHT4LYwXgPwlj
 lPmwCnvps5D9FK38kvqylXxsKthW1Zz5J5Zf+d4aLQBDyCFIMBA0kGDf7Aebqc9j9khNIoCSc
 LW4ZtzdckInafr0IcybeRIC2gdhGuyHlJxhFuB/JhJxFQFANXlFvoOz0/WNehREIRxtuuvv72
 P079ugF8YiqUetDaoVIKSOQvlO8PlVs4/9BIYzc7F4Botfm15WAGjSyOE2Ukek8n2Bcqd5uHv
 MgILl2UhA5TAYqpWVDrCLxZUdfkHJ28MJ1jfPI399HSU3mIgfn21zbSHTrvFDDGqPiS+bzVXP
 JF2zsTRP/3TU+rPwW/HWTakUT5CuyQg1jRIwHUTIRT2Cr4TXUYdbLpvQJdmQ6Z8S9SELU3GAM
 VetIgqnPu3Q0CC1nuWW6WrGMirqkBnPME53PshBXK2iCU=
Received-SPF: pass client-ip=212.227.17.21; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

On 2/16/24 06:58, Charlie Jenkins wrote:
> On Thu, Feb 15, 2024 at 09:34:15PM -0800, Guenter Roeck wrote:
>> Unaligned 64-bit accesses were found in Linux to clobber carry bits,
>> resulting in bad results if an arithmetic operation involving a
>> carry bit was executed after an unaligned 64-bit operation.
>>
>> hppa 2.0 defines additional carry bits in PSW register bits 32..39.
>> When restoring PSW after executing an unaligned instruction trap,
>> those bits were not cleared and ended up to be active all the time.
>> Clearing bit 32..39 in psw prior to restoring it solves the problem.
>>
>> Fixes: 931adff31478 ("target/hppa: Update cpu_hppa_get/put_psw for hppa=
64")
>> Cc: Richard Henderson <richard.henderson@linaro.org>
>> Cc: Charlie Jenkins <charlie@rivosinc.com>
>> Cc: Helge Deller <deller@gmx.de>
>> Signed-off-by: Guenter Roeck <linux@roeck-us.net>
>> ---
>>   target/hppa/helper.c | 7 ++++++-
>>   1 file changed, 6 insertions(+), 1 deletion(-)
>>
>> diff --git a/target/hppa/helper.c b/target/hppa/helper.c
>> index 859644c47a..7b798d1227 100644
>> --- a/target/hppa/helper.c
>> +++ b/target/hppa/helper.c
>> @@ -76,7 +76,12 @@ void cpu_hppa_put_psw(CPUHPPAState *env, target_ulon=
g psw)
>>       }
>>       psw &=3D ~reserved;
>>
>> -    env->psw =3D psw & ~(PSW_N | PSW_V | PSW_CB);
>> +    if (hppa_is_pa20(env)) {
>> +        env->psw =3D psw & ~(PSW_N | PSW_V | PSW_CB | 0xff00000000ull)=
;
>
> I thought there was something fishy in this function but was slow on the
> uptake...
>
> How about defining a new macro (PSW_CB_HIGH) to hold this value?

...and avoid the hppa_is_pa20() by using PSW_CB_HIGH unconditionally
on 32-bit too (which then gets optimized-out by the compiler).

Nice catch btw!
I wonder if this finally fixes 64-bit Linux kernels on qemu-hppa20....?

Helge

> - Charlie
>
>> +    } else {
>> +        env->psw =3D psw & ~(PSW_N | PSW_V | PSW_CB);
>> +    }
>> +
>>       env->psw_n =3D (psw / PSW_N) & 1;
>>       env->psw_v =3D -((psw / PSW_V) & 1);
>>
>> --
>> 2.39.2
>>


