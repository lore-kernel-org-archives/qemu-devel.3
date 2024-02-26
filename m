Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67CC9C5478C
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 07:40:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reVbE-0007KW-UK; Mon, 26 Feb 2024 02:40:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVbD-0007KN-FD
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:40:31 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1reVbC-00053e-0x
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 02:40:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708933229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cKvVn0Tip1ZPsINB1Vb5WetxV9NRHG/fyev4wfeLWf8=;
 b=N6R+hP6djPPyTzPNNjqMiZyaMqX7tHmmTJZIehskoBWe+Z0Kn9tBI48I5gWyl4Mzg9i0dP
 Wonmce7sKM7kxj8zK2+vqJYt15FZ40Zhwm/Z6ENOeRW33Ub7mLVY35koJEMaaGnnEUddtW
 uwxnmH8MA7mflKZtCICY5zCaV4cM9MI=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-632-Dv1iRypWMV-Twu5TPsj53Q-1; Mon,
 26 Feb 2024 02:40:28 -0500
X-MC-Unique: Dv1iRypWMV-Twu5TPsj53Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id C427F28EC106;
 Mon, 26 Feb 2024 07:40:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.193.4])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 9F7CD1121312;
 Mon, 26 Feb 2024 07:40:27 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 635DE21E66F4; Mon, 26 Feb 2024 08:40:20 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Peter Xu <peterx@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Leonardo Bras <leobras@redhat.com>
Subject: Re: [PATCH V1] migration: export fewer options
In-Reply-To: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 23 Feb 2024 09:13:24 -0800")
References: <1708708404-197951-1-git-send-email-steven.sistare@oracle.com>
Date: Mon, 26 Feb 2024 08:40:20 +0100
Message-ID: <87cysjllln.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

Steve Sistare <steven.sistare@oracle.com> writes:

> A small number of migration options are accessed by migration clients,
> but to see them clients must include all of options.h, which is mostly
> for migration core code.  migrate_mode() in particular will be needed by
> multiple clients.
>
> Refactor the option declarations so clients can see the necessary few via
> misc.h, which already exports a portion of the client API.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
> I suggest that eventually we should define a single file migration/client.h
> which exports everything needed by the simpler clients: blockers, notifiers,
> options, cpr, and state accessors.
> ---
> ---
>  hw/vfio/migration.c             |  1 -
>  hw/virtio/virtio-balloon.c      |  1 -
>  include/migration/misc.h        |  1 +
>  include/migration/options-pub.h | 24 ++++++++++++++++++++++++
>  migration/options.h             |  6 +-----

Unusual naming.  We have zero headers named -pub.h or -public.h, and
dozens named like -int.h or -internal.h.  Please stick to the existing
convention.

[...]


