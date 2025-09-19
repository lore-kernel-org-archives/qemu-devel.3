Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D993DCAC592
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:28:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzaCz-0008DQ-F7; Fri, 19 Sep 2025 08:27:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzaCt-0008D5-Vs
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:27:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1uzaCl-0004rE-Kp
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:27:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758284824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=kko7r7oKaVMG8Jcy4RfuU7lS7PJ2NuY0cvbKkQyhYbU=;
 b=UyQKCPTm1cPGwLG6cAYfRNtUTjH0GuvVV7GUgt3m74S4Qr0pDs9VuTJEA6M5hfBMIOYzZG
 ifp3W+3yy01rElRsX32vR3ikO+lgYZ3iYYpVTkiOncM91fuIuSm4PvHJSccHW/Vqzn3+ql
 8OY3ERT0Yv8XI8MBdvnFG5YPlPqGMqA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-491-mNyQ_xS0NDaVmqumQ1vx8w-1; Fri, 19 Sep 2025 08:27:03 -0400
X-MC-Unique: mNyQ_xS0NDaVmqumQ1vx8w-1
X-Mimecast-MFC-AGG-ID: mNyQ_xS0NDaVmqumQ1vx8w_1758284822
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3efe4fcc9ccso432298f8f.3
 for <qemu-devel@nongnu.org>; Fri, 19 Sep 2025 05:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758284822; x=1758889622;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kko7r7oKaVMG8Jcy4RfuU7lS7PJ2NuY0cvbKkQyhYbU=;
 b=UYNqmE57dv43j5ZwnNULj4mjxHvz48hCNH6GnxAsp2UwXIQzEHOAIrOk3hGTpMrcIL
 FT/pgvjt1iBDuABbqjYLjE26Py0H+Z+MKu1XaSjfzbn6VelsIWMGBwdiUj9NPjtjMIre
 2gxZTAtC8ka/OuTvXn1hMy0Bl7R1SVwYD24Yo+uPxuqxhjZHcFAzT6E5ni7IUmZG49b6
 /CJXdcLZyBwZ2vhh6ZweIpordd8cHSLO9TTlDpI2RIX2C8mcvHG9inmXLcAuaK5Oi5Yi
 EihZCaK12zUWIozPyV/weD/a30S93zvO9Msy9nQOAihZcrJq4BpRLlRTl6DY/m+2MsCB
 UPNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0eJSKNX1tihT5sPvjZ1EFcxTjdYUNKdO6yu8Zn9WDBf2oopl+l8t0yiwCfukE/YfuLPiEvBn/GtjO@nongnu.org
X-Gm-Message-State: AOJu0YyTFSa2g8Y/536YCqy9cg3R0zFW6GwiM0L7dhD6hAeYZWtI3R9d
 CjhGsNppGAjCizNzl87Ra9ItijHBqliOXxx9Go9v+FSc+kk0nIetaNmVdzmMGjou+L6p28iM9Aj
 UdLWch1UUM2GuDM7kTONM7n8TetVi/hqd5vT9+J/A2BHIIS+DZi+AQqNA
X-Gm-Gg: ASbGncsZ9E/Rea1jMqc1WjZ9pPR0r3k416nDaVjKbvpSuiwWh5gnnQExB61Grm0E5MX
 DbcbQg9W/mogQrYuhuzEWQ2qqsOurP6+BECQBK7x1QpEx6E5voYLikoJpbOJ+ZXAYyxuUaIzjx+
 Wl8OMqCHXs+J9gkVFT1hKCP0sVyddawSBUPKqgjbWEwcrxpaROWsW7uKJHWOiD1fe2Hy1/8OwuF
 r2ZL3mkj8PNT4+POhkNq6lIv/nqoyu2blnY0UHikYN+aVWHkbFrHJlbUP8BvCABuGuYS+kuC6KQ
 cfR/xafsWxcacCv5lL+LM+DY03MWGrMEMflDCrRLsBYmVH/2B/+5WDnkXWk/Bs+9MqMK19PBLVj
 cS3L9Vw==
X-Received: by 2002:a05:6000:144f:b0:3ed:e1d8:bd68 with SMTP id
 ffacd0b85a97d-3ee7c552a3dmr2625561f8f.7.1758284822137; 
 Fri, 19 Sep 2025 05:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGTMGzhQJ7McoCdQH39oHHduUU33QVhcznF71hu9trfsC8iLNpoF36MNLfv0be8c0Eiw1U2TQ==
X-Received: by 2002:a05:6000:144f:b0:3ed:e1d8:bd68 with SMTP id
 ffacd0b85a97d-3ee7c552a3dmr2625535f8f.7.1758284821746; 
 Fri, 19 Sep 2025 05:27:01 -0700 (PDT)
Received: from [192.168.0.7] (ltea-047-064-113-218.pools.arcor-ip.net.
 [47.64.113.218]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee0fbfedd6sm7837149f8f.60.2025.09.19.05.27.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 19 Sep 2025 05:27:01 -0700 (PDT)
Message-ID: <6a54ffea-fe5b-43fa-b0ab-806584e2ed87@redhat.com>
Date: Fri, 19 Sep 2025 14:27:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] docs: use the pyvenv version of Meson
To: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Cc: berrange@redhat.com
References: <20250919083621.86615-1-pbonzini@redhat.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250919083621.86615-1-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 19/09/2025 10.36, Paolo Bonzini wrote:
> The version in the system might be too old for QEMU; this will be
> especially true if Rust is going to be enabled by default.
> 
> Adjust the docs to suggest using pyvenv/bin/meson.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>   docs/devel/build-system.rst | 2 +-
>   docs/devel/rust.rst         | 2 +-
>   docs/system/devices/igb.rst | 2 +-
>   3 files changed, 3 insertions(+), 3 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>


