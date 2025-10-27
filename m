Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72FF4CCF9E5
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Oct 2025 12:42:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vDMYQ-0002zs-8n; Mon, 27 Oct 2025 08:42:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMYO-0002yp-5K
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:42:28 -0400
Received: from mail-wr1-x42c.google.com ([2a00:1450:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vDMYH-0007Zv-Kw
 for qemu-devel@nongnu.org; Mon, 27 Oct 2025 08:42:27 -0400
Received: by mail-wr1-x42c.google.com with SMTP id
 ffacd0b85a97d-4298bada5bdso4219189f8f.2
 for <qemu-devel@nongnu.org>; Mon, 27 Oct 2025 05:42:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761568937; x=1762173737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=RriYUNG7HJhNm8doXgSCka3N8hYdHvEsnqEoJloK74g=;
 b=FGaSlL/uB3L5PaNYrnwVVwwj/bEX21gKCUjZKnZwKRgtmTY3BvF31VP83X0jvw8Dw8
 wmYRlWy1fx0shjB7xm8kqYYGOxFYmanjuvERpwG9UQrFJk7q0vp94R0pNOMt8mpwuepb
 +Jfz5Srd5x8WVg5wI6rLfXWO1xP4/Jsk+jqbKeNVDd/6sX8rFQnbIdaQWXJ41NWS+dXO
 Dq2bP9dHd3iSsxGuFXDhE4Gg4At21aK0wjw4VMyrtRA3HO0wZY+e/NaFThdyWC8x4HF7
 l1V6CHePJdFEdm+WRDuNhHn5e9PIQbmvezccqN9WSIJqJSlTkp9ZPDX15QY+/N9AiEL/
 m6eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761568937; x=1762173737;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RriYUNG7HJhNm8doXgSCka3N8hYdHvEsnqEoJloK74g=;
 b=DF0b+BVwcHrbPPAYc4dg8MLu2bZIKzMO0h6gaE3rd8ufnsEdVuHVdsEKS8F2bCsYkA
 q7abUkJH2NOK0kJH2gDhfh3Q9yXcYBKsJEIeteS9mVX4Ntd2ThRxq2ghIE8kxVU4a6EB
 ZE4ySnP0OdLL24yNt1UGFZ7lY4q7g25zHJLO/yVjbTIu7jf1B7cT6TD9X7jkgTMGJExu
 FBSrUnlDsdA4xR1l4ueyMCmS2olIlyZ4tl8af4z3DBmYNMVzT5EnqT9cHl45r8qKaxN0
 +fQ3q7rjEEYAEtterd5k3cPcK5XIkTEeb45NdchvgvoL8Gl3UkP40YhtlIHe+pzMSV85
 u/qw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbiYvgraDP/8ZoNtRPlAhKkiVfnT/nxB9kknC4+cMccwrjPRlvZHaDH5PK84cJwq1HYjK2+jio9Ov7@nongnu.org
X-Gm-Message-State: AOJu0YyP2FM+M4kice8kmuO38s2+bOrBkXSXM/ML4aEG1g2/MbfW2GKc
 n1VOAW9ZgrdGnDpJ7EDmSKCpj7F7s7JSwuBXAyCLx5/gDXUU+fscShpUtNv6pGly1yMRBJfjzo1
 MhhPf7AY=
X-Gm-Gg: ASbGncsGVfi6BzpusrKvsh2RfFD3QO6dX/e34ZR1XTH+BDKXjLF+L8grH0AR/oR2Wym
 BfrRPx0LaskrBEhLf8EWx6acHEF0UVJLQYlUAe4JPLSja1D/ForWI6JaILbTDVRtBLTHuBnNtsC
 1ZtUwGtZWWTW8JcLkoZUJuJ+dJcX+qsrHafJRjIYmT2Lsygn35OpIXMJ/zY7IOfPwwM0zr+GbSi
 fEit3kHwGb9fDywhGWwHWRheeSpS/0r/567CkTyOxXpjxLP2l6enX7NmNbE/eRcDisrinr5VD57
 BqrvFk0IoFrvQBLJr0elKhnv1O/X17OHbDXd+fV4eAu+0P5eyj5+a3PyFTn5PahxPAsJpAtCcw3
 YqHcT5zzVmNtPM7iOwkT04baj8Gj39m1qGZdmZeWPa+NicofOuyTMtg0rUdNENdPvDdRY6zsQUG
 Ukom9JZnGHgv4O/kt2j9wuYxTOxJhHUPezMJKNdtW7FWE=
X-Google-Smtp-Source: AGHT+IHuKTZs0hpBrvlCOTBI4IYaj0tk44XcJcgE+yeAMthrwQc/wV66eXiA1XGkqgW6D5g6CT0zUA==
X-Received: by 2002:a5d:64c3:0:b0:426:dbef:9abf with SMTP id
 ffacd0b85a97d-42704d8e0b2mr24707820f8f.23.1761568937044; 
 Mon, 27 Oct 2025 05:42:17 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952de5f9sm14149823f8f.38.2025.10.27.05.42.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Oct 2025 05:42:16 -0700 (PDT)
Message-ID: <3e6b7bb6-0509-41c1-aa35-d73ced79e87f@linaro.org>
Date: Mon, 27 Oct 2025 13:42:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 3/3] hw/riscv: Widen OpenSBI dynamic info struct
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, alistair.francis@wdc.com,
 richard.henderson@linaro.org, palmer@dabbelt.com
References: <20251027-feature-single-binary-hw-v1-v2-0-44478d589ae9@rev.ng>
 <20251027-feature-single-binary-hw-v1-v2-3-44478d589ae9@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027-feature-single-binary-hw-v1-v2-3-44478d589ae9@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42c;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42c.google.com
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

On 27/10/25 13:35, Anton Johansson wrote:
> Since fw_dynamic_info is only used for non 32 bit targets, target_long
> is int64_t anyway.  Rename struct to fw_dynamic_info64 and use int64_t.
> 
> Reviewed-by: Alistair Francis <alistair.francis@wdc.com>
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   include/hw/riscv/boot_opensbi.h | 14 +++++++-------
>   hw/riscv/boot.c                 | 22 ++++++++++++----------
>   2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/include/hw/riscv/boot_opensbi.h b/include/hw/riscv/boot_opensbi.h
> index 18664a174b..ab9999be3f 100644
> --- a/include/hw/riscv/boot_opensbi.h
> +++ b/include/hw/riscv/boot_opensbi.h
> @@ -29,17 +29,17 @@ enum sbi_scratch_options {
>   };
>   
>   /** Representation dynamic info passed by previous booting stage */
> -struct fw_dynamic_info {
> +struct fw_dynamic_info64 {
>       /** Info magic */
> -    target_long magic;
> +    int64_t magic;

I wonder why some of these fields are signed; but this is pre-existing,
so for this patch:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>       /** Info version */
> -    target_long version;
> +    int64_t version;
>       /** Next booting stage address */
> -    target_long next_addr;
> +    int64_t next_addr;
>       /** Next booting stage mode */
> -    target_long next_mode;
> +    int64_t next_mode;
>       /** Options for OpenSBI library */
> -    target_long options;
> +    int64_t options;
>       /**
>        * Preferred boot HART id
>        *
> @@ -55,7 +55,7 @@ struct fw_dynamic_info {
>        * stage can set it to -1UL which will force the FW_DYNAMIC firmware
>        * to use the relocation lottery mechanism.
>        */
> -    target_long boot_hart;
> +    int64_t boot_hart;
>   };

