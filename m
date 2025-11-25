Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F6D8CFD364
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Nov 2025 07:44:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vNniL-0004Oe-AO; Tue, 25 Nov 2025 02:43:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNniJ-0004Mj-A2
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:43:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vNniH-000613-9I
 for qemu-devel@nongnu.org; Tue, 25 Nov 2025 02:43:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764056628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=NRRwu5NlezRgXXB7x9TmUjDknlgwZrR8rFTEutpYI+0=;
 b=dd8DntiR4p7U2JNDGtYbE+KZGYh/KRHpt4URFuDfj7wN9fWC0u9t4lIVMX/rADixgtNFgU
 HS+v3Xu0lIhpLOlUgcGRYglCmtgSNu36WIIqpexH8r4cVxtK8UpyVDFAlCOPaO7w8U7KQ+
 Cb3QpbrepUK6EuYDf3GRkTtpHN7KyhQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-551-rnnbCgknP3CUAbxlJ9rKrQ-1; Tue, 25 Nov 2025 02:43:45 -0500
X-MC-Unique: rnnbCgknP3CUAbxlJ9rKrQ-1
X-Mimecast-MFC-AGG-ID: rnnbCgknP3CUAbxlJ9rKrQ_1764056625
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so35189105e9.2
 for <qemu-devel@nongnu.org>; Mon, 24 Nov 2025 23:43:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764056624; x=1764661424; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=NRRwu5NlezRgXXB7x9TmUjDknlgwZrR8rFTEutpYI+0=;
 b=n0V2Gd7dfm+y4uzD/UzhesAnBLY8aNPiZ8arwdPW1jxCS7oxVooO1303et8tJ76qN9
 mBtekZpVDrUNyCqGB+UXzO5n/H37hFGORD+6nROK/qeEZJHsMBEN7n1NmeXY1KuFZXTS
 ImNQ4SOpr+LyHHtteSJNDLzqgj9inGvforbFpOV/HlDigfASJ/7Dm7VxC2yDQnXAsi/z
 ORb0UXAc6asm5SZIlEeKOCjJQePPWv/SJR1u4c8Ztok0PKNC4HC5F9vubwx+SYg1TQRV
 cEZU9n4p61aA9UAgyQAPSvMYxFzME+/mcDzRMb93U5ntSf3VWaYVWcjbNod7qk1T3Li5
 Bjrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764056624; x=1764661424;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NRRwu5NlezRgXXB7x9TmUjDknlgwZrR8rFTEutpYI+0=;
 b=RXv8zMvlfK4xCB5m5Lenlk+tEGHXsPLVDNg0b9hdzW7aihtGhdO5aNlOir5JktTB/G
 1/i8M6JcJP0rjKStT5pIRjZS7vfQmdmQ6HIrwe38mGpHHSXqAIm/YUcROHmFRrLuKTmX
 neGRjgK1+BEeTnd7iJnAexSSXqEx66gcI196wCWHWybgTD69NV7pY9P3S7BKVzuSjtre
 blvZzfGHejGn+B1dEVIKwwELCAuW5FlZ6DDVrhSWtLd3fkmGl9l29sWRNFxcA7p7dKWA
 7xmuNbjhCm8aHI7s7luYnllPF9F59MMYcnnvCKN/BFaIQGDuKEQdCxr8Qm/wmNU80SEX
 yoOg==
X-Gm-Message-State: AOJu0YyrZxs9C4q9BTMoQZemxcqvZLsF5ykdMlXlMlIQb8KYvgW2iG3H
 qyqwTG4gE/vwQ8ZBHlW1RPpbQ9oXcp37ydjukmF1yXKx6vd6ff0YTwS/YMCyCd2iTuLzi/Fkb0/
 MEeUfI7fh25FjHDKqpgIl2NEWuW7z/YpVsPvBxDveL2dtB1uJbt732JKbVpaKZhi/
X-Gm-Gg: ASbGncvBrezUKWtbyxjVwcshno8vdOvijDDmTpOSjaEluX3mQP2PgzoJ3I/TPAMXHqB
 tUXB2rYVo2vTr/r/Ar7bo1uZ3KmytLoZXw2VntHhjatMyuYyC1KRwV3ywh3+Z5QTDKVFJLiob6z
 848kLXYYfAbLgyffs2mg8iWglYEXGvADoq2bcD812JzBnUnmFX38qnqIacmlDzd7ZoXFZNmyqWV
 ml6aSbeNkdr1yqQzqSrY+dsJmUNpd4kCuIUs0IBRwFXHx/Gbg+8BUexERjL5I9WLeznrTytDiIC
 sKAHuOv57j8ZMfP2WJCrJuoIPMXy18k9WPPxlxgVxv7IsZPvMARq4bieyRNxH6zJiTuOgUj987z
 rQdZaa5LFLjpVQnNQD7dLbq8PWSzAeWtCVTvZZZSNbGaqU9O9
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-477c11175a9mr165189635e9.16.1764056624276; 
 Mon, 24 Nov 2025 23:43:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGzwfjXxdjV3j748wrZ7U0/xoEP48Tb+MMysSQyUvK+3EPgEcLxBW/mqjdK1dDH96blDREnAw==
X-Received: by 2002:a05:600c:4f82:b0:477:952d:fc11 with SMTP id
 5b1f17b1804b1-477c11175a9mr165189365e9.16.1764056623875; 
 Mon, 24 Nov 2025 23:43:43 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477c0d85360sm231247175e9.15.2025.11.24.23.43.43
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 Nov 2025 23:43:43 -0800 (PST)
Message-ID: <49af3063-53a0-4e72-80a3-a9b4d1c30d9a@redhat.com>
Date: Tue, 25 Nov 2025 08:43:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 4/5] vfio-user: simplify vfio_user_recv_one()
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Thanos Makatos <thanos.makatos@nutanix.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Mark Cave-Ayland <mark.caveayland@nutanix.com>
References: <20251117155656.2060336-1-john.levon@nutanix.com>
 <20251117155656.2060336-5-john.levon@nutanix.com>
 <819f4595-b323-4dcb-96c5-09c52cb09380@redhat.com> <aRyK3KUe0E-bng5f@lent>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aRyK3KUe0E-bng5f@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.075,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 11/18/25 16:03, John Levon wrote:
> On Tue, Nov 18, 2025 at 03:57:56PM +0100, Cédric Le Goater wrote:
> 
>> On 11/17/25 16:56, John Levon wrote:
>>> This function was unnecessarily difficult to understand due to the
>>> separate handling of request and reply messages. Use common code for
>>> both where we can.
>>
>> It's still difficult to read :) Could we have feedback from Thanos or Mark ?
> 
> It is surely better though?
> 
It seems so but I lack the expertise (and time) to dig in. I am waiting
for further feedback before adding them to vfio-next. We still roughly
have 10days for QEMU 10.2. That would be nice.


Thanks,

C.



