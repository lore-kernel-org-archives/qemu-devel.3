Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1112FC61DB9
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Aug 2026 21:50:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wyz2Y-000454-AG; Tue, 25 Aug 2026 17:50:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyz2V-00044i-6t
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:50:39 -0400
Received: from mail-pg1-x52c.google.com ([2607:f8b0:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1wyz2T-0007BB-JY
 for qemu-devel@nongnu.org; Tue, 25 Aug 2026 17:50:38 -0400
Received: by mail-pg1-x52c.google.com with SMTP id
 41be03b00d2f7-cbedf433a99so214647a12.2
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 14:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787694636; x=1788299436; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=BsbgNyctJvQigGQ1Apg8GGI69DkwihkAwnZjXFw1t6I=;
 b=KiE1P8KzX9+1zaQPhRqOZ5U/rYE68FHgp7MK+D8Vwfad1u/IaZJGWARmuLHR+CMwR4
 wTAZUGS209ulUAe1SU10R4Q0pWIFC36Qx1MgwAMNzwNyOH81f4MwTB0u1dVb2LEiH5ev
 lPtTHlqErFVPV7GgAqy9pJoGwaDnM7h8SkGn+EZU9hW7R31ajRT9ZHsTwMkxVv1YGA+9
 LZ65U8JMUh6HdW1p5PtPiOh1WTYjoyiEn4a35/+WKfM9F8PzGv24sWKGd9aKBv3bIcXR
 LXefHNqb0YCmb6RYia/54ygF87b0znS3ZS9wqHobP5pNt5Dc8X9BKdqetAnAdrFO96Pv
 eKzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787694636; x=1788299436;
 h=content-transfer-encoding:content-type:in-reply-to:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=BsbgNyctJvQigGQ1Apg8GGI69DkwihkAwnZjXFw1t6I=;
 b=fwfQ4MyvQoAeduTLW8zVSPyFW3hDIfDPzgNUaEPBMaqdxvlCRHh8ryq3R581X7zKai
 u/oaKM44AoqLuDC08KofiOkKtMqX6XccQZMW4nZJw/9AutZMLq8sjC/hqny6aVqfTLqh
 K+9G2L8d33ADK8lhk4sCIFkQIXoDH6SdCVarObm0IzAT1724NUr8s/XY99BAFyiY2TOe
 44zi4DCp0wrHs3bPML2DjeZge2dLjEWH78INg5Ai6B9gmp5PG6M5W8NzohO4c+FD+S9t
 +bIlJ25oMf0mB/qdIegxfSwh85gyzLgGBMKGV7t2Y7fRIRvZ/C83Id2MvUU6wdf+dkhd
 HhBQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rrvq2iggYcufiAbb5O7rssy/Wi/SLhVceXC1qix5qtqvtfQP+/xqx5DlimW/m/RE+q2qsFvGn8NT8ZE@nongnu.org
X-Gm-Message-State: AFuF++m3WF0LfopePqcNT2LgR3eqb+5imVqfZlJIXRL9gDox0v2tulEo
 wnRRma+qdFOJlgU4LHU2fsmV0ptSFdgR28nhPmKDwQgr5VBkT6akw7F+1I81MyhRaGw=
X-Gm-Gg: AR+sD13d6co7eoFcvQ3ZBVnqWTQ3bxHKs89Erhd4AePCJBYmDoTNE39nWKX6+pV1VlQ
 VHGTIn5WtgsOLP7Nf0uT4sjKfr59ZPoCtOvF4VvjXRQ4Nu4bFle4E2uN5NAhvOu++jGWhfx4ggB
 Fc5iernrxQbFHQN1/aqPzkfEyoNAVmPQ1r4xixlrPGpQm1740Snz9p/xyEsBCWHZRz94v4BpoI/
 HTu83v3ORK7sxMHZZB1p6+oOyxLBoFT3nQfO1RoS94aJMut7nhGlm7NbXeVwbgsox0JTmLZqOgN
 M43u/x//qVo+RbLECVT0rSE40JVQfUUxHs4lzTaWiXhbWlXIMfJsUYoFIhwiTmIOtYQRPyM31XR
 fMt7Q1hgeFAaKP5IJrGRv9dAHnTTkJ7VITw4w8KDzNs5FQRa2H0snalrRhxIh+ngALeWQNzvqde
 TaQ+2RJjwnGtP1Q7wk1zOTIXwU0nm8uEeeU0Z+X8hSqxDeN3/9wCSj3IcLKkzA/mf8PVLj7y7Gi
 y3+ud9bnS+NrUpw4xfvtnnEP0uY
X-Received: by 2002:a05:6a20:1eb0:b0:3bf:b1d3:393e with SMTP id
 adf61e73a8af0-3cf7576b336mr3239166637.2.1787694636064; 
 Tue, 25 Aug 2026 14:50:36 -0700 (PDT)
Received: from [192.168.0.4] (174-21-93-59.tukw.qwest.net. [174.21.93.59])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-cc1beae5b51sm187752a12.3.2026.08.25.14.50.35
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Aug 2026 14:50:35 -0700 (PDT)
Message-ID: <af70d3e6-9a71-4635-8b23-3d2a0e3d1ffc@linaro.org>
Date: Tue, 25 Aug 2026 14:50:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/7] accel/tcg: enlarge the TB jump cache to 64K entries
To: Matt Turner <mattst88@gmail.com>, qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, philmd@oss.qualcomm.com, alex.bennee@linaro.org,
 zhao1.liu@intel.com
References: <20260822190818.1829249-1-mattst88@gmail.com>
 <20260822190818.1829249-3-mattst88@gmail.com>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260822190818.1829249-3-mattst88@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::52c;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x52c.google.com
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

On 8/22/26 12:08, Matt Turner wrote:
> The cost is memory: the cache grows from 64 KiB to 1 MiB per vCPU. That
> is easy to justify for a single-vCPU linux-user process and less obvious
> for system emulation with many vCPUs, so this may want to be sized by
> target or made tunable rather than raised unconditionally.

Why do you believe linux-user processes are single-threaded?  I suppose 
when emulating /bin a fair few of them are, but...


r~


