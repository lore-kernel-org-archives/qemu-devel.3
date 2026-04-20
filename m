Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24525F5A8A1
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Apr 2026 17:35:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wEsWY-0004JP-ON; Mon, 20 Apr 2026 13:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEsWT-0004JF-Ng
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:35:01 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wEsWS-0005FB-75
 for qemu-devel@nongnu.org; Mon, 20 Apr 2026 13:35:01 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-48984d29fe3so12970895e9.0
 for <qemu-devel@nongnu.org>; Mon, 20 Apr 2026 10:34:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1776706498; x=1777311298; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=8TNhTgSb3MVHEeT0xN0XLy428ajVeu/fkK4elHpuOyE=;
 b=HJyKFo/bJ713azcii65zzR54XGWMXVQ9P4PKVkMN28QgAnth5N4MoJbf7WpOpbdxq3
 Z2r0fyudibeNfqzz0eMry+Qga8NvereuDURb/Qv6gB8x93XSRCGf/pcLZlWb2Y4AsZaZ
 zlFZ+VSJLqkKDWc8PyA/dEr3YfPPgxLIYXqUj4erIeHHw41tsjNpgSHRwsumP04N8XCi
 izw/188wOBslL5tN+41WreCtY8Za1hpDQfr9Od5edrk8FGn/Q/6BICZrHSihUPo3TeIs
 re8FQM58r2apNprDcIkkR9yl5uJ9GaOdFslSWtkvn1BpWbymCPzmnAvAQyci/j29hmEZ
 5Kgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776706498; x=1777311298;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=8TNhTgSb3MVHEeT0xN0XLy428ajVeu/fkK4elHpuOyE=;
 b=dnn9YDFvmq/TQcxv/09Yz/X5BJDeAbgmUMAzq3dN1SIb1Uo/zZoA+Rfirh2rAmEoX/
 pXvIPIEvPJBaLaHhJiGxvP/l/ZDMgYQFYjaU7Q095zI87PlZm4XobR5JUDIuN+RBbVKW
 sIsC8SewXJBraCJoWsIzNfq31zUlyHiIzPWmPONWaB8U4c74HbRQ4R8UmNTko/44bC0V
 0CsXAtFudcjsfnD0jqHz+zKqO7gY9EclKeK8mppKXqvDZdrQqzzwAtpgr3PeBfZ14f6h
 AWLGZ4G4hvFMQb70cdOBeDikeLcwe4et5MhJTofhIPnaikLIgoPr78EzbgSno5MSnBB4
 J4bA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XRK71BR+vvC/PzvqcMIdpw/Nh0ow61l4pEJ0QZDWZxBNQVh2hCNhpjNZmMwY7VVyN4ie6zxIM8/ka@nongnu.org
X-Gm-Message-State: AOJu0Yyly5ot3MiCD/avhHoKWPlyj5QkUyz6ODSRx1jNqiXmBIr235/o
 MSuj153t05ZwMXieuQ7FUh3+0gDDYvKzWPZdl0rv5fVD+xhgf+gQ8bo2i+bEBRP97lo=
X-Gm-Gg: AeBDievxz5XTGS+3nYNl7dhRAXtD8rMhfiW86Xsa5P+Lw6IPmCHRaPYoEFVpBWGN7ZK
 XJttrduNm9Kiwkx6tONEc3p900Sy49GsBlPtoLkmuJwYN35UBfn1c8n6Vf/YLDkO3CZ/3dbGbvF
 1ZYIZSopxbA11UpOEx8qG1PAFK1VAksXjXWozWVARINt75yPii+JuBQn3/k8k4TcAWf9kuzOLAG
 Cjw4w68ycy3ky7c2JmfCEdThGHAHBRsgVy2J/bFQvgDZUWHx7VMEX7UgBhjSTroer+fNp7GZzeg
 kSAJxeTF5llxaEQNWwWHBppw7QAPHEQXNx1xfFU87qyo17P+3bmCpeY9IKm9nZldyvP0qCDQQg7
 BXKhJWt2AULhFIT6jGkTQ7OaQ+yacmEZPJtXVutSJEJx251HEfeA9jCLl7NdJiCvwDdYvUjslSQ
 3Xue6zW+8HFMe6RBkjt6GuJPjRPAc6Dqu8f3BFO20nIe3AJPyvYRZuDkmWGMzpDJPKSFPEuKx/k
 C/1w48Ce5+YlwM=
X-Received: by 2002:a05:600c:8b2e:b0:488:b749:8482 with SMTP id
 5b1f17b1804b1-488fb7469b3mr229714715e9.4.1776706498512; 
 Mon, 20 Apr 2026 10:34:58 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488ffad20f2sm118088355e9.0.2026.04.20.10.34.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Apr 2026 10:34:57 -0700 (PDT)
Message-ID: <6997340d-b45f-4609-95c3-c503394c3333@linaro.org>
Date: Mon, 20 Apr 2026 19:34:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] migration/qemu-file: drop incorrect const from
 qemu_get_buffer_at buf
To: Junjie Cao <junjie.cao@intel.com>, qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de
References: <20260420201317.30199-1-junjie.cao@intel.com>
 <20260420201317.30199-4-junjie.cao@intel.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260420201317.30199-4-junjie.cao@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
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

On 20/4/26 22:13, Junjie Cao wrote:
> qemu_get_buffer_at() reads data *into* buf -- it should not be const.
> Drop the qualifier and remove the now-unnecessary cast.
> 
> Signed-off-by: Junjie Cao <junjie.cao@intel.com>
> ---
>   migration/qemu-file.c | 4 ++--
>   migration/qemu-file.h | 2 +-
>   2 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

