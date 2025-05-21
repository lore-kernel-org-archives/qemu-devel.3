Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13785C54E71
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 15:39:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHlWW-0007kN-B1; Wed, 21 May 2025 11:38:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHlWN-0007jG-Rp
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:38:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1uHlWL-0005lM-H4
 for qemu-devel@nongnu.org; Wed, 21 May 2025 11:38:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747841895;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=QkPgWZNcU+OqVl8Pjj5kWpwum/G2qsNBSEgRtMibbfE=;
 b=OuevJGmD7RhkP8ooyvhuqbKPYpzfXEB3yHByBJ7N88n02pX6NmPVSTAd/VKu48KpxfXc7Q
 FHVQm1+gT6m2c/JTTDaMT6vq+hbmtzJknQlGOFHSsQt8Lz3iwrJTiPRKc4dLecYTf+r7bb
 pVC2zHqdG2MGkHxxV0uddeJqs2M1R3Y=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-YTyPHlwkPIiwWQ3UF61MnA-1; Wed,
 21 May 2025 11:38:12 -0400
X-MC-Unique: YTyPHlwkPIiwWQ3UF61MnA-1
X-Mimecast-MFC-AGG-ID: YTyPHlwkPIiwWQ3UF61MnA_1747841889
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 98859180048E; Wed, 21 May 2025 15:38:06 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.129])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 399BB18003FC; Wed, 21 May 2025 15:37:54 +0000 (UTC)
Date: Wed, 21 May 2025 16:37:51 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Ilya Leoshkevich <iii@linux.ibm.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Weiwei Li <liwei1518@gmail.com>,
 qemu-arm@nongnu.org, Nicholas Piggin <npiggin@gmail.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Bin Meng <bmeng.cn@gmail.com>, Tyrone Ting <kfting@nuvoton.com>,
 Hao Wu <wuhaotsh@google.com>, Kyle Evans <kevans@freebsd.org>,
 Alistair Francis <alistair.francis@wdc.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Laurent Vivier <laurent@vivier.eu>, Riku Voipio <riku.voipio@iki.fi>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Alexandre Iooss <erdnaxe@crans.org>,
 Laurent Vivier <lvivier@redhat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Warner Losh <imp@bsdimp.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Palmer Dabbelt <palmer@dabbelt.com>,
 Mahmoud Mandour <ma.mandourr@gmail.com>, qemu-ppc@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, qemu-rust@nongnu.org,
 qemu-riscv@nongnu.org
Subject: Re: [PATCH v2 11/17] gdbstub: Try unlinking the unix socket before
 binding
Message-ID: <aC3zT7gOMn4i-d4U@redhat.com>
References: <20250207153112.3939799-1-alex.bennee@linaro.org>
 <20250207153112.3939799-12-alex.bennee@linaro.org>
 <ee091002-a552-49fe-ae5e-8916937dba15@tls.msk.ru>
 <56e0a35b5c53b416db130c414cd0f3d6@linux.ibm.com>
 <CAFEAcA8Mzo-Ne48=uFBTcy+CXNcnxGOaW941p=CRkD6gmC=JfA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAFEAcA8Mzo-Ne48=uFBTcy+CXNcnxGOaW941p=CRkD6gmC=JfA@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 04:34:24PM +0100, Peter Maydell wrote:
> On Tue, 20 May 2025 at 23:22, Ilya Leoshkevich <iii@linux.ibm.com> wrote:
> > However, wasn't it already broken in this regard?
> > With fccb744f41c69fec6fd92225fe907c6e69de5d44^ I get:
> >
> > [2/2] Linking target qemu-s390x
> > /usr/bin/ld: /usr/lib64/libglib-2.0.a(gutils.c.o): in function
> > `g_get_user_database_entry':
> > (.text+0xeb): warning: Using 'getpwnam_r' in statically linked
> > applications requires at runtime the shared libraries from the glibc
> > version used for linking
> > /usr/bin/ld: (.text+0x2be): warning: Using 'getpwuid' in statically
> > linked applications requires at runtime the shared libraries from the
> > glibc version used for linking
> > /usr/bin/ld: (.text+0x134): warning: Using 'getpwuid_r' in statically
> > linked applications requires at runtime the shared libraries from the
> > glibc version used for linking
> >
> > This comes from glib, but the ultimate result is still the same.
> 
> Those are in upstream glib, as you note. We can't fix those (unless we
> have the enthusiasm to write patches for upstream glib: last time
> we asked, they were not against the idea, but nobody on either side
> had the time available to try to write the necessary patches).
> But we can and should fix the cases in our own code.
> 
> > Also, what are the symptoms of the breakage? IIUC as long as execution
> > does not reach getaddrinfo(), which it in this case should not, because
> > it is used only on inet paths, there should not be any issues, right?
> 
> Correct -- if we don't call the function it's fine. But the easiest
> way to be sure we don't call the function is to not link it in :-)
> Otherwise future code changes could result in a call without our
> realizing it.
> 
> Also, mjt's packaging for Debian puts in some stubs for the
> offending getwpuid etc functions, which suppress the glib warnings
> (this is why he noticed this whereas none of the rest of us did):
> 
> https://sources.debian.org/patches/qemu/1:10.0.0%2Bds-2/static-linux-user-stubs.diff/

Oh interesting, I was conincidentally wondering if adding dummy
stubs might suppress this.

How about we pull that change upstream, and expand it to getaddrinfo
too ?  I like the stubs much more than artificially splitting up
the source files


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


