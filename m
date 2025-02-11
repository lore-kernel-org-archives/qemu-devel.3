Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E33F8C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 15:01:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thrkc-0004md-Vh; Tue, 11 Feb 2025 10:00:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thrkY-0004jk-Gd
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:00:36 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1thrkW-0001ja-IH
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 10:00:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739286030;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pCusbGUoWr0JCxR0RvxCKBkeWbes/s7CMGPJLMe+AcI=;
 b=HQfbFuPjWVKasAdYC702aKj3fIHlBtrLZEopjdvfcwtO7V9VeZ2IUqJSuhK+jJG6UM0Teh
 zo8DDIoFjHjDwRPnq/WvPhTYwlCesjHfR4Cs8tA617LqYrW4tVPocQgSXnV6pISDPOW7YH
 8UQuirBw49P/r9IpUE+5MlvhDDj1SWw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-310-C1x1_cATOmmoTpn7TV-xIQ-1; Tue,
 11 Feb 2025 10:00:24 -0500
X-MC-Unique: C1x1_cATOmmoTpn7TV-xIQ-1
X-Mimecast-MFC-AGG-ID: C1x1_cATOmmoTpn7TV-xIQ
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 85F0C1955F29; Tue, 11 Feb 2025 15:00:12 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6446195608D; Tue, 11 Feb 2025 15:00:11 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1A99621E6A28; Tue, 11 Feb 2025 16:00:09 +0100 (CET)
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
Subject: Re: [PATCH 27/42] qapi: differentiate "intro" and "detail" sections
In-Reply-To: <20250205231208.1480762-28-jsnow@redhat.com> (John Snow's message
 of "Wed, 5 Feb 2025 18:11:53 -0500")
References: <20250205231208.1480762-1-jsnow@redhat.com>
 <20250205231208.1480762-28-jsnow@redhat.com>
Date: Tue, 11 Feb 2025 16:00:09 +0100
Message-ID: <87frkkttl2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
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

> This patch begins distinguishing "Plain" sections as being either
> "Intro" or "Details" sections for the purpose of knowing when and where
> to inline those sections.
>
> Signed-off-by: John Snow <jsnow@redhat.com>

[...]

> diff --git a/scripts/qapi/parser.py b/scripts/qapi/parser.py
> index a8b30ae1a4b..b2f77ffdd7a 100644
> --- a/scripts/qapi/parser.py
> +++ b/scripts/qapi/parser.py

[...]

> @@ -584,14 +584,20 @@ def get_doc(self) -> 'QAPIDoc':
>                      if text:
>                          doc.append_line(text)
>                      line = self.get_doc_indented(doc)
> -                    no_more_args = True
> +                    have_tagged = True
>                  elif line.startswith('='):
>                      raise QAPIParseError(
>                          self,
>                          "unexpected '=' markup in definition documentation")
>                  else:
>                      # plain paragraph(s)
> -                    doc.ensure_untagged_section(self.info)
> +                    if have_tagged:
> +                        no_more_tags = True

@no_more_tags is not used in this patch.  Does the conditional
assignment belong to the next patch?

> +
> +                    # Paragraphs before tagged sections are "intro" paragraphs.
> +                    # Any appearing after are "detail" paragraphs.
> +                    intro = not have_tagged
> +                    doc.ensure_untagged_section(self.info, intro)
>                      doc.append_line(line)
>                      line = self.get_doc_paragraph(doc)
>          else:

[...]


