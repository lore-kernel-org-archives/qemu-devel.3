Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46CE4D6A22F
	for <qemu-devel@archiver.kernel.org>; Thu, 14 Nov 2024 20:59:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tBgvL-0007LX-PG; Thu, 14 Nov 2024 15:58:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgvG-0007Kv-18
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:58:39 -0500
Received: from mail-pl1-x62a.google.com ([2607:f8b0:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tBgvE-00076A-2D
 for qemu-devel@nongnu.org; Thu, 14 Nov 2024 15:58:37 -0500
Received: by mail-pl1-x62a.google.com with SMTP id
 d9443c01a7336-20ce5e3b116so11020345ad.1
 for <qemu-devel@nongnu.org>; Thu, 14 Nov 2024 12:58:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1731617913; x=1732222713; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1tG6t03luQb3c64VmUxFGkErdydvK9A/U5TyZTaAzmE=;
 b=ifJVNToztMUatOmVcaKBstHYRm04PPeixuFjWwLmhnUgNupCqJ9o5SQwaNNIQY55P2
 0rt9wLZP3cNQjhWrBAAUs2oSABhuEXyHu8pGvD8xG68COsX2U2PF84G+0I2WCyvJrmUS
 rYHS2b6GfbXczbh6IhniAeOGBz+WSQ2rtwE3cTebKdO7lJtiy5YKAmKQo7nAdd1IQt3S
 xr/08abPXZnq6DCsA7VvwsLLlC+L1ybk96VYN7BbrC2KV9YGiaFHGRz1qh4Bq2IqqdsW
 UeD5gig3WovdF5JgPC82/hI6PPuGKvI0A+vOHw+5hiWb9sE7IW/tD1+lJmkuzyjcrB8h
 tblA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731617913; x=1732222713;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=1tG6t03luQb3c64VmUxFGkErdydvK9A/U5TyZTaAzmE=;
 b=Wvsfh/ZflcyD603/hFLPvYMIXR4QP8KQHHGXoxm7m1PX+NVnut/aNW0FNYHQ4bUyo5
 /8XfBt3gBPZgwFEdoTZHC9WPSVAsgy27dr5zCGc/ehUtvvb4dO3dYJFQPjQl5nnXk6cG
 VbZVtb5cwLlW4GavplNmdYtisxv+nDqxwvAungd4Hvm1sJZyZ271t/o3KjyVWdJysNO9
 jW+VH+l+zliOuwlrufLc5S8qEjVXopkj3BYdbjVGaunyJGKJCzVMYkqbbhEOFKMXBt1h
 FqXLqMzYlNi0VbgFkBrfByzJNKSJABZsKeyV7CnQcj0X/UdmCXZE1UQRPvNHY84JDV66
 Sohw==
X-Forwarded-Encrypted: i=1;
 AJvYcCX4NMDdegSpXvkejqm5oEoyGKW0lZPpTWxwhmaz5eKkwXlJhW8AspM4YV66p5UKy4Al57wmtDg/sodt@nongnu.org
X-Gm-Message-State: AOJu0YyI46gltLM5fMRpzF0Y+slTfLnyGr1baKiE2XhihO/NuOsdoric
 oR95beE3wn+dQuMbEcUR5CSKghv8FZe8cogYLCDh7W7cthyOSgM1pOu6ZgHmN97gVhkVSu1SRDr
 r
X-Google-Smtp-Source: AGHT+IFZ3lApQ5mjOG3ZagznTdw5/IP4msONTqYcNkOAACSj/peQpd30mudNyIiq+HFPirGd8CJ8ZQ==
X-Received: by 2002:a17:902:ab91:b0:20c:637e:b28 with SMTP id
 d9443c01a7336-211d0ebfc2bmr2437705ad.39.1731617913628; 
 Thu, 14 Nov 2024 12:58:33 -0800 (PST)
Received: from [192.168.0.4] ([71.212.136.242])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-211d0f6182bsm516055ad.277.2024.11.14.12.58.33
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 14 Nov 2024 12:58:33 -0800 (PST)
Message-ID: <fea58b9b-9fad-4729-9f29-2f05d636d004@linaro.org>
Date: Thu, 14 Nov 2024 12:58:31 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-10.0 v2 00/54] accel/tcg: Convert victim tlb to
 IntervalTree
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
References: <20241114160131.48616-1-richard.henderson@linaro.org>
 <eaa2ecf4-74ce-49e1-846e-8f0c9c16d1af@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <eaa2ecf4-74ce-49e1-846e-8f0c9c16d1af@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62a;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62a.google.com
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

On 11/14/24 11:56, Pierrick Bouvier wrote:
> I tested this change by booting a debian x86_64 image, it works as expected.
> 
> I noticed that this change does not come for free (64s before, 82s after - 1.3x). Is that 
> acceptable?
Well, no.  But I didn't notice any change during boot tests.  I used hyperfine over 'make 
check-functional'.

I would only expect benefits to be seen during longer lived vm's, since a boot test 
doesn't run applications long enough to see tlb entries accumulate.  I have not attempted 
to create a reproducible test for that so far.


r~

