Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0872AC44524
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 06:55:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmnKq-0008BD-PB; Thu, 23 Jul 2026 02:55:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmnKp-0008Ay-0h
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:55:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1wmnKn-0003XY-8f
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 02:55:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784789708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Iw1zBylGnVl9+rnQcV/usuToQ/lAQ3WLGuXEI1eevbA=;
 b=Wt6+ZFoUMPll7NBYayTJfBojLMIummyR/dgqiRz8tZGaqClw1sxEbTLfKw6nmWxXCqu4K7
 mDU/jgdNkXi/JV26HRWFlLq9JBfwVul4NDfpLkZoq4v8V9+bUH45xxppIS0sMYtCm7WQ0Z
 hXvcU3FbZGM0YXdWA2wNLzbMkyeMeq8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-ShLcUtMSPGa2f2dUJbV3Eg-1; Thu, 23 Jul 2026 02:55:06 -0400
X-MC-Unique: ShLcUtMSPGa2f2dUJbV3Eg-1
X-Mimecast-MFC-AGG-ID: ShLcUtMSPGa2f2dUJbV3Eg_1784789705
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-47f90dbaf84so210838f8f.1
 for <qemu-devel@nongnu.org>; Wed, 22 Jul 2026 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784789705; x=1785394505; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Iw1zBylGnVl9+rnQcV/usuToQ/lAQ3WLGuXEI1eevbA=;
 b=Zt6xFzYmc/cdHk8YRXwf5TpqyV/iVWOzrnii/5hSrlzXam5OMWFF+zBgugr0dJeq0l
 T4VDoCyFzSxS7PNUahgJaoOUJ2sGQ0JGs2fdzshZcgynhfyNxhb7cVvILQgh40L/i6Q6
 vtc+QrvI7ymd1S5l5imx5JT568iHsJG+DaLw6BFvZ42c0gEJLStZOn4cV2CdsLv9JbWm
 kF6oZ4Msv3ES+mjis09sZip68Ncb0RIGts/U2yDbD9qZp/4CbEtdByUxUjhKQQ24Q4cT
 PsNGXTiNpz0Y7h3WPoCpFmZEC3Z+qNq8Ky8qXra5nHXyZpKIvHzxjmVbnBczIWxQdNF6
 yfZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784789705; x=1785394505;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Iw1zBylGnVl9+rnQcV/usuToQ/lAQ3WLGuXEI1eevbA=;
 b=QZstjMbySKUaXgw7f2VWuMWouXL2UgJmx1UiFC/D4357bQWjb/J3TBTrwzjzdtYyJq
 CZ5GOtoFNWtY956C6ljysEYrj4LBzCaHsbw0Y2TQiZddf9CEXGlMhnrflicmO8C3A9yc
 5yr4LGBNTxOPEHYILcxedenhKsOzDiPkfSrloSqlkSRwYq+KVWc1jXI37y4UXwmOVxRs
 ZFqwEeX0kBuU0G/cZ98faT7wtUghsgYkM72R67UupPEGR0KfOGe4KyLfSvaenn3xF9ST
 EL5VPq26hNcQJf/vpaVcbG2Ja6XHoJRamcRt9Y35RwFHpF3nlEhDMu+3wWSE/48shXMv
 /eZQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RoGpQ4Htu0Sszrb+vqH3K7sHVRikHwWEjdLhvEtchh8CjufjvG5e1OUi7i8GOxePM8P/NuNmNPd0xXi@nongnu.org
X-Gm-Message-State: AOJu0YzmAivOnZzaZHF6LTgS6e5bdQMQXucZqUh9/Wh8Q+ULqUh6uTL3
 Q5i2MyZCSJu5x9WYtKAnaKGQWyRw5lOr+L/wmjaF9RG7lVTVCRq8kbxiewDOQ7UuNA8kute3hrf
 5UKzEVuvulZqfKAsXXXS/uqZSrYEBba+taSd6vo11tasUT996zSaxnTIW2Fnk9/Mm
X-Gm-Gg: AR+sD10pgcTtDgRZSduTN6DBAx88YQZVQQ0m35y0awPSrk3Wi3l0jcPwFBe/wUIe+Y2
 RdA12LrYNEYV8DWV/98xV8i9QrlpEq+DDBDNbFLKOWmzT7RHLd5+X6sVd6lB7CciAWqGotTDnDQ
 5BVjY3q3fpjBjSN5UCYEh1T75BUYHSgRhDYK7/E37CkAO7Fs1TZh9DtP75q7lU7DiI2Q3R61GFE
 1oWSDOgP8Cta4lXEKMwu11II16ZrwVs25At8wLGd2f2gEy/x8NQBiBq8PjlnuHtfF8uG8VAqc5J
 WIgNuiPUopHcvEEersqRPRqqGPsCmfRCeK5dEcmcMF5PQETJhncR73PutDI1fl3HRqmRa0kmyev
 xVlhoMt09aQlsliVXKCbeGzbcA7QzaKl59PktTuE=
X-Received: by 2002:a05:6000:40ca:b0:470:2fb1:3dbc with SMTP id
 ffacd0b85a97d-47f8d7566c4mr2152212f8f.35.1784789705230; 
 Wed, 22 Jul 2026 23:55:05 -0700 (PDT)
X-Received: by 2002:a05:6000:40ca:b0:470:2fb1:3dbc with SMTP id
 ffacd0b85a97d-47f8d7566c4mr2152183f8f.35.1784789704788; 
 Wed, 22 Jul 2026 23:55:04 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47f85b9a659sm13295005f8f.6.2026.07.22.23.55.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 22 Jul 2026 23:55:04 -0700 (PDT)
Message-ID: <40175d61-af27-4c29-98cb-746c2898aa47@redhat.com>
Date: Thu, 23 Jul 2026 08:55:02 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/region: Clarify dma-buf failure messages
To: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, Nicolin Chen <nicolinc@nvidia.com>
References: <20260715070622.198400-1-clg@redhat.com>
 <e74d05ed-913f-4b24-94d3-6a2442073848@tls.msk.ru>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <e74d05ed-913f-4b24-94d3-6a2442073848@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: permerror client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On 7/22/26 23:29, Michael Tokarev wrote:
> On 7/15/26 10:06, Cédric Le Goater wrote:
>> The dma-buf failure messages in vfio_region_create_dma_buf() say "PCI
>> BAR IOMMU mappings may fail", which suggests the BAR is broken. In
>> practice, only P2P DMA is affected -- normal passthrough uses the mmap
>> fallback.
>>
>> Reword both messages to mention P2P DMA explicitly and clarify that
>> the mmap fallback is in use. Use warn_report_err_once() at the call
>> site so per-BAR repetition on mdev devices is suppressed.
>>
>> Fixes: dcf1b77e834d ("hw/vfio/region: Create dmabuf for PCI BAR per region")
> 
> FWIW (it's applied to master branch already), this is commit 8cfaf22668c,
> not dcf1b77e834d.
> 
My bad, dcf1b77e834d is the same commit in an old local vfio-next branch :/
I sent a scripts/checkpatch update to catch these.

Thanks,

C.


