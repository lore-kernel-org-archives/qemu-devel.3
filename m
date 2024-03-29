Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69A4ACD1283
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Mar 2024 20:01:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rqIPE-0000fo-GO; Fri, 29 Mar 2024 16:00:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rqIPB-0000fY-5S
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 16:00:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rqIP9-00080W-FX
 for qemu-devel@nongnu.org; Fri, 29 Mar 2024 16:00:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711742445;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=t8PSV5KA0dAIi4aI8RMQQqNwtEfz4wiRVy3EfiDz4SY=;
 b=ch+Y7WuGItzLsycN8TT97nNnzjZ4s3iWoJH11weBSgmbGsRWr/E7dQtk28E+2k6eSDwCK6
 iUUlmuWgqubOvfTgCM/hfokOUhd7ctYd+VABt3ofjOMIS92RavLFp6DUmenHboXHZGmZMC
 zn7B4bnF5fzKtjdH5kKrxL/eaIlsMa8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-271-RS_qfvXlP2e5M36leFk05w-1; Fri, 29 Mar 2024 16:00:42 -0400
X-MC-Unique: RS_qfvXlP2e5M36leFk05w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E2A2E800264;
 Fri, 29 Mar 2024 20:00:41 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.9])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4A5DB1C060D0;
 Fri, 29 Mar 2024 20:00:41 +0000 (UTC)
Date: Fri, 29 Mar 2024 20:00:35 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel <qemu-devel@nongnu.org>, Michael Roth <michael.roth@amd.com>,
 "Maydell, Peter" <peter.maydell@linaro.org>
Subject: Re: Backdoor in xz, should we switch compression format for tarballs?
Message-ID: <Zgcd48BX078i0A-n@redhat.com>
References: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CABgObfbBSer0p3OnS7LKt53oWbWw-i=UponFGq5hQnb2rBE71w@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.099,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, Mar 29, 2024 at 06:59:30PM +0100, Paolo Bonzini wrote:
> For more info, see
> https://lwn.net/ml/oss-security/20240329155126.kjjfduxw2yrlxgzm@awork3.anarazel.de/
> but, essentially, xz was backdoored and it seems like upstream was directly
> responsible for this.
> 
> Based on this, should we switch our distribution from bz2+xz to bz2+zstd or
> bz2+lzip?

Based on the attack vector of pre-loading git with an exploit, but then
modifying the tarball to activate it, there's a bigger question of whether
users should really trust manually created tarballs at all ? You don't
anything about either the tarball creator, or the state of creators' machine,
even if it is signed. How can you trust that its contents is a faithful
representation of the tagged release from git it claims to be?

This issue could prompt a push towards distros only handling tarballs
directly auto-generated from a git tag, in a reliably reproducible manner.

Obviously you couldn't actually trust the upstream maintainer in this
case, but at least if you're using a reproducible git tarball you can
verify every link in the chain right through each git commit, and don't
have this manual tarball whose contents need to be to picked apart.

TL;DR; I think we should consider our tarball distribution options, but
lets wait for the dust to settle and not rush into decisions.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


