Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515DDE7716F
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 22:46:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIy8J-00032O-E2; Wed, 04 Dec 2024 17:46:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy8B-0002z1-JQ
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:46:05 -0500
Received: from mail-pl1-x635.google.com ([2607:f8b0:4864:20::635])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1tIy8A-0003QU-1Z
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 17:46:03 -0500
Received: by mail-pl1-x635.google.com with SMTP id
 d9443c01a7336-215770613dbso1521435ad.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 14:46:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1733352360; x=1733957160; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=TLv3y8TooTZrXkX+y9Bi2qaMpM3/OPWrxBmqMaW039c=;
 b=EoHSSZnXS3NixEcQyrebGLvoDmC7sh+mt53MzO/XM7mSkYaL327Vk+ISDGdQKOTQu8
 bWU5IX1jPOtryjyslVdm5Sd5mHmoAr2oTmStW5B73ZPqiiAV6rJQML9/Tg0Mql0kNlD2
 2FFJtpfN9jQgXdWAfHiLDTtzad2cPGbY1mfNFx3B/CtQlfXMsahz9Uy8lWe4YCTC+INK
 z5r0GwnaAHlPNkarOpRbip6hSpMfFMJIDOAlRSl7zJkkvvbAZ151x1JiD06TRw/SANqx
 o2B8XJ6kuTAWvd+99khNPLXni1Tni1c/JHXEdsAyVWaRze9OxQDZK0PrfkVxiRlgD4bz
 m/zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733352361; x=1733957161;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=TLv3y8TooTZrXkX+y9Bi2qaMpM3/OPWrxBmqMaW039c=;
 b=CBE8sxT/HjsDgC02CJ9W2zssPE+MVZ4+i3TbZK1vSEZZADWk5M2oVm/cv6jN2L8K0n
 eyv9o7owyAlCQi0ADfhLmQuqHXLUZyHayat8EI/aVOvWAC9vIonV7g+Ab4Joo6N2McgD
 t6UGFK5WbaxDgvnjbyc2n99QDf4zCMQLmCCSMUNFsbknGd5VBqquLHD/9Mip3Fhjukkr
 MP8GyLBbKl0dFIoec+ALWs7aYjTZlwIEeM1B9Zi+kNw3SKDokWOrHb/JZCrUfhFzPejD
 QE9LEL3VDzNlqOagVIE6w7R2LZXydJpvpXL/E2Ao0HdbzctUHD7ALoG/xF5lOSaXYkOL
 uq3w==
X-Forwarded-Encrypted: i=1;
 AJvYcCWI/eJVQcizGyELVDROEEbdopjjML9AaYpE9bPFvo4txaoCGx5pSS2+GimZaJA0zaY8How7x4Esyrr4@nongnu.org
X-Gm-Message-State: AOJu0YyX1vAtaWJOol180aB6S/i/t78vlfMuXJFXBuDK+6ZJPNA7PuiQ
 K8veEzczfWQRmgWD8OxW/YdGkZBHnAEdkQtRGLhHbT+BUEc0dg4SeOHBjIHfDxs=
X-Gm-Gg: ASbGnct1Jo4biCnB0ltu3ebKTeilEcK1yTX6zD74LTHomYGqYSHZquXhZqhMHyc/HdZ
 RDVN3Z38oB4CFG5ejVbWOKoopoqs3EwR+IWyPIMhd4eTR/dc/1OGvo2CPlpnhSZCMGum5GE9FtW
 j9QV7i5JvjYjwlVSzKywctR6PQQpIQwLqrzi6Cl/IYR7o8Bl6CEfEfu3qolfR+PZl5CouTM7I3p
 YOoUvQb2wpyrFU6ay726ijh77i6HiqgeZ27e/Q/81sRUXvB/1vXD8BQgjYF1FntbZd8gOYXRuZK
 5ottMZrRnsEYctkFxTisNA==
X-Google-Smtp-Source: AGHT+IHoxbuVYXn3fpyqKiOjzfjego+34PrGBu5eshGGYBhNRDZFIAWg3Nago/gBeeD4xAcDQqO/4g==
X-Received: by 2002:a17:902:dac2:b0:20f:c292:6662 with SMTP id
 d9443c01a7336-215bd17a724mr101709475ad.51.1733352360695; 
 Wed, 04 Dec 2024 14:46:00 -0800 (PST)
Received: from [192.168.1.67] (216-180-64-156.dyn.novuscom.net.
 [216.180.64.156]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-215f8e63329sm545565ad.59.2024.12.04.14.46.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 04 Dec 2024 14:46:00 -0800 (PST)
Message-ID: <46562dd3-6699-4b76-ae28-e6523a8152c7@linaro.org>
Date: Wed, 4 Dec 2024 14:45:59 -0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v3 02/11] plugins: add API for registering
 discontinuity callbacks
