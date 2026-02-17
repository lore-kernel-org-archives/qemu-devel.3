Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4778CE68159
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Feb 2026 09:57:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vsHoo-0006qI-0N; Tue, 17 Feb 2026 04:56:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHoc-0006oi-4P
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:56:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vsHoY-000133-K3
 for qemu-devel@nongnu.org; Tue, 17 Feb 2026 04:56:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771322176;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MLq0La39LLTjPFt9PqWnXMZCoogQtI4ApYmmCq7NsPs=;
 b=KLs82OKTS/SFKdp7WooPkSycs35XTrkEynvE4wRoZnZvBjMPnRidrhDdBQ222KEB1RZtLD
 EVpSQnL8mNQkWIaKzJKkcjyQZ1jeFHU9hpYZkK68U/sVBSf1wN7vij39hF/PhhbYSC7YrX
 VzwGtKu8pmO0fXwyMQEnMt5S2zDGC6I=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672-TCyCaVC4Pcut_az41NxbbQ-1; Tue, 17 Feb 2026 04:56:15 -0500
X-MC-Unique: TCyCaVC4Pcut_az41NxbbQ-1
X-Mimecast-MFC-AGG-ID: TCyCaVC4Pcut_az41NxbbQ_1771322174
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-437700715ddso3756398f8f.2
 for <qemu-devel@nongnu.org>; Tue, 17 Feb 2026 01:56:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771322174; x=1771926974; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=MLq0La39LLTjPFt9PqWnXMZCoogQtI4ApYmmCq7NsPs=;
 b=I3Cyjy321TWw2JdyuF56h7CDMsbuffTX4cZH61fZ4kh/Fb2fhOitiUMY6cQ65InTP1
 Ob5Hq1b9KCC3rBUzGk2P3SU0JqLzZKjVDYn9/gNaRNPa3dGLNUNCG76ciT+SOAN/1NXK
 eBJaoSASl6D702Rl+E7C7IfVS+TzxOcbvWdas0Lqjw+8sZijGRIM14rU3f76fsIctRAX
 s5DTV6z+XjV24SLmUrx51pttF7lSXDt7ce5HWihF8hqdaRrMugzvUc0iAZe7aFAc36h2
 W6CMimj/MQJ2GuWW84buUSsdxstX6kaqGHsOOfayCdpYsXMsPU61jN2x5/XDTDFj7JSR
 Hk7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771322174; x=1771926974;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=MLq0La39LLTjPFt9PqWnXMZCoogQtI4ApYmmCq7NsPs=;
 b=nejfLwTR6pdAxnaauU0I6kHFLSWFU1kP9CkqUbe8d7UWkUZssdqh0dBkXhnyZdqlYS
 3GWNlL4VPJHxFOvp9MQfldr8XMBxaWZkhZvY/b8CmdzCloOGFdTk6S9+3/UiUuJSXzQe
 J5YRikaiuyvm1eINf0lvKtj94wCqNMNmQwMlD8tSXA4jsYTs8QOybAmT5Ap2upe42idE
 NErz8+bBjEq1+dOxHIfdovLHA8rDKhjZCMyCExYiWfvL4xGYnaQFUbQRg+oJhzmW+mTj
 gxtIJiJgfQs4qEb9evH9gNjHjoxNiP/fXWpH1TaUEQcinTLgtxeNH6wiV8GLoKEpBN04
 VyJQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8MuNgZkz0oPD3OC022OU8KfZBXYkYKaFaaaIq3iHJRez2rE/w4aPoNjCieTa5u9MPlZNpgWH7UEfR@nongnu.org
X-Gm-Message-State: AOJu0YyJU4yhg7LjiLV1op40JYZsnxPKMexNq93WesM9sq7WLnU3hP0G
 KYT/6nTjyHjEhXtcRsx5XvaCxQC4GJy2Ns0qbYvfIjQ9CcpfbaRuT+wspNcz1hdo1Qry0Sz40EM
 Afa5A4Rs3BHSrhskaZ3KIL2KZrvuhdKURedD35jJR1bTN6E0lsmwKVg0Y
X-Gm-Gg: AZuq6aKR9cOKvOC1Hbij+SUCqHwHVLKVFwIshLhSa9Uo8BY2f4ti9vjC0lVbRWBKT4a
 ecUkYuQ8AYK4lJjJOvVg5JJb3LF4FyrsSt0uZjhQLTJJkubwl2UF3DLOsaZaE7GdrYiIRbfiI5F
 uXAu9xwf2V9LC2BhtE38ropSbx1dEjOBmtwx2xyKQ2CykrKdqkSM6dqsdhDnfemRwxLlclVclZE
 XhZUaWriX9xd2HdKMti/GcWy4wFx8CWbdXRtXPmhmnqhzYdQ1L9I4NYOZPfag9mzeAt8CcY6ksD
 jNGWtWqBHWs5zep8Xw7uq5EiqYCYPpsP40sQRkMYO5+akEAT3Mmac3lZmHYPLLB8N/fierHHTdY
 O898hK7hvBfwkxPm5jYBrFxGwzBkjokj3necW8Ju+8voT3CaA4boQAoz76kpLupgM+cmVBd53ns
 ND94g8/eoulXVCrW+Yjw0pAbOUXIo=
