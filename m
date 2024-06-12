Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 864ACC27C77
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 16:25:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHQm1-0000Zk-3M; Wed, 12 Jun 2024 12:24:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHQly-0000Z1-Nb
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 12:24:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHQlx-0005nb-1b
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 12:24:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718209467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jh9Hc6oq55B/+hrDwJrPLVgsQ/OcTyxzkj+mcrrusQs=;
 b=eZ+PctclAXLwJ4CFz3fUS7hbidqN+O+TIxryt3C/tWY6PL4NJSTAC2cKvrVxHQXbmcTP1i
 dZAf4/wvw46EhwTrGzqv9Mh6OwsYefRGuXX0/hdG8yLCH9kqND4IKH3qOglePCytd5xcR3
 egEpLpRaEafkrSkkmCfHVTdVbPhK6vM=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-401-oOQy5q7NMWO8ldP7n7QhbQ-1; Wed,
 12 Jun 2024 12:24:26 -0400
X-MC-Unique: oOQy5q7NMWO8ldP7n7QhbQ-1
Received: from mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.40])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 308191955DE9; Wed, 12 Jun 2024 16:24:24 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C4C619560AD; Wed, 12 Jun 2024 16:24:21 +0000 (UTC)
Date: Wed, 12 Jun 2024 17:24:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alexander Monakov <amonakov@ispras.ru>
Cc: Paolo Bonzini <pbonzini@redhat.com>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
Message-ID: <ZmnLslPKftkPUkWI@redhat.com>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
 <ZmmIpr5f0sQy-VGl@redhat.com>
 <CABgObfZHBGxS-D9LdM1v0oDXBHoKm2-A4FknixmqjfJeQR1YLw@mail.gmail.com>
 <ZmmSxq7i_tpYj7tw@redhat.com> <Zmm6Kf8PEwZ47bMb@redhat.com>
 <59f923eb-1925-8c22-e83a-8703fbf60b7f@ispras.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <59f923eb-1925-8c22-e83a-8703fbf60b7f@ispras.ru>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.40
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 11
X-Spam_score: 1.1
X-Spam_bar: +
X-Spam_report: (1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.143,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=no autolearn_force=no
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

On Wed, Jun 12, 2024 at 06:40:09PM +0300, Alexander Monakov wrote:
> 
> On Wed, 12 Jun 2024, Daniel P. Berrangé wrote:
> 
> > I learnt that FESCo approved a surprisingly loose rule saying
> > 
> >   "Libraries packaged in Fedora may require ISA extensions,
> >    however any packaged application must not crash on any
> >    officially supported architecture, either by providing
> >    a generic fallback implementation OR by cleanly exiting
> >    when the requisite hardware support is unavailable."
> > 
> > This might suggest we could put a runtime feature check in main(),
> > print a warning and then exit(1), however, QEMU has alot of code
> > that is triggered from ELF constructors. If we're building the
> > entire of QEMU codebase with extra features enabled, I worry that
> > the constructors could potentially cause a illegal instruction
> > crash before main() runs ?
> 
> Are you literally suggesting to find a solution that satisfies the letter
> of Fedora rules, and not what's good for the spirit of a wider community.

I'm interested in exploring what the options are. Personally I still
think QEMU ought to maintain compat with the original x86_64 ABI, since
very few distros have moved to requiring -v2, but if that doesn't happen
I want to understand the implications for Fedora since that's where I'm
a maintainer.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


