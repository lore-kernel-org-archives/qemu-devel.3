Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D1E4C25B74
	for <qemu-devel@archiver.kernel.org>; Mon, 27 May 2024 15:04:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sBbtq-0003rC-9x; Mon, 27 May 2024 11:04:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sBbto-0003fh-8o
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:04:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1sBbtj-00069u-Sf
 for qemu-devel@nongnu.org; Mon, 27 May 2024 11:04:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716822266;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ABVaGG4iNequsNgxbeavvBegUigHzyJDvt6mIzzF1Kg=;
 b=aaxI3OqEiPKor9xdLFLoChrJf6CP/fX8AJqagFKDLGRlywkUOfOkiFqSzQQ1TVISNKv63v
 3+/tcUOHt+027LQYwIuybnd2Vphq4MLHpb27j2G01kAEPQB6/j8h5xAOdOoAg8IIxMDVUa
 WAGOC2Bfphd3hsG+ZDVMprZc7oM7pss=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-418-j5xLQ56nPW-JJFwd5fh91g-1; Mon, 27 May 2024 11:04:24 -0400
X-MC-Unique: j5xLQ56nPW-JJFwd5fh91g-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 42FCB8008A4
 for <qemu-devel@nongnu.org>; Mon, 27 May 2024 15:04:24 +0000 (UTC)
Received: from localhost (unknown [10.22.8.89])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 34324200A381;
 Mon, 27 May 2024 15:04:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Thomas Huth <thuth@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] scripts/update-linux-headers.sh: Remove temporary
 directory inbetween
In-Reply-To: <20240527060243.12647-1-thuth@redhat.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Michael O'Neill, Amy Ross"
References: <20240527060243.12647-1-thuth@redhat.com>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 27 May 2024 17:04:22 +0200
Message-ID: <871q5npa89.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.034,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Mon, May 27 2024, Thomas Huth <thuth@redhat.com> wrote:

> We are reusing the same temporary directory for installing the headers
> of all targets, so there could be stale files here when switching from
> one target to another. Make sure to delete the folder before installing
> a new set of target headers into it.
>
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  scripts/update-linux-headers.sh | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/scripts/update-linux-headers.sh b/scripts/update-linux-headers.sh
> index 8963c39189..fbf7e119bc 100755
> --- a/scripts/update-linux-headers.sh
> +++ b/scripts/update-linux-headers.sh
> @@ -112,6 +112,7 @@ for arch in $ARCHLIST; do
>          arch_var=ARCH
>      fi
>  
> +    rm -rf "$hdrdir"
>      make -C "$linux" O="$blddir" INSTALL_HDR_PATH="$hdrdir" $arch_var=$arch headers_install
>  
>      rm -rf "$output/linux-headers/asm-$arch"

Hm. I presume that headers-install gives us the same set of headers
outside include/asm for every arch?


