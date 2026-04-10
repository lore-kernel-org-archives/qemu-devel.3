Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DEA6F36B9B
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Apr 2026 01:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wB0ss-0000lt-Em; Thu, 09 Apr 2026 21:42:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wB0sm-0000lf-Ev
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:42:04 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wB0sj-0002ix-EX
 for qemu-devel@nongnu.org; Thu, 09 Apr 2026 21:42:04 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2a7a9b8ed69so11818085ad.2
 for <qemu-devel@nongnu.org>; Thu, 09 Apr 2026 18:42:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775785319; x=1776390119; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Tu+LA7A9EJmvbExYvR6W7voJ+kdETZFnnPb+ZY2iiI0=;
 b=iPlqunHjBXiIyfOcBW7uAjawzAfr/tAkL4WrL2O2Awsa6F8FVS99vy50g0zb9RBaqP
 +9Kwz7JiZh8a2XWugVCKE8SCb2ePstooIe3W9b1UA9oybYf3M1f4dnIADeuN29LJBA4i
 K6Qo6SK33DKVt04PlBMq5XKGJPZi6mo3LM3wBqL9DWd8B9afIchnlNp4RuXfABBQoJ9v
 gGTDbAsigM2hBXA/bTYVFm5wxhm639Hu0mtdBOD7ebbEIoE9yKGOV4eNy2ABf46VnbAm
 eU77tT/i333XBF6eO+qlD6dZO36d1VojK9fQ5eooVTl1PF25bPRlFFNnxZr3uf7baR/A
 0gWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775785319; x=1776390119;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Tu+LA7A9EJmvbExYvR6W7voJ+kdETZFnnPb+ZY2iiI0=;
 b=psOuFldRl7LnwplhhoNc7f0hDeXQkwuwDawGz4SIh4woJ03EIR8Vu7xX2t/aSsWgR5
 3l4m/ndWAEZElfU5Oxp+okpDvoM15APNAUX4FopQKKRYhguIluV1D0dru3zgHjqpK+VS
 kSkt6N/ZLd6UoQSAcmFp8SP4oD5CAbT672+IVEi/dBoSlmQ2F5hpRA135ktXsFP+hM5K
 0GWUCIzvwuTx2rcPUFClUQ8iaI1NUTijqOKcykqatzzlZ9FBP2efE+qOxRcp+NyyjZ9G
 Ijk+DQtpe1aAJNK8S5NyzX89nk/RoO6BmJAHBTQbtIKCDOSSNA0lkH3RXZ6cYbmy9hbg
 WOSQ==
X-Gm-Message-State: AOJu0Yyhu4tlp4cQ7rG9ccYZ3bQd4ln6gMgOrAN/V91rurxEKibX+Nm+
 WmP7kIKPkHBc2IWWClenwZVAmk+mUsrAna8vhUmmJQskZyD2Ej+f10zgqqPgjqwFjetK39lJeg7
 nUTXT
X-Gm-Gg: AeBDiesAlgkjRindaWvaGwPw+8JVNF/928qa66SBVNorS9y1d1kv/G8qCpgiqgY5RPm
 qGtkgHrTvsCveW+MAL3vnEohXR5crrmwcqbowwO10U3fbBwd0XavyE2d+4RXPtaFyAc5BKXE48W
 Pj3s/0/AGztBq6BTDfFkMEbiA79PnZq3zuXvUrjc6P2u6MYJPA9GGgoS2KELVOd9TNQvGQJfac4
 esM/H2iJXyjbWG2EurjEK7iidNTufBdOk4r7MjpeJyWqbNbC77EqyfDYS69WHrkHlJengmbSbJG
 U+c89MEZIvBi3gRq9QyXPzyeHQXpw1X/wRbNEsxNLiPLKZdl0/9sEXLBRWaj3ggJw4FE2GdHfrc
 RYOQWa3e3yMfVUrUQ+VPTHZF1CDIIiaV1x2sFJXju9W6KJTPScUSdXrDQNYlBfqZaLQoxEglgq8
 dymqDD9qlH4AMunBJ/e5ngtS0JKs00Kagz/f/q/fmIX3yVyIKLsdYP8zMH+RW8SFFQIBzS9Y1H+
 8g/Ng==
X-Received: by 2002:a17:902:cf05:b0:2b2:42da:25c4 with SMTP id
 d9443c01a7336-2b2d59adee5mr11959555ad.14.1775785319074; 
 Thu, 09 Apr 2026 18:41:59 -0700 (PDT)
Received: from [192.168.1.105] (124-150-69-109.tpgi.com.au. [124.150.69.109])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b2d4f32c76sm8402025ad.67.2026.04.09.18.41.57
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Apr 2026 18:41:58 -0700 (PDT)
Message-ID: <2b61ae1b-0feb-47ef-a134-07030f88f92e@linaro.org>
Date: Fri, 10 Apr 2026 11:41:53 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/6] target/riscv: Implement core SMMPT lookup logic
To: qemu-devel@nongnu.org
References: <20260408140635.42546-1-zhiwei_liu@linux.alibaba.com>
 <20260408140635.42546-3-zhiwei_liu@linux.alibaba.com>
 <CAKmqyKOCRdD5cUvux6W9Z_9fMXiZ0g5s1n6iWp7RkTmZBGvHXw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAKmqyKOCRdD5cUvux6W9Z_9fMXiZ0g5s1n6iWp7RkTmZBGvHXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=richard.henderson@linaro.org; helo=mail-pl1-x62f.google.com
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

On 4/10/26 11:36, Alistair Francis wrote:
> On Thu, Apr 9, 2026 at 12:07 AM LIU Zhiwei <zhiwei_liu@linux.alibaba.com> wrote:
>> +typedef union {
>> +    uint64_t raw;
>> +    struct {
>> +        uint32_t v:1;
>> +        uint32_t l:1;
>> +        uint32_t rsv1:5;
>> +        uint32_t perms:24;
>> +        uint32_t n:1;
>> +    } leaf32;
...
> There is no guarantee in C that these bit fields are packed and laid
> out like you are expecting
...
> and these accesses are not valid.
> 
> On some platforms this will work, but on others it won't
> 
> See the notes here
> https://en.cppreference.com/w/cpp/language/bit_field.html for more
> details

Indeed. Use hw/core/registerfields.h macros.


r~

