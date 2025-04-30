Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7799AC369D9
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 21:38:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uAF8K-0002kw-IC; Wed, 30 Apr 2025 17:38:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uAF8I-0002kK-Np
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uAF8G-000811-OK
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 17:38:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1746049098;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=LZfMM7T/nTuBkAM1Iw3JhH2thrF3UWOPVhniOlfJPmQ=;
 b=OEkkkL7ZN+XK4scS3YMohd3cZHoPmdypnko2tPdMCkWFk7NFG53x+OeecSpSMEw3x6DK/W
 lbP/N9oKom7WnoZZkbyttx4rnufhKu/Oq9g8a4cMSkK+MnhPk48zF21DRzvVK8uOuruI31
 0T+DKJHgtkC3ZGwg1VHtuCXjkMNiclk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-39-qAR9NRAjP4Sd7cOZmYwjQw-1; Wed, 30 Apr 2025 17:38:17 -0400
X-MC-Unique: qAR9NRAjP4Sd7cOZmYwjQw-1
X-Mimecast-MFC-AGG-ID: qAR9NRAjP4Sd7cOZmYwjQw_1746049096
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3a07a7b4298so123138f8f.0
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 14:38:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746049096; x=1746653896;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=LZfMM7T/nTuBkAM1Iw3JhH2thrF3UWOPVhniOlfJPmQ=;
 b=C7sbveuHDQCB9tP7gpJs5UCrbCa/qfez+idi//GlsE0NYnKX8tI9fdtmVd8PyQPSDi
 nAv8+Z0ZplA+MhdPoR5HkfkGXGVHv6ica0JfxYDGQY8cai8TD46TuiUOhD7s6PiFzk3g
 3UblW1sJ9NBa7F1Ul/V+aw83er/iYlEuNpE2XEVeKsoV3T3KxjiX1LLS71I7UR2AWg3c
 NSFguWoGqj3ke+eYXWWuflOTRviV/79/lveRH6Ub/oUp/BKIfCJ+LN0oPFEvJGLIDiaW
 5rZeu/N5pkZMUsf1O21Lo+Hs3oQiE/r96mofPrzeCzdTuHk6EP1od0JdEuJtSg0ny1ei
 PSNA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUwyDo5rCNxFqAXO4hcL64DGEgfzv2MrcJ3aTqQQFr4SPu0wuuD7PUyGAs4mJRD2g2HeQbziIaf/lUF@nongnu.org
X-Gm-Message-State: AOJu0YyKLHWQtjg1QlQ6htdMhkSB3Qsm5te8mkvTV2w9OQzFtcobWd3g
 ZChkflVusjLW/kfkEkG3KBWz2/Cm1X8cV5QCMcpDejuOTLzs1zeeTiyfd6GasKJCx2BKJeaiHmI
 0VmoJmKIeyZah0A+4lPH93fDEye2qPR3kV8Y5ZKi0oJdw/tvubJDS
X-Gm-Gg: ASbGncukw5O0l/e43TXrbESh0kzaDYCtYfPTTS+tVcAUjzLwdTV+SoeQCkocbwSFgxF
 TN47Aj901+O5dcOV+0y1LErjnAQRp4WsPngBiEiqeJm17SQoftbHKFxDC6ucqg7cQGUQ2pOO0bk
 CwyP9ulZBbSid3QtDcJYe6pgiXfKRB0RbEWXUz+v4HXQIAyxmuCNibBkGjhfKgBXfX5L8iYLBSG
 jEeLtCdmH/C/zw6Wk7Miw8/jb+jz7dy5TfCc6L+0qBX0DxfpvVcDlMby6FvGxocwS53V8H9l38i
 9/pHM2WknXsYcRv7tlQ0XQZayLRkvcZe99/0kN7JWHRwsxP+MwV1b6xjAUpeTrse51ECtc4fXzP
 uy18BPkBNeLBEchy7aVNL7DtAqJz3gGViQZGhmX8=