X-Received: by 2002:a05:6000:1865:b0:431:1d4:3a8a with SMTP id
 ffacd0b85a97d-43796ab1669mr22846188f8f.7.1771322173772; 
 Tue, 17 Feb 2026 01:56:13 -0800 (PST)
X-Received: by 2002:a05:6000:1865:b0:431:1d4:3a8a with SMTP id
 ffacd0b85a97d-43796ab1669mr22846148f8f.7.1771322173241; 
 Tue, 17 Feb 2026 01:56:13 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-43796a74704sm35568771f8f.16.2026.02.17.01.56.12
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Feb 2026 01:56:12 -0800 (PST)
Message-ID: <d968e44a-953d-4fcd-8342-33e0f2a971b8@redhat.com>
Date: Tue, 17 Feb 2026 10:56:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] hw/audio/pcspk: change PCSPK behaviour with
 --disable-audio
To: Sergei Heifetz <heifetz@yandex-team.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Thomas Huth <thuth@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>
References: <20260217052740.114117-1-heifetz@yandex-team.com>
 <20260217052740.114117-5-heifetz@yandex-team.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <20260217052740.114117-5-heifetz@yandex-team.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2/17/26 06:27, Sergei Heifetz wrote:
> PCSPK (PC Speaker) is an embedded audio device. We don't want it to use audio
> when QEMU is configured with `--disable-audio`. This is achieved with minimal,
> non-invasive changes to the code.
> 
> In essence, the changes ensure that PCSPK does not use the corresponding
> audio backend, while functioning the same way in non-audio aspects.
> 
> Signed-off-by: Sergei Heifetz <heifetz@yandex-team.com>
> ---
>   hw/audio/pcspk.c | 14 ++++++++++++++
>   1 file changed, 14 insertions(+)
> 
> diff --git a/hw/audio/pcspk.c b/hw/audio/pcspk.c
> index 916c56fa4c..03fe816024 100644
> --- a/hw/audio/pcspk.c
> +++ b/hw/audio/pcspk.c
> @@ -36,10 +36,12 @@
>   #include "qom/object.h"
>   #include "trace.h"
>   
> +#ifdef CONFIG_AUDIO
>   #define PCSPK_BUF_LEN 1792
>   #define PCSPK_SAMPLE_RATE 32000
>   #define PCSPK_MAX_FREQ (PCSPK_SAMPLE_RATE >> 1)
>   #define PCSPK_MIN_COUNT DIV_ROUND_UP(PIT_FREQ, PCSPK_MAX_FREQ)
> +#endif

Not needed.

>   
>   OBJECT_DECLARE_SIMPLE_TYPE(PCSpkState, PC_SPEAKER)
>   
> @@ -48,18 +50,25 @@ struct PCSpkState {
>   
>       MemoryRegion ioport;
>       uint32_t iobase;
> +#ifdef CONFIG_AUDIO
>       uint8_t sample_buf[PCSPK_BUF_LEN];
> +#endif
>       AudioBackend *audio_be;
> +#ifdef CONFIG_AUDIO
>       SWVoiceOut *voice;
> +#endif
>       PITCommonState *pit;
> +#ifdef CONFIG_AUDIO
>       unsigned int pit_count;
>       unsigned int samples;
>       unsigned int play_pos;
> +#endif

Please reorder the fields to have a single #ifdef/#endif.  Also leave out

DEFINE_AUDIO_PROPERTIES(PCSpkState, audio_be),

which lets you remove audio_be.

Thanks,

Paolo

>       uint8_t data_on;
>       uint8_t dummy_refresh_clock;
>       bool migrate;
>   };
>   
> +#ifdef CONFIG_AUDIO
>   static const char *s_spk = "pcspk";
>   
>   static inline void generate_samples(PCSpkState *s)
> @@ -131,6 +140,7 @@ static int pcspk_audio_init(PCSpkState *s)
>   
>       return 0;
>   }
> +#endif
>   
>   static uint64_t pcspk_io_read(void *opaque, hwaddr addr,
>                                 unsigned size)
> @@ -161,11 +171,13 @@ static void pcspk_io_write(void *opaque, hwaddr addr, uint64_t val,
>   
>       s->data_on = (val >> 1) & 1;
>       pit_set_gate(s->pit, 2, gate);
> +#ifdef CONFIG_AUDIO
>       if (s->voice) {
>           if (gate) /* restart */
>               s->play_pos = 0;
>           AUD_set_active_out(s->voice, gate & s->data_on);
>       }
> +#endif
>   }
>   
>   static const MemoryRegionOps pcspk_io_ops = {
> @@ -196,10 +208,12 @@ static void pcspk_realizefn(DeviceState *dev, Error **errp)
>   
>       isa_register_ioport(isadev, &s->ioport, s->iobase);
>   
> +#ifdef CONFIG_AUDIO
>       if (s->audio_be && AUD_backend_check(&s->audio_be, errp)) {
>           pcspk_audio_init(s);
>           return;
>       }
> +#endif
>   }
>   
>   static bool migrate_needed(void *opaque)


