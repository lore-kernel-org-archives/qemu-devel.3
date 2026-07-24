Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD53BC531F9
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jul 2026 08:38:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnBPm-0004JE-Rx; Fri, 24 Jul 2026 04:37:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wnBPl-0004Gh-Jw
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:37:53 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wnBPj-0003HO-1w
 for qemu-devel@nongnu.org; Fri, 24 Jul 2026 04:37:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784882269;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=X4S9RMaE2fa5ss0w5EmhFKbd4aE8j28FDbyZrUM8T6w=;
 b=HGxypFyjlwyqLs3xpdJnd/0gmEbw65oBkTR345/dN59DXadEmPW8k9zQoR30oCfjqoc31T
 iQTRyCBD3FFlz5qEj0V1YDPKXiS877S47Oykp4i9df8hmS7NCuLJ1LmeqLv+DF2Vf06r6N
 MekQ5rdrma3Pf/kx0N6Dopx1ByBoz1o=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-673-oBxzCoTvNSGT-1cnfDT2Pw-1; Fri,
 24 Jul 2026 04:37:46 -0400
X-MC-Unique: oBxzCoTvNSGT-1cnfDT2Pw-1
X-Mimecast-MFC-AGG-ID: oBxzCoTvNSGT-1cnfDT2Pw_1784882264
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 743EE1955DA3; Fri, 24 Jul 2026 08:37:44 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 95B711956060; Fri, 24 Jul 2026 08:37:39 +0000 (UTC)
Date: Fri, 24 Jul 2026 09:37:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Tokarev <mjt@tls.msk.ru>
Cc: Luc Michel <luc.michel@amd.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Francisco Iglesias <francisco.iglesias@amd.com>,
 Frederic Konrad <frederic.konrad@amd.com>,
 QEMU Stable <qemu-stable@nongnu.org>
Subject: Re: [PATCH v2] meson.build: re-add explicit gcrypt/nettle request
 check
Message-ID: <amMkUBpmpRq0-HCu@redhat.com>
References: <20260710132531.97844-1-luc.michel@amd.com>
 <53d5fe02-fcc5-4089-a64c-720c7b324c81@tls.msk.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <53d5fe02-fcc5-4089-a64c-720c7b324c81@tls.msk.ru>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
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

On Fri, Jul 24, 2026 at 10:22:28AM +0300, Michael Tokarev wrote:
> On 7/10/26 16:25, Luc Michel wrote:
> > c4b3d0074 removed the check that nettle or gcrypt were explicitly
> > requested as the crypto library to use, breaking the --enable-nettle and
> > --enable-gcrypt options. Re-add the logic to force usage of nettle or
> > gcrypt for crypto operations, while still keeping gnutls for TLS.
> > 
> > Fixes: c4b3d0074 (crypto: bump min gnutls to 3.7.5)
> > Signed-off-by: Luc Michel <luc.michel@amd.com>
> > ---
> > v2:
> >     - Revert more of c4b3d0074 to restore the gnutls_crypto logic to
> >       disable gnutls only for crypto ops but keep it for TLS [Daniel]
> > ---
> >   meson.build                    | 11 ++++++++++-
> >   crypto/cipher.c                |  2 +-
> >   tests/unit/test-crypto-block.c |  3 ++-
> >   crypto/meson.build             |  2 +-
> >   4 files changed, 14 insertions(+), 4 deletions(-)
> 
> I'm picking this up for 11.0.x stable series.
> Please let me know if I shouldn't.

That is good.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


