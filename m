Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E197FD26D9F
	for <qemu-devel@archiver.kernel.org>; Fri,  9 Jan 2026 21:47:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1veKKb-0002Y5-SX; Fri, 09 Jan 2026 16:47:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKKZ-0002WE-Re
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:47:39 -0500
Received: from mail-pl1-x641.google.com ([2607:f8b0:4864:20::641])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1veKKY-0007X1-5s
 for qemu-devel@nongnu.org; Fri, 09 Jan 2026 16:47:39 -0500
Received: by mail-pl1-x641.google.com with SMTP id
 d9443c01a7336-29efd139227so34612765ad.1
 for <qemu-devel@nongnu.org>; Fri, 09 Jan 2026 13:47:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1767995257; x=1768600057; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=fuAH2jh0tuCbC+ZVsRx/Msi/NrjYMOxm2/y0kucrX3Y=;
 b=AQBxwjAoO146+wQi9W0ddVDQkPJFlSxBTFfPApCMz+6/p87plMQ6CBHlxSGp/9SD2p
 HzW8tfLgnDJfRIwkSsKASOkp/Zhgbi33mVZkWOqlKNxH9pXKaVdeYBkV3f4k7sROwJ9E
 qptr5ZaEJ2raSnHR/MNwacno+vCXnDZ9pD4+aQIjC+yJMI/IUe8Zj4Rkm7yPxEgd2pgh
 pPRyRwPaMsy06sZSELYPP8Lf+MZ6gnpFX063950/QEkeRvysJwustGK62niGBErZjtPE
 CijTAfiUa7lnzUef4JuVidcMGid8R9sWtGxu3mzaTiVUcDXNiSr75jFhhyFPUywEooPc
 rpNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767995257; x=1768600057;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=fuAH2jh0tuCbC+ZVsRx/Msi/NrjYMOxm2/y0kucrX3Y=;
 b=lJvdrTLqSj3bwRuGuCIP6Q+bERU9MBlpUn3sbNgsxGWwFgsr55dQN5agDm+LhkEgsh
 7wRcloRm7enlpzKMF31Hu48+H76scv1AyWbsMRCWI2s5BdwT7Iuf5zpFTe5nq4xaIaqp
 oXeh9pbgoJtj6Jx/pAnH4OCh22gMbON982whohB1wy1X983J2Gd2TFum5LyHoopKJ7TS
 GdK9U43sy688vS1r3kx0mJMsirZd8TgsiivT7Uci7c2cmXoC5nyE2WSNEhA8Hz1VrS8f
 WzATMWqofF+wKzv/uesOz1q3EOwOU1fIGw0LE+Rs2DbvE8PbinZ3ue1gpnAwBJoROlAN
 RoPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWq0taByw9XBvRcMMCRmGI9mukbsttGSPNyqKEYEcLn6UABofGb4hemjvr5pUmY2Sfo0fC/zPdb0jXq@nongnu.org
X-Gm-Message-State: AOJu0Yx/JoG0kRqdB3Tdh+Yb5jWLx1qYu6gh1EZ9gAUpc6MnQW9wTugy
 oTGHv9JPLsFYTgBhdsRne4b76mlH9f0npls/QU3yVaYxgY/iWhJManSSjPmgjFwDk0U=
X-Gm-Gg: AY/fxX43R68FhpWwd+bhOYziQXb55HwOoizEUa/fy5VXINCwVbxiqUcxT24JVNCEjun
 k+h3dzNX7dVM1x2JD1t3CVgwrcBWJ4WUXVOxIMyWMo9R3h+dCrACMvBwo1nIGjTc6l6vSz8YZwE
 KOaWyvDAx4052u8LyhxUREvNmtitFheIWHhuBeW7ZdOOb9JHGCJcShA6nQuT4RcyXkIthwQGNCQ
 jIuIy3HUWC182lbIU37NuOhPbGtCHdkJhVYqcJVhYibXAVrC/JNmfwUTeS1Y5AVFe7wq7rJb6Co
 mKwR3gw7uT1V0ajZ7y+LZI8oevHOrJk0RMSYrnjWYnbQvJTZqLPU2fE0mY5BDcRnMxulajLtLMd
 4UUObsiY3BMz3Y8vr+pv1RfBwAEw/tJAbjY1DklsbastkgyEYwM4j9v8/UVQ4IkQOxM4ZVorUvw
 PK3rDum+wgfJXzUSJjgDtSN3cLVA==
