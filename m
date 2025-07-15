Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD4BCC83F22
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 16:41:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubiiB-0003M8-Ew; Tue, 15 Jul 2025 12:41:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubiDx-0005es-Kz
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:09:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1ubiDu-0003aM-43
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 12:09:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752595780;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0PqXR5KI6cEIFlFub2JJxd8sveEMDM4intMl0IjxjA=;
 b=UDayi3jE7hqxCsjhXf7sgkTv122Rax8eEczJ3oH3tBI1t+3kxmSVSvo31sFavtlwWhOiFv
 iJC0scNWDVwsZA5PqtTCXRNYVTrOhKhUSute6R7iCIFmlWrWmWVi3eoCjCsqDtXCFOsA3n
 0yXSd2+63n+jSCkwIXLS+rjw4t0+Nns=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-553-BxwDQlSfOvKKQE9eN5FtWA-1; Tue,
 15 Jul 2025 12:09:37 -0400
X-MC-Unique: BxwDQlSfOvKKQE9eN5FtWA-1
X-Mimecast-MFC-AGG-ID: BxwDQlSfOvKKQE9eN5FtWA_1752595776
Received: from mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.15])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 613EA19560A5; Tue, 15 Jul 2025 16:09:36 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.173])
 by mx-prod-int-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EBE40195609D; Tue, 15 Jul 2025 16:09:34 +0000 (UTC)
Date: Tue, 15 Jul 2025 17:09:31 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org, matoro <matoro_mailinglist_qemu@matoro.tk>
Subject: Re: [PATCH 7/7] crypto: allow client/server cert chains
Message-ID: <aHZ9O5N67rfnJ9SB@redhat.com>
References: <20250715092932.1395271-1-berrange@redhat.com>
 <20250715092932.1395271-8-berrange@redhat.com>
 <fa670d22-d882-409c-af3d-1669d6386800@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fa670d22-d882-409c-af3d-1669d6386800@linaro.org>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.15
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Tue, Jul 15, 2025 at 11:46:31AM +0200, Philippe Mathieu-Daudé wrote:
> On 15/7/25 11:29, Daniel P. Berrangé wrote:
> > From: matoro <matoro@users.noreply.github.com>
> 
> Should we use <matoro_mailinglist_qemu@matoro.tk> here?

I generally don't like to change the git metadata that a user
submits with unless it is clearly broken, which I don't think
is the case here.

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
> >   crypto/tlscredsx509.c                 | 157 ++++++++++++--------------
> >   tests/unit/test-crypto-tlscredsx509.c |  77 +++++++++++++
> >   2 files changed, 147 insertions(+), 87 deletions(-)
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


