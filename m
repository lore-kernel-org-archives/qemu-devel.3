Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D05C7C55164
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jul 2026 14:43:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wpRyr-0000QP-4m; Thu, 30 Jul 2026 10:43:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpRym-0000Pq-AZ
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:43:24 -0400
Received: from mail-pl1-x631.google.com ([2607:f8b0:4864:20::631])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wpRyj-0000Wj-D8
 for qemu-devel@nongnu.org; Thu, 30 Jul 2026 10:43:22 -0400
Received: by mail-pl1-x631.google.com with SMTP id
 d9443c01a7336-2cc891373e0so25690685ad.2
 for <qemu-devel@nongnu.org>; Thu, 30 Jul 2026 07:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1785422600; x=1786027400; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=W0NF0nKzNCQ2o/fLvP3GnfiSmOdSPoTeUfgPDtX3uO8=;
 b=ffiR17JDUXa89/zD7Ul5Wm0x7M6dGOLcRkE/G1Y49nMBvS02WaEZiCb0+bbfoaedDd
 SNHnCJatdMPOT/NfHSL0SsdcCKFbuYZnsD5C6oT+kyr57RXs7afIs9wRJtqQEKnxGPka
 DHNuRNmPAvnxnnMqQtYhUSD1IjTQHtXq272fU1l9l3bLQxRrV4CjjTkuIPoijFjOfTsf
 e0iGyJbDdohwkAu7o4GdgQJkd/nLdh1swI9EyM0fO6hCXrzvDNucoAI6psHeer0tYeP+
 wi9c3NVDQRiyVjDlPV+JA8YuFamudc8GELHpOa7jivS2S7rQdGnGYGDo5yyZLuOaV65W
 j4uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785422600; x=1786027400;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=W0NF0nKzNCQ2o/fLvP3GnfiSmOdSPoTeUfgPDtX3uO8=;
 b=lCiseoJxIHsMsG2+sBaW/BACaQXJaWwSqBtlTlu0xgSlBfkC3MuHdDd0bltT5wApFS
 D+6L3ctoWlH46YgZkI3LN/MPenDgqJ3X5X+n/lJYhCGIcypk5ByWMl65Qr9esbkyT5u3
 Mdzj9+wOMFsPa44O9dp4bK2T53Oy+i/On2Co8l/2va62S+t6x/dtTznAxgubXgZdlyUd
 xEjzolb1I4mPXLQEAsjTjWhSfm8NzLWBIBelOG+XtO0BlyuI9jr519yL0eS6Gu5AG3Oi
 nIpfMZoiN7HwxdP5QbHk1yx5U+ysSN6pUmvsou2+SeZUkN7dUBqhdS9h6TeivJOkXIXt
 kz1A==
X-Gm-Message-State: AOJu0YxuBd7ryYTcy4D6TTbINd6LKdsRo1RjM9Fmnwh6pfhM/Wetyyn8
 9nxJWtTSwFNN0+1OyOyDtrXpwOWhDJpgsjhWWPwNjvIPW8N17OeavW4R6i11zm9xgdcQk0calYT
 QnqOm
X-Gm-Gg: AR+sD11DHZou77WPaDJz+drXOnUfhh8uyOIWX/91pgd9aMufZeXVtO9TnKyT/+BaQGg
 37Q/dR4T4QOfDvpUKAann5AFgZshkX+Cp4cJxQFFDRMtHIQxRcxuDZxAiP+gN41dyNr2p0vNPjQ
 v+Ivft4hRY32V0sUQj31DVtzWJpzXHrHyhuvynENrnM4fSB5/DBACGrZTOt15AZ6mF1N4A/eSey
 XTn5noT/Gkyf1pPXk/Rv6pSVmjJn1OLt+fI08bZGh/MCgFoOnLPO7d5O1bIe3yiVT2KkEmsk6vh
 SvQZIpHGK21kHxLiHQr1cuG2CSwDfx924hoZAYO2ii3N1AsWlN2sU5AfBkCod9ghCM5tquOzmMb
 V3/8RvUzl27jInwCA/pK6p1VW8moD42nRxGRCCu8ca4fmLSUV2iP/SxY7yOmhPZKTx0jrIz7u+H
 9IPKWJ7ritIo0ChAjZC+dMS0tUlVwN494LnCGorO7XlUUcU1pP96aBC19MW3Topdv7Znty5g1mQ
 lafuG968AP1+IuBNk9tt3Y0FZQV8kazXAbiShk=
X-Received: by 2002:a17:903:1aae:b0:2cc:9763:e607 with SMTP id
 d9443c01a7336-2d035d1a647mr25494045ad.27.1785422599513; 
 Thu, 30 Jul 2026 07:43:19 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2d022bcad98sm27809775ad.54.2026.07.30.07.43.18
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Jul 2026 07:43:19 -0700 (PDT)
Message-ID: <6c5f2bbf-8855-465f-8eba-9ec9df848d89@linaro.org>
Date: Thu, 30 Jul 2026 07:43:17 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 01/50] accel/tcg: Add bitreverse and funnel-shift
 runtime helper functions
To: qemu-devel@nongnu.org
References: <20260730031025.12926-1-anjo@rev.ng>
 <20260730031025.12926-2-anjo@rev.ng>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260730031025.12926-2-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::631;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x631.google.com
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

On 7/29/26 20:09, Anton Johansson via qemu development wrote:
> +uint64_t HELPER(fshl_i64)(uint64_t a, uint64_t b, uint64_t c)
> +{
> +    Int128 d = int128_make128(b, a);
> +    Int128 shift = int128_lshift(d, c);
> +    return int128_gethi(shift);
> +}

The existing similar opcode is extract2, performing a constant right double-word shift. 
I'm open to adding a variable version, and adding left-shift, but we shouldn't have two 
names for the same operation.

Plus Phil's comment about not doing two things in the same patch.

r~

