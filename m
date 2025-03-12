Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0EF97C28B28
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Mar 2025 14:12:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tsMoF-0003Wx-Jz; Wed, 12 Mar 2025 10:11:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMoE-0003Wa-29
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:11:46 -0400
Received: from kylie.crudebyte.com ([5.189.157.229])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <qemu_oss@crudebyte.com>)
 id 1tsMoC-0001hF-8o
 for qemu-devel@nongnu.org; Wed, 12 Mar 2025 10:11:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=crudebyte.com; s=kylie; h=Content-Type:Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
 Content-ID:Content-Description;
 bh=uFVwCA3gegZzKCEfrwHsn0CqZZ4qLAERgFFLMd1OhXc=; b=X+wsZ3rrzzDxhU9KPotC+AIyUW
 KAb7Ibc9JOrQI+twNcu13dP+Y1U0e/6JYGAGamOc8+RLKrgNwxR0Ruax33SkbXQOBwuaTOMu/OU/Y
 WbgqSOZ1bzOwXLNeQEJTTd+TylByS9yp7avai0LHwrzzrAiDe0VHViXe1kWYsm1zijZ5xdKWo1pnA
 nEb7W1cBzfSLsvEBI0aviTAviSi62imznxyVOSnTTmJijvTICUvZwM/q3Wqgr////m0kVYFAcsQhz
 ra/I7nKUQ7YvyxV4sm1f+LsMR8Qt07SfTFKZMHjQ6wW1IZhMOGtIVut5KysMigOcLt5xLvYKV+NV8
 D5Uxz+rbNHoFJpAlNR+y3AJq3fDEIqFwtTqHs+PVl2IyuQRoAbzanipvnho6qCjidEd5ewWWietZQ
 yl/AYxIA3fto3LyVWZsuqKxH/JQSAXmM9Ash0i2YjDWiiXsAQn8kVflMyoAv9JQMFAGgnvKdDTa7w
 70VCXQjsVfkx8YaHJYnZjDLZAwCJOPxXhfRW0v0Hn/j1FycZiwaF6oRHiEalgzw70hKPT/bzvPrZA
 2kQrWVs62UAJAq6ngnXzTxMRwXb64bc7SivsQkSSKYJM+9XVph/yqJ6DpmKJ/kf4ZHbBnBVG283yN
 oNJ4WElmqC6oAIWRxsXHhmw933QVC64iDy2X6ur/4=;
From: Christian Schoenebeck <qemu_oss@crudebyte.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Greg Kurz <groug@kaod.org>
Subject: Re: [PATCH v2 6/6] tests/9p: Test `Tsetattr` can truncate unlinked
 file
Date: Wed, 12 Mar 2025 15:11:41 +0100
Message-ID: <4178394.pcGFbxMBL1@silver>
In-Reply-To: <20250311172809.250913-7-groug@kaod.org>
References: <20250311172809.250913-1-groug@kaod.org>
 <20250311172809.250913-7-groug@kaod.org>
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

On Tuesday, March 11, 2025 6:28:09 PM CET Greg Kurz wrote:
> Enhance the `use-after-unlink` test with a new check for the
> case where the client wants to alter the size of an unlinked
> file for which it still has an active fid.
> 
> Suggested-by: Christian Schoenebeck <qemu_oss@crudebyte.com>
> Signed-off-by: Greg Kurz <groug@kaod.org>
> ---
>  tests/qtest/virtio-9p-test.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/tests/qtest/virtio-9p-test.c b/tests/qtest/virtio-9p-test.c
> index f515a9bb157b..20c0d744fa56 100644
> --- a/tests/qtest/virtio-9p-test.c
> +++ b/tests/qtest/virtio-9p-test.c
> @@ -736,6 +736,14 @@ static void fs_use_after_unlink(void *obj, void *data,
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
>  }
>  
>  static void cleanup_9p_local_driver(void *data)
> 

Ah, I just meant the code snippet as a starting point, like I would have also
checked with a stat() call whether 9p server really did what it promised.

But OK, better some test coverage than nothing. :)

/Christian



