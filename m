Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A31FC83F1A
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Jul 2025 08:02:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1udlSX-0001Lq-6x; Mon, 21 Jul 2025 04:01:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1udlS6-000146-UD
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:01:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1udlS4-000519-IC
 for qemu-devel@nongnu.org; Mon, 21 Jul 2025 04:00:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753084845;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=RvUVvsrRdJY4X3WrO0wucdHCzJn0ATdzaV5RnRjDM3U=;
 b=SkGrvxrgF9Fs3ASWFiPykcEC2xNKGLCC0yrjFsdELBFVEo8TTznJaC7FP6S+t5ag0bWFre
 WUls/163oJBUkj6XpGRq0HrcouXB0qrKJ4+Jv7pZuNdan9lo1r6G311Z2QZVOsJe01uD1t
 wE40vtVK64aAH19AjVMizTosmMPWS1I=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-lxfKo5XuPq2KqC2P6gU96g-1; Mon, 21 Jul 2025 04:00:43 -0400
X-MC-Unique: lxfKo5XuPq2KqC2P6gU96g-1
X-Mimecast-MFC-AGG-ID: lxfKo5XuPq2KqC2P6gU96g_1753084842
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-456267c79deso12786955e9.1
 for <qemu-devel@nongnu.org>; Mon, 21 Jul 2025 01:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753084842; x=1753689642;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=RvUVvsrRdJY4X3WrO0wucdHCzJn0ATdzaV5RnRjDM3U=;
 b=lLSTj/6iOGQdNc+MK2dzoohOL+dTyojKY/LwGOPmiSQ0qaSCAXR+m7YQMFn/skjl3z
 qN0hVWawdC9W1G0i00JVW0rCoGgQoc7zKP7sTFo54yYoqcVDTzjwKYg2wfTLity9dTNK
 R3YzzAPR3fc5i1z8PXuZ1ZUc2B2dz5QVGTpDRCNyKwezmgLzQsi/VzD3KkU+t4wauufN
 Y8xJf1CXm0BTpmWpOYVD1S3NItgDl5AUG3H3OAPckN2qu+Y+JodWxwLqwjfv1vFTYtra
 Y6rXDsuksGVyUBMND02k38H43sRW+8gFJJ9A2Eb+h1NhXT2c/zaySXEJT5XLckiFUNOr
 yb4Q==
X-Gm-Message-State: AOJu0Yza2EW0EeBHzG5DopJm4jIiG+1MRiK4zbsNk62cnbgSNlLNox0v
 f1TTRNxb91eF6ly23zfs+hd2HpxIZmynMcvSmsSZ/kdITl79Jm6d5DHRtkW5FzBL4hlFF7xCHgw
 W7HIOl1JOK6Eyrn4CaPz1LZxNj8x5KNq2gP7DYpzV8WcC/c7WuLrBbpSL
X-Gm-Gg: ASbGncshoFzpaId3R3fFBSCZ09/tjLNlhQIZXma9R2oJz3X6Bpa2x6DJojvjKsy0Ukh
 i5lVIzqUIZp95UnMB8urtwjQo0cQBfaTl6sfyxj6iRUvDj1KWBBb3cQZJaTuRKcW1GnI+MJCit+
 plX+gOLUsP8e77Xg8x9y14Ns0y4b3WAB32Fpg5q5S+aEym2p00zN0Us8sib9f3WPXn0RTwZBVcX
 ETLjZE+YInazFgLbU+2a5pZb03HK5M63FBFPo2rtFqLmoX+PyH6pMnViB0q84zT8VBkghJSKQYC
 fOptjlRZ6S8r52nEOl41+IOMP8SFAzC6T/UPiBIWkP7+RtkLXPMSgVqTOTttLwRgaqOC3gRS1lr
 sx4Hi2dg5oMeHtU6wQibzL1oqI9Nkhg5tx3i2Sk/xJTkdwRsn9guOYxXfWywqgzxW
X-Received: by 2002:a05:600c:3549:b0:453:6b3a:6c06 with SMTP id
 5b1f17b1804b1-4562e3caa4amr157635465e9.29.1753084842090; 
 Mon, 21 Jul 2025 01:00:42 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFOLdUt8FiZDNHQlQyuCDo7hMkIQTneJsklEIftzYwEcg42yHjOWU9K9HieQLQhc03JP1OTxA==
X-Received: by 2002:a05:600c:3549:b0:453:6b3a:6c06 with SMTP id
 5b1f17b1804b1-4562e3caa4amr157634965e9.29.1753084841522; 
 Mon, 21 Jul 2025 01:00:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4c:df00:a9f5:b75b:33c:a17f?
 (p200300d82f4cdf00a9f5b75b033ca17f.dip0.t-ipconnect.de.
 [2003:d8:2f4c:df00:a9f5:b75b:33c:a17f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4562e819e04sm152666685e9.18.2025.07.21.01.00.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Jul 2025 01:00:41 -0700 (PDT)
Message-ID: <4a599699-e02b-4424-bd20-70604df02061@redhat.com>
Date: Mon, 21 Jul 2025 10:00:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hostmem/shm: Allow shm memory backend serve as shared
 memory for coco-VMs
To: Xiaoyao Li <xiaoyao.li@intel.com>, Igor Mammedov <imammedo@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>
References: <20250721065220.895606-1-xiaoyao.li@intel.com>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 g3eXuA==
Organization: Red Hat
In-Reply-To: <20250721065220.895606-1-xiaoyao.li@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 21.07.25 08:52, Xiaoyao Li wrote:
> shm can surely serve as the shared memory for coco-VMs. But currently it
> doesn't check the backend->guest_memfd to pass down the RAM_GUEST_MEMFD
> flag. It leads to failure when creating coco-VMs (e.g., TDX guest) which
> require private mmeory.
> 
> Set and pass down RAM_GUEST_MEMFD when backend->guest_memfd is true, to
> allow shm memory backend serve as shared memory for coco-VMs.
> 
> cc: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Xiaoyao Li <xiaoyao.li@intel.com>

Acked-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


