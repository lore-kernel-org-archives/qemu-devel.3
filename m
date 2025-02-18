Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6E2DC021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:28:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQRD-0005dj-47; Tue, 18 Feb 2025 11:27:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkQRA-0005cF-8S
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:27:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tkQR7-0000oW-St
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:27:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739896024;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ki5DTZ2UY6CcSa730fZlVMvx8PLyDNT1AsfFh/7Ol6U=;
 b=aKPnyZl+cKucMrAd0EdXuyNwIIYWhG07yUM8qKvxk02fdUg2KtpPN3E3miE5VGR7sEI7Nx
 IxOwXHKzRnpl/GCDYNZ7wKnJkAPBuR6p2B71D2kKRnE1U8Ch4FXO7ziV9CWv3/5tgdNHUi
 rd8JrTzpB/mj0zyS0U8nDK2XJkOh/78=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-427-tYqkRCFYPh6VeYHVdBbfjg-1; Tue,
 18 Feb 2025 11:27:00 -0500
X-MC-Unique: tYqkRCFYPh6VeYHVdBbfjg-1
X-Mimecast-MFC-AGG-ID: tYqkRCFYPh6VeYHVdBbfjg_1739896019
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 86BB21800873; Tue, 18 Feb 2025 16:26:58 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.158])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 18EEA1800357; Tue, 18 Feb 2025 16:26:52 +0000 (UTC)
Date: Tue, 18 Feb 2025 16:26:49 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Cc: Brian Cain <brian.cain@oss.qualcomm.com>,
 Stefan Weil <stefan.weil@weilnetz.de>, qemu-devel@nongnu.org,
 Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Alexandre Iooss <erdnaxe@crans.org>
Subject: Re: [PATCH v4 0/3] Enable clang build on Windows
Message-ID: <Z7S0yRtvX4VJboy1@redhat.com>
References: <20250110203401.178532-1-pierrick.bouvier@linaro.org>
 <b3ef0b9f-df09-4444-b0aa-3b2a36f7cd3a@weilnetz.de>
 <4e788add-ee40-4d98-b065-6745e6e2fce5@oss.qualcomm.com>
 <71254e1d-3e17-4082-968f-db7fe6cea590@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <71254e1d-3e17-4082-968f-db7fe6cea590@linaro.org>
User-Agent: Mutt/2.2.13 (2024-03-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.423,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Tue, Feb 18, 2025 at 08:22:14AM -0800, Pierrick Bouvier wrote:
> Hi Brian,
> 
> On 2/17/25 20:11, Brian Cain wrote:
> > 
> > On 1/11/2025 4:08 PM, Stefan Weil via wrote:
> > > Am 10.01.25 um 21:33 schrieb Pierrick Bouvier:
> > > > For now, it was only possible to build plugins using GCC on Windows.
> > > > However,
> > > > windows-aarch64 only supports Clang.
> > > > This biggest roadblock was to get rid of gcc_struct attribute, which
> > > > is not
> > > > supported by Clang. After investigation, we proved it was safe to
> > > > drop it.
> > > > 
> > > > Built and tested on Windows (all msys env)/Linux/MacOS for x86_64 and
> > > > aarch64
> > > > hosts.
> > > > 
> > > > v1 contained warning fixes and various bits that have been upstreamed
> > > > already.
> > > > The only bits left in this series are the gcc_struct removal, and
> > > > fixing the
> > > > plugins build with clang.
> > > > 
> > > > This series is for 10.0, as we decided to not include the gcc_struct
> > > > removal is
> > > > 9.2 release.
> > > > 
> > > > All patches are now reviewed, so this series can be pulled. I'll
> > > > report that to
> > > > MSYS2 too, so we can enable clang environments for QEMU.
> > > > 
> > > > v1:
> > > > https://patchew.org/QEMU/20241031040426.772604-1-pierrick.bouvier@linaro.org/
> > > > 
> > > > v2:
> > > > - drop attribute gcc_struct instead of using -mno-ms-bitfields option
> > > > - add a section about bitfields in documentation
> > > > 
> > > > v3:
> > > > - explain why gcc_struct attribute matters in packed structs in
> > > > commit message
> > > > - reword the bitfields documentation with suggestions given
> > > > 
> > > > v4:
> > > > - edit for bitfields doc requested by Philippe
> > > > 
> > > > Pierrick Bouvier (3):
> > > >     win32: remove usage of attribute gcc_struct
> > > >     docs/devel/style: add a section about bitfield, and disallow them for
> > > >       packed structures
> > > >     plugins: enable linking with clang/lld
> > > > 
> > > >    docs/devel/style.rst                      | 20 +++++++++++++++++++
> > > >    meson.build                               |  6 +++---
> > > >    include/qemu/compiler.h                   |  7 +------
> > > >    scripts/cocci-macro-file.h                |  6 +-----
> > > >    subprojects/libvhost-user/libvhost-user.h |  6 +-----
> > > >    contrib/plugins/meson.build               |  2 +-
> > > >    plugins/meson.build                       | 24 +++++++++++++++++++----
> > > >    tests/tcg/plugins/meson.build             |  3 +--
> > > >    8 files changed, 48 insertions(+), 26 deletions(-)
> > > 
> > > This nice series allows building QEMU for Windows with the LLVM cross
> > > compiler on my ARM64 machine, so you can add
> > 
> > Is this toolchain available publicly or did you build it yourself?  It
> > would be handy if there were a linux x86_64 hosted cross-toolchain that
> > can target Windows-aarch64.  Or linux aarch64 hosted would be pretty
> > good, too.
> > 
> 
> At the moment, the only open source toolchain supporting windows-arm64 is
> llvm-mingw (https://github.com/mstorsjo/llvm-mingw).
> There is some progress on gcc, but it is not yet fully upstream.
> MSYS2 uses llvm-mingw for windows-arm64 environment.
> 
> On my side, I used a windows-arm64 machine with MSYS2 native environment.
> 
> It would be handy to cross compile, and the problem is not really QEMU
> itself, but to cross compile all the dependencies.
> For x86_64, we use fedora, which provides convenient precompiled mingw
> packages for dependencies.
> It's definitely not impossible to do the same for windows-arm64, but it just
> takes much more effort.

Once GCC supports arm64 for mingw, we could propose enabling
this in Fedora and enabling the it in the build deps.  Not a
terribly complex bit of work, but probably a bit of a time
sink to get all the pieces sorted. If this is important to
QEMU long term though, it'l be worth the effort, as the
Fedora mingw containers are what everyone is used to for
testing Windows buildability.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


