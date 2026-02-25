Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 421C1FD374E
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 13:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvEvm-0002Lz-UO; Wed, 25 Feb 2026 08:28:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvEvj-0002Lh-Gm
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:27:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vvEvh-0001Az-2b
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 08:27:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772026071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Mq+TtfRN7NEOBAs4fuYxfUcHiilcK9tC68dy+otkKt4=;
 b=jRVpwUkpnpoeClzW06vWpIqSSyTexu7SBBYq+9EZ1kU3qEiKOGrqP2F5ltLsueDKdkrdoI
 i1qj6wVHoB9MkzDwgOveE3MdJIeCznZlBwYfz6vhustLzerCpR2wYaI1K+LctU1DaBHWRj
 GViH8E9aqHxlRHkLyfIGa+nbfSdg57w=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-352-zGFSYVMNO9mI0UnZOgLB8g-1; Wed,
 25 Feb 2026 08:27:47 -0500
X-MC-Unique: zGFSYVMNO9mI0UnZOgLB8g-1
X-Mimecast-MFC-AGG-ID: zGFSYVMNO9mI0UnZOgLB8g_1772026067
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1B631800615; Wed, 25 Feb 2026 13:27:46 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.13])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 63F5F3003D88; Wed, 25 Feb 2026 13:27:46 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C84621E692D; Wed, 25 Feb 2026 14:27:44 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: David Hamilton <dahamilt0@gmail.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/2] hw/misc/ivshmem-pci: Handle error from
 kvm_irqchip_add_irqfd_notifier_gsi()
In-Reply-To: <20260225121323.5395-2-dahamilt0@gmail.com> (David Hamilton's
 message of "Wed, 25 Feb 2026 07:13:22 -0500")
References: <20260225121323.5395-1-dahamilt0@gmail.com>
 <20260225121323.5395-2-dahamilt0@gmail.com>
Date: Wed, 25 Feb 2026 14:27:44 +0100
Message-ID: <875x7lkl67.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

David Hamilton <dahamilt0@gmail.com> writes:

> The return value of kvm_irqchip_add_irqfd_notifier_gsi() was being
> ignored. Propagate the error to the caller via errp.
>
> Also change setup_interrupt() to return bool to follow QEMU error
> handling conventions, making error checks at call sites simpler.
>
> Resolves the TODO comment at the call site.
>
> Signed-off-by: David Hamilton <dahamilt0@gmail.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


