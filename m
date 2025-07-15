Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E20C83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:31:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiYO-00066A-6s; Tue, 15 Jul 2025 12:30:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubhuS-00060P-46
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:49:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pabeni@redhat.com>) id 1ubhuQ-0005nA-43
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 11:49:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752594571;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EaaynNbXAbeJEzd/3fYvfFQk34QQXdyB/l9XIDKEMdY=;
 b=hYfKuFlKbjMKtzREutT243gh+qb7IwQkgoSuxm5BLGoGrLKSf1vzzzQvwcEAtx3pwdmFDI
 ot2KpM4icU4bR80EhehOKC+OM0LXx7rNQa+nBklQrzk5nucJv4GTnRZQFCgERzXMH2OngF
 v9o/aoJnGMt8AgB2hSumfL9tfrOteVE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-629-DiV_xYkUOWKjvv8hF3WssA-1; Tue, 15 Jul 2025 11:49:29 -0400
X-MC-Unique: DiV_xYkUOWKjvv8hF3WssA-1
X-Mimecast-MFC-AGG-ID: DiV_xYkUOWKjvv8hF3WssA_1752594568
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3a4f65a705dso3720855f8f.2
 for <qemu-devel@nongnu.org>; Tue, 15 Jul 2025 08:49:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752594568; x=1753199368;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=EaaynNbXAbeJEzd/3fYvfFQk34QQXdyB/l9XIDKEMdY=;
 b=KvyvGWJncpXX2aEbnIs70YmN29ImsHzwSB5Dh0k+NqR7cGHhZgf+rosFOkSoT10fZo
 ka21m+Ehs0ESYzwsfoOKYKPR884G8FXljtJdt2CMget/V3jVZDvtSsxBBYqdd1TSafpj
 aPkWXaKpmHmjN6frPZepZ6mF3aPtacD05fHzmxRU0VzGPls0pf1LS9ezGHxzxKYo4q+h
 GBfc0xrOIpbypvKD3f4gYiYnBYgncZm32w38DxJsHIKFGg7TFU8ELFRSHp98SQuU3rl8
 UKqTuIRURvzzgXxu4x/XlJKRFkygxcPI49K17lmj/tWHEp3qE560dokYQkGwP8lYVFyW
 usHw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW6TrZEWF6f/nKkYt/qeqe5Hg1rQawG+efuwysbaoGKKGiB9fWyMxW7Z1Poe+I5I8ZVPWthPZQplt7H@nongnu.org
X-Gm-Message-State: AOJu0YxYAoi1GnPiyvtgmdiHY3dOtX/bCJ8QThjtf+ya+bvlu2G/GnA+
 jw+eqkcU0KYzCKe0lcS4votXvamui7Bd9LFB4U1TCY+Fi1RUW1fV1wi+DSeiWsvQ2sxbwiYO2HZ
 2wmqD8Ij2gL80vH23rNPiqkNIZlxUnr+nPWrMrAmcjDH3HqcbMn709+ha
X-Gm-Gg: ASbGncubI3bDOI9tWe8x4B9GRWSQ3U7PpcjMdHZ6Ow7oKauVwMPuEAdQlESBwdaDUeG
 FRqPZFKyRErcgEzjfzph+E70nqMb/2VL0OMLSVj2Yfrtj4F7SGNfu7UnVZfnCiwvB2PdRkwtj//
 Ke2EX1TL2mtqkBeoiQOeOFXIuoDH1btg3wygLvOILLPruOcpuLRV5t0MUFBEdVqz2bOtkj/yVqq
 e84UmrG15uoNwD+VNH98EXL76trsrmbHjLzGtLRuC6gpUlymKuLBb08GbJjiC7EyuUWKyziWp05
 a5ss1vCvEiu08jFICRmKzsasGmDn8KRZQUgPz3I0q1C4M3SfUkOgvUeRCJ6mXgeWtw9d/jMHz68
 cka5jQu3s/Gs=
X-Received: by 2002:a05:6000:230e:b0:3b5:e6f2:9117 with SMTP id
 ffacd0b85a97d-3b5f2e3083dmr14052953f8f.39.1752594567552; 
 Tue, 15 Jul 2025 08:49:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF98qDkBB2TTtzIKKvxQc3djL0N5JfUyVilZbHF8FYISQjuvrvFyi7KXBenNz4gs7duy977fg==
X-Received: by 2002:a05:6000:230e:b0:3b5:e6f2:9117 with SMTP id
 ffacd0b85a97d-3b5f2e3083dmr14052923f8f.39.1752594567106; 
 Tue, 15 Jul 2025 08:49:27 -0700 (PDT)
Received: from ?IPV6:2a0d:3344:2712:7e10:4d59:d956:544f:d65c?
 ([2a0d:3344:2712:7e10:4d59:d956:544f:d65c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8e0d758sm15119598f8f.49.2025.07.15.08.49.25
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 15 Jul 2025 08:49:26 -0700 (PDT)
Message-ID: <e6626fe6-c66c-4b16-93e4-447e43379424@redhat.com>
Date: Tue, 15 Jul 2025 17:49:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC v2 12/13] net: implement tunnel probing
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
 <94ffdec876d61f22a90e63d6a79ff5517d1c727c.1752229731.git.pabeni@redhat.com>
 <93de161a-3867-46aa-bfc0-2da951981bcf@rsg.ci.i.u-tokyo.ac.jp>
Content-Language: en-US
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <93de161a-3867-46aa-bfc0-2da951981bcf@rsg.ci.i.u-tokyo.ac.jp>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pabeni@redhat.com;
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

On 7/15/25 10:05 AM, Akihiko Odaki wrote:
> On 2025/07/11 22:02, Paolo Abeni wrote:
>> diff --git a/net/tap-bsd.c b/net/tap-bsd.c
>> index 86b6edee94..e7de0672f4 100644
>> --- a/net/tap-bsd.c
>> +++ b/net/tap-bsd.c
>> @@ -217,6 +217,11 @@ int tap_probe_has_uso(int fd)
>>       return 0;
>>   }
>>   
>> +int tap_probe_has_tunnel(int fd)
> 
> This should return bool for consistency.

Some inconsistency will persist, as others bsd helpers supposed to
return a bool currently return an int. I tried to be consistent with the
surrounding code, but no strong objections.

/P


