Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E45CF43858
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Apr 2026 16:24:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wD31f-00010Q-Ih; Wed, 15 Apr 2026 12:23:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD31c-0000zs-Te
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:23:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wD31a-00050u-CX
 for qemu-devel@nongnu.org; Wed, 15 Apr 2026 12:23:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776270212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fFPbSRw1mOq72J72szuT2OZS3PuzeH5eik2GRyAc00U=;
 b=aDC9r2tNz8siTcPxfwItQCTToJwtMRIoA8qldVwb71jPYg3yeXjLaltePI6ZYYTuWfwKNd
 7fTMuv/ElpJU44EYiN0pAQJwAMaiC9p1W8tBuTK1TYmMrfC5jjl0Mog2eOZPXfb/VIylf5
 qg+DgyTaIOzQeqsPwHtyzq3UYbqHQko=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-299-tmuje5xHNLuhIjBHoVmWzQ-1; Wed, 15 Apr 2026 12:23:31 -0400
X-MC-Unique: tmuje5xHNLuhIjBHoVmWzQ-1
X-Mimecast-MFC-AGG-ID: tmuje5xHNLuhIjBHoVmWzQ_1776270210
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-8ac566014e0so190335206d6.2
 for <qemu-devel@nongnu.org>; Wed, 15 Apr 2026 09:23:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776270210; x=1776875010; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=fFPbSRw1mOq72J72szuT2OZS3PuzeH5eik2GRyAc00U=;
 b=NsNSUAxvLK1AuCvT6BQXhEsRDnSpzcPdK4vsSIXEZpIq9MvIDaTasIAIk1ihicXhDE
 uVcaW7k8xVwlYlBGbaJZpgP9K6ZOsVcH2eNBenM8TidetY/pBRtDE9Kqlef2s4jiPkJN
 NeZtj2NV8bAhoousjAVgLpzLw/tRHwAtTPvvRn0595n9LADj8abx/rf1QhOC80MiKp9M
 zScyt40RPH8fPzn/pN3CO37dqaV4gcCoCZcAZtFxW/1e7ALbJTl8Jqep0kzea1M9T1+X
 btR0uohlqoPqvc0C/06384C59U20tk52qSnaLvvxNnZ8h+6UwVcg9/D3TCYK3nAYD51x
 LHTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776270210; x=1776875010;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fFPbSRw1mOq72J72szuT2OZS3PuzeH5eik2GRyAc00U=;
 b=HSddUONqoLFc6pgiSkk1BA0YIHt6v1iZuabdobCa17jRJsSKw2W/R10q4TqlB6VgwT
 on58GGd2WfktwXz+Ib65FNo1/9npzuSBe6GsH80Yxta97oCnlUG2Dbhjks2+3diVoP8b
 2lRJ2QVm+VZURNCF0rfPR5H+/WTSfEIzdvyBP7Jl9tH8DXwZEYA0CjG3Oys4o917gGkH
 Sg7REJWchSB9PlkQJASxbRVsFNAuu0bPMWhaWsW2qD49mH5BbauxlXfMRBvdPdFBQHNy
 J9yls16V/ZfAPrfqJQsToLeAXuLbaLr6m/I4NGPFz5rZARxCYH6mDgqogNBbTHp7xYpr
 TEaA==
X-Gm-Message-State: AOJu0YwqjkqzvvGIG51iwWFfsjwr6OzksXyeSzyhHsWhZco01fylVNWL
 xt+ObnlBKDpydPK/4dzGQgKGHZudmyswcUlzKM7G2hF750AVLtrbxxPZTtsfGkVJDLQ2OzCnVs6
 9iSK7XMvvO6cu3uzYgMF0WhUW9N8WlmvQdKmoEsoEUQIU65Iu5s9HeWgs
X-Gm-Gg: AeBDies9vkXJRUbOb6UjlnTh6qdN5feaplI3Fkcu+ZfG71YvAvJb12BIwB1/TCI/THZ
 fIYLl9v2fI78nOhAk395R14FemZQU3QIv044P2J8OEuWhx/oaIZf7dkzsDYWLQ+q0EwsTjY/sOh
 hKB0z77AI4w+pYUvxHgByk0pUy1PEqJpy3uVbc6mkwiAtnhVes+St8GVkb9eAo8YkZQon+PgfJa
 0dKe9IfNBR+FIAO+Nop8yJwjXYfcnhWVUc+ZAwARCws7/AAlGYqUGxnO8upr6/DKDBqgClnXVqz
 V/gF6m1CXznJACTx/FtzNxXq5/8gqv180KZVAi4eJaaMlti7Z01vd9RDRVTQma9nWkvEAiI6FTU
 2KVdB6h7b/qmdH50sxesBfeIzShjnn58g4j7OCUgD7J/hGAnz0eTa2NvYdg==
X-Received: by 2002:a05:6214:4497:b0:8a0:22bb:1d51 with SMTP id
 6a1803df08f44-8ac8624e071mr344843686d6.53.1776270210270; 
 Wed, 15 Apr 2026 09:23:30 -0700 (PDT)
X-Received: by 2002:a05:6214:4497:b0:8a0:22bb:1d51 with SMTP id
 6a1803df08f44-8ac8624e071mr344842996d6.53.1776270209608; 
 Wed, 15 Apr 2026 09:23:29 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ae6cb9eb66sm15274976d6.31.2026.04.15.09.23.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 15 Apr 2026 09:23:28 -0700 (PDT)
Date: Wed, 15 Apr 2026 12:23:27 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Prasad Pandit <ppandit@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>, Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>
Subject: Re: [PATCH 04/14] migration/treewide: Merge
 @state_pending_{exact|estimate} APIs
Message-ID: <ad-7f30zV6XfYEE1@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-5-peterx@redhat.com>
 <adfdUBTJweN-V-ZP@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adfdUBTJweN-V-ZP@fedora>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Thu, Apr 09, 2026 at 07:10:56PM +0200, Juraj Marcin wrote:
> > -    /**
> > -     * @state_pending_exact
> > -     *
> > -     * This calculates the exact remaining data to transfer
> > +     * @save_query_pending
> >       *
> > -     * Sum of @can_postcopy and @must_postcopy is the whole amount of
> > -     * pending data.
> > +     * This estimates the remaining data to transfer on the source side.
> > +     * It's highly suggested that the module should implement both fastpath
> > +     * and slowpath version of it when it can be slow (for more information
> > +     * please check pending->fastpath field).
> 
> There is no pending->fastpath field anymore.

Yep I missed it..  When at it, I rewrote this part to make it read better,
latest version now:

    /**
     * @save_query_pending
     *
     * This estimates the remaining data to transfer on the source side.
     *
     * When @exact is true, a module must report accurate results.  When
     * @exact is false, a module may report estimates.
     *
     * It's highly recommended that modules implement a faster version of
     * the query path (for example, by proper caching on the counters) if
     * an accurate query will be time-consuming.
     *
     * @opaque: data pointer passed to register_savevm_live()
     * @pending: pointer to a MigPendingData struct
     * @exact: set to true for an accurate (slow) query
     */


[...]

> Apart from that one comment above, it looks good to me!
> 
> Reviewed-by: Juraj Marcin <jmarcin@redhat.com>

Thanks, Juraj!

-- 
Peter Xu


