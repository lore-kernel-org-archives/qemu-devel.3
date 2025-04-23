Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C940DC369D5
	for <qemu-devel@archiver.kernel.org>; Wed, 23 Apr 2025 11:50:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u7Ybc-00051S-8c; Wed, 23 Apr 2025 07:49:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u7YbU-0004tQ-Pd
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:49:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <david@redhat.com>) id 1u7Yah-0005fu-Ab
 for qemu-devel@nongnu.org; Wed, 23 Apr 2025 07:49:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745408912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=khXWl6B86EFh/TlgxGYc/PyZsDXAO1W4jUzSwpmpsAA=;
 b=KKMFO8Z/Hz7lKQdVPiKsyJ/rLkPZiJ7lhpEkMeCYWv4RRgjCcKiPdrwLhn/2j3dBj63VCt
 1ez9wUhwG0StQN5DS64EaJR88r1FeoUsTTaryxEX1YyCE7cOERqaIHEr6mPfYjBxM8mLpZ
 UoeQIB07MZQ6jEgG4i+U14x4kx6JhMM=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-cU0TuztYNpmRj0f-wBuPMQ-1; Wed, 23 Apr 2025 07:48:30 -0400
X-MC-Unique: cU0TuztYNpmRj0f-wBuPMQ-1
X-Mimecast-MFC-AGG-ID: cU0TuztYNpmRj0f-wBuPMQ_1745408909
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-43efa869b0aso40118785e9.3
 for <qemu-devel@nongnu.org>; Wed, 23 Apr 2025 04:48:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745408909; x=1746013709;
 h=content-transfer-encoding:in-reply-to:organization:autocrypt
 :content-language:from:references:cc:to:subject:user-agent
 :mime-version:date:message-id:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to;
 bh=khXWl6B86EFh/TlgxGYc/PyZsDXAO1W4jUzSwpmpsAA=;
 b=Q/SQggPYfSI9D7Wo38ljtCinYy6xsxXtw9F5MBq8Ku/OYkhGWspMG8rZhF/c5DrwfC
 rGQQtIjpORb+7ugJkx2cMabzu7z1pULAuu2tI9me/MttRDUE97rsgyhie0UvnzaGYRO8
 O+kx1WwiLT1fuJpzVrIs2XjuHS2U+1ec/zRRj38R5A3lDsZpLY0eCJoMZYs1o0il+hcd
 CA82BOoP7UmjXGTMPnb+yDyClkTKUcdHbFvRjZBSQ+S/DbQFE9GOsrOwUVv0M6Zo/wAm
 h8ch1ohJBztdo67yyOYIaIQhp6CSd4mDkn23alrkIgQAL3WFdo4WO+/SxHCpg6PteLjI
 kEUg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXkoSlwxbuaRfLk+tlRUvldWIo4NsOhBpObINpxQZh06q4frBcxHqRpiIpVL46u7qwdIOWwdcSGWlYI@nongnu.org
X-Gm-Message-State: AOJu0YwJ5VdF0Nq0HCRQXo5I5OWUv/UGX0zqn/zr8K4li2E5/cLHU371
 Ws8nvj+N1veFJ9JxAx+kqm4sCOwggAMmC9+jQsnSIgF/81OPFTXQi7/6w40kT8RvZNddMrhyH4o
 MndB45F6btMBasVEDlvrTuPdflwD/13bYau8Qf24a3Zgx6ORgq+WD
X-Gm-Gg: ASbGncsbpJzKxcJdNuMjEsjPcWTy+lBZituOKWl7O7QNql/aecuYjN01wm6bTILhyZz
 /nNFFUO8BIGMa8F9uvBP46AtvXCX+NcDgfOPGwnRFp9r2AlMOhRyGHWckqBpdWMxDOIsSDipNqw
 wyGD+GANpZlHE1RYbLg2dF5MR66jNp4ZCYymSgPCz9rU6mOPAkYfazjvdQf1mvLwXEFMqBv+gm0
 9nuWRtCNpJAc00tbVW6uYYF9N3oKIFeDkCNReRVCD8Y6Gzs8lgQTCqe5olc6TsqOsg775aSSsjK
 3HWAIz8qK1q7774z9UaZkRSUYxZWD0OcErK1R20x+ks5Yesefd50TOu6CVAm0B89qvIe1zVHWeK
 jeia/PfK5Rx/cWAVW5kSAZ5x1Hj7bQ7VUumXPrbY=
X-Received: by 2002:a05:600c:c0f:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-4406ab93badmr169202055e9.12.1745408909009; 
 Wed, 23 Apr 2025 04:48:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdhc/f9dPX98i6Hk8VXyf0TCbwVwFTu6FwvjfQ9/Hqa+yhqsgfx6VSZcG6zueR2XMtp8ZY4w==
X-Received: by 2002:a05:600c:c0f:b0:43d:7588:6688 with SMTP id
 5b1f17b1804b1-4406ab93badmr169201875e9.12.1745408908613; 
 Wed, 23 Apr 2025 04:48:28 -0700 (PDT)
Received: from ?IPV6:2003:cb:c740:2c00:d977:12ba:dad2:a87f?
 (p200300cbc7402c00d97712badad2a87f.dip0.t-ipconnect.de.
 [2003:cb:c740:2c00:d977:12ba:dad2:a87f])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-44092d40392sm23452585e9.36.2025.04.23.04.48.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 23 Apr 2025 04:48:28 -0700 (PDT)
Message-ID: <19530452-035e-4c3f-9678-51d2200a3ed2@redhat.com>
Date: Wed, 23 Apr 2025 13:48:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] system/memory: Remove DEVICE_HOST_ENDIAN definition
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>
References: <20250423111625.10424-1-philmd@linaro.org>
From: David Hildenbrand <david@redhat.com>
Content-Language: en-US
Autocrypt: addr=david@redhat.com; keydata=
 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
 WNyWQQ==
Organization: Red Hat
In-Reply-To: <20250423111625.10424-1-philmd@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=david@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.294,
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

On 23.04.25 13:16, Philippe Mathieu-Daudé wrote:
> Since the previous commit ("exec/memory.h: make devend_memop
> "target defines" agnostic") there is a single use of the
> DEVICE_HOST_ENDIAN definition in ram_device_mem_ops: inline
> it and remove its definition altogether.
> 
> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> ---

Reviewed-by: David Hildenbrand <david@redhat.com>

-- 
Cheers,

David / dhildenb


