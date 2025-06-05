Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B700CC5AE59
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Jun 2025 08:35:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uN64j-0002Vi-6x; Thu, 05 Jun 2025 04:35:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uN64T-0002GL-Rr
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:35:35 -0400
Received: from mail-pl1-x630.google.com ([2607:f8b0:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1uN64Q-0006w9-95
 for qemu-devel@nongnu.org; Thu, 05 Jun 2025 04:35:31 -0400
Received: by mail-pl1-x630.google.com with SMTP id
 d9443c01a7336-231e98e46c0so6816975ad.3
 for <qemu-devel@nongnu.org>; Thu, 05 Jun 2025 01:35:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1749112528; x=1749717328;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=0u3uA5JSpAEXaIO1NqCEQjYLy9eO7xSUc0BO/e3CoiU=;
 b=WC9gUponyFVI30n+55xBqJEQ+udy87fd1pPGsPLtn3dMD2T+f/LyBnk453do9YlHKE
 ZbSChS54PoOwpQR3hrE1+UeHSCDAsDcqG6/jI1Temv2XsaLnODzS1FbER8ONJX0Rwz9f
 8FfgdS/R3e/Mf2rV0KAynTNnPf4NISSqGVIs8F91rLoYEF4SXibrBCAj8zbUZGvr6PlH
 U5ptiswKM/5pRyNTWAoWOU5AHjwFTMYLiV0dQAGuA87ePrHyJD3j5GuDvml7islXni90
 cK+I0iAOmBJpzoZosg/F7+kOf5uD6IhcpV8t8mKgKb5DEld9od0/Mk5SV0/Dcjcq+N6F
 1Few==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749112528; x=1749717328;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=0u3uA5JSpAEXaIO1NqCEQjYLy9eO7xSUc0BO/e3CoiU=;
 b=qz0DLkKmtvw5UHV284uIRGOX514UkG/p+nMma05XXaZFTl4eKTHkcgrG6VY9nwOVYt
 tHSdLtH/fU5U2Oo8VJb2Wf1oniZwJO+geVU/a2uoKy048hIa81uapEn0x7l1N8I9k3tF
 lvsBluh4C018/Tt51hV/UitaQ3mDi4GngxY9N7d3/bPcJXBcx6tMtkOaZ6iFDy8JM8Mg
 kF1H8aalyk17Tt+v9Nnj1EQTicll1nbagBXVzn7cIPSezG5+Q0B4q0qSsjASwHD18voA
 jSwNyWMDzf0IASfwkZ4GBYD0JKHjZzFU3EB42+iHYRwjZ7ZjOQjd+jyaxKrG02voQ4Zi
 zzxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXFywOeBFdtq4TCkhqYEFBxBGM+GU0EIL9bpVJhXRR5jbE1TRPQhNX90J8R1n9uj+PUQoj2O2JF5JaM@nongnu.org
X-Gm-Message-State: AOJu0YyZWhWyiFcrCN8NQdb4VBcF1PeB/bxfYuZW8nGU08dnfzzHcgAK
 5DgGRYvjxwmIx5lLMYg3NgtilkchjbkUKsb0JIAFCCntlZGevIN/ReqQ3I54lwL8uIk=
X-Gm-Gg: ASbGncv4yEL5Z3R4/vVl2pzpvzzYxQkj1AJpO7VGTyRsC3tJtrFFw1pZYE7FGredIrk
 wYfcl7rcDVKmqH04Mlt3++wKxvlZTnQLxft2E+IwWRFXzoY0/Tvxicb2k8KKu/C8VomDM6b5wc5
 0M9vr9wERVw3qpL8pTU0A3Dv2WpHas2z347MC4Uz+O2CFPNMQQv0lz2oUtaaXZ70yr0wkO4jryX
 xFN9ekzaE0KlJkUaFMSqeHlZNxDnTkxxfZM8cM5MT7d/ElPdfe6uxD59jlbs9TdpFjVsmWZUss4
 09WyzzZ58D4xvCI7pRfVgUIysCjycUDysEV9JM3if1mUfJkzp0Bbj10qQnX67Hdq
X-Google-Smtp-Source: AGHT+IGjp6Pm19QxT9iOLUpHQ8WVqM7TqpwHB8wLa/3Zj4KSKc2MQp/mN1JvyfH6aMJJyPjNJivX7g==
X-Received: by 2002:a17:902:d488:b0:234:f182:a735 with SMTP id
 d9443c01a7336-235e11e5ef3mr88171765ad.34.1749112528438; 
 Thu, 05 Jun 2025 01:35:28 -0700 (PDT)
Received: from [157.82.203.223] ([157.82.203.223])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-23506cd3438sm114946755ad.136.2025.06.05.01.35.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Jun 2025 01:35:28 -0700 (PDT)
Message-ID: <e8b93b0b-461b-4029-9ed2-939ae51e3f81@daynix.com>
Date: Thu, 5 Jun 2025 17:35:23 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 08/17] MAINTAINERS: add Akihiko and Dmitry as reviewers
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, John Snow <jsnow@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, Peter Xu
 <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, qemu-arm@nongnu.org,
 Thomas Huth <thuth@redhat.com>, Alexandre Iooss <erdnaxe@crans.org>,
 Gustavo Romero <gustavo.romero@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250603110204.838117-1-alex.bennee@linaro.org>
 <20250603110204.838117-9-alex.bennee@linaro.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250603110204.838117-9-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::630;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x630.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 2025/06/03 20:01, Alex Bennée wrote:
> Thanks for volunteering to help.
> 
> Cc: Akihiko Odaki <akihiko.odaki@daynix.com>
> Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> Acked-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   MAINTAINERS | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7718199979..79b1d5c0b3 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2669,6 +2669,8 @@ F: include/hw/display/ramfb.h
>   
>   virtio-gpu
>   M: Alex Bennée <alex.bennee@linaro.org>
> +R: Akihiko Odaki <akihiko.odaki@daynix.com>

Please update my email address according to:
https://lore.kernel.org/qemu-devel/20250531-rsg-v1-1-e0bae1e1d90e@rsg.ci.i.u-tokyo.ac.jp/

> +R: Dmitry Osipenko <dmitry.osipenko@collabora.com>
>   S: Odd Fixes
>   F: hw/display/virtio-gpu*
>   F: hw/display/virtio-vga.*


