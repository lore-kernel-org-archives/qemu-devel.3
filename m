Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F657C27C53
	for <qemu-devel@archiver.kernel.org>; Wed, 12 Jun 2024 11:39:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHMJB-0004Gi-3Y; Wed, 12 Jun 2024 07:38:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHMJ9-0004GY-I3
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:38:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sHMJ7-0001FR-PY
 for qemu-devel@nongnu.org; Wed, 12 Jun 2024 07:38:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1718192304;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fD2pYojMAcurxn3tkreeI+FXSJvVJd7z1KH+PQ8ek8=;
 b=YEO/FI7ryu691hr4QHLN8HJaRbN+FKu8vuhia6BSHDlqN/z0+c3Y6aYpmw3ZRB/vIMIqmt
 hEfSY2+FIfh0LBk/IGc8FG5ySzQxRoNd5YYundQSh0NJhddXf5chY+ZIvdWpGVpCArTm4b
 94zLo4tNJg3cAGOwOv+CtsJfQKD2bxo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-589-tdsDymAeNCuRkt4T1SaJaA-1; Wed,
 12 Jun 2024 07:38:21 -0400
X-MC-Unique: tdsDymAeNCuRkt4T1SaJaA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A241C195608B; Wed, 12 Jun 2024 11:38:19 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.115])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 9CC2419560B1; Wed, 12 Jun 2024 11:38:17 +0000 (UTC)
Date: Wed, 12 Jun 2024 12:38:14 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: Alexander Monakov <amonakov@ispras.ru>, qemu-devel@nongnu.org,
 Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH 0/5] Reinstate ability to use Qemu on pre-SSE4.1 x86 hosts
Message-ID: <ZmmIpr5f0sQy-VGl@redhat.com>
References: <20240612105525.8795-1-amonakov@ispras.ru>
 <ZmmAq8fbJLuaX4Qg@redhat.com>
 <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CABgObfbGa=xpp9-cLwzqCpPFsf27qM+K-svfXEvc6ffjb=_VAg@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Wed, Jun 12, 2024 at 01:12:43PM +0200, Paolo Bonzini wrote:
> On Wed, Jun 12, 2024 at 1:04 PM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > On Wed, Jun 12, 2024 at 01:55:20PM +0300, Alexander Monakov wrote:
> > > Hello,
> > >
> > > I'm sending straightforward reverts to recent patches that bumped minimum
> > > required x86 instruction set to SSE4.2. The older chips did not stop working,
> > > and people still test and use new software on older hardware:
> > > https://sourceware.org/bugzilla/show_bug.cgi?id=31867
> > >
> > > Considering the very minor gains from the baseline raise, I'm honestly not
> > > sure why it happened. It seems better to let distributions handle that.
> >
> > Indeed distros are opinionated about the x86_64 baseline they want
> > to target.
> >
> > While RHEL-9 switched to a x86_64-v2 baseline, Fedora has repeatedly
> > rejected the idea of moving to an x86_64-v2 baseline, wanting to retain
> > full backwards compat. So this assumption in QEMU is preventing the
> > distros from satisfying their chosen build target goals.
> 
> I didn't do this because of RHEL9, I did it because it's silly that
> QEMU cannot use POPCNT and has to waste 2% of the L1 d-cache to
> compute the x86 parity flag (and POPCNT was introduced at the same
> time as SSE4.2).
> 
> Intel x86_64-v2 processors have been around for about 15 years, AMD
> for a little less (2011). I'd rather hear from users about the
> usecases for running QEMU on such old processors before reverting, as
> this does not get in the way of booting/installing distros on old
> machines. Unless QEMU is run from within the installation media, which
> it isn't, requiring a particular processor family does not prevent
> Fedora from being installable on pre-v2 processors.

This isn't anything to do with the distro installer. The use case is that
the distro wants all its software to be able to run on the x86_64 baseline
it has chosen to build with.

If we want to use POPCNT in the TCG code, can we not do a runtime check
and selectively build pieces of code with  __attribute__((target("popcnt"))),
as we've done historically for the bufferiszero.c code, rather than
changing the entire QEMU baseline ?


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


