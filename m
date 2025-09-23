Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D77C4CAC5A5
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Sep 2025 07:54:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0xqL-0002P7-Us; Tue, 23 Sep 2025 03:53:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xqG-0002OI-PD
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0xqD-0005LE-JA
 for qemu-devel@nongnu.org; Tue, 23 Sep 2025 03:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758614012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=M4ECiPnnzb0/4sDd6Qb3WQvrt9UzCo77Rq26Q9/jxyg=;
 b=e5rcZqvaz0aFhH8MyMzzW6WVLtIfFKCDKFGsWfCWps1AG1rWucRJDpmXMwUF9OeMxqATRT
 26Mpt2iHI2xWOY+ZQE8GOG/bWPmVyRInZl5tl7+nijRIqz67s4B/qZHAcPeYwXls1yxyM7
 iZZDzHvqHw+1mBV0RxaYYD42zYKBEVk=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-262-1TLOnLSoN-mmEiE5uXotOA-1; Tue, 23 Sep 2025 03:53:24 -0400
X-MC-Unique: 1TLOnLSoN-mmEiE5uXotOA-1
X-Mimecast-MFC-AGG-ID: 1TLOnLSoN-mmEiE5uXotOA_1758614003
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-62fd1b03d74so5005542a12.0
 for <qemu-devel@nongnu.org>; Tue, 23 Sep 2025 00:53:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758614003; x=1759218803;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=M4ECiPnnzb0/4sDd6Qb3WQvrt9UzCo77Rq26Q9/jxyg=;
 b=gw0PUMe00RGhvl7jFNxrx17Gtre5Be3yp0JJ5CHmapS8S3yeUy9Juy0aL6nxlPLiTC
 h92nC6HZ+SEwvvPtdG94N75pZc8/CJ65q0VbyTE76rn1qTWh1DdZhzvI6MFCmTtWLbgz
 A8gXI8LKV3wtHby3qyDG59wC8mTuqacyJe8jaB65uElx1YLFTMOuSCvQK3rD2Lp1iOVA
 Ubko4cfFuRt57O7IRyEcinyVXndSWt8v3ORlaPavrIeiEX0wblgFO2vSRVMmlpEW3EVZ
 pXwaAg/2KJhNQl/cE91CX0U4eVlaiIH/yn2J8MIcIB4M5h00bhnfuW1Lnhq613ZxT0Ca
 vzoA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUh18+VFLmM7XK0gKMI8gRBx66xhx8ZNWL0YjZH5uFh9hw45RB3TcMK0cEDbPpuZl1Rwo9pcV19asIv@nongnu.org
X-Gm-Message-State: AOJu0YzvBSfD6Ry0EN4a5OqAfS0CbIb76CrSIgoyX/BpZn4i6TwPyO1Q
 0AVjMZEXU0p9QQ23IK0/jRDfjAm4+6MJ/c95t+GFzBWDvtydCmweAAmyEJLGdNblll78IgZzRDl
 9aVJMCaZxc8/5sDtmmSd4tgXudMeXE7A3lC5zUXf6t95ZgFQwA8w1djOB
X-Gm-Gg: ASbGncuJnCwPjwwPOr1hwj7cfGKWXd48NEBGSPn4+dYY9HD5d4DD0/KK7OxezuFfA/t
 AgsGJojwT08a9+A+oljktzQuAx45yEn4UJsf2GlJc4y7Klh8dw6di5+i8+o9K2azkR3We9SNW9y
 4DHfc7p7q1joFkIPOCy93HKuyPxzT4sC5DR5pELRfrFuom6lpWbFm/aiWz8iBixEPHlMmd3G+hm
 ZAv3idv12ac8W8UdC+ANX+jEyMc3fB/SJkY+gmNzeb/I8QX/x13lwPBju9MKhz60Knlsr4OA2ar
 MZfYeI98lUSX/YcN2nYmX5hJfHKq3DSAIHoEw8BwRJnfyfmGiUrs+5kPdXqa0ASqc343kv0rUlj
 lz50mXeagVhrJXGmqQiVo+04IygMbJyFrZ+qWjiowZ5rkWQ==
X-Received: by 2002:a05:6402:2343:b0:62f:36bb:d8ba with SMTP id
 4fb4d7f45d1cf-634677e7c9amr1463077a12.22.1758614003491; 
 Tue, 23 Sep 2025 00:53:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFWqfRTr/AzEg5ZFnk07VTiqUm5y+YSQPLvjOfrTMwAZ0xWeA6Re4XcL0EozpCJROrMV5XJvw==
X-Received: by 2002:a05:6402:2343:b0:62f:36bb:d8ba with SMTP id
 4fb4d7f45d1cf-634677e7c9amr1463062a12.22.1758614003038; 
 Tue, 23 Sep 2025 00:53:23 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.googlemail.com with ESMTPSA id
 4fb4d7f45d1cf-62fa5d03befsm10695887a12.2.2025.09.23.00.53.22
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Sep 2025 00:53:22 -0700 (PDT)
Message-ID: <b2fb1e8c-4b30-4bde-9b16-b9a0cd314b70@redhat.com>
Date: Tue, 23 Sep 2025 09:53:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 0/2] Fix cross migration issue with missing features:
 pdcm, arch-capabilities
To: Hector Cao <hector.cao@canonical.com>, qemu-devel@nongnu.org
References: <CABjvBV7wgfSv-OjGf_L2t9ranXfzTQTSBdRAFODpHH-nFcLFig@mail.gmail.com>
 <20250910115733.21149-1-hector.cao@canonical.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250910115733.21149-1-hector.cao@canonical.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 9/10/25 13:57, Hector Cao wrote:
> Hello,
> 
> Since it is a blocking issue for us, we went further and ended up with a solution along [1]
> that allows us to get out of this situation.
> 
> The idea is to add compatibility properties to restore legacy behaviors for machine types
> with older versions of QEMU (<10.1). 2 compatiblity properties have been added to address
> respectively the 2 missing features, each one is done in a separate patch.
> 
> We know that 10.1 has been released and it's final, but working on a solution towards 11.0
> would allow everyone to settle on the fix and even consider backporting where not yet released
> like Ubuntu 25.10 for us.

Thanks, I have applied the patch.  It's better to have the fix in 10.1.1.

Sorry for the delay, I was on vacation for one week and working reduced 
hours the next.

Paolo

> It is important to have upstream support going forward in this or any other way
> and therefore reach out with this RFC to ask you to think about it with us.
> 
> [1] https://gitlab.com/qemu-project/qemu/-/blob/master/docs/devel/migration/compatibility.rst
> 
> Hector Cao (2):
>    target/i386: add compatibility property for arch_capabilities
>    target/i386: add compatibility property for pdcm feature
> 
>   hw/core/machine.c     |  2 ++
>   migration/migration.h | 23 +++++++++++++++++++++++
>   migration/options.c   |  6 ++++++
>   target/i386/cpu.c     | 17 ++++++++++++++---
>   target/i386/kvm/kvm.c |  5 ++++-
>   5 files changed, 49 insertions(+), 4 deletions(-)
> 


