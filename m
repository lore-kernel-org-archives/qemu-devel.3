Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45543E784BE
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 00:59:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1va1bS-0006B0-VM; Sun, 28 Dec 2025 19:59:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1bL-0006AW-Km
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:59:13 -0500
Received: from mail-pj1-x1035.google.com ([2607:f8b0:4864:20::1035])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1va1bK-0007MP-6X
 for qemu-devel@nongnu.org; Sun, 28 Dec 2025 19:59:11 -0500
Received: by mail-pj1-x1035.google.com with SMTP id
 98e67ed59e1d1-34ccbf37205so6443642a91.2
 for <qemu-devel@nongnu.org>; Sun, 28 Dec 2025 16:59:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1766969948; x=1767574748; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=NHSlXGuLn/FiDCG77u3uzy5vGW6vM7HD6CEVEvVd6R8=;
 b=cec7Lxgi06OOpqZB3fN0bp+Gm+3KkaucegLlre2zTzcOEPYVsPy/dCL0VN7X+mnAgt
 zysb5WcSXv56ANGJIC2L7WRf3sFS7k+5Bt7vGSIn4NdOwRm4Rxp2wLOyGPGK0zrhj98Q
 LcCC04tzxNdBcOG9ehW48I6+7qw2z/7rhC0SpWaOzpdLAueErGNarGaWP8YzNzjw8ca8
 esOwvXQvsVnqxGok5u5VvQzk62E9zCpONeQOZdz4MH1jobGBCTOeVBLlrGSknBlxYZUP
 2nMFoHD7EKxuWfActEGC8ffjUKLUh3M5BAjURX1bbjkzYE33nlVp8Ku8VNyIzhnw0qrS
 dxLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766969948; x=1767574748;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=NHSlXGuLn/FiDCG77u3uzy5vGW6vM7HD6CEVEvVd6R8=;
 b=u6YZYlaZ+SWfCxw2KaJLeoM5wkXtTl25pTHFVVgZeP2r+oHuhJ6cDfUKH8kn+7gJk3
 pJXrRPNIlEY0mybGrvRUcE5hy616UGqCrhedw6LyK4T9EVSxROLNes10aeZ8ComKnE3Z
 mOQut/b1dMXFjF8D5EOf09bqveSHuqz1Cu9RF6gp1SXyXJPmz3cSQyQ/wkX+ou/1U8Ck
 3vClrzofM9EVXwQZ4awGU11THScQE/gYlgliBnebTEBWENiItGYb3nTFGIbb1Nn3hFl7
 jGSW6ISLz8M8w0wnz5nGbrC7EfQ+/yldDwf2piLDbEcrhrPe5KTBVUOcUQu2nS/eQ/PR
 bvyw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXdfUWdZL/htLV5HN+hAwX7+x7ZwEkBs1P6MrE0tItMuxpofgvLYyUUwob0SwmefDSynOzixIZFM3gJ@nongnu.org
X-Gm-Message-State: AOJu0YyzApnem3aEi2wiXQEBZ2YQiNxAjnZ9W83BZk11glbMMP3fiEo3
 S9PumSkxkUFW875WDJsj08EZyw47u1ljMrTk7uJtMxB62HC1u9K1BOEWbWU+yU48crg=
X-Gm-Gg: AY/fxX4+K2rW/2baiMwYPpAfnk+bb1o23yK5MSE8cmFRupF6Fw4Y7KEfgTd8vjQX4D3
 drPY4+MQKaTUQiIn0W91OSse3etMvtQm1lUc11ApOzIXa/QVGJfh8omFCvZbs90nTUayJ4H+Qgz
 FxhdyPEh6en8HrKPKp+ccGXmY1D7rEOAJErRJhYNdNpKvkSj8p0w3+Hc2CrShVKCAQCo1Ibp/XW
 E3i6M9Zr/2CwW+OcT2qDyWwrJCmNKgizxetmPIlTIVasMT/lQhUSM9MJt65nUwDVJvnh5754HqA
 k5lZRm3UwLJPK93bEIZDu553P0bJMpVUsovR3teJhUxhsHrbAwqG7sCO960GPVH7nifkGYv+ELB
 xiypPAKnF6bruxo/YUoj3hZpaxGMtxqXUZI5wv9/HQ2HCnhcGtqXlwrHi2zM/lUGp2fDOf+SsSF
 HbvnCU/dbrgpbvGcDTEnt6Og+EpRPGUY7RwrMleXRK/oxYdNrbsDR7pXa/o+CFxB1XAjyMxQ==
X-Google-Smtp-Source: AGHT+IHXedYbYyWkABnajFgk04WIMicBazgjxtlA/yWYF2OdoCZcP0ETtUtydklmUM+YOf4ZB26fgQ==
X-Received: by 2002:a17:90b:1fcc:b0:34c:6124:3616 with SMTP id
 98e67ed59e1d1-34e921ddcb6mr26934292a91.27.1766969948306; 
 Sun, 28 Dec 2025 16:59:08 -0800 (PST)
Received: from ?IPV6:2406:2d40:40cd:310:f6a1:5e51:f9d7:f095?
 ([2406:2d40:40cd:310:f6a1:5e51:f9d7:f095])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-34e772e16c6sm11433438a91.12.2025.12.28.16.59.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 28 Dec 2025 16:59:07 -0800 (PST)
Message-ID: <056252ee-f74c-456b-8d2e-e02fe76c3e96@linaro.org>
Date: Mon, 29 Dec 2025 11:58:59 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 15/25] system: Allow restricting the legacy
 ld/st_phys() 'native-endian' API
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Anton Johansson <anjo@rev.ng>, David Hildenbrand <david@kernel.org>
References: <20251224152210.87880-1-philmd@linaro.org>
 <20251224152210.87880-16-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251224152210.87880-16-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1035;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1035.google.com
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

On 12/25/25 02:21, Philippe Mathieu-Daudé wrote:
> Guard the native endian APIs we want to remove by surrounding
> them with TARGET_NOT_USING_LEGACY_NATIVE_ENDIAN_API #ifdef'ry.
> 
> Since all targets can check the definition, do not poison it.
> 
> Once a target gets cleaned we'll set the definition in the
> target config, then the target won't be able to use the legacy
> API anymore.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   include/system/memory_ldst_phys.h.inc | 2 ++
>   scripts/make-config-poison.sh         | 1 +
>   2 files changed, 3 insertions(+)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

