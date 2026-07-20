Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B6E8C44521
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 07:38:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wlia9-0000nI-R5; Mon, 20 Jul 2026 03:38:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlia6-0000n2-0G
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:38:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wlia3-0004QL-SO
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 03:38:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784533105;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=2t4CKqK7Ktd/l4r6Bka1AEiQNgyOOA/SOvYdtTPea4o=;
 b=Q7iT1dM4eJAISCq5FEky5JbJSdaNRJBC386jviRUvADuhH8AeKFZhuegm+wat7vebAtGMF
 dh29YTNhtPyzqe74hysfwRnwGvMev6CN7Z2dhgZ8irlMzFQbyUeAmyJHO/dive3DFAZSxa
 8V8MdddHDpMrnzgc2Peo1FQGRR30RtA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-461-KH0ygj7yOuqflbRKbi4xxg-1; Mon, 20 Jul 2026 03:38:19 -0400
X-MC-Unique: KH0ygj7yOuqflbRKbi4xxg-1
X-Mimecast-MFC-AGG-ID: KH0ygj7yOuqflbRKbi4xxg_1784533098
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49560dddaa4so1900145e9.3
 for <qemu-devel@nongnu.org>; Mon, 20 Jul 2026 00:38:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784533098; x=1785137898; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=2t4CKqK7Ktd/l4r6Bka1AEiQNgyOOA/SOvYdtTPea4o=;
 b=p815m6FG8TbWy8fXxcYNCEPlGLQOx2kOPuiTqHI81LH1/8Jc/1SK0GkIVz8M5acD6s
 8sm6sqhu0qaPyWIwb1WJYxyYs4qDSlDHBCDrmx8bNVAhdjHgDEMC25sKNb7CR5wh9cps
 x/XuXqm4Fp6Ftyl7KmjAEmDfqpxCuZCDHqIkXw8BL0pm9Z4+WfYoA/4tHgYPmUg8afb1
 1LeBC2Nv0uidQX/PoktK++lOyBdU7GtpxNIQtm8wQFbYTnqPVo1NsMuf55cC1iR0Gego
 bXw9EzQnghQDM/2kFV/JRoNbEZA2/uC/7WlP60QLCxPKLiSujijXj9CXUy6n8NTlsdkW
 zMYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784533098; x=1785137898;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=2t4CKqK7Ktd/l4r6Bka1AEiQNgyOOA/SOvYdtTPea4o=;
 b=AUHSJcnGtqBOtDdJgrQ/o2snj5Y/J48NbfhkyGLuYE3EbJxC0hHPxvAilfj2A4EwsX
 H5X8613xv9Rp9WEBMxIebOK/p/T9LIiXOGM8GIeUkAryF2KxardnOrsKw4f2N4HkdXak
 3OLnnYxVZ81BAllZdYWfVAEn5Up7wa/YpwGqSylLeJebIjZ74HUYlMAwt1eXG2fKjAP9
 Dnomh8XHOg3vxtOkMOQIyC3lxs3HI2SQN0dCpZB/7z4C2/NtaRlWGwcfZg/nzu4OOJrb
 kVhR4VFqmmtI98M8sxGzWm0nQ91L8A9RSvCHDtYf1+1vUljH2O7fSZ3mNwSXlihg+8qz
 kEUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RrSzKsDgZUNgIQA0sVrmbec/NzIb4UGfiQ02iRpnniU7gSdF78hZvpSirrhU3kesPU4qe8S1yaa/rm2@nongnu.org
X-Gm-Message-State: AOJu0YxaCW1ITuyBvAK02As3gjO8FIhX7Dk1m3K30wOX/ubEYGdX/L4J
 MQEhRSXAgF48Ci2ARvEJxt7d1BYa3hWvCHfi+SoI/vaeBAVCwP1UdYyGqwo9RGohJRoBbBJUMc6
 dL06zNNHD7dvDp+0RYPb2SqQL0paGeZz6xMYRqzDaMOxMZv19uQlSfgxa
X-Gm-Gg: AfdE7cldJp0XiFUUVCrFIXSGAkJe+9cDNTBuyQV1WDUVRGmuPfoNuqrz9w1L9aRRdJW
 TOyyTIPWcyOSGMMyWfVAaJt+w7gnPTDy76LRsKgTk8XOSnD/cDhzn9OoJltKCUSiHm8ZZpW4zfU
 MZM/kKFaEZCTL7qCJJ6tR5WpMzuhx2z8PsbdZL8SK/wrMIojGown27M6dIFBx7FkPAjlAC1r5xu
 1AdysbWLPOQLETDvVmFJ8bxWhzSL1wkwM0GQyEF+KbPhCdRuPxyLXN/+YtMlEH5lhcID2KD6+q/
 9OkfHp+4oO49Q6F6a+Fjo1PeXipE7YHKeOOVVWowMp9l3tzJDAwpQjsDdiL6anVbz5CwONAxiA=
 =
X-Received: by 2002:a05:600c:208:b0:493:c8f7:3631 with SMTP id
 5b1f17b1804b1-4954a4043b8mr96011295e9.22.1784533098471; 
 Mon, 20 Jul 2026 00:38:18 -0700 (PDT)
X-Received: by 2002:a05:600c:208:b0:493:c8f7:3631 with SMTP id
 5b1f17b1804b1-4954a4043b8mr96011145e9.22.1784533098051; 
 Mon, 20 Jul 2026 00:38:18 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.144])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4954a2b87c6sm463973645e9.7.2026.07.20.00.38.16
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 20 Jul 2026 00:38:17 -0700 (PDT)
Message-ID: <22e68ec3-c020-4a5a-9463-dfc66ed4b503@redhat.com>
Date: Mon, 20 Jul 2026 09:38:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] usbredir: fix infinite loop and SIGFPE with zero
 max_packet_size
To: marcandre.lureau@redhat.com, qemu-devel@nongnu.org
References: <20260716141107.3597076-1-marcandre.lureau@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260716141107.3597076-1-marcandre.lureau@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=thuth@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

On 16/07/2026 16.11, marcandre.lureau@redhat.com wrote:
> From: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> A malicious usbredir peer can send an ep_info message resetting
> max_packet_size to 0 after bulk receiving has started. This causes:
> - infinite loop in usbredir_buffered_bulk_packet() where the splitting
>    loop increments by max_packet_size (0)
> - SIGFPE in usbredir_buffered_bulk_in_complete_ftdi() from modulo by 0
> - SIGFPE in usbredir_handle_buffered_bulk_in_data() from division by 0
>    when computing bytes_per_transfer
> 
> Fix by stopping and disabling bulk receiving in usbredir_ep_info() when
> max_packet_size is set to 0.
> 
> Add post-load check, and assert() for the invariant.
> 
> Fixes: CVE-2026-63319
> Resolves: https://gitlab.com/qemu-project/qemu/-/work_items/3995
> Reported-by: Tristan @TristanInSec
> Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> ---
>   hw/usb/redirect.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
Reviewed-by: Thomas Huth <thuth@redhat.com>


