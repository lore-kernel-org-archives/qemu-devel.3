Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31D3CAC5B0
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:20:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4PmB-0004NK-02; Thu, 02 Oct 2025 16:19:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pm8-0004Mu-JM
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:19:41 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Plv-0006Wg-Lc
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:19:40 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-78af3fe5b17so1373794b3a.2
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:19:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759436359; x=1760041159; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=PMLkp6xbCnlEFIe6KRQbjxyq+qJ+/4O0R5SB0MqLcnA=;
 b=maITMi8W7FqDXeNKjLSt+A9Yt95UMWl2IzMLxa3SYageZSLDsCLdtCEMqMMzh35RHn
 1k83bZ8BCxNUu9oG9k7Oq5n6x3WoLvwhfPBVjsHMb2YCWi6IJLbRAxVqIXhLq8gWDcx0
 VDrp/8SHRXCjF51N7dwfpLEtkCSVQgep7xVwGzt4ffXsXNoNNmP/SResFgheZt7VepUf
 5AS898PFQMyeR6NCynJ0tS6gWJzmcs8py+dm7k4EN+6gFt/g5vAh/8DCNwRrnr2SP0+u
 41Nof8hIIcqvYwFXDkdacWbTEdVhk3LuFBtehRQafVP2QmHPkHhiGiYBqeCExbbHHCO9
 9t9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759436359; x=1760041159;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=PMLkp6xbCnlEFIe6KRQbjxyq+qJ+/4O0R5SB0MqLcnA=;
 b=q0zoL/fdjsS+W5KKuCv0oiI8lGmYsPCUNkUVjS8mYaKXiW/Juft7RV3wQR+2LLOEVQ
 gG6FvjWqkOH04RCHePvT+oRWu5wgAQb6mt7GzLpysgskgdq/C5buyTa4/jDsbZeHtalS
 3xh3o0oynEkiiJeevo+tiMzRw0tUdGpWGiRgM4VidCGamay5nBnN1YkCwDriOtO+Lbz3
 GrNPwL41I/kvSnp9P0e0iUEQwZf1I17YK6QmTZqEHUoD+6XAxRW10LaK18exH+ypKiYs
 YW5rwrQsvRXbTzNJCibbXr+5qbFeRHkDfHmfb3Lgc9GLn60A7ibUtALKhuD03fsNucjy
 TVsg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVNS4pqAyjpiZYkEFSRjQpKUXnxiztFJ29MkihesFXq5iu62KbKGQ0R9pA8OvCvQ9zPLy79dyt4Ee6H@nongnu.org
X-Gm-Message-State: AOJu0YwIYJTETf3B9xV402psp3F4LZILmjMYKjF/hIp9/9pL5VWijAJG
 +YXG1gLtfShnbWn+A/5Tb/vBO6gUNku6bEw8+8ppxgjRmTNXkL/1VBI15DQmFjJ5dBY=
X-Gm-Gg: ASbGncsskn9RIYuaj/Ag66YfdpCGeNLjhaVY9CGjiQDqBnhEf9Y1zuFTILE3lkL4xId
 dr+PniiE+14oZpRYtpdLSlRxhd4xcL4YJk3/PJtrhXWEtzVn09EnZSkSil8JGNXznzuXgU6/kIO
 /6q2Bt1T9/xLGq1Kzwoe9WP4CdbbjBdYmCdc//HujgL7KDYhLNcLbXm1Q0o8BY3bIrjBg4/pmtY
 Ik3Qopp9KR4rhkPjbup3EjEMM9O1LktLyNhpo9dpN2n1pZPLwlC/Q8rZnpaGPUWrBGzg7Ouww22
 +t54jpmqiFyiEiqfiNLu4NIxsugn95WKbbgsVoRFLfUauIAIldnjPg8lM064q/6ZBwAPHPjB4iM
 Z6RvDv3YZsAbpFlVrPDtg6xFh3eZ+ugexDkHW24M8U3j2wW6TQwD93jU5Xm1Bb/c=
X-Google-Smtp-Source: AGHT+IFn73GSS4pkI9QzoDWUM5s4x5UIzqCFZ6FcNPrZWrWHL5t6CRqTghiGDqWiCkH+WFlssxYwJA==
X-Received: by 2002:a05:6a20:394e:b0:262:23dd:2ed0 with SMTP id
 adf61e73a8af0-32b620b19bcmr914550637.31.1759436358602; 
 Thu, 02 Oct 2025 13:19:18 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-78b0209603asm2846167b3a.91.2025.10.02.13.19.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:19:18 -0700 (PDT)
Message-ID: <12800981-277c-42b9-9aac-dd3df95400ef@linaro.org>
Date: Thu, 2 Oct 2025 13:19:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 27/33] target/riscv: Replace target_ulong in
 riscv_ctr_add_entry()
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-28-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-28-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 10/1/25 12:33 AM, Anton Johansson wrote:
> Widen to 64 bits in size to hold all relevant values.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        | 2 +-
>   target/riscv/cpu_helper.c | 4 ++--
>   2 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index c1fbb67b08..b17aca0e02 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -653,7 +653,7 @@ RISCVException smstateen_acc_ok(CPURISCVState *env, int index, uint64_t bit);
>   
>   void riscv_cpu_set_mode(CPURISCVState *env, uint8_t newpriv, bool virt_en);
>   
> -void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
> +void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
>       enum CTRType type, uint8_t prev_priv, bool prev_virt);
>   void riscv_ctr_clear(CPURISCVState *env);
>   
> diff --git a/target/riscv/cpu_helper.c b/target/riscv/cpu_helper.c
> index 2945a89a9c..4acfccc9d8 100644
> --- a/target/riscv/cpu_helper.c
> +++ b/target/riscv/cpu_helper.c
> @@ -925,8 +925,8 @@ static bool riscv_ctr_check_xte(CPURISCVState *env, uint8_t src_prv,
>    *    entry = isel - CTR_ENTRIES_FIRST;
>    *    idx = (sctrstatus.WRPTR - entry - 1) & (depth - 1);
>    */
> -void riscv_ctr_add_entry(CPURISCVState *env, target_long src, target_long dst,
> -    enum CTRType type, uint8_t src_priv, bool src_virt)
> +void riscv_ctr_add_entry(CPURISCVState *env, uint64_t src, uint64_t dst,
> +                         enum CTRType type, uint8_t src_priv, bool src_virt)
>   {
>       bool tgt_virt = env->virt_enabled;
>       uint64_t src_mask = riscv_ctr_priv_to_mask(src_priv, src_virt);

Watchout, here we have signed values.

However, checking call sites call sites, since we deal with pc, it seems 
safe to have uint64_t. Maybe it's worth saying this in commit description.

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


