Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DECFCCCF9EE
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Oct 2025 21:46:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEDyS-0007nY-Vr; Wed, 29 Oct 2025 17:44:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDyQ-0007l8-VD
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:44:54 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEDyF-00061v-VE
 for qemu-devel@nongnu.org; Wed, 29 Oct 2025 17:44:54 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-4298a028de6so1020582f8f.0
 for <qemu-devel@nongnu.org>; Wed, 29 Oct 2025 14:44:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761774274; x=1762379074; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=UDdG9vRzLSWqPzQtLxCE0sbsDd3SWye7KKaKxVt/EIY=;
 b=GI/Ie3MLm+q5Ls5dzP2GpmsWnQgVAZ/NF8uAcs6xDnGwuzFgCWytMq5D29z+GGHkAe
 it8Oe5yG0mnBLvNSeY6rVjDepOzK/hT2iHm7A+U0t7DCaU+0jKyuqEJtMBKeBjhEQUP6
 A5KuSYhKCHDzL33F+8pJk2xjKdjV7LC9ybRAYbH7bkldqvhQFmFCM0L1EaVmm0ey4t4R
 OiyvzflgbwI1sB8ltSsQhXCQ7Yzj5w7mRvUoeAoo7lf+rKfyQESUeeo5zVEjhsRlOoNS
 PTujxUPuUEVrjLcSpejJg01uxkw4fSZlQN2O6u6og1VK9ZGHYlZpII1wUdw9IWrmUoph
 2Iiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761774274; x=1762379074;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=UDdG9vRzLSWqPzQtLxCE0sbsDd3SWye7KKaKxVt/EIY=;
 b=v5yv7m2YwZX01sX6szYcGhQIvKt7q4KlFKtvTrHUH2gukUqNvAwTMdY6q/YmeeKXOQ
 SrYonNodkRKR6gjlz/FVuE3Kh8Kp5RLDx3gP7i+ycnJBD9Zz8xA2m3I/SfLHgj1g7eQl
 E4LKhpDwLeirr7yFG8JAVw6kJ8ezoR6T/SSOEyWvhW4DWDY5cDfW+9MBEL6t4x8dxGPd
 rgr415230xeb9Z2MI66wsMxWMGMUPgdTAT8Oe7eFLNnUZt97Ac8pcY5U1x5b/BSGlMP0
 jaG0jR/n05Pb3hQX3/37511jHLVXic09SYKIJy9I3v9qaCKi4cRudwo0geU8A9SVMeWY
 S3Zg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXF7C75685XFUBTTIMwJunvnWoKXwB+gEmE6iCui8S/RPOy2apvhQCmAzqw+QXQZaR1byFvsR0mfFxz@nongnu.org
X-Gm-Message-State: AOJu0YzlEo0KurjY9bRqJkVNf1DKWjc9byV7qMPvEx/0v+n2Tmz1qFaR
 aZOd/75re2rt38O5759cZpEqpkP39PknkK3/iv+d+GWX9ts3KiSfLNbdhrIcjONjS30=
X-Gm-Gg: ASbGncsf63/8SHaszm9clF23WQ/1OAt24M+KCTzbqx3Bge5BPysK+3tFVPmu+EqAjt0
 m7pytcdZ9uaVKmTdpCWWfUZCAlWjzQYJX9ApQoqQZC/trRLiMSI4zgVtFBNyPLxNEBmvMVW4r9T
 3+fWrSx7qUlVavBtSQZKxhw28WKo8oGok6LgJsi2FW4gPJbubzXPWQM3sJIUNt3hnYvxyrqrdZl
 J0C6vpH5gnOr1kDrMljXcRAu9Ws3IcrqHkHVErUhqj8fz/iJzxgv/3RpmRx/WyI3nHe78pjYRpQ
 ivxAS9iRL/PswlG19siZdKRmUNMLz9sTEm7qd2RVNungDs1xqyre1WEHhg+Bg3yJtevMnCBbipr
 JNZ9lg5lmyUxQIFmyRLEM1U4DUX+kvxi5W8qgLvB8tIx6yYCka6mc/PMk1vaJeQYH/eBizn/r+h
 f250dVg8MThIWycv5G9AUjbTguOap8JUjC4DQkFbzMBpY=
X-Google-Smtp-Source: AGHT+IHCMOL5lEG7uVAhkjuhUltsY7VIM/l4EQgPJmPm+DxoYytMBjptZof5/wUmnR0MYpjGe6K8rA==
X-Received: by 2002:a05:6000:430c:b0:425:86da:325f with SMTP id
 ffacd0b85a97d-429b4c5303emr1081859f8f.27.1761774273691; 
 Wed, 29 Oct 2025 14:44:33 -0700 (PDT)
Received: from [192.168.69.201] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-429952db99asm28493969f8f.32.2025.10.29.14.44.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 29 Oct 2025 14:44:33 -0700 (PDT)
Message-ID: <6ba24ce8-239a-452f-b051-cffb86f1a1b6@linaro.org>
Date: Wed, 29 Oct 2025 22:44:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 05/35] hw/audio/virtio-snd-pci: remove custom model
 callback
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
 <20251027151045.2863176-6-marcandre.lureau@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20251027151045.2863176-6-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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
> virtio-snd can rely on the default code to instantiate the device and
> set the audiodev.
> 
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/audio/virtio-snd-pci.c | 16 +---------------
>   1 file changed, 1 insertion(+), 15 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


