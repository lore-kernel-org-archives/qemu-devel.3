Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBCEAC282DE
	for <qemu-devel@archiver.kernel.org>; Thu,  6 Mar 2025 07:52:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tq61M-0004Ez-HN; Thu, 06 Mar 2025 02:51:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tq61K-0004EX-Bw
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:51:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tq61I-0005PI-9z
 for qemu-devel@nongnu.org; Thu, 06 Mar 2025 02:51:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741247510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jjqcf7kHu3fOO9U5lBVH4PhxuVgF9s6AgP4Ojtz5bHE=;
 b=GwLzSG0bB/gfI4bQrktM6OmgiC9j6OecOugtX14fm4V7tcGI6w2Sw8VUZ53YaMpEMTnqCs
 r0s6mUilqCyX7O3MXEERWE3X8HI66tsgzkrknmIhLyD3mQmYYHVqEEeZFcH2nYY4PHvY/R
 xev/6zKmct5mGDA99yYDSsQJwg+TLfs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-LHLnkpReOqSrH4v-8vaSXw-1; Thu, 06 Mar 2025 02:51:42 -0500
X-MC-Unique: LHLnkpReOqSrH4v-8vaSXw-1
X-Mimecast-MFC-AGG-ID: LHLnkpReOqSrH4v-8vaSXw_1741247502
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43943bd1409so2164795e9.3
 for <qemu-devel@nongnu.org>; Wed, 05 Mar 2025 23:51:42 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741247501; x=1741852301;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=jjqcf7kHu3fOO9U5lBVH4PhxuVgF9s6AgP4Ojtz5bHE=;
 b=gowBARGQlB2d9r5VK7crxwuC3TYggDjKW/wZq4esAknHRYh6Ijeg7AvBXEwcYepIQ6
 QgK7LxAchv0QQxqXlVD8V2kmiq7SomBIw0d5PUS09xnga7jK7IO2Ej4iub2n/HbeJa0H
 Lr18/tBgWRwazZ/Wgwal85h5oeNmRBIwLppv7i5ZFpqMKprobCKvyKhFI+ypXRtZmKvK
 3qxWpvzoTfKVlx7fyRakwoHexbQX8g3ZpaZTVgU4DfQAow5+ltBP634ar3WTO0DcnpTs
 Rq47i6Ja+uEM3uilSX9xCqGURledHVGLZqP+FaaO8lU1CRW5ZfH4rJSb38XmeuTVGkcl
 UKOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXQC1lartLiBTPQRlk9dpLpqsR3611dCh5BlQNf1hLAolLmosEf49fVaFPWXXjIVNhaVUZDN0+zBvtx@nongnu.org
X-Gm-Message-State: AOJu0YyrV0+aWPCP2g1tJ6XZHfLuCan2DSXtDXOqbpEk2zOz68zb1+YQ
 fdaeVSaYzLEEk2taL3cg5FL5ycJikFsbaVQtjH+LAuT3S8ApcqckCgL2yMvc8aFQMZ/Z2sBCap2
 906VcWDl/POGQpDlZEQLC9GBaab/GC2lAz7Xov8PqRYkDnnjbJVsqHpUwDSbMRkner1NNFLr6a6
 Snmqnxqgat6sUWAsgVg/jTK3RgPU0=
X-Gm-Gg: ASbGnctJpXrqv2N+XqmXSQYTdid0QJmxG+weprxC9hDgA7jaKZ4SgDbYgz1Lzth5bFW
 +EqNmTi9+waUJfZdNx7Py3e4BEu7wd3rRp0qso+HYjNWEJIFxY3PBeQY2Ab4btroo/r6a3/149d
 Y=
X-Received: by 2002:a05:600c:3b16:b0:43a:b0ac:b10c with SMTP id
 5b1f17b1804b1-43bd2ae5c02mr40037225e9.26.1741247501592; 
 Wed, 05 Mar 2025 23:51:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEc5/3QEPguplSVcF3V7nS3/t8B6dzaRa7r6mJns6xFlMuRT2pfHtaZqmX7+j/veIK4nWziuWYPCI9gSlmRc2g=
