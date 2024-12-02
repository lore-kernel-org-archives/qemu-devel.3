Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75B91D4979F
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Dec 2024 07:08:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tI0X4-0005Ov-MQ; Mon, 02 Dec 2024 02:07:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tI0X3-0005Oh-MR
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 02:07:45 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tI0X1-0002rm-51
 for qemu-devel@nongnu.org; Mon, 02 Dec 2024 02:07:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733123259;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RhoD0MwVSTtVWWxnrZmruHR3ZDtqAgDP2G8sp95PKy8=;
 b=e0S31z2kOcIHRgyDV5b67/R01Bbue3pZwALkffakMmgnhrZCKgJ6FGeKIylOutAOmDgv/5
 mgS5fJwD6uEhrApKBwumPgj4ga7YshCvOIOM4lWVBI68hTibg5ZvGygjc9e/0C9f2aDH1l
 GgBYvRx9yGBvANibmYWYmw/AChCpzfk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-3LzmQu82PWGs_4VDloEhCw-1; Mon, 02 Dec 2024 02:07:37 -0500
X-MC-Unique: 3LzmQu82PWGs_4VDloEhCw-1
X-Mimecast-MFC-AGG-ID: 3LzmQu82PWGs_4VDloEhCw
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-434a4ad4798so28819255e9.0
 for <qemu-devel@nongnu.org>; Sun, 01 Dec 2024 23:07:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733123256; x=1733728056;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=RhoD0MwVSTtVWWxnrZmruHR3ZDtqAgDP2G8sp95PKy8=;
 b=TAHmLh+bQSSARsg6w+LVZ3Hgg401kbByZcPrNFfTuiAkTdvstrIFokzeFjiMF4NeIX
 xM6xkD2ew8rDURaVEOGHHlnPKmxbKLfsHS4BxvpXqWlVY4aYgCtq2beuZx5rYdrnQAJ+
 59N8vQRYjT2c9GckGBqLomHnw5BWD2kh0Aa0reZ0WPeUqrDCOO53JIxEtIGDiY2L9S19
 pMd4ZV0cQH7pY/wkR7S9U7Im8UaXxIvJGNeSZVZdbEhBxQjfSnkQas80hUUxqOUd2OFr
 JYLLxj6oCEUzoPHoSP5aFx316jCIiHNalsTTxfeLnnLyzBILfHc1Njmcr26NxrFRc08A
 Jxjw==
X-Gm-Message-State: AOJu0Yykq6Gn8j5XZH34GoUYL70C0Dr6zpwKvRBzwInv8yqXqCq/C1tA
 FRGo68rFIkBJY1Mw5d3+jhp0GyGCrQ26nuV+b0YRSh9K6sZOco+r3s1S4H7aTJsMFqJtWgOlew7
 xL+qfmOkEkmQBFpPh/ZYtIxLJkdnGN69Z94uDuNWyGbINTohp7//Mg780eZXxSdi5fqyn7LJNO8
 +ogy3ksdSwlV+FbUSwWmeSOO0uqB0=
X-Gm-Gg: ASbGncuACv7jQ1cxtjWuk6MNR+qIXfDcoGX2mjzrkNapdKb/oBmMcRYxXRIoNm5TaK8
 g9rpGZz86oPV2o3BudBIn7Nk8j0k+qKoxbg==
X-Received: by 2002:a05:600c:1c88:b0:434:a0a0:3660 with SMTP id
 5b1f17b1804b1-434a9dfbbffmr204882855e9.31.1733123256402; 
 Sun, 01 Dec 2024 23:07:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEMKbO6qWpkR4vohuBXB9MIzpXrJLQwbLx3A+Ao15S3RrclDS4R3VEpD0wi5mvxynx9uoIVuqdilKH8+GcOgcc=
X-Received: by 2002:a05:600c:1c88:b0:434:a0a0:3660 with SMTP id
 5b1f17b1804b1-434a9dfbbffmr204882545e9.31.1733123256021; Sun, 01 Dec 2024
 23:07:36 -0800 (PST)
MIME-Version: 1.0
References: <20241129122256.96778-1-ppandit@redhat.com> <Z0nvv23M6bCnJrZc@x1n>
In-Reply-To: <Z0nvv23M6bCnJrZc@x1n>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 2 Dec 2024 12:37:19 +0530
Message-ID: <CAE8KmOyBUVF3DrLmwneM_paXH7uZeZPxzuS8Ae5LSnuJTow22g@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] Allow to enable multifd and postcopy migration
 together
To: Peter Xu <peterx@redhat.com>
Cc: qemu-devel@nongnu.org, farosas@suse.de, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hello Peter,

On Fri, 29 Nov 2024 at 22:16, Peter Xu <peterx@redhat.com> wrote:
> I saw that there's still discussion in the previous version, while this
> cover letter doesn't mention why it was ignored.  Especially, at least to
> me, what Fabiano commented on simplifying the flush condition check makes
> senes to me to be addressed.

* It is not ignored. Simplifying flush conditionals makes sense to me
too, that is why in the 'v0' version of this series I had added the
!migration_in_postcopy() check to the migrate_multifd() function,
right? I tried to discuss in the 'v1' thread if there's another way to
simplify conditionals. Not sure if you've followed all comments in the
thread.

* Secondly, as you mention above, I also thought Fabiano is pointing
at the complexity of the 'if' conditionals and thus I replied that his
proposed patch does not seem to solve for that complexity. But in his
subsequent reply Fabiano mentions that it is not just about
conditionals, but larger complexity of how and when multifd threads do
flush and sync amongst them.

* IMHO, simplifying that larger complexity of how multifd threads do
flush and sync can be done independently, outside the scope of this
patch series, which is about enabling multifd and postcopy together.

> Meanwhile, before I read into any details, I found that all the tests I
> requested are still missing.  Would you please consider adding them?
>
> My previous comment regarding to test is here:
> https://lore.kernel.org/qemu-devel/ZykJBq7ME5jgSzCA@x1n/
>
> I listed exactly the minimum set of tests that I think we should have.
...
> In general, any migration new feature must have both doc updates and test
> coverage as long as applicable.
>
> Multifd still has its doc missing, which is unfortunate.  We could have one
> doc prior to this work, but it can also be done later.
>
> OTOH on testing: this is not a new feature alone, but it's more dangerous
> than a new feature due to what I mentioned before, that postcopy needs
> atomicity on page movements, and multifd is completely against that from
> design POV due to NIC drivers being able to modify guest pages directly.
>
> It means multifd+postcopy bugs will be extremely hard to debug if we don't
> put it right first.  So please be serious on the test coverage on this
> work.

* I'm yet to get to the test cases. The revised series(v1 and v2) are
posted to share patch updates which were suggested in the previous
reviews. Test cases are a separate/different effort from source
patches. If we want to hold on this patch series till we get the test
cases and documentation in place, that is okay, I'll work on that
next.

Thank you.
---
  - Prasad


