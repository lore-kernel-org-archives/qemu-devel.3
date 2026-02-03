Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6C82E8B36B
	for <qemu-devel@archiver.kernel.org>; Tue,  3 Feb 2026 22:11:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vnOcB-00055z-Js; Tue, 03 Feb 2026 17:11:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnOc7-00054e-JL
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:11:15 -0500
Received: from mail-wr1-x441.google.com ([2a00:1450:4864:20::441])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vnOc5-0002h3-Dn
 for qemu-devel@nongnu.org; Tue, 03 Feb 2026 17:11:14 -0500
Received: by mail-wr1-x441.google.com with SMTP id
 ffacd0b85a97d-43615d9c5d0so537112f8f.1
 for <qemu-devel@nongnu.org>; Tue, 03 Feb 2026 14:11:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1770156671; x=1770761471; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=eVdDXWCg03oIwEjUgKsPXRtroaLZFQasxiGbsPktkBg=;
 b=mwh0KpZ67YJVR3uxB+yFIO/DHxjuUehYyqCjQMEYDBAkcVUc55BF5bjZPk/ddTG+lO
 /Dhn63U71BpSxoVMRdQOKhHuH4BKBNEBTJXBRbzj3DqGnoUqUhnQnnyeZ8v6HDHAfoxw
 RU5Ij0aD0IbvUuocEv0ZVpfUWbllzlpo5lUSmPQ/CmA0k7IrcRxImU8fU3k3EJEcqfXK
 woTtabSEiW9onCqVDNObjAvfw7l6wCM1fTrT6i7RySik2KOM+IC2D2dHPvHW0aWLeOr4
 G61X/tK/6nlqC5UTPRzN6XZtn39RmLn6L09lKIuZOOyjHYQW25LCn7VAvX5Xyh3K1exF
 Bo5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770156671; x=1770761471;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eVdDXWCg03oIwEjUgKsPXRtroaLZFQasxiGbsPktkBg=;
 b=GZaoJxXvKV/47qpQjoyQWtxAQeIcVbhmCO7M3K/ugf02su9SNIcGVRrhKIuL1zdKbd
 RgEtLAlopAzX3keulyAe+hWhMjBvHCuSg2shS7x01r0YL7NBpPVhX6hn8THvYGll1goC
 FwdL3mOsVQXE5B1i7bWxkySwoAbJ+7NU0za4/twKQzt53EaO06clnLg4YidZU9hrqttj
 Id97bTxQw2SpkJmqHzNaIxw00NJqkoV6kPGX9lA8jmClKBW/zU9D2IwgM/GPgY8TDePz
 I6N100legDHRra2aQ3h+R+gPuwFbjXrbqgD+ufN0Z9iUQvfzEXTUDXAc9CNdhYdMGmSs
 Rckg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUL1g53iPLJJ7h8m3LLS77R1OnFMHtesMwOnSfTg5eeIETcThYvzdhfH17r6PaMQVwIc8bGKLUp1BIO@nongnu.org
X-Gm-Message-State: AOJu0YxMmYQg9eX0wSE3mPdW2Zt/31+QO4N9uzhr3Ib4kwbLawvccCD4
 vS7J3Bftbq69osxdhsoUIUSXbh7r58favbUs+VPqTJSVPcKUOO/zuZplYMgb7TXqrAg=
X-Gm-Gg: AZuq6aJ/W6xg3PSpZpIReIi48DU6qffb2rmW8h6FXDG0vnyOLBXhqQvQQP3QiQQCjvB
 YOnne86lprERbUq7wVISBib9srnYdSAtnNX4bUUeUgZxjVVoMYtqZoA7nfpOu3Mbh7+bFwDcefJ
 Cn2S8LYBje1Ahnsq6OL7SqXqmv2yWPqhDCd5gW3w+Q9kHnRujfI2pAYN7yB+4IfLE8HUGXsK4Zs
 dX/uS189m+5f7w61AgzOEE+jrvHDsQ8Bci60Dy8MdY1HHtttvV0JALlqP+EntOvFg30NGW9pcI2
 xXzIzC4JJygVoYh4nKuv2kiytdjgUQs5mRgP/RmYP7KwoAiMsZG1fJIDdLZcbiCxq0o4cEGjMpd
 ZcTHsmK4RbgT91KPSvvi8cFdi2ASwFmDqF9yWA67VJKYP0zQx3YAgBbW1O9Y36NMRKIjhYDBhwp
 qg9ihQJELOzQbaySNu/xUcRn64HFewGEp5ZEvrp4Nef88Je9IMV2zDUC8EsWT51xqQ
X-Received: by 2002:a05:6000:2209:b0:431:53:1f49 with SMTP id
 ffacd0b85a97d-436180534fdmr1147266f8f.41.1770156671257; 
 Tue, 03 Feb 2026 14:11:11 -0800 (PST)
Received: from [192.168.69.210] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43617e263b9sm1655508f8f.4.2026.02.03.14.11.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 03 Feb 2026 14:11:10 -0800 (PST)
Message-ID: <3e6fcc5f-154d-4a71-aa7f-d42f04136616@linaro.org>
Date: Tue, 3 Feb 2026 23:11:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 3/9] hw/virtio: Use VirtIODevice::access_is_big_endian
 field
Content-Language: en-US
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>,
 Nicholas Piggin <npiggin@gmail.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <20260203205637.3109749-1-pierrick.bouvier@linaro.org>
 <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260203205637.3109749-4-pierrick.bouvier@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::441;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x441.google.com
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

On 3/2/26 21:56, Pierrick Bouvier wrote:
> From: Philippe Mathieu-Daudé <philmd@linaro.org>
> 
> Endianness access is constant between device resets.
> Use the field instead of calling the same function.

Maybe we should justify here, simply adding from your v3 comment:

   When doing automated benchmark with fio (see instructions
   in [*]) this resulted in a +1.4% speedup vs existing code.

   [*] https://lore.kernel.org/qemu-devel/20260202185233.GC405548@fedora/

> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> ---
>   include/hw/virtio/virtio-access.h | 24 ++++++++++++------------
>   hw/virtio/virtio.c                |  4 ++--
>   2 files changed, 14 insertions(+), 14 deletions(-)


