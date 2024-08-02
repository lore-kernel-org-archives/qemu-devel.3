Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D362C3DA7F
	for <qemu-devel@archiver.kernel.org>; Fri,  2 Aug 2024 21:01:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZzO9-0000BN-4J; Fri, 02 Aug 2024 17:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sZzO7-00008C-DD
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:00:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <rjones@redhat.com>) id 1sZzO5-00088W-CT
 for qemu-devel@nongnu.org; Fri, 02 Aug 2024 17:00:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722632432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ewistRBsZ/2rKq49a4EnqcioqEwnygURuqRkeEhmNN8=;
 b=KFol3eUDoOFZ7JYdYBXoObdrVdZuQhAzIlmxSy0SuQdWePTXbyDISJMn6K20N341XFrUHp
 bZrNoWYJ4cy8X/uZSE7KOQtPp+TQXGQvNihueVeLJHVBjv3GZvjREl3G7glGQ3u1phW8mM
 aR39oulXGRXMjAXn2NxFT6/UIo8fkEQ=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-150-bHMqgM3eN7Oz0JCPMiKbIw-1; Fri,
 02 Aug 2024 17:00:30 -0400
X-MC-Unique: bHMqgM3eN7Oz0JCPMiKbIw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 850441955BEE; Fri,  2 Aug 2024 21:00:29 +0000 (UTC)
Received: from localhost (unknown [10.42.28.4])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 88D68300018D; Fri,  2 Aug 2024 21:00:28 +0000 (UTC)
Date: Fri, 2 Aug 2024 22:00:27 +0100
From: "Richard W.M. Jones" <rjones@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] util: Refactor json-writer's string sanitizer to be
 public
Message-ID: <20240802210027.GW1450@redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240802194156.2131519-5-eblake@redhat.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=rjones@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.124,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 02, 2024 at 02:26:05PM -0500, Eric Blake wrote:
> My next patch needs to convert text from an untrusted input into an
> output representation that is suitable for display on a terminal is
> useful to more than just the json-writer; the text should normally be
> UTF-8, but blindly allowing all Unicode code points (including ASCII
> ESC) through to a terminal risks remote-code-execution attacks on some
> terminals.  Extract the existing body of json-writer's quoted_strinto
> a new helper routine mod_utf8_sanitize, and generalize it to also work
> on data that is length-limited rather than NUL-terminated.  [I was
> actually surprised that glib does not have such a sanitizer already -
> Google turns up lots of examples of rolling your own string
> sanitizer.]
> 
> If desired in the future, we may want to tweak whether the output is
> guaranteed to be ASCII (using lots of \u escape sequences, including
> surrogate pairs for code points outside the BMP) or if we are okay
> passing printable Unicode through (we still need to escape control
> characters).  But for now, I went for minimal code churn, including
> the fact that the resulting function allows a non-UTF-8 2-byte synonym
> for U+0000.
> 
> Signed-off-by: Eric Blake <eblake@redhat.com>

I have to admit I'd never heard of "modified UTF-8" before, but it's a
thing:

https://en.wikipedia.org/wiki/UTF-8#Modified_UTF-8

As the patch is almost a simple code motion:

Reviewed-by: Richard W.M. Jones <rjones@redhat.com>

Rich.

