Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5347EC4345F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Apr 2024 10:14:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s1kV7-0006Cw-Cf; Tue, 30 Apr 2024 06:14:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s1kV5-0006BK-4K
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:14:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1s1kUM-0002oR-Pg
 for qemu-devel@nongnu.org; Tue, 30 Apr 2024 06:13:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1714472008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=0BufbMVVg+T5x+4aqilXqIFa90FRMFl1Vq/1pNJOM14=;
 b=f3DDRoWRKtQw211yCX20Q4aKezkEdmxxQBpkX8ESIJnzDa/Cd3fR0gHC69ct3+BoN/LFAq
 TBDI8bMBz3ZBWM8cOHoKust/TxThqdJtGtDQJeM+ZI/AewWbat//MUlzCDLNUGOcIXt8d7
 4fZeeQjiAUBiYjSRgFyHqBu3VljAzFY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-156-tVOliMpqO2mm1SbYhYzlig-1; Tue, 30 Apr 2024 06:13:27 -0400
X-MC-Unique: tVOliMpqO2mm1SbYhYzlig-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-41bf6751b28so13489995e9.2
 for <qemu-devel@nongnu.org>; Tue, 30 Apr 2024 03:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1714472006; x=1715076806;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0BufbMVVg+T5x+4aqilXqIFa90FRMFl1Vq/1pNJOM14=;
 b=EP6f+ZWgA0puajgYUYH9o2bKDsDEeqSx3mGp/lQjcGPFUP7jVFQ4PMk+EV7PEA99mD
 8J7xG4MqmWYWuMnsuY4tyRy7d0jZkDIQF6me146DDku+PTwvFFlMZvntkT1LWNa2aaIN
 ND5B1R4tv+Tq3daQnjHFUGRlm+nvqCFY4D4oH5SNHaMTQ1eP63J9KMvBMXQ4A3J8ZPIQ
 eWVitk3xXH6wc6PG4+Yp0vJwT+GeDshitmvabJw6r/T/yxPg4QA/H4AqljYb+trZVKOi
 u0By/1wbx7cv8HROFXP+atWEOE8toVacDVAES1Ai6iYvrCsOoZlGMRvRzWTQkmONtwIW
 au2A==
X-Forwarded-Encrypted: i=1;
 AJvYcCUY8XsD3hp+qZXbxICcY0rmyaLIaJJDPdS6tVvlVovdOT7b6M8M6DzMDBccwi7uYI5ZxHGYDJ3rGVyHYeQIoVft1NgERj0=
X-Gm-Message-State: AOJu0YxfW/Y13dueFWzqzEw8bQ8sU7OFkUuNgeFsd5l1at9OmBS06kUO
 fQ71yXfNt6SK4KGxeUAAeUhWz5NlJxUdc+kl9RwDiHrHrp14br7pzxpSVM5wXwdADIBubvitPAf
 p13xyGDaJXa9R7IiW8tkHWzr0bb1waBz0p/jXkwJhDWKIx1wfvngz
X-Received: by 2002:a05:600c:3548:b0:41b:bb90:4b9 with SMTP id
 i8-20020a05600c354800b0041bbb9004b9mr7592919wmq.4.1714472006019; 
 Tue, 30 Apr 2024 03:13:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFokTY7LUol4CAj1+AO/F4+QUU3KCIAF6b4qxe101JX+qVkuGy8W1HxmU9JuELCjw/MThd+Gg==
X-Received: by 2002:a05:600c:3548:b0:41b:bb90:4b9 with SMTP id
 i8-20020a05600c354800b0041bbb9004b9mr7592908wmq.4.1714472005624; 
 Tue, 30 Apr 2024 03:13:25 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:5dac:bf3d:c41:c3e7?
 ([2a09:80c0:192:0:5dac:bf3d:c41:c3e7])
 by smtp.gmail.com with ESMTPSA id
 n18-20020a05600c4f9200b004169836bf9asm48306342wmq.23.2024.04.30.03.13.24
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 30 Apr 2024 03:13:25 -0700 (PDT)
Message-ID: <da071e57-27d6-455e-b2a9-ffd2ea946857@redhat.com>
Date: Tue, 30 Apr 2024 12:13:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/2] target/s390x: report deprecated-props in
 cpu-model-expansion reply
To: Collin Walling <walling@linux.ibm.com>, qemu-s390x@nongnu.org,
 qemu-devel@nongnu.org
Cc: thuth@redhat.com, wangyanan55@huawei.com, philmd@linaro.org,
 marcel.apfelbaum@gmail.com, eduardo@habkost.net, armbru@redhat.com
References: <20240429191059.11806-1-walling@linux.ibm.com>
 <20240429191059.11806-2-walling@linux.ibm.com>
Content-Language: en-US
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20240429191059.11806-2-walling@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.987,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 29.04.24 21:10, Collin Walling wrote:
> Retain a list of deprecated features disjoint from any particular
> CPU model. A query-cpu-model-expansion reply will now provide a list of
> properties (i.e. features) that are flagged as deprecated. Example:
> 
>      {
>        "return": {
>          "model": {
>            "name": "z14.2-base",
>            "deprecated-props": [
>              "bpb",
>              "csske"
>            ],
>            "props": {
>              "pfmfi": false,
>              "exrl": true,
>              ...a lot more props...
>              "skey": false,
>              "vxpdeh2": false
>            }
>          }
>        }
>      }
> 
> It is recommended that s390 guests operate with these features
> explicitly disabled to ensure compatability with future hardware.
> 
> Signed-off-by: Collin Walling <walling@linux.ibm.com>


Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


