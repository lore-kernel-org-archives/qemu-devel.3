Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A3D1C3DA4A
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Aug 2024 08:45:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sesZo-0008SX-5A; Fri, 16 Aug 2024 04:44:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sesZk-0008Rv-1I
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:44:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sesZi-0006dw-9p
 for qemu-devel@nongnu.org; Fri, 16 Aug 2024 04:44:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723797884;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gA5jdq5dLKzufFOVi0jOEI5ost4zThD+hb6Vt+IMbFc=;
 b=WjgLjJ0Od9LwPXS9FzeHiRztA7Jy4aS0huOY34nfKvGlCm2vuharORjfvU/wiOZ+V2hO0e
 5DYTPJU26y0O0a5RWhCe7gARyQ6nddjRGUcBk5F34aKpjPC36R7BYCvAG2Ws3qCFZFaLFN
 N6qoT1/fEoJWJuINM5lT+oLUXFVRPes=
Received: from mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-599-Sjs8SNsAMqait3Xiq3HaTA-1; Fri,
 16 Aug 2024 04:44:41 -0400
X-MC-Unique: Sjs8SNsAMqait3Xiq3HaTA-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-04.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 7F0D81955BFC; Fri, 16 Aug 2024 08:44:39 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.143])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 659E81955F23; Fri, 16 Aug 2024 08:44:33 +0000 (UTC)
Date: Fri, 16 Aug 2024 09:44:29 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Thomas Huth <thuth@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 qemu-devel@nongnu.org, Beraldo Leal <bleal@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
 Wainer dos Santos Moschetta <wainersm@redhat.com>, qemu-s390x@nongnu.org,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH v2 1/4] meson: hide tsan related warnings
Message-ID: <Zr8RbcFVN0cgwp-H@redhat.com>
References: <20240814224132.897098-1-pierrick.bouvier@linaro.org>
 <20240814224132.897098-2-pierrick.bouvier@linaro.org>
 <CAFEAcA-EAm9mEdGz6m2Y-yxK16TgX6CpxnXc6hW59iAxhXhHtw@mail.gmail.com>
 <Zr3g7lEfteRpNYVC@redhat.com>
 <CAFEAcA8xMjd2w5tT-sMcHKuKGXbqZg4HtTerNFG=_YpNRVVhxQ@mail.gmail.com>
 <66f144dd-f098-443b-8a34-d68bbdecc48f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <66f144dd-f098-443b-8a34-d68bbdecc48f@redhat.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
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

On Fri, Aug 16, 2024 at 07:44:28AM +0200, Thomas Huth wrote:
> On 15/08/2024 19.54, Peter Maydell wrote:
> > On Thu, 15 Aug 2024 at 12:05, Daniel P. Berrangé <berrange@redhat.com> wrote:
> > > 
> > > On Thu, Aug 15, 2024 at 11:12:39AM +0100, Peter Maydell wrote:
> > > > On Wed, 14 Aug 2024 at 23:42, Pierrick Bouvier
> > > > <pierrick.bouvier@linaro.org> wrote:
> > > > > 
> > > > > When building with gcc-12 -fsanitize=thread, gcc reports some
> > > > > constructions not supported with tsan.
> > > > > Found on debian stable.
> > > > > 
> > > > > qemu/include/qemu/atomic.h:36:52: error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’ [-Werror=tsan]
> > > > >     36 | #define smp_mb()                     ({ barrier(); __atomic_thread_fence(__ATOMIC_SEQ_CST); })
> > > > >        |                                                    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > > 
> > > > > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > > > > ---
> > > > >   meson.build | 10 +++++++++-
> > > > >   1 file changed, 9 insertions(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/meson.build b/meson.build
> > > > > index 81ecd4bae7c..52e5aa95cc0 100644
> > > > > --- a/meson.build
> > > > > +++ b/meson.build
> > > > > @@ -499,7 +499,15 @@ if get_option('tsan')
> > > > >                            prefix: '#include <sanitizer/tsan_interface.h>')
> > > > >       error('Cannot enable TSAN due to missing fiber annotation interface')
> > > > >     endif
> > > > > -  qemu_cflags = ['-fsanitize=thread'] + qemu_cflags
> > > > > +  tsan_warn_suppress = []
> > > > > +  # gcc (>=11) will report constructions not supported by tsan:
> > > > > +  # "error: ‘atomic_thread_fence’ is not supported with ‘-fsanitize=thread’"
> > > > > +  # https://gcc.gnu.org/gcc-11/changes.html
> > > > > +  # However, clang does not support this warning and this triggers an error.
> > > > > +  if cc.has_argument('-Wno-tsan')
> > > > > +    tsan_warn_suppress = ['-Wno-tsan']
> > > > > +  endif
> > > > 
> > > > That last part sounds like a clang bug -- -Wno-foo is supposed
> > > > to not be an error on compilers that don't implement -Wfoo for
> > > > any value of foo (unless some other warning/error would also
> > > > be emitted).
> > > 
> > > -Wno-foo isn't an error, but it is a warning... which we then
> > > turn into an error due to -Werror, unless we pass -Wno-unknown-warning-option
> > > to clang.
> > 
> > Which is irritating if you want to be able to blanket say
> > '-Wno-silly-compiler-warning' and not see any of that
> > warning regardless of compiler version. That's why the
> > gcc behaviour is the way it is (i.e. -Wno-such-thingy
> > is neither a warning nor an error if it would be the only
> > warning/error), and if clang doesn't match it that's a shame.
> 
> I thought that Clang would behave the same way as GCC, but apparently it
> does not (anymore?):

It is nothing new - clang has behaved this way wrt unknown warning flags
for as long as I remember.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


