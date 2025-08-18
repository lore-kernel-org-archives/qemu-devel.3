Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46105CA0ED1
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 07:38:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unuR8-0002mA-2P; Mon, 18 Aug 2025 03:37:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1unuR5-0002ly-Td
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 03:37:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1unuR3-0000NR-Ih
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 03:37:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755502657;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=pVAAoxdn7fW57C7atoU3x3oKKD+yIYNHT6qGQvnWNj4=;
 b=DZG1b6djbDQN2SJFwmt3VBmjY46YtZB7EhGEijPgt5fa6gxO7l/LUaZvFFFUjw+QDsxqRv
 HJaSzWO8+bYK8RD8e3krk9Slw/hjs9uuw3IEt1DdTPzMbyfinvG2XeutLHK+ENqEonVNh5
 kBNl+zoOB7s/BZ/ESCxoQy4K5XTsG+c=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-51YVZ_2zMPK9rU5EOah4bg-1; Mon, 18 Aug 2025 03:37:35 -0400
X-MC-Unique: 51YVZ_2zMPK9rU5EOah4bg-1
X-Mimecast-MFC-AGG-ID: 51YVZ_2zMPK9rU5EOah4bg_1755502654
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b9dc5c2ba0so1762472f8f.1
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 00:37:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755502654; x=1756107454;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=pVAAoxdn7fW57C7atoU3x3oKKD+yIYNHT6qGQvnWNj4=;
 b=Qlk6xAG6LLM4s7U3nciEqMGdMJw8NPq+bagHfL20T+sUgKlHSFaVoyMOMTwp/QOwIG
 I0yQld7M5SbaIUkxhhP7jRKQReBi+WTyJiTVMwfECFe+rozHkDors4unoVTh5+ITtEsD
 c/UNCHm3LyfvanDIbn29a4bcybF3jvLxTfYU/FLSYsMI73TUUap1J2RYZmlA6Y49v9rM
 ibkqV0SCenZbVoKqzj7XPeImEVsg2ha8mrFw/4Fbw60KHF4PMXJceya23jQYfg+DPVQN
 C9mZSa48EvU5W/x6CimzaEgZy0ki8OQ5CMRHaEobYoHW+06q3Wcpv2AobDhMAqbudWt3
 nx/g==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzX/oi1yjsJKdaCQQX20bxDlWxyOQyKmV0+F/Vr+2w66gzzhDP+eD7L/2X/UChK5JPiK6SZjQRtPp3@nongnu.org
X-Gm-Message-State: AOJu0YyTMNQwP+UJJYaTKlg8uDC96+2zmHhOn/qePvYBM45zuSI+O0I9
 UY6PwZ8Z7iQ6uOse7KY+0+YbTjsn3xSzjDayHQl/8fucIGyYMuwBusbFJ4Hf1KRPr3EhYVQW0Wy
 Rr/YKeXejnfrgNpkC34xu6vLgjXMSIigDy6RmmpjRJJ0qIQSt3rBqsTtW
X-Gm-Gg: ASbGncvP4mtv/gt/hLcJzZU+/JyAyUXlRbpYtaBG1TmYXHI5UeNlBWYgMWCecVkP9+/
 +o0P+XFvhl1VUU9Ba6MoDZ3wxum0mMykNEO/qbCIbLn6pVDI68O5oXPZiyD7QepXNPCaMAURoV9
 FbHm0yNEVz/dMOT581hClE1+4IP4jrgtxxtKeq9f7/JSbM/Vs9GMTMCjd29xns97+n6FjhdGybe
 ypoDacaT352sYShRLaPhT6a4kTf1FGSnnE6I6HoUHMNpFXBIZPLMr73NyxtbRJ4ZX1DvbqAN9Fe
 nd5WHG2o7nsOCLgrX3VgCLa9D5qTr/oCJ7IIF3StWYOsKCxxjnC8KvrmncCv7mxdUEFmWqR/4uh
 ry5o3Wj3mUBh3haOG2iHLCF44shxgdAX5lKM+iDBzagxr7pIXPTzdG7DJOpBCuXJP
X-Received: by 2002:a05:6000:4304:b0:3b6:c88:7b74 with SMTP id
 ffacd0b85a97d-3bc6afea9cfmr5485949f8f.59.1755502653833; 
 Mon, 18 Aug 2025 00:37:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFgARJaJxbjif5iR6eMFLUbk0ccSB9fuQPPbHb1viLkWLS+QHIORaFeGNYfTYGxtKPISGFc2g==
X-Received: by 2002:a05:6000:4304:b0:3b6:c88:7b74 with SMTP id
 ffacd0b85a97d-3bc6afea9cfmr5485916f8f.59.1755502653430; 
 Mon, 18 Aug 2025 00:37:33 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f22:600:53c7:df43:7dc3:ae39?
 (p200300d82f22060053c7df437dc3ae39.dip0.t-ipconnect.de.
 [2003:d8:2f22:600:53c7:df43:7dc3:ae39])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45a1c78c221sm167240295e9.26.2025.08.18.00.37.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Aug 2025 00:37:32 -0700 (PDT)
Message-ID: <6fe9163d-5690-4572-98d1-f0a9cfc3cd80@redhat.com>
Date: Mon, 18 Aug 2025 09:37:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 1/8] vhost-user: Add VirtIO Shared Memory map request
To: Albert Esteve <aesteve@redhat.com>, qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 hi@alyssa.is, =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, slp@redhat.com,
 Stefano Garzarella <sgarzare@redhat.com>, Paolo Bonzini
 <pbonzini@redhat.com>, jasowang@redhat.com, stefanha@redhat.com,
 dbassey@redhat.com, stevensd@chromium.org
References: <20250814083749.1317197-1-aesteve@redhat.com>
 <20250814083749.1317197-2-aesteve@redhat.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20250814083749.1317197-2-aesteve@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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


> +    /* Map the shared memory region */
> +    mapped_addr = mmap(NULL, len, prot_flags, MAP_SHARED, fd, fd_offset);
> +    if (mapped_addr == MAP_FAILED) {
> +        error_report("Failed to map shared memory region: %s", strerror(errno));
> +        return NULL;
> +    }
> +
> +    /* Create the VhostUserShmemObject */
> +    shmem_obj = VHOST_USER_SHMEM_OBJECT(
> +        object_new(TYPE_VHOST_USER_SHMEM_OBJECT));
> +
> +    /* Set up object properties */
> +    shmem_obj->shmid = shmid;
> +    shmem_obj->fd = fd;
> +    shmem_obj->fd_offset = fd_offset;
> +    shmem_obj->shm_offset = shm_offset;
> +    shmem_obj->len = len;
> +    shmem_obj->flags = flags;
> +    shmem_obj->mapped_addr = mapped_addr;
> +
> +    /* Create MemoryRegion as a child of this object */
> +    mr = g_new0(MemoryRegion, 1);
> +    g_string_printf(mr_name, "vhost-user-shmem-%d-%" PRIx64, shmid, shm_offset);
> +
> +    /* Initialize MemoryRegion with the mapped memory */
> +    memory_region_init_ram_device_ptr(mr, OBJECT(shmem_obj), mr_name->str,
> +                                      len, mapped_addr);

Oh, why did we go from memory_region_init_ram_from_fd() back to 
memory_region_init_ram_device_ptr() in this series?

I thought having a wrapper object around the memory region would have 
been sufficient to handle the race?

-- 
Cheers

David / dhildenb


