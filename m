Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 381E5F3ED67
	for <qemu-devel@archiver.kernel.org>; Sat, 11 Apr 2026 22:42:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wBh1X-00075x-Dh; Sat, 11 Apr 2026 18:41:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBh1V-00075U-JR
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:41:53 -0400
Received: from mail-wm1-x329.google.com ([2a00:1450:4864:20::329])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1wBh1T-0006O7-VK
 for qemu-devel@nongnu.org; Sat, 11 Apr 2026 18:41:53 -0400
Received: by mail-wm1-x329.google.com with SMTP id
 5b1f17b1804b1-488a88aeec9so42216645e9.2
 for <qemu-devel@nongnu.org>; Sat, 11 Apr 2026 15:41:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1775947310; x=1776552110; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KNrQ6Mh7MK+qwneHukA7Q54oBzJkbdThTvUW7Qg0+MY=;
 b=t940Gi+xlQyNRJnK9S8hLJx6mCkEiKGtgh/iW+CyK5BAXqhhxRbRds4ws9Acc//ay5
 eoFRT5cdH8vXk1G7/qILnfHxNgELV0fWRScOYzS1RtOO4Nm+TStR/W37uCf2/R7keVue
 yunphJVTqlgQDe5Vhe1J5i8rYtcc9dYjXxzAFGXJ+FeMzA/hAeG6hy0CyqaLhjBqs60y
 QP5xQpzwKkB29HT0kQrYvIHD9dblY5WE/Vh2Kwv9UIWebsjlm0pMABEaQ68f4Q3sqHpD
 Lm2s7YhoEFCQvv4/Uou671VLJKWHSMSP2N71Y1rO8gN0HFzCksSaMfPu5pbAhkPVU4wt
 +f7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775947310; x=1776552110;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=KNrQ6Mh7MK+qwneHukA7Q54oBzJkbdThTvUW7Qg0+MY=;
 b=J23ZFDCHHwTZ8svQpDOP374cQBNTfLVWogbcPkknD/yGy+6ksK1N1CCe487apUvKhi
 mkcJ81DeFqClhJjT9DrcbmHrCYoOj4mt71nplaGdTKKULXertFHSEAm/JNoj3XKkOcl6
 26jlgyx+tXMKTPX+AuahQ5jx7Ajpqi58ZWLcs86+8FwS3BA0pTjjaO5z2z5DFZWtOr2S
 98FFF6gzsHb99gaEB8K5VOsA0/8TJdKyVRhq+7LIQNjDq/OE/pWlZ9lGvVzK6YC2KQcS
 3M+MSeCkk4dg4XkYPDHePhwJ7OOs11eXyhDWUheK0iKkjBPn6ClQgXMM0ibNE4RMy2ji
 GA/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW68gJfqm4NrzpDRsH6nZfmA1jzERvfr5afr9xrGuhagdacEtQ4wmgRHWw5tOtJeFu4f96owlUXZ3QP@nongnu.org
X-Gm-Message-State: AOJu0Yy8+LRDPe2X86sLVqU1XOcoTQUIX7Z9krjPdsAoH7dzk9h6DyYG
 0RfBZH831DKQnUU6n4wUlbWBNAXEt1An6i5ptipxG0K5+fXSWUiaIP7kj29nKNGcNNQ=
X-Gm-Gg: AeBDieuYcYcqmSlgLpAUrQX3Ih0KgC1WIN4taQT7i+yW4l5hQL0p/L2idVd6WCIH6+6
 EfCvTnGMu83FFb+UT1Nq7sIGJnCsdZw9GMPaYOyEbQRTVKbHX66WSV8ehFJtxc/39EW3QeJjcqv
 dxneymcqgK/xAKkjDIbzL1+5IkGnwphZfAz4u++PXQIy/o6Q2kLAIXBHTCLgRQpPi66eionNHda
 HLMnEsceXJIv4naL3o/OVWCgjpyXbp+sZ3bTz5AvpCjtvPOPwO7DLkGcBBJDqMW+7ab8Z7uD2p6
 ux+Pge7i0lqYOqvPhaBNedBeeWoeDADJ41OHCPbrGTWG9Wn2FjsBfYBJ/I1chlGOV8Nn7vIR5FL
 qHp4mX1NRX6wcgSQyVSV1fDO64sT8zMs1+3FQ5gu8pMNBm9CayJHwTmBTTrxWcoFo7RO39AU4oq
 PplTY4aBMbFiwxonU/Y7qlamJAWWwRtPnFkvQOjNDjAPxeu4vxRe6Y6S44AVsDP+AgNg==
X-Received: by 2002:a05:600c:348d:b0:486:ff92:63e5 with SMTP id
 5b1f17b1804b1-488d67df5aamr111309665e9.6.1775947310019; 
 Sat, 11 Apr 2026 15:41:50 -0700 (PDT)
Received: from [192.168.69.228] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43d63e5061fsm19841928f8f.30.2026.04.11.15.41.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 11 Apr 2026 15:41:49 -0700 (PDT)
Message-ID: <aebc053c-0a57-4a69-9f98-775377ec6c25@linaro.org>
Date: Sun, 12 Apr 2026 00:41:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/67] ui/console: dispatch get_label() through QOM
 virtual method
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260410-qemu-vnc-v2-0-231416f76dc3@redhat.com>
 <20260410-qemu-vnc-v2-12-231416f76dc3@redhat.com>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20260410-qemu-vnc-v2-12-231416f76dc3@redhat.com>
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
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/4/26 21:18, Marc-André Lureau wrote:
> Replace the type-checking chain in qemu_console_get_label() (using
> QEMU_IS_GRAPHIC_CONSOLE/QEMU_IS_TEXT_CONSOLE) with a QemuConsoleClass
> virtual method, allowing each console subclass to provide its own
> get_label implementation.
> 
> Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   include/ui/console.h  |   2 +
>   ui/console-priv.h     |   1 -
>   ui/console-vc-stubs.c |   6 ---
>   ui/console-vc.c       |  12 ++++--
>   ui/console.c          | 101 +++++++++++++++++++++++++++-----------------------
>   5 files changed, 65 insertions(+), 57 deletions(-)
> 
> diff --git a/include/ui/console.h b/include/ui/console.h
> index 08082389f71..395a723e318 100644
> --- a/include/ui/console.h
> +++ b/include/ui/console.h
> @@ -129,6 +129,8 @@ void console_handle_touch_event(QemuConsole *con,
>   
>   struct QemuConsoleClass {
>       ObjectClass parent_class;
> +
> +    char * (*get_label)(QemuConsole *con);

Preferably 'const QemuConsole *con', otherwise:

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

>   };


