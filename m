Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC80DC9832A
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Sep 2026 15:53:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBa8a-0007hZ-SH; Tue, 29 Sep 2026 11:53:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBa8U-0007Xr-Ss
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:52:55 -0400
Received: from mail-pz2-x29.google.com ([2607:f8b0:4864:3b::29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <max.chou@sifive.com>)
 id 1xBa8T-0001aj-2a
 for qemu-devel@nongnu.org; Tue, 29 Sep 2026 11:52:54 -0400
Received: by mail-pz2-x29.google.com with SMTP id
 41be03b00d2f7-cc7d1802740so202478a12.1
 for <qemu-devel@nongnu.org>; Tue, 29 Sep 2026 08:52:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=sifive.com; s=google; t=1790697171; x=1791301971; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Zii2ZClBh/krf/pfPoQapyG37gcHIzvKUdpJglJM9qw=;
 b=CujPiiB/8X+fU3w9YvZMZsqIQ7ZoDuPiEY0DLhtyxOUBJUz9PKh+oFZvyJJwdyX64D
 2KtlFkf+RVONtTA7Y8iBAhCsKK7PLMYgOwKCh2C0yKwcEFq9Po3AvCNNX/fNdYww6LgG
 rtlPAb2zKI9pgAGfiNz0WBb3DnW1qmpnOx3k6CyDoFG1Q4jIGBvziT2seR3pKfGVFFBy
 Q224u5mSoSaykLkPzjqdc6b8rbUXC+zyENNaw79uRIMXg+5HCs75gjQJ4WnsirG0aNFF
 fHwhFcShOzkDyQWRsCJ4QA+IpkbXwOb6fiUU9xisrRx2RRy8tEeCULRLgm2gajGrlf5q
 9ESQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790697171; x=1791301971;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Zii2ZClBh/krf/pfPoQapyG37gcHIzvKUdpJglJM9qw=;
 b=QQ0QolBBdf5v5MDcKh7czSGJLRdmUkFKkJ0B/AhBMyg8FWO+o/CKnNpOzSigHOpGaS
 u1AsCwbAoJWOa6LmaDhQ7lcRKqJ4WbbmhA+eFMOAgveFB1s3Nhprwj2j2WPVckxikGmT
 BXdLB/5zQOaBt4B/qjxnUKnP+n7sNUwbc9BixnHMdR/aIsCZrzlweNve1+mnasj7uob/
 cNtDFYL1fBupb2z7i3m/m+uuc+UvUgkNzlkLE4f+/qloG4NR3vLidzPaiLXGq8ENqmma
 YcK3KpGL7dHe9LlJ93VUGxg9cnmQSNbOn8CJNPG/mGBuZEt9l6jhmhRKfsO8y1SJ1ffJ
 xliQ==
X-Gm-Message-State: AFq9FYKva3i0aNJ8Mm8nXcgqcuBQOVilSN+GeYAwNwvDfCfdAtfKGNdF
 P0jUarmZnRxBXnAcSoUZBD4p0HqAgdGc8QkSaWZMW6jdVwu3yVYVIimf2gXgaRtAvHY=
X-Gm-Gg: AYBFou0KZaTZSq7dvLzkN4tvKkNLAyhJ9N/bN52ly9THqviA0sqDme2pfqmRt1uQ6tu
 QM8DJH/mxDDfLmZJhJrq3vdjL6OmDCOg1FIQtcyZqbHktcyQWRm7OC+BjwA89wvbr/3+hqhyNF2
 4KC/6+iiRzSGIMeaRe6EFRZ+J9DpHYX4B2jt7UPw33GyVDnDZ9RUMnO9hYMkVKyb7yLvKUQhgpJ
 uFRHcRUk5ED182So9dToNt4qOphn+36IWxkRK62BpNSwT7HFHK5g736FX+acOaNZTyN5duminKy
 vE+gUNeeVczZzYhEMegAgVE2mgA8w8EtCR/MbAcVolHJqFPAQE1UImlTqVwucG0TFrgoxcptKKm
 03UVBmQ4ignwZpmxbqsuT/aEla6IT2KVYa7NgokX79h2zf51lwTLA/BYnBN+gb1zfQaKDaY7+f+
 pwGkF6VHyRUEABNAOCJNsY9m5xGEXjFwwbG74u8oMVNe42qu7/Yv1dTkLy8Ud2sUyRKjAHq67p7
 DkuHcR9uDNLs82I/gwNC6c=
X-Received: by 2002:a17:90b:1dcb:b0:3a0:e786:84bf with SMTP id
 98e67ed59e1d1-3a0e78686a5mr8699612a91.60.1790697171254; 
 Tue, 29 Sep 2026 08:52:51 -0700 (PDT)
Received: from sifive.com ([136.226.240.165]) by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a4986e964asm6472970a91.15.2026.09.29.08.52.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Sep 2026 08:52:51 -0700 (PDT)
Date: Tue, 29 Sep 2026 23:52:47 +0800
From: Max Chou <max.chou@sifive.com>
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org, palmer@dabbelt.com, 
 daniel.barboza@oss.qualcomm.com, Alistair.Francis@wdc.com,
 philmd@oss.qualcomm.com
Subject: Re: [PATCH v3 05/11] tcg/riscv64: Adjust sign of lui immediate in
 tcg_out_movi
Message-ID: <arvc_FWdQVCAGMIH@sifive.com>
References: <20260914000814.785155-1-richard.henderson@linaro.org>
 <20260914000814.785155-6-richard.henderson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260914000814.785155-6-richard.henderson@linaro.org>
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
> No real bug fix here, as we've already shown the full value
> fits in int32_t, but simple subtraction in tcg_target_long
> may produce a positive out-of-range intermediate.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  tcg/riscv64/tcg-target.c.inc | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 

Reviewed-by: Max Chou <max.chou@sifive.com>

Thanks,
rnax

