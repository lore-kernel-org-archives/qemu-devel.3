Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4F303C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 22:01:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9WXD-0004jw-FW; Mon, 28 Apr 2025 18:01:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WX4-0004gG-NX
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:00:59 -0400
Received: from mail-pl1-x633.google.com ([2607:f8b0:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u9WX2-0006kd-EV
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 18:00:57 -0400
Received: by mail-pl1-x633.google.com with SMTP id
 d9443c01a7336-2240b4de12bso80102685ad.2
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 15:00:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745877653; x=1746482453; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=t3kROnoGJIrSJkgyARG6n5sawkYNEpCcr7YwbCF9MlU=;
 b=tTVg1L0NDCtoXZIg6rHJN70dXuJdsx7kc/sW9TOr5TQYGPMC8LVrrPH1Zx4VC5BmrJ
 +kDBgXBuc0hfXCSETRccLaQgUT8oUVbjYssEwKAmRDh1fono7KfxhTeVZ8pOwp4KSHs4
 wqCHmjkSeNH51RFi9G1CcPtOKxf7i92v8+9SRFsAhCWkqSOV8KRNyQjtdqospLJnYCcD
 vT5GAgwMtlosmPKDiubVE3i2KFsu1v/xL4Qq8AUbByV6SL6JVWBgQUXs6akfcFaSDAlf
 UfPMJWX9eOgG+Vml4PYRJ6D4HommkH1x9N0Z3Hq+hNBfKOjn+PEgCdlm9u7QBraIKdOH
 mcCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745877653; x=1746482453;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=t3kROnoGJIrSJkgyARG6n5sawkYNEpCcr7YwbCF9MlU=;
 b=XyedybyeEOBMB5NhBtgWTfhadcWMs5+PmSGZ3dQsiCMQKErjaGPhH0RmcIg4mVsUon
 LzHRcV2tpD3turgnSN3DVb8+t6OkGip+u6Cz+PN1a5J54A3G5xbXKd2+lliWnybjI62R
 RzBM23hEbiLtnAhsOam5Z3NG+pnkq0MvDcNSTjS5EEsQLxe4dRc8Uz3JBDDytCg5id4m
 BpNHrR+x+EBg/KdhTQEiotItlBo7avO1/Eey5mc0m541ZDX7hw0TbVoZykyyFQ0h6Q86
 ye/JwlkE+5Qhd71Qv69BV7ldWQLgo7bVMey+vEKIwEf062UPuscCb9m94mgMS33X+3dk
 H9rQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVinEZSSm4xHC8cyXz+JqgCpFajOBJeV7ux14kqqvxIra7FljPQbmh+EUbkmS2IOMRm4uirZflj+ETz@nongnu.org
X-Gm-Message-State: AOJu0YzIoIY67NrJEegWHV0lU/C4RFZu0aFuTJzeHbLKhWSyWTKYXOij
 8xoK4P/HXc5k9nqpI3MI+dg1UhCoIQeFpK3+KkgW+eReO6StbyVQkMc0W4SmVL5BeaxT4pivLKH
 t
X-Gm-Gg: ASbGncuvgS8GnuGF8ZFHbgVBrIDMaCjvkCEqcbV5M6BsRRHYqWul3pp5IX8K0pvRMbn
 +FTLchzyPS39jeQQV/yEMzGVMZpoGdyrshG4oFRALlOSZwGE/A98WE6GHo5j7xlWY0CVqRiSv5T
 Jk+hxwImIVBlCWPiRna9Ek4eNB8XNedx4fHMc2E5bOVEzWG4xcYt/6Xdtjlhb2MTOT904Pbrm7b
 BdPcWrzd0QIxiTedOYoZf9EenEFbPizkupik+t9mq/7SjcaTE0BOSPhzG+jP4Ji7QCwP3k1O9qa
 3CdiU6uty9c1XMZtDtK4utJc5RjBK8oRQerfVHoUU2M+RzGjxeABY6G6VPYcKz5u
X-Google-Smtp-Source: AGHT+IHPD6nhCBfx1jGu7ElJrclbeR68DEj9rVNcCeCfqUwTprra/nQphH8HwDUdJPBkrSBCUiZ28g==
X-Received: by 2002:a17:902:ce07:b0:227:e74a:a063 with SMTP id
 d9443c01a7336-22dc6a68f4emr157458895ad.37.1745877653186; 
 Mon, 28 Apr 2025 15:00:53 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22db4dbcb75sm88569745ad.67.2025.04.28.15.00.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 15:00:52 -0700 (PDT)
Message-ID: <e56a1170-9e0f-4aed-83f5-99ac5c1261a3@linaro.org>
Date: Mon, 28 Apr 2025 15:00:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 07/10] accel/tcg: Return TCGTBCPUState from
 cpu_get_tb_cpu_state
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: philmd@linaro.org
References: <20250428201028.1699157-1-richard.henderson@linaro.org>
 <20250428201028.1699157-8-richard.henderson@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20250428201028.1699157-8-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::633;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x633.google.com
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

On 4/28/25 1:10 PM, Richard Henderson wrote:
> diff --git a/include/accel/tcg/cpu-ops.h b/include/accel/tcg/cpu-ops.h
> index f5e5746976..8dbe79ea7c 100644
> --- a/include/accel/tcg/cpu-ops.h
> +++ b/include/accel/tcg/cpu-ops.h
> @@ -18,8 +18,13 @@
>   #include "exec/vaddr.h"
>   #include "tcg/tcg-mo.h"
>   
> -void cpu_get_tb_cpu_state(CPUArchState *env, vaddr *pc,
> -                          uint64_t *cs_base, uint32_t *flags);
> +struct TCGTBCPUState {
> +    vaddr pc;
> +    uint32_t flags;
> +    uint64_t flags2;

Could it be named cs_base instead?
flags2 is a little bit generic.

> +};

Else,
Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

