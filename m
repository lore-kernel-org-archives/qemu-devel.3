Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B960CCF9F8
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 11:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEnMs-0006tP-0X; Fri, 31 Oct 2025 07:32:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEnMn-0006t1-Gn
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:32:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEnMT-0002B8-EW
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 07:32:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761910318;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eolKmLwocsTfgXp2C9WezaF/CHaLLSPtMAAbXtHWJjo=;
 b=FVc3065ZLoXvGeL/Uf+MOvkuDF/Wj1UTE7oC8fUGVxZTGspiKT8jzRyxsI4VBt5gJHMqTr
 urRHhkfzn5JmCOdvU8hT7Mcsq6JKN+cTtITQsHz49lz5WYQqUT+mbTLNrYz3xkbSVnDtrV
 /dhhEXMKcygjsBXnFQN16V0z8JHgPlg=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-216-1Glu2mfdPMGhGXSnFXW8Bg-1; Fri,
 31 Oct 2025 07:31:55 -0400
X-MC-Unique: 1Glu2mfdPMGhGXSnFXW8Bg-1
X-Mimecast-MFC-AGG-ID: 1Glu2mfdPMGhGXSnFXW8Bg_1761910314
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7B89B19541B7; Fri, 31 Oct 2025 11:31:54 +0000 (UTC)
Received: from redhat.com (dhcp-17-192.lcy.redhat.com [10.42.17.192])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 31E8A1955BE3; Fri, 31 Oct 2025 11:31:52 +0000 (UTC)
Date: Fri, 31 Oct 2025 11:31:50 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org
Subject: Re: [PATCH 12/21] crypto: introduce method for reloading TLS creds
Message-ID: <aQSeJm4g1Uka08cA@redhat.com>
References: <20251030144927.2241109-1-berrange@redhat.com>
 <20251030144927.2241109-13-berrange@redhat.com>
 <CAMxuvayxhJS2jDpkJNAtST1uLomrvmYX1upNkDTxKF26450rmg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvayxhJS2jDpkJNAtST1uLomrvmYX1upNkDTxKF26450rmg@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Thu, Oct 30, 2025 at 11:43:29PM +0400, Marc-André Lureau wrote:
> On Thu, Oct 30, 2025 at 6:49 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > This prevents direct access of the class members by the VNC
> > display code.
> >
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> >
> 
> Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> 
> 
> > ---
> >  crypto/tlscreds.c         | 15 +++++++++++++++
> >  include/crypto/tlscreds.h | 13 +++++++++++++
> >  ui/vnc.c                  |  9 +--------
> >  3 files changed, 29 insertions(+), 8 deletions(-)
> >
> > diff --git a/crypto/tlscreds.c b/crypto/tlscreds.c
> > index 49c7eb46a5..9433b4c363 100644
> > --- a/crypto/tlscreds.c
> > +++ b/crypto/tlscreds.c
> > @@ -281,6 +281,21 @@ char *qcrypto_tls_creds_get_priority(QCryptoTLSCreds
> > *creds)
> >  }
> >
> >
> > +bool qcrypto_tls_creds_reload(QCryptoTLSCreds *creds,
> > +                              Error **errp)
> > +{
> > +    QCryptoTLSCredsClass *credscls =
> > QCRYPTO_TLS_CREDS_GET_CLASS(OBJECT(creds));
> > +
> >
> 
> OBJECT() unnecessary here

Ah yes, will remove it.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


