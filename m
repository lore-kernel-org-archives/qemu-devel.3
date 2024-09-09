Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA276ECE57E
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 22:14:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snmdx-0001LS-KB; Mon, 09 Sep 2024 18:13:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmdv-0001Ko-AF
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:13:55 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1snmdr-0008Gc-Tt
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 18:13:55 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-374c1120a32so82367f8f.1
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 15:13:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725920025; x=1726524825; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Nx+cMrbotwEPWxi/VhdZc3UyrDm8+YEXwW/4VdSuySw=;
 b=TfhPBT1L6TTfPuPr/WaW/aWCOZkPmstgWJ+3VW4tXK+1hjuPVfs6nCZ4S9EyDueICC
 kGzUoIacnTiXRYO44pO0a+atsrHukmnveqUhINYu98P5zziK6vJL6RJHrqhyHTHjSLOu
 eT/P1ahC1ywZ86AR+cpoa0KPtypQ+R3ZB7RC7iFs56oIzxa6effoW96OLf5vmw2MqCh0
 I8tY2bmc4tY38cvvZG6p19D6ttAoFO3Ht0As6TtWh024EFoLS1qp9T0hjklGQdoYZlPh
 /eVXM/7edFXlnvK/sJXhBDU6Ub22hw7vKyishvIEIseCcwcTTEMAdP0LRGPGbfGz6BzF
 XyjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725920025; x=1726524825;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Nx+cMrbotwEPWxi/VhdZc3UyrDm8+YEXwW/4VdSuySw=;
 b=PnCFn8GRfu1IPHXgXvukZvx9aHkFDe0v8oc5mPah/tUWzd5oSMiceJ6SRphHaOwy+J
 gSK0WLat7m3JS2pknEVef6V3OAT5ocujQjbzO79tlWo8Y1/D12Ec0XXU7MfDFXre3Lb0
 YLnCzokqEqpITZczlH7nOHC03WqkjfkbpK8xMcykLkYWHBtjAtp8+5hanaBFoIKHGULG
 ZYR3qRj2p1qSphxXut79Se4yH33CRwfeid21wDuTwN8a2Qn3ZmZdVQnxBgAWR2ZDkNvp
 0UrJA60vGA6psPAJI5HHDoId+1DzlQDkS7TZiGU2ihspYVYXnIwsEXP/Rts5LKSyEe2N
 whWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVobHq1az5MZJC06rNnY8dF0Y/hbuQEPe8CxEdv8ig3edEWMQFcnv3p/rEETyklbR8auQ20CRa4zSim@nongnu.org
X-Gm-Message-State: AOJu0YzEZj2NKq3AzX0hSD2QxX5cugGLbMi0cy3BmJX2Iq5tF5ASD+v8
 ++b8/Vg8mJkObdqAA6AqDpsuXSf1jAWUfk/vncSQ1UwrYU8cPKdUZfLOQ9v7BV8=
X-Google-Smtp-Source: AGHT+IF+WNxA1H6E3/X1TkERlA3+UV4xTwTs5gwcKp7B6+vs33SFLQSn27ea8dpZWJet3W+ctoGibA==
X-Received: by 2002:adf:f744:0:b0:366:eade:bfbb with SMTP id
 ffacd0b85a97d-37889682e0fmr8078887f8f.46.1725920025229; 
 Mon, 09 Sep 2024 15:13:45 -0700 (PDT)
Received: from [192.168.69.100] (nsg93-h02-176-184-54-166.dsl.sta.abo.bbox.fr.
 [176.184.54.166]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-5c3ebd41c65sm3448218a12.16.2024.09.09.15.13.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Sep 2024 15:13:44 -0700 (PDT)
Message-ID: <1052259f-7809-4974-a5da-1b3dd9fba983@linaro.org>
Date: Tue, 10 Sep 2024 00:13:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 19/26] target/m68k: Split gen_ea_mode_fp for load/store
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: laurent@vivier.eu, daniel@0x0f.com
References: <20240909172823.649837-1-richard.henderson@linaro.org>
 <20240909172823.649837-20-richard.henderson@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240909172823.649837-20-richard.henderson@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x434.google.com
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

On 9/9/24 19:28, Richard Henderson wrote:
> Replace with gen_load_mode_fp and gen_store_mode_fp.
> Return bool for success from the new functions.
> Remove gen_ldst_fp and ea_what as unused.
> 
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>   target/m68k/translate.c | 125 +++++++++++++++++++++-------------------
>   1 file changed, 65 insertions(+), 60 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


