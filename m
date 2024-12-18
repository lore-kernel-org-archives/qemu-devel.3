Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7E07E77187
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Dec 2024 16:03:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNwVZ-00031y-NE; Wed, 18 Dec 2024 11:02:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNwVX-0002vZ-TM
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:02:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tNwVU-0008LD-D4
 for qemu-devel@nongnu.org; Wed, 18 Dec 2024 11:02:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734537758;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=1RVHCfcdqcEQIiL70TH4TJkxTcYPAUx4uhixmbAGrhM=;
 b=ORUe4DzUgtYpSB9g1TtPoP976IN8znc5I4BNkAZBgGzslP8lCL/8bZTpacbDdihCUB3HFE
 h2pvTGLqUF43UJOwQACJiJ5mjtyu0IUkO5IXiGyTvxgnVL3gxRE08QPpg/gwoe7l0iBBz3
 mHaL2cpGnIopzVyxxsjpYS9kxQdlGOA=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-416-NxKyAtMfNUaW6l9b3chhsg-1; Wed, 18 Dec 2024 11:02:37 -0500
X-MC-Unique: NxKyAtMfNUaW6l9b3chhsg-1
X-Mimecast-MFC-AGG-ID: NxKyAtMfNUaW6l9b3chhsg
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-7b6e4bea711so1097226385a.3
 for <qemu-devel@nongnu.org>; Wed, 18 Dec 2024 08:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734537757; x=1735142557;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=1RVHCfcdqcEQIiL70TH4TJkxTcYPAUx4uhixmbAGrhM=;
 b=kPdn1KsEu56qJQmKMDijf45gY2VOp8yEf2VtUHlTsyFhwqVG2HDsGxmq91YKpRW00b
 iPUuyZbs8dyFIx/0YjAXQeFVqsFdLtUgSt14OnVMYu+/eQK1se640MPs2rZwbA819QJg
 hB20FwRsexPVrRvE9fu7bs7YX7aIDZXVeYAuk8I1bw9YCDVNFbdFPjYAcuWhWHrIUrEb
 M2WRAvahkb2g3r7wtxrgbiVJUr3lDUd+XVrpGDaYfvUfkioxUD4dk7cz7dXMcRblGoL2
 3osYAwtwz6OieCHlf3u8d1be4076taIyw7dDxuaxx/fI+z/6pJq2/V2uM22IT5jpOw7G
 FKDA==
X-Forwarded-Encrypted: i=1;
 AJvYcCU1TXlAN0l5wKhDxXdebu2v8ihHBxw36i3u0PweNbZP/GbMImLPA9lKhHkTO7JOzuC7JuD267+zwP0D@nongnu.org
X-Gm-Message-State: AOJu0Yzs56uvMJt/krYGkf+gaBYjEVZ/1IDbHtWfoshy9/8Mq1jE5cIN
 R0srCGTMxmB4t+VXa/bIYiXq2PMBViYrg5SkwzPIoQ1nkVE1BlqTnQ+WH6QS9O8kqxplNWjhXjh
 VNsn8osESB7SlVlQO4K7hxcUezdpahfejlYRRTaptGA5siXqBMiBy
X-Gm-Gg: ASbGncst5TeaFuobiIeftQ1OxCxKvqmjVDfNNJsTiFcxBvIWP7heP35OeN9C6Am8O25
 awe+Xnd5AzcjZue6OP8yG0gIquiCzviadyC2nL723C6vqRuhM3NI71SFqzhL3bIz8lqcZqfNwwD
 wtUm27Z6/uWqGueMiRogLnRJ5AiIwX/CbDwRl/1MPMBn76+h431J48+xFvUC45SyRJMbw0tZI4W
 iM9qfDtopQd9EctylOqLmjW5oTTAO+EyjeKrohRUOUmmmodiN/wkozuwTwoxIDJO4DxuoPp2IU5
 EBJzKLm1DlCG
X-Received: by 2002:a05:620a:44d3:b0:7b6:d6e5:ac6e with SMTP id
 af79cd13be357-7b8636e6e09mr424916585a.4.1734537756957; 
 Wed, 18 Dec 2024 08:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEk8K8Li40AVxD7oY68g+83EbML+bij5y1nsmF6JgePbttJbriFRdhTg65OIR7WoiH27Z5Cpw==
X-Received: by 2002:a05:620a:44d3:b0:7b6:d6e5:ac6e with SMTP id
 af79cd13be357-7b8636e6e09mr424913285a.4.1734537756673; 
 Wed, 18 Dec 2024 08:02:36 -0800 (PST)
Received: from [192.168.0.6] (ip-109-42-49-186.web.vodafone.de.
 [109.42.49.186]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b7048bb8b6sm438319585a.89.2024.12.18.08.02.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 Dec 2024 08:02:36 -0800 (PST)
Message-ID: <d34b78bd-4add-4123-b0e7-5c5afb8a9e67@redhat.com>
Date: Wed, 18 Dec 2024 17:02:30 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] system: Move 'exec/confidential-guest-support.h' to
 system/
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Eric Farman <farman@linux.ibm.com>, kvm@vger.kernel.org,
 Marcelo Tosatti <mtosatti@redhat.com>, David Hildenbrand <david@redhat.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-ppc@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, qemu-s390x@nongnu.org,
 Yanan Wang <wangyanan55@huawei.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20241218155913.72288-1-philmd@linaro.org>
 <20241218155913.72288-2-philmd@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20241218155913.72288-2-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.116,
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

On 18/12/2024 16.59, Philippe Mathieu-Daudé wrote:
> "exec/confidential-guest-support.h" is specific to system
> emulation, so move it under the system/ namespace.
> Mechanical change doing:
> 
>    $ sed -i \
>      -e 's,exec/confidential-guest-support.h,sysemu/confidential-guest-support.h,' \
>          $(git grep -l exec/confidential-guest-support.h)
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---
>   include/{exec => system}/confidential-guest-support.h | 6 +++---
>   target/i386/confidential-guest.h                      | 2 +-
>   target/i386/sev.h                                     | 2 +-
>   backends/confidential-guest-support.c                 | 2 +-
>   hw/core/machine.c                                     | 2 +-
>   hw/ppc/pef.c                                          | 2 +-
>   hw/ppc/spapr.c                                        | 2 +-
>   hw/s390x/s390-virtio-ccw.c                            | 2 +-
>   system/vl.c                                           | 2 +-
>   target/s390x/kvm/pv.c                                 | 2 +-
>   10 files changed, 12 insertions(+), 12 deletions(-)
>   rename include/{exec => system}/confidential-guest-support.h (96%)

Reviewed-by: Thomas Huth <thuth@redhat.com>


