Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80630C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:00:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNkZ-0004oR-El; Sun, 09 Mar 2025 16:59:55 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNjy-0004if-7k
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:59:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNjw-0007on-JM
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 16:59:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741553954;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=RPtu7Ssd5cYqS0sN379K7wjAU1gPT1bxbThQdUYy9no=;
 b=fWOYBAzYLQf0tmgxRCQ0j5zWtE+GuBGy4MU49PE8vnvdHsb84Z7MtaNX08ANZFEi1MBNwk
 zVyHut09h8iV0GK3oRbO6NZgky5nY86DUi/KrMxOWO3lEp9QsywDRsa9DLUgaLL1/Klt1d
 C8Tj6zZFpe3CRz55BH1zCgvckP3D7/g=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-573-cQRRqC-WPE-bEYOLZqjBig-1; Sun,
 09 Mar 2025 16:59:11 -0400
X-MC-Unique: cQRRqC-WPE-bEYOLZqjBig-1
X-Mimecast-MFC-AGG-ID: cQRRqC-WPE-bEYOLZqjBig_1741553950
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1AAD2195608A; Sun,  9 Mar 2025 20:59:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8C4931956096; Sun,  9 Mar 2025 20:59:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 12F5721E675F; Sun, 09 Mar 2025 21:59:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 41/62] qapi/source: allow multi-line QAPISourceInfo
 advancing
In-Reply-To: <20250309083550.5155-42-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:28 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-42-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 21:59:07 +0100
Message-ID: <87ldtdzzs4.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
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

> This is for the sake of the new rST generator (the "transmogrifier") so
> we can advance multiple lines on occasion while keeping the
> generated<-->source mappings accurate.
>
> next_line now simply takes an optional n parameter which chooses the
> number of lines to advance.
>
> RFC: Here's the exorbitant detail on why I want this:
>
> This is used mainly when converting section syntax in free-form
> documentation to more traditional rST section header syntax, which
> does not always line up 1:1 for line counts.

Obvious way to resolve the RFC:

  The next patch will use this when converting ...

>
> For example:
>
> ```
>  ##
>  # = Section     <-- Info is pointing here, "L1"
>  #
>  # Lorem Ipsum
>  ##
> ```
>
> would be transformed to rST as:
>
> ```
> =======        <-- L1
> Section        <-- L1
> =======        <-- L1
>                <-- L2
> Lorem Ipsum    <-- L3
> ```
>
> After consuming the single "Section" line from the source, we want to
> advance the source pointer to the next non-empty line which requires
> jumping by more than one line.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> Reviewed-by: Markus Armbruster <armbru@redhat.com>


