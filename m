Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEF93D12D69
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 14:29:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQnqs-0001vG-Fc; Wed, 03 Dec 2025 09:29:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQnqm-0001v0-Ox
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:29:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1vQnqk-0007PI-HM
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 09:28:59 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764772137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=DGHwVC4Il10y0qGamHdnaam8Wq865+aZcADabZ7CxJQ=;
 b=WbDIArFm4JUpLb+4G9LIsIt5+Fx6TcMm9kbsDKBI8sr0UhU9HAAnCbDk0ddv7GQKnS6g/I
 5UWb4lkUJL12Fio3gKkwdCAl3NRoA8ALDKZP9oeECsW6i9VgZN+6t2m9zb46gGnGxRWCq8
 +Sc0XD4judpei0eLUWOj9kcFNRuaX9Y=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-304-ed0BbbwAOcOgLHIT-zjFRA-1; Wed, 03 Dec 2025 09:28:55 -0500
X-MC-Unique: ed0BbbwAOcOgLHIT-zjFRA-1
X-Mimecast-MFC-AGG-ID: ed0BbbwAOcOgLHIT-zjFRA_1764772134
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so4912947f8f.3
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 06:28:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764772134; x=1765376934; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=DGHwVC4Il10y0qGamHdnaam8Wq865+aZcADabZ7CxJQ=;
 b=cltZiK3PArzAYd4yKmJF3+HFhTl8S1AC6jVt8jB4gfwM3EfGEMvSO9ndko6B2x/Y67
 PF/yhxFIhCobh7S3bnA2Z2uojyAZOdTjFYsAixttX0Q5jNiMSFQjKkGjHuD9zAIIsbxH
 S6JnmIURnqSdORIYXeymvjeVNggZXc8R8tHF4Ai4QHCmRbiA+7pv3Xm3tnM86oYn9Ons
 ZvsMgXfPlHDNWPHSZxzMO0DT99q4mwJf3gR73fZxYsV+9lfUFhRJ8cpcVE+pXq4UVCbY
 o706rHiyGYapErm0II4DPpCqtiFQq/M5W64YHNWmshS2cVsyzro0Y48R1OZcz2/ytTKk
 kveg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764772134; x=1765376934;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DGHwVC4Il10y0qGamHdnaam8Wq865+aZcADabZ7CxJQ=;
 b=K/hDWasFNBRQ6nhJp7Yp//X2rz2vEUNY1meAOnsFYHFCk3tHU0/aZoxF0RjIWvUTHB
 EF3UiTW/MZoBB740zeEKzmcxI/rYJv4HKj8+TFJejgmnxBUiNOK6Fkv1Vv4wAxrlRzQm
 cB9+QrTeW892OT2VXJU58tuzeUWFx86oaiv9Lq9ismOYDzx5PE5bsNEk6mZaqWQ44MGJ
 tPTl38lviQ0vFc0ICWbUI+nvK8WFpKZqh8MBwKFse7CTle6+MjchAY77t5RWNgmu1OsT
 5MVMmP1tvAxhNd5+W8Epp6pqW1VzVc/YKOIiMRoz1oFOou9/OeSlEomlvW0T3s8xjSM6
 bNYw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVfZpk59w2CTh/7O1wMGEFQU/xGsR0E6HSu7NcWTKLg5mvh5xzLZWL7QMqID9sD7CaB4AINiBLtcpYJ@nongnu.org
X-Gm-Message-State: AOJu0YzRM2I9AeQzMCRsopTbN+opbbIlI034+QLf7ZQNLeZH4n/pUklH
 eIU+vd36i2Hyv6ZQLR0BzJLFR9IdGDKwY/AlnO+8HL6qBAqTAlQgq5CQYNyq5YDWxub9AZ2GJpN
 w+mAycLqWQDrB4lXo3Ji0aipkAVk0MkQhZxasEVUiCuvfJHMUtABbrh8q
X-Gm-Gg: ASbGncut+lv4pGZTbG7Zms3zjv3ImWmtXLgYLB+MfGKeXt3dvbZVQtSb2KMJmIJALhZ
 NRTgusXIPjX+EWnqXEWFsiO7n9u64b7wf3eb2xPeITSOVFSftSFPdoLTSbC5rKCOkJrPv6/xw4i
 vcaugH0Spr8Cz0Fd+KUdx4dnzXhNt6EZ8mLSbC4+pk8DLQeinRWIVNDS23P5CkrDjBJTdRGJKwJ
 XCpJ5biIkfo8SsJqikDpbRe/cJ3+7AxtILCHD8arH0C0g4ciAXuMA/rVPEU3q02XjWA5BdKtDxx
 QUe8LvWM3MOcU4RjyP2yVhtx+pDTsvl6EJpkS/QDc+581lVf709leKrS0TfdstZkLXFAVPRU9BW
 Df/aj+jBh2nf6Ar92DrgZ8UvXocJgseP2ZjTHPPKTJN3M6vdf
X-Received: by 2002:a05:6000:25c4:b0:429:cda2:9ffd with SMTP id
 ffacd0b85a97d-42f7317773fmr2644760f8f.9.1764772134437; 
 Wed, 03 Dec 2025 06:28:54 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGgaQ+nlAH2DK6B9g4NPiH81/DxM34h9JUTpdvGcSQU8kvVuw3RdSwoZNvqsGW61+axo5WoOw==
X-Received: by 2002:a05:6000:25c4:b0:429:cda2:9ffd with SMTP id
 ffacd0b85a97d-42f7317773fmr2644730f8f.9.1764772134057; 
 Wed, 03 Dec 2025 06:28:54 -0800 (PST)
Received: from ?IPV6:2a01:e0a:280:24f0:9db0:474c:ff43:9f5c?
 ([2a01:e0a:280:24f0:9db0:474c:ff43:9f5c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42e1c5e3857sm40617541f8f.19.2025.12.03.06.28.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 03 Dec 2025 06:28:53 -0800 (PST)
Message-ID: <91a9a8d6-465a-47b6-8f42-ff07d98f9cad@redhat.com>
Date: Wed, 3 Dec 2025 15:28:53 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 0/5] vfio-user coverity fixes
To: John Levon <john.levon@nutanix.com>, qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20251203100316.3604456-1-john.levon@nutanix.com>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <20251203100316.3604456-1-john.levon@nutanix.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/3/25 11:03, John Levon wrote:
> Fix some coverity-reported issues with error handling in vfio-user message
> processing.
> 
> John Levon (5):
>    vfio-user: simplify vfio_user_process()
>    vfio-user: clarify partial message handling
>    vfio-user: refactor out header handling
>    vfio-user: simplify vfio_user_recv_one()
>    vfio-user: recycle msg on failure
> 
>   hw/vfio-user/proxy.c | 206 ++++++++++++++++++++++++-------------------
>   1 file changed, 114 insertions(+), 92 deletions(-)
> 


Applied to vfio-next.

Thanks,

C.



