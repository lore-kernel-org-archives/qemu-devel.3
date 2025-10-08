Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09AC9CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Oct 2025 21:04:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6bIz-0008EH-9H; Wed, 08 Oct 2025 17:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bIw-0008Dw-11
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:02:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v6bIo-00071n-TT
 for qemu-devel@nongnu.org; Wed, 08 Oct 2025 17:02:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759957340;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bzhsJi918QjIWvjbNq6WV1Yubh7ju8mUHMYOlcZjem8=;
 b=Vk6cg5ILO3y6u9RWF3vGw91JH+YYvYwGTVbeH69KlVRHgCBq0R4rzxQXbtF1SFRmB7r4Xk
 jYIPCtuqjyYMGIUwLiXvlJlGNXDL2v0z/GdcUdIAgm6plKvXrVOE/h1Jp4rV0JW2XjhL4j
 7Tt9bL8Qf+m/Gjpg0TCOiI3GufOYqM0=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-pKk9mCRzPD-HsKT7iLUcwA-1; Wed, 08 Oct 2025 17:02:17 -0400
X-MC-Unique: pKk9mCRzPD-HsKT7iLUcwA-1
X-Mimecast-MFC-AGG-ID: pKk9mCRzPD-HsKT7iLUcwA_1759957337
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-4dbd8484abbso5192801cf.0
 for <qemu-devel@nongnu.org>; Wed, 08 Oct 2025 14:02:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759957337; x=1760562137;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bzhsJi918QjIWvjbNq6WV1Yubh7ju8mUHMYOlcZjem8=;
 b=LvwqF2bwkDX2aWjo2cWXH1Ol5/F5aU4F7H8QNrN4Wkz1tjs11jdSR9crnunhyDhq8H
 55Dqjsxpcn9ZwR0PQGiAthc97dwkngpgWZhH50dsnFBWeshd0/PEEPj8aqVqSJQFmnTK
 u+P+ughvsEwKG1xtHvXwxyqQfS3Tc/3pNkaxjD7n1GOOmwGeTtRE1pkRcdYweXq4+Tfc
 phoLLsg6ag5PwLdi5god3pTYuxAcwwuDMXW7aUivLb8Ha1F2AAHyZKVYjnqMX+erQ6o7
 seyhzMZDS6fIyGjCgJaCC6qWeng5jXWx1nqagE+XeRovMUXL0KluNnaux6Dvb0NUyrnQ
 +J2A==
X-Gm-Message-State: AOJu0Yywp50jaN5xU4FLUcUc/UJuyJEb4Zc8lcvZlwW/Xkff9c/S6NOt
 x8M3UAFof2I4eNIGs6iUEe7PIl9YZQpIHL7T9eTrJH3bOsuyYq5iBiWkCFdUYdO9zrxxFQVhwUT
 P7ng7455JyDd8oMze7GGv0LF6WXirvCKaKZtjo+nkqJRp/968KrAMUgeJ
X-Gm-Gg: ASbGncvnM/uNkK6Ib7ywLblADHGUaRewu80zrPDQKf12hVJw67dgo7oE0QBrTTTTaWm
 b5JEAIRyxfMRqzfPKGnon+TF8+RLkXjAdCAChfozJqHRNiogZH5JjEq0xI1dNu5g5UA45QAHMWZ
 JhXZwLsm+Hb3iUY5hiu5Z9zzEduSMLm3WlK63NpGxAmrLdyZ22VeuZc2v0JSAPKM30H9zuy9dbz
 RL7ZTXTOaohogeB44hG7J0xkbYHpKayFrEp9oaMAx1V3jMU2Mb1dXLXNYqN23tyQxN5MotQ9tB0
 sYT2ecqfCxmT37SSCgVAv3+elLqwkZpDF7EBkA==
X-Received: by 2002:ac8:5a84:0:b0:4b5:dc7c:a6ea with SMTP id
 d75a77b69052e-4e6ead5802emr74230221cf.49.1759957336821; 
 Wed, 08 Oct 2025 14:02:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGrcb/Kx1A70FpAkhdSX6QU4TdZFiHsIbMUnTJFbJC1WNueCvhU74RQ2q7YY7PzdLUbommAkQ==
X-Received: by 2002:ac8:5a84:0:b0:4b5:dc7c:a6ea with SMTP id
 d75a77b69052e-4e6ead5802emr74229681cf.49.1759957336346; 
 Wed, 08 Oct 2025 14:02:16 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-4e55a34b2c8sm166422861cf.1.2025.10.08.14.02.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 08 Oct 2025 14:02:15 -0700 (PDT)
Date: Wed, 8 Oct 2025 17:02:14 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Hailiang Zhang <zhanghailiang@xfusion.com>,
 Yury Kotov <yury-kotov@yandex-team.ru>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Prasad Pandit <ppandit@redhat.com>, Zhang Chen <zhangckid@gmail.com>,
 Li Zhijian <lizhijian@fujitsu.com>, Juraj Marcin <jmarcin@redhat.com>
Subject: Re: [PATCH RFC 5/9] migration: Thread-ify precopy vmstate load process
Message-ID: <aObRVr1TIgF8tw28@x1.local>
References: <20250827205949.364606-1-peterx@redhat.com>
 <20250827205949.364606-6-peterx@redhat.com>
 <aK-Z6rARUbgNzy5Q@gallifrey> <aLHXVadC-sjxmu8x@x1.local>
 <aLjthngB19Lae0p2@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aLjthngB19Lae0p2@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
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

On Thu, Sep 04, 2025 at 01:38:14AM +0000, Dr. David Alan Gilbert wrote:
> > > > In general, QEMUFile IOs should not need BQL, that is when receiving the
> > > > VMSD data and waiting for e.g. the socket buffer to get refilled.  But
> > > > that's the easy part.
> > > 
> > > It's probably generally a good thing to get rid of the BQL there, but I bet
> > > it's going to throw some surprises; maybe something like devices doing
> > > stuff before the migration has fully arrived
> > 
> > Is that pre_load() or.. maybe something else?
> > 
> > I should still look into each of them, but only if we want to further push
> > the bql to be at post_load() level.  I am not sure if some pre_load() would
> > assume BQL won't be released until post_load(), if so that'll be an issue,
> > and that will need some closer code observation...
> 
> Well maybe pre_load; but anything that might start happening once the
> state has been loaded that shouldn't start happening until migration ends;
> I think there are some devices that do it properly and wait for end of migration.
> 
> > > or incoming socket connections to non-migration stuff perhaps.
> > 
> > Any example for this one?
> 
> I was just thinking aloud; but was thinking of NIC activity or maybe
> UI stuff?  But just guesses.

I'll see if I can get some more test coverage to be slightly more
confident..  If you have any special setup / devices in mind that might be
prone to issues with this series, please let me know!  I can test them even
earlier.

We also always have the option to provide a knob, so that whenever
necessary we can still allow user to fallback to the coroutine way, until
it's proven solid..

Thanks,

-- 
Peter Xu


