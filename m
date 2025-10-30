Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5F43CCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:40:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVh7-0007Oj-RJ; Thu, 30 Oct 2025 12:40:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVh5-0007KR-Lj
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:12 -0400
Received: from mail-ej1-x62d.google.com ([2a00:1450:4864:20::62d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVgy-000328-3I
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:40:11 -0400
Received: by mail-ej1-x62d.google.com with SMTP id
 a640c23a62f3a-b6d83bf1077so252714166b.3
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:40:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761842399; x=1762447199; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=EwLZaMQ2xkYLb8CZxVsf81o4GwM6pprJR6dDncgMZCI=;
 b=P0TwnlSySemosWYjNblTGF3shklD/VNPMz15ipuTIexShTtqYoSPy+EYRS3cojNqaP
 RWW8FSbV1ZljJDY3Yh58nKlSWJp7sZTx5RiRI/ijmo7hcmAO+Rf8ZeuIkINlc88UWWuJ
 rY/Hm6pMPM/0FN4ug9WPOUegpM7C1bP0d95wSFbAqvXOodMsqk6MrlPXlmnduKHHQi6W
 CeArGKweGLPO3fe3J4lg9XXzBVplZJyvd9AdAi0EwmwNJm/q2pBRJ/MGgw1UEQQM2q0k
 Alp0Y9ncX+Q7W7DxXlp5p+rXNeD2Qmy8irQsV5zO2p+9dN0yPCvowp2cYmknT+359mNJ
 q8qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842399; x=1762447199;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EwLZaMQ2xkYLb8CZxVsf81o4GwM6pprJR6dDncgMZCI=;
 b=vfYpQiQcB/kMKsjUdBH56mVkYZeR6x67Y0I2dTrscvlesf++GjiYTqhvGeZUj96hkA
 1GIMdUNzX1t90rP/Y4zkakk4iu9M7JwKk5iyuEUlhUgHOGneSbtJOPumq0wkWThZg8sf
 YOIveIk63QoiB3N6IbtjO8RV1LyKM2EiALIkPx4O5ycjtN5pZt9LRUe8jajtDoM5TC6H
 ulcGRkhx7FmXPzm+0/HX4ZcPihF0uHsJVIjOm+Tk4VGpCqaezdWVazK0e0z2HpMW01u7
 DW4mdcV4ZNkUtXyxu+TEG3Ok4CRi8z9XiQRPQtLEPQhVdBlmwJJmdQR2aKZCuZxFh18x
 PwLA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVxkNXdZx7Nru/5/hUydeVPhbkxsUXKs2TlT5YObSA264nmtFhBsrRlQDDGuZUOM+pvVhWdyA4Q3gvr@nongnu.org
X-Gm-Message-State: AOJu0YwKziP4CApyAVp/KyB5YnKzg4yKQBtX1JnMhtTx/XdYEs2Zpi9E
 GHNyLSEzHRXF3Umj3dF/cPH6AKj7Li3LJWE5NfhPu5A2gMmDR56C4JSJW8nkSdtX3vM=
X-Gm-Gg: ASbGncsXiBn1kkmn2GQMNfRAcg6DtyNeoS8G8N7L1P66TCQcLEFRu40y9ST8wcG9F8m
 eOhMtPZAf9ul0F29Atu8a1ctn7p/SJFkwH91LG39EN89afXv89CxQQIWnHwIfwlbEFh+wKQEVFk
 ydzvpQvHHd4LlSXU+EYZT5EvAWDBbeMxscqS+51Z9YyHvyTRJwDIkSRRrPLxNNCGU+j+M2P91Al
 BizGvLeN9habBvclwztHGmePt0KigKhxvw0hf7f6duEuRDBVDBQcq20J47pNatTelOxOlfl0DPl
 e6n6Bmukg4Pz70IJVno1ImNKRFWIlAH0DRIz9MibJQyjVeAjVolfqsnFJ+OVYmpAcnF6n7eVKWg
 4b/9CaYSajML4blZzx9jernAuyDk3w97Ap3SHMKyTY+9iPJ64t0eg45CttpU4W5+dmZdAZ7/gDf
 Cl4EUaYWPERHaX+8AMFBEhof6lIGyrbC0CnunFfJy6Fw==
X-Google-Smtp-Source: AGHT+IGgyheceNatEFPKSZgnNYvP+OIpOEbIJH7SFWR4ihk3foSYIZgt79Ewlk923QElIXMO0Xuivg==
X-Received: by 2002:a17:907:2d87:b0:b32:2b60:f13 with SMTP id
 a640c23a62f3a-b7070834a6fmr11532766b.54.1761842399399; 
 Thu, 30 Oct 2025 09:39:59 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d85353ff7sm1796403466b.22.2025.10.30.09.39.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:39:58 -0700 (PDT)
Message-ID: <39eac421-7ced-4d48-ad59-e615bed8e31a@linaro.org>
Date: Thu, 30 Oct 2025 17:39:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 29/35] audio: move audio.h under include/qemu/
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
 <20251027151045.2863176-30-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-30-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62d;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62d.google.com
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   MAINTAINERS                                         | 1 +
>   audio/audio_int.h                                   | 2 +-
>   hw/audio/lm4549.h                                   | 2 +-
>   include/hw/audio/asc.h                              | 2 +-
>   include/hw/audio/virtio-snd.h                       | 2 +-
>   include/hw/display/xlnx_dp.h                        | 2 +-
>   include/hw/isa/vt82c686.h                           | 2 +-
>   {audio => include/qemu}/audio.h                     | 0
>   include/system/replay.h                             | 2 +-
>   ui/vnc.h                                            | 2 +-
>   audio/alsaaudio.c                                   | 2 +-
>   audio/audio.c                                       | 2 +-
>   audio/audio_win_int.c                               | 2 +-
>   audio/dbusaudio.c                                   | 2 +-
>   audio/dsoundaudio.c                                 | 2 +-
>   audio/jackaudio.c                                   | 2 +-
>   audio/mixeng.c                                      | 2 +-
>   audio/noaudio.c                                     | 2 +-
>   audio/ossaudio.c                                    | 2 +-
>   audio/paaudio.c                                     | 2 +-
>   audio/pwaudio.c                                     | 2 +-
>   audio/sdlaudio.c                                    | 2 +-
>   audio/sndioaudio.c                                  | 2 +-
>   audio/spiceaudio.c                                  | 2 +-
>   audio/wavaudio.c                                    | 2 +-
>   hw/arm/integratorcp.c                               | 2 +-
>   hw/arm/musicpal.c                                   | 2 +-
>   hw/arm/realview.c                                   | 2 +-
>   hw/arm/versatilepb.c                                | 2 +-
>   hw/arm/vexpress.c                                   | 2 +-
>   hw/arm/xlnx-zcu102.c                                | 2 +-
>   hw/audio/ac97.c                                     | 2 +-
>   hw/audio/adlib.c                                    | 2 +-
>   hw/audio/asc.c                                      | 2 +-
>   hw/audio/cs4231a.c                                  | 2 +-
>   hw/audio/es1370.c                                   | 2 +-
>   hw/audio/gus.c                                      | 2 +-
>   hw/audio/hda-codec.c                                | 2 +-
>   hw/audio/lm4549.c                                   | 2 +-
>   hw/audio/marvell_88w8618.c                          | 2 +-
>   hw/audio/pcspk.c                                    | 2 +-
>   hw/audio/sb16.c                                     | 2 +-
>   hw/audio/wm8750.c                                   | 2 +-
>   hw/core/machine.c                                   | 2 +-
>   hw/core/qdev-properties-system.c                    | 2 +-
>   hw/ppc/prep.c                                       | 2 +-
>   hw/usb/dev-audio.c                                  | 2 +-
>   replay/replay-audio.c                               | 2 +-
>   system/runstate.c                                   | 2 +-
>   system/vl.c                                         | 2 +-

Alternatively "system/audio.h". Regardless,

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   ui/dbus.c                                           | 3 +--
>   audio/coreaudio.m                                   | 2 +-
>   scripts/codeconverter/codeconverter/test_regexps.py | 2 +-
>   53 files changed, 52 insertions(+), 52 deletions(-)
>   rename {audio => include/qemu}/audio.h (100%)


