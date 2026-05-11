Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 520E4CD37AC
	for <qemu-devel@archiver.kernel.org>; Mon, 11 May 2026 11:43:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wMP2P-0005iz-DL; Mon, 11 May 2026 07:43:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMP2O-0005ir-GZ
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:43:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wMP2M-0006r6-Np
 for qemu-devel@nongnu.org; Mon, 11 May 2026 07:43:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778499781;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qX2tnJJNfV+osYZkXLO1DQa3mQgqX53HdEaTv1PbSD8=;
 b=LvEjb6DhcpWRerrWYWveWOhaON0DWCGqEXEp9+MoOqUVbGY1eqJDhIyIHfx03LYCx0M39j
 Sb+8r5sSEF23ziSSzZMTAhO+Pj7ZBcBeaQBpOnWhIKD+szTre2N6CyYbxLcxd5vvu+/YT9
 Za+sztqpoeTbG/h8bWyiaARaOUeJW04=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-413-8spRRmbEMF2wdhEt9Bshrg-1; Mon, 11 May 2026 07:43:00 -0400
X-MC-Unique: 8spRRmbEMF2wdhEt9Bshrg-1
X-Mimecast-MFC-AGG-ID: 8spRRmbEMF2wdhEt9Bshrg_1778499779
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a2c034fso4019736f8f.3
 for <qemu-devel@nongnu.org>; Mon, 11 May 2026 04:42:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778499779; x=1779104579; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=qX2tnJJNfV+osYZkXLO1DQa3mQgqX53HdEaTv1PbSD8=;
 b=PBjNqZzgJRY4VK4rciYq6sQYdSsw/m94shE9XuxTCPpp6Xykr8pPoxBMIT8982/Ju5
 OMwc0tCyPJkGGn3czNbgtlXWFGmfYhf39w0WGwCYl6oJ39uO/NP6BVG28mEw/0WQq18k
 +cSpcX0/tWiJgeMdzefqnLULeR5kQ102NBVLKzyYM3j7UP9jaIwceNcelnL09Y1ZgORV
 FCg6pQlC317IEyZlnSlrPAJHq7IYVfvnzjG9hrBILClmUZgg7tRN7Kt3wezXFSSxzYw3
 E03Bbd+suH2Xo9r5ZDX4MvNOKt2Rx7eW7OJbeNjxwwF/LOk3ry27NBhlf8CG1gUmVbzE
 otNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778499779; x=1779104579;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qX2tnJJNfV+osYZkXLO1DQa3mQgqX53HdEaTv1PbSD8=;
 b=fR1i+SXvC5ccXQY+G4NJ4X9x1oqPlBAnNLHaAKbit/kvULiSUYvi7eI70lYpvPSk5C
 CHpuKAwv6kp0ZH6H1r7utlmdw0bSo5UeogJY33omGXugPrkY5HmbZcn+MckUKQz/SwuD
 crQhu/3JX3uCGYYI2To15VY6sLFvFE96zZyd35ik1gD/Q7Uvv7Od/kqCWHhloVBOg4vA
 A/DfGBfPlhg/hMLJEU13rCJ62R6Y+sXSGVIivblHJvcW7thlYxot+tC8/OqHjXZs6Z0X
 DAbr7Hn1Q6VbcvU+saShOrBFC7MkpNAGAT4pSA6N4PYIP5PMGMxFFPlQ5oC9phX9f4c8
 s2uA==
X-Gm-Message-State: AOJu0YzdDO66ormWfzW/kasMy+be1RWlm9tPRyQ497ITfr+oWsUBThr/
 qh5h0Pt8gE1RdjQp7/GEqwWz95xCBRtGzMMMloucFa3YWDcyxGJNs8X6vqflhooMhhW00KzxVUg
 4mV3jiFMT2P/Hv2sMkM9K5RoYHS3cmB0yNBTbI8CPjwk5SxOIeWdClVHg
X-Gm-Gg: Acq92OFL+z3BqPxciuCDzIJaOFBKliPUYOAeJZxHFal7KTx3xpw4XmQemMSakd6ILf9
 rNBnHRGm4Xga8P4EbVZpJApqfzb3Eknt71MWl6KNbB0qdZYghclOjsWxdYJTXrw899drCnxkIv1
 u8oPGpAcutqynT6JHz1/NfWoWI3PdmPi4UEv13+pQUu5ye7MIVNIdoRHcHHzoqD87DAKC8wA74W
 e6UE0KsmK0+Qb6dYs223AMJ0Vb6Vyd6LOh/9o5fbHtdVqbNftLvbiaXHJ1UQPbDPH/5KaQzIhgQ
 j/2q5FF18u4xtnaLnIW2b+Hyeja44mJiU3ARaUgJNTt2tx3a1bjJLUCvrEpxN8pgtFZcOXooiSZ
 PiFKaGxXAQ9A62OCku9sD0o5EnLpo/+TMNK137ymX
X-Received: by 2002:a5d:5c84:0:b0:43f:e721:76bf with SMTP id
 ffacd0b85a97d-4515df66f27mr34964029f8f.41.1778499778932; 
 Mon, 11 May 2026 04:42:58 -0700 (PDT)
X-Received: by 2002:a5d:5c84:0:b0:43f:e721:76bf with SMTP id
 ffacd0b85a97d-4515df66f27mr34963960f8f.41.1778499778239; 
 Mon, 11 May 2026 04:42:58 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-48-7.inter.net.il. [80.230.48.7])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4548e6a66bfsm22030189f8f.4.2026.05.11.04.42.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 11 May 2026 04:42:57 -0700 (PDT)
Date: Mon, 11 May 2026 07:42:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@redhat.com>
Cc: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Cornelia Huck <cohuck@redhat.com>, Song Gao <gaosong@loongson.cn>,
 Avihai Horon <avihaih@nvidia.com>
Subject: Re: [PATCH] update-linux-headers: Inject VIRTIO_RING_NO_LEGACY in
 virtio_ring.h
Message-ID: <20260511074232-mutt-send-email-mst@kernel.org>
References: <20260511111913.3327672-1-clg@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260511111913.3327672-1-clg@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, May 11, 2026 at 01:19:13PM +0200, Cédric Le Goater wrote:
> The kernel commit 3c4629b68dbe ("virtio: uapi: avoid usage of libc
> types") changed the virtio_ring.h header and this breaks the build on
> Windows which requires the uintptr_t type to cast from pointer to
> integer.
> 
> Inject '#define VIRTIO_RING_NO_LEGACY' at the top of the synced header
> via the update script after the include guard. This discards the code
> section incompatible with Windows.
> 
> Signed-off-by: Cédric Le Goater <clg@redhat.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  scripts/update-linux-headers.sh | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index da367acee790657e33c71c10bc118b085774f45d..3c3a0e9394d277766e613dd5ef4e9c7407ec0033 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -104,6 +104,7 @@ cp_portable() {
>          -e 's/__kernel_ulong_t/unsigned long/' \
>          -e 's/struct ethhdr/struct eth_header/' \
>          -e '/\#define _LINUX_ETHTOOL_H/a \\n\#include "net/eth.h"' \
> +        -e '/\#define _LINUX_VIRTIO_RING_H/a \\n\#define VIRTIO_RING_NO_LEGACY' \
>          "$f" > "$to/$header";
>  }
>  
> -- 
> 2.54.0


