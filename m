Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53A08FD2D90
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Mar 2026 13:42:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzxLN-0006ct-1f; Tue, 10 Mar 2026 09:41:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzxLA-0006bK-TB
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:41:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vzxL8-00037v-1P
 for qemu-devel@nongnu.org; Tue, 10 Mar 2026 09:41:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773150097;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=st7Laohye1aRwT0IsQFt3PFTD/zMetc/rY1yaSDLilI=;
 b=c69iQ9m2oH/OJJ7y23gBR2cFDC5pf2hCcCX6+BoMDwvHJ35Exq24iP344yDylVcdI8fG8K
 ecyNIiRE4fnUvTMDKY8n7ufjtEdd3WjA6eeMpa6z1BlWbGBSZ6W6PxYtGki31ndjqiSqEn
 3f5VNrZX7SxsHzEYb0PE6jYG/Wr5f5U=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-417-UQU2qtucMYa3rcJwAJ2dvw-1; Tue,
 10 Mar 2026 09:41:34 -0400
X-MC-Unique: UQU2qtucMYa3rcJwAJ2dvw-1
X-Mimecast-MFC-AGG-ID: UQU2qtucMYa3rcJwAJ2dvw_1773150093
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 67C791808958; Tue, 10 Mar 2026 13:41:27 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.112])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C995C19560A6; Tue, 10 Mar 2026 13:41:23 +0000 (UTC)
Date: Tue, 10 Mar 2026 14:41:21 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Peter Lieven <pl@dlhnet.de>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, pbonzini@redhat.com,
 hreitz@redhat.com, marcandre.lureau@redhat.com, berrange@redhat.com,
 philmd@linaro.org, armbru@redhat.com, jsnow@redhat.com,
 thuth@redhat.com, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: Re: [PATCH] block/nfs: add support for libnfs v6
Message-ID: <abAfgVCdcP66IrGk@redhat.com>
References: <20260306142840.72923-1-pl@dlhnet.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260306142840.72923-1-pl@dlhnet.de>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

Am 06.03.2026 um 15:28 hat Peter Lieven geschrieben:
> libnfs v6 added a new api structure for read and write requests.
> 
> This effectively also adds zero copy read support for cases where
> the qiov coming from the block layer has only one vector.
> 
> The .brdv_refresh_limits implementation is needed because libnfs v6
> silently dropped support for splitting large read/write request into
> chunks.
> 
> Signed-off-by: Ronnie Sahlberg <ronniesahlberg@gmail.com>
> Signed-off-by: Peter Lieven <pl@dlhnet.de>

Thanks, applied to the block branch.

> @@ -280,6 +307,13 @@ static int coroutine_fn nfs_co_preadv(BlockDriverState *bs, int64_t offset,
>      }
>      qemu_coroutine_yield();
>  
> +    if (my_buffer) {
> +        if (task.ret > 0) {
> +            qemu_iovec_from_buf(iov, 0, buf, task.ret);
> +        }
> +        g_free(buf);
> +    }

I wonder if it wouldn't be easier to just always do the copy in the
callback. The only thing that would need to be version dependent is the
buffer that contains the actual data (the @data parameter in
nfs_co_generic_cb or the bounce buffer).

But I assume we'll touch this code again soon enough, because I saw that
libnfs recently added vectored reads. If we can use them, that would be
even more efficient. (But somehow it didn't add vectored writes at the
same time? Strange.)

Kevin


