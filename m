Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAA8EB7EAC
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Mar 2026 09:59:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vxj0e-0006XG-C8; Wed, 04 Mar 2026 04:59:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxj0c-0006Wt-LW
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:59:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vxj0a-0004UE-Ug
 for qemu-devel@nongnu.org; Wed, 04 Mar 2026 04:59:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772618351;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=XwaJZGUrc3/GtI8IhGfByEsnwYSAa4z44LKHfN6Q6+Q=;
 b=cKGJm6mvCwE3t9y7FyIyVeoKNRniO7J0tMGQqtI+BdZb7wM1N7Cmdnj8U8NWwn7v6O8I9I
 v+uO2xPVfeAcYu9N3TXE44+YumqyBsdYIpqkK8GLZrW6ALrBZfISrBgtEgX6poQMEpAN03
 z/A8dhCQuhKilmLdoyqRhNgSYrLqA90=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-612-w82f1UEROtKM0QySErnSSg-1; Wed,
 04 Mar 2026 04:59:08 -0500
X-MC-Unique: w82f1UEROtKM0QySErnSSg-1
X-Mimecast-MFC-AGG-ID: w82f1UEROtKM0QySErnSSg_1772618347
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A6CE1955D9C; Wed,  4 Mar 2026 09:59:05 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.30])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9AD50180049D; Wed,  4 Mar 2026 09:59:03 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 420FC21E692F; Wed, 04 Mar 2026 10:59:01 +0100 (CET)
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
Subject: Re: [PATCH v3 3/4] tests: Avoid sprintf() with "%.6f"
In-Reply-To: <20260304-nvme-v3-3-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp> (Akihiko
 Odaki's message of "Wed, 04 Mar 2026 15:28:35 +0900")
References: <20260304-nvme-v3-0-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
 <20260304-nvme-v3-3-bbb1b7fd2d0b@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 04 Mar 2026 10:59:01 +0100
Message-ID: <87wlzrkja2.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 27
X-Spam_score: 2.7
X-Spam_bar: ++
X-Spam_report: (2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.322,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=1.141, SPF_HELO_PASS=-0.001,
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

I'd like us to spell out that this is cleanup, not a bug fix.  I suggest
to start with the warning.  Something like this:

    tests: Clean up double comparisons to avoid compiler warning

    To enable -Wformat-overflow=2, we need to clean up a couple of false
    positives:

    <insert warnings here>

Now explain why they are false:

    These buffers cannot actually overflow because the doubles are
    between 0 and 31.0/3 inclusive.

Then justify the solution:

    However, formatting doubles just to compare them is silly.  Compare
    them directly instead.  To avoid potential rounding trouble, change
    the numbers tested to be representable exactly in double.

> Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
> ---
>  tests/unit/test-qobject-input-visitor.c  | 8 ++------
>  tests/unit/test-qobject-output-visitor.c | 7 ++-----
>  2 files changed, 4 insertions(+), 11 deletions(-)
>
> diff --git a/tests/unit/test-qobject-input-visitor.c b/tests/unit/test-qobject-input-visitor.c
> index 84bdcdf702e0..beee11db4e47 100644
> --- a/tests/unit/test-qobject-input-visitor.c
> +++ b/tests/unit/test-qobject-input-visitor.c
> @@ -500,7 +500,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
>      g_string_append_printf(json, "'number': [");
>      sep = "";
>      for (i = 0; i < 32; i++) {
> -        g_string_append_printf(json, "%s%f", sep, (double)i / 3);
> +        g_string_append_printf(json, "%s%f", sep, (double)i / FLT_RADIX);
>          sep = ", ";
>      }
>      g_string_append_printf(json, "], ");
> @@ -583,11 +583,7 @@ static void test_visitor_in_list_struct(TestInputVisitorData *data,
>  
>      i = 0;
>      for (num_list = arrs->number; num_list; num_list = num_list->next) {
> -        char expected[32], actual[32];
> -
> -        sprintf(expected, "%.6f", (double)i / 3);
> -        sprintf(actual, "%.6f", num_list->value);
> -        g_assert_cmpstr(expected, ==, actual);
> +        g_assert_cmpfloat(num_list->value, ==, (double)i / FLT_RADIX);
>          i++;
>      }
>  
> diff --git a/tests/unit/test-qobject-output-visitor.c b/tests/unit/test-qobject-output-visitor.c
> index 407ab9ed505a..3c47b28f6638 100644
> --- a/tests/unit/test-qobject-output-visitor.c
> +++ b/tests/unit/test-qobject-output-visitor.c
> @@ -538,7 +538,7 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
>      }
>  
>      for (i = 31; i >= 0; i--) {
> -        QAPI_LIST_PREPEND(arrs->number, (double)i / 3);
> +        QAPI_LIST_PREPEND(arrs->number, (double)i / FLT_RADIX);
>      }
>  
>      for (i = 31; i >= 0; i--) {
> @@ -571,12 +571,9 @@ static void test_visitor_out_list_struct(TestOutputVisitorData *data,
>      i = 0;
>      QLIST_FOREACH_ENTRY(qlist, e) {
>          QNum *qvalue = qobject_to(QNum, qlist_entry_obj(e));
> -        char expected[32], actual[32];
>  
>          g_assert(qvalue);
> -        sprintf(expected, "%.6f", (double)i / 3);
> -        sprintf(actual, "%.6f", qnum_get_double(qvalue));
> -        g_assert_cmpstr(actual, ==, expected);
> +        g_assert_cmpfloat(qnum_get_double(qvalue), ==, (double)i / FLT_RADIX);
>          i++;
>      }

With an improved commit message
Reviewed-by: Markus Armbruster <armbru@redhat.com>


