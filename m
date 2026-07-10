Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8D6CC43458
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jul 2026 13:44:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wiBWS-0005h6-TI; Fri, 10 Jul 2026 09:44:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wiBWQ-0005gq-D1
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:44:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1wiBWO-0007we-Ms
 for qemu-devel@nongnu.org; Fri, 10 Jul 2026 09:44:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1783691043;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=aYJqpLb9GIgT20IUphAhHkDOGA0o7U4qoe1VhHkgGlU=;
 b=QmbDQ64Et3vrtKWuqkTfg5Qs2bgzVhJcmxsJOtUXwpf3tcJ03MsmBLS70vTgPGd0xsEWdT
 N8aCV/K9uV6z+/T9zIgAacfgXVvAav/34XmQnNa67MMb4vZ2j9PGRJuiApeX1a3ntjw+MB
 WsvCDRtNUkwOPWpaQ7bbQBS3D8cgk2k=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-424-8343IuFuOcKh_gtmy4EgQQ-1; Fri, 10 Jul 2026 09:44:01 -0400
X-MC-Unique: 8343IuFuOcKh_gtmy4EgQQ-1
X-Mimecast-MFC-AGG-ID: 8343IuFuOcKh_gtmy4EgQQ_1783691040
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-493c20d0468so15104875e9.1
 for <qemu-devel@nongnu.org>; Fri, 10 Jul 2026 06:44:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1783691040; x=1784295840; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aYJqpLb9GIgT20IUphAhHkDOGA0o7U4qoe1VhHkgGlU=;
 b=YaNIl+yYqxycSR+5EJTrd5W7VGTWfr48jZgor3zVer7y7+ceIatqyfFiSidVJYyA3k
 B9lYDEeB42BgbyF+TW2lOtr2iZcfdP8jWDZJ0bzmRBNlpZcoOiIi8PjbwtCascEAj2sz
 wnTYIjL0Yz6fsjaVjAnB+7Z04pum88aDdJmGuARN2bivprw8D1DWdAgHQCMVxb74ZheS
 zhA7RFf2uO/bk7Hy+LYgmHatp2gBg2BUUEijQLTKV+fdJq2ASQuGa2jt/fbj/XIK025u
 VSsFvQIkyS44sUoRMiwBPcVb7PIqh/jZNiI1PYfWs82M3EOKGmm1U9wj0WdnYIOhtZw6
 SAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783691040; x=1784295840;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=aYJqpLb9GIgT20IUphAhHkDOGA0o7U4qoe1VhHkgGlU=;
 b=RLqMck/0Av20232lRWzepILSEFMELmjVFrBQ+7T/qmaeNgbdrZT+PdNLmjDgGK8Dae
 z3eGmiSu9GeDC/0QEMEo/ZADTAQW+X1vahYKHnUg7v35fy18abwzyEfzHmt+FNi2glCf
 NphFMGUZwy715dGBbuaRYT2JV0tsi15sOMPLAeLLlMyxoZslXkAY0kvVyG0t9fZSUrlm
 RstoZZyAp15DmMyYAcditeYiRzV7RSJDK6RYnuy5v4kvUSsgHoIQ8I8LvXGoQ4V6ZHjY
 bbDe4AiU1yOse6lNLZXe5LazL7QAFXTlnVQAGv+VqpqKekopAHvLQh4NeOcKFo4L1OvW
 4AjA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpLdgAufT3PRXCQKKwzpZX0pKzBN53ffefBtdJV1DmLiAMnBBFUF7A54ite6zqnlVTFJPPpSrBcI6XO@nongnu.org
X-Gm-Message-State: AOJu0YysOTZLBpcUvUTfzkjlvN6QbRdM353MLhtggdsYgHfcE6XC0m4q
 lPGhBDfZ3ZmKFbsCjxzKsGdaG1IdNepsANn6tGtURyoSi/QtZfIqBj/FXaUR8dpDZ/vo1vCOgqE
 wHSJyB0ciaef0G68J5tC2VrcuXSIXtRDFYmrlzDtBaO4of4q/boZ5zQVh
X-Gm-Gg: AfdE7cl2WsyE2tscD6hAPOFU0ddGxffHWJN1tqaBnKowomhCG8164YWXRrC+0dDkW4C
 pdTh0q9YrPL2e/3X2n50yw5tBR9GwwNYVfNmNxQvqSw7HQ8wp0P0DvD0Gkcb5siQ6Uou/r+TZed
 if0pcBhRqh8+GY6NUoc9CuWYXXTaV6JxwMOqJHsdHlkBck8IV4w3akUhYwgBb+1uEY0KelMlsUa
 xdI1uS/kuUeze2mSrWcaVKn0vzdAe7+4B0uqtDdNCaobEtJJs6iXlAYBL8N9P7KOvgPhUb/WmzA
 Vw88vT9u2Maz3+oz9063d9dhTlCTDEAjl5EjGMZk5jU/8ZjX0GoX2k1HWyl6QRq+a53gi8itaC3
 9zsIvn5hKZ1ZyPJtz3DdUWmG9J5xxacANTjGYqNCSER5b2IUTpQ==
X-Received: by 2002:a05:600c:c8a:b0:493:c3f9:65a2 with SMTP id
 5b1f17b1804b1-493e688cf81mr123108435e9.5.1783691040285; 
 Fri, 10 Jul 2026 06:44:00 -0700 (PDT)
X-Received: by 2002:a05:600c:c8a:b0:493:c3f9:65a2 with SMTP id
 5b1f17b1804b1-493e688cf81mr123108055e9.5.1783691039782; 
 Fri, 10 Jul 2026 06:43:59 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493eb73ae14sm136837915e9.11.2026.07.10.06.43.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 10 Jul 2026 06:43:59 -0700 (PDT)
Message-ID: <ec03b514-3252-4895-bb93-e577f5347b18@redhat.com>
Date: Fri, 10 Jul 2026 15:43:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/5] ui/input-barrier: fix off-by-one in keycode bounds
 check
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Marcelo Tosatti
 <mtosatti@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
References: <20260706-fix-v1-0-4b83a70e9f3b@redhat.com>
 <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <20260706-fix-v1-5-4b83a70e9f3b@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/6/26 14:53, Marc-André Lureau wrote:
> Use strict "<" to fix the off-by-one.
> 
> Fixes: 6105683da35b ("ui: add an embedded Barrier client")
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/3951
> Reported-by: huntr bubble
> Signed-off-by: Marc-Andre Lureau <marcandre.lureau@redhat.com>
> ---
>   ui/input-barrier.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/ui/input-barrier.c b/ui/input-barrier.c
> index d07027114af..0a238d4010b 100644
> --- a/ui/input-barrier.c
> +++ b/ui/input-barrier.c
> @@ -87,7 +87,7 @@ static kbd_layout_t *kbd_layout;
>   static unsigned int input_barrier_to_linux(uint16_t keyid, uint16_t keycode)
>   {
>       /* keycode is optional, if it is not provided use keyid */
> -    if (keycode && keycode <= qemu_input_map_xorgkbd_to_linux_len) {
> +    if (keycode && keycode < qemu_input_map_xorgkbd_to_linux_len) {
>           return qemu_input_map_xorgkbd_to_linux[keycode];
>       }
>   
> 

Reviewed-by: Laurent Vivier <lvivier@redhat.com>


