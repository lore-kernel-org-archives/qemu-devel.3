Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56CD3D35167
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Apr 2026 10:15:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7sba-0000o9-3j; Wed, 01 Apr 2026 06:15:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sbY-0000nw-97
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:15:20 -0400
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1w7sbW-0003lO-LG
 for qemu-devel@nongnu.org; Wed, 01 Apr 2026 06:15:20 -0400
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-43d0deb7ad5so1397386f8f.2
 for <qemu-devel@nongnu.org>; Wed, 01 Apr 2026 03:15:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775038517; x=1775643317; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=OIjj14ehm0lombSWBLMfx2faz4c9Var+PdE2FHuRIuo=;
 b=SRbit3pGIOXGEFPRsOO42kx1S040RERsH8wkwL1Kp0OjGpi9BaaqL1mkJNLahZmLQk
 UwrN9CExQnU7dAQbT8HY4b39lolf9NU82MpbEOfFtH4v557HMK6W4iyrhPagA1Xy7dKF
 oQdw8TOWVula8WfdrW99d9/XbVWFARDOpmeOu3ks0flmnIyLoieHm5aMCyGL+w1MBUuu
 FnKgUNlBfKfoHtvSayVeQlDW9rVCmFTVrfuPHIfg39XT7dr2uwd2VL+TlMvSqOz9H4Bt
 IPoKafjn+PJBEBAx/O2GhKHxaQD2Ehs2yZ8iH58+BK9JNQD7E99QVgsOwTUYqXVG5eis
 DhFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775038517; x=1775643317;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OIjj14ehm0lombSWBLMfx2faz4c9Var+PdE2FHuRIuo=;
 b=jvmHKJeKSkku/IE/vLHeJ04epYGpjEs+IRZ70eALYkUDQ5pCjCyXJopfdt3QH7vmcW
 JFD0NwemEC7/YLpFlSP/zjmQy+ayUqASYZnCPznDVH+TtWb9NQr+q/wNtuZy55XFLX5W
 Py0CacteN89SwvtJLqOky5SUG7atyNqAsgbiTyeYT6ROfz7nKMh9tOFmmyNQnWD1tT32
 6ZUeqxl/dBwJFFDAs8waiV/qmuK6Xq/zieeRO6yz+VtrE29PH9YyruGF7zIUv6Luz9P0
 pwnYkpMwAJ84SnL1QLJiNyPfkjogWBX9t7xwmHjM9T55E+G04rbSAnDDxgyKHwmYy4hq
 uIKg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7fHoRdWLLLuaZO0aOKBoKnJKagyhRsqgsxrvD10aV3i3ZJa5JlR7keMk5CcOuw/ql8YTMHk3uAlhl@nongnu.org
X-Gm-Message-State: AOJu0YzQqkIRH58h7kbhpEFqaRjSe92cP83Dq73FpfPdRCJUNunv8gml
 Gyf3eqiA3uHTbLJyZzyeAiDUrBw9vhO6VVxPTYk0MzaCJqmzE5gNALHoA5j1yS1sCHw=
X-Gm-Gg: ATEYQzyKB4yZzMS0Eq5SoaWTTHQtZh9JDzi5GL7QElrCL/JTbOQvU5xv14WwzQ2MIx/
 Ul4v3mMV3X6JCi6YMS+uaoLVdZnfN8adstSnW6hds6IGUOw4Talll9c2xTc3q00GlPKrXRhxe+i
 KnGJF8xAldjyXY6n7+3rFOtzgieas3Xy2G2e8okqepfsmCsc37Ux8gNmyIxnyRygQiLdMWEvyj6
 42Ju2nYydqIOOPhVqSIwyCqqLcxWkgB7GSvu2IJdLbyN73cD2sj6RMe6jhQhvvmUiw8knGVVBF8
 ZAq08l3m1r/XB34Ivjj/683a/1r46oWrjNfnixCCrPsM28OktUBnUHflNSdqlhDXAoHADyuu4fo
 QS42Xj1ifzP/L/psQv12zF0aboL66ZhaXUiNmYqZXtfUZfTmniA6ukOnXbvYwuBEsOmiReCqWm0
 pKjRcN4YISsCKFbKcfN/6uTsV+7ZDLjnwZXKca/61DZKTh64zO8WztoYfcbbCdA5Y3K4CLm2jIi
 hR9
X-Received: by 2002:a05:600c:3b1f:b0:488:7c98:e9df with SMTP id
 5b1f17b1804b1-48883306d7emr49796735e9.0.1775038516997; 
 Wed, 01 Apr 2026 03:15:16 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4887e93cf2dsm97456315e9.11.2026.04.01.03.15.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Apr 2026 03:15:16 -0700 (PDT)
Message-ID: <70042f26-3c17-4311-9ab4-7581c7437261@linaro.org>
Date: Wed, 1 Apr 2026 12:15:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] igvm: fix parent object type in IgvmCfg struct
Content-Language: en-US
To: Luigi Leonardi <leonardi@redhat.com>, qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Oliver Steffen <osteffen@redhat.com>
References: <20260330-igvm_fixes-v1-0-03587a5a808b@redhat.com>
 <20260330-igvm_fixes-v1-3-03587a5a808b@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260330-igvm_fixes-v1-3-03587a5a808b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 30/3/26 14:43, Luigi Leonardi wrote:
> IgvmCfg is defined as an Object but, currently, its first member is an
> ObjectClass.
> 
> Replace ObjectClass with Object.
> 
> Fixes: c1d466d267cf ("backends/igvm: Add IGVM loader and configuration")
> Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
> ---
>   include/system/igvm-internal.h | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

