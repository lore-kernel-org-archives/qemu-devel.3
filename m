Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38534606A200
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Nov 2026 17:43:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SbGqzGo8
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xRYpB-0003Mo-7U; Thu, 12 Nov 2026 12:43:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRYp2-0003MI-Cz
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:42:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1xRYp0-0000DR-8d
 for qemu-devel@nongnu.org; Thu, 12 Nov 2026 12:42:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794505368;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GZSn4tw2ZtZjhTVwyPjEJLJT4Xk87zWMtE30Gw/ubMc=;
 b=SbGqzGo8vuk9UbP5a7692x1GN1TAUxTw5JSSVU8Zi1MrUhP1J99vvF6ahje1h4suPGAfTO
 K3HccO1Ds+Qd6UO3tkLO24xVtv+pJYsLYCDydeeCg4KE8u8FcPiYqi2tkn55tDHGwjHUj5
 90eQlkz8yD/rkn0dkuaRnd0Zo+yKjLw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-122-yoE75EssNL2_D1hM_B9vkg-1; Thu,
 12 Nov 2026 12:42:46 -0500
X-MC-Unique: yoE75EssNL2_D1hM_B9vkg-1
X-Mimecast-MFC-AGG-ID: yoE75EssNL2_D1hM_B9vkg_1794505365
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 909CB18004F7
 for <qemu-devel@nongnu.org>; Thu, 12 Nov 2026 17:42:45 +0000 (UTC)
Received: from redhat.com (headnet04.pony-001.prod.iad2.dc.redhat.com
 [10.2.32.116])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86C1B1956095; Thu, 12 Nov 2026 17:42:44 +0000 (UTC)
Date: Thu, 12 Nov 2026 17:42:41 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: marcandre.lureau@redhat.com
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH v2 1/2] crypto: avoid overwriting Error object erasing
 keyslot
Message-ID: <avX6kV6GMYSXtsID@redhat.com>
References: <20261026111237.660633-1-berrange@redhat.com>
 <20261026111237.660633-2-berrange@redhat.com>
 <179311125460.913211.3496484666027902541.b4-review@b4>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <179311125460.913211.3496484666027902541.b4-review@b4>
User-Agent: Mutt/2.4.3 (2026-10-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-22.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Tue, Oct 27, 2026 at 06:27:34PM +0400, marcandre.lureau@redhat.com wrote:
> > When erasing a keyslot we deliberately ignore some errors and
> > carry on trying to erase as much as possible. This results in
> > overwriting Error objects and triggering an assertion. Don't
> > pass in the &local_err, if errp is already set.
> > 
> > Fixes: https://gitlab.com/qemu-project/qemu/-/work_items/4697
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > Message-ID: <20261026111237.660633-2-berrange@redhat.com>
> > ---
> >  crypto/block-luks.c | 2 ++
> >  1 file changed, 2 insertions(+)
> >
> > diff --git a/crypto/block-luks.c b/crypto/block-luks.c
> > index 0926ad28f0cd..277a51106072 100644
> > --- a/crypto/block-luks.c
> > +++ b/crypto/block-luks.c
> > @@ -1152,6 +1152,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
> >  
> >      if (ret < 0) {
> >          error_propagate(errp, local_err);
> > +        local_err = NULL;
> >      }
> >      /*
> >       * Now try to erase the key material, even if the header
> > @@ -1169,6 +1170,7 @@ qcrypto_block_luks_erase_key(QCryptoBlock *block,
> >              if (i > 0) {
> >                  return -1;
> >              }
> > +            local_err = NULL;
> 
> This is the recoverable path: the comment says we still write zeros and
> carry on, so a first-iteration random failure is not meant to be fatal. But
> error_propagate(errp, local_err) has just stored that error in *errp.
> 
> Keep the first-iteration failure as non-fatal but do not hand it to errp?
> (e.g. error_free(local_err) instead of error_propagate() when i == 0)

From the POV of the caller, we always want to report an error back
to them. We just want to try todo as much erasing as possible, even
when we're reporting an error. So don't think of this as a recover
from error sucess path. It is still a fatal error overall.


With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


