Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E45D6C52D7C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Aug 2024 11:06:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1seYIW-0006pb-3d; Thu, 15 Aug 2024 07:05:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1seYIU-0006nB-3Y
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:05:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1seYIS-00036D-8G
 for qemu-devel@nongnu.org; Thu, 15 Aug 2024 07:05:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723719934;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HHa9aFfTkq9W9zMlo50Xq2DohN++dzLZD2cadlzl9xQ=;
 b=Fs/CBCjtxeG3Jx+ZLSk4jaZVWCwAXXs31uty/hvm7pIpWsNDCYxT0aGstKsJT8TUwqCqg0
 Nb8fJMMFaVprqFxx5y8QXz60dNxEnf7glMYaK/wgUZNKM9m5nP/jS2H3aR//g9aVXUuKSm
 EV5jWwwbn0tSi2EW7jTNiGxLEqQGALM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-343-e2hN7Z13Pu-XyTKFdIjgMA-1; Thu,
 15 Aug 2024 07:05:31 -0400
X-MC-Unique: e2hN7Z13Pu-XyTKFdIjgMA-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BA7311956048; Thu, 15 Aug 2024 11:05:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.137])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 723D71955DC6; Thu, 15 Aug 2024 11:05:22 +0000 (UTC)
Date: Thu, 15 Aug 2024 12:05:18 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 Beraldo Leal <bleal@redhat.com>, David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
Message-ID: <Zr3g7lEfteRpNYVC@redhat.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Aug 15, 2024 at 11:12:39AM +0100, Peter Maydell wrote:
> On Wed, 14 Aug 2024 at 23:42, Pierrick Bouvier
> <pierrick.bouvier@linaro.org> wrote:
> >
> > When building with gcc-12 -fsanitize=thread, gcc reports some
> > constructions not supported with tsan.
> > Found on debian stable.
> >
> > qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
> >    36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
> >       |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> >
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >  meson.build | 10 +++++++++-
> >  1 file changed, 9 insertions(+), 1 deletion(-)
> >
> > diff --git a/meson.build b/meson.build
> > index 81ecd4bae7c..52e5aa95cc0 100644
> > --- a/meson.build
> > +++ b/meson.build
> > @@ -499,7 +499,15 @@ if get_option('tsan')
> >                           prefix: '#include <sanitizer/tsan_interface.h>')
> >      error('Cannot enable TSAN due to missing fiber annotation interface')
> >    endif
> > -  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
> > +  tsan_warn_suppress = []
> > +  # gcc (>=11) will report constructions not supported by tsan:
> > +  # "error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’"
> > +  # https://gcc.gnu.org/gcc-11/changes.html
> > +  # However, clang does not support this warning and this triggers an error.
> > +  if cc.has_argument('-Wno-tsan')
> > +    tsan_warn_suppress = ['-Wno-tsan']
> > +  endif
> 
> That last part sounds like a clang bug -- -Wno-foo is supposed
> to not be an error on compilers that don't implement -Wfoo for
> any value of foo (unless some other warning/error would also
> be emitted).

-Wno-foo isn't an error, but it is a warning... which we then
turn into an error due to -Werror, unless we pass -Wno-unknown-warning-option
to clang.

>               At any rate, that's how gcc does it
> (see the paragraph "When an unrecognized warning option ..."
> in https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html )
> and I thought clang did too...
> 
> thanks
> -- PMM
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


