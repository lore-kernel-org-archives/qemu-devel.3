Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A0DC369DC
	for <qemu-devel@archiver.kernel.org>; Sun,  4 May 2025 16:19:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBc32-0005Lr-AV; Sun, 04 May 2025 12:18:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc31-0005Lb-75
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:18:35 -0400
Received: from mail-pj1-x102b.google.com ([2607:f8b0:4864:20::102b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1uBc2z-00078V-DD
 for qemu-devel@nongnu.org; Sun, 04 May 2025 12:18:34 -0400
Received: by mail-pj1-x102b.google.com with SMTP id
 98e67ed59e1d1-30332dfc820so4324270a91.2
 for <qemu-devel@nongnu.org>; Sun, 04 May 2025 09:18:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746375512; x=1746980312; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=GVgHVjCZAzrnk6Yz+gPuLZDT9JxPN58KFxsJBrzHsuY=;
 b=OjaHIv0gvcaWoFUqNsHd3gGnIjjkJPTIQmx6Ecn6I1ybt8StHhWPjNERKMiIlsI0Zj
 VRucNAE4ppNHMBLp07L8THUnK2Hr4SFfpMHsSWVY8UQGh8Qv1nj8AgErIKRVcrd5WdRG
 aZ4B9DPuZvufwJp5a496lngkoPg/YdYWrmVOnkv93UHZbl3EX4qYFG0Ut9eOpcTDAmLD
 g+GdyGob31eOw1Y94GC6Io3lqECFac3uypPD2Ihp5AeEpHdCya/IkxXzbuquoYxZ3Dlu
 FaOj6N2ay9k7mUaDZUivNdXordxXzPzKRz0I0aOXzSomeSnXF+Tjuzrcbpk6LFKNNeiM
 1W/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746375512; x=1746980312;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=GVgHVjCZAzrnk6Yz+gPuLZDT9JxPN58KFxsJBrzHsuY=;
 b=UGjxkI/VO7hKOKJKhovTqDH3XbJqYi8rYbHyX8Y/6gFLwnAUHO6QjaW7xuqNu6Pp51
 JAsh7WN5Ul9S07/AkdPkYm9GbYkMXJ3OesiqIgoYc0IzdC3z61mMGDkTjjHhgvLahiZA
 AGadstL4KycNMdF2QTHEjQwB/J0Vq1qu2EYtYU8ApB7z89aiqXCBKus/XnVoApbDp5Ye
 P2clQQKOkYjvEqr2qGNKbCxmp7tejd5DBkCRfZU/mUYwBha7r0o2GlwlF0I/qnvPVrZ0
 FiSXRFo8rsahgiEyrobeEiTUbjb0wGHTlIzKeCPSooMzA6kP5NYwYFUz2nqYWY8b0Mwa
 Ijow==
X-Forwarded-Encrypted: i=1;
 AJvYcCVpmkKRzOLDWA4ELHD2ah6ZewaQTFuGLX1FD4p/dMeShWmKRZlrOU4m1G3KV7HXUnTjSKvShu0JpvSE@nongnu.org
X-Gm-Message-State: AOJu0YyF1ZC4oKUxkYUMvPW7n2HETi7Eu9SpKOMskc54neVuACbAac3N
 RYAZj0z9eRsuKmM3+XYsvayAEDWSAlNvV3xpyOMFlqRn5feWoxbo9DvRvqbvxmA=
X-Gm-Gg: ASbGnctSLwi3M1Nzsoj4i4/HJi/sLhQyJSFz1RCgpWNKYjNCt2o5/9vP6qTxp/3Le4f
 qpm+RjoDLoyITcJrUe2kNbSNyeEunDqPWQ7//LOlRoPZV/Bvt6XkoKQTYjVRpkLG4PiLFq/k2SN
 UDh5x/Dzu9qrrD7E3TNZzf+/1+kViGM6S5Vk+rGnTcJ1y1wfMeskE93RpYWs0v4LWmzeLiloRXH
 Krn3c66Q9Yq0LuVxGf/2TtsR4/Q0jDNqCzQ9sh4b/sAgsQWwuGpbxmnokA77D3oebESjFI8FbpD
 xb4NH3d1q9Dj62EXybxyd11MAIUT5Eb5NIwwR0WAURMNXSwvA00OMhulj3/KG5Uu3CUzm4NJjCe
 yNAX7z7U=
X-Google-Smtp-Source: AGHT+IFDVehLEijp7OUzeIAXqkg+5iC8+kDb1Uvyac3I7ayEa8psrutgXlbFuIS85v5QsmgH3zDmYw==
X-Received: by 2002:a17:90b:3d45:b0:305:5f33:980f with SMTP id
 98e67ed59e1d1-30a5aeb69f2mr9376272a91.27.1746375511926; 
 Sun, 04 May 2025 09:18:31 -0700 (PDT)
Received: from [192.168.0.4] (71-212-47-143.tukw.qwest.net. [71.212.47.143])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-30a263f4324sm7897339a91.1.2025.05.04.09.18.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 04 May 2025 09:18:31 -0700 (PDT)
Message-ID: <a50b2d4e-011d-447a-ad15-6165598a865f@linaro.org>
Date: Sun, 4 May 2025 09:18:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 32/40] target/arm/ptw: replace TARGET_AARCH64 by
 CONFIG_ATOMIC64 from arm_casq_ptw
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, anjo@rev.ng,
 kvm@vger.kernel.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 alex.bennee@linaro.org
References: <20250504052914.3525365-1-pierrick.bouvier@linaro.org>
 <20250504052914.3525365-33-pierrick.bouvier@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <20250504052914.3525365-33-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102b;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 5/3/25 22:29, Pierrick Bouvier wrote:
> This function needs 64 bit compare exchange, so we hide implementation
> for hosts not supporting it (some 32 bit target, which don't run 64 bit
> guests anyway).
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/ptw.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index 424d1b54275..f3e5226bac5 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -737,7 +737,7 @@ static uint64_t arm_casq_ptw(CPUARMState *env, uint64_t old_val,
>                                uint64_t new_val, S1Translate *ptw,
>                                ARMMMUFaultInfo *fi)
>   {
> -#if defined(TARGET_AARCH64) && defined(CONFIG_TCG)
> +#if defined(CONFIG_ATOMIC64) && defined(CONFIG_TCG)
>       uint64_t cur_val;
>       void *host = ptw->out_host;
>   

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

