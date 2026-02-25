Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25359FD376A
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 16:31:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvHmz-0005Z7-7Z; Wed, 25 Feb 2026 11:31:05 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHmt-0005XM-2m
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:30:59 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1vvHmr-0007WM-3s
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 11:30:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772037056;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ClgSxeuFhUQzYfRzqi7d1Wd0mr8wO4ohV0hokfoR0ko=;
 b=X4kzRKkbELgFlx+DFM2KMG5n7GJS7gWxXcsP/sph/JbXmiBf/IR1p173mSAo5L6oCo+4xN
 Ert14MadLNdH5tsW6sIkHm6EGE8nL6UYj3d46kr5pY+tPAyln+xlys/2cC95xVIIUo3hGB
 ZB/jEDrCbeCnr7jXlS6mNhhpY1xIFzQ=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-648-NiAAncytPLKS1jO3Fim0WQ-1; Wed,
 25 Feb 2026 11:30:40 -0500
X-MC-Unique: NiAAncytPLKS1jO3Fim0WQ-1
X-Mimecast-MFC-AGG-ID: NiAAncytPLKS1jO3Fim0WQ_1772037037
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D4511800282; Wed, 25 Feb 2026 16:30:37 +0000 (UTC)
Received: from redhat.com (unknown [10.45.225.165])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 005611800361; Wed, 25 Feb 2026 16:30:31 +0000 (UTC)
Date: Wed, 25 Feb 2026 16:30:28 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Stefan Weil <sw@weilnetz.de>, "Dr. David Alan Gilbert" <dave@treblig.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, devel@lists.libvirt.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 qemu-block@nongnu.org, qemu-rust@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Gerd Hoffmann <kraxel@redhat.com>,
 Christian Schoenebeck <qemu_oss@crudebyte.com>,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v6 26/27] util: add support for formatting thread info in
 messages
Message-ID: <aZ8jpGpOWXf_lByk@redhat.com>
References: <20260211152508.732487-1-berrange@redhat.com>
 <20260211152508.732487-27-berrange@redhat.com>
 <CAFEAcA-08J-_dn22s858QtUPV32VM4OuAEgBV-WdmGGxvJSu0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-08J-_dn22s858QtUPV32VM4OuAEgBV-WdmGGxvJSu0w@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
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

On Thu, Feb 19, 2026 at 10:29:56AM +0000, Peter Maydell wrote:
> On Wed, 11 Feb 2026 at 15:29, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > After:
> >
> >   # qemu-system-x86_64 -object tls-creds-x509,id=t0,dir=fish -d 'trace:qcrypto*'
> >   qemu-system-x86_64: (772366:main): qcrypto_tls_creds_x509_load TLS creds x509 load creds=0x560db818e080 dir=fish
> >   qemu-system-x86_64: (772366:main): qcrypto_tls_creds_get_path TLS creds path creds=0x560db818e080 filename=ca-cert.pem path=<none>
> >   qemu-system-x86_64: (772366:main): Unable to access credentials fish/ca-cert.pem: No such file or directory
> 
> Even more output enabled by default that is pretty useless for most
> uses of tracepoints and debug logging :-(

Getting the thread info in qemu log output was the original primary
motivating factor in this series. This short example doesn't show
it, but when debugging/tracing QEMU it is pretty important to
understand which messages are coming from different threads, so we
can correctly interpret the control flow. Pretty much every logging
framework these days will include some thread identifier by default,
and IMHO it is reasonable to do this by default in QEMU too.

There was a proposal a while back on the list to add stack trace
dumps to qemu_log output to allow threads to be distinguished, which
obviously could never be enabled by default. The short thread ident
info was something that could be unconditionally enabled so we get
more useful info from users reporting bugs without having to go
back and ask them to re-do the log collection with more options.

With regards,
Daniel
-- 
|: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
|: https://libvirt.org          ~~          https://entangle-photo.org :|
|: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|


