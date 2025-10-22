Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640D6CCD195
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 08:19:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBU3E-0004Ka-2C; Wed, 22 Oct 2025 04:18:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBU3B-0004K0-GJ
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:18:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vBU39-0003MS-8j
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 04:18:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761121104;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tw6gzjsbE+0nBCaw2caK+0Uvm9cuIz8oMjjN3LCWXSc=;
 b=i0lZyuYChQAF0xg9TytkexndacfEumwsjTVgiSdb3GsaXtJv/OG6ilaBdG2pe0RQAIBIXi
 3pjMhkcrA8xA5mxYBZwBD6Yp2a0inR4nDinjd0gODf1BXgrZPfOr4phfrZgZ0cFHSPC7hY
 0+5Q2vtLCn3ZeEC01XP77E1L2WonW3w=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-76-DfZnmvvZMveQb7Es9hOwsw-1; Wed,
 22 Oct 2025 04:18:21 -0400
X-MC-Unique: DfZnmvvZMveQb7Es9hOwsw-1
X-Mimecast-MFC-AGG-ID: DfZnmvvZMveQb7Es9hOwsw_1761121100
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2D16E19560AD; Wed, 22 Oct 2025 08:18:20 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.19])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B3ABF3000218; Wed, 22 Oct 2025 08:18:19 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 2133C21E6A27; Wed, 22 Oct 2025 10:18:17 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: qemu-devel@nongnu.org,  pbonzini@redhat.com,  Daniel P. =?utf-8?Q?Berr?=
 =?utf-8?Q?ang=C3=A9?=
 <berrange@redhat.com>,  Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PATCH] RFC: qdev: add legacy properties only for those
 print()-able
In-Reply-To: <CAJ+F1CJ6UiUZ=rY_O41Za=yPSDoW2atbM8Yk_oSdpQ+Nkjz1uw@mail.gmail.com>
 (=?utf-8?Q?=22Marc-Andr=C3=A9?= Lureau"'s message of "Tue, 21 Oct 2025
 16:58:13 +0400")
References: <20251015105419.2975542-1-marcandre.lureau@redhat.com>
 <87o6q0mn4o.fsf@pond.sub.org>
 <CAJ+F1CJ6UiUZ=rY_O41Za=yPSDoW2atbM8Yk_oSdpQ+Nkjz1uw@mail.gmail.com>
Date: Wed, 22 Oct 2025 10:18:17 +0200
Message-ID: <87o6pzgxiu.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Marc-Andr=C3=A9 Lureau <marcandre.lureau@gmail.com> writes:

[...]

> Yes, that matches my understanding and I agree about your feeling
> about the infrastructure just for DEVFN. But at the same time, it's
> nice to have and I don't have a proposal to change that :)

I have an idea on how to simplify things.  If it works, I'll send a
patch.


