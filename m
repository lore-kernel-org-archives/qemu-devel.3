Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EEEDCF31AF
	for <qemu-devel@archiver.kernel.org>; Wed,  2 Oct 2024 10:32:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1svweC-0004DX-2p; Wed, 02 Oct 2024 06:31:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svweA-0004AV-UK
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:31:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1svwe9-0001Ff-Gm
 for qemu-devel@nongnu.org; Wed, 02 Oct 2024 06:31:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1727865112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=ZZHqzKPFNCiDCKssaQGRs4slL1v6DbhhJkC+NtX1JgQ=;
 b=OMqUjAUU0JuTEVzvClZHkbFPGhiPW0QQ2dCY++sSIPGzrmLaM9D5qt3Wo+YYGQq8K6KZLD
 aTeW91laxE/DaUf+YhkAiOquAfMUhyJ8J6zJdsH4/ux/xisBA2Th4gGx3vOs48B7bddc7d
 /wlSZxAwGY3HYzK9wJsYrsD4HZjeXB8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-530-Ysx965pnN7ShijehPo2P9A-1; Wed, 02 Oct 2024 06:31:51 -0400
X-MC-Unique: Ysx965pnN7ShijehPo2P9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42e77b5d3dcso42963335e9.1
 for <qemu-devel@nongnu.org>; Wed, 02 Oct 2024 03:31:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727865110; x=1728469910;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=ZZHqzKPFNCiDCKssaQGRs4slL1v6DbhhJkC+NtX1JgQ=;
 b=btMqOdsz8uKf/vS4YFd6rn8TVK09V9V573qAJDn/a+M7eVG+2XQU1Xd7HJxYQwUtB2
 uMmUlClu5yuQToxLq52oleuXG5F7vYHj5IRV/5k5I0ki+lwmKhn9Bs6kZA4rFKXLHfIV
 vR6JRZ1YCygQOBzWSbtmQBBv7zxKbks3XPD1dP1+WTsrMphz/4GiPWbqNUDtIIBLwxVP
 0fcgKo31u/6i0zegsbqtyy3ZG9o101zCjDEP44clxY0F8L4SxMa3+SKxDyZtV+9UpUBH
 DGiDah2wzih5Z5YrjqSEOZ/l4r9bpjzkTcmN5fmiqNcFcl8P4bvflwcurgXBEp4pl+68
 gsLw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVyrILay1U7x4wy4OFeNPAo0q9c/0yr3d4wa8J0yd0zW/LB4iAlfIHhaMSMEhYFb9O0yOIk+cQhs9I2@nongnu.org
X-Gm-Message-State: AOJu0YxAez24WBIwTI8E2zqCXZ8aRYiIFGU13oyCJNYo6baB8Vxw3U7s
 qqcN+0iEnL+496uyUYhuYt8wlM513npRWy/BV+3TMyriGnfsqV6e/5dY9P644pCcQ5749NV+lwc
 XXgR0Ewic0mtwLqnAfKKluFPrOxKQKzWP71yiHfx9dW68kiBlHgfb
X-Received: by 2002:adf:e7c4:0:b0:37c:c80e:d030 with SMTP id
 ffacd0b85a97d-37cfba0a72bmr1752170f8f.53.1727865110438; 
 Wed, 02 Oct 2024 03:31:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHqYnM07lwjwLsKDAHi+NVrNkglKFA+ef3B21NhhPlrK9bjHBjfybUVYjbxNRGLtU7TAaWqfQ==
X-Received: by 2002:adf:e7c4:0:b0:37c:c80e:d030 with SMTP id
 ffacd0b85a97d-37cfba0a72bmr1752147f8f.53.1727865109968; 
 Wed, 02 Oct 2024 03:31:49 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-49-143.web.vodafone.de.
 [109.42.49.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-37cd564d2e8sm13830500f8f.18.2024.10.02.03.31.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Oct 2024 03:31:49 -0700 (PDT)
Message-ID: <73ef9298-05ba-48ce-9d60-c1e2bf50d729@redhat.com>
Date: Wed, 2 Oct 2024 12:31:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/char: Remove unused serial_set_frequency
To: dave@treblig.org, mst@redhat.com, pbonzini@redhat.com,
 QEMU Trivial <qemu-trivial@nongnu.org>
Cc: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20240918144122.155351-1-dave@treblig.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20240918144122.155351-1-dave@treblig.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 18/09/2024 16.41, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
> serial_set_frequnecy has been unused since it was added in 2009:
>    038eaf82c8 ("serial: Add interface to set reference oscillator frequency")
> 
> It looks like the 'baudbase' is now a property anyway so the wrapper
> isn't needed.
> 
> Remove it.
> 
> Signed-off-by: Dr. David Alan Gilbert <dave@treblig.org>
> ---
>   hw/char/serial.c         | 7 -------
>   include/hw/char/serial.h | 2 --
>   2 files changed, 9 deletions(-)
> 
> diff --git a/hw/char/serial.c b/hw/char/serial.c
> index d8b2db5082..6c5c4a23c7 100644
> --- a/hw/char/serial.c
> +++ b/hw/char/serial.c
> @@ -951,13 +951,6 @@ static void serial_unrealize(DeviceState *dev)
>       qemu_unregister_reset(serial_reset, s);
>   }
>   
> -/* Change the main reference oscillator frequency. */
> -void serial_set_frequency(SerialState *s, uint32_t frequency)
> -{
> -    s->baudbase = frequency;
> -    serial_update_parameters(s);
> -}
> -
>   const MemoryRegionOps serial_io_ops = {
>       .read = serial_ioport_read,
>       .write = serial_ioport_write,
> diff --git a/include/hw/char/serial.h b/include/hw/char/serial.h
> index 6e14099ee7..40aad21df3 100644
> --- a/include/hw/char/serial.h
> +++ b/include/hw/char/serial.h
> @@ -93,8 +93,6 @@ struct SerialMM {
>   extern const VMStateDescription vmstate_serial;
>   extern const MemoryRegionOps serial_io_ops;
>   
> -void serial_set_frequency(SerialState *s, uint32_t frequency);
> -
>   #define TYPE_SERIAL "serial"
>   OBJECT_DECLARE_SIMPLE_TYPE(SerialState, SERIAL)
>   

Reviewed-by: Thomas Huth <thuth@redhat.com>


