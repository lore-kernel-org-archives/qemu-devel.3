Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE466C25B75
	for <qemu-devel@archiver.kernel.org>; Fri, 31 May 2024 14:37:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sD3Mx-00008m-4a; Fri, 31 May 2024 10:36:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD3Mt-000074-Jy
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sD3Mr-0007h9-Dh
 for qemu-devel@nongnu.org; Fri, 31 May 2024 10:36:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1717166188;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lK/o7FUytkbjpLMyWIexWj5DGTTRuN3JwnZKzdPg1iY=;
 b=JsAXFj/5/vPjCgXnoiSxms5KmmN0DpO+v9GSDE+xH9bSaQgpDcoYmtvgwrdyutCWobimDq
 PgkpMxe6aBTYIEH+JMnoIXevRZWUtyPZIDtvcEbnPvpUMAm7Z7U9yNvyhNotN7lztt8g9L
 nQBfSAlHrqPNRVQSa5SaArCg8kcOf1Q=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-k-3LLhrIPBW4RT7kdVil5w-1; Fri,
 31 May 2024 10:36:23 -0400
X-MC-Unique: k-3LLhrIPBW4RT7kdVil5w-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 2E5541C0512F;
 Fri, 31 May 2024 14:36:23 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.235])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 8F858401405;
 Fri, 31 May 2024 14:36:21 +0000 (UTC)
Date: Fri, 31 May 2024 16:36:20 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, stefanha@redhat.com,
 berrange@redhat.com, qemu-stable@nongnu.org,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Hanna Reitz <hreitz@redhat.com>
Subject: Re: [PATCH v2 2/2] iotests: test NBD+TLS+iothread
Message-ID: <ZlngZP-wAfRSE7rL@redhat.com>
References: <20240518025246.791593-4-eblake@redhat.com>
 <20240518025246.791593-6-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240518025246.791593-6-eblake@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.085,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

Am 18.05.2024 um 04:50 hat Eric Blake geschrieben:
> Prevent regressions when using NBD with TLS in the presence of
> iothreads, adding coverage the fix to qio channels made in the
> previous patch.
> 
> CC: qemu-stable@nongnu.org
> Signed-off-by: Eric Blake <eblake@redhat.com>

> diff --git a/tests/qemu-iotests/tests/nbd-tls-iothread.out b/tests/qemu-iotests/tests/nbd-tls-iothread.out
> new file mode 100644
> index 00000000000..b5e12dcbe7a
> --- /dev/null
> +++ b/tests/qemu-iotests/tests/nbd-tls-iothread.out
> @@ -0,0 +1,54 @@
> +QA output created by nbd-tls-iothread
> +
> +== preparing TLS creds and spare port ==
> +picked unused port
> +Generating a self signed certificate...
> +Generating a signed certificate...
> +Generating a signed certificate...
> +
> +== preparing image ==
> +Formatting 'TEST_DIR/t.IMGFMT', fmt=IMGFMT size=1073741824
> +Formatting '/home/eblake/qemu/build/tests/qemu-iotests/scratch/qcow2-file-nbd-tls-iothread/dst.qcow2', fmt=qcow2 cluster_size=65536 extended_l2=off compression_type=zlib size=1073741824 lazy_refcounts=off refcount_bits=16

/home/eblake is suboptimal in reference output. :-)

Kevin


