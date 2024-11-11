Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F550D3ABD6
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 17:44:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tAYRa-0006nh-3D; Mon, 11 Nov 2024 12:43:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAYRV-0006mW-A1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:43:13 -0500
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1tAYRS-0003Ce-4h
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 12:43:13 -0500
Received: by mail-pj1-x102e.google.com with SMTP id
 98e67ed59e1d1-2e2d1858cdfso3588278a91.1
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 09:42:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1731346958; x=1731951758; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=CyWLg+N7kQjN9j0MfMW765Pul5jARnf7YRAep4pEPGQ=;
 b=kNRuq6LD6XJpz5hf3suijy45sAHC0epbQedD3y11HRGvJqE9CHl456mLFokOrtd/lE
 O0XXVaKKwRvZAIlthFYVh1G3tSVmaRvh5pS7svlhwK1q5FWkk/b+4f0RG8CvrXneyXG8
 EMYSZloyuwfC6X3tvj1B7dWw/iZixqr+KMcGBsuw+9PWJ1qqHMeH1sNWyuLPgLRa0RcO
 WdW43B4mbp15ZMiuXz7F4txJjzPR8VEDlxN5Ia7hdBu++Xvemnp17hRn8vx1TIqiSIAr
 CK0Cogqn/bLQSMogRpMgFOy+VP2oi53pd/51rDNNMxIP3C+Yxy0IKKbGwAYhOyu1me8C
 +z5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731346958; x=1731951758;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=CyWLg+N7kQjN9j0MfMW765Pul5jARnf7YRAep4pEPGQ=;
 b=EpW6N8YLEm4cDNdU5UMwVlGTXVsfaBYUQZGzxvpljjV9SetOqzHxhqmrA5M/+sb06/
 8UWIQdYTGL5rYakasQyynF8HGA7SFlf4CAszXrbYdG+3Bg4BTz8/aeeZk5XDesyu7hMT
 1XVB+aAv45BY+BPkErSYYSUFLyN3gOhJNHQzEgVCpbgMK7G5hbjx5ErlCrlTef6aA9wK
 NXn0D4UXlBY862hI7mGtn6PbuLthJN0XAzpCgEHq2IG7Vu7DKFbZkcojvUK8SkkAdF2d
 V1zuOEozf9FWULP+9m3WYZz7qpPCaONQzqO7lQdKi39GpJGdzpvcku2y1zaHeXqcrS1A
 UbpQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX76ulh0w3Pep2qjdhjWOZG1/J89lZTYdKHvASna7zBO/l3rxRSFe7rYPOLAsV9nSYOrJviWCfVFHtF@nongnu.org
X-Gm-Message-State: AOJu0YwsMsFdth42QNUrSbWhbj0RgO4M4GNM67iN+RwoKrPxiRACMCA4
 ekpTzMAJ5ZZ4Jrbf1smabDsht6vqppUtrS/b/HYUd5UT3SN2IY9igtS+Cy+qr1A=
X-Google-Smtp-Source: AGHT+IFsHqo9fg/H1YJEm1NoPek3VSRKntZF4MruRGbI3Hpra0mEn1e1T2/uojQ+3/LSJktLMtHS1g==
X-Received: by 2002:a17:90b:4a01:b0:2e9:2e69:ee10 with SMTP id
 98e67ed59e1d1-2e9b173d95cmr18526911a91.19.1731346958629; 
 Mon, 11 Nov 2024 09:42:38 -0800 (PST)
Received: from [192.168.68.110] ([189.79.22.174])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2e99a5f8df7sm11031029a91.41.2024.11.11.09.42.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 09:42:38 -0800 (PST)
Message-ID: <f61bb688-6b8a-4ca6-b0cb-0dfa72b0bd4a@ventanamicro.com>
Date: Mon, 11 Nov 2024 14:42:32 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] target/riscv: Add svukte extension capability
 variable
To: "Fea.Wang" <fea.wang@sifive.com>, qemu-devel@nongnu.org,
 qemu-riscv@nongnu.org
Cc: Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>,
 Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Frank Chang <frank.chang@sifive.com>, Jim Shu <jim.shu@sifive.com>
References: <20241108085239.2927152-1-fea.wang@sifive.com>
 <20241108085239.2927152-2-fea.wang@sifive.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20241108085239.2927152-2-fea.wang@sifive.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102e;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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



On 11/8/24 5:52 AM, Fea.Wang wrote:
> Refer to the draft of svukte extension from:
> https://github.com/riscv/riscv-isa-manual/pull/1564
> 
> Svukte provides a means to make user-mode accesses to supervisor memory
> raise page faults in constant time, mitigating attacks that attempt to
> discover the supervisor software's address-space layout.
> 
> Signed-off-by: Fea.Wang <fea.wang@sifive.com>
> Reviewed-by: Frank Chang <frank.chang@sifive.com>
> Reviewed-by: Jim Shu <jim.shu@sifive.com>
> ---

Reviewed-by: Daniel Henrique Barboza <dbarboza@ventanamicro.com>

>   target/riscv/cpu_cfg.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index 59d6fc445d..d8771ca641 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -84,6 +84,7 @@ struct RISCVCPUConfig {
>       bool ext_svnapot;
>       bool ext_svpbmt;
>       bool ext_svvptc;
> +    bool ext_svukte;
>       bool ext_zdinx;
>       bool ext_zaamo;
>       bool ext_zacas;

