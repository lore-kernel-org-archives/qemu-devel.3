Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B22E7F531CE
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Apr 2026 00:42:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wCRqa-0004jz-15; Mon, 13 Apr 2026 20:41:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRqY-0004jV-73
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:41:42 -0400
Received: from mail-pj1-x102d.google.com ([2607:f8b0:4864:20::102d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wCRqW-0005ZZ-Hz
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 20:41:41 -0400
Received: by mail-pj1-x102d.google.com with SMTP id
 98e67ed59e1d1-35da1af3e10so5065080a91.3
 for <qemu-devel@nongnu.org>; Mon, 13 Apr 2026 17:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776127298; x=1776732098; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=9JdWct8YpKUG1mKyRIzfcNED3Hp9tcAqdQ1N++hiHMA=;
 b=ismito6Ix7G2ji+REgv8Wnz7pS7DnXihBddqLz2FD3EohRuQoHHbXPAkOXrS7qQk+f
 QdQTnmmkyHMSiDyKSZMbvfYA6bsEjVnK4tGg+MjBlVb5F2+bf4aFe+rBmsg8avgdhMBe
 PE8fDSsgyoi4igiw5J3Wg+2IyBypEyDBd/6WtGFOmUeQGDgKB8O6ICilpkqc/B+LPHNi
 bTZyr09/JqOgYwawl9DvRsvDyClJMZrnF32bTQBzvlZYlLXQxxrAuUxJ3J5zgu2i9t7W
 6nn2/knVTAiWI1j1MGr+u5k+pbygnAWD9rgy9AisgCO83qmFSiJJijriP/8KWYK8wKoq
 Q2kA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776127298; x=1776732098;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=9JdWct8YpKUG1mKyRIzfcNED3Hp9tcAqdQ1N++hiHMA=;
 b=fZzogy/PPiqN8vV4JiA2+CQP5/IA/y2/RARo+IbDqPxQNNVkYVx2zcIkdgV0apZfLK
 FuIBZc3stJhMxrNN+VsXVaU1DfCIHarXaVtfGpG13eNjqLTOw6C+FB3K2WfbHwt5WKmj
 0tstYMoies3sYCqNDSdQ2DDfJnNsQBNQ+Onr87aZy0r981rpxzu3DJfhyBSdSY6t+zFu
 5OekhnCCMFEg60AlJfAij08ZWZdP8qXahy7rO2eQq1wnZQigxVhI0ijufhNKcHFKEaA7
 Rs/x0paDi8dSN8gRPV2b/XF1wVRekvnARVdNVrkZQKLaidS/qP6P48AXcCaIjW9icQAg
 Qlcg==
X-Forwarded-Encrypted: i=1;
 AFNElJ85sRWxCQkn0r2O+DGq8V8t5aBauGbotsc3zwTWFVBIhXgp3kWb4TMK7pz4/rtfKQW/V/VdOhJdfeqN@nongnu.org
X-Gm-Message-State: AOJu0YwVZcDLWh10ok/9eN80YMT0cQu6BAxq1dzW4dnSwSWDy7fQvgIe
 qwRr7Ba+UY8Lh+3TbU0H7kZJDyE5rlXjZ2xK72vlW0idXMwRE+Lj87PloSDCqazpifs=
X-Gm-Gg: AeBDievf/F07ML4LmwrKssS4Bp/a1uvhcT2SQLpVO/n8WFQFvL3mAJIxSb+ihmaFpYQ
 imV9zgXa9a0+eBwvNmYdPsRijhFIli51GOKTRXfyBR6+NWlwKkJ35lilSilA09dDYcr9l9XZBoV
 m2WKJPVtiSOiP40WeFSfWAB5fHHU32Cya8XdVxMmJxzNa9Q5egNB6HR0XrST7IfbkLpBUQJg/N8
 swp9ItjDqThOLQSLB0qq+YXfjlxOfIdZQseeAOZeb10Ih1FP0ATm2aQ/oM3x21MKBPPv3rb+Ffw
 FsiYjvE8vwPWNuDj4EgAeQ1HICIrDP+jomTRrHwNdVJSd+jYbO3wtbzcwo2m9QSOEPiUdx4bi6g
 jcBMV0bIHfzu8zK/01I2fYMiYwWvdjFN9iNxLsQMfb4Shkv+7824fChsHXvC+pD3JkpnCcmLncF
 ilceJoxzLtE+08rbICmA/8RJeXBq1xFXMiKq7ClR06/qizDamYn9jps0zERoDWrjSQlwajAtW5V
 ACrb1zw7dyUiA==
X-Received: by 2002:a17:90a:d607:b0:359:9014:99e7 with SMTP id
 98e67ed59e1d1-35e4288383emr15589082a91.29.1776127298211; 
 Mon, 13 Apr 2026 17:41:38 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:377f:61ec:6edd:e205?
 ([2401:d002:dc0f:2100:377f:61ec:6edd:e205])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-35fb88b8730sm2102056a91.4.2026.04.13.17.41.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Apr 2026 17:41:37 -0700 (PDT)
Message-ID: <5ba22d1d-d85c-4cd9-be34-e03b74d87a33@linaro.org>
Date: Tue, 14 Apr 2026 10:41:20 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/27] stubs: Rename monitor* -> qmp* files
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20260414003001.97571-1-philmd@linaro.org>
 <20260414003001.97571-2-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260414003001.97571-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::102d;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x102d.google.com
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

On 4/14/26 10:29, Philippe Mathieu-Daudé wrote:
> We use 'HMP' for Human monitor and 'QMP' for 'Machine protocol'.
> These files aren't about human monitor but QMP, so rename them
> for clarity using the 'qmp-' prefix instead of 'monitor-'.
> 
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   MAINTAINERS                                      |  6 ++++++
>   stubs/{monitor-arm-gic.c => qmp-arm-gic.c}       |  0
>   ...nitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} |  0
>   stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c}   |  0
>   stubs/{monitor-cpu.c => qmp-cpu.c}               |  0
>   stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c}     |  0
>   stubs/{monitor-i386-sev.c => qmp-i386-sev.c}     |  0
>   stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c}     |  0
>   stubs/{monitor-i386-xen.c => qmp-i386-xen.c}     |  0
>   stubs/meson.build                                | 16 ++++++++--------
>   10 files changed, 14 insertions(+), 8 deletions(-)
>   rename stubs/{monitor-arm-gic.c => qmp-arm-gic.c} (100%)
>   rename stubs/{monitor-cpu-s390x-kvm.c => qmp-cpu-s390x-kvm.c} (100%)
>   rename stubs/{monitor-cpu-s390x.c => qmp-cpu-s390x.c} (100%)
>   rename stubs/{monitor-cpu.c => qmp-cpu.c} (100%)
>   rename stubs/{monitor-i386-rtc.c => qmp-i386-rtc.c} (100%)
>   rename stubs/{monitor-i386-sev.c => qmp-i386-sev.c} (100%)
>   rename stubs/{monitor-i386-sgx.c => qmp-i386-sgx.c} (100%)
>   rename stubs/{monitor-i386-xen.c => qmp-i386-xen.c} (100%)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

