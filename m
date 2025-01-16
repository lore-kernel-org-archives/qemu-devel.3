Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A000BC02187
	for <qemu-devel@archiver.kernel.org>; Thu, 16 Jan 2025 11:51:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tYOOy-0000Ke-HL; Thu, 16 Jan 2025 06:51:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYOOw-0000KI-Rl
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:51:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tYOOs-0001KW-Jz
 for qemu-devel@nongnu.org; Thu, 16 Jan 2025 06:51:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737028261;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pQER36YlSKI7ufzEUuoSXqaU45/KBY8+Ep0/BII1QQw=;
 b=VRR9pDdfl7Oex0HuPVuxSe42T6wQQ/sArA5gQUoqAXH0MN8YfXqG4nYZcECKCslCWmrFoF
 Tl1ynJeqsWVHXobKnzIGw9AZx9EhGtarP6V91KMnDg3aAtQy8Kd9I5du2cs1AVVkRSGkLN
 /x8Sma6WasIzyHJSwhAydfh67D3R0uE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-355-BgLornCGNRSoPQzM9OT4GA-1; Thu,
 16 Jan 2025 06:50:57 -0500
X-MC-Unique: BgLornCGNRSoPQzM9OT4GA-1
X-Mimecast-MFC-AGG-ID: BgLornCGNRSoPQzM9OT4GA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7FBCE19560B3; Thu, 16 Jan 2025 11:50:56 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.48])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3878030001BE; Thu, 16 Jan 2025 11:50:56 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id AE91B21E6924; Thu, 16 Jan 2025 12:50:51 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,  Peter
 Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH v2 05/23] qapi/schema: add __repr__ to QAPIDoc.Section
In-Reply-To: <20250114185840.3058525-6-jsnow@redhat.com> (John Snow's message
 of "Tue, 14 Jan 2025 13:58:22 -0500")
References: <20250114185840.3058525-1-jsnow@redhat.com>
 <20250114185840.3058525-6-jsnow@redhat.com>
Date: Thu, 16 Jan 2025 12:50:51 +0100
Message-ID: <87v7uf6kpw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

> Makes debugging far more pleasant when you can just print(section) and
> get something reasonable to display.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index c3004aa70c6..cb259c42a6d 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -673,6 +673,9 @@ def __init__(
>              # section text without tag
>              self.text = ''
>  
> +        def __repr__(self) -> str:
> +            return f"<QAPIDoc.Section tag={self.tag!r} text={self.text!r}>"

pylint points out

    scripts/qapi/parser.py:677:43: E1101: Instance of 'Section' has no 'tag' member (no-member)

Previous patch renamed it to @kind.

> +
>          def append_line(self, line: str) -> None:
>              self.text += line + '\n'


