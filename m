Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5A86C369C2
	for <qemu-devel@archiver.kernel.org>; Fri, 25 Apr 2025 10:43:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u8GWZ-0005vT-0m; Fri, 25 Apr 2025 06:43:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GWV-0005u9-Gp
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:43:11 -0400
Received: from mail-wr1-x433.google.com ([2a00:1450:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1u8GWQ-0000Xc-Uh
 for qemu-devel@nongnu.org; Fri, 25 Apr 2025 06:43:11 -0400
Received: by mail-wr1-x433.google.com with SMTP id
 ffacd0b85a97d-39bf44be22fso1408072f8f.0
 for <qemu-devel@nongnu.org>; Fri, 25 Apr 2025 03:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1745577785; x=1746182585; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=JOo2vnxNM8UNjqKhjcq0H8AejpKFIa0Ga+J9yzl4LE8=;
 b=mHvwVzUPGqsGDjTojaXyTCXXAO6pp1f/U6abT7KQ0/ebsYmKT3WVfsTnPe1EOjVpoS
 oEDeHh3tlF2evXAO1kUl+S8aZOmamGzDaJ6f2wZ+SWvJKuKmviy2DslgcQUTZFd67c/h
 BE3DjL5LFyKiN3mwzvmKb+BuIIcJ2jeyEN40B4uaVzswHyANWRw6e7tYEguikmp+D8H6
 ZZvAAOlLLMzfpXSGq36RW1FO4VJRfL3em+0fNAmtYx+73HyvtbLTMTq39eldbTAs1Ntf
 Mlv7oe3X0IYXieTdesQ3lCPUHQBXkX2fl6UhCm5oLuVmq/E9vW2GtFz5DO3scGYEIxEk
 rMVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745577785; x=1746182585;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=JOo2vnxNM8UNjqKhjcq0H8AejpKFIa0Ga+J9yzl4LE8=;
 b=BkdNMmicZgyCGze5rmz9V0O+yE12528bhXCmMSP3q5yGuTibBOAhh38tM+eYdT2KME
 Lt83740IiHT71EfzSGP0qi0Zw/yZrWG7TimC2CZ5AhPtS2aQBEk2ounZ5rq1ZFeuRWZ2
 Mme0l7sX8FxTEfKyOzYxONfl4gOjt5mazP4YT2TmopcPVgjAN2i5/w3N6By4z+0PGJim
 IiLf9Pa8L/ihi+aIEyu9pFXiB8+OO5cDsMc8iv9GLTimImoLG8mfg47RVN+XeRFm0SuU
 X89t0USMZJr1GxegFG1nre8iytPuJJZUcqZpTRwKF/04gaq/YFl7eAvM3ySDW+AHsQYS
 7pXQ==
X-Gm-Message-State: AOJu0Yyw7o0E23BBtSZ+b5oITl8LSVrIcIIDvKfPSo+dRrAuqOiChSQx
 /I6PJ4VMNWZ6Ry4RVPq5fiiSKwfazj5ANq3xNj6E8jCprLxgTXamjYB7R4h8f5iiFxkJ9W3uxip
 H
X-Gm-Gg: ASbGncuFhNum5Lt5rSW96fIqYayc3QzJh2z0QUSZ8nZJe6XV3v2tjiAOQjSbU3G0JaI
 G1DLatA7C+udBliAJnFhou5QsBsI0Q2fHMUrulA165t2HHa1kTrfx/3+rCEh1xY+TB6g9D6LFND
 tpIjFsBWmfJuKNfMnAPMP3wDr2JoyyKlYwUGk1bCgKyef050mlQDq9QPsqIwzEi3AJHaEHynSUX
 PIApke/Zizv45BssDxM65o4QfRKQHI7N5GwoBwqNnVIp/D2YHGpsbxAD099IUfMRkhkGTqDeDF8
 GegNPK2O0sr2buYEkh0s6XgeC0V8/d0+ll1zaMz+gQSklHyLxBT/9vfuR5diIrzLcFHsd4LxYsS
 SNWEEPPFl
X-Google-Smtp-Source: AGHT+IFINrrY71IdZqVRyHyIGy4TPwtkQ7IHo8s+d4Qk3hSPDQwUbGg6BO+iFYIyJzy6cmTY1xlq+w==
X-Received: by 2002:a05:6000:2212:b0:39e:e588:6745 with SMTP id
 ffacd0b85a97d-3a074f0dadamr1548262f8f.46.1745577784804; 
 Fri, 25 Apr 2025 03:43:04 -0700 (PDT)
Received: from [192.168.69.169] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073ca4e50sm2040527f8f.30.2025.04.25.03.43.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 25 Apr 2025 03:43:04 -0700 (PDT)
Message-ID: <1debc1a4-7989-438c-82da-946a73ecb6b1@linaro.org>
Date: Fri, 25 Apr 2025 12:43:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/memory: Remove DEVICE_HOST_ENDIAN definition
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250423111625.10424-1-philmd@linaro.org>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250423111625.10424-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::433;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x433.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_PASS=-0.001,
 T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 23/4/25 13:16, Philippe Mathieu-Daudé wrote:
> Since the previous commit ("exec/memory.h: make devend_memop
> "target defines" agnostic") there is a single use of the
> DEVICE_HOST_ENDIAN definition in ram_device_mem_ops: inline
> it and remove its definition altogether.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
> Based-on: <20250422192819.302784-1-richard.henderson@linaro.org>
> ---
>   include/exec/cpu-common.h | 6 ------
>   system/memory-internal.h  | 3 ---
>   system/memory.c           | 2 +-
>   3 files changed, 1 insertion(+), 10 deletions(-)

Patch queued.

