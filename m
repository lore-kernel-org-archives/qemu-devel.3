Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 635AAC48BC3
	for <qemu-devel@archiver.kernel.org>; Tue, 20 Feb 2024 16:14:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcSkb-0002T8-7P; Tue, 20 Feb 2024 11:13:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcSkZ-0002Sw-Fb
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:13:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcSkX-0006Xn-TE
 for qemu-devel@nongnu.org; Tue, 20 Feb 2024 11:13:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708445620;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zVQFmTt8TSgKwfyZNv1oloKPfhVSkceX2a7Uakbb0AQ=;
 b=R+G9nG0yBWicWeISGT+45q/WMNZg6lgjuDNQYpSbh+Bz4Wt3VUPW6O0mEFej09moAeGv5z
 WtkUNObITprA6nLpnAGQr6tg0vsZMDbynYoehDskN5911eWqfxum86Yq1PtVCDd0qubTiw
 ve36R4fc2BpadwImWgCMg4kasQ64oIs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-149-MH-dupckOI-lB5tyG3UHEA-1; Tue, 20 Feb 2024 11:13:37 -0500
X-MC-Unique: MH-dupckOI-lB5tyG3UHEA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id AD61385A588;
 Tue, 20 Feb 2024 16:13:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.50])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D4660403864F;
 Tue, 20 Feb 2024 16:13:35 +0000 (UTC)
Date: Tue, 20 Feb 2024 16:13:33 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, michael.roth@amd.com, jsnow@redhat.com,
 eblake@redhat.com, peter.maydell@linaro.org
Subject: Re: [PATCH 11/16] qapi: Recognize section tags and 'Features:' only
 after blank line
Message-ID: <ZdTPrVPcr5fy9C_B@redhat.com>
References: <20240216145841.2099240-1-armbru@redhat.com>
 <20240216145841.2099240-12-armbru@redhat.com>
 <ZdTDn05noU8Ah7lK@redhat.com> <87v86j3yst.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v86j3yst.fsf@pond.sub.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Tue, Feb 20, 2024 at 05:06:42PM +0100, Markus Armbruster wrote:
> Daniel P. Berrangé <berrange@redhat.com> writes:
> 
> > On Fri, Feb 16, 2024 at 03:58:35PM +0100, Markus Armbruster wrote:
> >> Putting a blank line before section tags and 'Features:' is good,
> >> existing practice.  Enforce it.
> >> 
> >> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> >> ---
> >>  docs/devel/qapi-code-gen.rst                 | 15 +++++++++------
> >>  scripts/qapi/parser.py                       | 11 ++++++++---
> >>  tests/qapi-schema/doc-duplicated-return.err  |  2 +-
> >>  tests/qapi-schema/doc-duplicated-return.json |  1 +
> >>  tests/qapi-schema/doc-duplicated-since.err   |  2 +-
> >>  tests/qapi-schema/doc-duplicated-since.json  |  1 +
> >>  tests/qapi-schema/doc-good.json              |  9 +++++++++
> >>  tests/qapi-schema/doc-invalid-return.err     |  2 +-
> >>  tests/qapi-schema/doc-invalid-return.json    |  1 +
> >>  9 files changed, 32 insertions(+), 12 deletions(-)
> >
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> >
> >> @@ -574,9 +577,11 @@ def end_comment(self) -> None:
> >>      def _match_at_name_colon(string: str) -> Optional[Match[str]]:
> >>          return re.match(r'@([^:]*): *', string)
> >>  
> >> -    @staticmethod
> >> -    def _match_section_tag(string: str) -> Optional[Match[str]]:
> >> -        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *', string)
> >> +    def _match_section_tag(self, string: str) -> Optional[Match[str]]:
> >> +        if not self._first_line_in_paragraph:
> >> +            return None
> >> +        return re.match(r'(Returns|Since|Notes?|Examples?|TODO): *',
> >> +                        string)
> >
> > I guess I have a minor worry that we're silently ignoring
> > these tags when there's no blank line. Could result in
> > docs silently rendering in the wrong way if (when) someone
> > forgets the blank line.
> 
> True.
> 
> We could make it an error.  Can flag occurences in the middle of a
> free-form paragraph that happen to be at the beginning of a line, but
> that seems unlikely.
> 
> Of course, rST is full of similar syntactic traps anyway.  To quote
> Paolo, "I find it to be the Perl of ASCII-based markups."

Yes, probably not worth the hassle.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


