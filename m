Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DAB4C71136
	for <qemu-devel@archiver.kernel.org>; Tue, 17 Jun 2025 15:54:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uRYdD-0005ne-0I; Tue, 17 Jun 2025 11:53:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRYL0-0002qa-WD
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 11:35:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1uRW6R-0006Ll-Pp
 for qemu-devel@nongnu.org; Tue, 17 Jun 2025 09:11:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1750165910;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=TmX6nmEvI7Ms4bUVabaXQ6EWUDSQ7Lp0GXusiqhJNjI=;
 b=c4bcNAp8a/cr9Jh634HIC2+X7r2azltea0FXsJTtxJ0JlXLTv2n6sy8Gx/rtG+k8z7+bZd
 4FD1GkeEGcnmrzunE74Rd98201zZwzK2g/+R8oC3zzG3EzDBi6utyi/dcVQP3jjO1s2Uma
 BkEvNlvZWE8HjVd6/VYqDH73rDdCsvc=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-587-5F87UhBxPMiBsk_vpAj8_Q-1; Tue,
 17 Jun 2025 09:11:46 -0400
X-MC-Unique: 5F87UhBxPMiBsk_vpAj8_Q-1
X-Mimecast-MFC-AGG-ID: 5F87UhBxPMiBsk_vpAj8_Q_1750165902
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BC34D18001D6; Tue, 17 Jun 2025 13:11:39 +0000 (UTC)
Received: from localhost (unknown [10.2.16.91])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 2EA7B180045B; Tue, 17 Jun 2025 13:11:33 +0000 (UTC)
Date: Tue, 17 Jun 2025 09:11:32 -0400
From: Stefan Hajnoczi <stefanha@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, "Michael S. Tsirkin" <mst@redhat.com>,
 qemu-ppc@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 Fam Zheng <fam@euphon.net>, Laurent Vivier <laurent@vivier.eu>,
 Hanna Reitz <hreitz@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Steven Lee <steven_lee@aspeedtech.com>, qemu-arm@nongnu.org,
 Michael Tokarev <mjt@tls.msk.ru>, qemu-block@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>,
 =?iso-8859-1?Q?Fr=E9d=E9ric?= Barrat <fbarrat@linux.ibm.com>,
 Rob Herring <robh@kernel.org>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Jamin Lin <jamin_lin@aspeedtech.com>, qemu-s390x@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Halil Pasic <pasic@linux.ibm.com>, Kevin Wolf <kwolf@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?iso-8859-1?Q?C=E9dric?= Le Goater <clg@kaod.org>,
 Klaus Jensen <its@irrelevant.dk>, Jeuk Kim <jeuk20.kim@samsung.com>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Andrew Jeffery <andrew@codeconstruct.com.au>,
 Jesper Devantier <foss@defmacro.it>, qemu-trivial@nongnu.org,
 Sven Schnelle <svens@stackframe.org>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Troy Lee <leetroy@gmail.com>, Joel Stanley <joel@jms.id.au>,
 Thomas Huth <thuth@redhat.com>, Hannes Reinecke <hare@suse.com>,
 Alistair Francis <alistair@alistair23.me>
Subject: Re: [PULL v2 00/31] Block patches
Message-ID: <20250617131132.GA115124@fedora>
References: <20250612174855.238493-1-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
 protocol="application/pgp-signature"; boundary="UnC7cfz1zSY4rnPy"
Content-Disposition: inline
In-Reply-To: <20250612174855.238493-1-stefanha@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -39
X-Spam_score: -4.0
X-Spam_bar: ----
X-Spam_report: (-4.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.89,
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


--UnC7cfz1zSY4rnPy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/10.1 for any user-visible changes.

--UnC7cfz1zSY4rnPy
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEEhpWov9P5fNqsNXdanKSrs4Grc8gFAmhRaYQACgkQnKSrs4Gr
c8hNdQf9EYHh872rurOBpw4KzZKK3ONgdH2SzUIUadGN0zwxCJYpHsOPbofxnV9c
UE44CCvAubzLy/oM+IlcVxEI2qALscoZpihh+nqoClbIoRdtwZWEuZmfbTQm3rIQ
OZ3pqupgr4empImY5EirdAp3jv/EfwTxp29BWyrJMHP0is4JjyioSi+9RuWKUPCW
YxR7wkxlUIIhCz8DOpgN32cBpFIta2n28EJMoW7RWIR5zIhs6pr7WjOw8rGTaqF9
XqnREHypwUNZU2LCYIRDceFCRdIFGOBBitvcaxnc+2ENN02bZTm3LppGsnDWEQwP
jC9u2Gt6qMN4EU+j/FRY/ejgYOI9xQ==
=kvUW
-----END PGP SIGNATURE-----

--UnC7cfz1zSY4rnPy--


