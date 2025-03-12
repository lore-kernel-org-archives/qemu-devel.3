Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56863C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 16:22:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsOpg-0001k2-Rs; Wed, 12 Mar 2025 12:21:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsOpY-0001ih-HJ
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:21:19 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsOpW-0001vm-Er
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 12:21:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=h8osdOuF5WESF5uvKUs76EBYPWbvOr4LPpUWJtUhh6o=; b=eJbBIxHqfWWIp3rxFtJr5ve4ks
 apg9dCpsszwTmSFNWMuD/vTvIZo7NzFbqZEGbYHRliaPwUHQIdMZ9lwusv7r++5g/TppgO5KlETNs
 sZjY+fSVrkKFK4S6PLP9sQ+tAXW74L9V+hvwWbM0kAh+3Pujjus7YMyhwKzVGz/0NedPOGiyJxwzj
 PKJL5I13uaEJL9lEcNXMrQMg80igitgdD1YcyzG0vTYfV1vMz0R1q5xf0I3IkrA8TuCDXIbpFvwkO
 sAwPyOsnVumDZNDDnI7xlxPfWp+tU61wEpX2KTVpq2JgPk6LCf0CDtKxxiE79YRgoaFWCV1l8G9/c
 i8n6lr4WpEyeaihIupk1v7Wc7Q1nAEioq8z01dwSWwUXwslL8zI9qbpsJPwTjZtETJZTQRjRrJzj9
 qQP5yuuynv2yDrpqk9Gae9C0ojv603h44orFY0/f9G9vp9SzMzQV3f7sB83odx4/+5Wup+ts5cu8w
 t8jPkej9ppO6BzryEepaJTJYi3JBCQ9K1n77Rlo+OpRBiUo2zhRsPgmZjwmloEEauzy4pOcN+SOas
 U8ze2cYkVGILHeM+xkIyMKzB79+SXZYZ97Sohr5WCqftn+2wMA/TNCtKe3Xv7vsKhDAi26SB7JqkD
 DHM4CQBbVd84yvaH8dMi4jFwsR3PrBRcLJlwX2REw=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Greg Kurz <groug@kaod.org>, Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH v3 6/6] tests/9p: Test `Tsetattr` can truncate unlinked
 file
Date: Wed, 12 Mar 2025 17:21:08 +0100
Message-ID: <5885890.69HJ7TUJNn@silver>
In-Reply-To: <20250312152933.383967-7-groug@kaod.org>
References: <20250312152933.383967-1-groug@kaod.org>
 <20250312152933.383967-7-groug@kaod.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
Received-SPF: pass client-ip=5.189.157.229;
 envelope-from=qemu_oss@crudebyte.com; helo=kylie.crudebyte.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wednesday, March 12, 2025 4:29:32 PM CET Greg Kurz wrote:
> Enhance the `use-after-unlink` test with a new check for the
> case where the client wants to alter the size of an unlinked
> file for which it still has an active fid.
> 
> Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> 
> v3: - check the size of the truncated file
> ---
>  tests/qtest/virtio-9p-test.c | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index f515a9bb157b..ac38ccf59513 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -736,6 +736,20 @@ static void fs_use_after_unlink(void *obj, void *data,
>          .data = buf
>      }).count;
>      g_assert_cmpint(count, ==, write_count);
> +
> +    /* truncate file to (arbitrarily chosen) size 2001 */
> +    tsetattr({
> +        .client = v9p, .fid = fid_file, .attr = (v9fs_attr) {
> +            .valid = P9_SETATTR_SIZE,
> +            .size = 2001
> +        }
> +     });
> +    /* truncate apparently succeeded, let's double-check the size */
> +    tgetattr({
> +        .client = v9p, .fid = fid_file, .request_mask = P9_GETATTR_BASIC,
> +        .rgetattr.attr = &attr
> +    });
> +    g_assert_cmpint(attr.size, ==, 2001);
>  }
>  
>  static void cleanup_9p_local_driver(void *data)

Ah OK, even better than the suggested stat() call!

Reviewed-by: Christian Schoenebeck <qemu_oss@crudebyte.com>

Thanks!

/Christian