X-Received: by 2002:a05:600c:3b16:b0:43a:b0ac:b10c with SMTP id
 5b1f17b1804b1-43bd2ae5c02mr40037065e9.26.1741247501296; Wed, 05 Mar 2025
 23:51:41 -0800 (PST)
MIME-Version: 1.0
References: <20250228121749.553184-1-ppandit@redhat.com>
 <87frjy2k8z.fsf@suse.de>
 <CAE8KmOwVoGJ2frVCY76W7UxSr90wAL2EMj5Nmtcrdc+BE1e9=g@mail.gmail.com>
 <Z8W4xVOLLAD1wXjC@x1.local>
 <CAE8KmOzkVpG5iUqwShWWMF4+96-cbNm1AU8b=s3187EyWXXT4g@mail.gmail.com>
 <Z8cRYO1Kacl7vl-I@x1.local>
 <CAE8KmOyrSidELiHAtegX16gYbW6jWKL7m9YGJKzfmLbZ9x8Xaw@mail.gmail.com>
 <878qpjvaw5.fsf@suse.de>
In-Reply-To: <878qpjvaw5.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 6 Mar 2025 13:21:24 +0530
X-Gm-Features: AQ5f1Jrcuj07xvhMnF6y_RxX4afLUbOXgwktxQmiq3FxbEs0cA9S1YjqKcRLU1U
Message-ID: <CAE8KmOxEXLnUxhJCr7T0nVozZcLSb1WaKNfzZhrig2zYkGMktw@mail.gmail.com>
Subject: Re: [PATCH v7 0/5] Allow to enable multifd and postcopy migration
 together
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, berrange@redhat.com, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.129.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Hello Fabiano,

On Wed, 5 Mar 2025 at 19:26, Fabiano Rosas <farosas@suse.de> wrote:
> Note that none of this is out of the ordinary, you'll find such
> discussions in any thread on this community. It may feel arbitrary to
> you because that's tacit knowledge we gathered along the years.

* I understand. I don't find it arbitrary.

> We need an extra patch that reads:
>
>  migration: Refactor channel discovery mechanism
>
>  The various logical migration channels don't have a standardized way of
>  advertising themselves and their connections may be seen out of order
>  by the migration destination. When a new connection arrives, the
>  incoming migration currently make use of heuristics to determine which
>  channel it belongs to.
>
>  The next few patches will need to change how the multifd and postcopy
>  capabilities interact and that affects the channel discovery heuristic.
>
>  Refactor the channel discovery heuristic to make it less opaque and
>  simplify the subsequent patches.
>
>  <some description of the new code which might be pertinent>
>  ---
>
> You'd move all of the channel discovery code into this patch. Some of it
> will be unreacheable because multifd is not yet allowed with postcopy,
> but that's fine. You can mention it on the commit message.

Please see:
    -> https://privatebin.net/?dad6f052dd986f9f#FULnfrCV29NkQpvsQyvWuU4HdYjDwFbUPbDtvLro7mwi

* Does this division look okay?

> About moving the code out of migration.c, it was a suggestion that
> you're free to push back. Ideally, doing the work would be faster than
> arguing against it on the mailing list. But that's fine.

* Same here, I'm not against moving that code part to connection.c OR
doing the work. My suggestion has been to do that movement in another
series and not try to do everything in this one series.

> About the hang in the test. It doesn't reproduce often, but once it
> does, it hangs forever (although I haven't waited that long).

* Okay, I'm not seeing it or able to reproduce it across 3 different
machines. One is my laptop and the other 2 are servers wherein I'm
testing migrations of guests with 64G/128G of RAM and guest dirtying
memory to the tune of 68M/128M/256M bytes. I'll keep an eye on it if I
find something.

Thank you.
---
  - Prasad


