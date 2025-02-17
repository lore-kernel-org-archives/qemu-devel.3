Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62DEFC0219E
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 10:23:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjyGx-0006SA-9a; Mon, 17 Feb 2025 05:22:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tjyGu-0006Ro-Ra
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:22:40 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <lvivier@redhat.com>)
 id 1tjyGr-00078a-QW
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 05:22:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739787756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=iY5siou3c6vHYcTVhKPwCXdvlFqjn9QSNpgBEScIovY=;
 b=c8/+xiDRneYsdB1bU2ahPfUAhMia1xSRkH4WNyajqYIhOFLduqgHeGIvE0XRnBzkgGmikG
 2HcHVUGKcdlOJsTU7Haxa8rZK5nHhb+e1NLMbYWxejDFey0Xmh+kq3ST5sNXi/eJ5ZiHWV
 LDK4CTcFB/ONydoZuvafJHFd8HI4Z08=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-9vBzPrXWNNiz2Bi_MeAyJA-1; Mon, 17 Feb 2025 05:22:33 -0500
X-MC-Unique: 9vBzPrXWNNiz2Bi_MeAyJA-1
X-Mimecast-MFC-AGG-ID: 9vBzPrXWNNiz2Bi_MeAyJA_1739787752
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4395f1c4354so30687235e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Feb 2025 02:22:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739787752; x=1740392552;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=iY5siou3c6vHYcTVhKPwCXdvlFqjn9QSNpgBEScIovY=;
 b=cUyu3Ols8/9uOhDrkUPAlMU25ixFsPJ4GUptafczLEHwZxeTXRYdcom8Ash97uk6kR
 PYwtQfx2eWLWa1H9P8ww0aNgOA9eggcG3099hh6PJU8m3GLVaJNUjydfa1yPWWghhm91
 ptZM7lgSfUsDuS4UpbuhKIyOBeAN2IGcnQKc8B7qipzfrw3YZhYNOZYnHUUXGANBWQmi
 sRUhpOg788G5poDflTVJM7jV4+2a6f39qPPmrIiwHIAfBgeaCH1+IGhWauxmyeChiGk1
 XJb3xBhQ72UlP0yp1QXy6Il1zjYP4W+TqZ597w0oUSDTT5799sVaW2xi80Ft4Vrq8Z3m
 YdZw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeBeDbK2d9HUfoqpBwKrkLtKde5GfDu1G3k/pvc3U6KPv3PGZQrsAW1JnrSDPGGCSZPAI4RpS4DYIz@nongnu.org
X-Gm-Message-State: AOJu0Yz3s5HtJ2OFmEjYQM2uQLED6iMcMpaNlHqziKAfGdkgHfdbbrU1
 UtvUDlTaReb3e9BvcyvV8HFqz1Lf4v7VcbY/G8fjzEv/vVA78qyCFG3RzMYbWVRPEEkHy6X6zLD
 NDLBtxWU+xdjryV44OgRWmTamj1aPu3siRg5cV44mDlqZKARAJTkN
X-Gm-Gg: ASbGncscqxunjTDDRuC4iOeoINKkhqg40GxIH9G+ea1Ynqj55M16en2xaZapKnnicIX
 3cwQeYTbNADzMec7GNQ+VCsj/M+7M3jcslcMJ2lATKdEcA61Ib8ndH4Jl2nKgRCa/0XCupIS0AM
 pXN1KFN2NChIE4LTl9b6dx6W1hCRrPreWa3opvm8RCXZQBISOJHBBm6wT/I3RSEpHnotFYF7bKq
 0R+A5ynrVjPOMBBt2ggRYbqLvYUe3wiDBK5acdRw9lvI3Y6b2iUL0ksIu+1cNOJJTxUcWm13o4N
 xp3eg9oXAaxRltiuywmGAP0SWRiI8wHYsN0TXV+Lg3M=
X-Received: by 2002:a05:600c:4511:b0:439:88bb:d012 with SMTP id
 5b1f17b1804b1-43988bbd4c9mr12877905e9.8.1739787751708; 
 Mon, 17 Feb 2025 02:22:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHsyRtn8SS8l6uD5xjhmskAZ7qLSdRfvtJbW9pd7YtVpKT2OxpLFfYRBYtQ+Rf5MVKkQ71jTg==
