Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDC30D10375
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 07:17:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOWF9-0005Je-1I; Thu, 27 Nov 2025 02:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOWEc-00054B-Sj
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 02:16:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vOWEU-0000eL-33
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 02:16:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764227759;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:resent-to:
 resent-from:resent-message-id:in-reply-to:in-reply-to:  references:references; 
 bh=BmsuoLSzroiR22PuN5GEjJeFMVvNkXKNRLRdyHCwxNo=;
 b=M30IrDBP9EvbW9oOMJtXodjp/vqGCTrNR99OSANrftyFvEFDfJwcvJ/gWD5ONPgdpT1Pc5
 AfqCEhd6SkM9qSE5XMQsnMz/gFvzUWIOCEud5293wc36XlAU29IW0OYsO3sx76Xp56zL2n
 3r4SfhXkFzX12sGcM/Z/XXhJp5nPFmY=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-179-NZTM6WrRNvaguobKIa_2ig-1; Thu,
 27 Nov 2025 02:15:53 -0500
X-MC-Unique: NZTM6WrRNvaguobKIa_2ig-1
X-Mimecast-MFC-AGG-ID: NZTM6WrRNvaguobKIa_2ig_1764227752
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 84EC8195605F; Thu, 27 Nov 2025 07:15:51 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2F6A71800840; Thu, 27 Nov 2025 07:15:50 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 9C34A21E6A27; Thu, 27 Nov 2025 08:15:47 +0100 (CET)
Resent-To: peter.maydell@linaro.org, mail@maciej.szmigiero.name,
 qemu-devel@nongnu.org, farosas@suse.de, vsementsov@yandex-team.ru
Resent-From: Markus Armbruster <armbru@redhat.com>
Resent-Date: Thu, 27 Nov 2025 08:15:47 +0100
Resent-Message-ID: <875xaw9c9o.fsf@pond.sub.org>
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>, qemu-devel@nongnu.org,
 jmarcin@redhat.com,  marcandre.lureau@redhat.com,  farosas@suse.de,
 berrange@redhat.com,  vsementsov@yandex-team.ru,
 mail@maciej.szmigiero.name,  peter.maydell@linaro.org
Subject: Re: [PATCH 2.5/6] error: Explain why we don't g_autoptr(Error)
In-Reply-To: <aScobLHb0FQ6o_Gj@x1.local> (Peter Xu's message of "Wed, 26 Nov
 2025 11:18:52 -0500")
References: <20251125204648.857018-3-peterx@redhat.com>
 <20251126143427.2470598-1-armbru@redhat.com>
 <620bdcd0-a7e0-4b23-95c9-9752156a55e1@redhat.com>
 <aScobLHb0FQ6o_Gj@x1.local>
Date: Thu, 27 Nov 2025 08:01:57 +0100
Message-ID: <87fra09cwq.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Peter Xu <peterx@redhat.com> writes:

> On Wed, Nov 26, 2025 at 04:14:55PM +0100, C=C3=A9dric Le Goater wrote:
>> On 11/26/25 15:34, Markus Armbruster wrote:
>> > Suggested-by: Peter Maydell <peter.maydell@linaro.org>
>> > Signed-off-by: Markus Armbruster <armbru@redhat.com>
>> > ---
>> >   include/qapi/error.h | 17 +++++++++++++++++
>> >   1 file changed, 17 insertions(+)
>> >=20
>> > diff --git a/include/qapi/error.h b/include/qapi/error.h
>> > index f3ce4a4a2d..fc018b4c59 100644
>> > --- a/include/qapi/error.h
>> > +++ b/include/qapi/error.h
>> > @@ -437,6 +437,23 @@ Error *error_copy(const Error *err);
>> >    */
>> >   void error_free(Error *err);
>> > +/*
>> > + * Note: we intentionally do not enable g_autoptr(Error) with
>> > + * G_DEFINE_AUTO_CLEANUP_CLEAR_FUNC(Error, error_free).
>> > + *
>> > + * Functions that report or propagate an error take ownership of the
>> > + * Error object.  Explicit error_free() is needed when you handle an
>> > + * error in some other way.  This is rare.
>> > + *
>> > + * g_autoptr(Error) would call error_free() automatically on return.
>> > + * To avoid a double-free, we'd have to manually clear the pointer
>> > + * every time we propagate or report.
>> > + *
>> > + * Thus, g_autoptr(Error) would make the rare case easier to get right
>> > + * (less prone to leaks), and the common case easier to get wrong
>> > + * (more prone to double-free).
>
> How about we further poison the auto free altogether?
>
> IIUC this should work:
>
> +extern void
> +__attribute__((error("Error should not be used with g_autoptr")))
> +error_free_poisoned(Error *err);
> +
> +G_DEFINE_AUTOPTR_CLEANUP_FUNC(Error, error_free_poisoned)

Cute.  Why not.  I'll post a new patch.


