Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9270C369C2
	for <qemu-devel@archiver.kernel.org>; Sat,  3 May 2025 22:49:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uBLez-0004iy-Rv; Sat, 03 May 2025 18:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLeq-0004hn-9o
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:48:35 -0400
Received: from mail-pf1-x436.google.com ([2607:f8b0:4864:20::436])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1uBLeo-0000JI-RP
 for qemu-devel@nongnu.org; Sat, 03 May 2025 18:48:32 -0400
Received: by mail-pf1-x436.google.com with SMTP id
 d2e1a72fcca58-72d3b48d2ffso3540952b3a.2
 for <qemu-devel@nongnu.org>; Sat, 03 May 2025 15:48:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746312509; x=1746917309; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=nVS+KycHkuPP8W6uz8n8fLyf7XH6tEMps1l1FLxvTZI=;
 b=ExylOjbvOEg1BKU/8Oo9mL2BiMEkwDwZnVwqmjFs1vjNZ/7ipGOC3CA6nHguzX5419
 rzY5RNyPZRTQki63+CVwkkk6frm0/5XIQ3i2osqUYEVAYzmZvpi8bqohm+Mu7a6SZa9V
 iWBbB8EYImQ2lldMEsQEOgTcZjLQXUBssb24siSFoBx1snYN6N4Vrb5eEJTHvXa0twwH
 fyJop7qM1Vv1MONNsMU5m+ZIldncISdnup7i1CCF8YkATQ3ewzJnHMkG6M8InUYOKsRN
 NvGUs0Enmja6uSzDoyFBuHvo+2No1ZRPr7RHlvZgQgxXboRW9qG3vSMb1ho4kA0QrGNM
 Dc+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746312509; x=1746917309;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nVS+KycHkuPP8W6uz8n8fLyf7XH6tEMps1l1FLxvTZI=;
 b=SH6D/andMy7aUpMm0EPLxbbt8bGXsWEs7NXQDKyYZBC3OYKjDHmhv5/PntFDxc0PRi
 nVtWKxj0TML+MAcfRBjyHqvP/jXuvpQsdZppIjdx2l84hWcvZVBXn1EJAs12odo+jZf8
 /9hjLbobTt/beuyaQlKDaLZ9G2+KQ/DbvxsmKd5hY/Hmvl2WjtpFw7ETSx9gvtpX69zO
 TdYdRhNPFTb8O6oWAyOW+/mmmpOPZuof1Vk7YVTcs8e8IlfHKUP2UfPmvtXCjfvgHaZO
 qDviuhCNIbHBSM3YpIWsOZeNdmT2yAV8W2/zGzZcZl/F94PpFhdYr0c2TkChRf+L+cA8
 VmPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU6mgzyaIRpT6PwDNh7espsiY06v1ehvScqQVpJwAAqwCY2Nq4Ialqmv69L6rVBfEipmVEBZ301bREu@nongnu.org
X-Gm-Message-State: AOJu0YwhMqu456d2DMFMFpV7qKKqYpf7K9ss/dlTtTTcv+OEdPqJKmdX
 P5UsJpTAIPUk4CvQT5Ys2zdWwCSwv4pWuIgee+cS9vB5nKb3zMn7HXWRsw6UTB8=
X-Gm-Gg: ASbGncsRev6bCcvAMLmEi5VLnYkaxW9dusPD+4cqseZB+TWkf5CpTJk96ZmVHwE2qAS
 5uVLDVI1APU2GZAt1zCNVya5v60nY9JiqgWvmEQrIW8wM72hwMV6Sib2zs8Vhgh/WfywLjI/6Xx
 R8KLKyZiWSyOja8b6Lx1OFnwvacu6Zg9pc02AcubZJB/addX8qGGhmnxBgN/R8v1VsBtJ0kKNaq
 DAVEJSs5M/BVKZHjlCaHs9aHltR50y/UNgc0op6I+VNR65qV7wjfoVDtArRplYpG/wCbVCqJ3Jb
 Oa147IcWXPbQeqX0aGOM3uKDIdJuU5NwBfiOSwy+vZacgwYYCLriJg==
X-Google-Smtp-Source: AGHT+IEssVPbixRlA3/C3mZ239uDlY27+FZE+4B5eGQOr+ig8PfKullwsS+MJlf9YXhuC/SqJrnbIQ==
X-Received: by 2002:aa7:8b4a:0:b0:736:62a8:e52d with SMTP id
 d2e1a72fcca58-7406f0df3f2mr2759191b3a.12.1746312509170; 
 Sat, 03 May 2025 15:48:29 -0700 (PDT)
Received: from [192.168.1.87] ([38.41.223.211])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-74058db8f34sm3888793b3a.37.2025.05.03.15.48.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 03 May 2025 15:48:28 -0700 (PDT)
Message-ID: <3ba2f0d8-ce65-48a5-a662-f2350903a5c6@linaro.org>
Date: Sat, 3 May 2025 15:48:28 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 30/33] target/arm/ptw: remove TARGET_AARCH64 from
 arm_casq_ptw
Content-Language: en-US
To: Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>, qemu-arm@nongnu.org,
 alex.bennee@linaro.org, Paolo Bonzini <pbonzini@redhat.com>, anjo@rev.ng,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 kvm@vger.kernel.org
References: <20250501062344.2526061-1-pierrick.bouvier@linaro.org>
 <20250501062344.2526061-31-pierrick.bouvier@linaro.org>
 <a6fdb501-438e-4591-b166-87c8dbd14887@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <a6fdb501-438e-4591-b166-87c8dbd14887@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::436;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x436.google.com
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

On 5/1/25 9:24 AM, Richard Henderson wrote:
> Are we still able to build qemu-system-arm on a 32-bit host with these changes?  It may be
> tricky to check, because the two easiest 32-bit hosts (i686, armv7) also happen to have a
> 64-bit cmpxchg.  I think "make docker-test-build@debian-mipsel-cross" will be the right test.

By the way, I'm usually using debian-s390x-cross for testing a 
HOST_BIG_ENDIAN build. Is that the best choice available?

