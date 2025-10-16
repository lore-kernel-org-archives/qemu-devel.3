Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2EE7CCD194
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Oct 2025 12:16:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v9MtK-0005w5-Hg; Thu, 16 Oct 2025 08:15:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9MtD-0005vA-KX
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:15:28 -0400
Received: from mail-wm1-x32a.google.com ([2a00:1450:4864:20::32a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v9Mt1-0007zR-7C
 for qemu-devel@nongnu.org; Thu, 16 Oct 2025 08:15:25 -0400
Received: by mail-wm1-x32a.google.com with SMTP id
 5b1f17b1804b1-46e33b260b9so7519825e9.2
 for <qemu-devel@nongnu.org>; Thu, 16 Oct 2025 05:15:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1760616905; x=1761221705; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/wOBfcMUjLaYAEjydJ7P6gx935CmpKN2fH5eoS9dt1M=;
 b=uT3sXvQ05ibHlWoBNI4pNCy2XDvLRSye+Sgei3SyfWW30xJIpl3bDSQv26PTyuZONd
 8k8fBp4ozGtIAtBjAT4Lbio72ZZ/Y16SVQ4DSm4rBG1WrJKCsSTyeeIlMjT9u+3ZQzCB
 LUqW3stdufStCzaGdXVDYLibUeazOtl76FtT/mFtf5XaYiZojKTf0T1011nXqp7fN3Wm
 buyekTHc54c2uhPqh+bSKvRB1jZqavdtTha/AX+IxZl6RVsVDg5MCVLm97Y0cscKSfIB
 lxK4KW5U/qp6VXS/sjZG6ClnqfzOcMQnZuNHTx1JH6scSlIgHay+eFVtGGNehyXWrc+c
 vL0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760616905; x=1761221705;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/wOBfcMUjLaYAEjydJ7P6gx935CmpKN2fH5eoS9dt1M=;
 b=mMN3yTye5GzSi5vb9zMxYZ3mdNuhWoBN5+V4sEPxWj1jXTqwUNTUQzjEkznYtm/I37
 T3KPxTzEk/f27gSQJE+EII+1Udx/iGvfrdOnXkNqd79XhHqgQLKLACo3C89bTxEs34/R
 vtBsdcGZZb/jfHweRB+CuT5sLsGbNHCLSJIcDeQlx4luq2xORozuzb2uuhk6x4xwos7b
 ueRZ4d2naZ4XtXU3qkLEd3A7U+hTZY3QMCucfywOJrgX4EmBU97KPhBcIgZsecTaVGuT
 1HRexXhqDqoSsC0g+irXTBkcBZ2PFBk9yIjYA21JHiSRYTcKSTgbT15F2v4fHrYsya8u
 jjOw==
X-Gm-Message-State: AOJu0Yy/QZ4JFokY3oNysSqmkdAz/C1L3HdckKSNyl2os0nPMj8y/dM1
 M0JxhtNFZNxP/H2zi+ska5bHAFg0x81NWS7666thuoAEnLAsRKvTwxhqXujznES4HM5PAYqSfJN
 1kmjplj4=
X-Gm-Gg: ASbGnctPTMb8GfJWvik23SKt2FccAR5AY++D6Lzk+r2i0/iVWQxVurynHcCOnA7Jt95
 xNXGseqh1D31KwSY//A/9PaCQ7NzlIYdLdamJPEUNh7Uq0vcETB+UMNUAkvV2btQx31i2D6eIsD
 XDkAo2QqQyrPBpC+KoCSbTqfhbt1XKfjFtfhnn7seu3yGiUUWzdUNjtIgUvDLkDtRKkzcaPMRWt
 ph+utpcACRypT5Ftimj4aFddfFmBQi9Tv7We7erSN/ZciO2IH4+TmQGYEO2bg1NXdwCGPQXjlCm
 K8Uc7Rz6QqQnGaI3FDvSPfzNnWX/U9GBplO6XIkSrwkbegHRt+zt5CX4KtiKCb7o0ZFw3bIkJE/
 UCWkLh9qxVy4cwgzIY3kxWSn69fWFyuHg/1YT/Q9VlHh4C3kOW7gEbPX+HGyqxRN5sG7ehESHnk
 u0Sy74d12AH+oARWMUahDV8fm0CG32552RkzZCVg0Q10kQwg0xXmZzpkAjzA==
X-Google-Smtp-Source: AGHT+IEg8sfT+uIKqlJ3m2BRRSmg98ml1+qbg2ZC5gYJxpDMw4TQpzFdW2Wg+K73zZc9ruQ/7iodMQ==
X-Received: by 2002:a05:600c:354f:b0:471:12c2:2025 with SMTP id
 5b1f17b1804b1-47112c22146mr19596975e9.32.1760616905402; 
 Thu, 16 Oct 2025 05:15:05 -0700 (PDT)
Received: from [192.168.69.221] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-471144d1765sm31800135e9.17.2025.10.16.05.15.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 16 Oct 2025 05:15:04 -0700 (PDT)
Message-ID: <280b3e73-dd5c-45e8-9a97-8a66fd77a62e@linaro.org>
Date: Thu, 16 Oct 2025 14:15:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] target/microblaze: Remove all uses of target_ulong
 type
Content-Language: en-US
To: qemu-devel@nongnu.org
Cc: Anton Johansson <anjo@rev.ng>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
References: <20251015180115.97493-1-philmd@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251015180115.97493-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32a;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32a.google.com
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

On 15/10/25 20:01, Philippe Mathieu-Daudé wrote:

> Remove the left over target_ulong uses in MicroBlaze frontend.
> 
> Philippe Mathieu-Daudé (7):
>    target/microblaze: Remove target_ulong use in cpu_handle_mmu_fault()
>    target/microblaze: Remove target_ulong uses in
>      get_phys_page_attrs_debug
>    target/microblaze: Remove target_ulong use in gen_goto_tb()
>    target/microblaze: Remove target_ulong use in helper_stackprot()
>    target/microblaze: Have compute_ldst_addr_type[ab] return TCG_i32
>    target/microblaze: Have do_load/store() take a TCG_i32 address
>      argument
>    target/microblaze: Convert CPUMBState::res_addr field to uint32_t type

Series queued, thanks.

