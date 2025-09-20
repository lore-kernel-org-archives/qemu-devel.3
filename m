Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81726CAC5A0
	for <qemu-devel@archiver.kernel.org>; Sat, 20 Sep 2025 07:13:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzrm8-0006SU-Nt; Sat, 20 Sep 2025 03:12:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzrm7-0006SK-HL
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 03:12:51 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzrm5-0007KE-FA
 for qemu-devel@nongnu.org; Sat, 20 Sep 2025 03:12:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758352367;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=H618VREXSlMwYytQJmC8jMk0EObI0K6NUtkVct1Xhrs=;
 b=NSkvdVGezPijE8GO+EIHacutoGcq1IHopQBasE2n392DmUp15gsCrIFeygxoNA8I91vAtk
 exIqGn2TJtU95CfYeDznNqgS5GdgKSzL/XN+/0vMf0U4zkGKDkMb2WgyAPgaelxljvpSx+
 sT7lzK7qXbuZ0bo+45e+XarEMqgi4gU=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-353-8izjuGYLOQKLoFcbNWj_fA-1; Sat,
 20 Sep 2025 03:12:44 -0400
X-MC-Unique: 8izjuGYLOQKLoFcbNWj_fA-1
X-Mimecast-MFC-AGG-ID: 8izjuGYLOQKLoFcbNWj_fA_1758352363
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 32BB11956086; Sat, 20 Sep 2025 07:12:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CDB701955F21; Sat, 20 Sep 2025 07:12:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0B26021E6A27; Sat, 20 Sep 2025 09:12:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Laurent Vivier
 <lvivier@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH] tests/qtest: optimize qtest_get_machines
In-Reply-To: <1758290310-349623-1-git-send-email-steven.sistare@oracle.com>
 (Steve Sistare's message of "Fri, 19 Sep 2025 06:58:30 -0700")
References: <1758290310-349623-1-git-send-email-steven.sistare@oracle.com>
Date: Sat, 20 Sep 2025 09:12:40 +0200
Message-ID: <87frchtx5j.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Steve Sistare <steven.sistare@oracle.com> writes:

> qtest_get_machines returns the machines supported by the QEMU binary
> described by an environment variable and caches the result.  If the
> next call to qtest_get_machines passes the same variable name, the cached
> result is returned, but if the name changes, the caching is defeated.
> To make caching more effective, remember the path of the QEMU binary
> instead.  Different env vars, eg QTEST_QEMU_BINARY_SRC and
> QTEST_QEMU_BINARY_DST, usually resolve to the same path.
>
> Before the optimization, the test /x86_64/migration/precopy/unix/plain
> exec's QEMU and calls query-machines 3 times.  After optimization, that
> only happens once.  This does not significantly speed up the tests, but
> it reduces QTEST_LOG output, and launches fewer QEMU instances, making
> it easier to debug problems.
>
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

I guess this is a followup to an observation I made during review of my
[PATCH 1/5] qtest/qom-test: Plug memory leak with -p:

    Message-ID: <87h5ymdzrf.fsf@pond.sub.org>
    https://lore.kernel.org/qemu-devel/87h5ymdzrf.fsf@pond.sub.org/

Appreciated!


