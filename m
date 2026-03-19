Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70C881091931
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Mar 2026 23:32:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w3MqF-0008Ru-9X; Thu, 19 Mar 2026 19:31:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3MqD-0008Rd-QQ
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:31:49 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1w3MqB-0003IC-Cd
 for qemu-devel@nongnu.org; Thu, 19 Mar 2026 19:31:49 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-2b0603ee486so10372665ad.0
 for <qemu-devel@nongnu.org>; Thu, 19 Mar 2026 16:31:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773963106; x=1774567906; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ybx6zcDVa17XUYTeWE8lu+X+CZbyJZ6dwu788G/NCW0=;
 b=pHsCDUigx7xiW8er1nWuQ36Z8EpR/3xxkiICKp1hOb886sC4QgGbTpBmVyaDbOhb6H
 G475WnoqqrlIXf9t8CWB+skFoXQe9/tgX/Py8hiJga6wntEHKHmujG2e9NHHFlYIxvfE
 i9rn44MM4qxtxi47Z/ns0fycca/e9rR+nTRgfLExvJBaKjiQCHjq60OVTKx2mWMXE++3
 H0+KZJYN9icmYpfruj+w2lGSkWYrjXlFVS1Nw/7nDfE8D1HZ/2sdOAsFj6iXn6hyby1K
 b33DcvRHwnQD/n4MmppiwDViuUzHq0nQJBlTTVe+TuU5FmKMDrMoEvHRfqUrcSX4rKBX
 Zh4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773963106; x=1774567906;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ybx6zcDVa17XUYTeWE8lu+X+CZbyJZ6dwu788G/NCW0=;
 b=IAGR0I66DuZ8mYukWh29etNeNnYgaF9k9r1vl9kCevVa41bgFFS9D1XWmaXZ1iGaIY
 jZTgJxsx5mXUNoyeaZB2cGGY2EUcKkPqhAnfSPU4RHJ5bHBOhePok+K9fVTokKVctngS
 WUUWbAZ8bTeFfJpjHzmYLKuTUb1xU8S8d28Mui+edO6NOEcTApU2md/Vy1isDTjvpZ4o
 ncGZpmR3xh55UN26gIfo62wAUA89fy0TpUFSozbvJGnXhNEnUsmwbysK44U07sz06mBK
 ATLKGb4hDUsVlKRP0DEIqFYd11EAdGXGqMjaZkywQcXQ5aMVSVYloGupEqIO+zv4fF4o
 EHvQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyARZ0nGD7vfzZa0mYodk2BqaXJE+WdnOyhvlrajiPlrkGKhcedHO6cOEsO8GmWrMZKu1J6IUbWGr7@nongnu.org
X-Gm-Message-State: AOJu0YzjQB3ElDJFw1PWv5chK8dTxSncpHwqKLGhi11xzM8AEFavj0MR
 68wnECYkrouIQ4Ibblt8GiGoOOwCnJXu02l/U2W0XcEY04DB/PUVTz672DI/XIFQ/Lw=
X-Gm-Gg: ATEYQzwBHmFmFgiRsOCLueR4cjrmLZehFXA/1Lii3vWuZc6S9T2iw3BZANVY7YNCQV4
 kjfZcaYlDnEGhoBeB4L4uQACXUDtJkb/fsZQizYzzQ8XQiKxxoYRKObgjqt+xuFjjg2QfBsITwH
 l7+Y/RC+AhycJnYMgnRBFtQBQ3TeULTFWuYf1CJt0iV8XCKLzNf8+kV9Ci2d9Uw/YMnsqGSjm3u
 jLt/EM6hnljIQGrYUf7N8tjTVUoqSrn2d7TdZT3EZUar91tUTBPt4Jx/M3kD9DLgkGERLI0yN2J
 PjZxegPsedNit0HpwCvDCUQkgBx9MqVkdO/jLEDdmkk8CaCLpMApWZd5l+m0LFFWnOnbi+g7ftw
 xS+XmguJly6TytjXlzv6ivmXTtYXRc1QjW2X8wZe5KIfPFUBsOQSGMz20m/aIDMn0qDxZD9Mxgm
 1t8cICppbAVPSZOqFOiyOMzb3ttZTDd1jk0lc=
X-Received: by 2002:a17:902:d510:b0:2b0:4eeb:f810 with SMTP id
 d9443c01a7336-2b082769d79mr8656485ad.31.1773963105523; 
 Thu, 19 Mar 2026 16:31:45 -0700 (PDT)
Received: from [10.5.0.209] ([114.23.167.13]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2b083655718sm2996525ad.39.2026.03.19.16.31.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 19 Mar 2026 16:31:45 -0700 (PDT)
Message-ID: <34ae8827-6bb4-4676-98ba-56c95c0c4bf1@linaro.org>
Date: Fri, 20 Mar 2026 12:31:40 +1300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: duplicating CPUs with memcpy() in cpu_copy() vs memory-allocated
 things in CPUArchState structs
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
Cc: Laurent Vivier <Laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
References: <CAFEAcA9QAyZjjj4kXeC+wM4gg_C+U6Z7McYGrB9u=C1PbiaWZw@mail.gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <CAFEAcA9QAyZjjj4kXeC+wM4gg_C+U6Z7McYGrB9u=C1PbiaWZw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
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

On 3/6/26 06:47, Peter Maydell wrote:
> There are a couple of ways I can see that we could try to fix this:
> 
> (A) We could insist that every target's CPUFooState (env struct)
> must be shallow-copiable, and anything that isn't (pointers, etc)
> needs to be moved out to its FOOCPU (QOM CPU object struct).
> Then we could let targets implement any per-target copying specifics
> in some function in linux-user/$ARCH/ that we call from cpu_copy()
> after doing the memcpy(). This would be painful if there are any
> targets that have something non shallow-copiable that they want
> access to directly from generated code, which has the env pointer
> but not the CPU object struct.
> 
> (B) We could standardize the "end_reset_fields" convention that
> some targets have in their env struct, where an empty struct
> marks the end of the point in the struct where fields can be
> reset by zeroing them. If they can be reset by zeroing they can
> also be safely shallow copied with memcpy(). We could then let the
> target handle anything else via some target hook as above.
> This would require a lot of targets having this field marker added,
> which could be a pain if they don't have their structs ordered in
> a convenient way for this.
> 
> (C) We could say that trying to write generic code that can
> copy a target-specific structure is a fool's errand, and require
> the targets to implement it entirely themselves (only copying the
> stuff in the common CPU base class in common code). If a plain
> memcpy() works for them then their implementation can be simple.
> 
> Any preferences ?
The fixup function, as required by A and B, makes me prefer C.

Surely it's clearer to have

   cc->copy_env(new, old);

than

   memcpy(new, old, some_size);
   cc->fixup_env(new);

especially with the computation of some_size containing some
amount of target-specific peril.


r~

