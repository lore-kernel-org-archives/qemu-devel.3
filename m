Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4D870C48BEB
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:48:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoah-0001Rk-CQ; Wed, 21 Feb 2024 10:32:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rcoTw-00088G-D6
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:26:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rchta-0002Zv-UV
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 03:24:04 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708503837;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o3PsEXYR947T0UX4nW866y8pC0Gophy84Mt6DrFM8Xw=;
 b=dvUB3wQr+TBMnes7CA57uNarvrXxN+DVo/rQ886wpIfkVQnItTO6nLIQwx8YBMZBEz0hR9
 9dJjAK/5DEEGyt1NP0K8T/RzwEVb76644Z72UB+Dn63Y7ho5vTtYKaaTw+Cjm9m4aEZ5to
 bt91eWMGvkBzZkWftmuRLwX2KzRtMR8=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-570-MBJzYqmtNM2bZkgteIxHBQ-1; Wed,
 21 Feb 2024 03:23:55 -0500
X-MC-Unique: MBJzYqmtNM2bZkgteIxHBQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com
 [10.11.54.8])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7134F28B7405;
 Wed, 21 Feb 2024 08:23:55 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4FA72C185D2;
 Wed, 21 Feb 2024 08:23:55 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1E12A21E66D5; Wed, 21 Feb 2024 09:23:54 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Het Gala <het.gala@nutanix.com>
Cc: Markus Armbruster <armbru@redhat.com>,  qemu-devel@nongnu.org,  Peter Xu
 <peterx@redhat.com>,  Fabiano =?utf-8?Q?Fid=C3=AAncio?=
 <fabiano@fidencio.org>,  Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH] qapi: Misc cleanups to migrate QAPIs
In-Reply-To: <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com> (Het Gala's
 message of "Wed, 21 Feb 2024 12:36:57 +0530")
References: <20240216195659.189091-1-het.gala@nutanix.com>
 <87edd61ezt.fsf@pond.sub.org>
 <b1ce8254-24e8-487e-8da0-d8916f53fcb4@nutanix.com>
Date: Wed, 21 Feb 2024 09:23:54 +0100
Message-ID: <87a5nuz0md.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.8
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Het Gala <het.gala@nutanix.com> writes:

> Sorry Markus, firstly I thought its just regarding qapi documentation so migration maintainers might not be needed ? but then I realize the commit message fails to specify that
>
> IIRC, you are one of the maintainers for qapi. So, just cc'd to you, but you are right, should have done to migration maintainers also.

Cc'ing me was definitely appropriate.

You can use scripts/get_maintainer.pl to help you figugure out who to
cc.  For this patch, its output is

    Eric Blake <eblake@redhat.com> (supporter:QAPI Schema)
    Markus Armbruster <armbru@redhat.com> (supporter:QAPI Schema)
    Peter Xu <peterx@redhat.com> (maintainer:Migration)
    Fabiano Rosas <farosas@suse.de> (maintainer:Migration)
    qemu-devel@nongnu.org (open list:All patches CC here)

> Have we got the wrong Fabiano here ? Isn't Fabiano Rosas the migration maintainer ?

We do!  Butterfingers...

> cc'ing to Fabiano Rosas too.

Thanks for paying attention :)


