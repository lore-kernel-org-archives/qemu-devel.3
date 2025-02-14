Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4ACC021A6
	for <qemu-devel@archiver.kernel.org>; Fri, 14 Feb 2025 13:55:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiw9W-0003Jl-F1; Fri, 14 Feb 2025 08:54:46 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiw9U-0003JY-1M
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:54:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tiw9R-00010X-Mv
 for qemu-devel@nongnu.org; Fri, 14 Feb 2025 08:54:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739541280;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CdQQ3IW6vQcL1egE3OIOS4WQdVEXI858c2F8SSryLGU=;
 b=HJqj8pO3xjCW6p8uwr2CT5ju/VoAdzwL/vmu5gpw3HbrTxHDNRTocvvEyh7YYcw46+ho6f
 T3BOyXDJxeOrAsoltsbESw8z7VuGaCWiQj7bVKHrVAE1mVQ0mBMfhnEGE0n+9id+EVIl0I
 qaZkhoAtP6O1XI04YS7k4nfTB+AJJ/I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-pqv_MmbxPJ6_SvHQyp67iQ-1; Fri,
 14 Feb 2025 08:54:38 -0500
X-MC-Unique: pqv_MmbxPJ6_SvHQyp67iQ-1
X-Mimecast-MFC-AGG-ID: pqv_MmbxPJ6_SvHQyp67iQ_1739541277
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9B2E11955F28
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 13:54:36 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.22])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 53A691800352
 for <qemu-devel@nongnu.org>; Fri, 14 Feb 2025 13:54:36 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C067F21E6A28; Fri, 14 Feb 2025 14:54:33 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org,  =?utf-8?Q?Marc-Andr=C3=A9?= Lureau
 <marcandre.lureau@redhat.com>,
 Eric Blake <eblake@redhat.com>,  Jason Wang <jasowang@redhat.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Laine Stump <laine@redhat.com>,  Stefano
 Brivio <sbrivio@redhat.com>,  "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Subject: Re: [PATCH] net: vhost-user: add QAPI events to report connection
 state
In-Reply-To: <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com> (Laurent
 Vivier's message of "Fri, 14 Feb 2025 11:18:55 +0100")
References: <20250214072629.1033314-1-lvivier@redhat.com>
 <871pw07sdy.fsf@pond.sub.org>
 <2c5358eb-1abe-4fce-8b28-7935c71f1cff@redhat.com>
Date: Fri, 14 Feb 2025 14:54:33 +0100
Message-ID: <87a5ao3a3q.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -37
X-Spam_score: -3.8
X-Spam_bar: ---
X-Spam_report: (-3.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.732,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Laurent Vivier <lvivier@redhat.com> writes:

> On 14/02/2025 11:06, Markus Armbruster wrote:
>> Laurent Vivier <lvivier@redhat.com> writes:
>> 
>>> The netdev reports NETDEV_VHOST_USER_CONNECTED event when
>>> the chardev is connected, and NETDEV_VHOST_USER_DISCONNECTED
>>> when it is disconnected.
>>>
>>> The NETDEV_VHOST_USER_CONNECTED event includes the ChardevInfo
>>> (label, filename and frontend_open).
>>>
>>> This allows a system manager like libvirt to detect when the server
>>> fails.
>>>
>>> For instance with passt:
>>>
>>> { 'execute': 'qmp_capabilities' }
>>> { "return": { } }
>>>
>>> [killing passt here]
>>>
>>> { "timestamp": { "seconds": 1739517243, "microseconds": 115081 },
>>>    "event": "NETDEV_VHOST_USER_DISCONNECTED",
>>>    "data": { "netdev-id": "netdev0" } }
>>>
>>> [automatic reconnection with reconnect-ms]
>>>
>>> { "timestamp": { "seconds": 1739517290, "microseconds": 343777 },
>>>    "event": "NETDEV_VHOST_USER_CONNECTED",
>>>    "data": { "netdev-id": "netdev0",
>>>              "info": { "frontend-open": true,
>>>                        "filename": "unix:",
>>>                        "label": "chr0" } } }
>>>
>>> Signed-off-by: Laurent Vivier <lvivier@redhat.com>
>> 
>> Standard question for events: if a management application misses an
>> event, say because it restarts and reconnects, is there a way to obtain
>> the missed information with a query command?
>
> query-chardev could help but it doesn't provide the netdev id.
>
> in HMP, "info network" has the information, but for QMP we had a try with a query-netdev in the past but the series has been reverted.
>
> f9bb0c1f9862 ("Revert "qapi: net: Add query-netdev command"")
> d32ad10a14d4 ("qapi: net: Add query-netdev command")

Hmm.  Can management applications use these events without a matching
query?


