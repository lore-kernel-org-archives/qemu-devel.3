Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4F84CF9C69
	for <qemu-devel@archiver.kernel.org>; Sat, 21 Sep 2024 12:22:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srz7c-0002Hn-Ng; Sat, 21 Sep 2024 08:21:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1srz7b-0002E1-Iy
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 08:21:55 -0400
Received: from mail-pj1-x102c.google.com ([2607:f8b0:4864:20::102c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <dbarboza@ventanamicro.com>)
 id 1srz7a-0000iK-5z
 for qemu-devel@nongnu.org; Sat, 21 Sep 2024 08:21:55 -0400
Received: by mail-pj1-x102c.google.com with SMTP id
 98e67ed59e1d1-2dee71e47c5so124096a91.0
 for <qemu-devel@nongnu.org>; Sat, 21 Sep 2024 05:21:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ventanamicro.com; s=google; t=1726921313; x=1727526113; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nslfQPwOKA80pbWqblASkGA0VIK8Eg+jfKDmlfALEtE=;
 b=kWFKhgz4qZi6ItJAt/OBN7eqJSKg4nib7BkD/BDMjmJusWf8NTwXxluyG7smdGQ8kj
 CZ4xRs24gisCwLm6QCjCSwti+fv7m7rtH+mXFLVSYikT7Wx9UVXRal0NFZALExQZdX9E
 abcKBTFZRSaRyONDHp7NUf1iqY+Ny9y1cr62JiNfGllAWnTrEuWhH/NbmcQKtDfCZfT3
 7Aa6ipsTKiMplXVWhOyfUCl7qChqc5Pi0FuaOmQqoMkRxLG12N0EaTde0wZchTte1os0
 SCocg4lwGrNphM0eeohFFEiaOYXvK5mbPLrrt3rG7ZeP6o94oXRcfEJ6wUDOGh+E8ehn
 r/KQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726921313; x=1727526113;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nslfQPwOKA80pbWqblASkGA0VIK8Eg+jfKDmlfALEtE=;
 b=LQWfm7Kqw2W4NFdvuC4Alx8iceH/rki8mECTtmmCj5wSje55LnKz8+lFKUd7GzSgaw
 eq6D0DBfQJ3B8eeg6q3ATeG8gdCndoQL/hDL86wgtw20oy1630rDHKIZGpezdBCOyHQ4
 jRRSbs0M+sjjE9kR6U1KOIAqdWNNclBDwfTK16towmmi3dC2wPrKnHX4VCVSxEyODlp0
 EQQv9In9x+6GDAlR2r0vcssc9cRQ7F8m2jJqdaxPJLsGVEMcUxgN6sxFC+/ObFjh+n48
 im+fggGxAkCT3VJ0VK1/ju95IxiE9Qvt9K88F0JXxRWV4JjGajgerH8IBhTkQXJ5+0Tc
 EAUA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWKnRAzuvdQ83Ck0SmYqiEDX8ip1jQ4INUhOUlrMpxn7ucozgYC3pdtiAhHlePFKwOK0bOD+Jko6res@nongnu.org
X-Gm-Message-State: AOJu0Yx8IdHWpTgNgATRM2RCs+PKWpJ9uLDzStW3V6H0xSBsw4W7Q/au
 G2zpPUk6Nhf0fmfrq9ommWnEPqp4pWH4HgbmuPXMZ3Uv751+xg6u4tiFQLHqf9o=
X-Google-Smtp-Source: AGHT+IGCNTj+p+9Uj0HSaDGFLGNQBhCxmrexMAAxn3SP1rZiTEqMsuTirItP5FHw0loQwuYI3kMr7w==
X-Received: by 2002:a17:90b:2dc7:b0:2d3:d8b0:967b with SMTP id
 98e67ed59e1d1-2dd80c966b4mr8145055a91.27.1726921312738; 
 Sat, 21 Sep 2024 05:21:52 -0700 (PDT)
Received: from [192.168.68.110] ([187.101.184.93])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2dd7f87ba50sm3779810a91.28.2024.09.21.05.21.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 21 Sep 2024 05:21:52 -0700 (PDT)
Message-ID: <813f43e9-744e-46e3-859a-f9241b29c0b0@ventanamicro.com>
Date: Sat, 21 Sep 2024 09:21:47 -0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 06/10] target/riscv: Add `ext_smdbltrp` in RISCVCPUConfig.
To: =?UTF-8?B?Q2zDqW1lbnQgTMOpZ2Vy?= <cleger@rivosinc.com>,
 qemu-riscv@nongnu.org, Palmer Dabbelt <palmer@dabbelt.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>
Cc: Weiwei Li <liwei1518@gmail.com>, Liu Zhiwei
 <zhiwei_liu@linux.alibaba.com>, Ved Shanbhogue <ved@rivosinc.com>,
 Atish Patra <atishp@rivosinc.com>, qemu-devel@nongnu.org
References: <20240912084832.2906991-1-cleger@rivosinc.com>
 <20240912084832.2906991-7-cleger@rivosinc.com>
Content-Language: en-US
From: Daniel Henrique Barboza <dbarboza@ventanamicro.com>
In-Reply-To: <20240912084832.2906991-7-cleger@rivosinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102c;
 envelope-from=dbarboza@ventanamicro.com; helo=mail-pj1-x102c.google.com
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



On 9/12/24 5:48 AM, Clément Léger wrote:
> This variable is used to determine if the Smdbltrp extension is enabled.
> 
> Signed-off-by: Clément Léger <cleger@rivosinc.com>
> ---

Similar with patch 1, I would also merge this with patch 07 since the bool is
being used there. Thanks,

Daniel

>   target/riscv/cpu_cfg.h | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/target/riscv/cpu_cfg.h b/target/riscv/cpu_cfg.h
> index dd804f95d4..4c4caa2b39 100644
> --- a/target/riscv/cpu_cfg.h
> +++ b/target/riscv/cpu_cfg.h
> @@ -78,6 +78,7 @@ struct RISCVCPUConfig {
>       bool ext_sstc;
>       bool ext_smcntrpmf;
>       bool ext_ssdbltrp;
> +    bool ext_smdbltrp;
>       bool ext_svadu;
>       bool ext_svinval;
>       bool ext_svnapot;

