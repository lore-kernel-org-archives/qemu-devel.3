Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCB98CCF9F8
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 16:40:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEVgP-0006vp-8T; Thu, 30 Oct 2025 12:39:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVgC-0006si-28
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:39:18 -0400
Received: from mail-ej1-x62b.google.com ([2a00:1450:4864:20::62b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEVg5-0002xw-NB
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 12:39:15 -0400
Received: by mail-ej1-x62b.google.com with SMTP id
 a640c23a62f3a-b6d5c59f2b6so324027766b.2
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 09:39:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761842339; x=1762447139; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=ENvi7hvzKl7DHWnpguSuO6Lc6/9k4AkjfN10PNykDM4=;
 b=l+ILUiDk27TebWcyfbvSGIOqGTVj63MxBvkIJ6o8V6ZjLaU6JtFJxnny55nZRzsCgE
 yxW8cueVRXjLbmneu22z/T2Xj1sQrUJDUye/Wkemaw1rd9aAktOu1V4kdfKG07WjWe4c
 QDhUzxy4w3lP6WURKQgtNjPDELwmLf+BODIN+1tZp/iYXjplmZgEvnpl7IdnBYHNSVgy
 DNY6APJf59PXDRMaR/9TqOWxW3jOKeqYbAQJglhczxUvymGLbDUbGJwmk6SiaooR68e3
 zEjyu+Cr401VRTrydz/XFsGTNxh+dePXKKs/N4XRFUL6JYIQ3P/rZPCkBcworUs4iHoh
 TwkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761842339; x=1762447139;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ENvi7hvzKl7DHWnpguSuO6Lc6/9k4AkjfN10PNykDM4=;
 b=Vdl4KFGytGzOTM2DCL3OC9WKw6b3ynv98APF5IIN1EU3nsJwi49mwYfJcZPY9x/KXL
 ZXy+YPG1GV44dI8vGiC7kkfmkpRNm9uRh1u3OjtaoL6QDeZC6G7RX7RnZuK352aivvMk
 WrnkLet9ikr1cQYonPpViWsyncW+RO+ZF4RJ3S4+yIzRUp/hCYJsMpB1ONoLqDg9lHTy
 iyr4X5fcK6cs9lTfClIpQZQI55TAUIQ9/g84UIOnGCe9tCTRHS55b28AHRB+DQwHfdUb
 kNWc44VmMYVtdwYQItlmiocB3AC2a64g5lAgdD+SePl9s3DlDbhckmw01WsCgYhQsITU
 K/0g==
X-Forwarded-Encrypted: i=1;
 AJvYcCUiSwNrxBHIXSe3vyFsu1qNSk2hUeTg3VEwsGV6MJgH3hD8A3CEX4aaTElc04DGEQecmJfzLD5NZMVC@nongnu.org
X-Gm-Message-State: AOJu0YxIQ3YFh32n6Jht2rYulpLlcpruIWpAsIm41UsPYVVJfYqH5djL
 vo3GW3sWXZUAAVMKubapHyVcpaHwXSMfS+nauCRHfHKwugSGHgvmR7dWxSHsTN6kJ98=
X-Gm-Gg: ASbGncsYVrMLEiy5SxtFXbihw8fp16gYC+ZcrdELsGPEOhdYAKcffN4JIgICqvRaNB8
 jE7xAGy/vMMIesZTNDSj7RUE1Kn2DVRJG/mBrqqUK3j3oUCsZCpGtH44UYGPwHa/vwClMFJFwmE
 POr0Z0Q2J6XIA9w6ne1Rv5fRKeELxi833K3gGBvQ7W50RNZObXKNnTIGNJzIIHRGCQCn04/VOoo
 ZFoAUuDFNz/5bhn+iqs4p9N8yqU9AsHryR7FlkUmDA9BFBS5iHlRlEOwwFqlpy++Rpxv0mKswBP
 Y3XeZaCHiyyS8gkumZTFxUeel6Q3+HLLQLELC2IFF1stYRaI3tmo/Eae+U7CmMWGXqZ9+bZtlps
 Om2nPvveBIlpsyqXkp0TOxZN/unIQdU3WvIAC97uhPw2rI+hcfCHnKqgPEH2B4pkRYrU6NproZ1
 Fu/IkWa7XBdna0J+JKnHi2FpyeQzSNKbKVQEGtYAQ1FhrRkSwAXmLr
X-Google-Smtp-Source: AGHT+IFTD26vRmotglD6f5FMl51+1zYl8TM8Z+YV6DyeEFPfbeXvtdFnq/HDjAXHmOU97YgnKYqPDw==
X-Received: by 2002:a17:907:728c:b0:b6d:2f3f:3f98 with SMTP id
 a640c23a62f3a-b70704bc291mr11019266b.41.1761842339438; 
 Thu, 30 Oct 2025 09:38:59 -0700 (PDT)
Received: from [10.180.230.213] (183.105.204.77.rev.sfr.net. [77.204.105.183])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b6d853f9a0fsm1777593766b.50.2025.10.30.09.38.57
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 09:38:58 -0700 (PDT)
Message-ID: <7ce76bec-757d-4541-a08a-4b77c2d85c6f@linaro.org>
Date: Thu, 30 Oct 2025 17:38:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 28/35] audio/dbus: use a helper function to set the
 backend dbus server
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
 <20251027151045.2863176-29-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-29-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::62b;
 envelope-from=philmd@linaro.org; helo=mail-ej1-x62b.google.com
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
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   audio/audio.h     |  9 +++++++++
>   audio/audio_int.h |  5 ++++-
>   audio/audio.c     | 17 +++++++++++++++++
>   audio/dbusaudio.c |  9 +++++++--
>   ui/dbus.c         |  8 +-------
>   5 files changed, 38 insertions(+), 10 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


