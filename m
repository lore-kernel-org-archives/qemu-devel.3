Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCB28CAC582
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Sep 2025 13:51:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ux4Aa-0001BN-Cz; Fri, 12 Sep 2025 09:50:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux4AX-0001B8-Kq
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:50:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ux4AV-0005xj-7w
 for qemu-devel@nongnu.org; Fri, 12 Sep 2025 09:50:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757685023;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A4jyelgNF9BZhWkgDMAz4xKfjyRzIqQc3Q1VqXYIk3o=;
 b=BQwnRPwFXJRHUq6f9U9VcpJqMnn+04E880N4+8Ca/5M5mIhwBUnx5WC/Nd/YpSjrETFW52
 O7cqLLOzNh5kQ7K6GWExugk/ksIWsGE1YQbln07ikyj4ufDqysD43wdcXrn+5DYL+vjVOM
 Sc22DXBBg4xiwezU9ICG+IAXnpFKIiA=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-145-agrOZXXmOhCA1XSM_-iTWw-1; Fri,
 12 Sep 2025 09:50:20 -0400
X-MC-Unique: agrOZXXmOhCA1XSM_-iTWw-1
X-Mimecast-MFC-AGG-ID: agrOZXXmOhCA1XSM_-iTWw_1757685018
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 27D821944F01; Fri, 12 Sep 2025 13:50:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.12])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6A2B51954126; Fri, 12 Sep 2025 13:50:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id D113B21E6A27; Fri, 12 Sep 2025 15:50:14 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Filip Hejsek <filip.hejsek@gmail.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,  "Michael S. Tsirkin"
 <mst@redhat.com>,  Laurent Vivier <lvivier@redhat.com>,  Amit Shah
 <amit@kernel.org>,  Eric Blake <eblake@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Yanan Wang
 <wangyanan55@huawei.com>,  Zhao Liu <zhao1.liu@intel.com>,  Szymon Lukasz
 <noh4hss@gmail.com>
Subject: Re: [PATCH v4 08/10] virtio-serial-bus: add terminal resize messages
In-Reply-To: <20250912-console-resize-v4-8-7925e444afc4@gmail.com> (Filip
 Hejsek's message of "Fri, 12 Sep 2025 05:39:53 +0200")
References: <20250912-console-resize-v4-0-7925e444afc4@gmail.com>
 <20250912-console-resize-v4-8-7925e444afc4@gmail.com>
Date: Fri, 12 Sep 2025 15:50:14 +0200
Message-ID: <878qij7pbd.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Filip Hejsek <filip.hejsek@gmail.com> writes:

> From: Szymon Lukasz <noh4hss@gmail.com>
>
> Implement the part of the virtio spec that allows to notify the virtio
> driver about terminal resizes. The virtio spec contains two methods to
> achieve that:
>
> For legacy drivers, we have only one port and we put the terminal size
> in the config space and inject the config changed interrupt.
>
> For multiport devices, we use the control virtqueue to send a packet
> containing the terminal size. Note that old versions of the Linux kernel
> used an incorrect order for the fields (rows then cols instead of cols
> then rows), until it was fixed by commit 5326ab737a47278dbd16ed3ee7380b26c7056ddd.
>
> As a result, when using a Linux kernel older than 6.15, the number of rows
> and columns will be swapped.

Should this note be added to user documentation?

> Signed-off-by: Szymon Lukasz <noh4hss@gmail.com>
> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> Signed-off-by: Filip Hejsek <filip.hejsek@gmail.com>


