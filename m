Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D2C7C5B543
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Jun 2025 10:44:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uOwS4-0004ZR-HM; Tue, 10 Jun 2025 06:43:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uOwS3-0004Z3-5y
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:43:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uOwRz-0000cF-Qr
 for qemu-devel@nongnu.org; Tue, 10 Jun 2025 06:43:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1749552204;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=uHFLhgGIYP2g0wU8P4sjggV0oEKCBvBN6Ac+3j+lNps=;
 b=hxI6WQMUje8Oghx0isc0g0acGWk9k9Fi5s0KFHfp5PAW3yHDqcpClWHpe/T8Hy7aitwVRC
 HozRRZyxWtlsmPAVu65GDXndhecdDYTn8pJ2/JglLKPrydkhFKn/Y2InlPmuTKYhmRs2+j
 BGm6PxKWiaLidu6voNWjhBH/AsVttM0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-388-kS4kVHN6OI-UJRL-mEvQvw-1; Tue, 10 Jun 2025 06:43:23 -0400
X-MC-Unique: kS4kVHN6OI-UJRL-mEvQvw-1
X-Mimecast-MFC-AGG-ID: kS4kVHN6OI-UJRL-mEvQvw_1749552202
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-451d30992bcso41677585e9.2
 for <qemu-devel@nongnu.org>; Tue, 10 Jun 2025 03:43:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1749552202; x=1750157002;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=uHFLhgGIYP2g0wU8P4sjggV0oEKCBvBN6Ac+3j+lNps=;
 b=W1vOrBl7FliYCRF9lDrIDxX/jJVOjz4XPsRWgfcqQaNr462etKYf/6cDD1QANt4m3e
 YnEUwRh01z1wNfhtG+fA9TewsOZlpFFCH5tnnq6gacwxQ7OJCJ37iLx8lSAL/iZLppKr
 amLcHUeteOAm/nE76A4klvKTOGjMAJoFlE4BQhs29MsPGqYk/BeHRp18Zdy0iD12aFA9
 xnTHEgPk686QdtonTZDuII5+SVTfglKUhBF+9vCXxeSHEE9oepPZlHPT7JxkPo6YfGdx
 n2ZlGwO9CfBpu0lrp/kqXK2NJqp1PNbs6aiOy5PJ0NbftgC21hYaC9YmPCk5arnuNF70
 OykQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX61YCgqcYhPX4YnEIcOmmsLZKthdiaEJOOpRDQUShEy0HSErUt7hxgNY+DNO8UhVSRHy170EFBIfwN@nongnu.org
X-Gm-Message-State: AOJu0YyNQLXucpSZbrw8jOtre1e+GFbLd0Vbw/Bp6EvLJlTn3zXQOqJj
 pZw3yeAuxHRvUjhSYokr3+5nVStefpX3SQfaWLjIEk3lwWJKggqc37cyEvfeEyC9O+rT0JZjBCK
 4meyCMYMPJFR1IjHuxyQ5At/DTFTFAm1pGy5PaIgC4EoEER+8A7VBKw1f
X-Gm-Gg: ASbGnctstxdfgBS/pBhVY4vKgUEwf0WdRWi5pKpOH/68DgIoRI4SfhzNsNY4wK9HSka
 h/4+dvPKdO8LOeVYWzEOnzJiDvtGs4hCmAgbKNpLWrzR6z6OiIj8bdCYmqLtDsxvSNBQZUvuoRL
 tRwiQSJ0G/725gGUjoA2FsLZCJNumijvq+lj+Jm5sw0n7l0zD3dehwaLfbr+VuOqBE/2KgvGF9C
 /XzIYWY1TWEBtkF+H4RRU3e+YAkfDmn6UZH8owP0zeykiJyzVX/BmaHMnCiiZF8X9jN6YbuAFd3
 awxnpLXyVekwf2n1jQ3sMMi91PUNo/Ta6wn37j7d4VzgDSeuMsBcKkw=
X-Received: by 2002:a05:600c:5396:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-45201364c47mr172511585e9.2.1749552202321; 
 Tue, 10 Jun 2025 03:43:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEvV5JY3bGfsYp5VuherL+EoZ6KlJh9SmhQUQHRcOXIbXYIQokDS3YByBl5Ng/BVRG6/3+2Tg==
X-Received: by 2002:a05:600c:5396:b0:43c:f44c:72a6 with SMTP id
 5b1f17b1804b1-45201364c47mr172511255e9.2.1749552201940; 
 Tue, 10 Jun 2025 03:43:21 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a53229e009sm12297166f8f.16.2025.06.10.03.43.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Jun 2025 03:43:21 -0700 (PDT)
Message-ID: <d4f46b6e-b002-47f9-9f13-09b44d4431df@redhat.com>
Date: Tue, 10 Jun 2025 12:43:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 1/7] vhost-user: Add VirtIO Shared Memory map request
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: stefanha@redhat.com, slp@redhat.com, "Michael S. Tsirkin"
 <mst@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>,
 jasowang@redhat.com, stevensd@chromium.org, hi@alyssa.is,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
References: <20250609144729.884027-1-aesteve@redhat.com>
 <20250609144729.884027-2-aesteve@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250609144729.884027-2-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 09.06.25 16:47, Albert Esteve wrote:
> Add SHMEM_MAP/UNMAP requests to vhost-user to
> handle VIRTIO Shared Memory mappings.
> 
> This request allows backends to dynamically map
> fds into a VIRTIO Shared Memory Region indentified
> by its `shmid`. The map is performed by calling
> `memory_region_init_ram_from_fd` and adding the
> new region as a subregion of the shmem container
> MR. Then, the fd memory is advertised to the
> driver as a base addres + offset, so it can be

s/addres/address/

> read/written (depending on the mmap flags
> requested) while it is valid.
> 
> The backend can unmap the memory range
> in a given VIRTIO Shared Memory Region (again,
> identified by its `shmid`), to free it.
> Upon receiving this message, the front-end
> must delete the MR as a subregion of
> the shmem container region and free its
> resources.
> 
> Note that commit all these operations need
> to be delayed to after we respond the request
> to the backend to avoid deadlocks.
> 
> The device model needs to create VirtSharedMemory
> instances for the VirtIO Shared Memory Regions
> and add them to the `VirtIODevice` instance.

Just a general comment: you can use more characters per line in the 
patch desription.


-- 
Cheers,

David / dhildenb


