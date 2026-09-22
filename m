Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06367C98302
	for <qemu-devel@archiver.kernel.org>; Tue, 22 Sep 2026 13:53:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x90vM-0003LG-I1; Tue, 22 Sep 2026 09:52:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x90vK-0003JO-M0
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 09:52:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1x90vI-00014C-0N
 for qemu-devel@nongnu.org; Tue, 22 Sep 2026 09:52:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1790085158;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XQL4SDuelpCmtPBj0BTsrL4ETRByUxqewG6IhdtTbvw=;
 b=NnC388zEc2yajXxZicpTey11FTFGJfs38ENJGg0clKDaZPgm7D80zqGBDqsmm0LmeuhX9q
 o932F8RrYYo5bCWj87aQcbm1s6hw+WS2Duw8K5+FIeKl8ryyA15HYxyct6kOUxTPNuqZ1+
 jjK7mqngP3Q31Q7lkK+U9PwMa5JY1Tw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-34-gDDtak71MTG9K3hZJFNZ5g-1; Tue,
 22 Sep 2026 09:52:35 -0400
X-MC-Unique: gDDtak71MTG9K3hZJFNZ5g-1
X-Mimecast-MFC-AGG-ID: gDDtak71MTG9K3hZJFNZ5g_1790085154
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C881D182A11E; Tue, 22 Sep 2026 13:52:33 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.148])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB48F195604E; Tue, 22 Sep 2026 13:52:30 +0000 (UTC)
Date: Tue, 22 Sep 2026 15:52:28 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Alberto Garcia <berto@igalia.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 "Denis V . Lunev" <den@openvz.org>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 8/9] block/accounting: Move latency_ns override down
Message-ID: <arKIHIneJEkNNjRM@redhat.com>
References: <20260831135206.126184-1-hreitz@redhat.com>
 <20260831135206.126184-9-hreitz@redhat.com>
 <20260903150842.GF825275@fedora>
 <292ff2f9-b3fe-423b-9b36-ada26904a617@redhat.com>
 <20260921204237.GD115897@fedora> <arJ8tNgp9tDtKkfO@redhat.com>
 <w51mrt9tn76.fsf@igalia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <w51mrt9tn76.fsf@igalia.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Am 22.09.2026 um 15:44 hat Alberto Garcia geschrieben:
> On Tue 22 Sep 2026 03:03:56 PM +02, Kevin Wolf wrote:
> > Am 21.09.2026 um 22:42 hat Stefan Hajnoczi geschrieben:
> >> On Wed, Sep 16, 2026 at 10:21:22AM +0200, Hanna Czenczek wrote:
> > What's even stranger is that both things were introduced in the same
> > commit. But it seems clearly related to 136 because the change was made
> > right before the test was added.
> >
> > Berto, do you remember why you didn't rely just on clock_step?
> 
> No, sorry, I don't remember :-/ I guess I wasn't familiar with that
> function? 136 was one of the first tests that I wrote.

I thought so at first, too, but then I saw that other places in the same
test do use it.

Anyway, thanks for the quick reply. Then let's just try out what breaks
if we change it. :-)

Kevin


