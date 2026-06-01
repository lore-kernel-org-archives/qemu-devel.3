Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3BE5CD5BD1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Jun 2026 14:15:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wU3QD-00031c-8D; Mon, 01 Jun 2026 10:15:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wU3QC-0002zk-9o
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:15:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1wU3QA-00017b-Rq
 for qemu-devel@nongnu.org; Mon, 01 Jun 2026 10:15:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780323314;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7cqaaiEQkkhRu8pNut4pkKqMMrLXplukj+cfZ7XJ+rI=;
 b=LmvVYG3FoUAZbrawwKjKK7gdD7ahkuJhE+FHggRH2Eoy3UuwFtWeF9aKo2Nmmc0WBHLngc
 Q70qGt0JqmhyR+e+dRi4kSChd9w4187icKNrKbXxaoIAlW3dsNlMsH6vy8bfQL+lq/LR/d
 kh3tnRjCgXpgo2pITQAh5RnUlv095SU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-42-xBzPVjihNeO5sFNqWj0fMg-1; Mon,
 01 Jun 2026 10:15:09 -0400
X-MC-Unique: xBzPVjihNeO5sFNqWj0fMg-1
X-Mimecast-MFC-AGG-ID: xBzPVjihNeO5sFNqWj0fMg_1780323308
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 781EA18D6372; Mon,  1 Jun 2026 14:14:06 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.44.22.2])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BE65E180058F; Mon,  1 Jun 2026 14:14:05 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 04C0B21E6A01; Mon, 01 Jun 2026 16:14:03 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Keith Busch <kbusch@kernel.org>,  Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>
Cc: Mateusz Nowicki <mateusz.nowicki@posteo.net>, qemu-devel@nongnu.org,
 "Dr . David Alan Gilbert" <dave@treblig.org>,  Philippe =?utf-8?Q?Mathie?=
 =?utf-8?Q?u-Daud=C3=A9?=
 <philmd@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,  Eric Blake
 <eblake@redhat.com>,  qemu-block@nongnu.org
Subject: Re: [PATCH v3 0/2] hw/nvme: HMP commands for inspecting emulated
 controllers
In-Reply-To: <20260522102821.16766-1-mateusz.nowicki@posteo.net> (Mateusz
 Nowicki's message of "Fri, 22 May 2026 10:29:13 +0000")
References: <20260522102821.16766-1-mateusz.nowicki@posteo.net>
Date: Mon, 01 Jun 2026 16:14:02 +0200
Message-ID: <87mrxebb6d.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Mateusz Nowicki <mateusz.nowicki@posteo.net> writes:

> Add two HMP commands for inspecting emulated NVMe controllers from
> the QEMU monitor without attaching gdb to the QEMU process:
>
>   - 'info nvme'        - per-controller summary (PCI, identify
>                          fields, CC/CSTS/AQA, queue counts)
>   - 'info nvme-queues' - per-queue listing of admin and I/O SQ/CQ
>                          (size, head/tail, PRP1, doorbell offset,
>                          phase tag)
>
> Useful for verifying queue setup, doorbell rings, AERs held in the
> admin SQ and similar driver/controller interaction details from a
> running QEMU monitor.

I can take this, but I'd like at least an Acked-by from an NVME
maintainer.


