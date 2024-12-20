Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2414EE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 13:25:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOd0I-0000iu-DM; Fri, 20 Dec 2024 08:25:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOd0F-0000h8-Db
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:25:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tOd0D-0001dK-LK
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 08:25:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734701112;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YRKU+mS8aqSAtbWgVsQDaujFuJmMpjenR/K0OIdLr9M=;
 b=fyTptU0H9lfCVn9dAZd6DD+14ifLnWX4zFJhRz+1yRCU+lYAqFQzSMoV7sOAFza6RKju93
 FBdjxd9B/5JXkXzEQmS9ru48WekGbp4AEVWUy3BVHez4tck2hYIyy2SrYel/4Oof86SpW1
 gNi1i0tptmZ3538cQSMYapR1MglpDb0=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-115-SVxbphBaMha1ht2u6HtzgQ-1; Fri,
 20 Dec 2024 08:25:11 -0500
X-MC-Unique: SVxbphBaMha1ht2u6HtzgQ-1
X-Mimecast-MFC-AGG-ID: SVxbphBaMha1ht2u6HtzgQ
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 17CBD1956066; Fri, 20 Dec 2024 13:25:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A97FC19560AD; Fri, 20 Dec 2024 13:25:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 588CC21E66E2; Fri, 20 Dec 2024 14:25:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 10/23] docs/qapidoc: add visit_freeform() method
In-Reply-To: <20241213021827.2956769-11-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:13 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-11-jsnow@redhat.com>
Date: Fri, 20 Dec 2024 14:25:07 +0100
Message-ID: <87cyhm4hcc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
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

> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 47 ++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 47 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 7d2f7bfb415..6f8f69077b1 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -133,6 +133,53 @@ def visit_module(self, path: str) -> None:
>          self.add_line_raw(f".. qapi:module:: {name}", path, 1)
>          self.ensure_blank_line()
>  
> +    def visit_freeform(self, doc) -> None:
> +        # Once the old qapidoc transformer is deprecated,
> +        # freeform sections can be transformed into pure rST.
> +        #
> +        # For now, translate our micro-format into rST.
> +        # Code adapted from Peter Maydell's freeform().
> +
> +        assert len(doc.all_sections) == 1, doc.all_sections
> +        body = doc.all_sections[0]
> +        text = body.text
> +        info = doc.info
> +
> +        if re.match(r"=+ ", text):
> +            # Section/subsection heading (if present, will always be the
> +            # first line of the block)
> +            (heading, _, text) = text.partition("\n")
> +            (leader, _, heading) = heading.partition(" ")
> +            level = len(leader) + 1  # Implicit +1 for heading in .rST stub
> +
> +            # https://www.sphinx-doc.org/en/master/usage/restructuredtext/basics.html#sections
> +            markers = {
> +                1: "#",
> +                2: "*",
> +                3: "=",
> +                4: "-",
> +                5: "^",
> +                6: '"',
> +            }
> +            overline = level <= 2
> +            marker = markers[level]
> +
> +            self.ensure_blank_line()
> +            # This credits all 2 or 3 lines to the single source line.
> +            if overline:
> +                self.add_line(marker * len(heading), info)
> +            self.add_line(heading, info)
> +            self.add_line(marker * len(heading), info)
> +            self.ensure_blank_line()
> +
> +            # Eat blank line(s) and advance info
> +            trimmed = text.lstrip("\n")
> +            text = trimmed
> +            info = info.next_line(len(text) - len(trimmed) + 1)

We could instead eat newlines one at a time, calling .next_line()
without an argument for each newline eaten.  Less efficient, but won't
matter here.  Possibly easier to understand.

> +
> +        self.add_lines(text, info)
> +        self.ensure_blank_line()
> +
>  
>  # Disable black auto-formatter until re-enabled:
>  # fmt: off


