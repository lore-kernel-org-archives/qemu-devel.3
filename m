Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A09DEE57CF
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 19:10:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soSii-0004Zx-Qr; Wed, 11 Sep 2024 15:09:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1soSih-0004ZO-BZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:09:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1soSif-0007kx-Mw
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 15:09:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726081772;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=EcZ5F1vT1dIvyn3KmaOYjOzeZeGEdvXPhoDddghXFTg=;
 b=Wx6bxdrpusBj+OjNYqvVnWSky4Z3NMj3WuoGEa2Jte963BpMuAWFPM4fL/ND9bfpxPiEZF
 k/6Yuxz+XoofKv4/4jyPrA7f0YiPk/q5KrKz7CxdRyuQb8+aK40+i2Drq3YChu+2yq+p1Y
 G4qCnLrSxjCPhNZjxBPw6T5PtPZ6qIw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-DcKJmEpvMYO54Ccuzg1mVg-1; Wed, 11 Sep 2024 15:09:31 -0400
X-MC-Unique: DcKJmEpvMYO54Ccuzg1mVg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-42cb99afa97so602525e9.2
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 12:09:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726081770; x=1726686570;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EcZ5F1vT1dIvyn3KmaOYjOzeZeGEdvXPhoDddghXFTg=;
 b=T7VQ7bMMQL1XCEQwZNsmANaB80iKdF7BMQrEwhucLti9BzyxGS2W59PMJmUmwvYeVZ
 TgObgfPVH9Mchlqn8rKsqogMdUKrChWnhsAQEjeyrKQhQ2aVe4frusjkMK2+jHBv7Er+
 H7BmxEPmYHkpmJYX9C4MuB57fpxRoMrK3OqMEvvjrTrmURVhg93R4tnIy5FWx9sbEjYl
 8S/kzRsezoJ6FV8cp5s5n4YVB5cvovjiUzQbOkEW0tDLvVLJi1fNTZDj2DXaZljfuyGt
 ucJqZ7jZfJ3FMeAMGSg3p6U4tenCOCkHvwdjOSXPx1f12lrRmiO1eIQvfceyff/BJM1I
 k9wA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWTEg67irI6q2ogiqSoYAdFym7ku8t0xjWPGmz9DJG3PkvZ4blsgvg4ZuH31rK2pkBGpXEldVyLj7+3@nongnu.org
X-Gm-Message-State: AOJu0Yw/RkEOxoqpurtw41+Y5IokuZVZXUWdpkhoozD7h6G4yN80dWlG
 MKwHngvS34rww3bkouG4dAyErDKRmoCxRd9sraKaKcPnmFgGZfrRE24Gwq5MguNzQxV4961jMmH
 6Xn6BV549shjFKPoMyVmpXGPfmDx1K9d8AdcmeSlXUC3EjX/oso1N
X-Received: by 2002:a05:6000:18a9:b0:374:c6af:165f with SMTP id
 ffacd0b85a97d-378c2cfec9fmr172131f8f.12.1726081769788; 
 Wed, 11 Sep 2024 12:09:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHnHmu0jlif5SVvFpG/mcue1GbiUR23c+2QoaRt1n2VTRTzxlO+i1NL/N+6qKLaMQoRKS9AqA==
X-Received: by 2002:a05:6000:18a9:b0:374:c6af:165f with SMTP id
 ffacd0b85a97d-378c2cfec9fmr172097f8f.12.1726081768738; 
 Wed, 11 Sep 2024 12:09:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c700:7e00:c672:608:5b3e:df8c?
 (p200300cbc7007e00c67206085b3edf8c.dip0.t-ipconnect.de.
 [2003:cb:c700:7e00:c672:608:5b3e:df8c])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42caeb218d7sm151805235e9.9.2024.09.11.12.09.27
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 12:09:28 -0700 (PDT)
Message-ID: <ae1eb296-2737-4871-8769-cee78e459bca@redhat.com>
Date: Wed, 11 Sep 2024 21:09:27 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 00/14] s390x: virtio-mem support
To: Cornelia Huck <cohuck@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>
Cc: Janosch Frank <frankja@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-s390x@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eric Farman <farman@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>
References: <20240910175809.2135596-1-david@redhat.com>
 <4429b29a-a022-4507-a358-1a16b5032395@linux.ibm.com>
 <9dc58bde-7979-4ffb-9ba7-a501d9fcc416@redhat.com>
 <20240911100415-mutt-send-email-mst@kernel.org> <871q1qurol.fsf@redhat.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <871q1qurol.fsf@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 11.09.24 17:38, Cornelia Huck wrote:
> On Wed, Sep 11 2024, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
>>>>
>>>> I'd rather have it in a shared and bigger repo than in your personal
>>>> gitlab one. Maybe there's a space somewhere in QEMU or the Virtio team's
>>>> repos that would be a good fit if the kernel's docu isn't the right place?
>>>
>>> At this point, outside of kernel/QEMU feels like the right thing to do.
>>> Conny is already a co-maintainer of my "personal" (;)) gitlab.
>>>
>>>
>>> And now I realize that I CCed Heiko on the Linux series but not the QEMU
>>> series. My bad.
>>>
>>> [1] https://lore.kernel.org/all/20200727114819.3f816010.cohuck@redhat.com/
>>
>>
>> No prob. Or if you want it in virtio spec, that's also fine.
> 
> The virtio spec makes sense for documenting things needed to implement
> it, but what I liked about the gitlab project is that it tries to go
> into more s390-specific aspects (that feel a bit out of scope for the
> virtio spec), and that it provides a place to document non-virtio
> related interfaces.
> 
> Anyway, if we want to proceed with the gitlab project, would it make
> sense to create an org for it, so that it doesn't look like David's
> personal project?

I had that in mind as well, I can move the project.

> In any case, while I'm happy to stay on, I'm not that
> involved with s390 anymore, and it might make sense to add more people
> to it.

Indeed!

-- 
Cheers,

David / dhildenb


