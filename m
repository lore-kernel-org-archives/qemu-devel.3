Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 192EFCCF9E3
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Oct 2025 15:33:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vEUcz-0004C1-Hw; Thu, 30 Oct 2025 11:31:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEUcv-0004BR-Cf
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:31:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vEUch-00087j-9t
 for qemu-devel@nongnu.org; Thu, 30 Oct 2025 11:31:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761838290;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=biTNZPlrP2yAFyV1mDgczKGO6Nj6ewKnoCU7WGDDPR0=;
 b=YRCVDCfVRHV5nbX5LozDWa60hWfmqSPoGJ+LG308yix6gfQ2KUXirlyZ7KfvpX9jcSWcpc
 /luc12y0lR9IUzpjW42gGrcXmZybRJEg5Kzesp5DAdiAf09NIAsz+Dx8U/gAYldU9TOJ2P
 7ntNr4DWGUU7H9eH3WNvxbKU2gi8xe0=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-596-9U8juUmKNhWly9RpS1M_zg-1; Thu,
 30 Oct 2025 11:31:25 -0400
X-MC-Unique: 9U8juUmKNhWly9RpS1M_zg-1
X-Mimecast-MFC-AGG-ID: 9U8juUmKNhWly9RpS1M_zg_1761838284
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1838B187DED8; Thu, 30 Oct 2025 15:31:01 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.122])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 909D1180057C; Thu, 30 Oct 2025 15:30:59 +0000 (UTC)
Date: Thu, 30 Oct 2025 15:30:56 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 devel@lists.libvirt.org
Subject: Re: [PATCH 00/21] crypto: support multiple parallel certificate
 identities
Message-ID: <aQOEsB71Sc2WQX0d@redhat.com>
References: <20251030144805.2239954-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20251030144805.2239954-1-berrange@redhat.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Sorry, this series aborted during mail sending so is incomplete.

See the immediately following re-post for the full set of 21 patches

On Thu, Oct 30, 2025 at 02:47:44PM +0000, Daniel P. Berrangé wrote:
> This series aims to improve the support for post-quantum cryptography
> in TLS connections by allowing  multiple sets of certificates to be
> loaded. The idea is that during a transition period servers will have
> a traditional RSA based certificate in parallel with an MLDSA based
> certificate for PQC, and the right one will be dynamically determined
> during the TLS handshake.
> 
> The first 12 patches are trivial cleanups.
> 
> The next 3 patches fix a potential use-after-free problem
> 
> The last patches introduce support for multiple certificates.
> 
> NB, in terms of testing this will require either CentOS Stream 10,
> or Fedora 43. Most other distros will not support PQC out of the
> box at this time even if they have new enough gnutls, since they
> don't make use of the crypto-policies package which is needed to
> enable PQC by default.
> 
> Daniel P. Berrangé (21):
>   crypto: remove redundant parameter checking CA certs
>   crypto: add missing free of certs array
>   crypto: replace stat() with access() for credential checks
>   crypto: remove redundant access() checks before loading certs
>   crypto: move check for TLS creds 'dir' property
>   crypto: use g_autofree when loading x509 credentials
>   crypto: remove needless indirection via parent_obj field
>   crypto: move release of DH parameters into TLS creds parent
>   crypto: shorten the endpoint == server check in TLS creds
>   crypto: remove duplication loading x509 CA cert
>   crypto: reduce duplication in handling TLS priority strings
>   crypto: introduce method for reloading TLS creds
>   crypto: introduce a wrapper around gnutls credentials
>   crypto: fix lifecycle handling of gnutls credentials objects
>   crypto: make TLS credentials structs private
>   crypto: deprecate use of external dh-params.pem file
>   crypto: avoid loading the CA certs twice
>   crypto: avoid loading the identity certs twice
>   crypto: expand logic to cope with multiple certificate identities
>   crypto: support upto 5 parallel certificate identities
>   docs: creation of x509 certs compliant with post-quantum crypto
> 
>  crypto/meson.build                    |   5 +-
>  crypto/tlscreds.c                     |  77 ++--
>  crypto/tlscredsanon.c                 |  62 +--
>  crypto/tlscredsbox.c                  | 101 +++++
>  crypto/tlscredsbox.h                  |  46 ++
>  crypto/tlscredspriv.h                 |  36 +-
>  crypto/tlscredspsk.c                  |  64 ++-
>  crypto/tlscredsx509.c                 | 592 +++++++++++++++++---------
>  crypto/tlssession.c                   | 139 ++----
>  crypto/trace-events                   |   1 +
>  docs/about/deprecated.rst             |   9 +
>  docs/system/tls.rst                   | 134 +++++-
>  include/crypto/tlscreds.h             |  26 ++
>  include/crypto/tlscredsx509.h         |   6 +
>  tests/unit/test-crypto-tlscredsx509.c |   8 +-
>  ui/vnc.c                              |   9 +-
>  16 files changed, 849 insertions(+), 466 deletions(-)
>  create mode 100644 crypto/tlscredsbox.c
>  create mode 100644 crypto/tlscredsbox.h
> 
> -- 
> 2.51.1
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


