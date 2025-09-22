Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD3A4CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 10:39:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0dvx-0000g5-8p; Mon, 22 Sep 2025 06:38:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0dvv-0000fq-62
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:38:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1v0dvs-0004j1-MZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 06:38:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758537485;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=5XBhWgFAKXTqU3skqGTyp1zNW17oZO4Gh4amL3NQG6Y=;
 b=ipUAXTZU2C+1Fqe46S3OhZ0eO7I8Enu7am5Qv/QgdXJ/SwkAXdh3RwcjlGnNLcFlkduESN
 FM+b1h6S0xxR48asbE/SnRxhCHyXJryWMevD5h8NmTfwEXdt0nqc6ujn8BGqvgwHI0G9wO
 YazX+N8bxyY0GfhE2mmRyOWJVDj5Q+w=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-556-th3SJM1YPD68W4h7174MbA-1; Mon,
 22 Sep 2025 06:38:02 -0400
X-MC-Unique: th3SJM1YPD68W4h7174MbA-1
X-Mimecast-MFC-AGG-ID: th3SJM1YPD68W4h7174MbA_1758537481
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E4F89180048E; Mon, 22 Sep 2025 10:38:00 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7310C1800446; Mon, 22 Sep 2025 10:38:00 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A14E121E6A27; Mon, 22 Sep 2025 12:37:57 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Alessandro Ratti <alessandro@0x65c.net>
Cc: alex.bennee@linaro.org,  alessandro.ratti@gmail.com,  philmd@linaro.org,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2] virtio: Add function name to error messages
In-Reply-To: <20250915162643.44716-2-alessandro@0x65c.net> (Alessandro Ratti's
 message of "Mon, 15 Sep 2025 18:19:38 +0200")
References: <87a52wqa03.fsf@draig.linaro.org>
 <20250915162643.44716-1-alessandro@0x65c.net>
 <20250915162643.44716-2-alessandro@0x65c.net>
Date: Mon, 22 Sep 2025 12:37:57 +0200
Message-ID: <87h5wulqm2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Alessandro Ratti <alessandro@0x65c.net> writes:

> Replace virtio_error() with a macro that automatically prepends the
> calling function name to error messages. This provides better context
> for debugging virtio issues by showing exactly which function
> encountered the error.
>
> Before: "Invalid queue size: 1024"
> After:  "virtio_queue_set_num: Invalid queue size: 1024"
>
> The implementation uses a macro to insert __func__ at compile time,
> avoiding any runtime overhead while providing more specific error
> context than a generic "virtio:" prefix.

A need for function names and such in error messages suggests the error
messages are crap.

Consider the example above.  From users' point of view, the message
changes from gobbledygook to more verbose gobbledygook.  Was the error
the user's fault?  The guest's?  Something else's?  What can the user do
about it now?  If you need a developer to answer such questions, the
user interface is *dire*.

Clue: virtio_error() sets vdev->broken to true.  Did the device just
stop working?  If yes, shouldn't we tell the user?

Note that __func__ does not materially improve things even for developer
when the error message template string is unique.  Almost all are.

Fun example: "Region caches not initialized".  Three instances:

hw/virtio/virtio.c:        virtio_error(vdev, "Region caches not initialized");
hw/virtio/virtio.c:        virtio_error(vdev, "Region caches not initialized");
hw/virtio/virtio.c:            error_setg(errp, "Region caches not initialized");

Your patch adds __func__ in two out of three cases.  I'm not asking you
to add it to the third case, I'm only mentioning this to illustrate the
depth of the error reporting swamp around here.

I'll shut up now :)

> Also remove manual __func__ usage in virtio-balloon to avoid duplicate
> function names in error messages.
>
> Resolves: https://gitlab.com/qemu-project/qemu/-/issues/230
> Buglink: https://bugs.launchpad.net/qemu/+bug/1919021
>
> Signed-off-by: Alessandro Ratti <alessandro@0x65c.net>


