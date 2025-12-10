Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14ED0D3C912
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 15:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTM07-0000qY-6Q; Wed, 10 Dec 2025 10:21:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTM05-0000qJ-0Z
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:21:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vTM03-0002Ms-Eq
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 10:21:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765380066;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=baI0R97TK7p89Se7UZgLUGIFQzkKB6QNLu84QeRtfkM=;
 b=ChC1TtYjSWaZCpw3xOZhq5PvCd/1AWQJR6aQ+ciMJhYXbo/xrXqDDqgd/uKvUZKQGaKONS
 4n5V07VzRhp2etaCVQ0fXnKUWxsrNY8RMQIpfxmrGOLpF3ZU7V5smxupLdoqDi4WtxyD6m
 2/qhFdni0mgLOimUI9meHNnh3BXGjd0=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-ykyo3MPIPUSyGkMP_68wbA-1; Wed, 10 Dec 2025 10:21:02 -0500
X-MC-Unique: ykyo3MPIPUSyGkMP_68wbA-1
X-Mimecast-MFC-AGG-ID: ykyo3MPIPUSyGkMP_68wbA_1765380062
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-882380bead6so184335966d6.0
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 07:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765380062; x=1765984862; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=baI0R97TK7p89Se7UZgLUGIFQzkKB6QNLu84QeRtfkM=;
 b=T7Sy6hjuHQk8vYt66tNejkUaMqg+N1ypmqelQVgL9DA2UEiF9QB4ZA1H1rQ8oGNGle
 qwIVNHS7fjzPN7iaFl4FTI0/s/Jr/4Bb9XCp66TDWpV67gkvNSZ4K7q9Ww5qDXlGB4Gf
 CZPY/GVJVnW1Y3juNj9zhvowo8+cXFgCnAfJqTadKztwjTChGDjNsuokJQQZl0ugfPd4
 veqlobUMNL1x0VoVleaKLIhKbeid7Nxkge07ZQy9/MHD0zh7cIt+ldyzHxOKt77NrzOy
 m0mtwtQZw0A91em46uo3hRsyVhyFzVh8daaaEuw2JiukYhbm6smDrWKEO2EGHi9Y7PTC
 hjBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765380062; x=1765984862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=baI0R97TK7p89Se7UZgLUGIFQzkKB6QNLu84QeRtfkM=;
 b=EMMqBqduxKCZX7Myk6EZ4TeK8jYrrfXEnO8UT5Q+Df9kmhGBBfWMsO/EZmzsZMOWLF
 JJCgUDPHR3Xb3XZXSpa8pFUEhaGn964nYUmlEMP419lVnfizLRPRvIaeRiY4XLKN+yUI
 fyk1TGgqJjd9EtUbT9BX0DqH+w7UpR0QyM2vqhq+Wzu8GxIL3g+36tXoM9m03XgbTXen
 +9XSxZ+ubIho7cd2OJAasy4eFQLcZDpqrzGljswBarmiiOtxg9To+UfoO1fkYbskEmsA
 MsX3d+FsVRpoMzmV8rzMiFzAo2oWUFXACaR8tcW8oFNFvxHhGkMdn0KmqBfC+qqiW3yt
 wXbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWgPiCwAvZy+7aAFGAAPYtOBCYsxPkjpAOdyAg/wx+lnUOzOe7URHQfmSEkgZyeOmzGXPO7wlUDv3ku@nongnu.org
X-Gm-Message-State: AOJu0Yzw/6+9O7ELjOP/N/9lmrk+SLZrPj63kygXVMPtGUTifwEft3E/
 D0hdG01X/KosTK9Vvd88JCznPi1qAgbRzqntvOpgI8uDm/YghH5zGFZIITcpinR063BNPfXjdL5
 +L/lAsKRIfXMn8Clk66KMDaapUSO8FbKDYiBrcqVVCB5BE5Qtvo95uGul
X-Gm-Gg: AY/fxX71FEluLZbeGttILLvP3/i25e9PgCz9J1l0lvpJB5Rlphl6ydxkWYVhgCVRAwz
 973TQxNGgv73YMsxbVupgG34r1SBT2jCi/LWIsggOmIhyXL2lcm7ibs1y43AS5aa3r7yQj20NHq
 Fd9FkbivDiSQFvj0PNI0AKz4aHQxxj9dgpWjwuSi7/C9wIbvos30BxsaElhvnJlzb6jDo2D+188
 a4BZ0eH1ZS5NQpNVdPNSPqZvooLkE8WuQ+dWCt4nZFLvFRw0+z9kLdWVEdyV45daldaXCK0i/r8
 dfZAlbwLr3k2NCYlRxM+cD17YDMGWPsE9U4HAWwx3UOXxaJ/BC8VwrqCjekBV+erP7+CMwuqMOl
 zA08=
X-Received: by 2002:a05:6214:5008:b0:78d:be82:fffa with SMTP id
 6a1803df08f44-88863ae1e9bmr41562856d6.33.1765380062264; 
 Wed, 10 Dec 2025 07:21:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEJ43k15khqnN4x+QGmUTCrrWxRQ3bRy+9zZadlNRwpuO9I7HBxk3t1PSvd1KSG4YrnWbjO5Q==
X-Received: by 2002:a05:6214:5008:b0:78d:be82:fffa with SMTP id
 6a1803df08f44-88863ae1e9bmr41562236d6.33.1765380061744; 
 Wed, 10 Dec 2025 07:21:01 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-88827f4cacasm149709426d6.16.2025.12.10.07.21.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 07:21:01 -0800 (PST)
Date: Wed, 10 Dec 2025 10:20:59 -0500
From: Peter Xu <peterx@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: Alexandr Moshkov <dtalexundeer@yandex-team.ru>, qemu-devel@nongnu.org,
 Raphael Norwitz <raphael@enfabrica.net>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH v3 0/3] vhost-user-blk: support inflight migration
Message-ID: <aTmP28XK0X1rvJRv@x1.local>
References: <20251110103937.1944486-1-dtalexundeer@yandex-team.ru>
 <cf0f69b9-4b2b-4c09-a32b-ad86bbe04f6d@yandex-team.ru>
 <aRztnfZFl-OcbVYI@x1.local>
 <d986f0ac-a0ae-44f6-b7a5-e002b7d3226e@yandex-team.ru>
 <aThTdgwsNexV9KAp@x1.local>
 <a8bff5ea-e1c3-4d4c-9ef7-93fa530bff0d@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <a8bff5ea-e1c3-4d4c-9ef7-93fa530bff0d@yandex-team.ru>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Dec 10, 2025 at 02:41:20PM +0300, Vladimir Sementsov-Ogievskiy wrote:
> Yes, it can. And regardless of the way we chose: qdev properties or qapi,
> I don't think we need a property for backend itself. We need a property
> (or migration capability) for vhost-user-blk itself, saying that its
> backend should be migrated.

The problem is then we need to introduce the new property to all frontends
that would support the backend?  If it's a backend property, it can be one
property for the backend that all the frontends can consume.

> 
> It's a lot simpler to migrate backend inside of frontend state. If we
> migrate backend in separate, we can't control the order of backend/frontend
> stats, and will have to implement some late point in state load process,
> where both are already loaded and we can do our post-load logic.

Would MigrationPriority help when defining the VMSD?

Thanks,

-- 
Peter Xu


