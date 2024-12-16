Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19D5AE77180
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Dec 2024 13:16:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tNAwU-00014b-Lh; Mon, 16 Dec 2024 08:15:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNAwR-00013Y-8v
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:15:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tNAwP-000053-AA
 for qemu-devel@nongnu.org; Mon, 16 Dec 2024 08:15:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734354915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/qKAEzdzhIEGOaRCSbeIKsJLyFVYP0bVwg9LTjrq6Q8=;
 b=Z9T+B58uvlqC5QTkQe/QyzAGxzC/mVIfW1dnDg71o2oYLnRVaFLyHpb63OaDPeQV1NZ+zk
 4p7iK6FWPeXx1L9kcJ+Ushm11bC1czoovU+h4XGWe2cyVX3qbJqnN9E/FplOD3p4WDk6m2
 ZbHduaJzNk+ltMyfn3a3dY0MFtIqDKM=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-36-rEC1kyDGP8-_Mur25-Wemg-1; Mon,
 16 Dec 2024 08:15:10 -0500
X-MC-Unique: rEC1kyDGP8-_Mur25-Wemg-1
X-Mimecast-MFC-AGG-ID: rEC1kyDGP8-_Mur25-Wemg
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5DF5F1955F41; Mon, 16 Dec 2024 13:15:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.27])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE417300F9B8; Mon, 16 Dec 2024 13:15:08 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 8A5F821E6682; Mon, 16 Dec 2024 14:15:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Michael Roth <michael.roth@amd.com>
Subject: Re: [PATCH 01/23] docs/qapidoc: support header-less freeform sections
In-Reply-To: <20241213021827.2956769-2-jsnow@redhat.com> (John Snow's message
 of "Thu, 12 Dec 2024 21:18:04 -0500")
References: <20241213021827.2956769-1-jsnow@redhat.com>
 <20241213021827.2956769-2-jsnow@redhat.com>
Date: Mon, 16 Dec 2024 14:15:06 +0100
Message-ID: <877c7zdb1h.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.13,
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

> The code as written can't handle if a header isn't found, because `node`
> will be uninitialized.

Yes, we initialize @node only if we have a heading.

Made me wonder what happens when we don't.  So I deleted the = from the
"# = Subsection" line in doc-good.json, and got:

    Exception occurred:
      File "/work/armbru/qemu/docs/sphinx/qapidoc.py", line 425, in freeform
        self._parse_text_into_node(text, node)
                                         ^^^^
    UnboundLocalError: cannot access local variable 'node' where it is not associated with a value

So you're fixing a crash bug, but that's perhaps less than clear from
the commit message.

>                        If we don't have a section title, create a
> generic block to insert text into instead.
>
> This patch removes a lingering pylint warning in the QAPIDoc implementation

Can you show me the warning?  My pylint doesn't...

> that prevents getting a clean baseline to use for forthcoming
> additions.
>
> I am not attempting to *fully* clean up the existing QAPIDoc
> implementation in pylint because I intend to delete it anyway; this
> patch merely accomplishes a baseline under a specific pylint
> configuration:
>
> PYTHONPATH=../../scripts/ pylint --disable=fixme,too-many-lines,\
>     consider-using-f-string,missing-docstring,unused-argument,\
>     too-many-arguments,too-many-positional-arguments,\
>     too-many-public-methods \
>     qapidoc.py

What version of pylint?  Mine chokes on too-many-positional-arguments.

> This at least ensures there aren't regressions outside of these general
> warnings in the new qapidoc.py code to be committed.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  docs/sphinx/qapidoc.py | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/docs/sphinx/qapidoc.py b/docs/sphinx/qapidoc.py
> index 5f96b46270b..5a4d7388b29 100644
> --- a/docs/sphinx/qapidoc.py
> +++ b/docs/sphinx/qapidoc.py
> @@ -421,6 +421,8 @@ def freeform(self, doc):
>              node = self._start_new_heading(heading, len(leader))
>              if text == '':
>                  return
> +        else:
> +            node = nodes.container()
>  
>          self._parse_text_into_node(text, node)
>          self._cur_doc = None

Plausible enough (and I acked a similar fix previously, commit
2664f3176a8), but I'm a Sphinx ignoramus :)


