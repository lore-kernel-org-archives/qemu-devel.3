Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C4F1C4829C
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Feb 2024 06:53:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rXyHR-0000H1-2o; Thu, 08 Feb 2024 01:53:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXyHP-00009B-UO
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 01:53:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rXyHO-0007SZ-Hz
 for qemu-devel@nongnu.org; Thu, 08 Feb 2024 01:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1707375181;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=r9M6kqEmduSJXPFdjped99vZja+7s0yi6zgsd83xw/0=;
 b=XMnE522ShkrwuZiIVK13VwPtPlNn1RwWDF8559M+XfiuRenF2L5fY5mEKJMxkB5aLAQnVX
 Pg/OeI8NLvv4lA/5eXQVirESh1iTGIxR0BHburJkEFMoRYoqNbHi+b72J7DLtVdkMfIJ+U
 Ma1aE58LYKDmvTQ3BuXPnEMkvNkxWkI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Qp0bURbhOnuK1JhN9qaauw-1; Thu, 08 Feb 2024 01:53:00 -0500
X-MC-Unique: Qp0bURbhOnuK1JhN9qaauw-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E712885A588;
 Thu,  8 Feb 2024 06:52:59 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.123])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id C732B40D1B60;
 Thu,  8 Feb 2024 06:52:59 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E5C3421E66D0; Thu,  8 Feb 2024 07:52:58 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org,  marcandre.lureau@redhat.com,
 pbonzini@redhat.com,  devel@lists.libvirt.org
Subject: Re: [PATCH 2/4] tests/unit/test-char: Fix qemu_socket(),
 make_udp_socket() check
In-Reply-To: <xtjhv5rzpzzdebjwnefbin44ubygp35yqlyuoo3v6tw77qyhgq@dbw2rzuxulga>
 (Eric Blake's message of "Wed, 7 Feb 2024 13:45:39 -0600")
References: <20240203080228.2766159-1-armbru@redhat.com>
 <20240203080228.2766159-3-armbru@redhat.com>
 <xtjhv5rzpzzdebjwnefbin44ubygp35yqlyuoo3v6tw77qyhgq@dbw2rzuxulga>
Date: Thu, 08 Feb 2024 07:52:58 +0100
Message-ID: <871q9njvlh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.106,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Eric Blake <eblake@redhat.com> writes:

> On Sat, Feb 03, 2024 at 09:02:26AM +0100, Markus Armbruster wrote:
>> qemu_socket() and make_udp_socket() return a file descriptor on
>> success, -1 on failure.  The check misinterprets 0 as failure.  Fix
>> that.
>> 
>> Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> ---
>>  tests/unit/test-char.c | 4 ++--
>>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> Reviewed-by: Eric Blake <eblake@redhat.com>
>
> Might be worth amending the commit message of 1/4 where you called out
> this bug to mention it will be fixed in the next patch.

Yes.  Thanks!


