Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F476C531CF
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 12:50:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmssd-0001lM-2w; Thu, 23 Jul 2026 08:50:27 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmssb-0001l9-Dr
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:50:25 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1wmssZ-0001Rp-Jp
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 08:50:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784811022;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LbPNXoP9r2s8ahTbGwObJE1tvq9S15xgV3E13O8EbC0=;
 b=EWKDKiFIyeWQ6mmtWSGjxw3bipLeV8xCVPL9Zq2E5MNUD9CbN8xsf5SpsoY2oc5lNIAkSL
 n0cKrrU4yMfkpwnjaP5Ed+ey/8HVw4yrmPMjPCm98Blomw+YhUj2g24Rf+p4YaszkATUkH
 4JKpK9/T0ovFYRXzMLpPZpMOAjYe48c=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-hHmdmQcNPYm7M366WfAfzg-1; Thu,
 23 Jul 2026 08:49:11 -0400
X-MC-Unique: hHmdmQcNPYm7M366WfAfzg-1
X-Mimecast-MFC-AGG-ID: hHmdmQcNPYm7M366WfAfzg_1784810949
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 15BB119775EB; Thu, 23 Jul 2026 12:49:08 +0000 (UTC)
Received: from redhat.com (unknown [10.44.32.196])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4764818002A0; Thu, 23 Jul 2026 12:48:59 +0000 (UTC)
Date: Thu, 23 Jul 2026 13:48:55 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Jamin Lin <jamin_lin@aspeedtech.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@kaod.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Steven Lee <steven_lee@aspeedtech.com>,
 Troy Lee <leetroy@gmail.com>, Kane Chen <kane_chen@aspeedtech.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Joel Stanley <joel@jms.id.au>, Eric Blake <eblake@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "open list:All patches CC here" <qemu-devel@nongnu.org>,
 "open list:ASPEED BMCs" <qemu-arm@nongnu.org>,
 Troy Lee <troy_lee@aspeedtech.com>
Subject: Re: [PATCH v2 07/17] crypto/cipher: Add GCM to QCryptoCipherMode
Message-ID: <amINt0SKk2u-uqG1@redhat.com>
References: <20260715033311.1648424-1-jamin_lin@aspeedtech.com>
 <20260715033311.1648424-8-jamin_lin@aspeedtech.com>
 <87o6g8j1nm.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o6g8j1nm.fsf@pond.sub.org>
User-Agent: Mutt/2.4.0 (2026-06-19)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: permerror client-ip=170.10.133.124;
 envelope-from=berrange@redhat.com; helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 3
X-Spam_score: 0.3
X-Spam_bar: /
X-Spam_report: (0.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.951,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 T_SPF_PERMERROR=0.01 autolearn=no autolearn_force=no
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

On Wed, Jul 15, 2026 at 06:51:41AM +0200, Markus Armbruster wrote:
> Jamin Lin <jamin_lin@aspeedtech.com> writes:
> 
> > Introduce the GCM cipher mode so authenticated encryption can be built
> > on top of the existing qcrypto_cipher API. GCM is an IV-based mode, so
> > register it in mode_need_iv. No backend advertises it yet, so it stays
> > unsupported until a backend and the AAD/tag helpers are added in the
> > following patches.
> >
> > Signed-off-by: Jamin Lin <jamin_lin@aspeedtech.com>
> > Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>
> > Acked-by: Daniel P. Berrangé <berrange@redhat.com>
> 
> Same person giving Reviewed-by and Acked-by is odd.  Daniel, is this
> what you want?

Acked-by in the sense that as crypto subsys maintainer, I'm happy for
it to be merged by aspeed/arm maintainer as part of this series.

> 
> > ---
> >  qapi/crypto.json | 4 +++-
> >  crypto/cipher.c  | 1 +
> >  2 files changed, 4 insertions(+), 1 deletion(-)
> >
> > diff --git a/qapi/crypto.json b/qapi/crypto.json
> > index 2b55befef9..6e3a98ff68 100644
> > --- a/qapi/crypto.json
> > +++ b/qapi/crypto.json
> > @@ -121,10 +121,12 @@
> >  #
> >  # @ctr: Counter (Since 2.8)
> >  #
> > +# @gcm: Galois/Counter Mode (Since 11.2)
> > +#
> >  # Since: 2.6
> >  ##
> >  { 'enum': 'QCryptoCipherMode',
> > -  'data': ['ecb', 'cbc', 'xts', 'ctr']}
> > +  'data': ['ecb', 'cbc', 'xts', 'ctr', 'gcm']}
> >  
> >  ##
> >  # @QCryptoIVGenAlgo:
> 
> Acked-by: Markus Armbruster <armbru@redhat.com>
> 
> 
> [...]
> 

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


