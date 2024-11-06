Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE7FD44D46
	for <qemu-devel@archiver.kernel.org>; Wed,  6 Nov 2024 10:59:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t8dkk-0002ez-Hj; Wed, 06 Nov 2024 05:59:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8dki-0002eY-DD
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:59:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1t8dkh-00017k-0Y
 for qemu-devel@nongnu.org; Wed, 06 Nov 2024 05:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730890746;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TkDwnZA/qWqgOFZ6ibqJa+V6Fauy9EOy49K+bQTb6F0=;
 b=FuuA8nTLN+MiQ1+iSJpKf8SzHbDcBxE5emIGUZ8pejZJtVsLeZ2bEPf2VNwvuQlUcAxdlK
 V3zR350+EKIFkWb+bqLWiJA4nBBjwFvxwqu3y+/seZFKE3VY9+fY+F40qwpeIskHhWiYaK
 6rsBjwKqHiJLGQADnk0WR0Rjz891qm8=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-54-ekt9WqjkPRy6jn7mHpBhFA-1; Wed,
 06 Nov 2024 05:59:03 -0500
X-MC-Unique: ekt9WqjkPRy6jn7mHpBhFA-1
X-Mimecast-MFC-AGG-ID: ekt9WqjkPRy6jn7mHpBhFA
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DA101955F41; Wed,  6 Nov 2024 10:59:02 +0000 (UTC)
Received: from redhat.com (dhcp-192-228.str.redhat.com [10.33.192.228])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EE56A1956088; Wed,  6 Nov 2024 10:58:59 +0000 (UTC)
Date: Wed, 6 Nov 2024 11:58:57 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Eduardo Habkost <eduardo@habkost.net>,
 pkrempa@redhat.com,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, armbru@redhat.com
Subject: Re: [PATCH v3 0/2] qdev-monitor: avoid QemuOpts in QMP device_add()
Message-ID: <ZytL8UFrj7_EY8mr@redhat.com>
References: <20240827192751.948633-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240827192751.948633-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 27.08.2024 um 21:27 hat Stefan Hajnoczi geschrieben:
> v3:
> - Duplicate drain_call_rcu() into hmp_device_add() because moving it into
>   qdev_device_add_from_qdict turned out to be unsafe.
> v2:
> - Rename Patch 1 to indicate that we're avoiding QemuOpts rather than doing a
>   full conversion to QAPI. Also mention that 'gen': false is still being used.
>   [Markus]
> - Add Patch 2 to address a TODO comment suggesting that
>   qemu_create_cli_devices() should call qmp_device_add(). [Markus]
> - Move drain_call_rcu() into qdev_device_add_from_qdict() to avoid code
>   duplication. [Markus]
> 
> This series enables non-scalar parameter parsing in device_add (e.g.
> virtio-blk-pci,iothread-vq-mapping=). Stop converting from QDict to QemuOpts
> and back again as this loses type information and cannot represent non-scalars.

Reviewed-by: Kevin Wolf <kwolf@redhat.com>


