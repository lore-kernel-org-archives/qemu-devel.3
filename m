Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16E96C0218A
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Jan 2025 19:31:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tdaFs-0000ru-KI; Thu, 30 Jan 2025 14:31:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaFr-0000rR-Ba
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:31:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1tdaFq-0008K8-1q
 for qemu-devel@nongnu.org; Thu, 30 Jan 2025 14:31:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1738265469;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=u9gUNYN4A5N44oE1nPu1FES7J7FlMQwLb6jW5gFhLNs=;
 b=K8+CziFruxnXs6Ian09r13m50cHDt2Mx+pVtGN/sGDzW8YvVScBFwclU+zOhcacxWlOk8T
 5uydPfa0BJ6lVip4WM/6EXXzXnmM271DNop2ObqKO4ad94fXOn2a+ILosRl6VEoWiaPrpP
 1mjvnbfIx2rfYP5CuqgFcG4Evjowv50=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-D_qm62FiPXKoTVLbJOkhJw-1; Thu,
 30 Jan 2025 14:31:05 -0500
X-MC-Unique: D_qm62FiPXKoTVLbJOkhJw-1
X-Mimecast-MFC-AGG-ID: D_qm62FiPXKoTVLbJOkhJw
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6984D18009B7; Thu, 30 Jan 2025 19:31:03 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.28])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 635981800267; Thu, 30 Jan 2025 19:31:00 +0000 (UTC)
Date: Thu, 30 Jan 2025 13:30:57 -0600
From: Eric Blake <eblake@redhat.com>
To: Kevin Wolf <kwolf@redhat.com>
Cc: qemu-block@nongnu.org, hreitz@redhat.com, stefanha@redhat.com, 
 pkrempa@redhat.com, peterx@redhat.com, farosas@suse.de, qemu-devel@nongnu.org
Subject: Re: [PATCH v2 01/15] block: Add 'active' field to BlockDeviceInfo
Message-ID: <hxwm5u7vxqob4f7e7kjpi3ktp6xk6ljapdsn5fer6ukpdpyoxp@ixbfpdfvguow>
References: <20250130171240.286878-1-kwolf@redhat.com>
 <20250130171240.286878-2-kwolf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250130171240.286878-2-kwolf@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -33
X-Spam_score: -3.4
X-Spam_bar: ---
X-Spam_report: (-3.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.3,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 30, 2025 at 06:12:32PM +0100, Kevin Wolf wrote:
> This allows querying from QMP (and also HMP) whether an image is
> currently active or inactive (in the sense of BDRV_O_INACTIVE).
> 
> Signed-off-by: Kevin Wolf <kwolf@redhat.com>
> ---

> +++ b/block/qapi.c
> @@ -63,6 +63,7 @@ BlockDeviceInfo *bdrv_block_device_info(BlockBackend *blk,
>      info->file                   = g_strdup(bs->filename);
>      info->ro                     = bdrv_is_read_only(bs);
>      info->drv                    = g_strdup(bs->drv->format_name);
> +    info->active                 = !bdrv_is_inactive(bs);

Lots of double-negatives - annoying, but I don't see a way around it,
and I agree with your decision to make the public interface use the
positive (active) rather than the negative (inactive), even though the
negative is the unusual case.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


