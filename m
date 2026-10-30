Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C925E606A31A
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Oct 2026 19:36:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gsHZupYI
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xMsND-0000SN-8d; Fri, 30 Oct 2026 15:34:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNB-0000Qd-DM
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:34:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1xMsNA-0007i2-1H
 for qemu-devel@nongnu.org; Fri, 30 Oct 2026 15:34:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1793388883;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=DULR4CCYUV1xN6KTkQmnXD/WpQALqgE4bpbw1Uku33s=;
 b=gsHZupYIEtQCVhBjNsu4kCyhLHti+t4kL2njS2xTRCPPeRuRtafZsqgU6Kel4cBrFivlj0
 NxWtocllysWlOC1u1wDrCmKaLVj2wk0pIBW/WIqhvqM5tvZI+TaEBm0bQAFd4RPR8YUi0K
 4jrrCGTsX0RcGyYrCq+gNTNEsgcpk5k=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-ZJQLZmevNiKuHikQVpllEA-1; Fri,
 30 Oct 2026 15:34:35 -0400
X-MC-Unique: ZJQLZmevNiKuHikQVpllEA-1
X-Mimecast-MFC-AGG-ID: ZJQLZmevNiKuHikQVpllEA_1793388874
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D9486180067D; Fri, 30 Oct 2026 19:34:33 +0000 (UTC)
Received: from localhost (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id B7F871800677; Fri, 30 Oct 2026 19:34:32 +0000 (UTC)
Date: Fri, 30 Oct 2026 15:10:54 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Tim Pambor <timpambor@gmail.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 qemu-block@nongnu.org, Raphael Norwitz <rnorwitz@nvidia.com>,
 Brad Smith <brad@comstyle.com>, vhost-user@lists.linux.dev,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@oss.qualcomm.com>
Subject: Re: [PATCH v2 7/9] vhost-user: enable frontends on any POSIX system
Message-ID: <20261030191054.GA1686233@shajnocz.csb>
References: <20261030-vhost-user-posix-v2-0-cda7c17aad13@gmail.com>
 <20261030-vhost-user-posix-v2-7-cda7c17aad13@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261030-vhost-user-posix-v2-7-cda7c17aad13@gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Fri, Oct 30, 2026 at 12:21:00PM +0100, Tim Pambor wrote:
> The vhost-user protocol is not really Linux-specific so let's enable
> vhost-user frontends for any POSIX system.
> 
> vhost_net.c uses VHOST_FILE_UNBIND, which is defined in a Linux specific
> header. The kernel's VHOST_NET_SET_BACKEND documentation asks to pass
> fd -1 to unbind, so replace the macro with -1 and drop the include,
> nothing else in the file needs it. Long-term a constant could be
> introduced and used for it.
> 
> Co-authored-by: Stefano Garzarella <sgarzare@redhat.com>
> Signed-off-by: Tim Pambor <timpambor@gmail.com>
> ---
> Changes in v2:
> - Replaced VHOST_FILE_UNBIND with -1 and dropped the include
> ---
>  hw/block/Kconfig   | 2 +-
>  hw/net/vhost_net.c | 3 +--
>  meson.build        | 1 -
>  3 files changed, 2 insertions(+), 4 deletions(-)

Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>


