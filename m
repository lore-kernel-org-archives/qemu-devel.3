Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23AF9C369C2
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Apr 2025 16:44:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7GjZ-0003xJ-DR; Tue, 22 Apr 2025 12:44:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GjY-0003x2-7N
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:44:32 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u7GjW-0001H7-CI
 for qemu-devel@nongnu.org; Tue, 22 Apr 2025 12:44:31 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso35318965e9.3
 for <qemu-devel@nongnu.org>; Tue, 22 Apr 2025 09:44:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745340269; x=1745945069; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=haG/ndO25dOKBnT4wSdlgtPctcLWUCT0CZLIymDzsUI=;
 b=MEKDnu1hbBk/nbrFhOs5VSR5HQTIEAf0bcPumB3m3ZVVx4L+KuyV2lcUqBRlUmmZmf
 pwVw6GfNcMdm9Bujn/2EJnlsHy4Rf8Qv2vxr1ho9m/wabFcqhmDyIR/Gpvm9c/ON2e76
 1ZDRSg96+DZ7/3Uw6GdICkX/vnH55NhTedUPScrPIWkLK3ICmV0EVK4qQq8Z7IrBoUfm
 uExus6P99kzyv73ZmHIhEx3xwZP60p+WUC7fh7eVp/3/15VHfhkTL5eBCeYPIcBdid0x
 aU/mKnm0Dw6uR6fSo2fjpnzpw37q371HoS3idVfDLqmN5S+gtFCfgPhsmVLsamkIDT74
 huHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745340269; x=1745945069;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=haG/ndO25dOKBnT4wSdlgtPctcLWUCT0CZLIymDzsUI=;
 b=pShXjS4rXr4GaxhjQ5ZnbioVLl1eYJug5GPAHrbJxcrKgbEg1TmvFMHqtE1Iwz801I
 y1hw/GiOGebFkqKEGcvkH6myROhDDCK1QyPpfE7K6af4QS38/Q2FBNCWwveZii6ncysx
 aX37aDuK0X6hb20yaDbjcmUEPStg+m+/N9mw8S9kuoexymfo5BLNKizN56pAMWT/Tr0S
 WK6Gb/RWb/mg4ZviBl+2TRYJMYttZ9DCKdcMTPPM9lc9khx2Fv8H04c47wyt3fEv4WQF
 XZfMp16BzfRGmnqhX+3NgoaEcTH44cpZY7j42u6QrYelvwrTg7j2RtNa27vtTaz+VtI1
 fIFg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVqR+6P1LEWlQb8qoMlIYiEonMIUqgDKNS27nBsl1phA1yjh9YThLpba/65FRT0LVxgqhjKvOSN86lC@nongnu.org
X-Gm-Message-State: AOJu0Yxcvm4ZxgeDkhRZTEksj/SLKTuMIurdkOnEC7zM2K4taY6s51za
 dWrQSqLbJGWPTQ6OYbPVBUUxe5vlVNhzh+j2ZKHbvvUEQMT3bfpKruXHNVGNq3Y=
X-Gm-Gg: ASbGncsfMuTDs7R63kChTgt6P5kJYQfTKrLGSsn1wctJ/dmwxBHpazR65OHe3RQdFU0
 zoszOXkbW+ysAJVs8qVuEMoJLrJvo6WmWAIcqUVv3ISS5uoNdqQ6Sq2rHzo98fu7O7zjhQKpg3U
 TgBZglvNGllWj+K995ZyIp8exXrgOEl4HB2cwmJCfo9OnXekE7u/MWWQ7AwJbMibbCN3ZT28mc+
 Ch5JAPfRqN/yjke2v3qAlTk9zOYtG33rcRbGyeaquz2PYEA9QGoUoIDV1uUuJ8K9SPfV1rCg7mx
 RbqVtPy0YmnZi0fvP1qIekRJKhthHHR+AGkeqjaEX+pH6N7bE+UJvQwozFLJXiIYkTcKU2VkxbQ
 S4eDqqLQf
X-Google-Smtp-Source: AGHT+IGcPrVQ83CPo8fug29uctQLp3qPNo/HCxzyGuh5QzLQXVXvTgvFvirBZnSsGTo8cWCJFlkVmA==
X-Received: by 2002:a05:600c:3acf:b0:43d:209:21fd with SMTP id
 5b1f17b1804b1-4406ac2040dmr152189765e9.30.1745340268663; 
 Tue, 22 Apr 2025 09:44:28 -0700 (PDT)
Received: from [192.168.69.175] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4406d5accc2sm182609515e9.14.2025.04.22.09.44.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 22 Apr 2025 09:44:28 -0700 (PDT)
Message-ID: <00b36700-82fb-491e-891c-f39056e7195e@linaro.org>
Date: Tue, 22 Apr 2025 18:44:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 150/163] tcg: Formalize tcg_out_mb
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
References: <20250415192515.232910-1-richard.henderson@linaro.org>
 <20250415192515.232910-151-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250415192515.232910-151-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

On 15/4/25 21:25, Richard Henderson wrote:
> Most tcg backends already have a function for this;
> the rest can split one out from tcg_out_op.
> Call it directly from tcg_gen_code.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   tcg/tcg.c                        |  4 ++++
>   tcg/aarch64/tcg-target.c.inc     |  6 +-----
>   tcg/arm/tcg-target.c.inc         |  6 +-----
>   tcg/i386/tcg-target.c.inc        |  5 +----
>   tcg/loongarch64/tcg-target.c.inc |  6 +-----
>   tcg/mips/tcg-target.c.inc        |  5 +----
>   tcg/ppc/tcg-target.c.inc         |  6 +-----
>   tcg/riscv/tcg-target.c.inc       |  6 +-----
>   tcg/s390x/tcg-target.c.inc       | 20 +++++++++++---------
>   tcg/sparc64/tcg-target.c.inc     |  6 +-----
>   tcg/tci/tcg-target.c.inc         |  9 +++++----
>   11 files changed, 28 insertions(+), 51 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