X-Google-Smtp-Source: AGHT+IFPJT3MmJ6Fv1PusA1RV/J27ecaEvns3Xebx0NgGWF9oNcysVDn9N11uZq+hGQeN0sBxtJ6Og==
X-Received: by 2002:a17:902:e841:b0:2a1:3cd9:a739 with SMTP id
 d9443c01a7336-2a3ee4cae56mr104999645ad.43.1767995256552; 
 Fri, 09 Jan 2026 13:47:36 -0800 (PST)
Received: from [172.23.81.179] ([202.86.209.61])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2a3e3cc88fcsm112531915ad.83.2026.01.09.13.47.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 09 Jan 2026 13:47:36 -0800 (PST)
Message-ID: <01831bff-6aff-470f-9f57-f4a47937fb40@linaro.org>
Date: Sat, 10 Jan 2026 08:47:29 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 11/29] target/arm/tcg/translate.h: replace target_long
 with int64_t
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Jim MacArthur <jim.macarthur@linaro.org>, anjo@rev.ng
References: <20260109053158.2800705-1-pierrick.bouvier@linaro.org>
 <20260109053158.2800705-12-pierrick.bouvier@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260109053158.2800705-12-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::641;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x641.google.com
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

On 1/9/26 16:31, Pierrick Bouvier wrote:
> target_long is used to represent a pc diff. Checked all call sites to
> make sure we were already passing signed values, so extending works as
> expected.
> 
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   target/arm/tcg/translate-a32.h |  2 +-
>   target/arm/tcg/translate.h     | 12 ++++++------
>   target/arm/tcg/translate.c     | 18 +++++++++---------
>   3 files changed, 16 insertions(+), 16 deletions(-)
> 
> diff --git a/target/arm/tcg/translate-a32.h b/target/arm/tcg/translate-a32.h
> index 0b1fa57965c..a8df364171b 100644
> --- a/target/arm/tcg/translate-a32.h
> +++ b/target/arm/tcg/translate-a32.h
> @@ -40,7 +40,7 @@ void write_neon_element64(TCGv_i64 src, int reg, int ele, MemOp memop);
>   TCGv_i32 add_reg_for_lit(DisasContext *s, int reg, int ofs);
>   void gen_set_cpsr(TCGv_i32 var, uint32_t mask);
>   void gen_set_condexec(DisasContext *s);
> -void gen_update_pc(DisasContext *s, target_long diff);
> +void gen_update_pc(DisasContext *s, int64_t diff);
>   void gen_lookup_tb(DisasContext *s);
>   long vfp_reg_offset(bool dp, unsigned reg);
>   long neon_full_reg_offset(unsigned reg);
> diff --git a/target/arm/tcg/translate.h b/target/arm/tcg/translate.h
> index 63f187d4150..12319c02080 100644
> --- a/target/arm/tcg/translate.h
> +++ b/target/arm/tcg/translate.h
> @@ -27,8 +27,8 @@ typedef struct DisasLabel {
>   typedef struct DisasDelayException {
>       struct DisasDelayException *next;
>       TCGLabel *lab;
> -    target_long pc_curr;
> -    target_long pc_save;
> +    int64_t pc_curr;
> +    int64_t pc_save;

These two should aren't displacements, so shouldn't have been signed.

Perhaps better as vaddr. The same could be said for patch 10, really.

Otherwise,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>


r~

