Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B36DCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:49:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWbHk-0006m5-FU; Mon, 08 Jun 2026 10:49:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWbHJ-0006Wa-EM
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:48:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wWbHH-00055P-J1
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780930114;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=GYEaOEnVygtlFeRLbvCP5EiEYwlr1ShSg6WtKbZF1cU=;
 b=Ulvgs/+r/0cWynM6k1J3IPDKslI2Nlk2NxQkxDX5RRLECmrF2d7iJcBH2MPYVPGhJaQOrL
 ooFh5PWLtMYnVvyM9axGurdcAMMdki3IfztZlchk4oxLQA9xXvTgx5MeOGZHiZdtYVdXRC
 cDquJdN6hZyWm/Zpl8htRHEQ8Irkr8E=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-629-LjlPKQNAPk6hyawUrwVMoQ-1; Mon,
 08 Jun 2026 10:48:26 -0400
X-MC-Unique: LjlPKQNAPk6hyawUrwVMoQ-1
X-Mimecast-MFC-AGG-ID: LjlPKQNAPk6hyawUrwVMoQ_1780930105
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3C202195605E; Mon,  8 Jun 2026 14:48:25 +0000 (UTC)
Received: from redhat.com (unknown [10.44.49.219])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CD10919541B0; Mon,  8 Jun 2026 14:48:22 +0000 (UTC)
Date: Mon, 8 Jun 2026 15:48:19 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 qemu-devel <qemu-devel@nongnu.org>, Eric Blake <eblake@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, qemu block <qemu-block@nongnu.org>
Subject: Re: Race condition in qemu-iotests nbd 205?
Message-ID: <aibWM_LYrgnBYQQg@redhat.com>
References: <CAJSP0QU6Ko87bYaaNm6DCB7krVZgbo_YohuVKSAunBpnDJFdHA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAJSP0QU6Ko87bYaaNm6DCB7krVZgbo_YohuVKSAunBpnDJFdHA@mail.gmail.com>
User-Agent: Mutt/2.3.2 (2026-04-26)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jun 08, 2026 at 10:23:18AM -0400, Stefan Hajnoczi wrote:
> Hi Vladimir,
> It looks like there is a race condition in qemu-iotests 205 when the
> NBD server is shutting down:
> 
> +FAIL: test_remove_during_connect_safe_hard (__main__.TestNbdServerRemove)
> +----------------------------------------------------------------------
> +Traceback (most recent call last):
> + File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 149,
> in test_remove_during_connect_safe_hard
> + self.assertExportNotFound('exp')
> + File "/builds/qemu-project/qemu/tests/qemu-iotests/205", line 63, in
> assertExportNotFound
> + self.assert_qmp(result, 'error/desc', "Export 'exp' is not found")
> + File "/builds/qemu-project/qemu/tests/qemu-iotests/iotests.py", line
> 1246, in assert_qmp
> + self.assertEqual(result, value,
> +AssertionError: "Export 'exp' is already shutting down" != "Export
> 'exp' is not found"
> +- Export 'exp' is already shutting down
> ++ Export 'exp' is not found
> + : "error/desc" is "Export 'exp' is already shutting down", expected
> "Export 'exp' is not found"
> 
> https://gitlab.com/qemu-project/qemu/-/jobs/14745043965#L328
> 
> I have not seen this CI failure before, so it might be rare and hard
> to reproduce.

FYi, If you don't have time to investigate & fix it quickly, just
file a gitlab bug and then annotate the test cases / clases with:

 @iotests.skip_flaky("https://gitlab.com/qemu-project/qemu/-/work_items/NNN")

which will make the test be skipped in CI / locally, until someone
has time to look at it.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


