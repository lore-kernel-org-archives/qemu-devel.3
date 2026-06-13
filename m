Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70798CD98C5
	for <qemu-devel@archiver.kernel.org>; Sat, 13 Jun 2026 15:01:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYPr3-0004KG-If; Sat, 13 Jun 2026 11:01:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wYPqv-0004Jk-Fe; Sat, 13 Jun 2026 11:00:55 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1wYPqu-0003aY-0E; Sat, 13 Jun 2026 11:00:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=kwfuhHRIyDC2/Z2oBgWBujV6HcY1lWrA9Z8m1l/bPfY=; b=vti6gSqiALK/X7OJZoRmJLSwLg
 AVguw7XLw/E+SdRropRZcwZEFNKHkvAxmyx2sv1RZjRLqmgMz+c4xkTiT9HcpCbzhT9pIIf4gGjfm
 lStZRN1GUyP2t6LIfXYzDjegGsY5vqQ0F8z5fXD3hzAHhnZVEQJEDeCyzbF3qcDf2pfnwo/9NG6dk
 3v+fmeNKQBqWCOTJmB5mEW6dcbRwi17RRVgg+qEQ08AgOA75m/5dZQ1hT0NjfO4Sd8D+VzIFl0k8T
 Tp4QVB1FGaTp1MWPWArcJIajTGmllRcQvR7VYQXvi3W1AY+yLI7H5iqKLkpe9VyTISn/5pPZhuiAK
 nkCLcY7hG0ck1P/HOjCwq4sTjhcsgTNpI0UeusrFXw+GF4IVk+7FqA6KNt/guiIo137uGhZpxhMNb
 uqLv6lEJ3FL+sASP7hWdSJHWfcvgdbCOjTajlmblPxUW3gzFm/2GQPMqru8Cufnn+VbWbhkyVYOEe
 G/+kh5fZLufHJ/seCDQFIkfUXCSy19v806lpU5DkMZb3YiSeIQFo86SRHl1srkIGPv5nqB37SYIn5
 ZLA9sSv1XQfOienyRId41oFSf16e7wf1CqbLtRRkOKuMeT5Bq+4lghjRfMaaIPcjbYrj1cw6eAysO
 ypouzeSy84ZIx5kTSpzkOhrVB9rIg+YhgdKPicfg0=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org, qemu-stable@nongnu.org
Cc: Greg Kurz <groug@kaod.org>, Feifan Qian <bea1e@proton.me>
Subject: Re: [PATCH v2 12/12] tests/9p: add 3 xattr FID limit test cases
 (local fs driver)
Date: Sat, 13 Jun 2026 17:00:47 +0200
Message-ID: <5107356.31r3eYUQgx@weasel>
In-Reply-To: <cf4466391ba7822cef445f4bdb62498230c73d07.1781012549.git.qemu_oss@crudebyte.com>
References: <cover.1781012549.git.qemu_oss@crudebyte.com>
 <cf4466391ba7822cef445f4bdb62498230c73d07.1781012549.git.qemu_oss@crudebyte.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="utf-8"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tuesday, 9 June 2026 15:47:06 CEST Christian Schoenebeck wrote:
> Analogue to the previously added 3 synth tests, add (similar) 3 test
> cases using the "local" fs driver to verify correct xattr FID limit
> enforcement of 9pfs server with a real filesystem.
> 
> These 3 new local tests use the shared test code of the previously
> added 3 synth tests. The only difference is that the local fs driver
> does not expose the current internal xattr FID counter, so we can't
> verify this with the local tests.
> 
> Signed-off-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> ---
>  tests/qtest/virtio-9p-test.c | 69 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 66 insertions(+), 3 deletions(-)
[...]
> -static void *assign_9p_local_driver(GString *cmd_line, void *arg)
> +static void assign_9p_local_driver_with_args(GString *cmd_line,
> +                                             const char *extra_opts)
>  {
>      /* make sure test dir for the 'local' tests exists */
>      virtio_9p_create_local_test_dir();
> 
> -    virtio_9p_assign_local_driver(cmd_line, "security_model=mapped-xattr");
> +    g_autofree char *opts = g_strdup("security_model=mapped-xattr");
> +    if (extra_opts) {
> +        opts = g_strdup_printf("%s,%s", opts, extra_opts);
> +    }

That's a leak. I'll change it to:

    g_autofree char *opts =
        (extra_opts) ?
            g_strdup_printf("security_model=mapped-xattr,%s", extra_opts) :
            g_strdup("security_model=mapped-xattr");

And while I am at it, I'll also fix some more typos in the commit logs.

/Christian



