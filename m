Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF171CA5FF5
	for <qemu-devel@archiver.kernel.org>; Mon,  5 Oct 2026 20:37:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xDpQi-0005B9-5i; Mon, 05 Oct 2026 16:37:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDpQc-0005Ag-Ob
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:36:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1xDpQb-0005oO-1B
 for qemu-devel@nongnu.org; Mon, 05 Oct 2026 16:36:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1791232611;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pd1pcPAIWvsRQ9DH7CYewdhFMgjS4V8f+nBM0eZw+K8=;
 b=cRSooISHsKoIHxhB6XjaIJU5Zo7j5bJReYtwgQGdR8GvR0Ra4ZRcc4afGXt5JFDV7gzAUm
 GuPuOZSNL0afkcte+UhI2XLxzywb19us/TCU/WoxgQZM3uadKMjVjOA8NuUOLqLW8oY6Tx
 bxhyVHjOaM3lY8WeKTnpJySXu43SG58=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-505-EHagc05CPoC0AUu3hKKA5Q-1; Mon,
 05 Oct 2026 16:36:48 -0400
X-MC-Unique: EHagc05CPoC0AUu3hKKA5Q-1
X-Mimecast-MFC-AGG-ID: EHagc05CPoC0AUu3hKKA5Q_1791232607
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D62471956067; Mon,  5 Oct 2026 20:36:46 +0000 (UTC)
Received: from redhat.com (headnet05.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.117])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8E35B1800591; Mon,  5 Oct 2026 20:36:44 +0000 (UTC)
Date: Mon, 5 Oct 2026 15:36:41 -0500
From: Eric Blake <eblake@redhat.com>
To: "Denis V. Lunev" <den@openvz.org>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Subject: Re: [PATCH 10/13] qemu-io: add -g to write past the end of the image
Message-ID: <asQJArdFNRiILy_o@redhat.com>
References: <20260930165000.303236-1-den@openvz.org>
 <20260930165000.303236-11-den@openvz.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260930165000.303236-11-den@openvz.org>
User-Agent: NeoMutt/20260616
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 10
X-Spam_score: 1.0
X-Spam_bar: +
X-Spam_report: (1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.24,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Wed, Sep 30, 2026 at 06:49:56PM +0200, Denis V. Lunev wrote:
> From: Denis V. Lunev <den@openvz.org>
> 
> The preallocate filter only does anything for a write that lands beyond
> the end of its file, and that is what a format driver above it produces.
> qemu-io could not produce it at all: the backend rejects such a request
> with EIO, and the write path asserts without the resize permission, so
> the filter could only be reached by stacking a real format on top and
> letting it choose the offsets.
> 
> Take the resize permission and allow writes beyond the end when -g is
> given, which leaves the tool free to address the filter directly.
> 
> Signed-off-by: Denis V. Lunev <den@openvz.org>
> CC: Kevin Wolf <kwolf@redhat.com>
> CC: Hanna Reitz <hreitz@redhat.com>
> CC: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> CC: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  qemu-io.c | 32 +++++++++++++++++++++++++++++---
>  1 file changed, 29 insertions(+), 3 deletions(-)
> 
> diff --git a/qemu-io.c b/qemu-io.c
> index 2b684ccf55..87254b32ff 100644
> --- a/qemu-io.c
> +++ b/qemu-io.c
> @@ -45,6 +45,7 @@ static bool quit_qemu_io;
>  static int ncmdline;

> @@ -149,7 +166,7 @@ static const cmdinfo_t open_cmd = {
>      .argmin     = 1,
>      .argmax     = -1,
>      .flags      = CMD_NOFILE_OK,
> -    .args       = "[-rsCnkU] [-t cache] [-d discard] [-o options] [path]",
> +    .args       = "[-grsCnkU] [-t cache] [-d discard] [-o options] [path]",

No real pattern to how we sort the letters in this help synopsis, so
your choice of sticking -g first is no worse.

> @@ -175,7 +192,7 @@ static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
>      QDict *opts;
>      bool force_share = false;
>  
> -    while ((c = getopt(argc, argv, "snCro:ki:t:d:U")) != -1) {
> +    while ((c = getopt(argc, argv, "gsnCro:ki:t:d:U")) != -1) {
>          switch (c) {
>          case 's':
>              flags |= BDRV_O_SNAPSHOT;
> @@ -228,6 +245,9 @@ static int open_f(BlockBackend *blk, int argc, char **argv, Error **errp)
>          case 'U':
>              force_share = true;
>              break;
> +        case 'g':
> +            write_beyond_eof = true;
> +            break;
>          default:

With a maintainer's hat on, I do find it easier to patch a getopt()
call where the short-option string was in alphabetical order (mixed
case okay) and then the case statements are in the same order. Even if
the option string is NOT in alphabetical order, keeping the case
statements in the same order makes some sense (ie. since you put 'g'
before 's' in the optstring, it should be before 's' in the case
statements).  However, while the maintainance of sticking 'g' at the
end rather than in any particular order is harder, the logic is not
wrong; and shuffling cases is minor enough that whether or not you do
that on a respin, you can add:

Reviewed-by: Eric Blake <eblake@redhat.com>

> @@ -522,6 +544,7 @@ int main(int argc, char **argv)
>          { "object", required_argument, NULL, OPTION_OBJECT },
>          { "image-opts", no_argument, NULL, OPTION_IMAGE_OPTS },
>          { "force-share", no_argument, 0, 'U'},
> +        { "grow", no_argument, NULL, 'g' },

Pre-existing, but since you're touching this, it might be nice to use
NULL in place of 0 on the force-share line.

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


