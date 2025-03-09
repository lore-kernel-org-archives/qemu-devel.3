Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055DBC28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:00:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNjw-0004iM-7P; Sun, 09 Mar 2025 16:59:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNjp-0004d6-3j
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:59:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNjj-0007kC-4g
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:59:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741553941;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=o0gDuTAyWjmqACnYipjsqYLTOCUGXu8EOoD5XzigQkk=;
 b=CLFlC4kGeUg7S+H8xvZRgzUTWIXwosrZFuUhWKxPGucCq8d8BTdU3fpFuN/pphYk/XhxRI
 e6/4Cw86rpSiN5PDkuNZ/w9DQFa8nfWWYzmvGxsfud7jX7ER3B6KrK3eJJMjXpD7ClZmZH
 +CG+caohl5oHH+I1F8LTyrZyasuoxr4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-6nfK4w9MO1ictve2pyOW2g-1; Sun,
 09 Mar 2025 16:53:28 -0400
X-MC-Unique: 6nfK4w9MO1ictve2pyOW2g-1
X-Mimecast-MFC-AGG-ID: 6nfK4w9MO1ictve2pyOW2g_1741553607
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1445E19560B8; Sun,  9 Mar 2025 20:53:27 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 704F019560AB; Sun,  9 Mar 2025 20:53:26 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 0BC3921E66C1; Sun, 09 Mar 2025 21:53:24 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 32/62] qapi/parser: adjust info location for doc body
 section
In-Reply-To: <20250309083550.5155-33-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:19 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-33-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 21:53:24 +0100
Message-ID: <87tt82ylh7.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

John Snow <jsnow@redhat.com> writes:

> Instead of using the info object for the doc block as a whole (which
> always points to the very first line of the block), update the info
> pointer for each call to ensure_untagged_section when the existing
> section is otherwise empty. This way, Sphinx error information will
> match precisely to where the text actually starts.
>
> For example, this patch will move the info pointer for the "Hello!"
> untagged section ...
>
>> ##       <-- from here ...
>> # Hello! <-- ... to here.
>> ##
>
> Signed-off-by: John Snow <jsnow@redhat.com>

Here's my attempt to improve the commit message:

    qapi/parser: adjust info location for doc body section

    Instead of using the info object for the doc block as a whole (which
    always points to the very first line of the block), update the info
    pointer for each call to ensure_untagged_section when the existing
    section is otherwise empty. This way, Sphinx error information will
    match precisely to where the text actually starts.

    For example, this patch will move the info pointer for the "Hello!"
    untagged section ...

        ##       <-- from here ...
        # Hello! <-- ... to here.
        ##

    This doesn't seem to improve error reporting now.  It will with the
    QAPI doc transmogrifier I'm about to add.

    If I stick bad rST into qapi/block-core.json like this

         ##
         # @SnapshotInfo:
         #
        +# rST syntax error: *ahh!
        +#
         # @id: unique snapshot id
         #
         # @name: user chosen name

    the existing code's error message will point to the beginning of the
    doc comment, which is less than helpful.  The transmogrifier's
    message will point to the erroneous line, but to accomplish this, it
    needs this patch.

What do you think?


