Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE0C4CE8D6B
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 10:50:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKwnr-0004gS-PL; Mon, 17 Nov 2025 05:49:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vKwnn-0004fh-Nz
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:49:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vKwnl-0008GG-FU
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 05:49:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763376580;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/zXlAOvVsodIYOwlIzfzI3HVyW6IQo8/qz0fT9t5rtQ=;
 b=FKhAV0QTkYzb7VnJHAFmkf4RrsnQJoaaPelfiB4FhknyLqAUVtB72d5sjHlKqVnZGVVQYR
 89bROo+NGwS9LrPxRGLH6ptb5EAzwOMV6lOqsbrnKUOdf617L/4qApcapKJ/4mdeaxMfV7
 dpemzBOKLY/8tU3B30PTiUw0NxQgVGM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-6-5bqSYHbWOvuJp4wE4rSkfA-1; Mon,
 17 Nov 2025 05:49:36 -0500
X-MC-Unique: 5bqSYHbWOvuJp4wE4rSkfA-1
X-Mimecast-MFC-AGG-ID: 5bqSYHbWOvuJp4wE4rSkfA_1763376575
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 782C918AB425; Mon, 17 Nov 2025 10:49:35 +0000 (UTC)
Received: from redhat.com (unknown [10.44.33.115])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E322A3003754; Mon, 17 Nov 2025 10:49:32 +0000 (UTC)
Date: Mon, 17 Nov 2025 11:49:30 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 armbru@redhat.com, eblake@redhat.com, hreitz@redhat.com
Subject: Re: [PATCH v9 4/7] qapi: add blockdev-replace command
Message-ID: <aRr9uuaz4FmEextJ@redhat.com>
References: <20240626115350.405778-1-vsementsov@yandex-team.ru>
 <20240626115350.405778-5-vsementsov@yandex-team.ru>
 <992e1551-6d75-441f-af6e-5df9e6c85c31@yandex-team.ru>
 <256e998c-c0bd-40b4-94bf-de25ac9c1b02@yandex-team.ru>
 <ZxJpx024fRqNsI2E@redhat.com>
 <ebbc334f-43d2-4a06-a3a0-5fa3c1266f52@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ebbc334f-43d2-4a06-a3a0-5fa3c1266f52@yandex-team.ru>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi Vladimir,

I remembered this series and wanted to check what the current status is,
because I seemed to remember that the next step was that you would send
a new version. But reading it again, you're probably waiting for more
input? Let's try to get this finished.

Am 02.04.2025 um 15:05 hat Vladimir Sementsov-Ogievskiy geschrieben:
> On 18.10.24 16:59, Kevin Wolf wrote:
> > If we want to get rid of the union, I think the best course of action
> > would unifying the namespaces (so that nodes, exports and devices can't
> > share the same ID) and then we could just accept a universal 'id' along
> > with 'child'.
> 
> Maybe we can go this way even without explicit restriction (which
> should some how go through deprecation period, etc), but simply look
> for the id among nodes, devices and exports and if found more than one
> parent - fail.
> 
> And we document, that id should not be ambiguous, should not match more
> than one parent object. So, those who want to use new command will care
> to make unique ids.

I don't think such a state is very pretty, but it would be okay for me
as an intermediate state while we go through a deprecation period to
restrict IDs accordingly.

So we could start with blockdev-replace returning an error on ambiguous
IDs and at the same time deprecate them, and only later we would make
creating nodes/devices/exports with the same ID an error.

Kevin


