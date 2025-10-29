Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B528DCCF9EB
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 13:52:31 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vE6an-0002hG-7b; Wed, 29 Oct 2025 09:52:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6ac-0002Ze-I1
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:51:51 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vE6aY-0004Gx-It
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 09:51:49 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-47721293fd3so4438135e9.1
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 06:51:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761745897; x=1762350697; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=S3EFCcFvKD34fTRFqPt5CRFwrg+Z5J50HVINceHnPS4=;
 b=mE0U5z89/rk7N/OpRJuaCqs4fe32tfb7//ByTGTUiD4z7Re3cWkojzxJx4w77vWXKR
 zr/KNw/7QW9jZqCryvkzKWNK8w2ysmgJMJmRw4//IJ9KAxXBmsH25qLJMwREAUfNEkTD
 hun4wCSJkxKNnjPZ5FpJ8O3soWAMJ41bn/N5fSz1kG0ccpII9wrW2+p/rFDWMQPn4wcm
 wRkRB7bG8NJDmGySC5bp9vayBhFytPiWnmnekhUYkHC2sXSz9VtdsIFomdv+7MyTJ36Q
 8GR2rq3erUpMURWVQh6tC/TRoMmMtSMNkuMRkMwfOof8eQSi4KGCW5y9E46+cZfMBB87
 /Zxw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761745897; x=1762350697;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=S3EFCcFvKD34fTRFqPt5CRFwrg+Z5J50HVINceHnPS4=;
 b=efk4McbGjT58tM0M16kzFlA6OSC2vjkuRccf5Emr1qLqMu9l6YLktXEarXk/0gTDKN
 CoTaUUFq3+qPJgesG/ZqVD+8NiL7cJowp5yj+e4e1epK1PAnW0kbj0tZO/lIq/dPSPSW
 Q5SQrd4rCyOkhbwlwl3yL+b/zYiWgM982mQMuMOnndL7Bb/HTwJsWPpZqpJIZDwgoO90
 gQkZzGJwvrrD9QHAVfjgFFox1kjJ8ehIcpvSjxOKJONU557AgGDbA11rmj48yK5hOT7i
 qRkV8hNCENzAwU3+jdVhz6zrFIRKGfE+YLFG0JoMSJGrsksMiIEXaQlKZ0Ye6LJSx1TT
 MjOQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQf5toDMHOesrmLqQjbv4Butk2kvcbUy/Fcy5fC9yepeO0uEe2HRPTTvvrcvEth6xtmdQ5i2NzCirs@nongnu.org
X-Gm-Message-State: AOJu0Yzj6Xv2aFRnMNEGPzy0gi6wPP47Q8B9LRHewvDCQkKjcorVSLmq
 K0g20i4P5N9k1GlcWbIhizqhiWsNOhoR20R+6GirXA5RzNZRJlJvxjVBy5gjldv7vpo=
X-Gm-Gg: ASbGncuXeRInF2QHVPjQcoiQL8RhRHIFWKyuoUW+X64Zr6/5UeOXx0Y9TKPHUkYJiP9
 g95RiXNebywqFeebe7GPYF7+d3C0vZ97/Z3MOCOlAxCeIXDAYCxQgW4yavifu8iwfCd7ocFPhw0
 hWYzvDW0tL0P58qB9EdX4hxQzepg24zQHY2a70Pfj3yvcOaDx1Qun7/sS2dcoOe6TGYgmcE4xL7
 sprdXuDywWPOLGKTrbN7vna9wKjXTsCr2bvbJwh2FOPAw7q1vZVLqs/Nkkrb5swD8kQnBgHdzqr
 asX5yiEnVZhtKBp1FPo/Jbrwy2hFK45WmtOCAicKE8alSJSz3O0NiXs+QnXu2iynk+cJrqLcI6s
 2aTPaVxabtmQj4niJO5yIUEJZ8Vwvb0phDLHDWqa4l2ur/ZWfRuv1l6Eul/4m2WE7QsHDZ4BP4N
 BjRAwFfl1cYlIgWSOBhAqjJMFkn0xQcrJKFwze+SIRJkg=
X-Google-Smtp-Source: AGHT+IGk969MaDnboiOUQgj9GWk8LuPpPzy9PMFUc0Bt18OVoKikX9llhYkMv09U3nU4Jm48A+TmZg==
X-Received: by 2002:a05:600c:a58a:b0:477:11a0:b746 with SMTP id
 5b1f17b1804b1-4771810b645mr40317845e9.6.1761745896764; 
 Wed, 29 Oct 2025 06:51:36 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4771e39380dsm47596885e9.7.2025.10.29.06.51.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 06:51:36 -0700 (PDT)
Message-ID: <876f8ea8-670d-454b-b05e-ad6be27e3624@linaro.org>
Date: Wed, 29 Oct 2025 14:51:34 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 33/35] audio: drop needless audio_driver "descr" field
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
 <20251027151045.2863176-34-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-34-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x336.google.com
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
> Was it ever used?
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> Reviewed-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>   audio/audio_int.h   | 1 -
>   audio/alsaaudio.c   | 1 -
>   audio/dbusaudio.c   | 1 -
>   audio/dsoundaudio.c | 1 -
>   audio/jackaudio.c   | 1 -
>   audio/noaudio.c     | 1 -
>   audio/ossaudio.c    | 1 -
>   audio/paaudio.c     | 1 -
>   audio/pwaudio.c     | 1 -
>   audio/sdlaudio.c    | 1 -
>   audio/sndioaudio.c  | 1 -
>   audio/spiceaudio.c  | 1 -
>   audio/wavaudio.c    | 1 -
>   audio/coreaudio.m   | 1 -
>   14 files changed, 14 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