X-Received: by 2002:a05:600c:4511:b0:439:88bb:d012 with SMTP id
 5b1f17b1804b1-43988bbd4c9mr12877605e9.8.1739787751298; 
 Mon, 17 Feb 2025 02:22:31 -0800 (PST)
Received: from ?IPV6:2a01:e0a:e10:ef90:343a:68f:2e91:95c?
 ([2a01:e0a:e10:ef90:343a:68f:2e91:95c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43987d1865asm16360705e9.3.2025.02.17.02.22.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 17 Feb 2025 02:22:30 -0800 (PST)
Message-ID: <86021d71-6d5d-4063-9c9e-cbe78e331e05@redhat.com>
Date: Mon, 17 Feb 2025 11:22:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Laine Stump <laine@redhat.com>,
 Stefano Brivio <sbrivio@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
 <Z69MOEAuE9WHjLjT@redhat.com> <Z69Q4bhElTS9bOO_@redhat.com>
Content-Language: en-US
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; keydata=
 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
In-Reply-To: <Z69Q4bhElTS9bOO_@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=lvivier@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
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

On 14/02/2025 15:19, Daniel P. Berrangé wrote:
> On Fri, Feb 14, 2025 at 01:59:20PM +0000, Daniel P. Berrangé wrote:
>> On Fri, Feb 14, 2025 at 11:18:55AM +0100, Laurent Vivier wrote:
>>> On 14/02/2025 11:06, Markus Armbruster wrote:
>>>> Laurent Vivier <lvivier@redhat.com> writes:
>>>>
>>>>> The netdev reports NETDEV_VHOST_USER_CONNECTED event when
>>>>> the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
>>>>> when it is disconnected.
>>>>>
>>>>> The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
>>>>> (label, filename and frontend_open).
>>>>>
>>>>> This allows a system manager like libvirt to detect when the server
>>>>> fails.
>>>>>
>>>>> For instance with passt:
>>>>>
>>>>> { 'execute': 'qmp_capabilities' }
>>>>> { "return": { } }
>>>>>
>>>>> [killing passt here]
>>>>>
>>>>> { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
>>>>>     "event": "NETDEV_VHOST_USER_DISCONNECTED",
>>>>>     "data": { "netdev-id": "netdev0" } }
>>>>>
>>>>> [automatic reconnection with reconnect-ms]
>>>>>
>>>>> { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
>>>>>     "event": "NETDEV_VHOST_USER_CONNECTED",
>>>>>     "data": { "netdev-id": "netdev0",
>>>>>               "info": { "frontend-open": true,
>>>>>                         "filename": "unix:",
>>>>>                         "label": "chr0" } } }
>>>>>
>>>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>>>>
>>>> Standard question for events: if a management application misses an
>>>> event, say because it restarts and reconnects, is there a way to obtain
>>>> the missed information with a query command?
>>>>
>>>
>>> query-chardev could help but it doesn't provide the netdev id.
>>
>> It doesn't have to IMHO. The application that created the NIC should know
>> what ID it assigned to both the netdev and chardev, and thus should be
>> able to use query-chardev to identify the chardev it previously
>> associated with the netdev.
> 
> That said I kind of wonder whether we should be adding events against
> the chardev directly, instead of against the netdev use of chardev.

I don't know that is the best from a libvirt point of view.

> 
> ie CHARDEV_OPENED / CHARDEV_CLOSED events. For OPENED it is trivially
> equivalent. For CLOSED it is a little trickier, since this patch does
> delayed event dispatch from a bottom-half. If the chardev code was
> able to emit this event from a bottom half itself, that could be OK
> though.

Do we really need to delay the event?
libvirt could check the chardev user is really down before restarting it?

Without bh it's very simple:

@@ -68,9 +69,11 @@ void qemu_chr_be_event(Chardev *s, QEMUChrEvent event)
      switch (event) {
          case CHR_EVENT_OPENED:
              s->be_open = 1;
+            qapi_event_send_chardev_connected(s->label);
              break;
          case CHR_EVENT_CLOSED:
              s->be_open = 0;
+            qapi_event_send_chardev_disconnected(s->label);
              break;
      case CHR_EVENT_BREAK:
      case CHR_EVENT_MUX_IN:

Thanks,
Laurent

> With regards,
> Daniel


