Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F60AC47258
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 20:45:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rT6a1-0000NQ-7C; Thu, 25 Jan 2024 15:44:09 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rT6Zx-0000Lz-Cn
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:44:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1rT6Zv-0004WM-B4
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 15:44:05 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1706215442;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=G1xIOV3YjfMzypUK6KC2WVscvnQli3PXHVEPD6mn6NQ=;
 b=eSLxLTiCnUOakegRj9oJMHCHWJvSS40boJnnjwwpZRp2xpkyBfXcKYZhJoPBbgCB2r7dVd
 f/r2xKflEWry1GgZGWQclgU2vcqybLRPZsOll7O8JLLRpbfFGRaJTy+vLjNdqNmqou2QYV
 W5n1iosiUKxt5XEd06q+iX+3gem6IDw=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-180-KeBG55pqPX-s3WW0Oc5OZw-1; Thu,
 25 Jan 2024 15:43:58 -0500
X-MC-Unique: KeBG55pqPX-s3WW0Oc5OZw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 60A941C05154;
 Thu, 25 Jan 2024 20:43:58 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.221])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 5721E1C060AF;
 Thu, 25 Jan 2024 20:43:57 +0000 (UTC)
Date: Thu, 25 Jan 2024 14:43:55 -0600
From: Eric Blake <eblake@redhat.com>
To: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, kwolf@redhat.com, 
 hreitz@redhat.com, den@virtuozzo.com
Subject: Re: [PATCH] iotests: don't run tests requiring cached writes in
 '-nocache' mode
Message-ID: <wc2tis5uqy6heofjugtbf4dvzyrhu7bquctickkmpnawze6nyq@i63be6bq7zby>
References: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20231211133223.695048-1-andrey.drobyshev@virtuozzo.com>
User-Agent: NeoMutt/20231221
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.5,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Dec 11, 2023 at 03:32:23PM +0200, Andrey Drobyshev wrote:
> There're tests whose logic implies running without O_DIRECT set,
> otherwise they fail when running iotests in '-nocache' mode.  For these
> tests let's add _require_no_o_direct() helper which can be put in the
> preabmle and which makes sure '-nocache' isn't set.  Use it to skip

preamble

> running the following tests:
> 
>   * 271: creates files with unaligned sizes, thus producing multiple
>     errors like:
> 
> qemu-io: can't open device /path/to/t.qcow2.raw: Cannot get 'write'
> permission without 'resize': Image size is not a multiple of request alignment

I wonder if we can instead tweak the test to use larger sizes such
that all accesses ARE aligned even with O_DIRECT.

/me goes and reads the test...

    # Note that the image size is not a multiple of the cluster size
    _reset_img 2083k

Ah - we really DO have a test that depends on odd sizing; where
changing it to be more nicely aligned will break other assumptions in
the test.

> 
>   * 308, file-io-error: use fuse exports.  Though fuse does have
>     'direct-io' mode (see https://docs.kernel.org/filesystems/fuse-io.html)
>     we aren't using it yet, thus getting errors like:
> 
> qemu-io: can't open device /path/to/t.qcow2.fuse: Could not open
> '/path/to/t.qcow2.fuse': filesystem does not support O_DIRECT

And I agree that this one is beyond our control, so adding skip
support makes sense.

> 
> Signed-off-by: Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>
> ---
>  tests/qemu-iotests/271                 | 1 +
>  tests/qemu-iotests/308                 | 2 ++
>  tests/qemu-iotests/common.rc           | 7 +++++++
>  tests/qemu-iotests/tests/file-io-error | 1 +
>  4 files changed, 11 insertions(+)

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


