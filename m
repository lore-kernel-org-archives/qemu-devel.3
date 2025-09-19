Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFA8DCAC59A
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Sep 2025 12:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzZst-0000UY-Cl; Fri, 19 Sep 2025 08:06:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzZsg-0000Qv-Rj
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:06:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1uzZsX-0007GP-Hc
 for qemu-devel@nongnu.org; Fri, 19 Sep 2025 08:06:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758283575;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T01AH818qeNeowtpwxea0ArQoFwC0ja08QtMrfMfTF4=;
 b=Y9+3sob5v/ZjJJgcspM9bPrB/LTLBGNDvF2J12JXuSdEvjOK47cLhyY6Y/b7xk0Go4L1oH
 eb+BWDqLNrdIjC4fh7K6J13E47Jx7VFRKGZwDTPFCib1UweRRQ07bbV9bS0+XBY5SQOIa8
 YN9yGPuBiVjIw4WBcMWTkpYAbHSzacM=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-206-F38_89h1O6G11tso2B32eA-1; Fri,
 19 Sep 2025 08:06:14 -0400
X-MC-Unique: F38_89h1O6G11tso2B32eA-1
X-Mimecast-MFC-AGG-ID: F38_89h1O6G11tso2B32eA_1758283573
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4972D1800293; Fri, 19 Sep 2025 12:06:13 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.33])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 009EE180035E; Fri, 19 Sep 2025 12:06:12 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 3855521E6A27; Fri, 19 Sep 2025 14:06:10 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] qom: use ERRP_GUARD in user_creatable_complete
In-Reply-To: <aM1BhOI4yE2SBNz_@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 19 Sep 2025 12:41:56 +0100")
References: <20250919101504.1503735-1-berrange@redhat.com>
 <87cy7m3cj9.fsf@pond.sub.org> <aM1BhOI4yE2SBNz_@redhat.com>
Date: Fri, 19 Sep 2025 14:06:10 +0200
Message-ID: <87v7lezlxp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.105,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

> On Fri, Sep 19, 2025 at 01:30:18PM +0200, Markus Armbruster wrote:
>> Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:
>>=20
>> > With error_propagate, the stack trace from any error_abort/fatal
>> > usage will start from the error_propagate() call, which is largely
>> > useless. Using ERRP_GUARD ensures the stack trace starts from
>> > the origin that reported the error.
>>=20
>> Yes.
>>=20
>> I've been chipping at error_propagate() uses on and off for a while.
>> There are hundreds left.
>
> Are there cases where it is still OK to use error_propagate or should
> we be looking to eliminate all its usage ?

The common use of error_propagate() is to propagate an error received
from a function to the caller.  This is better done with ERRP_GUARD().
qapi/error.h:

 * Call a function, receive an error from it, and pass it to the caller
 * - when the function returns a value that indicates failure, say
 *   false:
 *     if (!foo(arg, errp)) {
 *         handle the error...
 *     }
 * - when it does not, say because it is a void function:
 *     ERRP_GUARD();
 *     foo(arg, errp);
 *     if (*errp) {
 *         handle the error...
 *     }
 * More on ERRP_GUARD() below.
 *
 * Code predating ERRP_GUARD() still exists, and looks like this:
 *     Error *err =3D NULL;
 *     foo(arg, &err);
 *     if (err) {
 *         handle the error...
 *         error_propagate(errp, err); // deprecated
 *     }

We occasionally store errors on the heap, and use error_propagate() to move
them into an @errp argument.  qapi/error.h:

 * Pass an existing error to the caller:
 *     error_propagate(errp, err);
 * This is rarely needed.  When @err is a local variable, use of
 * ERRP_GUARD() commonly results in more readable code.

error_propagate() can also be used to accumulate errors.  This cannot be
done with ERRP_GUARD().  qapi/error.h:

 * Receive and accumulate multiple errors (first one wins):
 *     Error *err =3D NULL, *local_err =3D NULL;
 *     foo(arg, &err);
 *     bar(arg, &local_err);
 *     error_propagate(&err, local_err);
 *     if (err) {
 *         handle the error...
 *     }

Accumulating errors is commonly a bad idea.  Note that
g_propagate_error() explicitly prohibits such usage.  We deviated from
it.

The *possibility* of intentional error acculumation makes conversions to
ERRP_GUARD() harder.  Perhaps we should track down all uses of error
accumulation, then change error_propagate() to prohibit it.

[...]


