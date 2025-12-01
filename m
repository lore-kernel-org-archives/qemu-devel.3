Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3C6FD116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 14:42:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ56O-0000hl-KA; Mon, 01 Dec 2025 09:42:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ56C-0000h3-W0
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:41:58 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vQ56B-0003Ls-B2
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 09:41:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764600112;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aZKn3ANz7dhOElaGzoBceRplLh3DJTmW+/O9eH24lf8=;
 b=OtNJMGHjX+uIX2xkOepz5woMavb7vCtmzAuzeaTRLaaWRhB5XRbYvuGBJ9kQxQfPLzlTxw
 tN6Gs1ea3NfLPLa/6J7CnyUXy0RLy82M6D5lYYfFMtxc341C7Urqh2V8QrvWlquYUEa5X2
 bIQrPEkxnhO7s9J4JHWnqbIiQokGvjk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-552-GghToXBCOfmLU7r_yhPWxg-1; Mon,
 01 Dec 2025 09:41:49 -0500
X-MC-Unique: GghToXBCOfmLU7r_yhPWxg-1
X-Mimecast-MFC-AGG-ID: GghToXBCOfmLU7r_yhPWxg_1764600108
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 99E8F1801327; Mon,  1 Dec 2025 14:41:47 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.139])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E31D9180049F; Mon,  1 Dec 2025 14:41:43 +0000 (UTC)
Date: Mon, 1 Dec 2025 14:41:40 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>
Cc: "Chalios, Babis" <bchalios@amazon.es>, "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>,
 "cohuck@redhat.com" <cohuck@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: Re: [RFC PATCH 3/4] hw/acpi: add VM generation counter field to
 VMClock
Message-ID: <aS2pJBM32o2cFVou@redhat.com>
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-5-bchalios@amazon.es>
 <aS2iOER6KBMMtJ0X@redhat.com>
 <e10030cec8809f16e41a2a3baaf07cf22894f8ff.camel@infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e10030cec8809f16e41a2a3baaf07cf22894f8ff.camel@infradead.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Dec 01, 2025 at 02:29:57PM +0000, David Woodhouse wrote:
> On Mon, 2025-12-01 at 14:12 +0000, Daniel P. Berrangé wrote:
> > From QEMU's POV, live migration and snapshots
> > are indistiguishable operations, both using the same functionaility.
> > 
> > eg
> >   $ qemu-system-x86_64 -monitor stdio -device vmclock
> >   (qemu) migrate file:snapshot.img
> > 
> > and
> > 
> >   $ qemu-system-x86_64 -monitor stdio -device vmclock -incoming file:snapshot.img
> > 
> > 
> > and we can't check the QEMU migration target being "file:" and mgmt
> > apps can use the "fd:" protocol to pass in a pre-opened target which can
> > be a socket or pipe or file.
> 
> What triggers the vmgenid to actually get updated for a snapshot?
> That's the condition we're after, isn't it?

I don't quiet understand the sequences, but libvirt is involved in setting
guid=nnnn as an arg to -device vmgenid when it spawns QEMU. This means
libvirt has control over when it is changed or not.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


