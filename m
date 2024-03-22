Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5967C54E71
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Mar 2024 05:37:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rnXZx-0006Wf-Mf; Fri, 22 Mar 2024 01:36:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnXZv-0006W9-Vn
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 01:36:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rnXZu-0004jH-Du
 for qemu-devel@nongnu.org; Fri, 22 Mar 2024 01:36:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711085788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yG0yo+7u+0MsuJRyUEV+KVPCtuu1yB8oqH2ID753QU0=;
 b=hQQxEBDDqSSeQrmgUbB300OeggRCemIbW4iWORXentyHABHckIx1kKQikvcIcP3i4GVLm4
 NgeFCQLB04yISAytXNuOncaEE4Dnkok6bK+rJKIpZefkiz6qb4rfBPuP/7yIydrAUZT/hI
 80Jy55JVb6xzgMhBrk1PzsPVK8yvJoQ=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-520-HqefWHAuPrWxZ1-poN3szg-1; Fri,
 22 Mar 2024 01:36:24 -0400
X-MC-Unique: HqefWHAuPrWxZ1-poN3szg-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id D1EA01C07823;
 Fri, 22 Mar 2024 05:36:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id ACE41492BD0;
 Fri, 22 Mar 2024 05:36:23 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 91CF821E6A28; Fri, 22 Mar 2024 06:36:18 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Justinien Bouron <justinien.bouron@gmail.com>
Cc: Eric Blake <eblake@redhat.com>,  Paolo Bonzini <pbonzini@redhat.com>,
 Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Eduardo Habkost
 <eduardo@habkost.net>,  Gerd Hoffmann <kraxel@redhat.com>,  =?utf-8?Q?Mar?=
 =?utf-8?Q?c-Andr=C3=A9?=
 Lureau <marcandre.lureau@redhat.com>,  qemu-devel@nongnu.org
Subject: Re: [PATCH v2] input-linux: Add option to not grab a device upon
 guest startup
In-Reply-To: <20240322034311.2980970-1-justinien.bouron@gmail.com> (Justinien
 Bouron's message of "Thu, 21 Mar 2024 20:43:11 -0700")
References: <20240322034311.2980970-1-justinien.bouron@gmail.com>
Date: Fri, 22 Mar 2024 06:36:18 +0100
Message-ID: <874jcyhlpp.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.372,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Justinien Bouron <justinien.bouron@gmail.com> writes:

> Depending on your use-case, it might be inconvenient to have qemu grab
> the input device from the host immediately upon starting the guest.
>
> Added a new bool option to input-linux: grab-on-startup. If true, the
> device is grabbed as soon as the guest is started, otherwise it is not
> grabbed until the toggle combination is entered. To avoid breaking
> existing setups, the default value of grab-on-startup is true, i.e. same
> behaviour as before this change.
>
> Signed-off-by: Justinien Bouron <justinien.bouron@gmail.com>

QAPI schema
Acked-by: Markus Armbruster <armbru@redhat.com>


