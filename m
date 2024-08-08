Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D01EBC3DA4A
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:03:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3iw-0007C7-GR; Thu, 08 Aug 2024 10:02:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sc3iu-0007A0-0z
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:02:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1sc3is-0002NY-6C
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:02:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723125753;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yYntwTUcoK7m1trKVGQMiEUkk3l/vrY8TANdkU99q9g=;
 b=hCBJ6Pmcb8o1a/oN3tu8/7PeuENefgH8vyZtDM2Dzbqcgl5ulJNigU9KdlQ6s3zbwV7bHs
 rZ4od99FQHdNJdDPLd1TNbc/bPyH2NzQQO0WWv1gQnRsYyHu3AnvrxviVpXGZAgKr0D1gl
 mNSH/t4DQu79RXo4kXRpd98pRfYTyvw=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-668-y2U2auqtO1eE-7IMDGuo8A-1; Thu,
 08 Aug 2024 10:02:30 -0400
X-MC-Unique: y2U2auqtO1eE-7IMDGuo8A-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4F9D61944A89; Thu,  8 Aug 2024 14:02:28 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.114])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8896F300018D; Thu,  8 Aug 2024 14:02:26 +0000 (UTC)
Date: Thu, 8 Aug 2024 09:02:23 -0500
From: Eric Blake <eblake@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com
Subject: Re: [PATCH 1/2] util: Refactor json-writer's string sanitizer to be
 public
Message-ID: <zd7l72yiri4zb65jauswl4irv5f3yiceu4wytvtyl6lzyh4lix@fsg67m7vb5e5>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-5-eblake@redhat.com>
 <87ed6z4fgt.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87ed6z4fgt.fsf@pond.sub.org>
User-Agent: NeoMutt/20240425
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, Aug 08, 2024 at 09:54:26AM GMT, Markus Armbruster wrote:
> Eric Blake <eblake@redhat.com> writes:
> 
> > My next patch needs to convert text from an untrusted input into an
> > output representation that is suitable for display on a terminal is
> > useful to more than just the json-writer; the text should normally be
> > UTF-8, but blindly allowing all Unicode code points (including ASCII
> > ESC) through to a terminal risks remote-code-execution attacks on some
> > terminals.  Extract the existing body of json-writer's quoted_strinto
> > a new helper routine mod_utf8_sanitize, and generalize it to also work
> > on data that is length-limited rather than NUL-terminated.
> 
> This is two changes in one patch: factor out, and generalize.
> 
> You don't actually use the generalized variant.  Please leave that for
> later, and keep this patch simple.

Makes sense. Will simplify in v2.

> 
> >                                                             [I was
> > actually surprised that glib does not have such a sanitizer already -
> > Google turns up lots of examples of rolling your own string
> > sanitizer.]

See https://gitlab.gnome.org/GNOME/glib/-/issues/3426 where I asked if
glib should provide a more generic sanitizer.  In turn, I found glib
does have:

char*
g_uri_escape_string (
  const char* unescaped,
  const char* reserved_chars_allowed,
  gboolean allow_utf8
)

which is a bit more powerful (you have some fine-tuning on what gets
escaped), but a different escaping mechanism (%XX instead of \uXXXX
escapes, where % rather than \ is special).  I'm not sure whether it
is nicer to have a malloc'd result or to append into a larger g_string
as the base operation (and where you could write an easy wrapper to
provide the other operation).

> > +/**
> > + * mod_utf8_sanitize:
> > + * @buf: Destination buffer
> > + * @str: Modified UTF-8 string to sanitize
> > + *
> > + * Append the contents of the NUL-terminated Modified UTF-8 string
> > + * @str into @buf, with escape sequences used for non-printable ASCII
> 
> "Append into" or "append to"?

"append to" works, will simplify.

> 
> > + * and for quote characters.  The result is therefore safe for output
> > + * to a terminal.
> 
> Actually, we escape double quote, backslash, ASCII control characters,
> and non-ASCII characters, i.e. we leave just printable ASCII characters
> other than '"' and '\\' unescaped.  See the code quoted below.
> 
> Escaping '\\' is of course necessary.
> 
> Escaping '"' is necessary only for callers that want to enclose the
> result in double quotes without ambiguity.  Which is what the existing
> caller wants.  Future callers may prefer not to escape '"'.  But we can
> worry about this when we run into such callers.

If we encounter more users, I could see this morphing into a backend
that takes a flag argument on knobs like whether to escape " or ',
whether to preserve printing Unicode, ...; coupled with frontends with
fewer arguments that pass the right flags intot the backend.

> 
> > + *
> > + * Modified UTF-8 is exactly like UTF-8, except U+0000 is encoded as
> > + * "\xC0\x80".
> > + */
> 
> Missing: behavior for invalid sequences.  Each such sequence is replaced
> by a replacement character U+FFFD.  For the definition of "invalid
> sequence", see mod_utf8_codepoint().

Indeed, more documentation here wouldn't hurt (both on \ and " being
escaped, and on U+FFFD codepoints being placed into the output
stream).

> 
> On the function name.  "Sanitize" could be many things.  This function
> actually does two things: (1) replace invalid sequences, and (2) escape
> to printable ASCII.  What about append_mod_utf8_as_printable_ascii()?
> Admittedly a mouthful.

Naming is always tough.  Your suggestion is longer, but indeed
accurate.  Maybe a shorter compromise of append_escaped_mod_utf8()?

> 
> > +void mod_utf8_sanitize(GString *buf, const char *str)
> > +{
> > +    mod_utf8_sanitize_len(buf, str, -1);
> > +}

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


