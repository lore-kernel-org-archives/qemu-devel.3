Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0E06C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 13:25:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4gHg-0003qz-9j; Tue, 15 Apr 2025 09:25:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4gHY-0003pz-O6
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:24:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1u4gHW-0006db-6l
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 09:24:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744723492;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=PuAuMgAIZ4T8jGY+S4qCNSjehktQ3hGQppM3WeGCIOE=;
 b=EYgd8FhxkfEc9ZMTIprkpxgmJvmWWdS6vC9e22OGWaDykuO0H0aqympAvp+QvGkJjvlrNF
 aSv9pC6NvTdwulDs7az1mv+A+Z/ELdlDzAJz29X51OPbUV2sufXVbzCrs82J7km1ZtMTlT
 NR8n4CFv3svL7+OvtFCmxnN3Ivil2eU=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-dzd1X7WXOWKhGa1pAlp9zQ-1; Tue, 15 Apr 2025 09:24:47 -0400
X-MC-Unique: dzd1X7WXOWKhGa1pAlp9zQ-1
X-Mimecast-MFC-AGG-ID: dzd1X7WXOWKhGa1pAlp9zQ_1744723486
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-43cf172ffe1so45248515e9.3
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 06:24:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744723486; x=1745328286;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=PuAuMgAIZ4T8jGY+S4qCNSjehktQ3hGQppM3WeGCIOE=;
 b=Nw17fZCJeOcBbwo2P9k3J+eo8JU2eUrdJjfAGlfIyBDiwwQ3M9EX06DU9iAvIVbLU+
 mqziU3n0sz6zIVGoNOrXjiUh85l1ckrMFXwqSoZJgDGkeHKaSPbST55F7Jr0DDZ6y2JH
 AGx/YI7S1qmOE5O+4cK2TtX+tLuRIqtXwlzvJ+Yl1O2wIqm79uoSbz6RDJQNj09ri13g
 pTzT9y9XvReI6aId20UZJxGJySZyWd7ynGGBrovum3ATAf+xBEwNizB2Jb3HbQveIGxn
 uooTT0Gq9VDLLURW4iK8T5ai1uo8GrUfUZwK27E0HiWuGGAraxn5bqNJJFkEYeWIKMPK
 WleA==
X-Forwarded-Encrypted: i=1;
 AJvYcCX2RISG835O7tSqk19LrNiTpB3UcMQHF7Le8cW4hZxWjJBSFyzJg3b8UzY5ix4LROLcthBeicmKIxFn@nongnu.org
X-Gm-Message-State: AOJu0YwIeXrrnY5psXWWlROiehSObFc5bYmsiFywwr3za7oYt/GBgWhr
 ukKcckicR0sgjFRYN5huDHzMr7ljJbepVDgkqeRe/D7CkQELCAh8slKzjC95e/AaZ7aLF+UI1H5
 ltBiBm+8zhJCMZnI9NkDR7VpKRlvD5xjg6hWvZMPaDOFJMgumBtVU
X-Gm-Gg: ASbGncswB58swz8OOTnYxX6+0tmjlO4KalKqUFlR8udrjwLN2n3L0jGn2EOirMkts3J
 ZdrclSLA2cbLi8C4UJb9c/tJEwep0akoHl3vvU3vV+wRqBaw1R+AW5T3ikLqSRCliFn+cK+I27F
 pClzNBXlw74+YG+U7ltaHIR2JYjWlcHDbjO7BrAwaarWiomZ7QptRZSmge2fqIRz3MyZEtA+zcB
 FK+iPPp5VbV82L8M9PKBwVVELzmuGrrCKswyK5q/2fQRIgfW7xcxCkRKicKu1hrcVMSL+fBWmEY
 VO1C6QWaeqlxEog2
X-Received: by 2002:a05:600c:a43:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43f3a9aa690mr115024135e9.20.1744723486080; 
 Tue, 15 Apr 2025 06:24:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEfZlNCRIYhaB1h77C4YwkaCiM22AK4zWsxFzNheuiDHlPgp0lMDVvIB5V5IPuUSacIc7Z0Tw==
X-Received: by 2002:a05:600c:a43:b0:43c:fa52:7d2d with SMTP id
 5b1f17b1804b1-43f3a9aa690mr115023845e9.20.1744723485742; 
 Tue, 15 Apr 2025 06:24:45 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.109.83])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-43f205ecc73sm211157645e9.8.2025.04.15.06.24.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Apr 2025 06:24:45 -0700 (PDT)
Message-ID: <3000f78a-5842-46f0-9dc4-cb8180c38a39@redhat.com>
Date: Tue, 15 Apr 2025 15:24:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
Cc: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>,
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>,
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <20250415030653-mutt-send-email-mst@kernel.org>
 <20250415123330.GB270228@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250415123330.GB270228@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 4/15/25 14:33, Stefan Hajnoczi wrote:
> On Tue, Apr 15, 2025 at 03:11:00AM -0400, Michael S. Tsirkin wrote:
>> On Tue, Apr 15, 2025 at 06:18:08AM +0000, CLEMENT MATHIEU--DRIF wrote:
>>> Address space creation might end up being called without holding the
>>> bql as it is exposed through the IOMMU ops.
>>>
>>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.com>
>>
>>
>> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
>>
>> Stefan, want to pick this one up, too?
> 
> Not yet, it may need to wait until after the release:
> - Discussion is still ongoing.
> - Is this a regression in 10.0 or a long-standing issue?
> - Who is affected and what is the impact?
> 
> There are still a few hours left before -rc4 is tagged. I will merge it
> if consensus is reached and the missing information becomes clear.
There are other thread-safety issues in the same code, so I'd prefer to 
hold this patch and not hold the release for it.  Even if it's a 
regression, it can be fixed with a quick 10.0.1 in a couple weeks.

Paolo


