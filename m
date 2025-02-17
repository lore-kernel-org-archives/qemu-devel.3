Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A5A9C021A9
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 11:54:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjzgk-0002t8-3p; Mon, 17 Feb 2025 06:53:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tjzgh-0002r8-KQ
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:53:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tjzgc-0002P1-BK
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:53:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739793196;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SwItw33j+/mwBh1MBw5xUq0NIFNUaA54Bp/baFMp0rg=;
 b=DK1Fnp02bivLm/1BfMDhAKrJLOo2jAuLG2dOGCZta4tK5oTxw8ZPxMkZxuer7ZKNmbu1p0
 4nIzJ8ADZU/fNwG4/y/65NuwnAZlfo/Ein62xpEsN4eNRpWmMDdyx4T4IY2Ygiu7JGoFLZ
 SDFeJ8s46fry/qKFIRGc1k+J/ExZDN8=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-462-bY-E9i4hO3-USLlcJlWEnA-1; Mon,
 17 Feb 2025 06:53:12 -0500
X-MC-Unique: bY-E9i4hO3-USLlcJlWEnA-1
X-Mimecast-MFC-AGG-ID: bY-E9i4hO3-USLlcJlWEnA_1739793190
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 5F76518D95A4; Mon, 17 Feb 2025 11:53:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6C0E8180035E; Mon, 17 Feb 2025 11:53:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B84FD21E6A28; Mon, 17 Feb 2025 12:53:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Jason Wang <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 28/42] qapi/parser: prohibit untagged sections between
 tagged sections
In-Reply-To: <20250205231208.1480762-29-jsnow@redhat.com> (John Snow's message
 of "Wed, 5 Feb 2025 18:11:54 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-29-jsnow@redhat.com>
Date: Mon, 17 Feb 2025 12:53:06 +0100
Message-ID: <87v7t8rdnh.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

> This is being done primarily to ensure consistency between the source
> documents and the final, rendered HTML output. Because
> member/feature/returns sections will always appear in a visually grouped
> element in the HTML output, prohibiting free paragraphs between those
> sections ensures ordering consistency between source and the final
> render.
>
> Additionally, prohibiting such "middle" text paragraphs allows us to
> classify all plain text sections as either "intro" or "detail"
> sections, because these sections must either appear before structured
> elements ("intro") or afterwards ("detail").
>
> This keeps the inlining algorithm simpler with fewer "splice" points
> when inlining multiple documentation blocks.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index b2f77ffdd7a..c5d2b950a82 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -500,6 +500,20 @@ def get_doc(self) -> 'QAPIDoc':
>              self.accept(False)
>              line = self.get_doc_line()
>              have_tagged = False
> +            no_more_tags = False
> +
> +            def _tag_check(what: str) -> None:
> +                if what in ('TODO', 'Since'):
> +                    return
> +
> +                if no_more_tags:
> +                    raise QAPIParseError(
> +                        self,
> +                        f"{what!r} section cannot appear after free "
> +                        "paragraphs that follow other tagged sections. "
> +                        "Move this section upwards with the preceding "
> +                        "tagged sections."
> +                    )

Negative test case(s), please.

>  
>              while line is not None:
>                  # Blank lines
> @@ -513,6 +527,7 @@ def get_doc(self) -> 'QAPIDoc':
>                      if doc.features:
>                          raise QAPIParseError(
>                              self, "duplicated 'Features:' line")
> +                    _tag_check("Features")
>                      self.accept(False)
>                      line = self.get_doc_line()
>                      while line == '':
> @@ -576,6 +591,7 @@ def get_doc(self) -> 'QAPIDoc':
>                          )
>                          raise QAPIParseError(self, emsg)
>  
> +                    _tag_check(match.group(1))
>                      doc.new_tagged_section(
>                          self.info,
>                          QAPIDoc.Kind.from_string(match.group(1))

[...]


