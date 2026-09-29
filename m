Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F559CA5FA5
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:43:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBZym-0002oc-1N; Tue, 29 Sep 2026 11:42:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBZyl-0002nR-Az
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:42:51 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBZyj-0000dq-TI
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:42:51 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 d2e1a72fcca58-8864c6bd0d5so234964b3a.2
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:42:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790696568; x=1791301368; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=V7QUA2lv0WogjVyHREZ+JXw5BhsRPf0GHt492jX54Sc=;
 b=AG/Ql17++Fui3Yn9aVZBNVAhH2zg02axtVwCVmXLoI1P6gGkxRAhCcc6fiNuParp5J
 n0wQ/uNns5w8L43Ik1RtRM/KkGUI2c3J+tQjCM8XBalocyWQrUMXoDxAusAoYwYlsPvs
 meZ8d/l/sLWCRKxuI5MDiA20oKcRSdP/Moq7XTtCZnBqSn9RuBc9cvAogNYSdKfOFBV/
 EO9+p3fAeCq5MNkvV90/5WlqkUD41fwkCEMf3UjMCSSK2Sgs1WSbRB4PZx5yAMBEqbz4
 X+wjZAwWxKqztLxVP2u0MtgKMF+fgkP/DZEzsvZr+6wEJRyz6+F9t4NsaYxtB4XzcEBV
 LMTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790696568; x=1791301368;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=V7QUA2lv0WogjVyHREZ+JXw5BhsRPf0GHt492jX54Sc=;
 b=UD4v2QYF/a5OTa2u/33SH3xFV5WoEw2qoC03z7/d514Leb33+94HKmPSmh52WRitcw
 CDb0r2ARLUANu7BWUMXq81+w9gB9UDK66kV0XoBD9ERpcfatU7Fj5tcHyN5QUCPChW8x
 uSNo6VKjd8Wg4Pjoyyx839b++aQ0BCCPHR15TpwcmjeMni+QMko4ZPzbN1w29rRoTz1K
 NB6jQmuDdzvsK3QGqPEYUAcQsQ9EPASkgk4qzG7ufcTGDvKuKMYtfcbcDG8YSGovoKx7
 rS5RNe7Wz46uG2J7cG8WqFJLBz7fad1u0JkycKBQXYP6NRjwvqbIp8/W5CEtAHzUrW37
 3MTQ==
X-Gm-Message-State: AFuF++lNvEFXp2iL7J8YRKZLwqiIkTmqtKrZng3Xk3dCf2Nq+O0Mjf8V
 1lnhHRj61mAtwKynN0sDnKm/3eylOGJqoTddmqfTp3c7WwRO2Q8fS6KOkj9uRwVQAfU=
X-Gm-Gg: AYBFou300V0audJpaCCQKU6p68Gr+6PM8SzPQLq7fg6q8IvPIRdkcvj3YlP3Bw2l1MF
 KbcVmTSHXuVkp2LYSY8DoUVXTMHIKOi90uLwAHHaOGI0tvzyUiXqab0tDtvptteNrmu+UMuur5I
 6VDxfjY41UVU5KW2YJGIyn/rVQHYlPS4djnN1ry8VZ3uLIT8c0Tn5LpZ42ig2WGtclscMc9AL+q
 NI2JT2cPD9Tm1/S4UH6W1BjLuv/NdeWgmqS0i6yuFj3yIvOZ6xA8fAx/vxYivJgSt/dYItmYoGo
 qU5yfFUtx76bUb1i2yzvNeTDNSmuZv4Xm68bAKPok0WjJeXrP8cNJJAapOBT3swZw3mvllFAuJf
 7nFA7+9V7NnQpYNvAgPKdc3EdD3qQA7KrGd7TqcZT3KFV2YzYeEcnHL5s4PcwtfiX54MciWdIrN
 SRu+TykPdYzIgo7lH80iOcRpsiNwuxJ1nAjlrXKgKze9dN7joFd9TSk0CbjqlOiIPXLsE3kaS8O
 dxHL75Arh1A6ioc2lfpPvRthmrL/xnTwuWqFy9sV2np
X-Received: by 2002:a05:6a00:a203:b0:878:3538:8f7f with SMTP id
 d2e1a72fcca58-87e9f821e63mr13596675b3a.45.1790696567956; 
 Tue, 29 Sep 2026 08:42:47 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-8868c0ed9casm152591b3a.30.2026.09.29.08.42.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:42:47 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:42:44 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 01/11] tcg/riscv64: Return tcg_insn_unit from insn
 encoders
Message-ID: <arvcPgfa09C-o3dk@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-2-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-2-richard.henderson@linaro.org>
Received-SPF: pass client-ip=2607:f8b0:4864:3b::29;
 envelope-from=max.chou@sifive.com; helo=mail-pz2-x29.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On 2026-09-13 14:08, Richard Henderson wrote:
> Returning int32_t was logically incorrect.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 47 ++++++++++++++++++------------------
>  1 file changed, 23 insertions(+), 24 deletions(-)

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

