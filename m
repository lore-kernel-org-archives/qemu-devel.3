Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCD19CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 15 Oct 2025 18:32:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v96HP-0003uR-PZ; Wed, 15 Oct 2025 14:31:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v96HN-0003tZ-Bs
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:31:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1v96HF-0002XE-Id
 for qemu-devel@nongnu.org; Wed, 15 Oct 2025 14:31:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760553064;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GEg/THBD/5BWgHAsENtq7+iCn1fbwBsrBkE3aDTTNDU=;
 b=MKJ9zU3xdWNlK8A6NOZoUEVRYkpdMZ/R0zqX6EJbKerzLMZQT3AZ7zTTcegvaTSvx8Uskl
 lHHdlJU5aZ2kwWQYVA0nZCvdZr3eHho4OxIuqd3gL/8S+sLRRaJE+lz/qxQW6ouDNBJfzi
 1cjqGZs3NxLlLORdKrrhLi8RBtwWDy4=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-554-XlWG_w9gNomSUoqguT8oDg-1; Wed,
 15 Oct 2025 14:31:02 -0400
X-MC-Unique: XlWG_w9gNomSUoqguT8oDg-1
X-Mimecast-MFC-AGG-ID: XlWG_w9gNomSUoqguT8oDg_1760553062
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5A741956080
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 18:31:01 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.144])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D6DBD30001A1
 for <qemu-devel@nongnu.org>; Wed, 15 Oct 2025 18:31:00 +0000 (UTC)
Date: Wed, 15 Oct 2025 13:30:58 -0500
From: Eric Blake <eblake@redhat.com>
To: qemu-devel@nongnu.org
Subject: Re: [PATCH v3 0/2] reject qcow2 creation with protocol in data_store
Message-ID: <45553n3xrdjqcphm3jacej4tvtod4i72hek6xuz7vmhcfxfkae@uqqt3rwggzgw>
References: <20250915213919.3121401-4-eblake@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250915213919.3121401-4-eblake@redhat.com>
User-Agent: NeoMutt/20250905
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Sep 15, 2025 at 04:37:25PM -0500, Eric Blake wrote:
> v2 was here:
> https://lists.gnu.org/archive/html/qemu-devel/2025-05/msg06231.html
> Since then:
>  - rebase to latest tree
> 
> Eric Blake (2):
>   block: Allow drivers to control protocol prefix at creation
>   qcow2, vmdk: Restrict creation with secondary file using protocol

Ping

> 
>  include/block/block-global-state.h | 3 ++-
>  block.c                            | 4 ++--
>  block/crypto.c                     | 2 +-
>  block/parallels.c                  | 2 +-
>  block/qcow.c                       | 2 +-
>  block/qcow2.c                      | 4 ++--
>  block/qed.c                        | 2 +-
>  block/raw-format.c                 | 2 +-
>  block/vdi.c                        | 2 +-
>  block/vhdx.c                       | 2 +-
>  block/vmdk.c                       | 2 +-
>  block/vpc.c                        | 2 +-
>  12 files changed, 15 insertions(+), 14 deletions(-)
> 
> -- 
> 2.51.0
> 
> 

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


