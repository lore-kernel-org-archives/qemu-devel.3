Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9EEAC54ED1
	for <qemu-devel@archiver.kernel.org>; Tue, 27 May 2025 14:00:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJuqS-0002w2-Ax; Tue, 27 May 2025 09:59:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuqN-0002rT-UR
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:59:52 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1uJuq0-0005e2-7O
 for qemu-devel@nongnu.org; Tue, 27 May 2025 09:59:41 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-43d0618746bso28074445e9.2
 for <qemu-devel@nongnu.org>; Tue, 27 May 2025 06:59:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1748354366; x=1748959166; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8zRF7gZgpee+VA74X2ZTLJYR+l8cz0/HEAk7KOqBh30=;
 b=d0q4JJEIJpJ9+0Kg1NGHc0zgPYTz6YM+DET439KVgflZcJYE/QWVRVisaX2zJY61m9
 +XeEzG/6wqplf9gB52G6VGGCYiqUki7vnN7DF3C8wJG0d0JjytRuPm/JPkhB9MsQYFlJ
 2nX5M4QGYMOuIzTYr5YVgFOvC357bdBPc1n9bcFAG/frE9wEUzZ/KL7KdEI23YaqfZW2
 fLAkrJqtd2MbZmP3twYe4NN3c++wvjwtIdGn87VEBlCr2FlrMP4SWRtCepeDc0J8RPly
 hEBeY28lOi9LQesIa6WViiDipUr8XGRoYqoevKzkWxfMgt4V1r8tHoTPZRwdUm/bdq58
 qxdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748354366; x=1748959166;
 h=content-transfer-encoding:in-reply-to:from:cc:content-language
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=8zRF7gZgpee+VA74X2ZTLJYR+l8cz0/HEAk7KOqBh30=;
 b=Fdb3oScI8AkefJ0h2zWvVD9ZyhXfu8aMVFS0D0sZSpfx7v8g+dxWW+WGNwCL0O+qJ/
 vfpc9xa28qGpqotvii5295YGj1PSb55pyw/LTtH3/XF2tCF1FTPeZ5M9f4nAtOOxmjU4
 tr9fAZbeIp0bBTwTZZTfDxO37LjQyGmzufLBFHABaE1efu+wKjQUnSc083CetnSKNgdf
 4aXnrHEK3yfpjwYbDUZV9Y7SjC3WZkYl0U4FKb7Hmf9FNVmvzus+c/swpHe+kct24pJK
 JtB8bZaH0XKqzRFDYnEeyVfip4tabgWfRirxOVQhBpZpTDzG3Ndd6i+zSvdCn9JHe03J
 T2cQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVjN3e5+WmofvZQAwIdY6LLnaF6iaEyhpoRvpGgw2N/zPh1YbnyirFEeShVkJgCzOsdXHQdpqTdqarX@nongnu.org
X-Gm-Message-State: AOJu0YzyqG3/09G7/hfdtqgsTg+kswWRNL/pY7uwcPGjL2lhKBPbk8lW
 y7iS95o7by2+W7cJK282iESTPbnl5FDj8clSmBHk0igLkQwKl//2pSGLu2ElwpDUs1U=
X-Gm-Gg: ASbGncswRUtTF8Mp3glC2Niy3rTyFdPrub12zg2ePYWtLOyNKxMkTIXfWTij3NhGni/
 iHaZZGJijQVEfr05SiCqk4jRo5iZpwm6AsDv3zFznNoh3DoFRjdvHD/LQJlWCJ1M6msYruF+2Ec
 lZJm3/68GzW6seWNInQ0BVlnxOIltWWIVOgvsNjlvpCXKwbdvfgMnAlsCVMouZ1yZd/SjQN/Y8h
 OKlwxc76k/ZuLVOyZqoQtPVXxrXarMJXXsBxUOnle6roGjcDJAZVnp4emwu2LEkQSOouco6jQvD
 j5SE/0hhYfBL2Huz40g4ro/SQeW6xPEk47fmkFmFLA1nF5MmekwRzrd3i1wJ0KlW3upXJPC6E2y
 ReybHpvV3tW+gNFYcRQhWf5in
X-Google-Smtp-Source: AGHT+IF/jeZXc876/VN0/pSTmFwJwhH5Ab9yTN9VpAcz4z2IUBQsWIseCTSfEzbqTTrwLufXliQmIA==
X-Received: by 2002:a05:600c:138f:b0:43d:fa5d:9315 with SMTP id
 5b1f17b1804b1-44c94c2d54emr115574065e9.33.1748354366002; 
 Tue, 27 May 2025 06:59:26 -0700 (PDT)
Received: from [192.168.69.138] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44fcd11e343sm18454805e9.1.2025.05.27.06.59.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 May 2025 06:59:25 -0700 (PDT)
Message-ID: <684885a4-0022-4de8-98aa-07c9fe4a11c7@linaro.org>
Date: Tue, 27 May 2025 15:59:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/scsi/esp: fix assertion error in fifo8_push
To: Zheng Huang <hz1624917200@gmail.com>, qemu-devel@nongnu.org
References: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
Content-Language: en-US
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>, Fam Zheng
 <fam@euphon.net>, Peter Xu <peterx@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <37889706-8576-476c-8fea-c1a3a2858b1e@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Hi,

Cc'ing maintainers:

$ ./scripts/get_maintainer.pl -f hw/scsi/esp.c
Paolo Bonzini <pbonzini@redhat.com> (supporter:SCSI)
Fam Zheng <fam@euphon.net> (reviewer:SCSI)
$ ./scripts/get_maintainer.pl -f migration/
Peter Xu <peterx@redhat.com> (maintainer:Migration)
Fabiano Rosas <farosas@suse.de> (maintainer:Migration)

On 27/5/25 15:12, Zheng Huang wrote:
> This patch add validation checks on FIFO structures in esp_post_load() to
> avoid assertion error `assert(fifo->num < fifo->capacity);` in fifo8_push(),
> which can occur if the inbound migration stream is malformed. By performing
> these checks during post-load, we can catch and handle such issues earlier,
> avoiding crashes due to corrupted state.

How can that happen? Can you share a reproducer?

> 
> Signed-off-by: Zheng Huang <hz1624917200@gmail.com>
> ---
>   hw/scsi/esp.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/hw/scsi/esp.c b/hw/scsi/esp.c
> index ac841dc32e..ba77017087 100644
> --- a/hw/scsi/esp.c
> +++ b/hw/scsi/esp.c
> @@ -1350,11 +1350,17 @@ static int esp_post_load(void *opaque, int version_id)
>           /* Migrate ti_buf to fifo */
>           len = s->mig_ti_wptr - s->mig_ti_rptr;
>           for (i = 0; i < len; i++) {
> +            if (&s->fifo.num >= &s->fifo.capacity) {
> +                return -1;
> +            }
>               fifo8_push(&s->fifo, s->mig_ti_buf[i]);
>           }
>   
>           /* Migrate cmdbuf to cmdfifo */
>           for (i = 0; i < s->mig_cmdlen; i++) {
> +            if (&s->cmdfifo.num >= &s->cmdfifo.capacity) {
> +                return -1;
> +            }
>               fifo8_push(&s->cmdfifo, s->mig_cmdbuf[i]);
>           }
>       }


