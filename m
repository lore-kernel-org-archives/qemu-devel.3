Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6409FE6BF05
	for <qemu-devel@archiver.kernel.org>; Fri, 30 Jan 2026 11:45:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlmvt-0007L6-Kh; Fri, 30 Jan 2026 06:45:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vlmvq-0007HE-V1
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 06:44:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vlmvp-0002uo-I4
 for qemu-devel@nongnu.org; Fri, 30 Jan 2026 06:44:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769773495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=KuZ9fbh3GbrKgpTd2oDXMqRhbqVpPrkUK8OxuZOh/w8=;
 b=AWwu/rabKDz5LruVdtMVaou8AmN4VD875t5TYDSUGbozXLplMeIE/KWxQNWPqHmLWPDWS9
 bIRDy2hp8QZMbKcYpZdSJ9Lk0WCV893KlZRbH1JWG3A08yPcCrnWHnqsMq8v0UMnqrStvC
 C6UFIqI1aV6eN+H3P8BrILmYqqo40CQ=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-446-EcPTXforPi2v3jBXFe0hmg-1; Fri,
 30 Jan 2026 06:44:52 -0500
X-MC-Unique: EcPTXforPi2v3jBXFe0hmg-1
X-Mimecast-MFC-AGG-ID: EcPTXforPi2v3jBXFe0hmg_1769773491
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA0911956096; Fri, 30 Jan 2026 11:44:50 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.45.242.3])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 756A019560A2; Fri, 30 Jan 2026 11:44:48 +0000 (UTC)
Date: Fri, 30 Jan 2026 12:44:44 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: jasowang@redhat.com, pierrick.bouvier@linaro.org, eblake@redhat.com,
 armbru@redhat.com, devel@lists.libvirt.org, qemu-devel@nongnu.org
Subject: Re: [PATCH] qapi/net: deprecate TAP fd and vhostfd options
Message-ID: <aXyZrBIb77Gh_s7X@angien.pipo.sk>
References: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260129215338.1422004-1-vsementsov@yandex-team.ru>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Fri, Jan 30, 2026 at 00:53:38 +0300, Vladimir Sementsov-Ogievskiy wrote:
> They are the same as fds and vhostfds, except they accept only
> one fd. Let's deprecate redundant options.
> 
> Signed-off-by: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
> ---
> 
> Hi all!
> 
> after "[PATCH v2 00/12] net: refactoring and fixes" options fd
> and vhostfd becomes redundant, fds and vhostfds may be used instead.
> 
> this patch also based on
> "[PATCH v6] qapi: net: deprecate vhostforce option", that's why
> it's sent separately.
> 
> Based-on: <20260129213215.1405459-1-vsementsov@yandex-team.ru>
> Based-on: <20251113071711.349651-1-vsementsov@yandex-team.ru>
> 
>  docs/about/deprecated.rst | 6 ++++++
>  qapi/net.json             | 9 +++++----
>  2 files changed, 11 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index e8ff478583..9010f8ab07 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -451,6 +451,12 @@ TAP ``vhostforce`` (since 11.0)
>  The ``vhostforce`` option is redundant with the ``vhost`` option.
>  If they conflict, ``vhost`` takes precedence.  Just use ``vhost``.
>  
> +TAP ``fd`` and ``vhostfd`` (since 11.0)
> +^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
> +
> +Use ``fds`` and ``vhostfds`` correspondingly, each set with one fd
> +instead of ``fd`` and ``vhsotfd``.

Does this replacement apply/work on all versions supporting vhostfds/fd?

I'm asking because libvirt does have code to format the singlular vs
plural but none of the versions we support are lacking support for the
plural forms so we could replace this unconditionally if it works with
older versions.


