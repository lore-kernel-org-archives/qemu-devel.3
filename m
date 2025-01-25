Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0640FC0218C
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jan 2025 18:25:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbkql-0000iP-W7; Sat, 25 Jan 2025 13:25:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkqk-0000cv-1c
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:25:42 -0500
Received: from mail-wr1-x430.google.com ([2a00:1450:4864:20::430])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tbkqi-00067d-F4
 for qemu-devel@nongnu.org; Sat, 25 Jan 2025 13:25:41 -0500
Received: by mail-wr1-x430.google.com with SMTP id
 ffacd0b85a97d-38632b8ae71so2485959f8f.0
 for <qemu-devel@nongnu.org>; Sat, 25 Jan 2025 10:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1737829539; x=1738434339; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=wQ4lTVqtpyTo781FD+1Tn//Lmj0tttf1rce8iYGm1vs=;
 b=oPaJ4xZV8YTxZXyxAKBNyLwrF9GOZJt+MCSZU8leCdDHrT66Gs/HCcSjeX/bAMi66H
 P52KfEZoySVXuo2kIXD/IkqZsVoijsiLJAUToJ84bwWu7usJ+bsIn7ocUSd27C3z7c1T
 LV9bY/rhPn+OBSpKk7fTU1MtbH2CPE+ghOq2Ys9oHN7h2V+AOf/4/TBoj2nYuoxuOGwU
 F2lY86BQyLNrXaxsgwUMdOMJ6FGCWvHnRiNWLIJhFGRqvCAv6OWQuwwptpGv2CvSRAiy
 iAlvAQ16tGY5/QGEcpyLt/ZEuJ5vqniRnZuYjdO+SohXLsXtaAbsf6UhvGmI5wf/zpcG
 RJJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737829539; x=1738434339;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=wQ4lTVqtpyTo781FD+1Tn//Lmj0tttf1rce8iYGm1vs=;
 b=ONSy1b6ZM9QRXKUmYSHJg5lpT+PMr5Dg3YnsC1XyJcO85Vi5r2szPtL9S/9uh7Bgsk
 O3HTIqq9Sh+wWCeUD/Y+8bYj4lcGCHwSt+93aHeNEX42mcHKoXAtZSRSfea25aO8U082
 HcptSlM8GkZWBjBDXRKBm7Nf34YFDLeQ449aA+rlWlu7cPADMLA2iqWYJp8/EkVD1naj
 oGySEOdrAkNxFlBAzJOb+Niw6C3ig7jef/TCLoeSv1KodLZEdnQDAVk/slKKqc1Fh8+b
 C4REUHdClaC3RNko+CO0Ho6fEAMHEEZ62r63Q5aYXF70FgMsis7NRPRCGsVJGPrMuRUp
 8Bkg==
X-Gm-Message-State: AOJu0YypQPPlGc4aJRE86p8E1s8nM2Vc3fWpBu2zal5oTp8oihrDuaiG
 K+re9k/AYV3yr677DCpAmTMlPTiEb+YW4m71A6RQMqqS5iiCa8YiHuhA3IaU93U=
X-Gm-Gg: ASbGncv6HohjDMdISkeAayRE5pDQcRxInSZgkn20BboyKcKTavkhvIPChdQ97RsftD0
 +M3v9Xt2iOR1KyGG4wTriktIPcmb8prcA2kDWCmB3zEOa0T0rrOlgCozlEpAYTOXHIL+CWRXBmk
 AWH1BOEYX8oGk5JXhFvfZG+JSm85JyPK8KIulQERdHZRmiB6sygfEiuI0fvZlDvQQkWYd5biI0N
 x+mrVgdox7NDutretA5+9cipEehZpJ0yAUVj780P2X9zza/HuN4qXvYmi9G72A2D7ohevTrU6QC
 u4cEouInnyFsF9KunByMZw8YavhYnqwlrcJPRTs6rVXQqZkUmuKTPQ==
X-Google-Smtp-Source: AGHT+IGKsDxbPo7Xf5OXZg0BCZ/Xxv8DH6u9CFy0KCka0NswMtpIv+1nIVxpIWROPUnGHkOHwOdJxA==
X-Received: by 2002:a5d:4845:0:b0:386:857:cc54 with SMTP id
 ffacd0b85a97d-38bf5679b17mr25583820f8f.9.1737829538799; 
 Sat, 25 Jan 2025 10:25:38 -0800 (PST)
Received: from [192.168.69.181] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38c2a18931esm6268973f8f.60.2025.01.25.10.25.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 25 Jan 2025 10:25:38 -0800 (PST)
Message-ID: <fbf13036-18b3-4aa5-b514-e6c8484ff33e@linaro.org>
Date: Sat, 25 Jan 2025 19:25:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 3/4] audio: Add functions to initialize buffers
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>
Cc: qemu-devel@nongnu.org, devel@daynix.com,
 Phil Dennis-Jordan <phil@philjordan.eu>
References: <20250123-coreaudio-v5-0-6873df4215a0@daynix.com>
 <20250123-coreaudio-v5-3-6873df4215a0@daynix.com>
 <7a020e94-841a-4a3c-bdea-12c00579ef3f@linaro.org>
 <f62af9d4-36ae-45ea-8aa6-9139502da47e@daynix.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <f62af9d4-36ae-45ea-8aa6-9139502da47e@daynix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::430;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x430.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On 24/1/25 05:58, Akihiko Odaki wrote:
> On 2025/01/23 17:43, Philippe Mathieu-Daudé wrote:
>> Hi Akihiko,
>>
>> On 23/1/25 08:18, Akihiko Odaki wrote:
>>> These functions can be used to re-initialize buffers when hardware
>>> parameters change due to device hotplug, for example.
>>>
>>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
>>> Reviewed-by: Phil Dennis-Jordan <phil@philjordan.eu>
>>> Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
>>> ---
>>>   audio/audio_int.h |  2 ++
>>>   audio/audio.c     | 24 ++++++++++++++++++------
>>>   2 files changed, 20 insertions(+), 6 deletions(-)
>>
>>
>>> index 
>>> 87b4e9b6f2f356b6e5e972eabc100cf270fcbc29..17c6bbd0ae9e6ff810c0989dbfa1710ef674ff0a 100644
>>> --- a/audio/audio.c
>>> +++ b/audio/audio.c
>>> @@ -1407,12 +1407,18 @@ void audio_run(AudioState *s, const char *msg)
>>>   #endif
>>>   }
>>> +void audio_generic_initialize_buffer_in(HWVoiceIn *hw)
>>> +{
>>> +    g_free(hw->buf_emul);
>>> +    hw->size_emul = hw->samples * hw->info.bytes_per_frame;
>>> +    hw->buf_emul = g_malloc(hw->size_emul);
>>
>> What about using g_realloc()? Otherwise LGTM.
> 
> g_realloc() will copy the content, which is not necessary here.

Oh I missed that! Maybe worth mentioning? Anyway, just nitpicking...

hw->size_emul = hw->samples * hw->info.bytes_per_frame;
g_free(hw->buf_emul); /* Discard previous content, no need to realloc */
hw->buf_emul = g_malloc(hw->size_emul);

