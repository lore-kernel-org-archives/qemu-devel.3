Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A77C7EE6B68
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Feb 2026 22:50:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1voUel-0001Pp-2r; Fri, 06 Feb 2026 17:50:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUei-0001Ph-Fr
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:50:28 -0500
Received: from mail-pf1-x42e.google.com ([2607:f8b0:4864:20::42e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1voUeg-0005Ad-IM
 for qemu-devel@nongnu.org; Fri, 06 Feb 2026 17:50:28 -0500
Received: by mail-pf1-x42e.google.com with SMTP id
 d2e1a72fcca58-81e8a9d521dso835678b3a.2
 for <qemu-devel@nongnu.org>; Fri, 06 Feb 2026 14:50:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770418224; x=1771023024; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=rCQ3TWsqeBF3IZ3Rl0GX4n6cJZ5LotzFGr8X617TW/4=;
 b=fL7K4Xwpz8ReybFxF5HkFY1fTqzaCx9rUNTNOFJP4AUCa+w1ANRrml4UAHR4MAgz7+
 9gQq7NsEvmUy+dSt+exjzJytz2h760HRWcVTOtZQVXfQONbRm0hzT9BVNoYwtCPeWIbv
 BE5wKFrCpvZS/aQBh3Ae6maXIujfUjRul2X0d4+QmKlg2015W77EgkMs19tevHtFgPMn
 96r01ExhpE2QBx9J13BCBGf/Mu6RilJyrL2ePnkInAgyB4ejf9chXXcYnbT7eBFSOuKU
 zikz+zsicUJwPgrXSmnqNGuopt4nC7kdDj0JbiExhUBNMpPbZQKhMTKXEAr771JQKUUZ
 jF8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770418224; x=1771023024;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=rCQ3TWsqeBF3IZ3Rl0GX4n6cJZ5LotzFGr8X617TW/4=;
 b=oaxxAYvMXoLe9l6GwXnnb63mfjSvfrGevAsbAJOblxdzS8bXIvaXGIlaTl9lA5CB4v
 A4RheHF9ogNtz8IoW+FCTflDHgUBfi2mJ8No0ZChFx4mA/r0xKNeUg2flWKpFZorTFWp
 4FCVKU/+gqz9SX57eKVcsr+5QhxcfBtcc+Iy72fsdoBYqdW0PdS0JW1qOlj8XzNIA18U
 tZqqBbGF34lUd49czRe2zdnM4f833OZrD3U2odgQ/uDep9vxjuzGRnZrkzm9XI7pkP/t
 TPKXx3PD0HQeSboRwN5yhfzFY6BIdcD88/gyRAAAHvc8OYa2cR8zWuBGiUmXB4eNHyE+
 hL8g==
X-Forwarded-Encrypted: i=1;
 AJvYcCU5D14jNOw8aD3Wrw8H/3v/VGHOafWhbGoWnmyosyceGz3bNFbL1s2R/R856eX+dE7eoSLcpCZBjVbj@nongnu.org
X-Gm-Message-State: AOJu0YzpxJTg5PoAieQj4JM8thn6ZwWEMtfi8LruWNKVvH8xiA52kpsE
 rrBJ0zOhBYJx+g6BdRbyOsJp8bIavQNsLBFLbGdymwcSFWZ9jbS4+KUkE44+mb02erE=
X-Gm-Gg: AZuq6aIkoTjYO32v3H+cOH7L/aFZdK3MIKmU5qncUEG2YfLbG65ZYWqBMqqon04AXl/
 cNP6Y9gHLn3NMBr4yQIq3aE7Xl8OOwLZzX1fSR0K8jZBXd/8w6uVOpgiFQhtUmvc2rYIkAYQHYH
 V7vteERU9aQhLS1AUxAIb6rfxwLtJFunH/BuSqjPDEnYTgGssJSZAWN+PsItzl4uoJKh3Dfjg37
 /j8XtDpeH1/WZwv9wUvUFr7waPPR8OCZSCr7XG/U804cfKrP+qKU/FumZR8nuA79GKua2AsWpBt
 1Jt2heFlU1Li7JNHKaO9Mm7urFwwcmmq7JMwtHCTxNoZPm+H5GTmYEeIoxEGOmmTeFpf/CEm8Ud
 aFq9EMJ5unGepQUYUE+hhdk43wh4dTg/R0dvQWgQUla+tGDM80BjfCOUEjy2W6dkm2yNQBuUIjY
 7eruiG4l7u0l2j/stKsndvVdyBAazxc5dxvzuJDcaFi63NJ/0l34D/F8Lp
X-Received: by 2002:a05:6a00:88c:b0:80a:fc3c:f839 with SMTP id
 d2e1a72fcca58-8244170e1b0mr4035905b3a.49.1770418224059; 
 Fri, 06 Feb 2026 14:50:24 -0800 (PST)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82441677169sm3493855b3a.6.2026.02.06.14.50.23
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Feb 2026 14:50:23 -0800 (PST)
Message-ID: <ce628255-5c7f-4a06-bc2a-b358aaa4ffc6@linaro.org>
Date: Fri, 6 Feb 2026 14:50:23 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/3] Handle some invalid encodings
Content-Language: en-US
To: Brian Cain <brian.cain@oss.qualcomm.com>, qemu-devel@nongnu.org
Cc: ltaylorsimpson@gmail.com, alex@alexrp.com
References: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260206183813.2573541-1-brian.cain@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::42e;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pf1-x42e.google.com
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

On 2/6/26 10:38 AM, Brian Cain wrote:
> Fix the issues reported by Alex Rønne Petersen causing zig test suite
> failures.  The 0x0 case is a conflicting "multiple register write" - the
> handler here will cover duplexes but not the more general case of multiple
> register writes.  I'll include that in a subsequent patchset.
> 
> Brian Cain (3):
>    target/hexagon: Fix invalid duplex decoding
>    target/hexagon: Reject duplex encodings with duplicate dest registers
>    target/hexagon: Return decode failure for invalid non-duplex encodings
> 
>   linux-user/hexagon/cpu_loop.c        |  4 ++++
>   target/hexagon/decode.c              | 28 +++++++++++++++++++++++++---
>   target/hexagon/translate.c           | 18 ++++++++++++++++--
>   tests/tcg/hexagon/invalid-duplex.c   | 28 ++++++++++++++++++++++++++++
>   tests/tcg/hexagon/invalid-dups.c     | 23 +++++++++++++++++++++++
>   tests/tcg/hexagon/invalid-encoding.c | 20 ++++++++++++++++++++
>   tests/tcg/hexagon/Makefile.target    | 23 ++++++++++++++++++++++-
>   7 files changed, 138 insertions(+), 6 deletions(-)
>   create mode 100644 tests/tcg/hexagon/invalid-duplex.c
>   create mode 100644 tests/tcg/hexagon/invalid-dups.c
>   create mode 100644 tests/tcg/hexagon/invalid-encoding.c
> 

Sounds good.

I have one suggestion to improve it. For tests, it would be nice to 
catch SIGILL, so test returns 0 if it worked as expected, or exit with 1 
if SIGILL was not sent. It's just a suggestion though :)

Regards,
Pierrick

