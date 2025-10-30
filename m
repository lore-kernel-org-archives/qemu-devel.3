Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76929CCF9F0
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 10:51:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEQEQ-000430-I9; Thu, 30 Oct 2025 06:50:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEQEP-00042s-Ea
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:50:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vEQEL-00007g-UQ
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 06:50:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761821407;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=TaoAh68AivJBxKW56wL9vQUpB/qY1oVMraW2jGy39LE=;
 b=V2IvaNWjPrxr65Eqwhd2eQPTb+JGR7HhOQgeXHCvpvQmn2kU87ng8ghxM1y7yJZCdP5pth
 +N6UNCH+J3dDhP3ylp/clC2nZWSV9yli1QSrCRIMfsdCbOSDKK8PcvLa/VpOnufWFxBduD
 q7j440yp/wpyWFuAV+UBOBMWeJNJhco=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-363-HZObqgT2PjuqDbcddThDTA-1; Thu, 30 Oct 2025 06:50:03 -0400
X-MC-Unique: HZObqgT2PjuqDbcddThDTA-1
X-Mimecast-MFC-AGG-ID: HZObqgT2PjuqDbcddThDTA_1761821402
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-4284525aecbso561188f8f.1
 for <qemu-devel@nongnu.org>; Thu, 30 Oct 2025 03:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761821402; x=1762426202;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TaoAh68AivJBxKW56wL9vQUpB/qY1oVMraW2jGy39LE=;
 b=YjrVtDwOQy+zPE2rmTlgZe2lsFhV8Us+PapJRNVYiN9EkCy+DJQuiKeUbLDRH+PlL3
 6mtxlM0YP6x0BQiAOqfuIll24jsZsCqNFwIx2pNcV0Kw491vt4Zzr2D+hTj+PqrqxAyW
 RKm2RVAsYDkyZKwK1KgE5zG8Q8+0bz9qKwn3tpkHZrNtZIjxWqnMqRNyHGmmcQmwi0F5
 uqjofWdwz9oswSN6qdi/k9C7qpV5FSrtwAHgbSqZE5WsGxZT66hKF4WJu+Qi24AdvEEn
 JfC9/DJQcYoPI45Je9rGnjjd0Dx+KA3ZX8FXVcJ+eDt1/PqubbNEueoAM0WTbWiGsGuI
 sacQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVO419i9gYzjiTOyjNFj+A9TTCv6MCe7c5y9zb1i5e5jht5hVqqZ/rXyRY9cnthHwlSK4agSlraFbBI@nongnu.org
X-Gm-Message-State: AOJu0YzyrHZSe3Ea8jSvxs6jn6+DuTiJy98AkfUoLG8Q/bGXdJ4WxxhT
 H+r+Vp5razIm92ew6P5qtFSzMgz4SxsKS1yvZak58KIpqv1IbLJ6MsrF/pORYepgqZbvoal1uYt
 4dCm6BjtwGt/GrAZHQQIBVPdnjq9cyN6rbzhNK3xweEwez2Dd3MikV0pl
X-Gm-Gg: ASbGncs5iitDnynjWxxMoTvrDqWbCUtrnaG+knW8M0qFLaS2lKflzN9f6AWOLdp9ppT
 dx+sZD2goHcxaN5Zp4JDATqgvF5E6Q+6ZL4YQlnhIDYpkh97AY8jUi13CapN+79/SA91zTOKAfw
 oNLczr/JHgSC8KpPGBB3L0GZgx6FG7L3JiG415zv2a2flnHlZSvpBXDjid+kb+jkRazRDPbfarj
 JN8aFyPGyk+lax1UwK0mb3bkT97kJkH0dUtEemhivlRkBcxw3h8E7r/q76c5Duathi+RCljxWd5
 RYZRTroEMRP7J+rZMQtBjaJNu0/fc6ccO/GHc/051yZ3oW0sg7SgSYqa0yzxStrGaY3HPAoRSgB
 +xTO0AIrilI9Z4I81YFU9DqEEnLGny+vMLyYwTP0A9gq4edpV22xzwFfFMFKqHgTWaq0c57GP88
 Aza84=
