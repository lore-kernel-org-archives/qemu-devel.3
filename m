Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8B363FF885E
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Apr 2026 10:04:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHIoN-0004fm-7f; Mon, 27 Apr 2026 06:03:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHIo0-0004es-8K
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:03:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wHInx-0001GJ-UZ
 for qemu-devel@nongnu.org; Mon, 27 Apr 2026 06:03:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777284183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=UPP0emTi32YmHA+FIh2cIPMv+2JnoEhqfyD+roGN62I=;
 b=OqOKxz0HjCl74twUcw+Dy51pqLDuB967VKJuXckFKZ8h/IO1RDq6hTMg6X5bLwDHhgmCXi
 tD5/AnYgBFykGi9JjXFvatXacAp1dm62IwBoHNHSRpQ8d600dh6lhlTwpjqvuN5LjLxPhx
 /JZ+nbSlcw4RK/Ov6cdy8vAI4MB+0q8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-52-fWD8UzTFOAu02eOxB_eSAg-1; Mon, 27 Apr 2026 06:03:02 -0400
X-MC-Unique: fWD8UzTFOAu02eOxB_eSAg-1
X-Mimecast-MFC-AGG-ID: fWD8UzTFOAu02eOxB_eSAg_1777284181
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso109622615e9.1
 for <qemu-devel@nongnu.org>; Mon, 27 Apr 2026 03:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777284181; x=1777888981; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=UPP0emTi32YmHA+FIh2cIPMv+2JnoEhqfyD+roGN62I=;
 b=XD20Mg30cUxqQwFzailMzQYfBcgWZUeLrJN0uJM2EynCjioVaKs/BAfoVkkVltUEPD
 PFdut3rJtLWnDHgRqCwXnI/tElJDKUgZjK0c3i8U+fBcSXT3BobPCYStoDnCF7oEEGHn
 JXkeOy4mbqaf1r4+Kh2SJepyDeS6b0E7jdge8xbW4msWcLorE2xbauGuo1P9/Trgo5nP
 WGrrtUkQrAGfBI+DBAZ2dg3+yE60CVVCLW4ja2PWBzkis5UBqDSyek4LO/phRX9iTu+t
 qpknvzBlEB4Xm+idNiMv6+l3DwCz3eWNneIzERvxgsYiHOXFmVy7H8lSWl+CKAYthVlh
 l5CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777284181; x=1777888981;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UPP0emTi32YmHA+FIh2cIPMv+2JnoEhqfyD+roGN62I=;
 b=iWBw3zrxltcmJV6auNwlDtrl8yjKRRHrX5w+QFY87MqUolQ76ROLlCDi7g1IGAnnZW
 ih4vfE/MfS18Ks7gm6apVAJX5wqBwnHYRIPVeNQKIFSKNrefQp4KV3o2S+b7PUpCtil7
 cCt51F1yJVhODOuLrrpeAekH3fjxU2dB5sGrd2IkbaXJO3MIjCcos+e4GaskpxKHCbsL
 BC7mXEfz1Klvj4iN2Vcmzk2/dXAr9VaE0xcl9PON3DvMfQkS3bYvbuJWIDM0blPQ7zPE
 tsvhOOvrR8BzkBalJT4LTo3oL32EJnvYSDxFQen1tFJJfM71NJr+5i2xhjyXJAVqnTpV
 vrGg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8p0pws+o9gb67/vl6dz0uZ3B9CtzqCh4ZJO3qCXyvXnysqjKr8u57eUzNFywkrbJvohvtKLuY8/1Sq@nongnu.org
X-Gm-Message-State: AOJu0Yw7Ie4owTdCoK20MB9WJybuCgs7tsQRE08Qa16ypNrd9L4JWzOz
 8mPGteQlKeNBLDeMeHhbTL/0T5Sh9mj9ElttXmWA9LsFByU20LJGocxhvOPLMMObsYoZuipdwdS
 9uyd8F044UohP+HPXlabx6JGmeccoSPxXOm7UZZKqYiDh9C/EHANkARXo
X-Gm-Gg: AeBDieuU7S8ycFOMf8Lnmernoiq19cb28SjRsUOLKfg7mFckBZm2pf+YDOjpnUjjUjJ
 BHgR+ffDgHTamseE+IBKpz4IpClzwPE8JY1kLX7ARDOVNfysKVjrbamTx5Zr9/XM6zTQBI02D7R
 ADpUBRHTIdDOQbYt4TbupDoWq0Iol0lxakcAugHN8jrTD+0cUOChZhe/h72zG7sC08UHiMAvNW/
 kcaL8ZWE1O50DUjN3C7f7imNJubSE3lFwCk+PNNWF7lW4riRP3RpSxm3xQfjMfWK1pf/udXpOmP
 daItUvKjDcXHeSAWhCakJNhlV7Viv74RPmo2y+06K5F5gZNSU8hIemavZy2V811NNSlLybT4v4H
 FNzv5TQt3/gNJUp4jc7pKaIaiRWq72w==
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48a53ea1500mr314684205e9.2.1777284180476; 
 Mon, 27 Apr 2026 03:03:00 -0700 (PDT)
X-Received: by 2002:a05:600c:859a:b0:48a:53ea:13df with SMTP id
 5b1f17b1804b1-48a53ea1500mr314683745e9.2.1777284179793; 
 Mon, 27 Apr 2026 03:02:59 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.114.147])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a5aa3ae83sm791591055e9.12.2026.04.27.03.02.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 27 Apr 2026 03:02:59 -0700 (PDT)
Message-ID: <883bd7fd-a9e2-49e3-9198-8333825f8aa1@redhat.com>
Date: Mon, 27 Apr 2026 12:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/i386/fw_cfg: Use g_new() and g_new0() instead of
 g_malloc()
To: Sourish Dutta Sharma <sourishduttasharma770@gmail.com>,
 qemu-devel@nongnu.org
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, eduardo@habkost.net,
 mst@redhat.com, marcel.apfelbaum@gmail.com
References: <20260224160020.137036-1-sourishduttasharma770@gmail.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260224160020.137036-1-sourishduttasharma770@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

On 24/02/2026 17.00, Sourish Dutta Sharma wrote:
> Replace g_malloc() and g_malloc0() calls that calculate the allocation
> size using sizeof() with the type-safe g_new() and g_new0() macros.
> 
> This aligns the code with QEMU's coding style guidelines, improving
> readability and protecting against potential integer overflow
> vulnerabilities when allocating arrays.
> 
> Signed-off-by: Sourish Duttta Sharma  <sourishduttasharma770@gmail.com>
> ---
>   hw/i386/fw_cfg.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)

  Hi!

Thanks for your patch! FWIW, fw_cfg is not really my turf, but since I was 
looking into malloc() related patches today, I noticed your patch which 
seems to have fallen through the cracks (sorry for this!), so I picked it up 
and added it to my latest pull request.

  Regards,
   Thomas