Content-Language: en-US
To: Julian Ganz <neither@nut.email>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Mahmoud Mandour <ma.mandourr@gmail.com>
References: <cover.1733063076.git.neither@nut.email>
 <e4af8fed4cc5449a7be04fbbf026abf267dc189b.1733063076.git.neither@nut.email>
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
In-Reply-To: <e4af8fed4cc5449a7be04fbbf026abf267dc189b.1733063076.git.neither@nut.email>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::635;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x635.google.com
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

On 12/2/24 11:26, Julian Ganz wrote:
> The plugin API allows registration of callbacks for a variety of VCPU
> related events, such as VCPU reset, idle and resume. In addition to
> those events, we recently defined discontinuity events, which include
> traps.
> 
> This change introduces a function to register callbacks for these
> events. We define one distinct plugin event type for each type of
> discontinuity, granting fine control to plugins in term of which events
> they receive.
> ---
>   include/qemu/plugin-event.h |  3 +++
>   include/qemu/qemu-plugin.h  | 15 +++++++++++++++
>   plugins/core.c              | 15 +++++++++++++++
>   3 files changed, 33 insertions(+)
> 
> diff --git a/include/qemu/plugin-event.h b/include/qemu/plugin-event.h
> index 7056d8427b..1100dae212 100644
> --- a/include/qemu/plugin-event.h
> +++ b/include/qemu/plugin-event.h
> @@ -20,6 +20,9 @@ enum qemu_plugin_event {
>       QEMU_PLUGIN_EV_VCPU_SYSCALL_RET,
>       QEMU_PLUGIN_EV_FLUSH,
>       QEMU_PLUGIN_EV_ATEXIT,
> +    QEMU_PLUGIN_EV_VCPU_INTERRUPT,
> +    QEMU_PLUGIN_EV_VCPU_EXCEPTION,
> +    QEMU_PLUGIN_EV_VCPU_HOSTCALL,
>       QEMU_PLUGIN_EV_MAX, /* total number of plugin events we support */
>   };
>   
> diff --git a/include/qemu/qemu-plugin.h b/include/qemu/qemu-plugin.h
> index 9c67374b7e..f998a465e5 100644
> --- a/include/qemu/qemu-plugin.h
> +++ b/include/qemu/qemu-plugin.h
> @@ -273,6 +273,21 @@ QEMU_PLUGIN_API
>   void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>                                            qemu_plugin_vcpu_simple_cb_t cb);
>   
> +/**
> + * qemu_plugin_register_vcpu_discon_cb() - register a discontinuity callback
> + * @id: plugin ID
> + * @cb: callback function
> + *
> + * The @cb function is called every time a vCPU receives a discontinuity event
> + * of the specified type(s), after the vCPU was prepared to handle the event.
> + * Preparation usually entails updating the PC to some interrupt handler or trap
> + * vector entry.
> + */
> +QEMU_PLUGIN_API
> +void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
> +                                         enum qemu_plugin_discon_type type,
> +                                         qemu_plugin_vcpu_discon_cb_t cb);
> +
>   /** struct qemu_plugin_tb - Opaque handle for a translation block */
>   struct qemu_plugin_tb;
>   /** struct qemu_plugin_insn - Opaque handle for a translated instruction */
> diff --git a/plugins/core.c b/plugins/core.c
> index bb105e8e68..a89a4a0315 100644
> --- a/plugins/core.c
> +++ b/plugins/core.c
> @@ -559,6 +559,21 @@ void qemu_plugin_register_vcpu_resume_cb(qemu_plugin_id_t id,
>       plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_RESUME, cb);
>   }
>   
> +void qemu_plugin_register_vcpu_discon_cb(qemu_plugin_id_t id,
> +                                         enum qemu_plugin_discon_type type,
> +                                         qemu_plugin_vcpu_discon_cb_t cb)
> +{
> +    if (type & QEMU_PLUGIN_DISCON_INTERRUPT) {
> +        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_INTERRUPT, cb);
> +    }
> +    if (type & QEMU_PLUGIN_DISCON_EXCEPTION) {
> +        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_EXCEPTION, cb);
> +    }
> +    if (type & QEMU_PLUGIN_DISCON_HOSTCALL) {
> +        plugin_register_cb(id, QEMU_PLUGIN_EV_VCPU_HOSTCALL, cb);
> +    }
> +}
> +
>   void qemu_plugin_register_flush_cb(qemu_plugin_id_t id,
>                                      qemu_plugin_simple_cb_t cb)
>   {

Reviewed-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>


