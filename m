Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 236D8CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:44:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVke-00045o-If; Thu, 30 Oct 2025 12:43:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVkQ-0003pX-38
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:43:41 -0400
Received: from mail-ej1-x630.google.com ([2a00:1450:4864:20::630])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVk6-0003Vz-Ai
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:43:34 -0400
Received: by mail-ej1-x630.google.com with SMTP id
 a640c23a62f3a-b6dbb4a209aso243665266b.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:43:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761842592; x=1762447392; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=G8eV1FRR47sZH5kygZofNxOHp940E7AT+ZsoVqkmAXs=;
 b=qkmyq0UCufu/qzSPQshizBse80ude720cAkba3ynASbTIHgf7YGINjv4ZwT8WM6W8D
 B61NM9V4AqKqu7rYEwbQilOE5sLIELhjECwAHMsE2mi3u1QBZtkHBFlW+ZbhCotl4lft
 0J0RBV+GWLoCIxANXjeYa4jsu75bwGWnsPERwJ0S+i24EiLNxYz7xUMscAp5VukUnVpJ
 Dlhp5/Q+yvDjUouKiGBWx3BuBJISiOWqjC5ccJtRN+waBfHAHD5nXT5yF3Xu+vvj2eTY
 ufE7QAW4+a7sbMsjdIr3KKJMqJz6OlBbUJ6DC4EQdGthCyutGXO9AqOU07jRNYTcrsBO
 rK0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842592; x=1762447392;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=G8eV1FRR47sZH5kygZofNxOHp940E7AT+ZsoVqkmAXs=;
 b=X7BMH5Sea1v98Dcm0SkZGC4zPVD+DfUPVDx6p+oZOhlRcKJkthi2oDVwR2jGaHICIK
 VzX3FEOHfesofekTlTTKS0qza7TyinM0XgELb7bAnuVoCCcxraNm5WsBwKTneTGYje20
 jgTjneMhcEZKYEkjcYbSZBgauoUc5Hh5wk79VvtpFamNWSv3s/13FlKV35tkmIfZPiIx
 CMZ4kiaa3WbmJPIkhomJvTPJAn7FnyXrBYhf0tcW7Ke63Gm9pIxoVzO7PJVYO/NkjFG7
 dU1SegDPdiGISAlYZxZT+PZ7TNqLtnhHzm9ICQZASvXTfql+RNsR7l4+TMR7HUThU5Lg
 JheQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMwMefsLvyHG8j5adzJ0tEHNg+BBv3jScl8E8UlFU6z8797Zt8HTkPYrywmp/RY7iHx0uvhMk5teGW@nongnu.org
X-Gm-Message-State: AOJu0YxqtYMCFDrAphALvwPTOYI0ur5MY0NrL9mZKJHkRR9LmEUIS9z4
 TwsOC+toXD/1AFK7nfqMUnXYVZIlXglhbsQtPakCVzIikszmAKKDWaAbLJHkaHJ+d3w=
X-Gm-Gg: ASbGnctfugecJ6qzfcfragRjogx1NKWrHo7c9A9CQlRgd7FZCWEX1ciZWEwteytGds3
 L97oxwVVryxSnESYg47p0Jsf/aMo0yEud0Zn/KYCobVKQX2H6lRdOFKBkTQZeDgtAia94qSS33e
 qXV7ebWJKdHXKlpDrYJjQprc4I7ZgNPjBQXBpDe2AWz+gMB8iE+HxdsQz5MjWGYmfZA2gFR1v0W
 85Jh+v5+caWLAuj5z3L3kxcACuKHmRCNLaPkrRTOHq/MOoiG44Pt5nhzz0FVnvkwBR9hDa88BCw
 CEQTs1cVA8jL9/t27lih671bN4jmwuLTOrj4bcq54Laldvwi8vh2S6ZSmxdm3Cheqxhi/dywIqk
 avGF0jATwFzuJtcV7KHaY0j1y3oyN8hE3UWP8nnSytirx3WLzxrEQh9s4A1fdRvj/eEHxGEMUW4
 RHHwqgvZCddUupC3iqQrYlPQk26B6wkVjKIlo+vSHJxw==
X-Google-Smtp-Source: AGHT+IGiDbPZ99yBxB1j7NrjlcPTsIGQehP2K0HeszKtG7jVCDOKxyyjE+XdOld1snxt59DGqdBh1Q==
X-Received: by 2002:a17:907:2d0a:b0:b6d:5f52:eee8 with SMTP id
 a640c23a62f3a-b7070199ee4mr16828766b.29.1761842592353; 
 Thu, 30 Oct 2025 09:43:12 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d8992aa28sm1758610666b.41.2025.10.30.09.43.10
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:43:11 -0700 (PDT)
Message-ID: <0ed9cb4e-7d72-43f8-9408-bcc3dae0e429@linaro.org>
Date: Thu, 30 Oct 2025 17:43:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 27/35] audio: remove QEMUSoundCard
Content-Language: en-US
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
Cc: Alexandre Ratchov <alex@caoua.org>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, Jan Kiszka <jan.kiszka@web.de>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Yanan Wang <wangyanan55@huawei.com>, Thomas Huth <huth@tuxfamily.org>,
 Gerd Hoffmann <kraxel@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-ppc@nongnu.org,
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>,
 qemu-arm@nongnu.org, Alistair Francis <alistair@alistair23.me>,
 Zhao Liu <zhao1.liu@intel.com>, =?UTF-8?Q?Volker_R=C3=BCmelin?=
 <vr_qemu@t-online.de>, Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 BALATON Zoltan <balaton@eik.bme.hu>, Laurent Vivier <laurent@vivier.eu>
