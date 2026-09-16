Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00BBDC88E7F
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 18:13:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6u81-0003gS-Hf; Wed, 16 Sep 2026 14:13:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6u7z-0003ft-5O
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:13:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6u7w-0005Ti-Bj
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 14:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789582377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QXH7k6JNHTLZhRW14ruEsP3wRtHT0wa1ys334Qv3x1I=;
 b=i2eta966TDopyBhcxbYcbGVAic5WYvOtuR7Q2EJr+/8mofQA6GCAXvICuSl/bjV6u2o+yR
 LQav0976aaiSMJvyc4P48+wsFXXFW1cpX9dqbcp9Dn3gM1j/Z6GNLyWtkmARhdC71S8H6l
 4ZhlcgdKCPFHOiSQEkcoQ0OjBNUpJa0=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-w5dPXNaWO5GdxH5nCepoJg-1; Wed,
 16 Sep 2026 14:12:56 -0400
X-MC-Unique: w5dPXNaWO5GdxH5nCepoJg-1
X-Mimecast-MFC-AGG-ID: w5dPXNaWO5GdxH5nCepoJg_1789582371
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4E11218A6970; Wed, 16 Sep 2026 18:12:50 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6E543300418B; Wed, 16 Sep 2026 18:12:49 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1F58B21E6A04; Wed, 16 Sep 2026 20:12:47 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Jonathan Cameron
 <jic23@kernel.org>,  Eric Blake <eblake@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Kevin Wolf <kwolf@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,  linux-cxl@vger.kernel.org,
 qemu-block@nongnu.org,  Junjie Cao <junjie.cao@intel.com>,  Lukas Straub
 <lukasstraub2@web.de>,  Hanna Reitz <hreitz@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  Jason Wang <jasowangio@gmail.com>
Subject: Re: [PATCH v4 7/7] qapi: convert intro sections followed by
 notes/examples
In-Reply-To: <20260916135841.3614495-8-jsnow@redhat.com> (John Snow's message
 of "Wed, 16 Sep 2026 09:58:41 -0400")
References: <20260916135841.3614495-1-jsnow@redhat.com>
 <20260916135841.3614495-8-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 20:12:47 +0200
Message-ID: <877bkl6p5s.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
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

John Snow <jsnow@redhat.com> writes:

> These provide a rather natural cutoff point, but technically this does
> introduce a new intro/details split to these documentation blocks.

Not sure what you mean by "technically".

>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json   |  5 ++---
>  qapi/migration.json | 15 +++++++--------
>  qapi/misc.json      |  3 +--
>  qapi/run-state.json |  7 +++----
>  4 files changed, 13 insertions(+), 17 deletions(-)
>
> diff --git a/qapi/machine.json b/qapi/machine.json
> index 84d95c8d87f..276258d9e5c 100644
> --- a/qapi/machine.json
> +++ b/qapi/machine.json
> @@ -1209,9 +1209,8 @@
>  
>  ##
>  # @HV_BALLOON_STATUS_REPORT:
> -#
> -# Emitted when the hv-balloon driver receives a "STATUS" message from
> -# the guest.
> +#     Emitted when the hv-balloon driver receives a "STATUS" message
> +#     from the guest.
>  #
>  # .. note:: This event is rate-limited.
>  #
   # Since: 8.2

The patch splits the first section between after the first paragraph,
i.e. before the note.

This matters, because we insert generated argument documentation after
the first section.  Rendered documentation changes like this

    Emitted when the hv-balloon driver receives a "STATUS" message from
    the guest.
 
+   Members:
+      * The members of "HvBalloonInfo".
+
    Note:
 
      This event is rate-limited.
 
-   Members:
-      * The members of "HvBalloonInfo".
-
    Example::
 
       <- { "event": "HV_BALLOON_STATUS_REPORT",

> diff --git a/qapi/migration.json b/qapi/migration.json
> index d571c06fc20..a272e701385 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1254,10 +1254,10 @@
>  
>  ##
>  # @migrate_cancel:
> -#
> -# Cancel the currently executing migration process.  Allows a new
> -# migration to be started right after.  When postcopy-ram is in use,
> -# cancelling is not allowed after the postcopy phase has started.
> +#     Cancel the currently executing migration process.  Allows a new
> +#     migration to be started right after.  When postcopy-ram is in
> +#     use, cancelling is not allowed after the postcopy phase has
> +#     started.
>  #
>  # .. note:: This command succeeds even if there is no migration
>  #    process running.

Similar split, but rendered documentation doesn't change, because
nothing gets inserted.

Same for the remaining hunks.

Should the one hunk that changes rendered documentation be in the "qapi:
convert/split remaining QAPI/QMP intro sections" series?

[...]


