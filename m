Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4B5FC2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 14:57:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHkrx-0007we-5j; Wed, 21 May 2025 10:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHkrs-0007wQ-1P
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:56:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHkrn-0007ny-Pt
 for qemu-devel@nongnu.org; Wed, 21 May 2025 10:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747839380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MHH75geyc/ykHniQrJECgycqFi3EoJBFhYaMFoJD0K4=;
 b=T35QL3lHfVSl8LHsVfuyFJ7+1HFSMWOSJYVq/lVfoRag/yEqdJ8loWxrSrZ2eDvVM221xt
 LnvFjp2VlvNRh9F1rW48VlbX+03hFpb+9rdTDzFuLgIjQV+rczuHRxsUoC8cBxsZdqEyvQ
 Vlfc5sI0lNhiQdJbgUE+smfSLru4BTc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-5FE10qpqN2egAWR9749ZVQ-1; Wed, 21 May 2025 10:56:17 -0400
X-MC-Unique: 5FE10qpqN2egAWR9749ZVQ-1
X-Mimecast-MFC-AGG-ID: 5FE10qpqN2egAWR9749ZVQ_1747839377
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-7c5cd0f8961so1440388285a.1
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 07:56:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747839376; x=1748444176;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MHH75geyc/ykHniQrJECgycqFi3EoJBFhYaMFoJD0K4=;
 b=pHcc2Tzs8fVfaUxgFEfqCfDrAmKEA5MBhPNHDXAIj5v80phN5BPpRfsg0KmkFXNaLt
 Y4iZD5XqrDtK3mW1HzqX17Kz/0BnVZXP27PcVRS7vQfsrUb+FZIv2Moib5uM5HHniVq/
 SixwR7B3x9FYmxsykNwzUwAGOZxSvkQkfwB8s/GDrkg8qB7cyGEtuq1VMx3Zgl60wwUA
 Y5SpBsnILg12PE+sz2Z162NTplef1IgtoQrVYrHaeNUGgK+Xbj6ZRxeCnfcLocI+Cxls
 xXwGG+KrH1Ycif94wtnzNsXTYJHn+76c/GLlDpQBcAE0tqP5E6FHpKr9bu/Z+QXOSO8c
 YE/g==
X-Gm-Message-State: AOJu0YzPQI2kL53Hg+c+6rGsAF5R1mE487ESRWqaEvcu389saP5cJrJj
 C8wXXUon/ZJqcnjjaQIb2FiM3bHdJK4ZRqWU2ROSPtsO6mmeJQRrezFcYYZPezQtV9C6AKOPwBn
 U/OyvRFyQpj29nqtOGa5YivBric6EOUuYdRxmJ/5gFKCT6W8eENXVKIsJnzXNEvEz
X-Gm-Gg: ASbGncucsneIt9wo6tRt+OmoNnbvGT4E9X+/YqS1quHfpM9QVRGn1EUK2esX8gIqHpd
 lCqJU8wzOqE47g4QZSL4u1mQ5txgur1xf7nxXVt3DJU8KmUjMCK2sTqp5/uF7MxPSWv6S6QDVWb
 WDsRLxHjdpw38WN3NhQ4YVUM+6Mhc7lrMJEcAjAElyC2Nw5djcu+35/TVEk7186BTpGSuFSSoN5
 nnXTZGxtT994P3JPm9zUbMn6eKOngrykL3kfLeKixKwfxAjPIJzWeT9NwXT30eJ1ktum02fVuue
 4+c=
X-Received: by 2002:a05:6830:3982:b0:72b:98f8:5c96 with SMTP id
 46e09a7af769-734f6ae77a6mr17197603a34.8.1747839365174; 
 Wed, 21 May 2025 07:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHQcDxS/xLvr4Ac2sXpNjyZ9wfRsrS7qx+rPbBUgbSvURULERmgcWxq51TCX6/1l3feMQRWhQ==
X-Received: by 2002:a05:622a:4005:b0:490:8ffd:9a90 with SMTP id
 d75a77b69052e-494ae48f602mr355200381cf.45.1747839354495; 
 Wed, 21 May 2025 07:55:54 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-494ae3f89a9sm85656821cf.20.2025.05.21.07.55.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 07:55:54 -0700 (PDT)
Date: Wed, 21 May 2025 10:55:51 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] qapi/migration: Deprecate migrate argument @detach
Message-ID: <aC3pd3Q03yypU6oS@x1.local>
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-3-armbru@redhat.com>
 <aC3VlBLa0nmaXNLW@x1.local> <87msb6yr5a.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87msb6yr5a.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 04:28:33PM +0200, Markus Armbruster wrote:
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Wed, May 21, 2025 at 08:37:09AM +0200, Markus Armbruster wrote:
> >> Argument @detach has always been ignored.  Start the clock to get rid
> >> of it.
> >> 
> >> Cc: Peter Xu <peterx@redhat.com>
> >> Cc: Fabiano Rosas <farosas@suse.de>
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  docs/about/deprecated.rst |  5 +++++
> >>  qapi/migration.json       | 18 +++++++++---------
> >>  2 files changed, 14 insertions(+), 9 deletions(-)
> >> 
> >> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> >> index 9665bc6fcf..ef4ea84e69 100644
> >> --- a/docs/about/deprecated.rst
> >> +++ b/docs/about/deprecated.rst
> >> @@ -179,6 +179,11 @@ Use ``job-dismiss`` instead.
> >>  
> >>  Use ``job-finalize`` instead.
> >>  
> >> +``migrate`` argument ``detach`` (since 10.1)
> >> +''''''''''''''''''''''''''''''''''''''''''''
> >> +
> >> +This argument has always been ignored.
> >> +
> >>  ``query-migrationthreads`` (since 9.2)
> >>  ''''''''''''''''''''''''''''''''''''''
> >>  
> >> diff --git a/qapi/migration.json b/qapi/migration.json
> >> index 8b9c53595c..ecd266f98e 100644
> >> --- a/qapi/migration.json
> >> +++ b/qapi/migration.json
> >> @@ -1660,6 +1660,10 @@
> >>  #
> >>  # @resume: resume one paused migration, default "off".  (since 3.0)
> >>  #
> >> +# Features:
> >> +#
> >> +# @deprecated: Argument @detach is deprecated.
> >> +#
> >>  # Since: 0.14
> >>  #
> >>  # .. admonition:: Notes
> >> @@ -1668,19 +1672,14 @@
> >>  #        migration's progress and final result (this information is
> >>  #        provided by the 'status' member).
> >>  #
> >> -#     2. All boolean arguments default to false.
> >
> > There's one more boolean ("resume") exists, but probably not a huge
> > deal.. All booleans if not mentioned should have a default-false semantics
> > at least to me.
> 
> Its default remains documented.  It's visible above :)

Ah, indeed!

-- 
Peter Xu


