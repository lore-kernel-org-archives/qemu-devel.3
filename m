Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2084DCCD199
	for <qemu-devel@archiver.kernel.org>; Mon, 20 Oct 2025 11:23:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vAnyT-0004ch-GG; Mon, 20 Oct 2025 07:22:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAnyR-0004c6-Ay
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:22:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vAnyO-0007Ei-0Z
 for qemu-devel@nongnu.org; Mon, 20 Oct 2025 07:22:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1760959363;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Bw5wI8Cdfh2NdDWKH0I8UFb2+F2bLkh/qyJGWki94Mk=;
 b=AqfOpZrOGeZBRVz20Hpr5lnOCHzyXKCIsGGKwmOTUpx24C0BZPDXa4SHRNh9qRhpPFxRuN
 ngPHEfeZRzqHH7z0EQLBAplk7O0zmV757yA7ltnDRdMQpIoPiuvtCORfgqia/g4AFtZ1JA
 yMvGoYuATIuVbazexR57/8alJwTkLts=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-590-e_4VfOTAP-m2J0-MXkGYYg-1; Mon,
 20 Oct 2025 07:22:41 -0400
X-MC-Unique: e_4VfOTAP-m2J0-MXkGYYg-1
X-Mimecast-MFC-AGG-ID: e_4VfOTAP-m2J0-MXkGYYg_1760959360
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id AD82C1800669; Mon, 20 Oct 2025 11:22:40 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.161])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 895931800578; Mon, 20 Oct 2025 11:22:39 +0000 (UTC)
Date: Mon, 20 Oct 2025 12:22:36 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Eric Blake <eblake@redhat.com>
Cc: qemu-devel@nongnu.org, matoro <matoro_mailinglist_qemu@matoro.tk>
Subject: Re: [PATCH v2 3/6] crypto: allow client/server cert chains
Message-ID: <aPYbfNkO6Jdo2gDt@redhat.com>
References: <20250919101022.1491007-1-berrange@redhat.com>
 <20250919101022.1491007-4-berrange@redhat.com>
 <jczraatcitsz3tf5aznkeaiffanysz4dlvn7opoyibofvr2loj@u3wumm3rwdq5>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jczraatcitsz3tf5aznkeaiffanysz4dlvn7opoyibofvr2loj@u3wumm3rwdq5>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Thu, Oct 16, 2025 at 10:28:59AM -0500, Eric Blake wrote:
> On Fri, Sep 19, 2025 at 11:10:19AM +0100, Daniel P. Berrangé wrote:
> > From: matoro <matoro@users.noreply.github.com>
> 
> The CC: line has a different email address for matoro than the git
> author attribution.  Does that matter?  I'm not a fan of github's
> attempt to make it difficult to reach a contributor outside the github
> walled garden.
> 
> > 
> > The existing implementation assumes that client/server certificates are
> > single individual certificates.  If using publicly-issued certificates,
> > or internal CAs that use an intermediate issuer, this is unlikely to be
> > the case, and they will instead be certificate chains.  While this can
> > be worked around by moving the intermediate certificates to the CA
> > certificate, which DOES currently support multiple certificates, this
> > instead allows the issued certificate chains to be used as-is, without
> > requiring the overhead of shuffling certificates around.
> > 
> > Corresponding libvirt change is available here:
> > https://gitlab.com/libvirt/libvirt/-/merge_requests/222
> > 
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Signed-off-by: matoro <matoro_mailinglist_qemu@matoro.tk>
> > [DB: adapted for code conflicts with multi-CA patch]
> > Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> > ---
> >  crypto/tlscredsx509.c                 | 156 ++++++++++++--------------
> >  tests/unit/test-crypto-tlscredsx509.c |  77 +++++++++++++
> >  2 files changed, 147 insertions(+), 86 deletions(-)
> 
> >  
> > -static gnutls_x509_crt_t
> > -qcrypto_tls_creds_load_cert(QCryptoTLSCredsX509 *creds,
> > -                            const char *certFile,
> > -                            bool isServer,
> > -                            Error **errp)
> > -{
> 
> > -
> >  static int
> > -qcrypto_tls_creds_load_ca_cert_list(QCryptoTLSCredsX509 *creds,
> > -                                    const char *certFile,
> > -                                    gnutls_x509_crt_t **certs,
> > -                                    unsigned int *ncerts,
> > -                                    Error **errp)
> > +qcrypto_tls_creds_load_cert_list(QCryptoTLSCredsX509 *creds,
> > +                                 const char *certFile,
> > +                                 gnutls_x509_crt_t **certs,
> > +                                 unsigned int *ncerts,
> > +                                 bool isServer,
> > +                                 bool isCA,
> > +                                 Error **errp)
> >  {
> 
> Nice consolidation to reduce duplication.
> 
> > @@ -520,41 +497,48 @@ qcrypto_tls_creds_x509_sanity_check(QCryptoTLSCredsX509 *creds,
> 
> >  
> > -    if (cert &&
> > -        qcrypto_tls_creds_check_cert(creds,
> > -                                     cert, certFile, isServer,
> > -                                     false, errp) < 0) {
> > -        goto cleanup;
> > +    for (i = 0; i < ncerts; i++) {
> > +        if (qcrypto_tls_creds_check_cert(creds,
> > +                                         certs[i], certFile,
> > +                                         isServer, (i != 0), errp) < 0) {
> 
> The () around 'i != 0' look extraneous to me; but that's trivial
> formatting so I'm not opposed to keeping them.  On the other hand...

Yeah, I'll loose the ()

> 
> > +            goto cleanup;
> > +        }
> >      }
> >  
> > -    if (cert &&
> > -        qcrypto_tls_creds_check_authority_chain(creds, cert,
> > +    if (ncerts &&
> 
> ...here you are doing an implicit conversion of ncerts to bool; why
> not do the same implicit conversion of 'i' rather than explicit '(i !=
> 0)' above?

IMHO using an int in a conditional expression  "if (<int vriable>)"
has pretty clear intent.

Passing an int to a parameter that expects a bool could just as easily be
indicative of a code bug, as it could be intentionally relying on the
type conversion. IOW, it has fuzzy intent.

So although I didn't write this patch, I would be inclined to write it
the same way it is done here.

> 
> Reviewed-by: Eric Blake <eblake@redhat.com>

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


