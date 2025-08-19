Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D153CCA0EEB
	for <qemu-devel@archiver.kernel.org>; Tue, 19 Aug 2025 19:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uoSMY-0006w3-Hw; Tue, 19 Aug 2025 15:51:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSMX-0006vi-1r
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:51:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uoSMV-0001ob-GP
 for qemu-devel@nongnu.org; Tue, 19 Aug 2025 15:51:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755633074;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jRVF0Vp1IuEBTfX65I6J766XjWpTlpg5NZ84eDy5fgs=;
 b=eaP+l3vT89Gwl9PQZecGBgOH0z+LN0f2askisuPkFJk0iliMAFUdZh+2SQ4/k0PvLiQvXM
 fU1C0khpmWgX4E0Uz/N4xIMbhRmPu7Nwh3D2cBw4Slm7bMNmCDd7yCAH4rtE6C0VST+BDM
 w4WLheCbPri75xNlduZXHXzi3qQUyJs=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-491-FGkDmw9sOR26WLjlIlXk7Q-1; Tue,
 19 Aug 2025 15:51:12 -0400
X-MC-Unique: FGkDmw9sOR26WLjlIlXk7Q-1
X-Mimecast-MFC-AGG-ID: FGkDmw9sOR26WLjlIlXk7Q_1755633071
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 82A8C180034A; Tue, 19 Aug 2025 19:51:10 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.237])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id C034A3000198; Tue, 19 Aug 2025 19:51:06 +0000 (UTC)
Date: Tue, 19 Aug 2025 20:51:03 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: John Snow <jsnow@redhat.com>
Cc: qemu-devel@nongnu.org, Hanna Reitz <hreitz@redhat.com>,
 Jagannathan Raman <jag.raman@oracle.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Thomas Huth <thuth@redhat.com>, Cleber Rosa <crosa@redhat.com>,
 qemu-block@nongnu.org, Kevin Wolf <kwolf@redhat.com>,
 "Richard W.M. Jones" <rjones@redhat.com>
Subject: Re: [PATCH 01/14] python: Replace asyncio.get_event_loop for Python
 3.14
Message-ID: <aKTVpwZjz_GQuteM@redhat.com>
References: <20250715143023.1851000-1-berrange@redhat.com>
 <20250715143023.1851000-2-berrange@redhat.com>
 <CAFn=p-bVmn_N4hWBnYtNhhdHHYEh4j0zVBHnXFtJVQK5GDRaJw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFn=p-bVmn_N4hWBnYtNhhdHHYEh4j0zVBHnXFtJVQK5GDRaJw@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Aug 19, 2025 at 03:47:50PM -0400, John Snow wrote:
> On Tue, Jul 15, 2025 at 10:30 AM Daniel P. Berrangé <berrange@redhat.com> wrote:
> >
> > From: Richard W.M. Jones <rjones@redhat.com>
> >
> > In Python 3.14, no asyncio event loop gets generated automatically.
> > Instead create one when we need it.  This should work with Python 3.13
> > as well.  This change was suggested here:
> >
> > https://bugzilla.redhat.com/show_bug.cgi?id=2375004#c4
> >
> > See-also: https://docs.python.org/3.14/whatsnew/3.14.html#id7
> > Thanks: Miro Hrončok, Daniel P. Berrangé
> > Signed-off-by: Richard W.M. Jones <rjones@redhat.com>
> 
> Reviewed-by: John Snow <jsnow@redhat.com>
> 
> We fixed this in the standalone tree, but I hadn't synchronized the
> changes over yet. Shall we take your patches first, and then I'll
> worry about synchronizing later?

This really needs to be in 10.1.0, because tests crash and
burn under python 3.14 without this - we're applying this
in Fedora builds locally to deal with the brokeness.

> (I desperately need to drop this code from the qemu.git tree, urgh.)

IMHO qemu.git should be considered authoritative right now because
that's what we're actually shipping & thus take priority for merge.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


