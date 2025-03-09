Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D5D6C28B28
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:06:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNqU-0005a9-RE; Sun, 09 Mar 2025 17:06:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNqT-0005a0-32
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:06:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNqR-00028O-JG
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:06:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741554358;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=foZ3txxTPW+9ZRGPVwSxRC9DYX6mcYMd01FwJodNytw=;
 b=T+C55JsUsTVKiU+rjRP8tFCiYYtyXayxeY1zn36ayYmPOYJxB/q0oThyJ3iHkcPcW1oEue
 vX6J40O4iFNOw3bC8DrF6KFMnLJZp/Gg+Qo87TTu72tbi6pt1fKruoD/BFvaJauTsGqZXC
 0/dmcTPsNdKV/0LDdW0E0Me76oRG39Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-601-CHEUl9lpOJKEe1voybgEHw-1; Sun,
 09 Mar 2025 17:05:54 -0400
X-MC-Unique: CHEUl9lpOJKEe1voybgEHw-1
X-Mimecast-MFC-AGG-ID: CHEUl9lpOJKEe1voybgEHw_1741554353
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CB46180035E; Sun,  9 Mar 2025 21:05:53 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53A871828A84; Sun,  9 Mar 2025 21:05:53 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id E28AD21E675E; Sun, 09 Mar 2025 22:05:50 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Markus Armbruster <armbru@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Michael Roth
 <michael.roth@amd.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Thomas Huth <thuth@redhat.com>,  Alex =?utf-8?Q?Ben?=
 =?utf-8?Q?n=C3=A9e?=
 <alex.bennee@linaro.org>,  Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 45/62] docs/qapidoc: add visit_errors() method
In-Reply-To: <20250309083550.5155-46-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:32 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-46-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 22:05:50 +0100
Message-ID: <87tt81ykwh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
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

> Notably, this method does not currently address the formatting issues
> present with the "errors" section in QAPIDoc and just vomits the text
> verbatim into the rST doc, with somewhat inconsistent results.
>
> To be addressed in a future revision.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index b96445f0802..14feafe866e 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -139,6 +139,12 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
>          self.add_lines(section.text, section.info)
>          self.ensure_blank_line()
>  
> +    def visit_errors(self, section: QAPIDoc.Section) -> None:
> +        # FIXME: the formatting for errors may be inconsistent and may

If I remember correctly, you wanted to mention this FIXME in the commit
message.

> +        # or may not require different newline placement to ensure
> +        # proper rendering as a nested list.
> +        self.add_lines(f":error:\n{section.text}", section.info)
> +
>      def preamble(self, ent: QAPISchemaDefinition) -> None:
>          """
>          Generate option lines for qapi entity directives.


