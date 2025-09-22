Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A934CAC592
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 08:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0bbk-0007Bi-U7; Mon, 22 Sep 2025 04:09:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0bbj-0007BP-Ts
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:09:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1v0bbh-0006tR-LN
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 04:09:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758528546;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PyxwHXKJku4lFfrzCaotS/lV51q50T34vgA9CpGy7i0=;
 b=HsWG7l/jnOdqc/45LhWwOFZNyhtg0i8Y62aPwlFiBlv2C6+VK1vl/0KbrkSvzYSCDlNXkx
 qnJBC3D2vQxhlUGfVavDWAxFwSDhA5Zui32+ORCu16tRNLFjNhfX+CcEg4TZ0CUHJSxL5k
 8motDlk2BDgSj0jckPfQ8qcX7wxGjvI=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-93-lidI5jveM9W8go_wvYvhIQ-1; Mon,
 22 Sep 2025 04:09:02 -0400
X-MC-Unique: lidI5jveM9W8go_wvYvhIQ-1
X-Mimecast-MFC-AGG-ID: lidI5jveM9W8go_wvYvhIQ_1758528540
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBE1A180034D; Mon, 22 Sep 2025 08:08:59 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.69])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1DB901800578; Mon, 22 Sep 2025 08:08:55 +0000 (UTC)
Date: Mon, 22 Sep 2025 09:08:52 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org, Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Ed Maste <emaste@freebsd.org>, Thomas Huth <thuth@redhat.com>,
 Li-Wen Hsu <lwhsu@freebsd.org>,
 Yonggang Luo <luoyonggang@gmail.com>, Warner Losh <imp@bsdimp.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Kohei Tokunaga <ktokunaga.mail@gmail.com>, Kyle Evans <kevans@freebsd.org>
Subject: Re: [PATCH 02/24] scripts/archive-source: speed up downloading
 subprojects
Message-ID: <aNEEFJYDh4qzQVbX@redhat.com>
References: <20250919133320.240145-1-marcandre.lureau@redhat.com>
 <20250919133320.240145-3-marcandre.lureau@redhat.com>
 <aM1fjf1tuzuBXudQ@redhat.com>
 <CAMxuvawKG1h2mv3sHvm-e1n2M8N_DOpLxJROxCi4QkN-RHqkgQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAMxuvawKG1h2mv3sHvm-e1n2M8N_DOpLxJROxCi4QkN-RHqkgQ@mail.gmail.com>
User-Agent: Mutt/2.2.14 (2025-02-20)
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Mon, Sep 22, 2025 at 10:59:11AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Fri, Sep 19, 2025 at 5:50 PM Daniel P. Berrangé <berrange@redhat.com>
> wrote:
> 
> > On Fri, Sep 19, 2025 at 05:32:56PM +0400, marcandre.lureau@redhat.com
> > wrote:
> > > From: Marc-André Lureau <marcandre.lureau@redhat.com>
> > >
> > > Running meson on each subproject is quite slow.
> >
> > Why is this faster ?  Does it make meson do parallel downloads
> > if you list then all at once ?
> >
> 
> It doesn't look like it does it in paralllel, yet it is x times faster...
> 
> time sh -c 'for s in keycodemapdb libvfio-user berkeley-softfloat-3
> berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs bilge-0.2-rs
> bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs libc-0.2-rs
> proc-macro2-1-rs proc-macro-error-1-rs proc-macro-error-attr-1-rs
> quote-1-rs syn-2-rs unicode-ident-1-rs; do
>   meson subprojects download $s >/dev/null
> done'
> sh -c   5.27s user 0.33s system 99% cpu 5.613 total
> 
> time sh -c 'meson subprojects download keycodemapdb libvfio-user
> berkeley-softfloat-3 berkeley-testfloat-3 anyhow-1-rs arbitrary-int-1-rs
> bilge-0.2-rs bilge-impl-0.2-rs either-1-rs foreign-0.3-rs itertools-0.11-rs
> libc-0.2-rs proc-macro2-1-rs proc-macro-error-1-rs
> proc-macro-error-attr-1-rs quote-1-rs syn-2-rs unicode-ident-1-rs'
> sh -c   0.32s user 0.01s system 99% cpu 0.339 total

Oh I bet that 0.32secs is the overhead of python importing all modules
that meson uses. Running python 18 times, gives the 5 second overhead.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


