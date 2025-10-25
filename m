Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 920BBCCD1BF
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Oct 2025 18:27:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCiyC-0006uy-6m; Sat, 25 Oct 2025 14:26:28 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCixq-0006iX-2x
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 14:26:08 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vCixl-0002rS-Hd
 for qemu-devel@nongnu.org; Sat, 25 Oct 2025 14:26:05 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b6d402422c2so752405266b.2
 for <qemu-devel@nongnu.org>; Sat, 25 Oct 2025 11:26:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761416759; x=1762021559; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ts2j38OK+dgbdYAETPYQuhRQ1Szff25gZPmkQ/Bglz0=;
 b=T5ck2x2NYjF9DrYM9f2ctWsBMIwwnFn0ivgX/FxvhD8+4JWh91MMGkMwpWyQgHGiD3
 dS9qa7eEjib/yzCJBFlKdsGpLWO3GiBEpZTU07DKVuGBwowgZZYs9gxz/IvtFBJdA2JK
 EIZhJuglIYeKhIZNxF/e9EX8OC5Hy1A+daUOLiD3MDgfzSW1/SPloDEjnDjd88WD/1sX
 GQoQbvOHhX5aF+lEKkstyCsqTpyDmKI2TqjY0Cu2lboCuJ/qFMBUK/FzWIHtzz3pgiRL
 M7rdHFqVB7gOAL3yGRAdO+7mvFeATsEVFCcb950CuJL1jFbS0PMffHt5NCFFqkY3KtPk
 Pg0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761416759; x=1762021559;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ts2j38OK+dgbdYAETPYQuhRQ1Szff25gZPmkQ/Bglz0=;
 b=rDeUW+BuQvA23kabLBjBq0Pyk9CVd4XDhzrf9AeLRgqt8SMgQMjOQYnfO1Q5dwcYkd
 hxdmA9vulnbcH4kv08pzr2JYrv6KCzzE8qowj3Om6mvXcf8O1/FZ2fmpyZ4Gk2E3oq7d
 1QgqTu4HDInavqWsU0N1KOzqnyeFKKtTk/yet0YBL350yuwoezr8cQqfUDIY+xJQQf0Q
 z+Zo8chAOhE3bUj+VyllBaeu0SX2usfP+zmm835vWtXMk3AqbtrhNk+EbVb+Hsq3yS99
 W5kxk4BZfWJ0p6fyY7LZv1jpVm0+2m/hF4qiGQnW0bqr0Ld4uagtaVPhIHwN5IfGOZpb
 sprQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWL/4TirGGnGLh+48CkaaOacmzUS0kU8dVintYlQjFsmD8Z0OorKeRGoM7j2aDOe3U/S7KxlrQHJ9If@nongnu.org
X-Gm-Message-State: AOJu0YzOIVd3SlevilNFevOyHwXousLJPibm8POzNSERyQcl19zmUA22
 c2+u6x+f5KArhBtzPSQMIV2XaduVUyGrzUS6DtRGtd/Pvk7oqOL2hwjf9jQA/sWQx50=
X-Gm-Gg: ASbGncuA2/Fv9mo5iyneczaSRjHH4C6bTIDWt57vuEgfMHCY/P4S78goAogHleE66DF
 WAu9026gazjWrO7/zrnWCc0e0THBLvYpiwM6Kk6GZzc7jrZE76s/ocAXQFNYV/i0Prci+/Y5tqt
 XZ6cH24vo9/61zXLkIcYnki1qfMO+sEF6uOd24Cv9sRybIyf/l8bziN5HMp/L3HZuHTtsfxoBwB
 czJAIhjxUzaoJ8I6n2Un/nL7wNn1skFiOAJUhZP/seWLiAfKbpcI3U4uQs0TBWCP0sd5nn8NHQ1
 RUn+y2gcX4FBcrS3nbBeQERq9ycMFc+1czxUH7E6HeMmL7KnoVoJguYEvX2xLDQZN8Db4ixu+B7
 tky20gsmlJPd/BPPRGyl6MWfbpim4Z4Fj9XqB0pGdjb9YQ0QvsPeUEz0doOA/LY5vmhfB+OXc8t
 Xm4NoJLULptyVqwNmHFSB1Sl4tqlF0Ypqya61a5oE4LZ9qNwohj1hhLWUN3w3CFBKaVTfkiK8dF
 Q==
X-Google-Smtp-Source: AGHT+IHFCQ/RE/oBiJdkb+LqgUFHjTlcPdW/BIXgap6eriaKxMdch9+NdxGfjJuiR98z397ilvk/mA==
X-Received: by 2002:a17:907:2685:b0:b3f:f207:b755 with SMTP id
 a640c23a62f3a-b6471d45a76mr3256861166b.6.1761416759499; 
 Sat, 25 Oct 2025 11:25:59 -0700 (PDT)
Received: from [10.240.88.227] (ip-037-024-071-028.um08.pools.vodafone-ip.de.
 [37.24.71.28]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8541fb5bsm261624466b.56.2025.10.25.11.25.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Oct 2025 11:25:59 -0700 (PDT)
Message-ID: <59eb5630-a91b-46d4-bf0e-f8b763119c00@linaro.org>
Date: Sat, 25 Oct 2025 20:25:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 42/58] target/arm/hvf: Implement dirty page tracking
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 Stefan Hajnoczi <stefanha@redhat.com>, Alexander Graf <agraf@csgraf.de>,
 Peter Collingbourne <pcc@google.com>, Cameron Esfahani <dirty@apple.com>,
 qemu-arm@nongnu.org, Mads Ynddal <mads@ynddal.dk>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Peter Maydell <peter.maydell@linaro.org>,
 Roman Bolshakov <rbolshakov@ddn.com>
References: <20251023114638.5667-1-philmd@linaro.org>
 <20251023130625.9157-1-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251023130625.9157-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=richard.henderson@linaro.org; helo=mail-ej1-x62b.google.com
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

On 10/23/25 15:06, Philippe Mathieu-Daudé wrote:
> +        /* Handle dirty page logging for ram. */
> +        if (iswrite) {
> +            hwaddr xlat;
> +            MemoryRegion *mr = address_space_translate(as, ipa, &xlat,
> +                                                       NULL, true,
> +                                                       MEMTXATTRS_UNSPECIFIED);
> +            if (memory_region_is_ram(mr)) {
> +                uint64_t ipa_page = ipa & TARGET_PAGE_MASK;
> +
> +                /* TODO: Inject exception to the guest. */
> +                assert(!mr->readonly);
> +
> +                if (memory_region_get_dirty_log_mask(mr)) {
> +                    memory_region_set_dirty(mr, ipa_page + xlat,
> +                                            TARGET_PAGE_SIZE);
> +                    hvf_unprotect_dirty_range(ipa_page, TARGET_PAGE_SIZE);
> +                }

We need to use the host page size/mask, not TARGET_PAGE_SIZE/MASK here.

r~

