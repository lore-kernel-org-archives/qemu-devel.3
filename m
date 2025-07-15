Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24C33C83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 15:28:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubhZC-0003TL-V3; Tue, 15 Jul 2025 11:27:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubh1Y-0008HN-Ji
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:52:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubh1W-0004bW-7V
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 10:52:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752591167;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bxQZ8Hie5T3HCgWx3/R4T32KxcUlxdlQ0fcB+aBwW1M=;
 b=ZmFbwg+nL6GcWGcXsHrd8BPB02YwA2fmUuMmDL8Ukw6BD02i4KNT7vemMs/JpncnCbY2It
 XJm7j2E8sl+da1Gc7ZURI84VAh9L/kY4Yk/WF7KYajZFeybFGqxfQk9yIhY+LXWf25JRts
 UAA3ct6A0ASX9JiLkJVTV/nEVvx+dok=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-512-2J7b3EAKOw6EiwRZt8sHvw-1; Tue, 15 Jul 2025 10:52:45 -0400
X-MC-Unique: 2J7b3EAKOw6EiwRZt8sHvw-1
X-Mimecast-MFC-AGG-ID: 2J7b3EAKOw6EiwRZt8sHvw_1752591164
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3a54a8a0122so2897681f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 07:52:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752591164; x=1753195964;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bxQZ8Hie5T3HCgWx3/R4T32KxcUlxdlQ0fcB+aBwW1M=;
 b=MADXUheNqn5EBTqm+R7AOepU5e3NNI7nQsM228QKYUjixGWT+O5iUvaldMenHQlz9t
 FO9p9qkHbrIr9rvRJt025z49eTx0G8rtFm2Df/hVgSEcsIM5QpW2zkAA2QKkBGr+qV0D
 7FsnebjzA4KwU3cg/MV960Gx9XSLtmihBAO7yjNvHiZPHnKqitak2zYXCZPl5E56vu78
 wSr088MxFTvEyAWzvJOe2LXvofHRQG5zxcauAbkOt1aCOFroONS6ss/Zw/EcCMg55/X3
 GS7HH0AAD/VgpxtSzZagzbpYpnBYEbjqezVFjxtSqz7yL8Gl4aK6dty3u/X8mYyDCskR
 rU1w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVgVk0TjFV0pLtykdXQtiXjkZH5ryNVLys8/Ul+JB3vFoRb6lNw3TQ6jpzP9pQezpbuDUdsNRSKZtWV@nongnu.org
X-Gm-Message-State: AOJu0YyWu38hfjRJUDCoJO6zccdIx2X/rfe6XafcUN/B20qrw0luMq++
 NPvWF8rOeDJPQGZFb4JzbZCnMZNfDkhFPMLS/PhhpxfMsaPdP92Fwy8LtEKJp/o/FKtMpfpTTeQ
 CDeWhS5nMYPJbIVQtm/vjq6tWiDYGHgwoo50GZOGIhx9k+Lbmf8VvZcMs
X-Gm-Gg: ASbGncu/N30nZ+gdZDgbR8+4amgkmd8QEA0BjKVzrdufIIXolCUkNITBzClEqdaQMkb
 kktO955C1nCRdSAGBsC+WoiNHKHxs+aM0vztsY5dUEjzGRIqEo62QYjT78WkM2p7K+n3HUlVQEa
 lbBaq0eWn6YX5iRWGHuXmeMutka8nf6pAf/YNHQM7qxd+hKHlbnANmWRtUp2t+xotOo0IimJ2lK
 oQGQA9pSjyxZFtLzAs1T6dGuXwDAFqVFsaCQ9Ps5LCR3RuTgEmuqITqMMP2ywV1yCuq5ponKQEN
 PkfXGKxadM8Ls5cfNBwov5BN6byiykgSF3/651nnRqFnWsBxfYKgkkrm5CRvW+DAr+Pwq1tGntv
 ULVveYMAugKY=
X-Received: by 2002:a05:6000:2c08:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3b5f187b273mr14409314f8f.6.1752591164406; 
 Tue, 15 Jul 2025 07:52:44 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHHvBquKJxzCWKzr/INp7RLFyz+PGA2ulyXDvLI1kn0nN13gZk4ELGhhUPuBfVbo9Gg/8knmQ==
X-Received: by 2002:a05:6000:2c08:b0:3a4:dc2a:924e with SMTP id
 ffacd0b85a97d-3b5f187b273mr14409291f8f.6.1752591163964; 
 Tue, 15 Jul 2025 07:52:43 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8bd18ffsm15081072f8f.9.2025.07.15.07.52.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 07:52:43 -0700 (PDT)
Message-ID: <bbf7744c-9340-4d59-804b-87f7ff9bdcc4@redhat.com>
Date: Tue, 15 Jul 2025 16:52:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 01/13] net: bundle all offloads in a single struct
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, Jason Wang
 <jasowang@redhat.com>, Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>, Cornelia Huck <cohuck@redhat.com>,
 Luigi Rizzo <lrizzo@google.com>, Giuseppe Lettieri
 <g.lettieri@iet.unipi.it>, Vincenzo Maffione <v.maffione@gmail.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 kvm@vger.kernel.org
References: <cover.1752229731.git.pabeni@redhat.com>
 <6e85b684df9f953f04b10c75288e2d4065af49a2.1752229731.git.pabeni@redhat.com>
 <d434b098-aebc-42cb-b589-d84f7bd78c21@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <d434b098-aebc-42cb-b589-d84f7bd78c21@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pabeni@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 7/15/25 8:36 AM, Akihiko Odaki wrote:
> On 2025/07/11 22:02, Paolo Abeni wrote:
>> The set_offload() argument list is already pretty long and
>> we are going to introduce soon a bunch of additional offloads.
>>
>> Replace the offload arguments with a single struct and update
>> all the relevant call-sites.
>>
>> No functional changes intended.
>>
>> Signed-off-by: Paolo Abeni <pabeni@redhat.com>
>> ---
>> Note: I maintained  the struct usage as opposed to uint64_t bitmask usage
>> as suggested by Akihiko, because the latter feel a bit more invasive.
> 
> I think a bitmask will be invasive to the same extent with the current 
> version; most part of this change comes from the parameter passing, 
> which does not depend on the representation of the parameter.

Do you have strong feeling WRT the bitmask usage?

Another argument vs the bitmask usage is that it will requires some
extra input validation of the selected offload bits (most of them don't
make sense in this context).

Thanks,

Paolo


