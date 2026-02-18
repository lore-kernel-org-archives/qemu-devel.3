Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BD1AE9A03B
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Feb 2026 09:53:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vseEM-0003Ad-0r; Wed, 18 Feb 2026 04:52:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vseEI-00039n-UW
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:52:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vseEF-0003O7-3C
 for qemu-devel@nongnu.org; Wed, 18 Feb 2026 04:52:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771408336;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=p/o48FhHUtVqRP8QJE7g4XyNXIXv3G98fFT/ILWFulI=;
 b=BJaD0fL9ntlNGhJzEA2jIwmfiZ/qQclydHSyzoeZ+1S51NbF7Qv0doWayUbh8edLbgJG/K
 +du4TmkCAcadjCUNSBzcfFXmuTWe189i5JW+je4/G6F2jNX1KPiemKhYvPoTSZ2ycgyO7V
 tz8RevViXEp2sY6hwr7obE2qL9zpS4g=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-619-yp4l4jOuP0yIkUJ0thNoWg-1; Wed,
 18 Feb 2026 04:52:12 -0500
X-MC-Unique: yp4l4jOuP0yIkUJ0thNoWg-1
X-Mimecast-MFC-AGG-ID: yp4l4jOuP0yIkUJ0thNoWg_1771408330
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 604941956058; Wed, 18 Feb 2026 09:52:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.14])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A48ED1955F43; Wed, 18 Feb 2026 09:52:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 38B7021E692D; Wed, 18 Feb 2026 10:52:07 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Stefan Weil <sw@weilnetz.de>,  "Dr.
 David Alan Gilbert" <dave@treblig.org>,  Pierrick Bouvier
 <pierrick.bouvier@linaro.org>,  devel@lists.libvirt.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  =?utf-8?Q?Marc-Andr?=
 =?utf-8?Q?=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Hanna Reitz <hreitz@redhat.com>,  Kevin
 Wolf <kwolf@redhat.com>,  qemu-block@nongnu.org,  qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,  Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,  Richard Henderson
 <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 12/27] util: avoid repeated prefix on incremental
 qemu_log calls
In-Reply-To: <20260211152508.732487-13-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Wed, 11 Feb 2026 15:24:53
 +0000")
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-13-berrange@redhat.com>
Date: Wed, 18 Feb 2026 10:52:07 +0100
Message-ID: <87ms16e5vc.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -13
X-Spam_score: -1.4
X-Spam_bar: -
X-Spam_report: (-1.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.043,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 GB_FAKE_RF=0.754, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001,
 RCVD_IN_MSPIKE_WL=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> There are three general patterns to QEMU log output
>
>  1. Single complete message calls
>
>       qemu_log("Some message\n");
>
>  2. Direct use of fprintf
>
>       FILE *f =3D qemu_log_trylock()
>       fprintf(f, "...");
>       fprintf(f, "...");
>       fprintf(f, "...\n");
>       qemu_log_unlock(f)

Real code needs to check @f or risk crashing.  Shouldn't we show that
here?

>  3. Mixed use of qemu_log_trylock/qemu_log()
>
>       FILE *f =3D qemu_log_trylock()
>       qemu_log("....");
>       qemu_log("....");
>       qemu_log("....\n");
>       qemu_log_unlock(f)
>
> When message prefixes are enabled, the timestamp will be
> unconditionally emitted for all qemu_log() calls. This
> works fine in the 1st case, and has no effect in the 2nd
> case. In the 3rd case, however, we get the timestamp
> printed over & over in each fragment.
>
> One can suggest that pattern (3) is pointless as it is
> functionally identical to (2) but with extra indirection
> and overhead. None the less we have a fair bit of code
> that does this.
>
> The qemu_log() call itself is nothing more than a wrapper
> which does pattern (2) with a single fprintf() call.

qemu_log_trylock()'s lock is recursive.  Worth a comment?  Not sure.

> One might question whether (2) should include the message
> prefix in the same way that (1), but there are scenarios
> where this could be inappropriate / unhelpful such as the
> CPU register dumps or linux-user strace output.
>
> This patch fixes the problem in pattern (3) by keeping
> track of the call depth of qemu_log_trylock() and then
> only emitting the the prefix when the starting depth
> was zero. In doing this qemu_log_trylock_context() is
> also introduced as a variant of qemu_log_trylock()
> that emits the prefix. Callers doing to batch output
> can thus choose whether a prefix is appropriate or
> not.
>
> Fixes: 012842c07552 (log: make '-msg timestamp=3Don' apply to all qemu_lo=
g usage)
> Reported-by: Richard Henderson <richard.henderson@linaro.org>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