X-Received: by 2002:a05:6000:659:10b0:426:ffaa:8e9c with SMTP id
 ffacd0b85a97d-429aef735dfmr4377154f8f.13.1761821401828; 
 Thu, 30 Oct 2025 03:50:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFZlNpOSvJd8ldrLjCjFofXVQIATqPeKXdzSYbhIqgNoRuG8BmwlQlVfOg9ORQeS+7Y7fcsqw==
X-Received: by 2002:a05:6000:659:10b0:426:ffaa:8e9c with SMTP id
 ffacd0b85a97d-429aef735dfmr4377135f8f.13.1761821401443; 
 Thu, 30 Oct 2025 03:50:01 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-47728a97656sm33272395e9.9.2025.10.30.03.50.00
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 30 Oct 2025 03:50:00 -0700 (PDT)
Message-ID: <3849eccc-ca94-49f9-87a4-4c5aad496976@redhat.com>
Date: Thu, 30 Oct 2025 11:49:57 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/4] hw/pci-host/articia: Map PCI memory windows in realize
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: Peter Xu <peterx@redhat.com>, Akihiko Odaki
 <odaki@rsg.ci.i.u-tokyo.ac.jp>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, qemu-devel@nongnu.org, qemu-ppc@nongnu.org,
 Nicholas Piggin <npiggin@gmail.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>
References: <cover.1761346145.git.balaton@eik.bme.hu>
 <ceda4c28887c40e1c8eae3f561ee381ca98b0484.1761346145.git.balaton@eik.bme.hu>
 <7747275c-8e0a-4983-8613-fc39fc03bb39@linaro.org>
 <87b009e6-0d51-7409-61ad-dd65582eb13e@eik.bme.hu>
 <d23d5106-645c-466f-86e1-30ce20cc61d3@linaro.org>
 <dbdbc78f-3d4b-c0b2-87ac-85e24568a115@eik.bme.hu>
 <802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp>
 <28c6f065-ba8d-e5e2-922e-d5fd1fb58b60@eik.bme.hu>
 <db06bf5e-b7f5-4980-a054-393529e188eb@rsg.ci.i.u-tokyo.ac.jp>
 <759b6b4c-1155-184a-fa99-1df384f0fac3@eik.bme.hu> <aQJpDE6FvkIF6GgE@x1.local>
 <318bf988-9035-4012-9708-40c3783803f8@redhat.com>
 <b525a0c5-bcc0-7349-a925-6827591b7a34@eik.bme.hu>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <b525a0c5-bcc0-7349-a925-6827591b7a34@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

On 10/30/25 11:38, BALATON Zoltan wrote:
> I've tried to explain why I dislike that way in previous replies in this 
> thread but here's a short summary:
> 
> - Not piling memory regions not otherwise needed in device struct makes 
> it easier to understand. (Could you spot errors within the lot of boiler 
> plate code before clean up? Having less code makes it more comprehensible.)

Not sure what's different between

     MemoryRegion foo_mr;

in the struct, versus

     mr = g_new(MemoryRegion, 1);

in the realize function.  It's one line either way.

> - Documentation says it should work this way QOM managing memory regions 
> so it was meant to be that way. I'd rather fix code than documentation 
> as I think if it just works that's easier than loosing that convenience.No, that's *your* reading of the documentation, and it's based on the 
incorrect assumption that destruction implies freeing the memory. 
Akihiko explained that 
(https://lore.kernel.org/qemu-devel/802b77f2-2c23-4b5a-a739-d56b09c335de@rsg.ci.i.u-tokyo.ac.jp/).

The memory region documentation does not exist in a void, the difference 
between QOM object_initialize() and object_new() exists independent of 
that documentation.  It may be worth improving the QOM documentation on 
the object lifecycle; that could be.

Paolo

> - Allows simpler device models reusing superclasses without having to 
> write much boiler plate code to create a subclass.
> 
> I'll send some patches that can be discussed later.


