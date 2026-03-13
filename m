Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C29E107BCCB
	for <qemu-devel@archiver.kernel.org>; Fri, 13 Mar 2026 16:38:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w15Wg-0007uw-24; Fri, 13 Mar 2026 12:38:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WQ-0007Pp-1P
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:38:00 -0400
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1w15WB-0001kT-Ni
 for qemu-devel@nongnu.org; Fri, 13 Mar 2026 12:37:45 -0400
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-2ab077e3f32so11429595ad.3
 for <qemu-devel@nongnu.org>; Fri, 13 Mar 2026 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1773419862; x=1774024662; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UIUlcicR1mbf29bKMZSZ/kGXpse0WHVXcCjTg2mVTS8=;
 b=CuKPkZt4wJssvwNz8DVlayCh6Vd0ZIBHrbdD51EKs/8xe5/oe/sAs3xWRgdGCSIdn9
 sX9qaZOiZcj6duhdUAgbO1j3pkZVlqECWMHmnC5i8U4wEoBnJ5QH7S+isn7N4la3GVFi
 rbGicWgGK8iDd+Ub4ktQrhZW8/PfKh3Ty9KLO7izf0+n6qnvTRo+m8kuXxQLJxi9N6qy
 99o/kZ7lbTpPASm37HeXjFpjzGDKsSC7IScWW+heUKB+nW6J6kddy2FPJOC025UyH8E6
 /SDuoSx1YRdrtAZfh7Yjg2kiSV1VloR4DXvHNKo3d2FHNn4rjfQvr/UZqztcGw55N/P+
 hYpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773419862; x=1774024662;
 h=content-transfer-encoding:in-reply-to:autocrypt:from:references:cc
 :to:content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=UIUlcicR1mbf29bKMZSZ/kGXpse0WHVXcCjTg2mVTS8=;
 b=piXi34Z00qm5kBESIJGuugzhO7upcJ9V9Z+EVzBXYLuCa0ClaWOEp9bV3sw10hcTvT
 I9jx1Qd5Q8yGbj4zO9EEuBVnQ1T+dLFzDg0QiLDGpRZ4lwMsItCQJ4RVRmV065wqG2V/
 SwI3/Q+/TROqczAKHg0QfW2vs+B5M8K0lWhLCYW9wiBBxiUOe3vnw0ou5PcxU+tFNV3b
 rDDKpQiBp9OgiQ6PHFL36tZSgszF5TN2Tr/xumolJ1a1mwHc/vO9bTFfiA8oIjSfT/Ga
 6ejAbZNpUZoFOEzX+YjY+Se+vrEaMPwmEdgN/8ozDTFVejcwx6aM2r0olP+bNJvl2YHT
 cr3A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUgfEt+DyYVpr0num5q40lDG6pSbakqpZKtlwDW6NxDzsG9s9jS+KOVAtu9wnGDCeklx1iIMXUtOmhj@nongnu.org
X-Gm-Message-State: AOJu0YwQr6wIqrHc966kua1kzT4fPE55Qla21u8tMHLqLOxOTawzYBlX
 1tcR9RJ9N7w0ySKyOnnCowz1kMllibMr8Wcu9uEchfL8Fm28nftkM+BavF36yiUVZ1M=
X-Gm-Gg: ATEYQzwwYhWtBk2qyIMJPLdzy4ptjW8+OY38zSrXJU5BjRf0gVgnj0woak/CnZZfnLa
 UwMmuhtQ9dCEV8UKIxgYXYIolMt0Q+xJZ11nnBhW62dTJa4EDf6sDyEp+e1FuPF54VPwrWFkCXe
 oEEJQGpGz4vvK5EartZ3XxgzsIf/kT9fYFac9KHQP1ZI++Bq1KJaxgvCswAF7EMynwWr2pS3sIt
 Vw3vA5MBvYJl+ffTzfyrlnRZ171fOMFgrvArmp6+iiVGSleMD1PcbLCqRELRxUu0DS0SuLr0xJp
 RMxq8YISR9fgpAg2xvNrZAziOCYVReswux+oDSTjEqlOnZYQbNuGeKVKiiwoye9kNmbUXOmfClE
 Jh6dZ/vbluseBuMdlHACXsO+YTdJydTw9/a9w/Yv1epwTz72yUk/3o4ZLg/lwQGuCbla4uojxBp
 +60LnwbsppbSYvltuJ4LgvTo1/0tmXhr/C8CJJvA7TSfhx547zn0tsL0GRvVK7WZV0sv/z
X-Received: by 2002:a17:902:d501:b0:2ae:bd12:f830 with SMTP id
 d9443c01a7336-2aecac9b8e0mr42988175ad.49.1773419862240; 
 Fri, 13 Mar 2026 09:37:42 -0700 (PDT)
Received: from [192.168.1.87] (216-71-219-44.dyn.novuscom.net. [216.71.219.44])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2aece83b35fsm29990225ad.80.2026.03.13.09.37.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 13 Mar 2026 09:37:41 -0700 (PDT)
Message-ID: <67cd5478-1f70-4a53-889c-b90ec7f8c9ea@linaro.org>
Date: Fri, 13 Mar 2026 09:37:41 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/38] target/ppc: Include missing 'exec/target_long.h'
 header
Content-Language: en-US
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Anton Johansson <anjo@rev.ng>
References: <20260313062055.2188-1-philmd@linaro.org>
 <20260313062055.2188-13-philmd@linaro.org>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Autocrypt: addr=pierrick.bouvier@linaro.org; keydata=
 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
 ZtfdHNZotF092MIH0IQC3poExQpV/WBYFAI=
In-Reply-To: <20260313062055.2188-13-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 3/12/26 11:20 PM, Philippe Mathieu-Daudé wrote:
> The "exec/target_long.h" header is indirectly included, pulled
> via "exec/cpu-defs.h". Include it explicitly otherwise we'd get
> when removing the latter:
> 
>    target/ppc/cpu.h:1281:5: error: unknown type name 'target_ulong'
>     1281 |     target_ulong gpr[32];  /* general purpose registers */
>          |     ^
>    hw/ppc/spapr_ovec.h:76:44: error: unknown type name 'target_ulong'
>           76 | SpaprOptionVector *spapr_ovec_parse_vector(target_ulong table_addr, int vector);
>              |                                            ^
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/ppc/spapr_ovec.h | 2 +-
>   target/ppc/cpu.h            | 1 +
>   2 files changed, 2 insertions(+), 1 deletion(-)
> 

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>

