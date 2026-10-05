Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 422E5CA5FF0
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 22:05:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDqnR-0000Go-FN; Mon, 05 Oct 2026 18:04:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDqnO-0000GB-Ns
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 18:04:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDqnN-0004jy-3H
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 18:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791237867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ElwfLK4I6tA6MHPhVqf7xfSj5Z4og465c8eWqEahqZ8=;
 b=cIn0Kz1soYTDzo9HLFgHuc4xQ3N2KCSVNlfsyCHPjBMxXBbLWZkYH2NtCUTmeQKzieRRt8
 pPJxMU3WD7ouxDdK6qaU1Z22PRsYYnb46lYUiqU21guWqmKWPfbubVfuZ8F1UBTlaQh1Fm
 JMjXwU2yd5ME8zIpMznC+GOTw2/ndvM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-395-0MsMiYqhOfy6uNwvM7GRJw-1; Mon,
 05 Oct 2026 18:04:24 -0400
X-MC-Unique: 0MsMiYqhOfy6uNwvM7GRJw-1
X-Mimecast-MFC-AGG-ID: 0MsMiYqhOfy6uNwvM7GRJw_1791237863
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 92157180AEED; Mon,  5 Oct 2026 22:04:22 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DD203001D2E; Mon,  5 Oct 2026 22:04:20 +0000 (UTC)
Date: Mon, 5 Oct 2026 17:04:17 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@virtuozzo.com>
Cc: "Denis V. Lunev" <den@openvz.org>, qemu-devel@nongnu.org, 
 qemu-block@nongnu.org, Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH v3 0/9] block: cheaper zero handling in backup and commit
Message-ID: <asQeay3yVze-ELxa@redhat.com>
References: <20260929155125.3151111-1-den@openvz.org>
 <127bf797-defd-46bf-9aa2-063f15152cfc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <127bf797-defd-46bf-9aa2-063f15152cfc@virtuozzo.com>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
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

On Mon, Oct 05, 2026 at 10:59:11AM +0200, Denis V. Lunev wrote:
> On 9/29/26 17:51, Denis V. Lunev wrote:
> > This email originated from an IP that might not be authorized by the domain it was sent from.
> > Do not click links or open attachments unless it is an email you expected to receive.
> > Backup and commit re-query the source block status for every task and
> > size a task by the copy buffer, so a long run of zeroes turns into a
> > crowd of small write-zeroes requests. This series reuses what the
> > up-front scan already learned and lets one write-zeroes task cover a
> > whole run.
> >
> > Backup of a 16G qcow2 image holding 1G of data, the rest never
> > allocated, sync=full to a raw target on ext4:
> >
> >                tasks    time
> >     before     16384    1.6s
> >     after       1088    1.0s
> >
> > Such an image is the normal case rather than a corner one: a guest with
> > discard enabled on a disk which is mostly free leaves exactly this
> > shape behind.

> ping

It looks like this series is fully reviewed; I also took a look at it
and didn't spot anything to add. I plan on queueing into a pull
request shortly.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


