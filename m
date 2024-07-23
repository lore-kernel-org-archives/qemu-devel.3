Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3B7FC3DA63
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Jul 2024 11:37:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sWDoz-0001Gp-62; Tue, 23 Jul 2024 07:36:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWDoy-0001E9-82
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:36:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sWDow-00031B-AF
 for qemu-devel@nongnu.org; Tue, 23 Jul 2024 07:36:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721734600;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qwo9o2hK11YlOWWF7FwRS7b28LoxIw1TvvLmmMzaC8M=;
 b=JcWyiNWS8/c0odMiDGvpZkAi08HYu/gi982wCTd79lLJKN+/R7O5iZr6y6f3IPvn6rUyMi
 l213rIjWBlAaAix67dHMC98x4j6BBbMUrAMgTCT7ZYIL454ULzksp96Gw0FT+M/zUUQDNK
 zzHHQQeinONUX6WIP3wFVYmCIzCy+3A=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-558-pamfHetuO3qV3qWXsEajOQ-1; Tue,
 23 Jul 2024 07:36:37 -0400
X-MC-Unique: pamfHetuO3qV3qWXsEajOQ-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4DE321955D5A; Tue, 23 Jul 2024 11:36:35 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.65])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6955719560B2; Tue, 23 Jul 2024 11:36:34 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1BFFC21E668F; Tue, 23 Jul 2024 13:36:32 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Michael Roth <michael.roth@amd.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/5] qapi: allow for g_autoptr(Error) usage
In-Reply-To: <20240722131611.2820041-2-berrange@redhat.com> ("Daniel
 P. =?utf-8?Q?Berrang=C3=A9=22's?= message of "Mon, 22 Jul 2024 14:16:07
 +0100")
References: <20240722131611.2820041-1-berrange@redhat.com>
 <20240722131611.2820041-2-berrange@redhat.com>
Date: Tue, 23 Jul 2024 13:36:32 +0200
Message-ID: <87jzhcuypr.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.133,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> While common error propagation practice does not require manually
> free'ing of local 'Error' objects, there are some cases where this
> is needed. One example is where the 'Error' object is only used
> for providing info to a trace event probe. Supporting g_autoptr
> avoids the need to manually call 'error_free'.
>
> Signed-off-by: Daniel P. Berrang=C3=A9 <berrange@redhat.com>
> ---
>  include/qapi/error.h | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/include/qapi/error.h b/include/qapi/error.h
> index 71f8fb2c50..6e429809d8 100644
> --- a/include/qapi/error.h
> +++ b/include/qapi/error.h
> @@ -437,6 +437,8 @@ Error *error_copy(const Error *err);
>   */
>  void error_free(Error *err);
>=20=20
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free);
> +
>  /*
>   * Convenience function to assert that *@errp is set, then silently free=
 it.
>   */

The Error interface is designed for a certain way of using it: an Error
object flows from the spot detecting the error to a spot handling it.
Failure to handle the error is a memory leak.  Our tooling can help with
tracking these down.

The interface tries to make the intended use easy: functions that report
an error consume the Error object.  Explicit error_free() should only
needed when you handle an error in some other way.

When such an explicit error_free() is needed on all paths to return,
then replacing it with auto-freeing is nice.  But what if it isn't?

Say we add a new error path and use error_report_err(err) there.  This
has always been just fine.  No more: if @err is auto-freed, this is a
double-free.  We have to also add err =3D NULL.  Feels like a trap for
developers to me.

Your use of auto-freeing is in the next patch.  It's this pattern:

    g_autoptr(Error) err =3D NULL;

    if (!frobnicate(args, &err)) {
        trace_frobnicate_err(..., error_get_pretty(err));
    }

You want to report the error to a trace point.  That's perfectly
legitimate.  The problem is that this kind of error reporting function
does not free, unlike the ones provided by qapi/error.h.

We could extend tracing to accept Error values, so that

        trace_frobnicate_err(..., err);

does free.  Doesn't seem worthwhile unless we find quite a few more uses
for it.

If we conclude we want to provide auto-free as an option, we at least
need to point out the trap in a comment.  A bit of a pain to write, and
whether people will read, understand, and remember it is uncertain.

My gut feeling right now: stick to the design, and free manually.  If
you think my gut is wrong, tell me.


