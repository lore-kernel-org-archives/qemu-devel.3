Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D0FCE9D812
	for <qemu-devel@archiver.kernel.org>; Sun,  5 Apr 2026 18:11:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9Rwi-0001pV-UF; Sun, 05 Apr 2026 14:11:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1w9Rwh-0001p7-GH
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:11:39 -0400
Received: from mout01.posteo.de ([185.67.36.65])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <th.huth+qemu@posteo.eu>)
 id 1w9Rwf-00046K-La
 for qemu-devel@nongnu.org; Sun, 05 Apr 2026 14:11:39 -0400
Received: from submission (posteo.de [185.67.36.169]) 
 by mout01.posteo.de (Postfix) with ESMTPS id 90A2B240028
 for <qemu-devel@nongnu.org>; Sun,  5 Apr 2026 20:11:35 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=posteo.eu; s=2017;
 t=1775412695; bh=FQm69UZGcGbkg4PG7Mm3WDMpFxwnuJJu0T5Ppef6F4M=;
 h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
 Content-Transfer-Encoding:From;
 b=El644tHioNziMQxbZ96EMETjN3QS6mWJSH3RKirKtLNk6MOI9ZU2x4d8Tv/SQD1N6
 zA5k5WClMZ3BswOqDk7/d+uociGvMnDsGEwxP9GVnRiBik0OeKHTKuTjsDjT8BNxPj
 dLuQXM12FoerK57ZaX0UrPRBdKyiIPVMauBH/SHFhjtraQnc14RagfH2zpdml2fQh0
 87OwGGJELWeZBREQa4cnLd6i74xBIltXbqo6ych9IIbTOfCkpf8VDDkbM7DqQ5bdnI
 IF70ADMYdYLrNdDCTOu5bXPFbMqn93+YBZRgXf2Ytno3JLIcIHOboCjk4tyqom5Er8
 0XpEBmYGmGjlQ==
Received: from customer (localhost [127.0.0.1])
 by submission (posteo.de) with ESMTPSA id 4fpgWp04cgz6tsb;
 Sun,  5 Apr 2026 20:11:33 +0200 (CEST)
Date: Sun, 05 Apr 2026 18:11:35 +0000
From: Thomas Huth <th.huth+qemu@posteo.eu>
To: Christian Brauner <brauner@kernel.org>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, Eric Blake
 <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, Laurent Vivier
 <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, Philippe
 =?UTF-8?B?TWF0aGlldS1EYXVkw6k=?= <philmd@linaro.org>, "Daniel P.
 =?UTF-8?B?QmVycmFuZ8Op?=" <berrange@redhat.com>
Subject: Re: [PATCH 4/5] tests/qtest: add tests for dynamic monitor add/remove
Message-ID: <20260405201133.6f04b585@tpx1>
In-Reply-To: <20260402-work-qmp-monitor-hotplug-v1-4-6313a5cdd574@kernel.org>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
 <20260402-work-qmp-monitor-hotplug-v1-4-6313a5cdd574@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=185.67.36.65; envelope-from=th.huth+qemu@posteo.eu;
 helo=mout01.posteo.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am Thu, 02 Apr 2026 23:19:19 +0200
schrieb Christian Brauner <brauner@kernel.org>:

> Test the monitor-add, monitor-remove, and query-monitors QMP commands:
> 
> - Basic lifecycle: chardev-add -> monitor-add -> query-monitors ->
>   monitor-remove -> chardev-remove
> - Error: duplicate monitor id
> - Error: monitor-remove on nonexistent id
> - Error: monitor-add with nonexistent chardev
> - Re-add after remove: same id and chardev reusable after removal
> 
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> ---
>  tests/qtest/qmp-test.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 101 insertions(+)
> 
> diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> index edf0886787..9dbd3a6103 100644
> --- a/tests/qtest/qmp-test.c
> +++ b/tests/qtest/qmp-test.c
> @@ -337,6 +337,105 @@ static void test_qmp_missing_any_arg(void)
>      qtest_quit(qts);
>  }
>  
> +static void test_qmp_monitor_add_remove(void)
> +{
> +    QTestState *qts;
> +    QDict *resp;
> +
> +    qts = qtest_init(common_args);
> +
> +    /* Create a null chardev for the dynamic monitor */
> +    resp = qtest_qmp(qts,
> +                     "{'execute': 'chardev-add',"
> +                     " 'arguments': {'id': 'monitor-chardev',"
> +                     "               'backend': {'type': 'null',"
> +                     "                           'data': {}}}}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +
> +    /* Add a dynamic monitor */
> +    resp = qtest_qmp(qts,
> +                     "{'execute': 'monitor-add',"
> +                     " 'arguments': {'id': 'dyn-mon',"
> +                     "               'chardev': 'monitor-chardev'}}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +
> +    /* Verify it shows up in query-monitors */
> +    resp = qtest_qmp(qts, "{'execute': 'query-monitors'}");
> +    g_assert(!qdict_haskey(resp, "error"));
> +    qobject_unref(resp);
> +
> +    /* Error: duplicate id */
> +    resp = qtest_qmp(qts,
> +                     "{'execute': 'monitor-add',"
> +                     " 'arguments': {'id': 'dyn-mon',"
> +                     "               'chardev': 'monitor-chardev'}}");
> +    qmp_expect_error_and_unref(resp, "GenericError");
> +
> +    /* Remove the dynamic monitor */
> +    resp = qtest_qmp(qts,
> +                     "{'execute': 'monitor-remove',"
> +                     " 'arguments': {'id': 'dyn-mon'}}");
> +    g_assert(qdict_haskey(resp, "return"));
> +    qobject_unref(resp);
> +
> +    /* Error: remove nonexistent */
> +    resp = qtest_qmp(qts,
> +                     "{'execute': 'monitor-remove',"
> +                     " 'arguments': {'id': 'dyn-mon'}}");
> +    qmp_expect_error_and_unref(resp, "GenericError");
> +
> +    /* Error: remove CLI monitor (the default one) -- find its id first.
> +     * CLI monitors typically have no id, so use a bogus id to test. */

Please check coding style with scripts/checkpatch.pl - I guess it will
complain about the multiline comment here.

Apart from that, the patch looks fine to me. But I think either a qtest or
a functional test should be enough, you don't need both. I'd maybe
recommend to just keep the qtest, since these tests are often run more
frequently than the functional tests.

 Thomas

