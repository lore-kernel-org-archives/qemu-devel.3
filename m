Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3BD97C8303C
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Jul 2025 09:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ua9fu-0004Qt-Sf; Fri, 11 Jul 2025 05:04:11 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9TA-0002Hx-1q
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:51:00 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1ua9T7-0003ye-RY
 for qemu-devel@nongnu.org; Fri, 11 Jul 2025 04:50:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752223856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=v2CTcd/fVTzCEOJHFnKMcxXmxWLuvQQHMFQroJLSQAI=;
 b=LYHynn1jF1281jwXhew4h3Tjarv0ZH2Ic9rPG8O9HSs6ugJVVBRzTobJi5tnYT6ULfjmMt
 x5obEhWdHcLidxBTs2KDKmeKMW45TDKQPttB0sweuEyQIpv5YH3u7BGHln0wKGmRxjapAA
 fj2VoFRho0y5DFh5UWk34fsOVbDXH7c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-685-ny-jwGtMPACEHKOfH9tDEA-1; Fri, 11 Jul 2025 04:50:55 -0400
X-MC-Unique: ny-jwGtMPACEHKOfH9tDEA-1
X-Mimecast-MFC-AGG-ID: ny-jwGtMPACEHKOfH9tDEA_1752223854
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso1315254f8f.2
 for <qemu-devel@nongnu.org>; Fri, 11 Jul 2025 01:50:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752223854; x=1752828654;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v2CTcd/fVTzCEOJHFnKMcxXmxWLuvQQHMFQroJLSQAI=;
 b=m0X3TkxVH5Ug3F45sCW5R4GHIidTleFPiKNgVLOGiR5Wm5LvlAVdlXYgvY2R4sMxVZ
 adNwIGpP+vABQnhOE7eR0gcBynERtcbwHjKTbRKoRKyf3+enxfByJeiIckDcKMlu2MSS
 KnO6/TqeLFOwvvz4ccf/8ZmkcMlHcVtnJfUw9zv9sEvq2EQVq1bklyuO0Y6EmtveE73C
 GanYrR6hUZyVH4AykxjyQlQNB/9zfQUN6ryPeJogqa1QcdiE/bHhsAOCCpHvPljW04y6
 yF9urEmzSMqPyM8m4+3hgoMEldmMSaYMwyaXXf+FypjM/6QaFJzaGY2EOfMhy5wMHUp0
 khcw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWMz9+7iA7DYbw9woK5rQ0kGkRp39zlA6GFR8sRJdc5p9/aXpZRl0oKMpJUg59h/nolmg84OVyayURT@nongnu.org
X-Gm-Message-State: AOJu0YxtDPH/cBd6f4ljRN9k9a4mXskfjGFgW/XSsmhJcNV9zb6ayO/0
 Op/hqaeKq/4nHZ2lyY9CIcdnlrxf7mjivA2zBX/4ociUihPurwRuzsdo4a8CAUJ3Vk6OHxZyloR
 zSZPGdTcQ7BuwexwyedOXCN7WGtvmHVUE/rWF7jxx9oOkE6Jr8914UIzpWHW3Dk+a
X-Gm-Gg: ASbGncspc7otuH9A0/YjhjrV11vQYhYK6Gx/cZ88goTNOOvqpgPt4ipVfvcOLb0p9wD
 wTflwuyhBz8i5KkuWUhlGAob8lIOR4oF8G/0hCgUplMcVayQD7WZ3+TTpHmIyKkYvWH2UumxuNo
 HZ/foT81L4XJE7xac6ZRXXr4m8aXw8nPAjCGjt60Nrxcd3MXjvZ7BZKzJRDxXfUMF5zICsOxoTu
 ve+WIgQn4PjBDLTXJ/iyQPc0K+STz4ZawEXmJAyePYnhYkSAoVUymxrPo/zEZA2A+yGF1mW7tuB
 VWX1a1E0jX4wMU0fcErkGmDb6sLqg2izeU0mI+sCvlMrtTdqcA9QK7DY+tVnTam76H26PpuYRT7
 Rw/2g
X-Received: by 2002:a05:6000:1a8b:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3b5f2e1bb21mr1459856f8f.31.1752223853545; 
 Fri, 11 Jul 2025 01:50:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHlGKCu0g1trtqXPPun31fz71AkE1gtjJprhlmMtbJGNpgKq0oUHH9Lm0jTQe8rKFGw9x3Zsw==
X-Received: by 2002:a05:6000:1a8b:b0:3a5:25e4:264f with SMTP id
 ffacd0b85a97d-3b5f2e1bb21mr1459791f8f.31.1752223852854; 
 Fri, 11 Jul 2025 01:50:52 -0700 (PDT)
Received: from [192.168.0.6] (ltea-047-064-115-149.pools.arcor-ip.net.
 [47.64.115.149]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc3a54sm3970300f8f.39.2025.07.11.01.50.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 11 Jul 2025 01:50:52 -0700 (PDT)
Message-ID: <7834f3e5-6eb2-46ce-8061-f17d9fdf51f2@redhat.com>
Date: Fri, 11 Jul 2025 10:50:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/4] target/s390x: Cleanups around s390_cpu_[un]halt()
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: David Hildenbrand <david@redhat.com>, Ilya Leoshkevich
 <iii@linux.ibm.com>, Richard Henderson <richard.henderson@linaro.org>,
 qemu-s390x@nongnu.org
References: <20250708095746.12697-1-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250708095746.12697-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 08/07/2025 11.57, Philippe Mathieu-Daudé wrote:
> Trivial cleanups around s390_cpu_[un]halt(), split of
> a bigger series which consolidates CPUClass::[un]halt()
> for re-use between accelerators.
> 
> Philippe Mathieu-Daudé (4):
>    target/s390x: Remove unused s390_cpu_[un]halt() user stubs
>    target/s390x: Expose s390_count_running_cpus() method
>    target/s390x: Have s390_cpu_halt() not return anything
>    target/s390x: Extract system internal declarations to s390x-internal.h
> 
>   target/s390x/s390x-internal.h | 231 +---------------------------------
>   target/s390x/s390x-system.h   | 215 +++++++++++++++++++++++++++++++
>   target/s390x/cpu-system.c     |   6 +-
>   target/s390x/helper.c         |   4 +-
>   4 files changed, 222 insertions(+), 234 deletions(-)
>   create mode 100644 target/s390x/s390x-system.h

Thanks, I'll queue 1-3 for my next pull request. Patch 4 needs some 
modifications.

  Thomas


