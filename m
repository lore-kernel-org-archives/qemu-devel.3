Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70B57C44520
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Jul 2026 12:30:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wln7X-0007dQ-AJ; Mon, 20 Jul 2026 08:29:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wln7W-0007dH-MZ
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:29:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wln7U-000158-Q6
 for qemu-devel@nongnu.org; Mon, 20 Jul 2026 08:29:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784550554;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=i7mcpZP/6fNzDDj7JoWkrEcEYNz62L5FQYpgkhKwtlA=;
 b=NNvCZp9ti+3tEu1peuKF8RTC18oOJ1py0AgwyGnK657HVF521YQcfu44Comgopmf+9Lc+r
 l7n1waJJHmFFbG6FD+yuElhLCfuX27nE1/QZClwoG7wFg5HkyXgPwhV8D+9tjeK5BUQqTC
 X1NXnVW0sJvbxxF8H59G0fhoOUu76A4=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-HQxYbI8ZM7qToUW86fpE2g-1; Mon,
 20 Jul 2026 08:29:13 -0400
X-MC-Unique: HQxYbI8ZM7qToUW86fpE2g-1
X-Mimecast-MFC-AGG-ID: HQxYbI8ZM7qToUW86fpE2g_1784550552
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6DCB2180136E; Mon, 20 Jul 2026 12:29:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13B5C195422C; Mon, 20 Jul 2026 12:29:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id A7A7021E6920; Mon, 20 Jul 2026 14:29:09 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Roman Bogorodskiy <bogorodskiy@gmail.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Kostiantyn
 Kostiuk <kkostiuk@redhat.com>,  Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH] qga: implement 'guest-get-diskstats' for FreeBSD
In-Reply-To: <20260719160329.73695-1-bogorodskiy@gmail.com> (Roman
 Bogorodskiy's message of "Sun, 19 Jul 2026 18:03:29 +0200")
References: <20260719160329.73695-1-bogorodskiy@gmail.com>
Date: Mon, 20 Jul 2026 14:29:09 +0200
Message-ID: <87ik69vo8a.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: permerror client-ip=170.10.129.124;
 envelope-from=armbru@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=ham autolearn_force=no
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

Roman Bogorodskiy <bogorodskiy@gmail.com> writes:

> Implement the 'guest-get-diskstats' for FreeBSD.
> This implementation uses the devstat(3) library which is a part
> of the FreeBSD base system.
>
> The build system is updated to link qga with `-ldevstat`.
>
> Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>


QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


