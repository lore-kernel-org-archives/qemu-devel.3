Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27708EE3695
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 16:14:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqZJo-0003dZ-DY; Thu, 12 Feb 2026 11:13:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vqZJi-0003cj-PQ
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:13:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pkrempa@redhat.com>)
 id 1vqZJe-0004L3-O4
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 11:13:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770912794;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zUyF7MIeOjpeQHiis98JujsK3qKIVMlOKqHIiMAfux0=;
 b=eIR0X3XECDoJUQ3fjz3burIuF177WfuATZ6CJ07m30u7y8HKOFiYRQ2zZvxRyBrVoC+PkS
 ar+Y5J7eKd3EszAgqy0YKrXCclvpmzj7VNrjghaWDT+83Oc7jqJmIIYz2dgwCVJnwvb0QE
 MjhH22UE8kCPyBhmKa/bMH0qdz9gYAs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-172--Er0xJeRO5evqzuBK5S_Mw-1; Thu,
 12 Feb 2026 11:13:11 -0500
X-MC-Unique: -Er0xJeRO5evqzuBK5S_Mw-1
X-Mimecast-MFC-AGG-ID: -Er0xJeRO5evqzuBK5S_Mw_1770912791
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A40E018004BB; Thu, 12 Feb 2026 16:13:10 +0000 (UTC)
Received: from angien.pipo.sk (unknown [10.44.22.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9C7571800464; Thu, 12 Feb 2026 16:13:08 +0000 (UTC)
Date: Thu, 12 Feb 2026 17:13:05 +0100
From: Peter Krempa <pkrempa@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v4 0/2] block: Wire up 'flat' mode also for 'query-block'
Message-ID: <aY38Edx6GINilEGa@angien.pipo.sk>
References: <cover.1770210044.git.pkrempa@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770210044.git.pkrempa@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pkrempa@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Wed, Feb 04, 2026 at 14:15:42 +0100, Peter Krempa wrote:
> v4:
>  - No need to check 'has_flat', as qemu doesn't have warnings about
>    unused variables active (Markus)
>  - Doc wording tweak (Markus)
> 
> v3:
>  - Doc wording tweak (Eric)
> 
> v2:
>  - More descriptive docs text for the new QAPI option (Markus; new
>    wording not approved)
>  - use new options in hmp_nbd_server_start to avoid fetching unused
>    backing image info, impossible in 'info block' worker (Markus)
> 
> Peter Krempa (2):
>   block: Wire up 'flat' mode also for 'query-block'
>   hmp_nbd_server_start: Don't ask for backing image data

Ping?


