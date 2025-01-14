Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3EB9E77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 14:01:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXhU2-00081H-1R; Tue, 14 Jan 2025 09:01:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhTl-00080s-6o
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:01:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1tXhTi-0002qn-8G
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 09:01:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736863268;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=nlWleDUIMsS2jwvuNYiGOiFFuyxeQDHZ/qZSc7hmHcQ=;
 b=U+Mwm2YrTOXhMe6bYPFPL1zH6wGyT/S5wenWZKir5FdG6Dkfn/9t0qitfaDo6iuX3yBkvN
 8OYttO3aAi93/rqktURJEuk91YcM5rjKuvtD2c5ZZO0IYvQJmgqG28JEqSVGiK45fOCKiu
 E+n/wAhUobAo8t2KZCdMIsCLZ5ed8Ds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-92-qm1QB8OMOuOUOe5nvD_pGQ-1; Tue, 14 Jan 2025 09:01:06 -0500
X-MC-Unique: qm1QB8OMOuOUOe5nvD_pGQ-1
X-Mimecast-MFC-AGG-ID: qm1QB8OMOuOUOe5nvD_pGQ
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-388d1f6f3b2so2500074f8f.0
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 06:01:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736863265; x=1737468065;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=nlWleDUIMsS2jwvuNYiGOiFFuyxeQDHZ/qZSc7hmHcQ=;
 b=VcTg8wOhuBwVjlKeOexZ8HyK6HkfJlV/L1ua+4BtMGN8lFO5y2swHNmOqxfCnFjYBR
 9B73v8uT8hyK+2BEU91YqMAvUZn9wJQpqQQI0fenujraT0SsN4lZHeA1ZX2Pa80h/ioa
 UmchtW0elIdoXTp3/zNGkUzm3ZzvItWbu8ltkMI5drHRb1fKD8nQeDt984CEn2o+2iM7
 e04j2/CN/4SWWIm9Bz6/8LYTIxrrMyWgrGKQQ1BNqZzAhEOHwYQ0/kPRWylg0yzkGBzU
 rwpwtEGDp+jFcf45vXTUwmBu1DK1o41Wny9SSfHL7Sjbhj7OiI27YNjsS2TVSL9TQFAR
 /6hg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXZ18kndzfFiJ768655Y67/hH5Mq5PczvUmqfOkXU+oUJM7CUiGPvtgGTWVWzAyCLuGxdjOl4Iskjn/@nongnu.org
X-Gm-Message-State: AOJu0YxKeC9UHk0bl+KbruKxMnJ0zT+V+k7Nwbl+O4UgZ6X08+NAhb3T
 Jksh6FqIKtHi+Xua5yqUUh6hIMLke2/NqJJC9vzPxr/oYGBv9KVTvMrxvV1+Zz0pcghqJiEFbaN
 MY4DKifoS68FIlmwAhgZ5TrCMG5fh7hUJ/15aYQ6GbuQdGffmnP5Z
X-Gm-Gg: ASbGncsFwtGrBiR7TH/d4UDq9dhX2IEg2uOLnwA7k32RoWVYpq+FnotQxuGVYkKHWKl
 uMWlA4mpEOrNI3lt0t5mD25TMJGdfrmLra3/0AfiHR/iktrwT2hZGWq2rrnoZQJ0+GasGQgqEEU
 LCDBzBxXdyGcPeJ+VHyBMDjJ37Ab7uGZtvOtZ1p2JT7n7JFqttg/K+dutaaFL6/n0OKMp1rVM6L
 5lhGqLO/3xzMFa2Ay7iEbgqCgK223fDgf0Skq7axBLmG0Lsy4dEmh3U15qutQWaqQGbTrqjKZ7a
 JEkBp5kRHOQCSufuGSNtogfu0uCin5qJW/XhZ20un7u5xHB/4d2r6G00XYHfxNMTwyL50RQMnDo
 RCAVOcF04
X-Received: by 2002:a5d:6c63:0:b0:385:f38e:c0c3 with SMTP id
 ffacd0b85a97d-38a872f6eb4mr19679305f8f.6.1736863263186; 
 Tue, 14 Jan 2025 06:01:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxwFQMVUCHSGLQ9DgFsnAU/aUPIjw3iKv0pKkRJvNfQO83MKMVpbo6Eqxcny4Gp0x1sjvOPA==
X-Received: by 2002:a5d:6c63:0:b0:385:f38e:c0c3 with SMTP id
 ffacd0b85a97d-38a872f6eb4mr19679214f8f.6.1736863262417; 
 Tue, 14 Jan 2025 06:01:02 -0800 (PST)
Received: from ?IPV6:2003:cb:c738:3100:8133:26cf:7877:94aa?
 (p200300cbc7383100813326cf787794aa.dip0.t-ipconnect.de.
 [2003:cb:c738:3100:8133:26cf:7877:94aa])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a9fcb7a11sm9419173f8f.75.2025.01.14.06.00.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 14 Jan 2025 06:01:01 -0800 (PST)
Message-ID: <dbdc0f83-5b5b-4104-b850-63c0a4ec795f@redhat.com>
Date: Tue, 14 Jan 2025 15:00:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/7] system/physmem: poisoned memory discard on reboot
To: William Roche <william.roche@oracle.com>, kvm@vger.kernel.org,
 qemu-devel@nongnu.org, qemu-arm@nongnu.org
Cc: peterx@redhat.com, pbonzini@redhat.com, richard.henderson@linaro.org,
 philmd@linaro.org, peter.maydell@linaro.org, mtosatti@redhat.com,
 imammedo@redhat.com, eduardo@habkost.net, marcel.apfelbaum@gmail.com,
 wangyanan55@huawei.com, zhao1.liu@intel.com, joao.m.martins@oracle.com
References: <cf587c8b-3894-4589-bfea-be5db70e81f3@redhat.com>
 <20241214134555.440097-1-william.roche@oracle.com>
 <20241214134555.440097-3-william.roche@oracle.com>
 <15d255c8-31fb-4155-83f0-bf294696621b@redhat.com>
 <9d1ed0f2-f87a-4330-bf5b-375e570a74e1@oracle.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <9d1ed0f2-f87a-4330-bf5b-375e570a74e1@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.794,
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

> If we can get the current set of fixes integrated, I'll submit another
> fix proposal to take the fd_offset into account in a second time. (Not
> enlarging the current set)
> 
> But here is what I'm thinking about. That we can discuss later if you want:
> 
> @@ -3730,11 +3724,12 @@ int ram_block_discard_range(RAMBlock *rb,
> uint64_t start, size_t length)
>                }
> 
>                ret = fallocate(rb->fd, FALLOC_FL_PUNCH_HOLE |
> FALLOC_FL_KEEP_SIZE,
> -                            start, length);
> +                            start + rb->fd_offset, length);
>                if (ret) {
>                    ret = -errno;
>                    error_report("%s: Failed to fallocate %s:%" PRIx64 "
> +%zx (%d)",
> -                             __func__, rb->idstr, start, length, ret);
> +                             __func__, rb->idstr, start + rb->fd_offset,
> +                            length, ret);
>                    goto err;
>                }
> 
> 
> Or I can integrate that as an addition patch if you prefer.

Very good point! We missed to take fd_offset into account here.

Can you send that out as a separate fix?

Fixed: 4b870dc4d0c0 ("hostmem-file: add offset option")

-- 
Cheers,

David / dhildenb


