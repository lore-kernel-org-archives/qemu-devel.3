Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D9ACCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 06:39:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAjXB-00026D-TD; Mon, 20 Oct 2025 02:38:21 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vAjX9-000256-5a
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:38:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vAjX6-0000ft-1a
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 02:38:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760942292;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=huIkyUJ8NiBG4cJNgS3rkEOotBbfW2CESH1EMTp6uK4=;
 b=aTs8Og9ybTbyb+Wy2kxu1V82WXc33DqUUPzkLgkWEWCrxIVoFxLtpW4eJOH4bJjLGfzRZq
 MK2RkuKnK5OMDOExqe2+l7/4LqfA/p+wnZjLFWwzIheu474o1qrQuYANsAb9JV3NQvJm0t
 sQFg6QkGw5P/HvYQ2xSvcgfhIHqb+rE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-473-59bCKQY-PJy2Fv-Qn_ulBA-1; Mon, 20 Oct 2025 02:38:10 -0400
X-MC-Unique: 59bCKQY-PJy2Fv-Qn_ulBA-1
X-Mimecast-MFC-AGG-ID: 59bCKQY-PJy2Fv-Qn_ulBA_1760942289
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-427060bc12dso4450222f8f.0
 for <qemu-devel@nongnu.org>; Sun, 19 Oct 2025 23:38:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1760942289; x=1761547089;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=huIkyUJ8NiBG4cJNgS3rkEOotBbfW2CESH1EMTp6uK4=;
 b=pDHiOiyTO8hrCl+u9+PilDcvTdXMN8UlIAct7f+I1DqxxHIc7dQMtvU5abhiNNfY1f
 77vlF3TmCon3GquYjbUg5xaKAiH/r/NotHb8ktgvBIZ0YBVp7gxG4Q5Q3ppRKMXbz1XQ
 yz0+Xx0WeEdxRr8yyc3kBoqO+yLZdqCufnSxgD52EAE2yFpK6MS07swKO72rXWco+3uO
 +se75C64g6+7Inq6F3YjU4wEHR1xhyJdLFfp8CMkbk+dIP8pRKtm3YEi38Xmvb3drKBI
 mjXR0qlYuQGbHafvjlag9hSfiw+zDdsGz0MT8HuD8XM9oW572/6cLPEW9pSaIDebLONK
 Otvg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXcW2Pz/ZxCgWyxweoFOpazhbLldCRMSmZY680O48VChxw6rxVkqyx6L02/GVnRGELutAnUxQ/TvVgU@nongnu.org
X-Gm-Message-State: AOJu0YwUvku9iVAWNwl8BIVAHYhXqBxt36KrFBWb611mz/qwkq/3g4te
 NH8s1n3CWf8eyeNm6byuIxWiyoodVFba9Ro9SV/X+oG0JUbY9n6/HG8OxEfuBk3ZM4aejk4wLjf
 T1eHOyQFbSEM+wKY8VPrnvpGJyqpRnbDIK31QzepWTEpLOZumJnWkZZvO
X-Gm-Gg: ASbGncsTEo7N0qyOXwNIvD9OzDxKoGVpq8dx1U8c3Glz0o4CzBO0MQo3F9uMd2bTrbT
 Dn0AeYhS3MI5F0iN3uapBWO/7l7y0jq5JJLa6GP8UjBISukQF8MSWhRPtiaGNXfe1SEuXPZK82P
 h3BIJwdfb2hdC4DElRdGCIdoHR8czTJmJ3KmgFxK9VQwFqan1k3N0+Sn6LWXyk2uVF9H+2Yyncf
 T0HYQkuV/W7rtlv1PpnH1YXxIGvVSvEUjVqwPughJhii7xnk2INV7MpgKvD3ZM94hGgJbw0gVm7
 A7GDq9bNIcAVfK93UR4P+BYFZ/5lDJmbPGvhuq4GprDjEBZMhPJfMl6/gZTlWZ7rv/Q4g7m5zj7
 MytNzS6c+Q/uW8kpthbmItPE4OiTRemV9SMEgZHoy+CXJrsVeJCedLGgGYWhFQrGbwfA3DMRmec
 4UdQ==
X-Received: by 2002:a05:6000:4382:b0:427:a6a:fd44 with SMTP id
 ffacd0b85a97d-4270a6b0aa2mr6302355f8f.61.1760942288959; 
 Sun, 19 Oct 2025 23:38:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFJ9cCSPGkpt8AJdcVYDa9SY+hPcP6DNtsvzfoSRtkV1z5A9nMs009gIEzFIym4LqHyDoSjtg==
X-Received: by 2002:a05:6000:4382:b0:427:a6a:fd44 with SMTP id
 ffacd0b85a97d-4270a6b0aa2mr6302329f8f.61.1760942288582; 
 Sun, 19 Oct 2025 23:38:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.61.22.175])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-427ea5b3b45sm13784939f8f.11.2025.10.19.23.38.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 19 Oct 2025 23:38:07 -0700 (PDT)
Message-ID: <aa0b2645-cc24-40f7-b4c3-82c86eefc9b2@redhat.com>
Date: Mon, 20 Oct 2025 08:38:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] rcu: Unify force quiescent state
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: David Hildenbrand <david@redhat.com>, Eric Blake <eblake@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20251016-force-v1-1-919a82112498@rsg.ci.i.u-tokyo.ac.jp>
 <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <cc38a1ac-6f05-4c27-90a5-6ed71d9b566c@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 10/16/25 21:33, Dmitry Osipenko wrote:
> On 10/16/25 09:34, Akihiko Odaki wrote:
>> -        /* Wait for one thread to report a quiescent state and try again.
>> +        /*
>> +         * Sleep for a while and try again.
>>            * Release rcu_registry_lock, so rcu_(un)register_thread() doesn't
>>            * wait too much time.
>>            *
>> @@ -133,7 +150,20 @@ static void wait_for_readers(void)
>>            * rcu_registry_lock is released.
>>            */
>>           qemu_mutex_unlock(&rcu_registry_lock);
>> -        qemu_event_wait(&rcu_gp_event);
>> +
>> +        if (forced) {
>> +            qemu_event_wait(&rcu_gp_event);
>> +
>> +            /*
>> +             * We want to be notified of changes made to rcu_gp_ongoing
>> +             * while we walk the list.
>> +             */
>> +            qemu_event_reset(&rcu_gp_event);
>> +        } else {
>> +            g_usleep(10000);
>> +            sleeps++;
> 
> Thanks a lot for this RCU improvement. It indeed removes the hard stalls
> with unmapping of virtio-gpu blobs.
> 
> Am I understanding correctly that potentially we will be hitting this
> g_usleep(10000) and stall virtio-gpu for the first ~10ms?

Would it help to have some kind of exponential backoff, starting with 
1-3 ms and increasing after the first wait?  Something like 
1.5/3/6/12/12/12 ms would have a similar effect but reduce the wait if 
the vCPU kick is fast enough.

Paolo

I.e. the
> MemoryRegion patches from Alex [1] are still needed to avoid stalls
> entirely.
> 
> [1]
> https://lore.kernel.org/qemu-devel/20251014111234.3190346-6-alex.bennee@linaro.org/
> 


