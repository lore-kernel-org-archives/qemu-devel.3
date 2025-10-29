Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26BD9CCF9E9
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:50:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6Yj-0008DD-8w; Wed, 29 Oct 2025 09:49:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6Ya-00087H-UG
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:49:45 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6YS-0003qd-Uq
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:49:44 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-46e6a689bd0so72959595e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:49:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745773; x=1762350573; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=bFG8gwDo2dMIA+dlMTwwaXhTvZBM52R0Qxu7TU/qj7Q=;
 b=JwlKJb1385LKVKX49BazKQkAlRfYkCeGY0m6YCstsqRkPd2FsB8BmJiuOxOzk9FvfR
 HoGbACF5zeuhAl2risDhg9YccHTPmZooRe5I5BjsQsmZr5v53onBegQ6O4KaSzKbZAIs
 4vvQeJkq8wSEcXtpv6jcHBHaCovfmC+DbiGQJKb40LTwvtN0FVS5HOmDCCiwx9rL3FpU
 kv824BKVpb6J/Sqha9AHezR04spmWeQ+iBACGmrMs+CeUmt9RY/cmKP0W1oLLmHqZQ8E
 Q0SCz9d5cZ/S1vvPV4BnL0drP9WSUqwgaeEZbuJGI6IZG4eYX4nJquBQ+HYQ0MuIOXbX
 6IRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745773; x=1762350573;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bFG8gwDo2dMIA+dlMTwwaXhTvZBM52R0Qxu7TU/qj7Q=;
 b=lOXgELvtEU8lEqmEplcLlTvjCDXqunTBL5U7wbV2wztgTH8mMAuAtEF1F4CSNd0eg2
 g1K5xL1/mBsjw1LHCFBG+3oWjhOqEMY9AT/V5aoqcu6rNZ9uV7tc9W8iTeN8i4LdNO17
 3aFYGAkyXkylN5ZhKWYLDo1hJe0mqk0rv4w3+xU+2sw35SuHXeOhTbQmW+BpS/qNGa8s
 rhezMLQZec0EypnXxGC23ng0NycVY8DESvvUk9IEoC2syBBJFNKlwLmuYmcTS18huE3F
 cp/L76WBQBKYrJSFNM8SV/WdJgW9tUN96tIxrC4poJuN05s/3ZTSjQ0TJJKiPWKBD9Wc
 JplA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQNZdUZYWv/u2TlgQV1OOb6HUaQ+7B1ODrcvzZyiyEa/y1IwBbNF/JYjaLvUSVhSxu4NKAhAgV48BF@nongnu.org
X-Gm-Message-State: AOJu0YxhpjV6opeUX6GrMLteP/Ny3KuLt7wCH6D2A+4d23G9Y+d+401a
 iAo9Ceadmyk85JKYcQEe+zQU4gVIBk2gM67X9wtClEAoADI93skAfLCZ7gixHVu6WbU=
X-Gm-Gg: ASbGncs3VCG7qJnRKov96uSrDO0Ah5a2nQlwWXxByIkN+sXEHy4uRsOB7nZ22WHmTkx
 t5ICcWSAW3nx+a9eg7P1KoWPTdzm8hgw0kFKguZz0scb4voQQlGbnNvRAOgFjzVbOCbE4ZVPMU2
 DFsWTdoy6u5t/tHDXHpayN/jP7CpCf1W/vAzry3/nnDh5Hh0PBZb8sEZdmTHX6j7XoHSkDyJXgU
 +xESqPqXB4Mk+SFQ7BS+5YWwgHaDzBkbeSEx/kGqtvY0mCkFldem3RloEStgyKspjA37ryykRJq
 /EaKeMhe0et6lJOFDF6UmNPvE0Ep3+htYyGHkf3nv5m14UZYbgA+49KzliZLms7Q69Fq+Pqj1p6
 hTXxNKitAKysQF4Wzr2WZ9/zsc5fZ1rS9JYT/V5bEDMAWkOQBzZCg0PMeX61sByBmr84lBzkbnA
 t3/FgaabOJ6jy/x0qQld8rP6kmCNyj+kYXiGHZdWSbA/s=
X-Google-Smtp-Source: AGHT+IGW7vqGhnc32I0Hvi6ZMqV8kemWcyz0ay9PLO7I7j3Jy5wubYCgZ12VZOnfsmtjMwQ8zfCklQ==
X-Received: by 2002:a05:600c:a087:b0:477:58:7cf4 with SMTP id
 5b1f17b1804b1-4771e16e3a3mr28569825e9.4.1761745772558; 
 Wed, 29 Oct 2025 06:49:32 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47718427409sm45422115e9.1.2025.10.29.06.49.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:49:31 -0700 (PDT)
Message-ID: <fbdafda9-642d-4010-a9c4-881189065ea0@linaro.org>
Date: Wed, 29 Oct 2025 14:49:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 26/35] audio: rename AudioState -> AudioBackend
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
 <20251027151045.2863176-27-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-27-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::329;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x329.google.com
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
> Naming is hard. But in general in QEMU, a host "backend" is the term
> used to fullfill the request made by the device or frontend.
> 
> AudioBackend will become an abstract base class in a follow-up series.
> 
> Currently the frontend is QEMUSoundCard, we are going to drop that next.
> 
> Note that "audiodev" is the corresponding QAPI type name (or configuration).
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h                    | 16 +++---
>   audio/audio_int.h                | 20 +++----
>   audio/audio_template.h           | 20 +++----
>   ui/vnc.h                         |  2 +-
>   audio/alsaaudio.c                |  2 +-
>   audio/audio-hmp-cmds.c           |  2 +-
>   audio/audio.c                    | 90 ++++++++++++++++----------------
>   audio/dbusaudio.c                |  8 +--
>   audio/ossaudio.c                 |  4 +-
>   audio/wavcapture.c               |  2 +-
>   hw/audio/pcspk.c                 |  2 +-
>   hw/core/machine.c                |  2 +-
>   hw/core/qdev-properties-system.c |  6 +--
>   ui/dbus.c                        |  8 +--
>   ui/vnc.c                         | 10 ++--
>   15 files changed, 97 insertions(+), 97 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


