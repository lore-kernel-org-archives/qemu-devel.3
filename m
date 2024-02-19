Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F512C48BC3
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Feb 2024 15:33:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rc5e7-0003iM-1o; Mon, 19 Feb 2024 10:33:31 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5e6-0003h8-3f
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:33:30 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rc5e4-0007Gu-Nl
 for qemu-devel@nongnu.org; Mon, 19 Feb 2024 10:33:29 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708356807;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dXE8faEVa9ORmy00IPPxWlcUNKvVCoD4Z55HmlJ9/Kg=;
 b=EgWvzl9epA96DYp4r4cp4K1S/BpjL25H4PGOON9dKVAj86K1sN//ClFwDUvCnqXTb78Wil
 FHkK3Mzsji+2xlxAB0upFNR3CmWfyE52djxMBJERwwl3uGOUxucfl8G3Z/UcDGLE/+ZwF7
 avW3AX8QwLj3ZPHMGczEMG0nCiaEPWg=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-BBzPzY-7ObKSRYgV0PFGNw-1; Mon, 19 Feb 2024 10:33:24 -0500
X-MC-Unique: BBzPzY-7ObKSRYgV0PFGNw-1
Received: from smtp.corp.redhat.com (int-mx09.intmail.prod.int.rdu2.redhat.com
 [10.11.54.9])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5613310B0702;
 Mon, 19 Feb 2024 15:33:24 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.55])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 347F1492BCA;
 Mon, 19 Feb 2024 15:33:24 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 47AF421E66D0; Mon, 19 Feb 2024 16:33:23 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Hyman Huang <yong.huang@smartx.com>
Cc: qemu-devel@nongnu.org,  "Michael S . Tsirkin" <mst@redhat.com>,  Eric
 Blake <eblake@redhat.com>
Subject: Re: [PATCH v3 3/3] qapi: Define VhostDeviceProtocols and
 VirtioDeviceFeatures as plain C types
In-Reply-To: <4ce51ef3d64fe2b09443cd0529da91115476b35a.1706883915.git.yong.huang@smartx.com>
 (Hyman Huang's message of "Fri, 2 Feb 2024 22:32:17 +0800")
References: <cover.1706883915.git.yong.huang@smartx.com>
 <4ce51ef3d64fe2b09443cd0529da91115476b35a.1706883915.git.yong.huang@smartx.com>
Date: Mon, 19 Feb 2024 16:33:23 +0100
Message-ID: <87h6i4ii4c.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.9
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.072,
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

Hyman Huang <yong.huang@smartx.com> writes:

> VhostDeviceProtocols and VirtioDeviceFeatures are only used in
> virtio-hmp-cmds.c.  So define them as plain C types there, and drop
> them from the QAPI schema.
>
> Signed-off-by: Hyman Huang <yong.huang@smartx.com>

Reviewed-by: Markus Armbruster <armbru@redhat.com>


