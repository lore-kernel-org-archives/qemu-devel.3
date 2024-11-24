Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 510A9E6780A
	for <qemu-devel@archiver.kernel.org>; Sun, 24 Nov 2024 21:24:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tFK5J-0004gK-4d; Sun, 24 Nov 2024 16:24:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFK5C-0004fk-Kd
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 16:23:55 -0500
Received: from mail-oa1-x31.google.com ([2001:4860:4864:20::31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1tFK58-0007ax-Fk
 for qemu-devel@nongnu.org; Sun, 24 Nov 2024 16:23:51 -0500
Received: by mail-oa1-x31.google.com with SMTP id
 586e51a60fabf-29680f21217so2235472fac.1
 for <qemu-devel@nongnu.org>; Sun, 24 Nov 2024 13:23:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1732483428; x=1733088228; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=lkRcVJX8wUPYNIA+AGfnhzFYEv0l3JKbkcy87L62QgA=;
 b=mySOxkVTuCxyqm8vshn9gIKpX2HokzcpaTXubjUN1WnYKvEqqubENFENfbHZC+QgIH
 XDawnJAlPqw22jEky+dsJNAUf0upxFUEdFjLYWw1WLk8/L01WOeTw4UZOnEzIESmp3DT
 PVxh5fhh9L6jI3JvmDh3GZwZCtMOzEvUkBTREu5hEcIvCWTFuc2sNNbQ67zhzCdt5nAi
 KON/HfArpdwC3hkz+/DN2cSfN41MXkfdxTWqDFbXDqan5qml3IJQM7VlUKW1e61JVViz
 RFD/qNHmKqkr2ADdiJB2AbX8+1YOiNzCdOolBClHbqUZ8YMbsST8AiaB+xMrZ8TPG5Ln
 tc/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732483428; x=1733088228;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=lkRcVJX8wUPYNIA+AGfnhzFYEv0l3JKbkcy87L62QgA=;
 b=LGBPbfDYI2qrzD9uiYDVdiw5eYFT4JYHUEr1SLnV0Gs/bGNjx0P1oFNqT8ytagAMTX
 1h4h+IkgfTTWfNih8UJcPlJ3HrJ3GXOX6oki0o1hmj/8AAbAcTHB4DiQGdy+7sP1wpvB
 cakI/FGk+C4Hxx6jqhN1X1nJZ351+OC0qr6evI+Ispcig5kA6fHH5FiKh4wzbqGq8vNB
 UxLWuwXq+jOafwEwLKVSqmOGbrfYh0KL/eXHt/EEKhZZR6uzhLTjhDN5+pSjR/HzlnPR
 NRTffDXEFGuQr05UvMa6Eq+dmyKu9FLKPofIp7QaROYpGaNSrEP+jZiYgvOozJ9U4oXV
 6XgQ==
X-Gm-Message-State: AOJu0Yyg0m52yJB+Fa52MCtC3BtatP/LhowOK+82KCmTopltVZ/vaX+U
 I9rodYoTSn+J9K5ReTmkwzKf0cLjU3r2+Xxp7EOJqAz8dvMJKwywlTCUHncHHrs=
X-Gm-Gg: ASbGnctXco2h1Fp7AcO1+q2g/UpliGjyTFIrfx+u8aLzY/WNVNTgBSZAygmoGxQt28L
 vgmJTmx9SilLzso9xrC+irljwSuBh/Ec11rbSaeUt+tpDoSzhH9vxpYt9sS8SGdZYHn/ZN1oE0W
 B7r7usaD8H3rAHvl/rFsqNLqpL0yVkletj5Yp4Q9VuoR84tzPTSbrIdT33qU6+zUljAYyZR+9Q6
 Ozs7Z9hhAwBuASuQtolDTWxGardhEh1FzpJLJcsdrznPgs1rRpwQ2v79wZEuZIXiQ==
X-Google-Smtp-Source: AGHT+IHNfVFZfZbzfdS8jYyQfHkjv7RFDZ8NJPzht80iMAJGc5BUftSyWmG9jcbs4T3rD2nrTeoR7A==
X-Received: by 2002:a05:6871:153:b0:296:ee2e:a23c with SMTP id
 586e51a60fabf-29720af2349mr9221826fac.5.1732483428535; 
 Sun, 24 Nov 2024 13:23:48 -0800 (PST)
Received: from [10.25.0.199] ([187.210.107.185])
 by smtp.gmail.com with ESMTPSA id
 586e51a60fabf-2971d87e96dsm2502995fac.45.2024.11.24.13.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 24 Nov 2024 13:23:47 -0800 (PST)
Message-ID: <501e74e5-72b1-4d0c-8e22-c213dd4a75da@linaro.org>
Date: Sun, 24 Nov 2024 15:23:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/physmem: Fix cpu_memory_rw_debug for armv7m MPU
To: xndcn <xndchn@gmail.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
References: <20241120151515.56884-1-xndchn@gmail.com>
 <20241120151515.56884-2-xndchn@gmail.com>
 <4d3f8a83-7c03-4b48-9a84-d99b88b0d47c@linaro.org>
 <CAJ=gGT3v9WrDButDKP7C_6b7dLnX7AS0Gfyy5x1cLYunJqWBwg@mail.gmail.com>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <CAJ=gGT3v9WrDButDKP7C_6b7dLnX7AS0Gfyy5x1cLYunJqWBwg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::31;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x31.google.com
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

On 11/23/24 22:30, xndcn wrote:
> Thanks. This patch at least guarantees normal read/write access to
> addresses with r/w flags, although there is still a risk of
> misidentifying accessible regions within continuous address spaces.
> 
> Actually, initially I did write a patch with a modified page size as
> an argument, but I soon found that the current implementation of
> armv7a (pmsav7) will return the page size (lg_page_size) as 0 in many
> situations (such as overlapping regions).

0 was arbitrarily chosen as "anything less than TARGET_PAGE_BITS".

> Maybe we can simply make the page size as 2^5 (minimal page size) when
> the returned lg_page_size == 0?

No, don't lie, or make unhelpful guesses at the generic level. The only thing you could do 
for arm m-profile is give accurate information, which for now will be immediately 
discarded as *still* being less than TARGET_PAGE_BITS.  But I do have plans for that.

Anyway, nothing you do with page sizes is helpful along the debug path.  For that, we need 
to swap away from "pages" to "ranges", where some ranges are in fact pages, but others 
aren't.  This means changing the API for cpu_get_phys_<something>_debug.


r~

