Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961DAEA8536
	for <qemu-devel@archiver.kernel.org>; Sun,  8 Mar 2026 17:19:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzHlx-0001MR-DA; Sun, 08 Mar 2026 13:18:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzHlu-0001M5-Oq
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:18:30 -0400
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vzHlt-0002er-9Y
 for qemu-devel@nongnu.org; Sun, 08 Mar 2026 13:18:30 -0400
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-48534e9076fso3362945e9.0
 for <qemu-devel@nongnu.org>; Sun, 08 Mar 2026 10:18:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772990307; x=1773595107; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=alc0N1N1wtTVu/xCCt9xPuL7HmUCinUEadr0TbLOnOg=;
 b=QipEHMsUNDXhXGP+QudnE16JVdeMfrWY9jFj6z+2VIe4/I+J6xWtamau1HoCUASRXc
 2gag0s0nv0Tgp5CwsFNXBanHx7JTDJ8qTORoUjpzEnVdpvottD68JZFJn+YZqt/jXaLZ
 dpTOJW51yU9A5G4VWUVKjZxFJFraF2Nd5WYpepxQ17d5cxzlsawajHWvYzsc6WsecIRL
 3nTZpQ5lpi/HuUhkk8fDIwGGdvspzVyCwt5JyqifXhC0UZoc3ranVh+wjYv8UVNhWArb
 9RJmfxFJvOru4Lj1LCofVKdm+o0tG5QR1CwJQEvEuoggbTdZedkgslCnP4F/RR3uowzs
 YWQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772990307; x=1773595107;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=alc0N1N1wtTVu/xCCt9xPuL7HmUCinUEadr0TbLOnOg=;
 b=QnbQBkEo0u+H8iwRIYzTlsiGwhvFKuDmd6eq8LO7U2awxS8myflO+SGVfa/emws/4G
 VCgsMsCghRwRMcDCNjOwBVAREbDroriOppHeef2apKg+FDwF2yRi9D53J5pKMQ5qmMCh
 TsJWdieiU+jqqgr5CsDiTfZkbPD9v7mr/foaCBflAV74q6kDgHiWkgQgxbOOpXBWt0dD
 sDMVf2DSRM3ZGU45SHdIE0Y2xdDD9vmhZJry/BW4js2m+9HxQwuuQ4qjMshStTIL0Uoe
 uJQBpS1e1sc2CHm/v0urVb/nZvy9aW0yxQCW8d9MHU1Ga4zIw8KQVY8yBDsIGjejzSPK
 UtLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjzUmgbomyV033IZih0ZWVGcPH1d8Yho290mhyshMMN7XUNRxA+u2q+OHD0srdTYeuXbQURRIA37/G@nongnu.org
X-Gm-Message-State: AOJu0YxzFB7VF3dYkfq9jTdK1nkdS1aT3tZmkw47KiBHC1DAUZfGt2rt
 FXj7wC1NFdzHJuOxfx5hxIMoZBO5fbgLegiXNZj88OKKhlrEnH1ICZgslXHzKVyBuOs=
X-Gm-Gg: ATEYQzxlZlgvMpRlmNi0hyU6yaXuhAOznv75OrROv/G7FS8H4GYWd10qleSnJ8FOSIs
 tye7Bz0Qd5qoHY3IUgNsI+/RtuiLYdt7Ve4FUk2LRT+/vGqhzHlMn7dhVN7MA/aiUJVwFF/mhIX
 LNlSc6MruhkzFsli/UI+Vhev30OOisbTGKw5nZiHTJsRWmoEbOM79GflKTTnhSYsf2JQHPFlmIy
 azOvxbCqyhIoMLMiITrHZcBR1YxZAVvkc0Y6tR5RpDOQNjLxg4kN0BGtMwyRxHFQ9tDgz3YB4/p
 XwLMF6J9eFoMD9MMwnyeMAm5k5Nt6MgqkhkEnzLj8wcsNp8BTS1JLcWdR0juoUy3b7Ae/tdBmzW
 aaabMulfH3Tqo8KvbX/4MSjJJOEAkq1LOXkM7J3Yt3Th4U8tCHfMkw20VzPcSSgxcADmaA2Pxea
 kEh752F4kaSgDjM8Yyu7JIu0SNOZwm1BKSlT2aOeff+yQLlTc+UtAts3dH2/quY5TQCg==
X-Received: by 2002:a05:600c:1e2a:b0:483:c771:10e with SMTP id
 5b1f17b1804b1-48526957d6cmr140192625e9.20.1772990306341; 
 Sun, 08 Mar 2026 10:18:26 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4853916624dsm46416505e9.6.2026.03.08.10.18.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 08 Mar 2026 10:18:25 -0700 (PDT)
Message-ID: <ec7b8dfc-168e-4898-bd5e-2e2742f69f46@linaro.org>
Date: Sun, 8 Mar 2026 18:18:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/uefi: add variable digest to vmstate
To: Gerd Hoffmann <kraxel@redhat.com>, qemu-devel@nongnu.org
References: <20260304075954.584423-1-kraxel@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Content-Language: en-US
In-Reply-To: <20260304075954.584423-1-kraxel@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x332.google.com
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

On 4/3/26 08:59, Gerd Hoffmann wrote:
> Add digest to vmstate if needed.  Clear digest before
> loading vmstate to make sure it is initialized.
> 
> Fixes: db1ecfb473ac ("hw/uefi: add var-service-vars.c")
> Signed-off-by: Gerd Hoffmann <kraxel@redhat.com>
> ---
>   hw/uefi/var-service-vars.c | 36 ++++++++++++++++++++++++++++++++++++
>   1 file changed, 36 insertions(+)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

and queued via hw-misc, thanks!

