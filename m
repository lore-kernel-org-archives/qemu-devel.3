Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 448FEC54E64
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Mar 2024 09:12:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rplny-0005n1-5V; Thu, 28 Mar 2024 05:12:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rplnw-0005mo-MA
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:12:12 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1rplnu-0002zw-Lg
 for qemu-devel@nongnu.org; Thu, 28 Mar 2024 05:12:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=IejtATrydAzQQ4PM+sijJnYkcCc4eJ72yoIRKR+KryM=; b=bqx+PhPkCcRYNUF/BrCKISnFOL
 HBUvhJS0QiSol31lnYDaiK+Ypt/dFEen3f5PJRRf+cCHZvOOCEfzt0/HDrwRLRwE+1mfzNr0zmeNO
 TbbViRKGvKiifik4hm3kOUXOBGfVTU8sehZC+HmTkvYds5+lLz6tlp0LE0rUyH1moIYqPxDL3Ce9W
 GCOeCxDzNhbGLYXqGonIhwX3HXV1Kz/H2e7rbMctjpa10rHL4VAD64OenVPgDGzrzz7iSGknNggzD
 pc1agEW3mgTcqt/afMdDxSiNun+mcuzOfReSSmLLeXg6czcxAuyejcmOjGa0dLyh4WPjdH/aMT1pp
 nmJNEXjsQYhCQyY4hExZMpa4r4lvMbqm/rxFsgKxt+z1H7lFaw10qfHiNfVu9yz0WFsoZ3Nk0pvZ2
 YKVQAatJJKtYa5dfu06dLaydN1R+v6Nag1/B13yoVb+ky8gyAgBUqWfcgsKJv+UKEB4FcFqWY2LKd
 vqpp75Vc47j9DLlXZrEypRYiR51bRXKviaHgK0yhDu6xblckcZ4xwcXdQQpZWu1wAhu0T3fwL6cbI
 veSkkKdMOD5YUlNXWq2Qmi1ltiVa+Nck7PhAEzglX5O/MPM+dPlwPRIU4SUOwk98TNQaptxeb1cKR
 Vj1gEq9NKqnQQVahUefCPbkfBOq7m2GUAuaj6LDy0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: thuth@redhat.com, alistair.francis@wdc.com, groug@kaod.org,
 peter.maydell@linaro.org, Daniel Henrique Barboza <dbarboza@ventanamicro.com>
Subject: Re: [PATCH for-9.0 v3 0/2] qtest/virtio-9p-test.c: fix slow tests
Date: Thu, 28 Mar 2024 10:12:06 +0100
Message-ID: <2268533.olLYQ3gCYy@silver>
In-Reply-To: <20240327142011.805728-1-dbarboza@ventanamicro.com>
References: <20240327142011.805728-1-dbarboza@ventanamicro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wednesday, March 27, 2024 3:20:09 PM CET Daniel Henrique Barboza wrote:
> Hi,
> 
> In this new version we took a different approach after the discussions
> we had in [1]. The tests are now untouched, and we're addressing the root
> cause directly: the fact that we have a single temp dir for all the test
> execution in qos-test.
> 
> We're now creating and cleaning temp dirs for each individual test by
> calling virtio_9p_create_local_test_dir() in the .before callback for
> the local 9p tests (assign_9p_local_driver()). In this same callback we
> queue the cleanup function that will erase the created temp dir. The
> cleanup will run after the test ran successfully.
> 
> This approach is similar to what other qtests do (in fact this design was
> taken from vhost-user-test.c) so it's not like we're doing something
> novel.
> 
> I kept the revert of the slow test gate because Gitlab seems to approve
> it:
> 
> https://gitlab.com/danielhb/qemu/-/pipelines/1229836634
> 
> Feel free to take just patch 1 if we're not sure about re-enabling these
> tests in Gitlab.
> 
> 
> Changes from v3:
> - patches 1 to 6: dropped
> - patch 1 (new):
>   - create and remove temporary dirs on each test
> - v2 link: https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06335.html
> 
> [1] https://mail.gnu.org/archive/html/qemu-devel/2024-03/msg06400.html
> 
> Daniel Henrique Barboza (2):
>   qtest/virtio-9p-test.c: create/remove temp dirs after each test
>   qtest/virtio-9p-test.c: remove g_test_slow() gate
> 
>  tests/qtest/virtio-9p-test.c | 32 +++++++++++---------------------
>  1 file changed, 11 insertions(+), 21 deletions(-)

Queued on 9p.next:
https://github.com/cschoenebeck/qemu/commits/9p.next

Thanks!

/Christian



