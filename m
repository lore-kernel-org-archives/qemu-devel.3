Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23C9DF55454
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 04:52:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vv6sN-0003hA-8p; Tue, 24 Feb 2026 23:51:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6sM-0003gx-8J
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:51:54 -0500
Received: from mail-yw1-x1129.google.com ([2607:f8b0:4864:20::1129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1vv6sK-0000e5-Ok
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 23:51:54 -0500
Received: by mail-yw1-x1129.google.com with SMTP id
 00721157ae682-79801df3e21so61709437b3.2
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 20:51:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1771995111; x=1772599911; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=SYzPhoyo9q1aOgv+RISAC6VG8zgRhjacisSdefDTrfw=;
 b=FG2eoS+9zdO4PCa6h+6haRo2hTRv2wOEFeB9gG4WksmCbjat4JqdourNG0mLuTy1/U
 4Uzj5EBbSBHQZ8a2E2Z+JA2MlgvmNLHfY9V3ssf2qv/BPCK7e5DKQ+BhzZJ++XJys/Ul
 GG5FJGRfVcZaIhmUZZO4kzDYq+V2Y392KVUufI28UUaw5/9bIxPgzGVycQN9DdDu3C3O
 8OuBbqwpN8t6OEkU0RLllFnWtlK+v7vXq9yjA/EGdy656V7RAM79MGMtPl3Y3CS6dCKQ
 mWDXQwGF9baafKSmg2Yrlf9e2ruwORkWvTR+v36Gv87FvYJNhqenlAVFYEDAoZntc4Tq
 NMJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771995111; x=1772599911;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=SYzPhoyo9q1aOgv+RISAC6VG8zgRhjacisSdefDTrfw=;
 b=mrDfUWvr2ZSSbkA1kaAoWM9P64cwHfOI8ML102AkMudoxXcWKoaQq+9aaZFEBovcNT
 aQsH4Gk9lba7fUADGTlcAKKD3pJLA9YYO5d5kS+ihst+lf+2fvObljR6F7v+ZuYZI9MT
 277axeWXNy+681wV9A9b4X1N8VATvCBu1C4VQIxUuoCjJW/UEP/8H6FXGhxjw0q4fkJa
 Zq3T0pQzGz1czFiOXw2X2mhJjgyzD4Er2m+b/WrZmuPSTubmMZe5sEyg3rsp2j1HLS39
 +MbVrqmbdQmtPW59eiKrGfffXosf2wVS4qtvcu+Pl0qC2K3toPeCpV/6joXQ+2JyT4h3
 WvFA==
X-Gm-Message-State: AOJu0YyxXxc3MLYVMiteSBHWtFzXcP+O8JnudslUbs7aNBD/QYmy/Vos
 GhIAMl1lkudDuSElXiAOg7Br4RsulMbdXO8TUnAWp48Kj/2OV8GjQQ3e9AbUHKW8+zfABeOOZh0
 GWL2bcjM=
X-Gm-Gg: ATEYQzyjgp04PxYqc9KNHmqTC+uZ7sOVePzrg63vWV11nUvZ51ZEuy0/oso/6X2FjQU
 xquYRUNOT2KB9aXccNeEp9TyxX8fU49/b3iQG4y9Rb5nsyxLA84wYPWl5CaamzKbOdsToQ6ggJS
 YjF+FFjEeEJr10snuBQkmFX3QP3WiOk+bhUIVwpeQ83uJwu41EsijRVPYADZ3NTVw4IvUgjqMGh
 K5h0nPYjyZ6EN5fLKgEUzG0CtRWkHZ2+AqRIKpF+U7zIcPa/ZwLfIHh+gk9GrnGEK7JAEUKQ5RL
 6YW7fi5Gh9UY40/F3CFiA1fZ6C8S9d9sSnNArcGZEc8ocGAI/9hMmNW1KPWCH3rrvxH50biKDCS
 tarbHoMjhiToTpggNpZzbcH9nryHJZywk1RVzQvlkcpuZbLJIVE0aDViFMe8i9PdrjBCLZCLuqe
 fuov/hDdUTE26xeJS3c5aW7BB0qVconXZXZmZ6Ch+LvODVpw47cvugGBlvmz/wTH8=
X-Received: by 2002:a05:690c:e3c1:b0:798:6542:30f6 with SMTP id
 00721157ae682-798681c5a39mr10695397b3.37.1771995111216; 
 Tue, 24 Feb 2026 20:51:51 -0800 (PST)
Received: from [10.34.149.227] ([172.59.192.107])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-79862083774sm9034687b3.14.2026.02.24.20.51.49
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 20:51:50 -0800 (PST)
Message-ID: <dd2a1db4-f2e5-4273-87be-c5a1e76bcd63@linaro.org>
Date: Wed, 25 Feb 2026 15:51:44 +1100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 5/6] hw/virtio/virtio-qmp: make compilation unit common
To: qemu-devel@nongnu.org
References: <20260225041948.52929-1-philmd@linaro.org>
 <20260225041948.52929-6-philmd@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20260225041948.52929-6-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1129;
 envelope-from=richard.henderson@linaro.org; helo=mail-yw1-x1129.google.com
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

On 2/25/26 15:19, Philippe Mathieu-Daudé wrote:
> From: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> 
> All compile time conditionals have no impact at runtime, since they are
> representing only possible features for devices present at runtime.
> 
> In case they are not present, associated features table will never be
> used. In case they are present but some features are not, matching bits
> will never be enabled, so those entries will be unused.
> 
> Thus, simply expose everything and call it a day.
> 
> Signed-off-by: Pierrick Bouvier<pierrick.bouvier@linaro.org>
> Signed-off-by: Philippe Mathieu-Daudé<philmd@linaro.org>
> ---
>   hw/virtio/virtio-qmp.c | 70 ------------------------------------------
>   hw/virtio/meson.build  |  2 +-
>   2 files changed, 1 insertion(+), 71 deletions(-)

Reviewed-by: Richard Henderson <richard.henderson@linaro.org>

r~

