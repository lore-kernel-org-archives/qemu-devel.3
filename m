Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 745A7C021AB
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Feb 2025 11:55:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tjziX-0003g5-TC; Mon, 17 Feb 2025 06:55:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tjziW-0003fw-Lq
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:55:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tjziU-0002fM-W6
 for qemu-devel@nongnu.org; Mon, 17 Feb 2025 06:55:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739793314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hUUOIBoe74pk6PM1o/3S+l81F8n5gorOIxRS8qvQnMA=;
 b=FBjbTGTpKgAgcB2wHG+FjL+/zmU4mjX8cE0xD6dfz4BQiad+bUi3wuVR9uBRAXFgs3VBH9
 t4zczbNdH1ad6k4TFjrrDwY9g5EgP1RRBGlI+PrPgfvb16d3Co7D6JWj4H1oYvbss/ghDM
 SLxX2y1fLeRaMOUwo4yCbkJSJGgkgYg=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-577-H9lnoi67O_S9sZZPJIYXSQ-1; Mon,
 17 Feb 2025 06:55:08 -0500
X-MC-Unique: H9lnoi67O_S9sZZPJIYXSQ-1
X-Mimecast-MFC-AGG-ID: H9lnoi67O_S9sZZPJIYXSQ_1739793307
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9175319560AF; Mon, 17 Feb 2025 11:55:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D42431800352; Mon, 17 Feb 2025 11:55:04 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2D50F21E6A28; Mon, 17 Feb 2025 12:55:02 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Thomas Huth <thuth@redhat.com>,  Yanan Wang <wangyanan55@huawei.com>,
 Fabiano Rosas <farosas@suse.de>,  Zhao Liu <zhao1.liu@intel.com>,  Lukas
 Straub <lukasstraub2@web.de>,  Eduardo Habkost <eduardo@habkost.net>,
 Michael Roth <michael.roth@amd.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Peter Xu <peterx@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,  Alex
 =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,  Jason Wang
 <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>
Subject: Re: [PATCH 29/42] qapi: Add "Details:" disambiguation marker
In-Reply-To: <20250205231208.1480762-30-jsnow@redhat.com> (John Snow's message
 of "Wed, 5 Feb 2025 18:11:55 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-30-jsnow@redhat.com>
Date: Mon, 17 Feb 2025 12:55:02 +0100
Message-ID: <87seocrdk9.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.382,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

> This clarifies sections that are mistaken by the parser as "intro"
> sections to be "details" sections instead.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  qapi/machine.json      | 2 ++
>  qapi/migration.json    | 4 ++++
>  qapi/qom.json          | 4 ++++
>  qapi/yank.json         | 2 ++
>  scripts/qapi/parser.py | 8 ++++++++
>  5 files changed, 20 insertions(+)

Missing updates for the new syntax

* Documentation: docs/devel/qapi-code-gen.rst

* Positive test case(s): tests/qapi-schema/doc-good.json

* Maybe a negative test case for _tag_check() failure

[...]

> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index c5d2b950a82..5890a13b5ba 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -544,6 +544,14 @@ def _tag_check(what: str) -> None:
>                          raise QAPIParseError(
>                              self, 'feature descriptions expected')
>                      have_tagged = True
> +                elif line == 'Details:':
> +                    _tag_check("Details")

This one.

> +                    self.accept(False)
> +                    line = self.get_doc_line()
> +                    while line == '':
> +                        self.accept(False)
> +                        line = self.get_doc_line()
> +                    have_tagged = True
>                  elif match := self._match_at_name_colon(line):
>                      # description
>                      if have_tagged:


