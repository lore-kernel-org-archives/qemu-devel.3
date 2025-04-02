Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7220C28B20
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Apr 2025 14:27:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tzz2m-0002Su-EG; Wed, 02 Apr 2025 10:26:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzz2J-0002R6-D0
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:25:47 -0400
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tzz2B-0006bl-SD
 for qemu-devel@nongnu.org; Wed, 02 Apr 2025 10:25:45 -0400
Received: by mail-wr1-x429.google.com with SMTP id
 ffacd0b85a97d-39149bccb69so5987427f8f.2
 for <qemu-devel@nongnu.org>; Wed, 02 Apr 2025 07:25:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1743603937; x=1744208737; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=aVfP5vQagloycdbrJi94vMQgixg8z85JM0ycrLK/NEw=;
 b=ojFjgOJtBkaCwhR8mQ6FAkXkWzLLj8OXLVpnfX7oHVENyEfgKMP6OjFA9eklrGJBjB
 PoB1P70fshyHM6MiXISYKn8KUUZNCzYgLfGc+FtwgoKGAwJG/taOBIYyAw6bi9tY7nfU
 oEXY+CdzHAc5oAstFRFAAXqPgbNqxITAaW79NAdhHwZcjVdy5P/mRyS1Dare2j78XAED
 G9jh+UuioYJPyV+kRau6eAoAS/LRES0V395lCAv6SsdF9xldMa0jxJErB7naldSJOoJu
 O2vnNUwMISyKePVg+ojkA1jJ5uBVtGXo66XECgjpL6yvbTX2GFVcsB6OrNAi5q2hjwGR
 tOmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1743603937; x=1744208737;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=aVfP5vQagloycdbrJi94vMQgixg8z85JM0ycrLK/NEw=;
 b=eB8RRpMKyVBGdogVXNHRnQzxQoRQSMybqgGI6aUbvoTDf+9UFojuxU3Skqqu6ZAxve
 LnAG4seUkhzGOMcRH8GiBQ60YRg6INlxWd7cTJkP7JGPK+hGLBC3pWGSZEZx8murt9z+
 e3ZTQxiShe43po0K15Z1G1yskEbhZXhAkjPbOvxZSuAg8RrVO/5nQnR1NJdQ1VpRDcIE
 5TVV6Xxo3hfy3TcakybQQdfLtJbwRNQb9rK8F/y2CazADTTshd7eO1OZU2vacqQvJmVi
 LY7wvnFbEPG/rO3tWm0uYHE1cCZ/Bi/SSrvTaRa99heyjOlCP9DKOpu8wC4QmVnG0qXA
 E24A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUl0mgcy/RBC65WUzOpWpPJDtQ995mPg29GpDgC9CHOra1tuTQl75Fa3+K0/mwBYLUlW+OfGgR8YdD7@nongnu.org
X-Gm-Message-State: AOJu0Yy5HJWpU4DDIKS2SgqNnj6NzEdfyd8WXFpaZ5eQa3lWwJ4uCV/9
 lnxj0TZTLFvuWF/djkaecQgy+M6VmmI/Hh7ZX6/VTd2tMMxM9N8EZBMPdlYTdCg=
X-Gm-Gg: ASbGncvYXUFcdT6zhp/YlK8rfxZ22Td5TwA5mk/kyIRurmmnl1B4DX5gzc1lsoeNNZc
 HLG4OhgEzPp+V2yUfS89wO+szELuVdCoNFv7JQae/u3zRI3FCP+TU2PBVFg6ZkWRNOk/w905XKw
 EfgyFAipzX+KDSjtNPIzccJ7PZoeK4uK7rzlVKaHwRhASezJG0cTIf9+sQlDPEpjMIFTubdR4FN
 U5uaLrY/IcnBSM7nCuxKcJJ+/sIyi+l9sLK6pcnqbYAMaUuZy9y+3GC04CL6XVbCx1xOj58T3Hy
 jJA1crO9uRl03NX3V/EmSNA9XOgcbnGrHj9m8AeA23kDFvieyAgLX4MqZAQ3klP9AazSHq09AZu
 WnuLP/URuYQRpSuxCxWpeMVA=
X-Google-Smtp-Source: AGHT+IFxW5+8rD2QX8PIoO2bG/PGlri1/BUHwL28htfp/qXi8y4TuaW5IDpu8wotklfyI0LbO4/t3g==
X-Received: by 2002:a05:6000:480d:b0:391:4231:414 with SMTP id
 ffacd0b85a97d-39c297e3f85mr2048249f8f.40.1743603936692; 
 Wed, 02 Apr 2025 07:25:36 -0700 (PDT)
Received: from [192.168.69.235] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-39c0b663860sm17340281f8f.39.2025.04.02.07.25.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Apr 2025 07:25:36 -0700 (PDT)
Message-ID: <43e170ad-d4e3-489d-a049-22361cd34f13@linaro.org>
Date: Wed, 2 Apr 2025 16:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH-for-10.1 1/4] target/riscv: Restrict RV128 MTTCG check on
 system emulation
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-riscv <qemu-riscv@nongnu.org>
References: <20250321155925.96626-1-philmd@linaro.org>
 <20250321155925.96626-2-philmd@linaro.org>
 <2650b68f-e705-4994-9791-0bf8b2e01d74@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <2650b68f-e705-4994-9791-0bf8b2e01d74@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::429;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x429.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 23/3/25 19:08, Richard Henderson wrote:
> On 3/21/25 08:59, Philippe Mathieu-Daudé wrote:
>> Multi-threaded TCG only concerns system emulation.
> 
> That's not really true.  User emulation simply has no option to
> run in a single-threaded context.
> 
> I really don't think we should allow RV128 in user-mode at all.
> Certainly not until there's a kernel abi for it.

It seems to be safe since commit 905b9fcde1f ("target/riscv: Replace
is_32bit with get_xl/get_xlen"):

  #ifdef TARGET_RISCV32
  #define get_xl(ctx)    MXL_RV32
  #elif defined(CONFIG_USER_ONLY)
  #define get_xl(ctx)    MXL_RV64
  #else
  #define get_xl(ctx)    ((ctx)->xl)
  #endif

Should we undefine MXL_RV128 on user-mode?

