Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 12E3EC88E72
	for <qemu-devel@archiver.kernel.org>; Thu, 17 Sep 2026 12:37:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x7BMi-0002wV-RD; Thu, 17 Sep 2026 08:37:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7BMc-0002w4-3q
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:37:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x7BMa-0000wb-2T
 for qemu-devel@nongnu.org; Thu, 17 Sep 2026 08:37:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789648634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=9IYv3xi5t6Kjs4YbHJI3BlrO7tA27RM1MKp9Oa6xHKc=;
 b=T8TK+UoIuiPTk5E/G5mQzJZjZoMPkf/fR2KPaJIrz10TsgkuQRTisLo5/EfQggKQy9++0R
 6GAAaeL+w/47gCjHmyArrD+eAdDL3M7YybS44wBpxoULR5NLc2muiQNjfk8Ta941vhpMgM
 9rcm2+uU8uKqaWAKz3wuSxnIXxHi9u0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-553-4fBzYzzvOliMHrgwUJzrCA-1; Thu, 17 Sep 2026 08:37:12 -0400
X-MC-Unique: 4fBzYzzvOliMHrgwUJzrCA-1
X-Mimecast-MFC-AGG-ID: 4fBzYzzvOliMHrgwUJzrCA_1789648632
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-9104c2ce026so20521056d6.3
 for <qemu-devel@nongnu.org>; Thu, 17 Sep 2026 05:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789648632; x=1790253432; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9IYv3xi5t6Kjs4YbHJI3BlrO7tA27RM1MKp9Oa6xHKc=;
 b=t3KcQx3IjWVwirN4mfVX7CcV5IRt8Me0vqUkCkReIy1OvFTDr3RczgQZABpE9smzcM
 p7CnSeLveiIqtrWMgA7qGJjyE18//KNb9K0R7qjciUYV/UU82jO43TS7CRR3qGDRcXCV
 iE+azaawE10ofpFvdqZB9c65jYahUKA0/60BZp28tImDxtoNjVcrq5NhBit7KBcQZbli
 ARlOut/uw2SCejVDQxVQqcLNzmg10kGiP28BjslRM2gNE2w8AS3rOdkw5/3rg8rFuDbh
 A7sv87uwswmtPFKz7iVyO/12Vc81Ac6AZMbYxxGqFn2mslTEntWiRWt+5A3BHk3moIAX
 TlPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789648632; x=1790253432;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=9IYv3xi5t6Kjs4YbHJI3BlrO7tA27RM1MKp9Oa6xHKc=;
 b=aj9ttg8acAfp6eStmf6c3vlOvkUxk0IO0uCA4ul5gCwPmk7KMFROhQgMMXorHBTDjB
 pNALcIMfs8H1zzoHc5vKwGFbwIl0bZkyT0IRRo41MkaDJ3gtET5LS6oGScEUC9qKHVJo
 MkzRwyYFdfqmz2F6c3sMAaAz9+CpDMNg9DQDvfneqgvrNWfnRzDGVZxGaV/5zFYlJn6T
 segyuaYyNvOBBQu+fHjU2z648xCoau0S4pJFhVINU8E9TmlbA+oANydB/jDjY5PZuy3A
 Hi3mXzbvSGOe7XAYvyLAqvCnqQY728WYWAj2rxGeCpzJ7TDzwR3L6j3ky3Ka3ibTDZCV
 3OrQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBxmVM6I/oM95TqamImoR0DsPt0gkSYrwH67erdDwkTsPTLfpElvLnmlQ1ochwlrLWJY4WM6ibY1Bcde@nongnu.org
X-Gm-Message-State: AFuF++laNHNg1rF4SbcUgkkyBIoDRugW9bQdIMLH34feqCzSx+IBJ2sE
 8kYBdD8QJmynsudUW6HCpsGYpeTbChWv4mMeHKCrfyNOrv2vazyUQLvMdGEk2TirdGTzQ+o/TdP
 axrG4y/cS1cdXJMbfoN3tGu8d0A4XqVbSC5yYOb2XMcA3oRIuCxbP96Ve
X-Gm-Gg: AYBFou0QufagdFqjlYtL1uZMtYUGXJDO//ZcC24KvGM+BgxiMf6jAl2SbNZKlpkmXh0
 5IMH5ZeMVXVopOaPMB4c1cStkcWRiaUl00l2iMayVTfFdO+9UokdOHzupZtSeUbLmZ9Pgw/EVj0
 Yra/YzvR3ffL2CqBHUejCSlG3GwTnsiZBgqxb1/lYkPLY91pIUAw9g4n9FrnDLW7vNm1hn5CFi7
 NX3g03Vb9wMRBLcCzFCcAco3OY/7EHJAVmd9T4fYlNbbBuXuO+YVQHstad2fTEiQxxB4lyb3FFg
 tSMBr05kgQpC7LQJOhW0k/c6fsM1GvOrTTfCu3aepxyNtux7aaa2LGYROWuH4tXL2zNA
X-Received: by 2002:a05:6214:b64:b0:912:517b:90f with SMTP id
 6a1803df08f44-912517b0c71mr2470176d6.46.1789648631850; 
 Thu, 17 Sep 2026 05:37:11 -0700 (PDT)
X-Received: by 2002:a05:6214:b64:b0:912:517b:90f with SMTP id
 6a1803df08f44-912517b0c71mr2469386d6.46.1789648631237; 
 Thu, 17 Sep 2026 05:37:11 -0700 (PDT)
Received: from localhost ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-9123bddd40esm49315446d6.4.2026.09.17.05.37.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 17 Sep 2026 05:37:10 -0700 (PDT)
Date: Thu, 17 Sep 2026 08:36:59 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>, "Denis V. Lunev" <den@openvz.org>,
 qemu-devel@nongnu.org, Mark Kanda <mark.kanda@oracle.com>,
 Ben Chaney <bchaney@akamai.com>
Subject: Re: [PATCH 1/1] migration/cpr: lock the cpr state
Message-ID: <aqve6zlIKMMcIfKV@zhexu-thinkpadt14gen5.rmtcaon.csb>
References: <20260916132428.1628553-1-den@openvz.org>
 <aqrhPxFO7zHvZgs5@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <87v785rpml.fsf@suse.de>
 <aqrwAftZOnT4LsI6@zhexu-thinkpadt14gen5.rmtcaon.csb>
 <88028fa0-6b8d-44a6-8a59-41480b9d7b69@maciej.szmigiero.name>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <88028fa0-6b8d-44a6-8a59-41480b9d7b69@maciej.szmigiero.name>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Sep 17, 2026 at 02:24:42PM +0200, Maciej S. Szmigiero wrote:
> Isn't moving to more fine grained locking than BQL desirable in the long term,
> much like BKL was split and removed from Linux kernel years ago?

My question was more seeking the issue behind.  CPR is pretty special, I
didn't expect any new fd addition didn't already take BQL, at least before
reading the last message.

I don't think we should randomly add lock for any structure that is
currently protected by BQL, it'll unnecessarily slow things down.  We
should only do smaller granule locking when we can consider getting rid of
BQL in the first place.

> 
> For now, this new "cpr_fds_lock" would need to have its locking order with
> respect to BQL explicitly documented (if not enforced via asserts).

Yes, some document would be nicer.

-- 
Peter Xu


