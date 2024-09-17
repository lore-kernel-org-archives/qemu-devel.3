Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 023F9CAC58E
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Sep 2024 17:07:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sqbfe-000466-3q; Tue, 17 Sep 2024 13:07:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqbfc-00045c-Gf
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 13:07:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1sqbfa-0003FR-Sg
 for qemu-devel@nongnu.org; Tue, 17 Sep 2024 13:07:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726592837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3XKfZGPBgG4Iz4dKY6GaNQn0cpBFSkhMZlLUsHbrAoM=;
 b=Nj4SFOAFy27+TZIQasPgT1FZGAYGZEOzolgm3JaV8iXbnR/jJpxu72W+nHklcHBJ8ZH/AC
 kSxmbtk8NUxERDCyelSDkXLXfxdxkv5LMadzGQqDhTN2Jyk8Q1+ikmHcoJmCfxChzThcLF
 3BsWMRQFdcs+SmIqB7+pH74Cw0vaJ+k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-355-56a6C6NHObqD6mUwDc4jFw-1; Tue, 17 Sep 2024 13:07:15 -0400
X-MC-Unique: 56a6C6NHObqD6mUwDc4jFw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb236ad4aso38258445e9.3
 for <qemu-devel@nongnu.org>; Tue, 17 Sep 2024 10:07:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726592833; x=1727197633;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3XKfZGPBgG4Iz4dKY6GaNQn0cpBFSkhMZlLUsHbrAoM=;
 b=jn4t1/4Zn7raZkPmJic91vzuUpLN99BmeULdeIQSEQSaZPt2UOSdMn/cT6++w5gNJQ
 +/U8qOCASFughIBewGhIqXgj7VCHzT6TcjIB7W4z57B3md6ipjjLqltRBzYV5+SefzIh
 QMx4i9sn5V0/hlcyMx35RNvi2DlPCno0dlPmDdBL53xEGsEvgcfUQclCQ0tdlfetQNAq
 G+eBAQKDdWz2O+t6AobLVw5D2xoK2lLXfXbcFwGVsu19Q8ByeDw+/kAfd67PpCL3FSDg
 IcBMWH5yfwbN9yQDf/c7tJig1MdsltCZHh2bMLjoEPC96jyOnWlZ+3SKdOKBJabVj7pZ
 QwBw==
X-Forwarded-Encrypted: i=1;
 AJvYcCUQzulEVjDy/PXY2byePob1NB3612cX8ueK127p8f3sxa87HFYJubfWXPPsQEOWOxuuicRd7dlZXp7o@nongnu.org
X-Gm-Message-State: AOJu0YzYonZN91HVXzu0yf+E4CbRHS+c0vCxXKmRippAR2jfYajYMabc
 U8oBYxtZmFzaU7wwFfuUz1HThibg95pd4MBxg5ZH5Eky6ZlYKUSteVL0dyun8n6Xouq7iUuGIwN
 SLqYKEcnKnsYMSRtYZ+6fgqHgEwvNI9jUE/zuq/3Gv32qDu40v9n+
X-Received: by 2002:a05:600c:510f:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-42cdb529479mr137876785e9.8.1726592833139; 
 Tue, 17 Sep 2024 10:07:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGY7y/opb+aSl+6pfqnHnX3Vd63DEldQmhs8g9E7JqNvFTQk9wJQ/bJAyFzwUc73120LVa9Pg==
X-Received: by 2002:a05:600c:510f:b0:426:66e9:b844 with SMTP id
 5b1f17b1804b1-42cdb529479mr137876545e9.8.1726592832612; 
 Tue, 17 Sep 2024 10:07:12 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:3f78:514a:4f03:fdc0?
 ([2a01:e0a:280:24f0:3f78:514a:4f03:fdc0])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42da22d7e2esm107873265e9.13.2024.09.17.10.07.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 17 Sep 2024 10:07:12 -0700 (PDT)
Message-ID: <45f44392-cb56-4341-ab1d-7d7f28554c77@redhat.com>
Date: Tue, 17 Sep 2024 19:07:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/17] migration/multifd: Device state transfer support
 - send side
To: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Cc: mail@maciej.szmigiero.name, Alex Williamson <alex.williamson@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Joao Martins <joao.m.martins@oracle.com>,
 qemu-devel@nongnu.org
References: <cover.1724701542.git.maciej.szmigiero@oracle.com>
 <fdcfd68dfcf3b20278a4495eb639905b2a8e8ff3.1724701542.git.maciej.szmigiero@oracle.com>
 <87h6b4nosy.fsf@suse.de> <ZuCickYhs3nf2ERC@x1n> <87zfoc1zms.fsf@suse.de>
 <ZuOGAb3988ExsrHi@x1n> <87o74r1yfw.fsf@suse.de> <ZuRJ8i4T_vUzrawY@x1n>
 <87ldzv1tpb.fsf@suse.de> <ZuRYouLwikc4OYye@x1n>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
In-Reply-To: <ZuRYouLwikc4OYye@x1n>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

[ ... ]

>>> I as a patch writer always like to do that when it's essential.  Normally
>>> the case is I don't have enough reviewer resources to help me get a better
>>> design, or discuss about it.
>>
>> Right, but we can't keep providing a moving target. See the thread pool
>> discussion for an example. It's hard to work that way. The discussion
>> here is similar, we introduced the union, now we're moving to the
>> struct. And you're right that the changes here are small, so let's not
>> get caught in that.
> 
> What's your suggestion on the thread pool?  Should we merge the change
> where vfio creates the threads on its own (assuming vfio maintainers are ok
> with it)?
> 
> I would say no, that's what I suggested.  I'd start with reusing
> ThreadPool, then we found issue when Stefan reported worry on abusing the
> API.  All these discussions seem sensible to me so far.  We can't rush on
> these until we figure things out step by step.  I don't see a way.
> 
> I saw Cedric suggesting to not even create a thread on recv side.  I am not
> sure whether that's easy, but I'd agree with Cedric if possible.  I think
> Maciej could have a point where it can block mutlifd threads, aka, IO
> threads, which might be unwanted.

Sorry, If I am adding noise on this topic. I made this suggestion
because I spotted some asymmetry in the proposal.

The send and recv implementation in VFIO relies on different
interfaces with different level of complexity. The send part is
using a set of multifd callbacks called from multifd threads,
if I am correct. Whereas the recv part is directly implemented
in VFIO with local thread(s?) doing their own state receive cookery.

I was expecting a common interface to minimize assumptions on both
ends. It doesn't have to be callback based. It could be a set of
services a subsystem could use to transfer state in parallel.
<side note>
      VFIO migration is driven by numerous callbacks and it is
      difficult to understand the context in which these are called.
      Adding more callbacks might not be the best approach.
</side note>

The other comment was on optimisation. If this is an optimisation
then I would expect, first, a non-optimized version not using threads
(on the recv side).

VFIO Migration is a "new" feature which needs some more run-in.
That said, it is stable, MLX5 VFs devices have good support, you
can rely on me to evaluate the future respins.

Thanks,

C.


