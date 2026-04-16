Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDB37F8D765
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Apr 2026 18:25:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wDROw-0001FF-TD; Thu, 16 Apr 2026 14:25:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDROu-0001Ef-4h
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:25:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wDROr-0004bq-Uj
 for qemu-devel@nongnu.org; Thu, 16 Apr 2026 14:25:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776363911;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wC+/19WUKqFmEdg5f6qxQGVzDz4SfRctKemzsIP2jZQ=;
 b=e6tjvkX46CbqarE30pLedsZJaJrOogWyJqYliUc6RXC78STX6BqCQGmLzD+0XgHz2CLPyD
 dSyDeE2TTte7yBIYCKqLD+TrqTZWb+2f+QEI5yo17pPz7NZXnVComgjMj0hyzh+350GvVp
 R+1ukUF+1e6P7uGOTWU6gi7wpvX6jOs=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-421-kbpT07h1Nc-xNch-4vHHYA-1; Thu, 16 Apr 2026 14:25:09 -0400
X-MC-Unique: kbpT07h1Nc-xNch-4vHHYA-1
X-Mimecast-MFC-AGG-ID: kbpT07h1Nc-xNch-4vHHYA_1776363909
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-50da31af14cso18454661cf.1
 for <qemu-devel@nongnu.org>; Thu, 16 Apr 2026 11:25:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776363909; x=1776968709; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=wC+/19WUKqFmEdg5f6qxQGVzDz4SfRctKemzsIP2jZQ=;
 b=dj2n8JIwNTUAQ6lDzkqqqPyeyrvdVRyK96eee2LvAixiLNNJuEN6sPNLVJXHH7IbLv
 jgMXyYxbgrxUmuPCQ0kUpYvhV2D65nkILRHiVsacXgkALFWJhE3uF0TkBwjAemizbYdP
 zlz3osj3UQKHD/z28X54cwShIMWA30fCMdbqbef1BRdfOM3RgMH/0ZEdlY6I+HgwgiuF
 y8yfEx3EVigMW/LkvP29m1ZS8nOuBYdizG9Jn38QzPyEhUq2uTnX6pcj6zm1zClwJb7W
 7kl3oSXqVVcMikZ6MMQ6ehbgzIZ75H2qJgbEZNX1hTotkD5dCtW73G5bF6xO8ZdLmIZx
 8bSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776363909; x=1776968709;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wC+/19WUKqFmEdg5f6qxQGVzDz4SfRctKemzsIP2jZQ=;
 b=oLrMaBF46PNCrXax6/cdyHsAKXdFOhYtB1xgK0stmWPgOx4Gi3iDSDhuA/iti/mkS0
 kWX5eAhsuus8UyBG/JQ40xfZLbl2uxzhCvWo0ejr6XRyADLhKn6cBmvS2Lb04rQceIdN
 VtgKBfLQNpwPsF5RJvvotc24d2fmQfHCmRT5fvMDxf//OZzJP8gEe9k7kWIWxRShFniT
 jN4SLBbPCCEtE0hk+MWtcAyl5paGAOXK1pfgY4vM3d5tcmnWsDHid6OioyMWwS7BmeLv
 PBBeMvDSND9wgbirbEZYoFp0ANFaZOdh/G//A6kI6uQ/UqAhMgID7c8c99UzrosWXj86
 Oq6Q==
X-Gm-Message-State: AOJu0Yyu0w3irJL8n0z6eraFvPZHugGOlRXdG1x+DC5JO0kUoQC21qdp
 SS+g6Rw43wLt0z/3+ccTcAYATr1KeKOEvMnL2r9RA6JoeZUH17PPYLO2lV94YIy2MBtXOfT1QUg
 2CXAGq7u1TLjQTcLn4CYCStyArN6AW82Cs/Pl44TURRdrMQHduA9JAECz
X-Gm-Gg: AeBDietT6oiv2V2hgYXWYUe9aCxA3ZYwcTlNv8N5cQax2mFxecCntGaSEoQOB4LMj0R
 HROA4a4K99GOgqt0tAKLlTl9ZlrfKSis+x5iYVxMQPogfrKLDEPPyozQMg/sX/UdxCYLVKCoYw0
 exqXo1mdUwAcuX24AfzA6lwiu53JazvV0tlTMRNTb4lzwvU1YxFimacWkSB9/VlYz/rq/QU4lgj
 1gsfuJMBhxh/nInMANFF823vm7GQHYBmnz40gK8hjckJw5Yv3lLFPJwGLZlhOYoer6bFFa/kdFw
 h81erI6PPx8eLRiZfMqJmE7GhgwlpSWMXuF0R8tyJu7qGn2ExcVQ8GmVh8UN5D72LwK5YBe+8nr
 XK8JIC4D+PeEDTFXUsaDzocYn+vJRNqT2U5WTxkzOLgNf+Jed+lyOfKF7Tg==
X-Received: by 2002:ac8:5f4b:0:b0:50d:ef97:f1d8 with SMTP id
 d75a77b69052e-50e34a0020emr2968231cf.38.1776363908635; 
 Thu, 16 Apr 2026 11:25:08 -0700 (PDT)
X-Received: by 2002:ac8:5f4b:0:b0:50d:ef97:f1d8 with SMTP id
 d75a77b69052e-50e34a0020emr2967401cf.38.1776363907974; 
 Thu, 16 Apr 2026 11:25:07 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50e1af9e0bcsm43061391cf.15.2026.04.16.11.25.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Apr 2026 11:25:07 -0700 (PDT)
Date: Thu, 16 Apr 2026 14:25:06 -0400
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org, "Maciej S . Szmigiero" <mail@maciej.szmigiero.name>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Zhiyi Guo <zhguo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 Prasad Pandit <ppandit@redhat.com>, Avihai Horon <avihaih@nvidia.com>,
 Kirti Wankhede <kwankhede@nvidia.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Joao Martins <joao.m.martins@oracle.com>,
 Markus Armbruster <armbru@redhat.com>, Alex Williamson <alex@shazbot.org>
Subject: Re: [PATCH 13/14] migration/qapi: Introduce system-wise "remaining"
 reports
Message-ID: <aeEpgnoEIJA4bdow@x1.local>
References: <20260408165559.157108-1-peterx@redhat.com>
 <20260408165559.157108-14-peterx@redhat.com>
 <adgeySiEoXBWRpOl@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <adgeySiEoXBWRpOl@gallifrey>
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

On Thu, Apr 09, 2026 at 09:48:57PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > Currently, mgmt can only query for remaining RAM, not system-wise remaining
> > data.  It was not a problem before, because for a very long time RAM was
> > the only part that matters.
> > 
> > After VFIO migrations landed upstream, it may not be true anymore
> > especially considering that there can be GPU devices that contain GBs of
> > device states.
> > 
> > Add a new "remaining" field in query-migrate results, reflecting
> > system-wise remaining data, which will include everything (e.g. VFIO).
> 
> Of course you realise the next thing people will ask for is being able
> to ask *which* vfio device is the one that's busy.

Heh, true..

Since so far this effort is led by a requirement to detect migration stalls
with VFIO devices attached, I'll try to keep this API as simple as
possible, until someone else complains with another good reason..

> 
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>

Thank, Dave.

-- 
Peter Xu


