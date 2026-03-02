Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D317E9B36B
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 11:52:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vx1pC-0007ej-TV; Mon, 02 Mar 2026 06:52:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vx1p9-0007dV-4U
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:52:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vx1p4-0007Xf-Aj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 06:52:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772452345;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YWX4v3zZ8/+//gPorMIBUcjscnX2sRFl/j3aSMy3EQg=;
 b=OEd1lQlqfOsOdCuzLR27yc43qixKba8ovx6KOc6dcTq/3v/7jQo7EsYpT43ZKM3tp9HTmV
 hVZJVkaaF2/MbzR6UY8hsuHhApRJL3kIUgtzCbeoH4m/beBZM3btcqLODei1NmavW02XpW
 xmQE0+cecTn00HfxtlZr5Z2ch2JkxQ8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-315-smBBWQ4rPJCE1uqdwdfm1Q-1; Mon,
 02 Mar 2026 06:52:17 -0500
X-MC-Unique: smBBWQ4rPJCE1uqdwdfm1Q-1
X-Mimecast-MFC-AGG-ID: smBBWQ4rPJCE1uqdwdfm1Q_1772452335
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E120719560A6; Mon,  2 Mar 2026 11:52:14 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.4])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4C66919560A3; Mon,  2 Mar 2026 11:52:13 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7A7EC21E692F; Mon, 02 Mar 2026 12:52:10 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: qemu-devel@nongnu.org,  Viktor Prutyanov
 <viktor.prutyanov@phystech.edu>,  Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,  Michael Roth
 <michael.roth@amd.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,  Daniel P. =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Keith Busch
 <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>,  Jesper Devantier
 <foss@defmacro.it>,  qemu-block@nongnu.org
Subject: Re: [PATCH v2 3/4] tests: Grow buffers for double string
In-Reply-To: <20260302-nvme-v2-3-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Mon, 02 Mar 2026 16:48:10 +0900")
References: <20260302-nvme-v2-0-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
 <20260302-nvme-v2-3-37ad8b5788c3@rsg.ci.i.u-tokyo.ac.jp>
Date: Mon, 02 Mar 2026 12:52:10 +0100
Message-ID: <87pl5m1mad.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 24
X-Spam_score: 2.4
X-Spam_bar: ++
X-Spam_report: (2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188, SPF_HELO_PASS=-0.001,
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

Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> writes:

> A string that represents a double can be long if it is an exponentially
> large number.
>
> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  tests/unit/test-qobject-input-visitor.c  | 2 +-
>  tests/unit/test-qobject-output-visitor.c | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
> index 84bdcdf702e0..baff9243313c 100644
> --- a/tests/unit/test-qobject-input-visitor.c
> +++ b/tests/unit/test-qobject-input-visitor.c
> @@ -583,7 +583,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
>  
>      i = 0;
>      for (num_list = arrs->number; num_list; num_list = num_list->next) {
> -        char expected[32], actual[32];
> +        char expected[318], actual[318];

Where does 318 come from?

>  
>          sprintf(expected, "%.6f", (double)i / 3);
>          sprintf(actual, "%.6f", num_list->value);
           g_assert_cmpstr(expected, ==, actual);
           i++;
       }

Existing code is safe, because the numbers run from 0, 1.0/3, ...,
31.0/3.

Its purpose is to check the input visitor parses number arrays
correctly.  Doing it this way is questionable.  Elsewhere in this file,
we get away with the equivalent of

           g_assert_cmpfloat(num_list->value, ==, (double)i / 3);

Yes, double can't represent the fractions exactly, but if we're
concerned about that, we should test the difference is less than
epsilon, or simply use representable values.

> diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
> index 407ab9ed505a..ae05a726f775 100644
> --- a/tests/unit/test-qobject-output-visitor.c
> +++ b/tests/unit/test-qobject-output-visitor.c
> @@ -571,7 +571,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
>      i = 0;
>      QLIST_FOREACH_ENTRY(qlist, e) {
>          QNum *qvalue = qobject_to(QNum, qlist_entry_obj(e));
> -        char expected[32], actual[32];
> +        char expected[318], actual[318];
>  
>          g_assert(qvalue);
>          sprintf(expected, "%.6f", (double)i / 3);

Likewise.


