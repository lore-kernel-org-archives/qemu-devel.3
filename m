Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19A47CA100C
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Sep 2025 07:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utiJK-0004kv-TE; Wed, 03 Sep 2025 03:53:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1utiJG-0004jv-Rq
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:53:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1utiJE-0004qL-VP
 for qemu-devel@nongnu.org; Wed, 03 Sep 2025 03:53:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756886014;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=vIwKenhC8Vrbg0ooQhgtFA1AhsEbn3GoVDnCzgJTlO0=;
 b=Ul8+SKddmunKz1DcyQPm0b8FS9TBiQJVFuWsnwjXPFJj7pbnsfJlJ+DT3Vlv9G52CE0Ult
 skRWgCnSMWY7uPcSjCklqqlqiG5ph/1WGaTgKb1iGQdNPYt/Y5jS3Qvczc90fVC+Zxh/hD
 WDIZUgHvPUJ6pDNEzgwvC21uDBHmiEk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-5cs1vyh5Pf-aR1AvNT-m8g-1; Wed, 03 Sep 2025 03:53:33 -0400
X-MC-Unique: 5cs1vyh5Pf-aR1AvNT-m8g-1
X-Mimecast-MFC-AGG-ID: 5cs1vyh5Pf-aR1AvNT-m8g_1756886012
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b96c2f4ccso9959185e9.0
 for <qemu-devel@nongnu.org>; Wed, 03 Sep 2025 00:53:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756886012; x=1757490812;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=vIwKenhC8Vrbg0ooQhgtFA1AhsEbn3GoVDnCzgJTlO0=;
 b=eYVlL0cqkB4wE05n+PMk8u7tVgxsljy/d/QPNtny3jsCceRHRcpOZgCEfXTQZiVX2l
 sKBTHkn3+wDCycG+JpuJWTKpHFltYVUH2NrYEgR6XEPwcNqoFhel5GP0HE2wXWmNIC2j
 oxM7jDTKFE+ciyKZVFMTzrhQIaH4OGjeOJTu+lWJkB73VwZ33RY7Iz7AfYTwivPcicDl
 GaCed2KGi96poXUcoSmEGHzmSpH/hk1bnCvRl9RFVWAAVq5eDTY4hnixdGf3FZz1FM09
 XboiaiDzmwrmrAWVC2r2pJU7i6EqqgIBeGka2XESSi84PZ/evbVu7A+kVIsE6RwbCbdn
 AWhg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWPXn69AXNx13U/RzXxJO2jcAxCM9z5bAdKR5SRDz8vVAyKPKsiml1VRqVRGl63KH5l8SU2DydAZIHb@nongnu.org
X-Gm-Message-State: AOJu0YwzZ+uE8OZiU8trIZB3xGDJ7ZctH3ftdBm4Gg10EcJ3F0JIZGm8
 ewKO9VMLDSSDbEdG0fh4ygLc8ZvVV9ZmJ4DePXyF+Sti+04otbrnpDSySnnkONl+DvODiMJnmsc
 UuT3B7+BAUkArzi/m6Q+DbMhNvDhFQE8IK8099i7x4OFtA1+VshPjS+cE
X-Gm-Gg: ASbGncu5prNgfq45ufGzBaxdfYSwhjhleqVLtlKT4PxECGWabQi9XWMpMLMGsbrIm2x
 aRDuhbpIex/XmiEy9KCDl47O9SOem4ZzUawVhZgb7mfybzSspt1dFy5zlbs6iwJiTQOtG/Ywu8B
 OKXNwyt0rkMBneHFQmY3kjxZBQtxw+C0n7PMpZE4FF7JxdE7OgSEkJKlv2ESZzn+rmyioztlqeR
 Vlu9iG2hb3nfhDP9vJI/IUauXV3B5gks5PRNh2vy+0Mc64Sf0EuxMsxCoSn3yyiA+k17vwtTvfk
 3uXoGiLbpBL7B5Pd7e6viyflJPioyjXTdx0hRq6rsBcq9jFr6Nbe9uf0xmylhnhyqO+ww0zQW4e
 npqembsd5pCyuEoye+ahwUqFyAQMFUjNmAhLA1vQ1CLf3fSduwPMwqdXe4K0RtivrRwk=
X-Received: by 2002:a5d:5d10:0:b0:3d4:1acb:aed1 with SMTP id
 ffacd0b85a97d-3d41acbb238mr8271164f8f.44.1756886011207; 
 Wed, 03 Sep 2025 00:53:31 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFMJpNJ2EwbfO0BZC3DUlNBh7w82uZe2eV9sATGgedBJXjczxASzV1uFj7zdWEmjIDkhYZpOw==
X-Received: by 2002:a5d:5d10:0:b0:3d4:1acb:aed1 with SMTP id
 ffacd0b85a97d-3d41acbb238mr8271112f8f.44.1756886010003; 
 Wed, 03 Sep 2025 00:53:30 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f09:9c00:8173:2a94:640d:dd31?
 (p200300d82f099c0081732a94640ddd31.dip0.t-ipconnect.de.
 [2003:d8:2f09:9c00:8173:2a94:640d:dd31])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3cf33fba9fbsm22608350f8f.50.2025.09.03.00.53.29
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Sep 2025 00:53:29 -0700 (PDT)
Message-ID: <8e9c0cd0-048a-465e-8b97-9fecd559cb6a@redhat.com>
Date: Wed, 3 Sep 2025 09:53:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] memory: Fix addr for flatview_access_allowed()
To: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Peter Maydell <peter.maydell@linaro.org>
References: <20250902214005.730358-1-peterx@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250902214005.730358-1-peterx@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 02.09.25 23:40, Peter Xu wrote:
> flatview_access_allowed() should pass in the address offset of the memory
> region, rather than the global address space.
> 
> Shouldn't be a major issue yet, since the addr is only used in an error
> log.
> 
> Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
> Fixes: 3ab6fdc91b ("softmmu/physmem: Introduce MemTxAttrs::memory field and MEMTX_ACCESS_ERROR")
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers

David / dhildenb


