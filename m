Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82FCED3C928
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 16:59:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTNWx-0007g9-DN; Wed, 10 Dec 2025 11:59:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTNWv-0007fa-58
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:59:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vTNWt-0001IJ-Dn
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 11:59:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765385946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Kodh8vEQ4JYJWtdVQWXu7/OyWzDXA5uWeVLXRCXU/ZA=;
 b=g+CTfzoNWdHWJNK5Wh5rtsydScoFanR43cpVdZS7S7+s/GjdvzShrhMvJKRETWE758S/Bj
 Y2G6EX2uXe2/TLVDJmnHzGLmelLOglDbXR60qtpfETU+H6UJUfMQnbCoptQj/MycyM4Zw3
 vQqjMUVadnxp3wpHBuySOZaVfSTSx1s=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-682-lNVZwOCVMTWdHAbziNxmlg-1; Wed,
 10 Dec 2025 11:59:04 -0500
X-MC-Unique: lNVZwOCVMTWdHAbziNxmlg-1
X-Mimecast-MFC-AGG-ID: lNVZwOCVMTWdHAbziNxmlg_1765385944
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F7A41956089; Wed, 10 Dec 2025 16:59:03 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.7])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0A7DA1956095; Wed, 10 Dec 2025 16:59:02 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 7D2DB21E6A27; Wed, 10 Dec 2025 17:59:00 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, qemu-rust@nongnu.org
Subject: Re: [PATCH 00/19] rust: QObject and QAPI bindings
In-Reply-To: <1aef2d39-0052-4787-9635-89857bfb4a19@redhat.com> (Paolo
 Bonzini's message of "Wed, 10 Dec 2025 17:01:08 +0100")
References: <20251010151006.791038-1-pbonzini@redhat.com>
 <87tsy52ftl.fsf@pond.sub.org> <87zf7s5h3k.fsf@pond.sub.org>
 <525d2198-5d6f-43a0-88cd-78eae0042d27@redhat.com>
 <878qfa8k82.fsf@pond.sub.org>
 <1aef2d39-0052-4787-9635-89857bfb4a19@redhat.com>
Date: Wed, 10 Dec 2025 17:59:00 +0100
Message-ID: <87h5ty6zor.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Paolo Bonzini <pbonzini@redhat.com> writes:

> On 12/10/25 15:50, Markus Armbruster wrote:
>>> Let us know what you'd prefer and we'll switch.  Alternatively,
>>> retconning -B's meaning so that it applies to Rust will work too. :)
>> 
>> Any particular reason *not* to generate Rust unconditionally along with
>> C?
>
> Two reasons I can think of:
>
> 1) the exact layout is still in flux (not modular, no commands or events).
>
> 2) Rust prefers to have all files under a common path ("mod xyz" directs 
> the compiler to look at xyz.rs or xyz/mod.rs), which doesn't work well 
> if they are created in qapi/meson.build.  There's plenty of workarounds, 
> but I'd rather not pick one until the layout is fixed.
>
> So maybe for now we can use -B and not pollute qapi/meson.build, and 
> when the generator is more complete we can move Rust generation there?
>
> Paolo

Using -B for an in-tree prototype is fine with me.  I'd like a suitable
comment, though.


