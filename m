Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55B74C3DA7F
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Aug 2024 12:05:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sawSk-0000mB-7G; Mon, 05 Aug 2024 08:05:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sawSg-0000VQ-Ne
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:05:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sawSe-0007LJ-DK
 for qemu-devel@nongnu.org; Mon, 05 Aug 2024 08:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722859510;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=k2+03LMEuPaGM16pwn+EMkekWvEJ9+6FEyr5EweSAqY=;
 b=RN7cRobMi/WW9PMiTziBU4lVnPl+x3tMCRpwqmu+jem5AWnhMlltWxsqtKw8UV0veZ0W4M
 Tv12bNbsW0lJE6l1QeQ7/tCWCucjCat62zp+3pJPcPdjTNf/uNbB8JuaJnMWuNJ6+cyQEW
 Yw7qn7RUtTFkGyp44eIjXavxL5vmiAk=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-178-5Z5-sSQ1OIiTooFT60s0Cw-1; Mon,
 05 Aug 2024 08:05:05 -0400
X-MC-Unique: 5Z5-sSQ1OIiTooFT60s0Cw-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 650C519540FC; Mon,  5 Aug 2024 12:05:04 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.224])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C30419560AE; Mon,  5 Aug 2024 12:05:00 +0000 (UTC)
Date: Mon, 5 Aug 2024 14:04:58 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, hreitz@redhat.com,
 vsementsov@yandex-team.ru, pbonzini@redhat.com, eesposit@redhat.com,
 den@virtuozzo.com
Subject: Re: [PATCH v3 2/3] iotests/298: add testcase for async writes with
 preallocation filter
Message-ID: <ZrC_6jb8M6YU1AfQ@redhat.com>
References: <20240716144123.651476-1-andrey.drobyshev@virtuozzo.com>
 <20240716144123.651476-3-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240716144123.651476-3-andrey.drobyshev@virtuozzo.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Am 16.07.2024 um 16:41 hat Andrey Drobyshev geschrieben:
> The testcase simply creates a 64G image with 1M clusters, generates a list
> of 1M aligned offsets and feeds aio_write commands with those offsets to
> qemu-io run with '--aio native --nocache'.  Then we check the data
> written at each of the offsets.  Before the previous commit this could
> result into a race within the preallocation filter which would zeroize
> some clusters after actually writing data to them.
> 
> Note: the test doesn't fail in 100% cases as there's a race involved,
> but the failures are pretty consistent so it should be good enough for
> detecting the problem.
> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>

I left it running in a loop for a while, but couldn't reproduce the bug
with this test.

>  tests/qemu-iotests/298     | 49 ++++++++++++++++++++++++++++++++++++++
>  tests/qemu-iotests/298.out |  4 ++--
>  2 files changed, 51 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/qemu-iotests/298 b/tests/qemu-iotests/298
> index 09c9290711..b7126e9e15 100755
> --- a/tests/qemu-iotests/298
> +++ b/tests/qemu-iotests/298
> @@ -20,8 +20,10 @@
>  
>  import os
>  import iotests
> +import random
>  
>  MiB = 1024 * 1024
> +GiB = MiB * 1024
>  disk = os.path.join(iotests.test_dir, 'disk')
>  overlay = os.path.join(iotests.test_dir, 'overlay')
>  refdisk = os.path.join(iotests.test_dir, 'refdisk')
> @@ -176,5 +178,52 @@ class TestTruncate(iotests.QMPTestCase):
>          self.do_test('off', '150M')
>  
>  
> +class TestPreallocAsyncWrites(iotests.QMPTestCase):
> +    def setUp(self):
> +        # Make sure we get reproducible write patterns on each run
> +        random.seed(42)
> +        iotests.qemu_img_create('-f', iotests.imgfmt, disk, '-o',
> +                                f'cluster_size={MiB},lazy_refcounts=on',
> +                                str(64 * GiB))
> +
> +    def tearDown(self):
> +        os.remove(disk)
> +
> +    def test_prealloc_async_writes(self):
> +        def gen_write_pattern():
> +            n = 0
> +            while True:
> +                yield '-P 0xaa' if n else '-z'
> +                n = 1 - n

This looks like a complicated way to write the following?

    # Alternate between write_zeroes and writing data
    def gen_write_pattern():
        while True:
            yield '-z'
            yield '-P 0xaa'

> +        def gen_read_pattern():
> +            n = 0
> +            while True:
> +                yield '-P 0xaa' if n else '-P 0x00'
> +                n = 1 - n

Same here.

Kevin


