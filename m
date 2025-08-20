Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 157C3CA0EF8
	for <qemu-devel@archiver.kernel.org>; Wed, 20 Aug 2025 09:30:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uof8I-0004Kk-0J; Wed, 20 Aug 2025 05:29:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uof8F-0004KM-71
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:29:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1uof8C-0001pS-Rf
 for qemu-devel@nongnu.org; Wed, 20 Aug 2025 05:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755682158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=syAv2VQGJ5kfHz8tQi9MR+WXXqDAUBY+nEWDz/pOZIs=;
 b=AzUQZ3+2R7rVdN9IKGBNS8RLne/SJLkmwssgYreauMZR3AOvB+DG8GrOp6QM+x6OSzPkvb
 /f2jHD+mejD2v3lV8N5JpJaaTBI/x7YC8h9WTRcwr2PG3Pgk/VzQz0AwDVOq58HKV0xfiN
 i8YPuBiACx8kMMF9Vk+InCMIhS0xQRk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-1Il9KtASP-y8WWmt3fkoTw-1; Wed, 20 Aug 2025 05:29:15 -0400
X-MC-Unique: 1Il9KtASP-y8WWmt3fkoTw-1
X-Mimecast-MFC-AGG-ID: 1Il9KtASP-y8WWmt3fkoTw_1755682155
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3b9e4166a7bso3158366f8f.2
 for <qemu-devel@nongnu.org>; Wed, 20 Aug 2025 02:29:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755682154; x=1756286954;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=syAv2VQGJ5kfHz8tQi9MR+WXXqDAUBY+nEWDz/pOZIs=;
 b=Vo4qrUoeB4zvYkgI/LcmOkQHAFmYhkbndRb+efhvB1kev6nbSwx2MUzS1niyQJ0ZoQ
 CJQP1lvpGFG7rbcvST+hIVRusoPnYKSoBzOxikIrtBY+nywYNI4qlC0wbT0hCzYC0nA3
 I3udKGQELnwxXOyCsjyqC6VV+xtmpT5lo7nHUoLz2ldX5h0WcdyXfUxlz/INjKHTCxXh
 mzuPfwf2MAuSxiTys0amUhvuOLI0fTzSG7+QiESEv2xRZh746OmTq4i4izqEtfKGwDSg
 OE7kj5pGxvnVxeXMLm14Gs8fzUbPY7GpAFLxdtaMrnOxKeS00WGErSzLczOPpCVKRvCD
 TrPg==
X-Gm-Message-State: AOJu0YzXBdeZX9SSfaJ7mWOF8Nvyi46ORb6Q9AfGDLModO94PVA/Ij7S
 xq6HUChhqB4DaIO/CeGTNPDs8zQEzpl5HVyfh6K4joKRBBsrRN+r+HQHhKmT06ziRlDSju2oUdS
 DSDWPsi2tCOITje1/P5ShxAQcG/mjPZ7DPWpKNlEd51rAhIGIpQp8V5kV
X-Gm-Gg: ASbGncu2mkCKBkbSTdoWtyNJRA3qD702jxWmu8vwgvDdZFC35WZjsZnbRqS6aDI+XCE
 SjmyE1LaksXWfAbv6EGxDVwaP5ptn0as+0Jy8PrGw36lQXZVnFRnlDFRlQR6GyqOGwV6ZgMh0mC
 galS8yt/3Q+Z8q0CPPOfE5yuO06CwlY+YfZL+rl6hy1ibongpHTdYXLmInTmT6XbPVJH1IRnpHZ
 WLzhUC1SiVNC2BVKMgr/WfrBuDNIQT1ARm/k7DLX3Ipa+tATtgKTVAbIRSuhLXRH37ONrq2SkJl
 aXG30IIZWV/XIV/eMh2b7Ljr62YhH/6/eiN3GYEBFJkwcrSS24adEZtoCPw7AvfOHPsMrjAay8j
 oX1OfHRUx7gTdhD516ac42847qQKlrnOjGaowkxI3r0zhH+n2A4FeST4GBk50VkXm
X-Received: by 2002:a05:6000:310d:b0:3b7:8473:31c3 with SMTP id
 ffacd0b85a97d-3c32c247939mr1281615f8f.9.1755682154557; 
 Wed, 20 Aug 2025 02:29:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEsS6kxUAMCIas3xRWVJ+VCmFbLhU+OkBXKckGyUAsDdH+xSW2+C+tUZGeeRg3/BmWR0e/XLw==
X-Received: by 2002:a05:6000:310d:b0:3b7:8473:31c3 with SMTP id
 ffacd0b85a97d-3c32c247939mr1281603f8f.9.1755682154154; 
 Wed, 20 Aug 2025 02:29:14 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f13:de00:e9f1:62b4:5bb:5d83?
 (p200300d82f13de00e9f162b405bb5d83.dip0.t-ipconnect.de.
 [2003:d8:2f13:de00:e9f1:62b4:5bb:5d83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3c0777892basm6895354f8f.56.2025.08.20.02.29.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 20 Aug 2025 02:29:13 -0700 (PDT)
Message-ID: <45c2fe3a-fb71-4cc2-96ff-20612da34627@redhat.com>
Date: Wed, 20 Aug 2025 11:29:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/arm: add static NVDIMMs in device tree
To: Gao Xiang <hsiangkao@linux.alibaba.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
References: <20250730-nvdimm_arm64_virt-v1-1-f843596ab995@linaro.org>
 <20250731110036.00003a0a@huawei.com>
 <e8203af151ea4f9696b809dd5de6b155@huawei.com>
 <db65aa49-7323-49f4-8531-7c617e9d8a1b@linux.alibaba.com>
 <dd4fff02-7c73-412f-bf8c-ee8446cd9b11@linux.alibaba.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <dd4fff02-7c73-412f-bf8c-ee8446cd9b11@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=david@redhat.com;
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

On 20.08.25 06:10, Gao Xiang wrote:
> (try to Cc David and Paolo for some discussion...)
> 
> Hi David and Paolo,
> 

Hi!

> If possible, could you share some thoughts about this, because
> currently each `memory-backend-file` has their own page cache
> on the host, but if QEMU can provide one nvdimm device backed
> by multiple files, so that EROFS can share memory in finer
> layer granularity on the host.  (we don't need to attach so
> many devices, because some container images can be dozens of
> layers.)

Sounds a bit like what virtio-fs does?

> 
> Without further investigatation, I wonder which direction is
> better:
> 
>     1) one memory-backend-file backed by multiple files;

No.

> 
>     2) nvdimm, virtio-pmem, .. backed by multiple
>        `memory-backend-file`s..

Better.

> 
> Currently I don't have extra slot to look into the QEMU codebase,
> but if the idea is acceptable, I will try to work on this later.

But is this really better than just using many devices?

-- 
Cheers

David / dhildenb