> ---
>  include/qemu/unicode.h |  3 ++
>  qobject/json-writer.c  | 47 +----------------------
>  util/unicode.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 46 deletions(-)
> 
> diff --git a/include/qemu/unicode.h b/include/qemu/unicode.h
> index 7fa10b8e604..e1013b29f72 100644
> --- a/include/qemu/unicode.h
> +++ b/include/qemu/unicode.h
> @@ -4,4 +4,7 @@
>  int mod_utf8_codepoint(const char *s, size_t n, char **end);
>  ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint);
> 
> +void mod_utf8_sanitize(GString *buf, const char *str);
> +void mod_utf8_sanitize_len(GString *buf, const char *str, ssize_t len);
> +
>  #endif
> diff --git a/qobject/json-writer.c b/qobject/json-writer.c
> index 309a31d57a9..5c14574efee 100644
> --- a/qobject/json-writer.c
> +++ b/qobject/json-writer.c
> @@ -104,53 +104,8 @@ static void pretty_newline_or_space(JSONWriter *writer)
> 
>  static void quoted_str(JSONWriter *writer, const char *str)
>  {
> -    const char *ptr;
> -    char *end;
> -    int cp;
> -
>      g_string_append_c(writer->contents, '"');
> -
> -    for (ptr = str; *ptr; ptr = end) {
> -        cp = mod_utf8_codepoint(ptr, 6, &end);
> -        switch (cp) {
> -        case '\"':
> -            g_string_append(writer->contents, "\\\"");
> -            break;
> -        case '\\':
> -            g_string_append(writer->contents, "\\\\");
> -            break;
> -        case '\b':
> -            g_string_append(writer->contents, "\\b");
> -            break;
> -        case '\f':
> -            g_string_append(writer->contents, "\\f");
> -            break;
> -        case '\n':
> -            g_string_append(writer->contents, "\\n");
> -            break;
> -        case '\r':
> -            g_string_append(writer->contents, "\\r");
> -            break;
> -        case '\t':
> -            g_string_append(writer->contents, "\\t");
> -            break;
> -        default:
> -            if (cp < 0) {
> -                cp = 0xFFFD; /* replacement character */
> -            }
> -            if (cp > 0xFFFF) {
> -                /* beyond BMP; need a surrogate pair */
> -                g_string_append_printf(writer->contents, "\\u%04X\\u%04X",
> -                                       0xD800 + ((cp - 0x10000) >> 10),
> -                                       0xDC00 + ((cp - 0x10000) & 0x3FF));
> -            } else if (cp < 0x20 || cp >= 0x7F) {
> -                g_string_append_printf(writer->contents, "\\u%04X", cp);
> -            } else {
> -                g_string_append_c(writer->contents, cp);
> -            }
> -        }
> -    };
> -
> +    mod_utf8_sanitize(writer->contents, str);
>      g_string_append_c(writer->contents, '"');
>  }
> 
> diff --git a/util/unicode.c b/util/unicode.c
> index 8580bc598b3..a419ed4de35 100644
> --- a/util/unicode.c
> +++ b/util/unicode.c
> @@ -154,3 +154,87 @@ ssize_t mod_utf8_encode(char buf[], size_t bufsz, int codepoint)
>      buf[4] = 0;
>      return 4;
>  }
> +
> +/**
> + * mod_utf8_sanitize:
> + * @buf: Destination buffer
> + * @str: Modified UTF-8 string to sanitize
> + *
> + * Append the contents of the NUL-terminated Modified UTF-8 string
> + * @str into @buf, with escape sequences used for non-printable ASCII
> + * and for quote characters.  The result is therefore safe for output
> + * to a terminal.
> + *
> + * Modified UTF-8 is exactly like UTF-8, except U+0000 is encoded as
> + * "\xC0\x80".
> + */
> +void mod_utf8_sanitize(GString *buf, const char *str)
> +{
> +    mod_utf8_sanitize_len(buf, str, -1);
> +}
> +
> +/**
> + * mod_utf8_sanitize:
> + * @buf: Destination buffer
> + * @str: Modified UTF-8 string to sanitize
> + * @len: Length of @str, or negative to stop at NUL terminator
> + *
> + * Append the contents of @len bytes of the Modified UTF-8 string
> + * @str into @buf, with escape sequences used for non-printable ASCII
> + * and for quote characters.  The result is therefore safe for output
> + * to a terminal.
> + *
> + * Modified UTF-8 is exactly like UTF-8, except U+0000 is encoded as
> + * "\xC0\x80".
> + */
> +void mod_utf8_sanitize_len(GString *buf, const char *str, ssize_t len)
> +{
> +    const char *ptr;
> +    char *end;
> +    int cp;
> +
> +    if (len < 0) {
> +        len = strlen(str);
> +    }
> +
> +    for (ptr = str; *ptr; ptr = end) {
> +        cp = mod_utf8_codepoint(ptr, MIN(6, str + len - ptr), &end);
> +        switch (cp) {
> +        case '\"':
> +            g_string_append(buf, "\\\"");
> +            break;
> +        case '\\':
> +            g_string_append(buf, "\\\\");
> +            break;
> +        case '\b':
> +            g_string_append(buf, "\\b");
> +            break;
> +        case '\f':
> +            g_string_append(buf, "\\f");
> +            break;
> +        case '\n':
> +            g_string_append(buf, "\\n");
> +            break;
> +        case '\r':
> +            g_string_append(buf, "\\r");
> +            break;
> +        case '\t':
> +            g_string_append(buf, "\\t");
> +            break;
> +        default:
> +            if (cp < 0) {
> +                cp = 0xFFFD; /* replacement character */
> +            }
> +            if (cp > 0xFFFF) {
> +                /* beyond BMP; need a surrogate pair */
> +                g_string_append_printf(buf, "\\u%04X\\u%04X",
> +                                       0xD800 + ((cp - 0x10000) >> 10),
> +                                       0xDC00 + ((cp - 0x10000) & 0x3FF));
> +            } else if (cp < 0x20 || cp >= 0x7F) {
> +                g_string_append_printf(buf, "\\u%04X", cp);
> +            } else {
> +                g_string_append_c(buf, cp);
> +            }
> +        }
> +    }
> +}
> -- 
> 2.45.2

-- 
Richard Jones, Virtualization Group, Red Hat http://people.redhat.com/~rjones
Read my programming and virtualization blog: http://rwmj.wordpress.com
virt-p2v converts physical machines to virtual machines.  Boot with a
live CD or over the network (PXE) and turn machines into KVM guests.
http://libguestfs.org/virt-v2v


