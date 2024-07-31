Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D72FC3DA64
	for <qemu-devel@archiver.kernel.org>; Wed, 31 Jul 2024 15:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZB11-0001DJ-RO; Wed, 31 Jul 2024 11:13:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZB0u-0001Bz-Rd
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:13:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sZB0t-0004an-CF
 for qemu-devel@nongnu.org; Wed, 31 Jul 2024 11:13:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722438794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fza9ukk+4QNe4cQe2uSJ2CS6APdAnsMbz6PF4zAPWIk=;
 b=PS4zvIHOvDYSphrvtf0aUjvvGgNXcuHgdo2cN1XBrpLjdW7TQvMye+xcfqHAIjSaVUGlYI
 FLo1EzxvQZj0d010DuJPFOQdlky1AKijppvjg8hQdbdeUmWpcnZjOCZERUf/BD3ueip1k3
 kdZSK/zCkipHiVfd1jUd8mfqr7fC3Mo=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-544-kwoQeM7bMyCDGkoKrvSriw-1; Wed,
 31 Jul 2024 11:13:11 -0400
X-MC-Unique: kwoQeM7bMyCDGkoKrvSriw-1
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7C29B1944B2E; Wed, 31 Jul 2024 15:13:10 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.1])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 33FBA300018D; Wed, 31 Jul 2024 15:13:07 +0000 (UTC)
Date: Wed, 31 Jul 2024 17:13:05 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 John Snow <jsnow@redhat.com>, Stefan Weil <sw@weilnetz.de>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Subject: Re: [PATCH 6/7] hw/ide/pci.c: Remove dead code from
 bmdma_prepare_buf()
Message-ID: <ZqpUgb1Y74-N9q0_@redhat.com>
References: <20240731143617.3391947-1-peter.maydell@linaro.org>
 <20240731143617.3391947-7-peter.maydell@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240731143617.3391947-7-peter.maydell@linaro.org>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 31.07.2024 um 16:36 hat Peter Maydell geschrieben:
> Coverity notes that the code at the end of the loop in
> bmdma_prepare_buf() is unreachable.  This is because in commit
> 9fbf0fa81fca8f527 ("ide: remove hardcoded 2GiB transactional limit")
> we removed the only codepath in the loop which could "break" out of
> it, but didn't notice that this meant we should also remove the code
> at the end of the loop.
> 
> Remove the dead code.
> 
> Resolves: Coverity CID 1547772
> Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
> ---
>  hw/ide/pci.c | 4 ----
>  1 file changed, 4 deletions(-)
> 
> diff --git a/hw/ide/pci.c b/hw/ide/pci.c
> index 4675d079a17..f2cb500a94f 100644
> --- a/hw/ide/pci.c
> +++ b/hw/ide/pci.c
> @@ -266,10 +266,6 @@ static int32_t bmdma_prepare_buf(const IDEDMA *dma, int32_t limit)
>              s->io_buffer_size += l;
>          }
>      }
> -
> -    qemu_sglist_destroy(&s->sg);
> -    s->io_buffer_size = 0;
> -    return -1;
>  }

Should we put a g_assert_not_reached() here instead to make it easier
for the reader to understand how this function works?

Either way:
Reviewed-by: Kevin Wolf <kwolf@redhat.com>


