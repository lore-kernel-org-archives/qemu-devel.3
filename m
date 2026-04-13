Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C372E9380E
	for <qemu-devel@archiver.kernel.org>; Mon, 13 Apr 2026 04:09:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wC8c5-0005nW-Al; Mon, 13 Apr 2026 00:09:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8bz-0005mK-3v
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:09:23 -0400
Received: from mail-pg1-x535.google.com ([2607:f8b0:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wC8bx-0004FS-51
 for qemu-devel@nongnu.org; Mon, 13 Apr 2026 00:09:22 -0400
Received: by mail-pg1-x535.google.com with SMTP id
 41be03b00d2f7-c741692db4cso935437a12.1
 for <qemu-devel@nongnu.org>; Sun, 12 Apr 2026 21:09:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776053355; x=1776658155; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=oefSW38xN9MALUbzSeF43j8POVD9JWQv4OHtCnV+W2Y=;
 b=R1e1lAfLYOcoqQXLX36t3iSa/TyboZ6rpeUIfkbnhyT3ujh5HjF3r2+OV5J0D7unPu
 h6G0juk5UvNdZm63EM/k+egC72ikg7GKx07tFtiJ0Mjc30irJmhOs11dabxXtkEXBb5W
 SHNTyaj7OonWuqyfydUHDMhkEQWPyTYOkS/Ym/gtQv9qPcJMa7DJ0Q/Ha9lt1uu8xHXy
 hv1YwS1lvN/Qr4jPbxVG493TG+ZKOvCCyOz8uxRvevz5l835ov9xIumQgPj5jqIpkIiG
 3PneezQRSnsIq5FktztoBqbP4v1CpFSquqkAOiphWISa83JA3Lh/LqToTT8nYiyb3XEA
 FQ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776053355; x=1776658155;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oefSW38xN9MALUbzSeF43j8POVD9JWQv4OHtCnV+W2Y=;
 b=OqeMjSR7SZwO5x1SHZhr9ZfwlK/qJqET/lEdoIrP+iNZwgRX4xVzGPf2Q4yOOXehGV
 LvLIDuPcHDUr7zqlV8aSslZoCg9MPW3Bc4cvuECYVmYysMWVLjBZ7eyhivl05Lminptt
 ISP2xKfBA4sYBXaAYK1og2eiEprTUYFIr6LUNAz8Qp4fusiIdzml3oT5f+KNIjy2+a7r
 8TlQHpqJk4YGM5h+A0/h3YNjC/Xi5MT5ZM3pS8bFtSOjv6hyzTvXfPbZ8kIL6N+r8rQc
 fKZCTkT5QoPAKaFfSCNKZ2jaWoN4Kvtt5guKizeq7w4syD8NFnD7ZY2w4y/HdRjxVesb
 4e3Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Kw3P5gHpRBzWESekNlebunRFumwCB10KzF6aFnScEPZsjYC9JlB69pBXMj129ft3ndrIjePMH32hN@nongnu.org
X-Gm-Message-State: AOJu0YxEHd6gzA4hCdCNRnHKAvMKLNRyN8dVid7L3hZT7QyQLFO+SdBm
 Py+mU2+enbPGJ8cKb4ImTeczrizQWEQPnhJSxf1u8rKFhifFag745sUt6IB5Pof8JLM=
X-Gm-Gg: AeBDies0NbAe65syxGL/aY/7Ug9km5p21OVztNagYFrVfhTw8ZX377sSKrjPwyNYsNT
 WD0N7QVEnxXOwIZcZkHkC2UkOhqQsJoKwT1NCjhRZn0p+MHgKEmd1SA2rssemgZ91VJsSsGLsRb
 rVziDXaapENfwVKlSXsJv8IIsaFZ+l9eEdLWI51IFXxY3ouhwJdlv9VKTkL9YD3WLHidY3lWGlx
 fXTCukIzJMLEC0KxjT/NsuDr5KiyMiGUMI/ixUWkJ1o9GllYw3gEd+ddQRxn0rWc7KN3sFTbHD2
 bc9h+A6uw/50Zz/UtmqE49TObvYKd5MgRk/Y3GkkWVy0wbg9A0OdvrruKRBIaLJWiB1amhhfstf
 l2nWVLtv8d8yIm2M1yo7Qgkk/v/oq1JbvwucznCXF6eVP54CMIPSISvibmNIPgZ8n8XCRGbPsXF
 dLdHuWoOJsNhU6UrzeorQ+4Hw2uhQCb3a1Gxv14jJj0AR+18bQAlswTZtY8U0YY85QvKbIwDXUA
 X7EU9NMuTma4Gf9UWq3CpITZtmT57ufboulOV+onbZTqtG12FYX4Ts=
X-Received: by 2002:a05:6a20:748a:b0:398:6ec6:b06d with SMTP id
 adf61e73a8af0-39fc9631183mr16546757637.34.1776053355060; 
 Sun, 12 Apr 2026 21:09:15 -0700 (PDT)
Received: from ?IPV6:2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f?
 (bg30dj032xp6rdh0yngy.ip6.superloop.au.
 [2401:d002:dc0f:2100:a7b4:d4f1:5b23:321f])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-c79219cb9eesm8899871a12.21.2026.04.12.21.09.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Apr 2026 21:09:14 -0700 (PDT)
Message-ID: <c5abb558-42ed-47bd-877b-942876ee808b@linaro.org>
Date: Mon, 13 Apr 2026 14:09:06 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 11/27] cpus: Introduce
 SysemuCPUOps::monitor_get_register() hook
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-riscv@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, qemu-s390x@nongnu.org,
 kvm@vger.kernel.org, qemu-ppc@nongnu.org
References: <20260410195323.17937-1-philmd@linaro.org>
 <20260410195323.17937-12-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260410195323.17937-12-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::535;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x535.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 4/11/26 05:53, Philippe Mathieu-Daudé wrote:
> Allow targets to register their legacy target_get_monitor_def()
> in SysemuCPUOps; check it first in get_monitor_def() otherwise
> fall back to previous per-target helper.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/hw/core/sysemu-cpu-ops.h | 8 ++++++++
>   monitor/hmp.c                    | 6 +++++-
>   2 files changed, 13 insertions(+), 1 deletion(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

