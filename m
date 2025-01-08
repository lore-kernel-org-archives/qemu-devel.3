Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9752AE77188
	for <qemu-devel@archiver.kernel.org>; Wed,  8 Jan 2025 14:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVWe8-00008s-BW; Wed, 08 Jan 2025 09:02:56 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVWe6-00007y-8t
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:02:54 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kraxel@redhat.com>) id 1tVWe4-0000GB-FB
 for qemu-devel@nongnu.org; Wed, 08 Jan 2025 09:02:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736344971;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=E6jJe8yXIHBeeef6GjObc81Y2a9IYh+ijGCPoh9KBPw=;
 b=MNbltStRU7P+6e2qkCey1J8AHV3EcZXhiFhtaxGESjB8ho8H9jKMsptyrKKXANlYRf3Hdf
 EVP185IMfkgXf4CSQEJOzEFjDHEGEXHhPSik/CjNx23hxFZX3EJeCKTUzGqnSBqQ87sArT
 vSDL2jRf8LoIMgBbbODLdYj7T4Nniz4=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-258-TcJFhFaXMOm8GiFLFXV21A-1; Wed,
 08 Jan 2025 09:02:45 -0500
X-MC-Unique: TcJFhFaXMOm8GiFLFXV21A-1
X-Mimecast-MFC-AGG-ID: TcJFhFaXMOm8GiFLFXV21A
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3B1A21955E80; Wed,  8 Jan 2025 14:02:18 +0000 (UTC)
Received: from dobby.home.kraxel.org (unknown [10.39.192.243])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 740F3300018D; Wed,  8 Jan 2025 14:02:17 +0000 (UTC)
Received: by dobby.home.kraxel.org (Postfix, from userid 1000)
 id CF1EE2CDE95; Wed, 08 Jan 2025 15:02:14 +0100 (CET)
Date: Wed, 8 Jan 2025 15:02:14 +0100
From: Gerd Hoffmann <kraxel@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, graf@amazon.com, 
 Paolo Bonzini <pbonzini@redhat.com>, Michael Roth <michael.roth@amd.com>, 
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Thomas Huth <thuth@redhat.com>, qemu-arm@nongnu.org,
 Eric Blake <eblake@redhat.com>, 
 Peter Maydell <peter.maydell@linaro.org>, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 00/21] hw/uefi: add uefi variable service
Message-ID: <r574aim43uwh7qhfkvifcy3hmim4xpbxxi5eedl7iglrtxvirf@c3rddfvmihpz>
References: <20250107153353.1144978-1-kraxel@redhat.com>
 <CAMxuvazrd+3v2qqO-5o3qpky-ULRTwvU48jkwdxMPZG5c1RA1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMxuvazrd+3v2qqO-5o3qpky-ULRTwvU48jkwdxMPZG5c1RA1A@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=kraxel@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

  Hi,

> > The design idea is to reuse the request serialization protocol edk2 uses
> 
> I suppose this is a stable protocol. (some parts are set by the UEFI
> spec probably)

Partly yes, partly this is edk2-internal stuff.  In theory there is some
freedom to change the internal parts, in practice I have not seen this
changing in incompatible ways to far.

> There doesn't seem to be a defined way to query either side version or
> capability, I suppose this could be added later assuming an initial
> behaviour/magic etc.

There is a 'magic' device register, so should the need arise there is
the option to define a new magic cookie for incompatible changes.

> > A edk2 test branch can be found here (build with "-D QEMU_VARS=TRUE").
> > https://github.com/kraxel/edk2/commits/devel/secure-boot-external-vars
> 
> ok, perhaps it would be nice to have some basic unit tests in qemu
> too. Almost none of this new code is exercised by the qemu tests yet.

I have some unit tests, they are using edk2 though.  So having unit
tests right from the start is somewhat difficult.  I don't feel like
re-implementing the guest side of the serialization protocol for the
qemu unit tests.

Once the edk2 changes have landed in a edk2 stable tag and qemu bundled
firmware has been updated it should be relatively easy to add those
tests to qemu.  With updated edk2 firmware we can also add some
end-to-end testing such as booting a fedora cloud image with secure boot
turned on.

take care,
  Gerd


