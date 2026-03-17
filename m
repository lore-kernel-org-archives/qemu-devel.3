Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D075DF3380C
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Mar 2026 07:36:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2OxU-00086E-LU; Tue, 17 Mar 2026 03:35:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2OxR-000860-Ee
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:35:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1w2OxP-0005ln-A6
 for qemu-devel@nongnu.org; Tue, 17 Mar 2026 03:35:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773732912;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DPTqDaqt1TG31j4dbwwT8v5ORZJQ4ugI41iRVLRAn/c=;
 b=ggbLqnL4W+1dnynGh7If+sXDDeSeYCD7YU/mUGy04aheoHy+cGuJ96riMzYPf/n2ePe3Ac
 hGf0dt3Ns3HCMF1FKlyCtQYr5Dy+vyMyd8SEnsVW43FZFb+nbGSW4CHTRqr4Jk2BGsyIrf
 rhjs2sMD6Tb18m8PDrwzY4A1JyB8RpM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-360-ryYPvEC1M-iDvxvobaBafw-1; Tue,
 17 Mar 2026 03:35:10 -0400
X-MC-Unique: ryYPvEC1M-iDvxvobaBafw-1
X-Mimecast-MFC-AGG-ID: ryYPvEC1M-iDvxvobaBafw_1773732909
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A6FF11944EB6; Tue, 17 Mar 2026 07:35:09 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.6])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 38FC7180075C; Tue, 17 Mar 2026 07:35:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D654E21E6937; Tue, 17 Mar 2026 08:35:06 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: Re: -device T,help crashes
In-Reply-To: <bd616907-9265-4ca2-83d3-d157d717c916@redhat.com> (Thomas Huth's
 message of "Tue, 17 Mar 2026 07:24:40 +0100")
References: <87pl5abgpl.fsf@pond.sub.org> <87bjgtzcoa.fsf@pond.sub.org>
 <bd616907-9265-4ca2-83d3-d157d717c916@redhat.com>
Date: Tue, 17 Mar 2026 08:35:06 +0100
Message-ID: <87y0jqlxhx.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Thomas Huth <thuth@redhat.com> writes:

> On 12/03/2026 09.15, Markus Armbruster wrote:
>> Markus Armbruster <armbru@redhat.com> writes:
> ...
>>> These crashes escape tests/qtest/device-introspect-test, because it
>>> covers only HMP "device_add T,help", not CLI "-device T,help".
>>
>> Anyone wants to cook up a patch to cover -device?
>
> Quick'n'dirty patch:
>
> diff --git a/tests/qtest/device-introspect-test.c b/tests/qtest/device-introspect-test.c
> --- a/tests/qtest/device-introspect-test.c
> +++ b/tests/qtest/device-introspect-test.c
> @@ -105,6 +105,7 @@ static void test_one_device(QTestState *qts, const char *type)
>      QDict *resp;
>      char *help, *escaped;
>      GRegex *comma;
> +    int ret;
>
>      g_test_message("Testing device '%s'", type);
>
> @@ -119,6 +120,17 @@ static void test_one_device(QTestState *qts, const char *type)
>
>      help = qtest_hmp(qts, "device_add \"%s,help\"", escaped);
>      g_free(help);
> +
> +    if (!g_str_equal(type, "nonexistent") && !g_str_equal(type, "device")) {
> +        help = g_strdup_printf("%s -device \"%s,help\" > /dev/null", qtest_qemu_binary(NULL), escaped);
> +        ret = system(help);

Not using qtest_init() or similar.  Hmm.

> +        g_free(help);
> +        if (ret) {
> +            fprintf(stderr, "Running qemu with -device %s,help failed!\n", escaped);
> +            abort();
> +        }
> +    }
> +
>      g_free(escaped);
>  }
>
> But I think it needs some more work - we likely don't want to run this for each test run since it slows down the test quite a bit. And the g_test_quick() switch is already used for something else here.

It's used to test with every machine type, not just with "none".

I think we could also use it to additionally test -device just with
"none".  Testing it with every machine type would be even slower, and I
doubt it's worthwhile.

Another idea to conserve cycles: use a unit test instead.

> Anyway, found these additional issues so far:
>
>  ./qemu-system-ppc -device raven-pcihost,help
>  Segmentation fault (core dumped)
>  ./qemu-system-sparc -device cgthree,help
>  Segmentation fault (core dumped)

One more: sparc sun-tcx


