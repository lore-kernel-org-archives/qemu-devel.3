Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9798C982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 07:12:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6jmp-0008Iv-Ei; Wed, 16 Sep 2026 03:10:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6jmb-0007ka-68
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:10:20 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1x6jmY-0000MZ-Po
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 03:10:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789542614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1/gaTwawDlLuf14wEB4bYVu+faTFd3wc+Gqm1sgWtic=;
 b=cdVTq4ozxJWh3lcwPIs+qMoyjSA1UmzCItieDssJ1aEPIKpEHO4cKxDJlnVv0X7HQQB6DZ
 wmLRmG79xEwXClCP1teqSBVHHvN0+/Un4EMYmyvrTWWX1mUHcCD0M5ZVsX3Wj646sOZ9+x
 YTvoGnAor1Ogq7fHVxEiz3noD+ehOkc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-52-2Bn_dHJHOMKjnrfJ-Sf7ZA-1; Wed,
 16 Sep 2026 03:10:09 -0400
X-MC-Unique: 2Bn_dHJHOMKjnrfJ-Sf7ZA-1
X-Mimecast-MFC-AGG-ID: 2Bn_dHJHOMKjnrfJ-Sf7ZA_1789542607
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5AA7418A5A0E; Wed, 16 Sep 2026 07:10:07 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.5])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A54351800345; Wed, 16 Sep 2026 07:10:06 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 5AD6521E6A04; Wed, 16 Sep 2026 09:10:04 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Fabiano Rosas <farosas@suse.de>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@mailo.com>,  Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org,  Zhao Liu <zhao1.liu@intel.com>,
 linux-cxl@vger.kernel.org,  Lukas Straub <lukasstraub2@web.de>,  Jonathan
 Cameron <jic23@kernel.org>,  Paolo Bonzini <pbonzini@redhat.com>,  Peter
 Xu <peterx@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Jason Wang
 <jasowangio@gmail.com>,  Eric Blake <eblake@redhat.com>,  Kevin Wolf
 <kwolf@redhat.com>,  Junjie Cao <junjie.cao@intel.com>
Subject: Re: [PATCH v3 5/7] qapi/parser: fix intermediate "intro" detection
In-Reply-To: <20260915211434.3511110-6-jsnow@redhat.com> (John Snow's message
 of "Tue, 15 Sep 2026 17:14:32 -0400")
References: <20260915211434.3511110-1-jsnow@redhat.com>
 <20260915211434.3511110-6-jsnow@redhat.com>
Date: Wed, 16 Sep 2026 09:10:04 +0200
Message-ID: <87bj9xekoj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> In 43e7ad1a3fa5, I adjusted the insertion algorithm for inserting
> something after the "introduction" to cope with both the old and new
> syntax while we converted QAPI to the new syntax. There's a bug in
> that code that only shows up in a handful of cases and only when using
> the new syntax while this affordance/flex code is still enabled.
>
> In the case that we do actually have a real bona-fide intro section,
> we want to insert directly after that real-deal intro section, not
> after any plaintext sections that may follow it. This code adjusts the
> temporary code to strongly prefer inserting after the actual intro
> section if it exists.
>
> Once again: once conversion is done, you will be delighted by how much
> of this ugly code goes away.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 7 +++++++
>  1 file changed, 7 insertions(+)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 9e14c2f7921..79f03062eea 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -845,6 +845,13 @@ def _insert_after_intro(
>          needed and ``_insert_near_kind(QAPIDoc.Kind.INTRO, ...)`` will
>          be sufficient.
>          """
> +        first = self.all_sections[0]
> +        if first.text and first.kind == QAPIDoc.Kind.INTRO:
> +            # First section is introduction and is non-empty: insert here.
> +            # Rest assured all of this ugliness will very soon go away.
> +            # Pinkie-swear.
> +            self._insert_near_kind(QAPIDoc.Kind.INTRO, section, after=True)
> +
>          index = 0
>          for index, ref_section in enumerate(self.all_sections):
>              if ref_section.kind.name in ("PLAIN", "INTRO"):

This seems to insert generated sections twice, but only sometimes.

Two examples:

   Command query-status (Since: 0.14)

      Query the run status of the VM

      Return:
         "StatusInfo"

  +   Return:
  +      "StatusInfo"
  +
      Example::

         -> { "execute": "query-status" }
         <- { "return": { "running": true,
                          "status": "running" } }

and

   Enum DisplayProtocol (Since: 7.0)

      Display protocols which support changing password options.

      Values:
         * **vnc** -- Not documented

  +      * **vnc** -- Not documented
  +
         * **spice** -- Not documented


