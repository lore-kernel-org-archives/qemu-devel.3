Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EBBACAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 07:41:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3rRI-0007HS-72; Wed, 01 Oct 2025 03:39:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rR3-0007Bp-Ca
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:39:40 -0400
Received: from mail-wm1-x335.google.com ([2a00:1450:4864:20::335])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3rQU-0006tp-Cr
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 03:39:36 -0400
Received: by mail-wm1-x335.google.com with SMTP id
 5b1f17b1804b1-46e326e4e99so3300585e9.1
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 00:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759304331; x=1759909131; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=f+dfwnFRSg8jlAAmaCnMvAsR7G4WxJUSpKPLskfagp0=;
 b=dn9l+/mh83O5C3pGZHt1yNFM/wSQzAwsfVVHE3v2QKuVk1j+jjLPAgNA+K470PqWTm
 xMMHo396lAJvpJxa800KAjxOr7I7NO1UBhZiIJTtxf/cPiPLjctIT9Eqae0QHd1xvYYZ
 bSLMUzKC6int/z65LDQdJRI8smfCCvVQPh+pogs59Tt8Ny50OdwtZoMCJBTbYRA3Ztpk
 8rEdarHal82lf3FIL6UA43gWabDViFk+/2TaS8DYzRo55IChh0fZO3pg47autamIxZRu
 gndPHyZGx6zfUZmRaFAT81rmHG+5FGadBL6p2/PPsZQ9+ldAw/OWJYqcnwEE7pfk0UdM
 uvjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759304331; x=1759909131;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=f+dfwnFRSg8jlAAmaCnMvAsR7G4WxJUSpKPLskfagp0=;
 b=SLFqcOBubVJEOakjiSYsv7wG+Yol4hfecLoNo57tk0f68QF9FGZ6rNFQ3v8CMDJYg7
 7GmU7NmipbCKqHRka2fi1G8QAY1ct6DwFDuUsRmrOEg9jbGYbuS7L38I1PlF14nvHdQt
 ccakv81eIUFzXRvlOKeHLpeH3hWsycMnC+pPTNVwZKOpfLqfsm7HGWR0ZvO/c23w/sbD
 lFQrTRitSnaTQdeyHBm5qp67rPj3cZQjMvbrNbx1dl0ijpylA929YHQN3qlUUv/bgzYy
 wr6LIWCvm0ea4XzfaKreHMwiul8rwSBoJ45J7y2iiVBFYLsu1L0BA2hPUpb2c3oPNeaB
 VqNg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVC85DSAwhSxwbjg20kKO0mKAPeMqcAA6THVORHp+GQV06PSYqGqSgqzN1Z9TylpGqFxyWfFZNz1xJP@nongnu.org
X-Gm-Message-State: AOJu0YwfhpiniQezf/rEYPKkxJgJIO49v3HDUaVJf6AQX8mfWx7RIdHD
 aPywlNPhxPEgYWjiEhJ+Fc5zluITT7KF6al5jIPyYRu5ehyY2ycAZBNVsp2JOxN/B10=
X-Gm-Gg: ASbGncttC8ObQDw4hqzXOpvQuKBK7Ms9MXs1JAUD8uPv7Gtpg81hPfP2FPa1MNA3MTu
 jpwkAHokBERfi7d24awkywYw1G13otW37jMWzaquTND/gGBwIclBqN8pewgNPScs2fQpArcu877
 BLGm6XnYFxdw88uWAVTFuXtew+01Far2hf8m/VMaXwwKEhsDNVfB5nyyImMa6BOiPAMXIh6wUjo
 tR4xnvPhKk7aGyjRMQiFQhrtjymttCV4X3xz17jWPtk/kq47YPQrQbhGyLmzVu3Y+c4PN7CSKVw
 +gwAK6e9WRy2eBCqURBXQIx5WCriuQFEfhIEkPX7zhrPsxUnc1o0TAAumUu/IIj3c5BfCfz2Jwv
 mNMkR/LzEUtdu42UXIcNNHqZfQpEdlzfM80XnmLFqiXyrHCJL3KPF/OBDpzPHhIQZsjBksVQDFe
 pIlwZ0QJeh/czyqw==
X-Google-Smtp-Source: AGHT+IFZwXTRaSC2i1avWXk0Mv/VmfsjN5R8HRSOWi4x9Y96NR0qL7AptuzQ4uqUX6tmWuiJMUMW1w==
X-Received: by 2002:a05:600c:3f07:b0:45d:f7df:2735 with SMTP id
 5b1f17b1804b1-46e612c983dmr19823585e9.16.1759304331461; 
 Wed, 01 Oct 2025 00:38:51 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46e5c4c0321sm28255545e9.8.2025.10.01.00.38.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 01 Oct 2025 00:38:51 -0700 (PDT)
Message-ID: <ed12dc41-afcb-410b-91dd-73ce4c958b02@linaro.org>
Date: Wed, 1 Oct 2025 09:38:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 03/33] target/riscv: Fix size of mhartid
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: pierrick.bouvier@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-4-anjo@rev.ng>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251001073306.28573-4-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::335;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x335.google.com
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

On 1/10/25 09:32, Anton Johansson wrote:
> and update formatting in log.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h         | 2 +-
>   target/riscv/cpu_helper.c  | 2 +-
>   target/riscv/machine.c     | 2 +-
>   target/riscv/tcg/tcg-cpu.c | 2 +-
>   4 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/target/riscv/cpu.h b/target/riscv/cpu.h
> index 736e4f6daa..3235108112 100644
> --- a/target/riscv/cpu.h
> +++ b/target/riscv/cpu.h
> @@ -279,7 +279,7 @@ struct CPUArchState {
>       target_ulong geilen;
>       uint64_t resetvec;
>   
> -    target_ulong mhartid;
> +    uint64_t mhartid;
>       /*
>        * For RV32 this is 32-bit mstatus and 32-bit mstatush.
>        * For RV64 this is a 64-bit mstatus.


> diff --git a/target/riscv/machine.c b/target/riscv/machine.c
> index 99e46c3136..328fb674e1 100644
> --- a/target/riscv/machine.c
> +++ b/target/riscv/machine.c
> @@ -425,7 +425,7 @@ const VMStateDescription vmstate_riscv_cpu = {
>           VMSTATE_UINTTL(env.priv, RISCVCPU),
>           VMSTATE_BOOL(env.virt_enabled, RISCVCPU),
>           VMSTATE_UINT64(env.resetvec, RISCVCPU),
> -        VMSTATE_UINTTL(env.mhartid, RISCVCPU),
> +        VMSTATE_UINT64(env.mhartid, RISCVCPU),

The problem is you break the migration stream again. Maybe simpler to
just squash with previous patch?

Thay said, IIUC mhartid is only set once in riscv_hart_realize().
I suspect it is pointless to migrate it.

