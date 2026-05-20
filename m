Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5056ACD4F3C
	for <qemu-devel@archiver.kernel.org>; Wed, 20 May 2026 14:22:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wPhns-00050D-Ol; Wed, 20 May 2026 10:21:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPhnr-0004zx-Dq
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:21:43 -0400
Received: from mail-pf1-x429.google.com ([2607:f8b0:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wPhnp-0002Kt-SI
 for qemu-devel@nongnu.org; Wed, 20 May 2026 10:21:43 -0400
Received: by mail-pf1-x429.google.com with SMTP id
 d2e1a72fcca58-82fbf5d4dc2so3425982b3a.1
 for <qemu-devel@nongnu.org>; Wed, 20 May 2026 07:21:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1779286900; x=1779891700; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=z693pucdr/KHVgbcxJX8W/LKpl2ypTRR2M7Z1TdnQmg=;
 b=FQQHiakFOMe/UCdQvQr4SBczGqKk7RFLaOrpLoz+CLNwN3/LZbmzt5PAcRde+4klbc
 ZPM7Xun0Sd0rzeOPAj7982WrrLkpREUgSZ51nRkuPhtlnGG370+sU3n8vF96B9dEsiwY
 c80EllQxa0E5SnTb0Elrsg9QiPG3XQDqMwIFHyCTIums/cUkBqJIqc1fvGog17zpjcsd
 RKAxKzhpVLguyye6Gkxde6XtOG60Rbk9arpTsah2mzw3FEV4g3/7LIalMQNSYnwXurEJ
 xgY6YL5OfUN1/9KUfldpx7LiGVdmJ4fvWpLkCrxT4/wekHMrGMMnWjLYneIZiNPI8qax
 h7PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779286900; x=1779891700;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=z693pucdr/KHVgbcxJX8W/LKpl2ypTRR2M7Z1TdnQmg=;
 b=EPXav+trdGs1bM1SRdfoo/BgmaztZ1WQaiQF4hzhwdC5USorh9/9jJCz4TRXYgB61D
 PnNMQuM46CzFH/KF/Lp0vGDf1Vab7UMHK5027r5wGbqOrEMSd9npMdnzKulGIyD5HzMr
 aLllTz1fzRmGruepzGiFjk3laT8S9RNX/2MGuCfK2OTfMTqboMuHAXp8u/DeyoAcSA9Q
 /PStFe51Q/tmInBkkP9S3yWgzo0Drs+JYffR/9Zo4s9Znep3BLMUgHqldz3CDzZGyq3V
 d118X/IG2jbSlB2O0MubZ/rq+IBfOCRNSE6SJC6oPEhvOYVlyjFTMgvBEq0uEJPN4Olm
 0luw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/RGYRAbgs5S/zIibeO6FOeKQVk28vPFWwCQ5/iW5TgQEbAkA/MtlgjZKFUNdowtyBR274I9vLOVbRq@nongnu.org
X-Gm-Message-State: AOJu0YzB+VuglojV/wLf0q9NT4Sojo6LiKZ1bBGDlIw0eP3/eE4pQ6CV
 1iHW5V6Ra2FwEExb9+/tvDwCa0OIj2K8RP7nHWyhxb4guM45qIoL5M9JmDjSD9oiom8=
X-Gm-Gg: Acq92OGbRpBwFH/mNw7554Mh+i5MXkG6NAqiuXh4PQcozmTyKBppkx4SALgm7mUpfml
 fM+RaIpnU98yeDNvNO7gsozmEbnrPy9BT4NhrH3oE5Zist9tr4IytfH2WASHc0NZWAVomvhknAx
 nC+vDXk70Sw7g3pkcv2hPFGgIzrlkKoD4juBn6VyftL3qWMwa12+RZOnm65DXgIDThuettGzBsl
 4QhlZZU4DBT8RbVy5OzXqiR8gbiXDUQ3Z0mpF2HBhuI5AIGw5O4Tm8FeWx4G+Lr2hElZpR9t2sW
 9krvWwi5h0s0WFaA+WX5Lr+yPxWQjJOKpcNcv5AWLo4/Pq2nUYTOZpIRxNYbIi6sn2JhgCiXsGx
 N16tck0Dn/ZhRMeLMmqELXP+Okr2zLkRVLPmqF0QZqcOnytJnDLkSj4xXTTEfcV6bKNRMy6BKVf
 VnOHOBv9TUNvpX6bxM4j5gniTxysf7zTgmFQPY
X-Received: by 2002:a05:6a00:12e7:b0:821:7d7e:41cd with SMTP id
 d2e1a72fcca58-83f33aeb06dmr25733247b3a.10.1779286899029; 
 Wed, 20 May 2026 07:21:39 -0700 (PDT)
Received: from [192.168.0.4] ([71.212.142.33])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f19fa869esm25315176b3a.61.2026.05.20.07.21.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 May 2026 07:21:38 -0700 (PDT)
Message-ID: <c5fb24c6-8064-493b-b316-ce8bfb153ba4@linaro.org>
Date: Wed, 20 May 2026 07:21:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v11 24/24] target/mips: add Octeon LA* atomic instructions
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Aleksandar Rikalo <arikalo@gmail.com>,
 James Hilliard <james.hilliard1@gmail.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Aurelien Jarno <aurelien@aurel32.net>
References: <20260520101807.9971-1-philmd@linaro.org>
 <20260520101807.9971-25-philmd@linaro.org>
 <95f50fd5-9463-4108-b7a8-5b21804cbb27@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <95f50fd5-9463-4108-b7a8-5b21804cbb27@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::429;
 envelope-from=richard.henderson@linaro.org; helo=mail-pf1-x429.google.com
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

On 5/20/26 06:58, Philippe Mathieu-Daudé wrote:
> Alternatively passing the atomic function by argument to TRANS():
> 
> -- >8 --
> +typedef void AtomicThreeOpFn(TCGv_i64, TCGv_va, TCGv_i64, TCGArg, MemOp);
> +
> +static bool do_atomic_ld(DisasContext *ctx, AtomicThreeOpFn *atomic_fn,
> +                         int base, int add_reg, int rd, int64_t imm, MemOp mop)
> +{
> +    TCGv_i64 addr = tcg_temp_new_i64();
> +    TCGv_i64 value = tcg_temp_new_i64();
> +    TCGv_i64 old = tcg_temp_new_i64();
> +    MemOp amo = mo_endian(ctx) | mop | MO_ALIGN;
> +
> +    gen_base_offset_addr(ctx, addr, base, 0);
> +
> +    if (add_reg >= 0) {
> +        gen_load_gpr(value, add_reg);
> +    } else {
> +        tcg_gen_movi_i64(value, imm);
> +    }

If you're going to tweak that, you might as well do

     if (add_reg >= 0) {
         value = tcg_temp_new_i64();
         gen_load_gpr(value, add_reg);
     } else {
         value = tcg_constant_i64(imm);
     }


r~

