Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 551D9C54791
	for <qemu-devel@archiver.kernel.org>; Wed, 13 Mar 2024 09:40:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rkL68-0001Oy-G2; Wed, 13 Mar 2024 05:40:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkL66-0001Oo-MQ
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:40:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rkL63-00024x-Hm
 for qemu-devel@nongnu.org; Wed, 13 Mar 2024 05:40:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1710322825;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/VDIsS8xatjbwIvdxMWV6loRxSBb9iEYV5eZJQRgg9k=;
 b=fVYKZAET/lx/wPJ4Y1hSaXBzqfsFWwrfivfd4hFccbvqRT8Oxb4fOWE4fRqI/WoCz6mdny
 QpTaOU/SKeHZuoaRIxENkjti5T4+rsKSGd5q6dK3VjLk6kSUXq9ZxflEnzOGCryjoULVs4
 3/EN2aAqqM+TkU9mbHO+aEmPcNwUpCQ=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-369-UekRnUn5NOWLnRQ01iajGQ-1; Wed, 13 Mar 2024 05:40:23 -0400
X-MC-Unique: UekRnUn5NOWLnRQ01iajGQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3A084800265;
 Wed, 13 Mar 2024 09:40:23 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.138])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D5D3540C6CB1;
 Wed, 13 Mar 2024 09:40:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id ADC7F21E6A24; Wed, 13 Mar 2024 10:40:21 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Hyman Huang <yong.huang@smartx.com>,  qemu-devel@nongnu.org,  Eric Blake
 <eblake@redhat.com>
Subject: Re: [PATCH v4 0/3] Adjust the output of x-query-virtio-status
In-Reply-To: <20240313051034-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Wed, 13 Mar 2024 05:18:50 -0400")
References: <cover.1708525606.git.yong.huang@smartx.com>
 <20240312121944-mutt-send-email-mst@kernel.org>
 <87h6hah7bb.fsf@pond.sub.org>
 <20240313051034-mutt-send-email-mst@kernel.org>
Date: Wed, 13 Mar 2024 10:40:21 +0100
Message-ID: <87msr2fp16.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.687,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
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

> On Wed, Mar 13, 2024 at 09:20:08AM +0100, Markus Armbruster wrote:
>> "Michael S. Tsirkin" <mst@redhat.com> writes:
>> 
>> > On Wed, Feb 21, 2024 at 10:28:50PM +0800, Hyman Huang wrote:
>> >> v4:
>> >> - Rebase on master
>> >> - Fix the syntax mistake within the commit message of [PATCH v3 1/3]
>> >> - Adjust the linking file in hw/virtio/meson.build suggested by Markus
>> >> 
>> >> Please review,
>> >> Yong
>> >
>> > I'm still not excited about this.
>> > For one this will not scale when we add more than 64 feature bits.
>> 
>> x-query-virtio-status is meant to be a low effort, low level debugging
>> aid.  Its feature set members correspond 1:1 to uint64_t members of the
>> C struct, which I figure correspond 1:1 to 64-bit words in the binary
>> virtio interface.
>> If we run out of bits in the binary virtio interface, I guess we'd add
>> another 64-bit word.  The C struct acquires another uint64_t member, and
>> so does x-query-virtio-status.
>> 
>> What's wrong with that?
>
> Nope, that last part about virtio binary interface is wrong. virtio does
> not have a 64-bit word in it's ABI, it has an array of bits represented,
> depending on a transport, as a dynamically sized array of 32-bit words
> (PCI, MMIO) or a dynamically sized array of bytes (CCW).

Then have x-query-virtio-status return a suitable array of unsigned
numbers.  Look ma, no invention!

> We are beginning to get closer to filling up 64 bits for some devices
> so I'm already looking at not baking 64 bit in new code.
>
>> 
>> > As long as we are changing this let's address this please.
>> > I would also suggest just keeping the name in there, so
>> > a decoded feature will be
>> > [0, NAME]
>> > and a non-decoded will be just
>> > [23]
>> >
>> > will make for a smaller change.
>> 
>> I'm not sure I understand your suggestion.
>> 
>> [...]
>
> For example, for the balloon device:
>
> instead of e.g. 0x201 as this patch would do,
> I propose [ [{0, "VIRTIO_BALLOON_F_MUST_TELL_HOST" }, {9, ""}] ].

Syntactially invalid.  I guess you mean something like

    [{"bit": 0, "name": "VIRTIO_BALLOON_F_MUST_TELL_HOST"},
     {"bit": 9, "name": ""}]

or with optional @name

    [{"bit": 0, "name": "VIRTIO_BALLOON_F_MUST_TELL_HOST"},
     {"bit": 9}]

This is an awfully verbose encoding of an n-bit number, even if we omit
"VIRTIO_BALLOON_F_" as noise.

I could be awkward for the use case described in PATCH 1's commit
message:

    However, we sometimes want to compare features and status bits without
    caring for their exact meaning.  Say we want to verify the correctness
    of the virtio negotiation between guest, QEMU, and OVS-DPDK.  We can use
    QMP command x-query-virtio-status to retrieve vhost-user net device
    features, and the "ovs-vsctl list interface" command to retrieve
    interface features.  Without commit f3034ad71fc, we could then simply
    compare the numbers.  With this commit, we first have to map from the
    strings back to the numeric encoding.

It next describes the patch's solution:

    Revert the decoding for QMP, but keep it for HMP.

    This makes the QMP command easier to use for use cases where we
    don't need to decode, like the comparison above.  For use cases
    where we need to decode, we replace parsing undocumented strings by
    decoding virtio's well-known binary encoding.

Since this is not a stable interface, instead of a perfect (and to my
subjective self overengineered) solution at some future point, I'd
prefer to get in a simple one *now*, even if we may have to evolve it
later.


