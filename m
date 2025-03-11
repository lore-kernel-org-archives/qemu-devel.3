Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64E38C28B2E
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Mar 2025 07:02:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1trtcT-0004pP-6n; Tue, 11 Mar 2025 03:01:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtcN-0004oS-A1
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:01:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1trtcL-00035j-Au
 for qemu-devel@nongnu.org; Tue, 11 Mar 2025 03:01:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1741676491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0S/F3sCaH5tqLNLltTX2D2DhfFDol708NpXtozcZ8VU=;
 b=NcnYa+SKh20wFhVK8spq30s5bEz1vAt1NpGxoyLGB0ZVycBM4YdDmT8OJpPjyI1H5AJ13Z
 IK+MZ3eBpW/OfC/PzKTlGk3Bx+rjkHwefEEdbPWqnTBESdpxyTdGXIyFk5OTG0xVmaf2Vf
 g4+5gL61XMDdlbta6s+Ym/qfdznux0Y=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-yMeaWAjvPjevDtN9Qsnfug-1; Tue,
 11 Mar 2025 03:01:27 -0400
X-MC-Unique: yMeaWAjvPjevDtN9Qsnfug-1
X-Mimecast-MFC-AGG-ID: yMeaWAjvPjevDtN9Qsnfug_1741676486
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9BE1F180049D; Tue, 11 Mar 2025 07:01:26 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE1731955BCB; Tue, 11 Mar 2025 07:01:25 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 34E2D21E675E; Tue, 11 Mar 2025 08:01:22 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org,  Peter Maydell <peter.maydell@linaro.org>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eric Blake
 <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  Thomas Huth
 <thuth@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: Re: [PATCH v3 32/63] qapi/parser: adjust info location for doc body
 section
In-Reply-To: <20250311034303.75779-33-jsnow@redhat.com> (John Snow's message
 of "Mon, 10 Mar 2025 23:42:30 -0400")
References: <20250311034303.75779-1-jsnow@redhat.com>
 <20250311034303.75779-33-jsnow@redhat.com>
Date: Tue, 11 Mar 2025 08:01:22 +0100
Message-ID: <87jz8w830d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

> Instead of using the info object for the doc block as a whole (which
> always points to the very first line of the block), update the info
> pointer for each call to ensure_untagged_section when the existing
> section is otherwise empty. This way, Sphinx error information will
> match precisely to where the text actually starts.
>
> For example, this patch will move the info pointer for the "Hello!"
> untagged section ...
>
>> ##       <-- from here ...
>> # Hello! <-- ... to here.
>> ##
>
> This doesn't seem to improve error reporting now. It will with the
> forthcoming QAPI doc transmogrifier.
>
> If I stick bad rST into qapi/block-core.json like this:
>
>>  ##
>>  # @SnapshotInfo:
>>  #
>> +# rST syntax error: *ahh!
>> +#
>>  # @id: unique shapshot id
>>  #
>>  # @name: user chosen name
>
> The existing code's error message will point to the beginning of the doc
> comment, which is less than helpful. The transmogrifier's message will
> point to the erroneous line, but to accomplish this, it needs this
> patch.
>
> Signed-off-by: John Snow <jsnow@redhat.com>
> ---
>  scripts/qapi/parser.py | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index 64f0bb824ae..97def9f0e4f 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py
> @@ -686,7 +686,11 @@ def end(self) -> None:
>      def ensure_untagged_section(self, info: QAPISourceInfo) -> None:
>          if self.all_sections and not self.all_sections[-1].tag:
>              # extend current section
> -            self.all_sections[-1].text += '\n'
> +            section = self.all_sections[-1]
> +            if not section.text:
> +                # Section is empty so far; update info to start *here*.
> +                section.info = info
> +            section.text += '\n'
>              return
>          # start new section
>          section = self.Section(info)

Reviewed-by: Markus Armbruster <armbru@redhat.com>


