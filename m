Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4FF36C3DA7F
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Aug 2024 18:50:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sbljL-0001pI-89; Wed, 07 Aug 2024 14:49:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbljJ-0001nL-1u
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:49:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sbljH-0000d0-31
 for qemu-devel@nongnu.org; Wed, 07 Aug 2024 14:49:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723056581;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Njo5QMsccRYfU9sZCJh4Xok9zz4eMQXc10FOs/J8wp0=;
 b=dLUKSlExEPnCZaDopo5vKY04g+8QggyD96IjKC6n++JM04NikSaWCBi7mfp0KAl7l5uMo1
 tAFt9+eobb20m0ZqJwQw7dcIxgQFwgO20aBlLw0Jhw/+oRAg+btozLkspMSDsAl3Y9DN4l
 HPHmReVFMl/r3NboDTYBQJ5O8hUYfl0=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-442-703nJ7luN0ex3BLy5ox0UQ-1; Wed,
 07 Aug 2024 14:49:38 -0400
X-MC-Unique: 703nJ7luN0ex3BLy5ox0UQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A199519560A2; Wed,  7 Aug 2024 18:49:37 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.79])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D89119560AE; Wed,  7 Aug 2024 18:49:35 +0000 (UTC)
Date: Wed, 7 Aug 2024 19:49:32 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, rjones@redhat.com,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH 1/2] util: Refactor json-writer's string sanitizer to be
 public
Message-ID: <ZrPBvOSrLjgTNlV3@redhat.com>
References: <20240802194156.2131519-4-eblake@redhat.com>
 <20240802194156.2131519-5-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240802194156.2131519-5-eblake@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.144,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
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
> ---
>  include/qemu/unicode.h |  3 ++
>  qobject/json-writer.c  | 47 +----------------------
>  util/unicode.c         | 84 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 88 insertions(+), 46 deletions(-)

I was going to ask for a unit test, but "escaped_string" in
test-qjson.c  looks like it will be covering this sufficiently
well already, that we don't need to test it in isolation.

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


