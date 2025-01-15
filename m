Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021FEC02180
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Jan 2025 04:47:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXvIp-0004fj-V4; Tue, 14 Jan 2025 23:46:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXvIh-0004eG-1N
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 23:46:43 -0500
Received: from mail-pl1-x62c.google.com ([2607:f8b0:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1tXvIe-0002iP-IW
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 23:46:42 -0500
Received: by mail-pl1-x62c.google.com with SMTP id
 d9443c01a7336-21619108a6bso109869845ad.3
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 20:46:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1736916397; x=1737521197;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=/Uhws9SC7hG/hfh7pDLDlFWAdOXR9vNZaQZYTTfHns0=;
 b=uCnPfqLNtY7h9ThS8fr1LOEFnHJGg47DJbA5+YoSOKzIHNwcI3dOim+HDzp1gM6Zno
 BTkvC1osAnVFp9ExSAwCbTv+M8hcMsu33VhjEpilZG+ORd4gUgQ/FeYWUmKSfh+pcq1E
 TLNaMaht7NyGwnZJ7QlLbS4TTQ9bZyfWHYDRIzZxT1+t7WDmyhiEeLGhgDJWIx6bCSoA
 H+L5N9hACDoZiVwxF905CZ6v2vMyNnpGqvKY8e0RPIRnMAY5F6tGvwr6zX4yibvhEou+
 nIh/MlArjK1ymIBf05FH3m7vnp+oWdBSEKZHJ9EIi+dMd4mrNpgmbv39ix9FtL556yBB
 cSkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736916397; x=1737521197;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=/Uhws9SC7hG/hfh7pDLDlFWAdOXR9vNZaQZYTTfHns0=;
 b=oRZFr4IkSNaOo03R7aqvu0FdKqEV+/y69hzSRkMZ5WrwDCLRu1D8oQHTsQkNYevrQ1
 MwuUf/+uH9v1gUILkjDpOPZB45JmM5tU6Kth27tmas+xGTbXcUGVz47WjGIDY2oDbPdx
 Y9nEtjxGtq8cTI83dqGuB/BvcYhbV4mbl6PIXxhW+F4HdxqK37p812MoZ2g9nWZxz9oE
 hvqQpOzLvX3RiPCi61lsMbDEpWlmrsU2XFhKssd2ZBcQr5T0UUYHfHtN/+MZmMg8jahT
 vaQAcr5aW3+tdgxVJQeboMP+0mV30ICvqPDfzViANRMTHxcS3YZ4haOldsYWHp8xhrxl
 dxjg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWram07fTEjvAg8JudYnBJ7l1CtE3TJkSp56hNBejs61u11xWhVguT6R1BCerG1NP4wnBm55CvngHEm@nongnu.org
X-Gm-Message-State: AOJu0Yw69PjH5+egBts835/jvQjhrgAFAZCPgtbz1gtIVRTt9OYQXb18
 tRTi9F4bnIRbOd+5NH93HVY/q9JcIR3M2sUAZXB9VPnCtO7ZL+gBDzUFHhELwvI=
X-Gm-Gg: ASbGncsiEJx8M3Hgjh2Eeh0sZuYiJjLKZwWixzebQ7JSgqQLzBN8Mq/fvuy3Y8ZVu90
 /zn9t1yZDBzyuUDzDoZLxttY3ghodkerJEiUF2K+NOzg0PJLEO3msB0HFQSOnSTtNhJyx/VIuJf
 5cJKZEH8VNMHmABeanWG5kZ45+Mtn0yn5WShCJEdnjKLGaQuwNfnETX5KzoGIq2mY+8UkZXuW/u
 DlJLPlWzW6fDoGcyI3/GmweUgn0pra8uDvuBq23eVlGuulWdSqTYMz0dslG2Z5cY0Y=
X-Google-Smtp-Source: AGHT+IHlxwbWSSZbJOZDD873kqsC2YNfpksqJMnwRoHho7kS7JXLdOgTia/G900WQYgu9v+tyxbs5A==
X-Received: by 2002:a17:903:2311:b0:215:a2e2:53ff with SMTP id
 d9443c01a7336-21a83f36e1dmr455916845ad.11.1736916397245; 
 Tue, 14 Jan 2025 20:46:37 -0800 (PST)
Received: from [157.82.203.37] ([157.82.203.37])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-2f72c17fa66sm460963a91.13.2025.01.14.20.46.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 20:46:36 -0800 (PST)
Message-ID: <00a220df-b256-4b70-9974-f4c1fe018201@daynix.com>
Date: Wed, 15 Jan 2025 13:46:29 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
To: Peter Xu <peterx@redhat.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost
 <eduardo@habkost.net>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Peter Maydell
 <peter.maydell@linaro.org>, qemu-devel@nongnu.org, qemu-block@nongnu.org,
 qemu-ppc@nongnu.org, devel@daynix.com
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu> <Z4AjkXbZeu3T94Y1@x1n>
 <Z4AldAcucTyqZ0HJ@x1n> <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n> <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n> <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
 <Z4aYpo0VEgaQedKp@x1n>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <Z4aYpo0VEgaQedKp@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62c;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pl1-x62c.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 2025/01/15 2:02, Peter Xu wrote:
> On Tue, Jan 14, 2025 at 05:43:09PM +0900, Akihiko Odaki wrote:
>> memory_region_finalize() is not a function to tell the owner is leaving, but
>> the memory region itself is being destroyed.
> 
> It is when the lifecycle of the MR is the same as the owner.  That holds
> true I suppose if without this patch, and that's why I don't prefer this
> patch because it makes that part more complicated.

The lifecycle of the MR is not the same as the owner. The MR gets 
finalized during the finalization of the owner, and the owner is still 
alive at the moment. It is something you should always care when having 
a child object.

> 
>> It should not happen when a container is still referencing it. That is
>> also why it has memory_region_ref(subregion) in
>> memory_region_update_container_subregions() and assert(!mr->container) in
>> memory_region_finalize().
> 
> Again, the line I added was sololy for what you said "automation" elsewhere
> and only should work within MR-links within the same owner.  Otherwise
> anyone referencing the MR would hold the owner ref then this finalize()
> will never happen.
> 
> Now, if I could go back to your original purpose of this work, quotting
> from your cover letter:
> 
>> I saw various sanitizer errors when running check-qtest-ppc64. While
>> I could just turn off sanitizers, I decided to tackle them this time.
>>
>> Unfortunately, GLib versions older than 2.81.0 do not free test data in
>> some cases so some sanitizer errors remain. All sanitizer errors will be
>> gone with this patch series combined with the following change for GLib:
>> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120
> 
> Is check-qtest-ppc64 the only one that will trigger this issue?  Does it
> mean that most of the devices will do proper removal of device-owned
> subregions (hence, not prone to circular reference of owner refcount)
> except some devices in ppc64?
> 

Searching for memory_region_add_subregion() gives 1078 instances where 
there are 142 instances of memory_region_del_subregion(). This is a 
rough estimate but there are potentially 936 instances of subregions 
without explicit deletion.

For example, hw/audio/intel-hda.c adds subregions immediately after 
their containers never deletes the subregions. I think that's fine 
because their lifetimes are obvious with reference counters.

