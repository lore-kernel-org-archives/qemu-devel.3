Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70347CAC5B8
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Oct 2025 20:09:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v4Pbm-0006JT-A8; Thu, 02 Oct 2025 16:08:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4Pbi-0006Hy-SI
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:08:55 -0400
Received: from mail-pf1-x42c.google.com ([2607:f8b0:4864:20::42c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1v4PbW-0001zc-TS
 for qemu-devel@nongnu.org; Thu, 02 Oct 2025 16:08:54 -0400
Received: by mail-pf1-x42c.google.com with SMTP id
 d2e1a72fcca58-78af9ebe337so1100437b3a.1
 for <qemu-devel@nongnu.org>; Thu, 02 Oct 2025 13:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759435710; x=1760040510; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=j6WsxfMOkjCcAmLfRVYNdzZX9liC7T+3yZK4Cxq/OlI=;
 b=mN52xHy2BSE1X8GjLN25SlbV/GcYd6eDUN4m65kyTc4HzyR/+2AqcRe55dkVOWPhn8
 08qULCAFPpcgl0KE1JUdWPzaTXLXTeqItzhhMlQ7VI9RYvpb66powJ8PkxyHzy0Q2qLC
 ccOunafPgUIOfEY120zzdQ2t8/yWVhnfrR5/eEXrFY3+e6S5XWtGnD4m9VrcWqIpRa0X
 JSGJLKvZemr42TCvgFEVWshkrGflODMC19FSOL9t86qu5kvio+fc4IRrmdiOh2RDEZZ8
 y/xGkq+t61P42QBpfNaYnyNYfP5RHSm9H2GtIZtiR4BXu5aySQ6Yk2XyFyK3529HzqeM
 1XAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759435710; x=1760040510;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=j6WsxfMOkjCcAmLfRVYNdzZX9liC7T+3yZK4Cxq/OlI=;
 b=sGpYucco+lFa9bkYR62sdVOa7kbpK80qlzs4qAvfeKc1WH3NioGKYcK3fnQQL+PK+P
 gUK8SRjBoSmTJ+EtRd6XxnZCYInrMHUu8hFqBntJj1rKiUIKZvmafka9KD7HR52u8TLW
 mP6Mfmyd93Y4zaWc80+bauMWgWAP/tRbOVX4g7TWtb5Y9PVptBhLSAkL9nGVxUQ7vJVx
 uqYEMMuLL1GHE3o9U0ghQOr+E1MDTo64Gxzrc2QPgzh5IzNrfs19xIvJ2JCG3cZzpe2p
 B924bwolibsOZ79RciTzxdISGtiwIjaoYdho78YVwv6vei+lCaHrKVkOTNQ8V2Hi+JU2
 JOrg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWoohaZikKgSK/rhhlvgHQCqccPXAek1NZKE6HgG4wbCOi8GoizM05WaUnftrgYek1hdx5UMsUgHuju@nongnu.org
X-Gm-Message-State: AOJu0YwxMeycBOtvVKV3NmkprT0r1UZMxgdYH/d8RNYmKp5vgkgMashu
 lXo5wQ8+uJ6QsULzcZueJ/tvogexEAzlpqhMp488A07Mrgs6J32dHkIZslp0iUO7JPI=
X-Gm-Gg: ASbGncuB5Dyu7ueGMdZE7HwRwlc2G9rj4juziFOAOV+oukY4S5UwWmklHBOkJ7L7FpX
 4UNhHPepZ/L34oJeeNuYG0LE3MOQogjkHj6kzMANwTaETQ5I8LegFZeZ2tDCbi2cG4GE37Fl3s8
 aPDKfCYH/wbN71vHLlR2bd2ko2wm6cTdRdxeheIc2XM9WAk/kRKCKRHiF1582i36xmzpxON2+IS
 2LzDeEQJrc0kFO+yewt3tvWbhumUbIBF2hELG1InOx+FbhXW54pEcTmdSKN20ZhRf7a0QFgTyRB
 3wP7mFjg/Z5e0OsgYDMr77I3y3Z+vU/EIrKY8PKcFp9npC3Drd0cFeqnsxztVUx+MOCKShdcUoi
 Il13wmTLsSv0wAEav5U71RFrvxkKv07zhZLy4uvbY5+UD/cdCQ7Rus7kxA4LyyaU=
X-Google-Smtp-Source: AGHT+IEfeiI3Hl0+6A1Mwf3kDwibjs00w3eP/vcZGYbmehizHmGVZExuSrvtV4xRRHS+wiuVx7h0gA==
X-Received: by 2002:a05:6a20:9152:b0:324:6e84:d16e with SMTP id
 adf61e73a8af0-32b620ec7e8mr752817637.43.1759435710490; 
 Thu, 02 Oct 2025 13:08:30 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099afa5fdsm2670121a12.15.2025.10.02.13.08.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 02 Oct 2025 13:08:30 -0700 (PDT)
Message-ID: <4e73e87b-34dc-42ab-b9f4-190d4d585019@linaro.org>
Date: Thu, 2 Oct 2025 13:08:29 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 21/33] target/riscv: Fix size of gei fields
Content-Language: en-US
To: Anton Johansson <anjo@rev.ng>, qemu-devel@nongnu.org
Cc: philmd@linaro.org, richard.henderson@linaro.org,
 alistair.francis@wdc.com, palmer@dabbelt.com
References: <20251001073306.28573-1-anjo@rev.ng>
 <20251001073306.28573-22-anjo@rev.ng>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <20251001073306.28573-22-anjo@rev.ng>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42c;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42c.google.com
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

On 10/1/25 12:32 AM, Anton Johansson wrote:
> geilen takes the values 31 or 63, fix it to 8 bits. hgeie and hgeip are
> at most 64 bits in size, fix to 64.  Update relevant function arguments.
> 
> Signed-off-by: Anton Johansson <anjo@rev.ng>
> ---
>   target/riscv/cpu.h        | 10 +++++-----
>   target/riscv/cpu_helper.c |  4 ++--
>   target/riscv/machine.c    |  4 ++--
>   3 files changed, 9 insertions(+), 9 deletions(-)

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


