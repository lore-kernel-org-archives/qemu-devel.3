Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4189E88D6D
	for <qemu-devel@archiver.kernel.org>; Fri,  3 Apr 2026 22:56:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w8nQp-0005sV-BX; Fri, 03 Apr 2026 18:56:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nQn-0005s4-R9
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 18:56:01 -0400
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w8nQm-0006eW-6l
 for qemu-devel@nongnu.org; Fri, 03 Apr 2026 18:56:01 -0400
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-2ad4d639db3so10439875ad.0
 for <qemu-devel@nongnu.org>; Fri, 03 Apr 2026 15:55:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775256958; x=1775861758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u6rTCVIJEc41lIqTdE7Fkcyn8hFrgM/EBVaTprslLAk=;
 b=tXGq87tXdcl7X3pnK/kyyGtvyEZ2PdL8AiYXKpG4XjVZOC0rL+TdiqVa+GDshhzCoG
 hoc0HmfLgvGu0RVEa6jn7fFIzeZbgzPvMgg+UW8N/boInwjcjRW2NHcOIO2noRH5TpY8
 P944tsdWPn0zP70R0yeKl5zn6JKO7q028c+hPh1V41pihM/UOrd/DdsH7LiyoxqhGFLj
 d7Gf9t4cvKsxodzeXDUHLncHx+v7/WBjpEBsdB4Wpmv5h0dIiBefIgmbLpymbfdDTiea
 grBNyoky0+C/B36HMTD/HaS19MlN1k3xgLWMBlkvhKVLgZraRuOotfR+FOWulegZjRoK
 BtLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775256958; x=1775861758;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=u6rTCVIJEc41lIqTdE7Fkcyn8hFrgM/EBVaTprslLAk=;
 b=nxmk0hDihqUnGwd/M7RZ2azbREs0o0rwIDcUywPExngXJoZImu6HjZBnzzCnNt3Kf8
 0zLPPVLBlpAVUgsdvyikNQgnNV5dCgmsLbUfwtd+vmIQ/reiImr3uvJtGnCUDoTTvRJD
 NANPrXkZlJRj/rbMx9jugo9i9+XioeljauxtJphFji8pXPOgL6PbJ9XdwJHAI0ainOAe
 z7+ayrrDPcwD1BdLRAnoxp3YFpVRgjQvd73Q8VEj95vvFtevBnHyVntQ/Y+jQpPlRRNh
 c0tQZRCiKcX8xI5MS2EaBvkr9OfMedsjzl7iHi1NadUVlm6f1yKcQ4tKjd/AFdhKBqHi
 WfUg==
X-Gm-Message-State: AOJu0Yye2xqwXIrzfKfd/N6WG9k3s4XWxVUdIQlcjvlnw6rCWthgTn8D
 07k8DlsQZi/oHwuO5nve9lHBQQuxVO6vPQK1KPIghqZE3N//3ewdldeXEHhjm/bD7axtN1YBzUA
 uR8MIcAo=
X-Gm-Gg: AeBDievYPlZHXQxPy5OIfsQdhnE+/YldmSAilHSf7QcpJkrk55mqJQhy6aUX9qPXBnb
 3GIZyWu4aHrFysXj4QQ8hTdV/oQPEmmloHu/7IuYNMKy5pEvDtpg9eIK02uVQADTVTpJNwQar+P
 YMIKzKbk1KrMNnoWuN6wo29WXZ+C8KPVjYYWgwVz2Itk/TTA/29deXl1XEAHUkoY7b2lYJFwfCB
 2InXK92GJj4xh4gZq+UybBCIgHJA9bN0ufjMjR4FVm5enR7uzBh+kL9zQL+MyKqBfV63pHBvEyv
 gVOQlbKodxqUzesVmACdmiuSphuv5EUw4W92WtQPtanUhfK5b1JIo7D4fvsYAHijvEfEqM4vL4B
 Wu1xPlXJ2SbKt2i0A3k2TbrH/+7xsIOECYS7FA3WzI/tJlPlJhGXAlq4HM9u/5sKpdFva1HeGEI
 /0D8wZR8o8ghWj0lX2S3+SeqhbyYf71a6neumeYGsImOJUTYKZDgX43E/68yS6+Nvfz4s=
X-Received: by 2002:a17:903:191:b0:2ae:504c:ae8a with SMTP id
 d9443c01a7336-2b281818bdemr44088515ad.16.1775256958271; 
 Fri, 03 Apr 2026 15:55:58 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b274779b48sm91984645ad.25.2026.04.03.15.55.56
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 03 Apr 2026 15:55:57 -0700 (PDT)
Message-ID: <ce92d0b4-96b1-4868-b790-7397cf033a34@linaro.org>
Date: Sat, 4 Apr 2026 08:55:52 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH] target/arm: always propagate s1ns state on faults
To: qemu-devel@nongnu.org
References: <20260402154821.2340594-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260402154821.2340594-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62c.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 4/3/26 01:48, Alex Bennée wrote:
> According to our mmuidx documentation:
> 
>    we fold together most secure and non-secure regimes for A-profile,
>    because there are no banked system registers for aarch64
> 
> So we don't hold quite enough information during the table walk to
> infer we are in secure mode. When we are trying to access a
> none-secure page we get a stage 1 translation like:
> 
>    (rr) p ptw
>    $1 = (S1Translate *) 0x7f07479f93a0
>    (rr) p *ptw
>    $2 = {in_mmu_idx = ARMMMUIdx_Stage2, in_ptw_idx = ARMMMUIdx_Phys_S, in_space = ARMSS_NonSecure, cur_space = ARMSS_NonSecure, in_debug = false, in_at = false,
>      in_s1_is_el0 = false, in_prot_check = 1 '\001', in_nv1 = false, out_rw = true, out_be = false, out_space = ARMSS_Secure, out_virt = 1075929104, out_phys = 1075929104,
>      out_host = 0x7f0750016010}
> 
> However as we only write HFPAR_EL2.NS when
> arm_is_secure_below_el3(env) && fi.s1ns we can afford to relax the
> check in fault_s1ns.
> 
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/2568
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   target/arm/ptw.c | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/target/arm/ptw.c b/target/arm/ptw.c
> index d5b2ed6c99c..ccdc1ef9916 100644
> --- a/target/arm/ptw.c
> +++ b/target/arm/ptw.c
> @@ -634,9 +634,11 @@ static bool fault_s1ns(ARMSecuritySpace space, ARMMMUIdx s2_mmu_idx)
>        * For stage 2 faults in Secure EL22, S1NS indicates
>        * whether the faulting IPA is in the Secure or NonSecure
>        * IPA space. For all other kinds of fault, it is false.
> +     *
> +     * At this point we can't actually tell we are in SEL[012] but the
> +     * actual setting of HPFAR_EL2.NS is gated by arm_is_secure_below_el3(env).
>        */
> -    return space == ARMSS_Secure && regime_is_stage2(s2_mmu_idx)
> -        && s2_mmu_idx == ARMMMUIdx_Stage2_S;
> +    return space == ARMSS_NonSecure && regime_is_stage2(s2_mmu_idx);

The root problem is that the computation is simply wrong.  Nothing to do with the mmuidx 
documentation, so the patch description can be simplified.

Anyway, for the actual change,
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

