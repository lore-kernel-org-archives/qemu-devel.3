Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A032DC02198
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Feb 2025 12:29:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tiBrd-0000LX-Kl; Wed, 12 Feb 2025 07:29:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tiBrE-0000JB-Vm
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:28:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tiBrC-0005jm-Dj
 for qemu-devel@nongnu.org; Wed, 12 Feb 2025 07:28:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739363324;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JXRjSceMxYxUagBLxQrXrdr/9hn78YW+HitZU1RergM=;
 b=EFmuuFBErj9YcMMhQct4HHtPQckRhEvnvGEVZpislaQKBeHJGfhk1EMo65us+WhLne1084
 RpnFGouvxu2p+zISXzXcsO1288VVHuRt/TMwBYRXuWazC03OXHT8IvVf+98xmKBijzsLvW
 CZ/NhTUE4YcSkhUz3gvuJGXkzSFo43Y=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-265-SnQWMP13NRO2XE79_u8Duw-1; Wed,
 12 Feb 2025 07:28:41 -0500
X-MC-Unique: SnQWMP13NRO2XE79_u8Duw-1
X-Mimecast-MFC-AGG-ID: SnQWMP13NRO2XE79_u8Duw_1739363319
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 955ED19560AE; Wed, 12 Feb 2025 12:28:39 +0000 (UTC)
Received: from sirius.home.kraxel.org (unknown [10.45.224.69])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E68E930001AB; Wed, 12 Feb 2025 12:28:37 +0000 (UTC)
Received: by sirius.home.kraxel.org (Postfix, from userid 1000)
 id 9E6B918000A6; Wed, 12 Feb 2025 13:28:35 +0100 (CET)
Date: Wed, 12 Feb 2025 13:28:35 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: Alexander Graf <graf@amazon.com>
Cc: qemu-devel@nongnu.org, Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, 
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 qemu-arm@nongnu.org, Michael Roth <michael.roth@amd.com>, 
 Markus Armbruster <armbru@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH v3 09/23] hw/uefi: add var-service-core.c
Message-ID: <kk4f5e3olb26qfjveqefkuzrjc45djikkk7uspz4yj7iesdmbj@zointitbvhdp>
References: <20250211092324.965440-1-kraxel@redhat.com>
 <20250211092324.965440-10-kraxel@redhat.com>
 <da0ac9ed-fdca-433e-b793-5423f430a852@amazon.com>
 <iuwaykfdm7bwtvblyz7lkew3em2ksi5xeztdphqjdv7tsp2ejw@s6j64y3lfmrw>
 <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ea1d355b-7e56-47ef-b1e7-158003b6d85f@amazon.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.495,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Feb 12, 2025 at 12:30:20PM +0100, Alexander Graf wrote:
> 
> On 12.02.25 11:24, Gerd Hoffmann wrote:
> > 
> > Why do you use confidential computing in the first place if you trust
> > the host with your EFI variables?  I'd rather see something simliar
> > running under guest control, in svsm context.
> 
> That depends heavily on your threat model. You can use a host provided
> variable store to gain variable persistence for things like boot variables
> and then have an ephemeral SVSM based TPM that you use to measure the loaded
> payloads. A malicious host can already replace your root volume, so
> extending the threat to variables is not the end of the world.

If you go depend on measured boot instead of secure boot then yes, this
might be a workable model.  Should be doable with a small svsm driver
which forwards requests to the host via svsm-controlled bounce buffer
(where the svsm has control over page properties).

> > The firmware knows all this very well though.  The OS passes a mapping
> > table to the firmware, efi runtime drivers can subscribe to mapping
> > updates and can use RT->ConvertPointer to translate addresses from
> > physical to virtual.
> > 
> > The edk2 code (https://github.com/tianocore/edk2/pull/10695) does
> > exactly that.
> > 
> > I see your driver does that too, so in theory it should work just fine.
> > I'm wondering what exactly the problem with macOS is?
> 
> You get to know the new virtual address, but ConvertPointer never tells you
> what the new *physical* address is. That means you have no idea where to DMA
> from once you're in virtual land.

Yes.  Knowing both physical and virtual address works only for memory
you allocated yourself before ExitBootServices.  So you can't pass on
pointers from the OS, you have to copy the data to a buffer where you
know the physical address instead.  Yes, some overhead.  Should still
be much faster than going to pio transfer mode ...

> > It would be nice to have nitro support merged upstream,
> > especially with BYOF coming.
> 
> Yes. Or converge on this protocol instead to simplify the firmware
> implementation

Yes, that works too and would reduce your stack of unmerged patches a
bit.

take care,
  Gerd