X-Received: by 2002:a5d:64ee:0:b0:39c:1424:1cb3 with SMTP id
 ffacd0b85a97d-3a08f752638mr4615460f8f.5.1746049096034; 
 Wed, 30 Apr 2025 14:38:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHOCoUUC0V3Cxqj6KalcZ7L0gIjZqUuXtul45uLqJ3E7d4scSjd2+bEPI1soa0lGFEUVvlKCg==
X-Received: by 2002:a5d:64ee:0:b0:39c:1424:1cb3 with SMTP id
 ffacd0b85a97d-3a08f752638mr4615449f8f.5.1746049095729; 
 Wed, 30 Apr 2025 14:38:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c745:a500:7f54:d66b:cf40:8ee9?
 (p200300cbc745a5007f54d66bcf408ee9.dip0.t-ipconnect.de.
 [2003:cb:c745:a500:7f54:d66b:cf40:8ee9])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3a073e5c7d1sm17855264f8f.83.2025.04.30.14.38.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 30 Apr 2025 14:38:15 -0700 (PDT)
Message-ID: <f5f540a2-a6d6-47fd-9b7c-8fd4a4927684@redhat.com>
Date: Wed, 30 Apr 2025 23:38:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/1] system: optimizing info mtree printing for monitors
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Chao Liu <lc00631@tecorigin.com>, pbonzini@redhat.com, peterx@redhat.com
Cc: zhangtj@tecorigin.com, zqz00548@tecorigin.com, qemu-devel@nongnu.org
References: <cover.1746003314.git.lc00631@tecorigin.com>
 <6b3567672da9d5778c18a32ee1306aaed884463c.1746003314.git.lc00631@tecorigin.com>
 <15227d0a-c459-4bea-bec7-13dc88d22c3c@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <15227d0a-c459-4bea-bec7-13dc88d22c3c@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.483,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 30.04.25 11:58, Philippe Mathieu-Daudé wrote:
> Hi Chao,
> 
> On 30/4/25 11:02, Chao Liu wrote:
>> Make the hierarchical relationship between nodes clearer by adding characters
> 
> W.r.t. $Subject, it isn't really about "optimization" but making
> output clearer, as you describe.
> 
>>
>> e.g.
>>
>> qemu-system-riscv64 -M virt -monitor stdio -display none
>>
>> ```
>> (qemu) info mtree
>> ...
>> memory-region: system
>> │  ├── 0000000000000000-ffffffffffffffff (prio 0, i/o): system
>> │  │   ├── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport_window
>> │  │   │   └── 0000000003000000-000000000300ffff (prio 0, i/o): gpex_ioport
>> ...
>> │  │   └── 0000000400000000-00000007ffffffff (prio 0, i/o): alias ...
>> ```
>>
>> Signed-off-by: Chao Liu <lc00631@tecorigin.com>
>> Reviewed-by: Qingze Zhao <zqz00548@tecorigin.com>
>> Reviewed-by: Tingjian Zhang <zhangtj@tecorigin.com>
>> ---
>>    system/memory.c | 36 ++++++++++++++++++++++++++++++------
>>    1 file changed, 30 insertions(+), 6 deletions(-)
>>
>> diff --git a/system/memory.c b/system/memory.c
>> index 71434e7ad0..cf91718bcc 100644
>> --- a/system/memory.c
>> +++ b/system/memory.c
>> @@ -3296,6 +3296,21 @@ typedef QTAILQ_HEAD(, MemoryRegionList) MemoryRegionListHead;
>>                               int128_sub((size), int128_one())) : 0)
>>    #define MTREE_INDENT "  "
>>    
>> +enum mtree_node_type {
>> +    MTREE_NODE_T_INNER,
>> +    MTREE_NODE_T_TAIL,
>> +};
>> +
>> +static void mtree_print_node(enum mtree_node_type is_tail)
> 
> Either rename 'is_tail' as 'node_type', or really use a boolean
> (maybe '[is_]last_node' is clearer?), since the mtree_node_type enum
> doesn't bring much (see [*] below).
> 

Note that I suggested that, because the passing or true/false in the 
code is horrible for readability.

-- 
Cheers,

David / dhildenb