References: <20251027151045.2863176-1-marcandre.lureau@redhat.com>
 <20251027151045.2863176-28-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-28-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::630;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x630.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On 27/10/25 16:10, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> There is no clear need for this extra intermediary structure between
> the audio backend and its user.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   audio/audio.h                       | 18 ++++++------------
>   audio/audio_int.h                   |  3 ---
>   audio/audio_template.h              | 22 ++++++++++------------
>   hw/audio/lm4549.h                   |  2 +-
>   include/hw/audio/asc.h              |  2 +-
>   include/hw/audio/virtio-snd.h       |  2 +-
>   include/hw/display/xlnx_dp.h        |  2 +-
>   include/hw/isa/vt82c686.h           |  2 +-
>   include/hw/qdev-properties-system.h |  2 +-
>   audio/audio.c                       | 29 ++++++++++-------------------
>   hw/audio/ac97.c                     | 25 ++++++++++++-------------
>   hw/audio/adlib.c                    |  9 ++++-----
>   hw/audio/asc.c                      |  9 +++------
>   hw/audio/cs4231a.c                  |  8 ++++----
>   hw/audio/es1370.c                   | 23 +++++++++++------------
>   hw/audio/gus.c                      |  9 ++++-----
>   hw/audio/hda-codec.c                | 15 +++++++--------
>   hw/audio/lm4549.c                   |  8 ++++----
>   hw/audio/pcspk.c                    |  9 +++++----
>   hw/audio/pl041.c                    |  2 +-
>   hw/audio/sb16.c                     | 16 ++++++++--------
>   hw/audio/via-ac97.c                 |  9 ++++-----
>   hw/audio/virtio-snd.c               | 13 ++++++-------
>   hw/audio/wm8750.c                   | 23 +++++++++++------------
>   hw/core/qdev-properties-system.c    | 11 +++++------
>   hw/display/xlnx_dp.c                |  6 +++---
>   hw/usb/dev-audio.c                  | 11 +++++------
>   27 files changed, 129 insertions(+), 161 deletions(-)
> 
> diff --git a/audio/audio.h b/audio/audio.h
> index 1d56f111ea..fdbc33ae0c 100644
> --- a/audio/audio.h
> +++ b/audio/audio.h
> @@ -69,18 +69,12 @@ struct AudioBackendClass {
>   };
>   
>   typedef struct AudioBackend AudioBackend;
> -typedef struct QEMUSoundCard {
> -    char *name;
> -    AudioBackend *be;
> -    QLIST_ENTRY (QEMUSoundCard) entries;
> -} QEMUSoundCard;
>   
>   typedef struct QEMUAudioTimeStamp {
>       uint64_t old_ts;
>   } QEMUAudioTimeStamp;
>   
> -bool AUD_register_card (const char *name, QEMUSoundCard *card, Error **errp);
> -void AUD_remove_card (QEMUSoundCard *card);
> +bool AUD_backend_check (AudioBackend **be, Error **errp);
>   CaptureVoiceOut *AUD_add_capture(
>       AudioBackend *s,
>       struct audsettings *as,
> @@ -90,7 +84,7 @@ CaptureVoiceOut *AUD_add_capture(
>   void AUD_del_capture (CaptureVoiceOut *cap, void *cb_opaque);
>   
>   SWVoiceOut *AUD_open_out (
> -    QEMUSoundCard *card,
> +    AudioBackend *be,
>       SWVoiceOut *sw,
>       const char *name,
>       void *callback_opaque,
> @@ -98,7 +92,7 @@ SWVoiceOut *AUD_open_out (
>       struct audsettings *settings
>       );
>   
> -void AUD_close_out (QEMUSoundCard *card, SWVoiceOut *sw);
> +void AUD_close_out (AudioBackend *be, SWVoiceOut *sw);
>   size_t AUD_write (SWVoiceOut *sw, void *pcm_buf, size_t size);
>   int  AUD_get_buffer_size_out (SWVoiceOut *sw);
>   void AUD_set_active_out (SWVoiceOut *sw, int on);
> @@ -132,7 +126,7 @@ AUD_set_volume_in_lr(SWVoiceIn *sw, bool mut, uint8_t lvol, uint8_t rvol) {
>   }
>   
>   SWVoiceIn *AUD_open_in (
> -    QEMUSoundCard *card,
> +    AudioBackend *be,
>       SWVoiceIn *sw,
>       const char *name,
>       void *callback_opaque,
> @@ -140,7 +134,7 @@ SWVoiceIn *AUD_open_in (
>       struct audsettings *settings
>       );
>   
> -void AUD_close_in (QEMUSoundCard *card, SWVoiceIn *sw);
> +void AUD_close_in (AudioBackend *be, SWVoiceIn *sw);

I know this is painful, but please fix ./checkpatch.pl errors before
posting your pull request.

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


