Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1908E77188
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Dec 2024 21:30:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tSNLM-0005bX-Ph; Mon, 30 Dec 2024 16:30:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tSNLH-0005au-RV
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 16:30:31 -0500
Received: from mout.gmx.net ([212.227.15.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <deller@gmx.de>) id 1tSNLD-0006xb-I6
 for qemu-devel@nongnu.org; Mon, 30 Dec 2024 16:30:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmx.de;
 s=s31663417; t=1735594219; x=1736199019; i=deller@gmx.de;
 bh=v5p3Hn2vr4wHRGeWprexOQlQgq8CZ+fMqVamVO83L5c=;
 h=X-UI-Sender-Class:Message-ID:Date:MIME-Version:Subject:To:Cc:
 References:From:In-Reply-To:Content-Type:
 Content-Transfer-Encoding:cc:content-transfer-encoding:
 content-type:date:from:message-id:mime-version:reply-to:subject:
 to;
 b=oxRZTOCV5/Osf8N+ma4C/F0Xysive925Xf1aL77PaXPHClFRAqgCqV3A03C6FVdy
 YLOXtbJP8B7IalGHd+dtDG5Z/3IaE+inr+PFERTcRUkYSEKlleS0sAH+9UISmb4jt
 EDiplarOp6V54s9fDoIlN85+yWghwZIYhfCLL+U+tgEqTkmgtsS6w7Dl28j2ZOpUu
 AqWaNafyMRdZ3CX+Ci/kbgHoX5dgi2s+h0RsnkHr9VMdsStlQODuVG+7kUkEtMGKq
 raLXjjEivSyfYW5VjjiANEcvO68l08PaalD2ufEqy6MYv1xYNBvr5uYWpF239XKES
 VDrGH7D/dW390a++3Q==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [192.168.20.172] ([109.250.63.155]) by mail.gmx.net (mrgmx004
 [212.227.17.190]) with ESMTPSA (Nemesis) id 1MMobO-1tBwv115HQ-00JdvY; Mon, 30
 Dec 2024 22:30:19 +0100
Message-ID: <3cc7d9a4-8153-4f40-8b84-142ba455913e@gmx.de>
Date: Mon, 30 Dec 2024 22:30:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/5] hppa CPU reset and speedup
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>
References: <20241230152519.86291-1-philmd@linaro.org>
 <32a4d72c-6cc2-4c33-876d-ddf66b71fab4@gmx.de>
 <6db51529-4754-49dc-8af5-2b40019ed30e@linaro.org>
Content-Language: en-US
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
In-Reply-To: <6db51529-4754-49dc-8af5-2b40019ed30e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:RVHMtcWxuMRQ5GXFoSrsUhjzdxcNakmDT5xJdSe8vxooh/R2kRi
 m+DdXOmsDhPnAgvUdTCzlrCurO+mFYordQD5kDsSNwmlLftskN1qV6WftwzI1gYCNeB0kSD
 r3XzeDkhutzKu+OUumf3jn16pAbDLF1osgh6dEqaBDIssZ/yHoA1aqA2w85uS8XLYy2F/3f
 wWwEN47X1iw/HtjAZjqdg==
UI-OutboundReport: notjunk:1;M01:P0:TykvgEeFp/I=;iy/O/oljUc/VplXp7BdtKE7VRRx
 03PvK9z97tO4ialSaySj5mhUpieDVVVYZiC/PK4ShHC1HLmtnBMzdYUnAGwMkYgdvu/5twqwX
 V89fGW5/i0TzWqcSBrdKdUT/Qgv6yVaJqgg3LYX0AwXRmkw3P7B49O6J9nut0cdfJoOSqQKxK
 XkdkSx2qQmOBZ+7nliO+tPGbduIuZb40lKAdW8IJ6s0km7OYwebhMkC6u2phhsgQbIDIh1fZn
 YSaMJNpPnJy+6Y2qj1IGpGB2blQQdY9kVFLX0l2CIw7yKFL5DchNaDG3wZK9yIHfpADVWEd2s
 6Q+FMiYO/wRilI6qQ4A8YARHTHlP2vuKJrQWFOL1uS2BFflpv8llLcxqRAEfVyxO8CNSC4XQc
 AlQNMIVVwqNsHtWl1zx7ifoxJvRUJ5fbhcvIvczUpAqS+QBac7vi5RQbsZqoS2dhSWfOI9gHp
 93VYXQejtI2EFkHzLHSNVeRwnrbhbO5etkuc/uJ9eTAai5u4H77MQzJZdGfotYB+T61x1Z5i4
 vcfvGMn6geT6kLHx7jkqSVs2l4WhUxUET8ycyuYkn6H58kWIJdvIz9cAATBZ+v1kz379X9uZ4
 +seRBol56jRoJQvptWnliYJRNFoOIC5K5uj+aXQfoCMvy5y7e0BalvS04I5ncg/qgDwH8Ki0W
 8CthhklaSs4zKbaapV00fR/tTDWVLNq/SR/Wk8ix+uRqHYCe1hmah5o+JnD6jNs4R/SzAZ6Jc
 RYqbpSwNVNSJemtb8/2diZ6lhXYeiKlsTGDWV/F4P2FfDPRgtZ53gYe2ODWMuO/sJ0ZPb51BU
 OmVBUrXRuLWUVr8F1292oXqKhpwJFwNX3iIu51TeF8kfakTgWJgASykCcJlWTrO7bzTRl6H4a
 UldGBwBEasaW4w3Gc2wSQ8ttnIj48NZUoJDK+SKK7E1MhZ9eWa1B8lPVroShCxUgSZbwXsvTy
 YZpwh+dVrXsXO2x9OH8GgU96stFtx1YLH/5bkRqMIVWrVwQtigRTpKJgKJZtPJqMnILBVql5r
 HLaS3bJCEiZPC2CXLsCCh+uzBkztAegXZkO9lHpICV10ZW3MPJNRg8xwrpqEYVKv5gEg6GOn7
 jdN0W2CwIWVDZHTll1R/wYrTvlX/7m
Received-SPF: pass client-ip=212.227.15.19; envelope-from=deller@gmx.de;
 helo=mout.gmx.net
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-0.001,
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

On 12/30/24 21:47, Philippe Mathieu-Daud=C3=A9 wrote:
> On 30/12/24 21:24, Helge Deller wrote:
>> Hi Philippe,
>>
>> On 12/30/24 16:25, Philippe Mathieu-Daud=C3=A9 wrote:
>>> Respin of:
>>> https://lore.kernel.org/qemu-devel/20241229234154.32250-1- deller@kern=
el.org/
>>> "Add CPU reset function and speed up runtime and translation."
>>>
>>> - Remove hppa_cpu_init()
>>
>> Thanks for picking up my patches and integrating them properly
>> with the reset code.
>
>
>>> - Reset PSW using M bit (untested)
>>
>> We haven't implemented PSW-M support and the first
>> thing the firmware does is to reprogram PSW.
>> So, basically it's not needed.
>
> Good to know it isn't needed yet (I grepped and noticed
> very few uses). Are you OK with the patch as is (as it
> matches the spec)?

At least I don't have any objections as long as 32- and 64-bit
CPUs still boot.

Will you respin the series, then I can test and review?

Helge

