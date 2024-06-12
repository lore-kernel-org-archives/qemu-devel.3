Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFA6C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:41:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMLZ-0005XP-4p; Wed, 12 Jun 2024 07:40:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHMLU-0005XF-TK
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:40:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1sHMLT-0001t7-Ez
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:40:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718192450;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=VdRYuOWTPma8dA81nle6iSSbPBC8XgYLZl13dme8+8s=;
 b=hZzyxORlfx/Ev48fEv77Xe5rWxIPWN0ytiZ+2hT1OkvbUwMuZTw/J6f9hIi11+2dazWD8O
 C39hJM0Piqp12gaKdN3S2IpUNRQUud/UGqC8HsEmA7h+2iPWhKfle7pH9lnW9shvnSEaPj
 iDAY+ceMY4jbvpDUrUFPRKFRij7mK8c=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-3xdV_KOpNEiKsJNQNiyasQ-1; Wed,
 12 Jun 2024 07:40:44 -0400
X-MC-Unique: 3xdV_KOpNEiKsJNQNiyasQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AC31C19560B4; Wed, 12 Jun 2024 11:40:43 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.93])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 19D8319560AE; Wed, 12 Jun 2024 11:40:43 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id C087121E6757; Wed, 12 Jun 2024 13:40:40 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Eduardo
 Habkost <eduardo@habkost.net>,  Eric Blake <eblake@redhat.com>,  Daniel P.
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH v3 0/4] allow to deprecate objects and devices
In-Reply-To: <20240606143010.1318226-1-kraxel@redhat.com> (Gerd Hoffmann's
 message of "Thu, 6 Jun 2024 16:30:06 +0200")
References: <20240606143010.1318226-1-kraxel@redhat.com>
Date: Wed, 12 Jun 2024 13:40:40 +0200
Message-ID: <87zfrqe6dj.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

Gerd Hoffmann <kraxel@redhat.com> writes:

> Put some infrastructure in place to allow tagging objects (including
> devices) as deprected.  Use it to mark the ohci pci host adapter and
> the usb hub as deprecated.

I can see usb-hub [PATCH 2], but not "ohci pci host adapter".  Peeking
at the change log below... dropped in v2?

> v3:
>  - switch to two properties: 'deprecated' and 'not secure' flags.
>  - add rfc patch implementing policies for devices with flags.
>
> v2:
>  - pick up reviews.
>  - drop ohci patch.
>  - add cirrus vga patch.
>
> Gerd Hoffmann (4):
>   qom: allow to mark objects as deprecated or not secure.
>   usb/hub: mark as deprecated
>   vga/cirrus: mark as not secure

This part isn't mentioned in the cover letter.

>   qdev: add device policy [RfC]

There's overlap with QAPI special feature 'deprecated'.

QMP command object_add has argument @qom-type, which is an enumeration
of (user-creatable) object types.  The proper way to mark one of these
deprecated is to tack feature 'deprecated' to it.  It is then subject to
policy set with -compat deprecated-input=XXX, and is visible in
query-qmp-schema.  Modern management applications should already know
how to deal with it there.

This is definitely how we should deprecate user-creatable objects.
Adding a second way to do it seems undesirable to me.

Trouble is QMP command device_add still mostly bypasses QAPI.  Its
argument @driver is a string.

QAPIfying device_add properly has been on our (unwritten) wishlist since
forever.  Kevin (cc'ed) explored it some not too long ago.

I figure you want the means to deprecate devices now rather than after
we figure out how to QAPIfy device_add.  That's fair.

I think we should limit this series just to devices.  It'll become
redundant if we ever succeed at QAPIfying device_add.  No need to worry
about that now.


