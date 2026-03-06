Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07E8FF51416
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Mar 2026 14:29:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vyWBE-0007DU-Ic; Fri, 06 Mar 2026 09:29:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyWBD-0007CZ-2b
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:29:27 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1vyWBB-0004tD-Nl
 for qemu-devel@nongnu.org; Fri, 06 Mar 2026 09:29:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772807365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3uePhOIw7V33gcTtcHzAfCvatCscfEm67Ki3tJ5CTXE=;
 b=a46RPpjBOWuvfYPkh3V/UWFHqBfR5ln7n2Q+WC5Kk3YmTm7i0MYoRM5tdxw0rt+6LMWP7a
 dz75lGahUrPh1AnO7+eehSN/1tvejHFKf1LzwERYNBmMfRXqCZf/DF1KB4CAAxyDHqMVtA
 /feGmAXcMusqHTwCU4q1wOo+yquHoAM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-484-OnhERoQbPBSGP2ajjyilDw-1; Fri,
 06 Mar 2026 09:29:22 -0500
X-MC-Unique: OnhERoQbPBSGP2ajjyilDw-1
X-Mimecast-MFC-AGG-ID: OnhERoQbPBSGP2ajjyilDw_1772807361
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0794C18002CF; Fri,  6 Mar 2026 14:29:21 +0000 (UTC)
Received: from redhat.com (unknown [10.45.224.210])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BCE851800673; Fri,  6 Mar 2026 14:29:19 +0000 (UTC)
Date: Fri, 6 Mar 2026 15:29:17 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Hanna Czenczek <hreitz@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org
Subject: Re: [PATCH 1/4] qcow2: Add keep_data_file command-line option
Message-ID: <aarkvZt4Ww4ekTTu@redhat.com>
References: <20250530084448.192369-1-hreitz@redhat.com>
 <20250530084448.192369-2-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250530084448.192369-2-hreitz@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -9
X-Spam_score: -1.0
X-Spam_bar: -
X-Spam_report: (-1.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.411, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.679,
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

Am 30.05.2025 um 10:44 hat Hanna Czenczek geschrieben:
> Add a command-line-only option to prevent overwriting the file specified
> as external data file.
> 
> This option is only available on the qemu-img create command line, not
> via blockdev-create, as it makes no sense there: That interface
> separates file creation and formatting, so where the external data file
> attached to a newly formatted qcow2 node comes from is completely up to
> the user.
> 
> Implementation detail: Enabling this option will not only not overwrite
> the external data file, but also assume it already exists, for two
> reasons:
> - It is simpler than checking whether the file exists, and only skipping
>   creating it when it does not.  It is therefore also less error-prone,
>   i.e. we can never accidentally overwrite an existing file because we
>   made some mistake in checking whether it exists.
> - I think it makes sense from a user's perspective: You set this option
>   when you want to use an existing data file, and you unset it when you
>   want a new one.  Getting an error when you expect to use an existing
>   data file seems to me a nice warning that something is not right.
> 
> Signed-off-by: Hanna Czenczek <hreitz@redhat.com>

> @@ -4004,6 +4029,40 @@ qcow2_co_create_opts(BlockDriver *drv, const char *filename, QemuOpts *opts,
>          goto finish;
>      }
>  
> +    qcow2_opts = &create_options->u.qcow2;
> +
> +    if (!qcow2_opts->has_preallocation) {
> +        qcow2_opts->preallocation = PREALLOC_MODE_OFF;
> +    }
> +    if (!qcow2_opts->has_data_file_raw) {
> +        qcow2_opts->data_file_raw = false;
> +    }

These checks are technically redundant, QAPI already gives us a zeroed
object. At least for the enum, it might still be nice not to rely on the
order. I don't think there's a reason for the bool one, though.

Kevin


