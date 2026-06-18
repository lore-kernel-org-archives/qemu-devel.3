Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92AA0CD98ED
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Jun 2026 10:36:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1waA72-0005f0-L2; Thu, 18 Jun 2026 06:36:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1waA6s-0005Zk-Ts
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:36:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1waA6o-0008Q6-VG
 for qemu-devel@nongnu.org; Thu, 18 Jun 2026 06:36:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781778989;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=rR4k7wyAmZP5QefkjdX36fHIsopUiqJNEsSxb5wU3zY=;
 b=GqaEDJyy4w1M+fbyYJed/hSwPtZIjqi6zeEFFgrpn5PX0YlFCUE1mlHZAvcojUA01b6YZa
 BmBSPDy54db2vwcc8olQsl73X0Qxi9NnycIZq1KUkcO6H1JI3Jf72+ltJg+EvdblIWMAdq
 Nim96hE8mbIVLnKXLCqVX++V5gU1yD4=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-434-QaJvRGKTNn-Ak_XFI5b69Q-1; Thu, 18 Jun 2026 06:36:27 -0400
X-MC-Unique: QaJvRGKTNn-Ak_XFI5b69Q-1
X-Mimecast-MFC-AGG-ID: QaJvRGKTNn-Ak_XFI5b69Q_1781778987
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-45efb6e60e4so858300f8f.0
 for <qemu-devel@nongnu.org>; Thu, 18 Jun 2026 03:36:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781778986; x=1782383786; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=rR4k7wyAmZP5QefkjdX36fHIsopUiqJNEsSxb5wU3zY=;
 b=KtoUJe4n+WNjTXH1oW5ue9EViTrNMVD4iFz5wMIOT3Cgjq9GCmY9itIPKYLT4c7dH8
 5SVFm92BvBFXxlfdsmC4AtgOKn9hYcP9LOwnSVx55RIhY21OV7D96GBrxe0Y3X0DM1Rh
 DUcAiXLyoEEF13sMpimGhdkbT9PHI0BMLXUKYcQjMg/3WUKjugu6b3eJRaWrccLRolUS
 WPoVhp4Df43EIER6c8fiyxMb42ylLLD2mP+g1bqTd+/L6f6+tX6LaqZmixsRsTdYtqN7
 FNoiVVDyzCAxoi+C8BY8Q9jFYoDyBUTitJEEux6aU3VGCXjSwVNmznC5Eb5A1E6FVcLS
 vfWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781778986; x=1782383786;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rR4k7wyAmZP5QefkjdX36fHIsopUiqJNEsSxb5wU3zY=;
 b=MC7amtKVCf0aVfjO5lkv8V+NqzdcRCM95n/96rpUYtPxxOojiDyck2H783J+pVe5sY
 VoyMHB/gKySwLvox7LWtZWy56SxuIgW4NHYxWEzER3d9ZRDukQR5WCsKqWpACZ9266dt
 oYuNBsrd9yDbQskb55VA/AZ+0YeRTc9SC9e3zfkyeywmOShP2sR/u3scvw1LLclxJu3/
 NEXmJiV9elyVvMuK9pKwAKM7gWEZvUkxT3TBn+TGJCBkvZPPS5nsDHbXQqvphxPn5XEs
 MSZmqahS8kDI/eOkPl/nWHUY40a9uvt8Lo+7ejsp32/paqAmNNJ2IDywf5SpztTHKy63
 y+wA==
X-Forwarded-Encrypted: i=1;
 AFNElJ9vNq5uwQ8pZr4Ye8Yz0Ejy6XdGcCLgrHsBaqqkhkxSDJ8By7O0k86q3bnVRc1FmGXTq8ucJ8U+Q2Cd@nongnu.org
X-Gm-Message-State: AOJu0YycjlS/sXmOCJBZ8t/G/KlvAtokaUoY0NztuahKb73EJtxB84S6
 lbP3wonpHqX3CWTg9tFCgPw1xfygj+bn8AyJeZNfBCZx4GcEFaoi6h1W8KtMjBQgJqrvRj7A81w
 jfcyN+yTYwEOa7VwVEVDXga+o9M8muTOFZD3xHQU2/iuMU8AZe5eS0XX7
X-Gm-Gg: AfdE7cm9s+a66Nvl0zLAGmrcVdRoaAk76koInYDDNWUJX0j+e2SlkJ1zppP26KJ8zYH
 OR8avOCNZ/B8HgQNuJgAECJCK1iBUux5w6XhzfTnnjAxdrZuJfeWLKxQY4sLGKqJPL5CTgj937y
 P99e00OqP77bgg8YBXkNImB0A0dHknGvI4J9wU8IzKtKJalKx/saVJiCGGi/FaqSqsZPdXg8FDr
 5MCS16FI5eI0i3qpe2TS/LVdt+GAKi+SZB9MwgNZ998I3byv2TMw2uim8PbdJUoSslnqOoXsX2n
 jKYppSVOm629ZRvdyfDmwga5e2/hBOyMTP66kGF7JicOD55Wwfol9d7BvNQ//nciwDP94BlwKHJ
 JQg/0j+Lx7I64oEKGEPzP3JTaWEjqZ3zqI+eGESxSkP+W4NtGlQ==
X-Received: by 2002:a05:600c:5290:b0:492:172f:a2d4 with SMTP id
 5b1f17b1804b1-492381f1351mr50765365e9.14.1781778986466; 
 Thu, 18 Jun 2026 03:36:26 -0700 (PDT)
X-Received: by 2002:a05:600c:5290:b0:492:172f:a2d4 with SMTP id
 5b1f17b1804b1-492381f1351mr50764935e9.14.1781778986099; 
 Thu, 18 Jun 2026 03:36:26 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26f309sm57120025f8f.14.2026.06.18.03.36.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 18 Jun 2026 03:36:25 -0700 (PDT)
Message-ID: <eb18acc2-7e4d-4a3b-8111-7cef86e360bb@redhat.com>
Date: Thu, 18 Jun 2026 12:36:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/7] vfio/igd: Fix garbled screen on IGD passthrough
 with legacy VBIOS
To: K S Maan <kirandeepmaan45@gmail.com>, Tomita Moeko
 <tomitamoeko@gmail.com>, qemu-devel@nongnu.org
Cc: Alex Williamson <alex@shazbot.org>, "Michael S. Tsirkin" <mst@redhat.com>
References: <20260617100646.28326-1-tomitamoeko@gmail.com>
 <9268e0d9-c62b-4b9e-9d7b-d15bb4ecbdde@gmail.com>
 <e4c5461f-3bc6-4796-a142-ac4a2ce7f719@redhat.com>
 <de7a10d2-7f33-468b-af3b-7e0af3887a9d@gmail.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <de7a10d2-7f33-468b-af3b-7e0af3887a9d@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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


> While following issue is unrelated and can be close due to mismatch firmware between host and guest create other problems :
>    https://gitlab.com/qemu-project/qemu/-/work_items/3535

Please do.

Thanks,

C.


