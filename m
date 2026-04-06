Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEB56F46C44
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 14:37:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9l4f-00085O-FF; Mon, 06 Apr 2026 10:37:09 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9l4d-0007zL-Pe
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:37:07 -0400
Received: from sea.source.kernel.org ([172.234.252.31])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <brauner@kernel.org>)
 id 1w9l4c-0000eI-2h
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 10:37:07 -0400
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6102E40554;
 Mon,  6 Apr 2026 14:37:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0C0FC4CEF7;
 Mon,  6 Apr 2026 14:37:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1775486224;
 bh=kbw03O6QQnSJeekm6/PTxDxHqjkiPa5PMzYC3V7z32I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=mXBJFwHlKqvmLLtdGe/PKRe9cmdGMU4UMSy5OXQi8/iamdj6bWaXHpwV5A95VN0fM
 9RBw2tsmBCI+9sMAdMbsG0EInYDfj3G5uEnmVRpPWL8hqff/N+d6KTPCEes+3aQFQM
 uXHUgiCqtbqeZgsWrCQlIb1KkowN4XEdQPVFb1FX7jb0LGTSF/Dxgj7qT+0OSWoa3e
 brscIv6/oICWAcNgBsXzy9HBnqWcsuxCUM6mPBuuEBcxE8SeyoKaCf9N7b9VbVrJgo
 hdCJsNSwU3PbD68u27rgkPSfr5UxH+VN2XUrfWDnq6NHc+Tz65+1qcO1L10Y3c0c8b
 XplItq1AVUr8w==
Date: Mon, 6 Apr 2026 16:36:59 +0200
From: Christian Brauner <brauner@kernel.org>
To: Thomas Huth <th.huth+qemu@posteo.eu>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH 4/5] tests/qtest: add tests for dynamic monitor add/remove
Message-ID: <20260406-verteidigen-garage-ef6523079ddc@brauner>
References: <20260402-work-qmp-monitor-hotplug-v1-0-6313a5cdd574@kernel.org>
 <20260402-work-qmp-monitor-hotplug-v1-4-6313a5cdd574@kernel.org>
 <20260405201133.6f04b585@tpx1>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260405201133.6f04b585@tpx1>
Received-SPF: pass client-ip=172.234.252.31; envelope-from=brauner@kernel.org;
 helo=sea.source.kernel.org
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Sun, Apr 05, 2026 at 06:11:35PM +0000, Thomas Huth wrote:
> Am Thu, 02 Apr 2026 23:19:19 +0200
> schrieb Christian Brauner <brauner@kernel.org>:
> 
> > Test the monitor-add, monitor-remove, and query-monitors QMP commands:
> > 
> > - Basic lifecycle: chardev-add -> monitor-add -> query-monitors ->
> >   monitor-remove -> chardev-remove
> > - Error: duplicate monitor id
> > - Error: monitor-remove on nonexistent id
> > - Error: monitor-add with nonexistent chardev
> > - Re-add after remove: same id and chardev reusable after removal
> > 
> > Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
> > ---
> >  tests/qtest/qmp-test.c | 101 +++++++++++++++++++++++++++++++++++++++++++++++++
> >  1 file changed, 101 insertions(+)
> > 
> > diff --git a/tests/qtest/qmp-test.c b/tests/qtest/qmp-test.c
> > index edf0886787..9dbd3a6103 100644
> > --- a/tests/qtest/qmp-test.c
> > +++ b/tests/qtest/qmp-test.c
> > @@ -337,6 +337,105 @@ static void test_qmp_missing_any_arg(void)
> >      qtest_quit(qts);
> >  }
> >  
> > +static void test_qmp_monitor_add_remove(void)
> > +{
> > +    QTestState *qts;
> > +    QDict *resp;
> > +
> > +    qts = qtest_init(common_args);
> > +
> > +    /* Create a null chardev for the dynamic monitor */
> > +    resp = qtest_qmp(qts,
> > +                     "{'execute': 'chardev-add',"
> > +                     " 'arguments': {'id': 'monitor-chardev',"
> > +                     "               'backend': {'type': 'null',"
> > +                     "                           'data': {}}}}");
> > +    g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> > +
> > +    /* Add a dynamic monitor */
> > +    resp = qtest_qmp(qts,
> > +                     "{'execute': 'monitor-add',"
> > +                     " 'arguments': {'id': 'dyn-mon',"
> > +                     "               'chardev': 'monitor-chardev'}}");
> > +    g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> > +
> > +    /* Verify it shows up in query-monitors */
> > +    resp = qtest_qmp(qts, "{'execute': 'query-monitors'}");
> > +    g_assert(!qdict_haskey(resp, "error"));
> > +    qobject_unref(resp);
> > +
> > +    /* Error: duplicate id */
> > +    resp = qtest_qmp(qts,
> > +                     "{'execute': 'monitor-add',"
> > +                     " 'arguments': {'id': 'dyn-mon',"
> > +                     "               'chardev': 'monitor-chardev'}}");
> > +    qmp_expect_error_and_unref(resp, "GenericError");
> > +
> > +    /* Remove the dynamic monitor */
> > +    resp = qtest_qmp(qts,
> > +                     "{'execute': 'monitor-remove',"
> > +                     " 'arguments': {'id': 'dyn-mon'}}");
> > +    g_assert(qdict_haskey(resp, "return"));
> > +    qobject_unref(resp);
> > +
> > +    /* Error: remove nonexistent */
> > +    resp = qtest_qmp(qts,
> > +                     "{'execute': 'monitor-remove',"
> > +                     " 'arguments': {'id': 'dyn-mon'}}");
> > +    qmp_expect_error_and_unref(resp, "GenericError");
> > +
> > +    /* Error: remove CLI monitor (the default one) -- find its id first.
> > +     * CLI monitors typically have no id, so use a bogus id to test. */
> 
> Please check coding style with scripts/checkpatch.pl - I guess it will
> complain about the multiline comment here.

Thanks, whatever checkpatch.pl raised should now be fixed.

> Apart from that, the patch looks fine to me. But I think either a qtest or
> a functional test should be enough, you don't need both. I'd maybe
> recommend to just keep the qtest, since these tests are often run more
> frequently than the functional tests.

Hm, I did keep both for v2 and I think whoever applies the changes (if
accepted) can just decide which patch to drop so I'm inclined to just
keep it.

