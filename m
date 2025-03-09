Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE629C28B2E
	for <qemu-devel@archiver.kernel.org>; Sun,  9 Mar 2025 21:06:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trNqx-0006Hg-9c; Sun, 09 Mar 2025 17:06:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNqs-0006BT-PL
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:06:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trNqr-0002FR-BM
 for qemu-devel@nongnu.org; Sun, 09 Mar 2025 17:06:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741554384;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=I8sb6eTl4UmwhwGytIjDTkAgo/1Wvx3ji5RIuJXBIOU=;
 b=dlHpEmM0R1YrplwozFXNxlaaoPpsUPfIVWTopQLDbL2pIcC1xPGW8LI1G6Slqd0U9x1lHm
 uDc5EKHH+w95KKyIguEJnibuVcYfFGr7RunfSaGw1SOaHWysvnOQJqqju3R/RzWhukWJZV
 4fZRHEpMAJka+oCHkC+xxvlqLyx9HMs=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-483-0_EYaw50OCCUvA3cE-MDkg-1; Sun,
 09 Mar 2025 17:06:23 -0400
X-MC-Unique: 0_EYaw50OCCUvA3cE-MDkg-1
X-Mimecast-MFC-AGG-ID: 0_EYaw50OCCUvA3cE-MDkg_1741554382
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2EAE219560B4; Sun,  9 Mar 2025 21:06:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D67F91955BCB; Sun,  9 Mar 2025 21:06:20 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 61D5B21E675F; Sun, 09 Mar 2025 22:06:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Eric Blake <eblake@redhat.com>,  Thomas Huth
 <thuth@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 48/62] docs/qapidoc: add visit_feature() method
In-Reply-To: <20250309083550.5155-49-jsnow@redhat.com> (John Snow's message of
 "Sun, 9 Mar 2025 04:35:35 -0400")
References: <20250309083550.5155-1-jsnow@redhat.com>
 <20250309083550.5155-49-jsnow@redhat.com>
Date: Sun, 09 Mar 2025 22:06:18 +0100
Message-ID: <87plipykvp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

> This adds a simple ":feat name: lorem ipsum ..." line to the generated
> rST document, so at the moment it's only for "top level" features.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 9 +++++++++
>  1 file changed, 9 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index b87ce288837..eaea19af7ac 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -195,6 +195,15 @@ def visit_paragraph(self, section: QAPIDoc.Section) -> None:
>          self.add_lines(section.text, section.info)
>          self.ensure_blank_line()
>  
> +    def visit_feature(self, section: QAPIDoc.ArgSection) -> None:
> +        # FIXME - ifcond for features is not handled at all yet!
> +        # Proposal: decorate the right-hand column with some graphical
> +        # element to indicate conditional availability?

If I remember correctly, you wanted to mention this FIXME in the commit
message.

> +        assert section.text  # Guaranteed by parser.py
> +        assert section.member
> +
> +        self.generate_field("feat", section.member, section.text, section.info)
> +
>      def visit_errors(self, section: QAPIDoc.Section) -> None:
>          # FIXME: the formatting for errors may be inconsistent and may
>          # or may not require different newline placement to ensure


