Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A42B0C25B75
	for <qemu-devel@archiver.kernel.org>; Wed, 29 May 2024 13:21:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sCJET-0003fV-ON; Wed, 29 May 2024 09:20:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sCJEQ-0003et-5n
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:20:42 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1sCJEO-0004yq-Hf
 for qemu-devel@nongnu.org; Wed, 29 May 2024 09:20:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716988839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oD+XSeTIwnENgUhSUme1EXmN0K2eMJPIIRlWHmse/z8=;
 b=Km630cm5RtettTDzqvvYgLWFnEyfzmwib8wzz+u5r4K68Bsm1CcEtbSLsChGbMVwfCB2AB
 5tZgbsrK4jdL/4bMF1EdiZtoHzmGuwebV2V/B3hpEZ41+LCKYhBLLyUreVwNPp+Nyy141T
 lt1sSTmU/F4K1EOJf0rTvRTUbC5vq+k=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-237-IW33jL5vPcmdyAZZMoA1ig-1; Wed,
 29 May 2024 09:20:36 -0400
X-MC-Unique: IW33jL5vPcmdyAZZMoA1ig-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7D75329AA384;
 Wed, 29 May 2024 13:20:35 +0000 (UTC)
Received: from redhat.com (unknown [10.39.194.254])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 0A659105480A;
 Wed, 29 May 2024 13:20:33 +0000 (UTC)
Date: Wed, 29 May 2024 15:20:32 +0200
From: Kevin Wolf <kwolf@redhat.com>
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Hanna Czenczek <hreitz@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>, qemu-stable@nongnu.org
Subject: Re: [PATCH 1/2] Revert "monitor: use aio_co_reschedule_self()"
Message-ID: <ZlcroLAbB2KuBt4G@redhat.com>
References: <20240506190622.56095-1-stefanha@redhat.com>
 <20240506190622.56095-2-stefanha@redhat.com>
 <5e6a19d0-bb58-440e-9524-25555a276a21@proxmox.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5e6a19d0-bb58-440e-9524-25555a276a21@proxmox.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.036,
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

Am 29.05.2024 um 12:33 hat Fiona Ebner geschrieben:
> CC-ing stable since 1f25c172f83704e350c0829438d832384084a74d is in 9.0.0

Good point, I'm also updating the commit message in my tree to add
a Cc: line. Thanks for catching this, Fiona!

Kevin


