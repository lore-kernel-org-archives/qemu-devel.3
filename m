Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63961C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 08:20:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkJqb-0004Le-EI; Wed, 13 Mar 2024 04:20:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkJqY-0004LQ-SF
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:20:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkJqX-0002tu-Ch
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 04:20:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710318012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=oXQomDLC4ZvYa+LcOtJH5M4wdQapExpEJeSijt2BL3U=;
 b=PNZIcpbexFgdJM3LK6tifahxyFuo0Bhj8mxBB8JAQ0+DHK4+AlpvgBrdP1RadCxzzr/OU1
 8EvDdvf1G3mWci0yQV8DaDhjp43ny84C4eDoajRj6nVrejZ2R74AM9PCj38OxwyxQnEIcb
 DClie71SGQHQLBUZRTk43WamWicZ2AM=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-518-JvHNpGwsN4qdyIsfREW-FQ-1; Wed,
 13 Mar 2024 04:20:10 -0400
X-MC-Unique: JvHNpGwsN4qdyIsfREW-FQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com
 [10.11.54.3])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 155063C000B3;
 Wed, 13 Mar 2024 08:20:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id A67321121306;
 Wed, 13 Mar 2024 08:20:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7C1CB21E6A24; Wed, 13 Mar 2024 09:20:08 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
In-Reply-To: <20240312121944-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 12 Mar 2024 12:39:38 -0400")
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
Date: Wed, 13 Mar 2024 09:20:08 +0100
Message-ID: <87h6hah7bb.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
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

"Michael S. Tsirkin" <mst@redhat.com> writes:

> On Wed, Feb 21, 2024 at 10:28:50PM +0800, Hyman Huang wrote:
>> v4:
>> - Rebase on master
>> - Fix the syntax mistake within the commit message of [PATCH v3 1/3]
>> - Adjust the linking file in hw/virtio/meson.build suggested by Markus
>> 
>> Please review,
>> Yong
>
> I'm still not excited about this.
> For one this will not scale when we add more than 64 feature bits.

x-query-virtio-status is meant to be a low effort, low level debugging
aid.  Its feature set members correspond 1:1 to uint64_t members of the
C struct, which I figure correspond 1:1 to 64-bit words in the binary
virtio interface.

If we run out of bits in the binary virtio interface, I guess we'd add
another 64-bit word.  The C struct acquires another uint64_t member, and
so does x-query-virtio-status.

What's wrong with that?

> As long as we are changing this let's address this please.
> I would also suggest just keeping the name in there, so
> a decoded feature will be
> [0, NAME]
> and a non-decoded will be just
> [23]
>
> will make for a smaller change.

I'm not sure I understand your suggestion.

[...]


