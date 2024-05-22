Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6C08C25B77
	for <qemu-devel@archiver.kernel.org>; Wed, 22 May 2024 11:48:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s9kRk-0003Yk-2y; Wed, 22 May 2024 07:47:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9kRi-0003YF-TQ
 for qemu-devel@nongnu.org; Wed, 22 May 2024 07:47:50 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1s9kRg-0005lx-Eq
 for qemu-devel@nongnu.org; Wed, 22 May 2024 07:47:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1716378467;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uCr4WA2AUwuOp3c+1uaFvi46ptMzk07EKy/9UlojYJA=;
 b=CI77IHaPdA4SMukUM7E2NrM45eOGzRJFiJVlJPQ65yGlj6/DcY+bBwQ7z5Sak3y8rwU6Tk
 fA9jVuZEIVvInF2vjwRd2obbxwuMGavGcwpl89dlU1MRsACumdECr8oGLVrFj3eV/sHZTe
 +mQVKClXHPHxGSlUo5cWaA0hQuE0LLM=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-446-4pXtiA3kPxyF2yxyV2i_jg-1; Wed, 22 May 2024 07:47:45 -0400
X-MC-Unique: 4pXtiA3kPxyF2yxyV2i_jg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8D332800994;
 Wed, 22 May 2024 11:47:44 +0000 (UTC)
Received: from redhat.com (dhcp-17-234.lcy.redhat.com [10.42.17.234])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 4F12651BF;
 Wed, 22 May 2024 11:47:42 +0000 (UTC)
Date: Wed, 22 May 2024 12:47:40 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Michael Tokarev <mjt@tls.msk.ru>,
 Laurent Vivier <laurent@vivier.eu>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 1/3] qemu-keymap: Free xkb allocations
Message-ID: <Zk3bXNAIGnhbEUnK@redhat.com>
References: <20240522-xkb-v3-0-c429de860fa1@daynix.com>
 <20240522-xkb-v3-1-c429de860fa1@daynix.com>
 <CAFEAcA_Sm=j_Q-gP=gaAKpmaMwA1-rO+JLAijzzuuhQOEFyfXA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAFEAcA_Sm=j_Q-gP=gaAKpmaMwA1-rO+JLAijzzuuhQOEFyfXA@mail.gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, May 22, 2024 at 12:35:23PM +0100, Peter Maydell wrote:
> On Wed, 22 May 2024 at 11:49, Akihiko Odaki <akihiko.odaki@daynix.com> wrote:
> >
> > This fixes LeakSanitizer complaints with xkbcommon 1.6.0.
> >
> > Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> > ---
> >  qemu-keymap.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/qemu-keymap.c b/qemu-keymap.c
> > index 8c80f7a4ed65..7a9f38cf9863 100644
> > --- a/qemu-keymap.c
> > +++ b/qemu-keymap.c
> > @@ -237,6 +237,9 @@ int main(int argc, char *argv[])
> >      xkb_state_unref(state);
> >      state = NULL;
> >
> > +    xkb_keymap_unref(map);
> > +    xkb_context_unref(ctx);
> > +
> >      /* add quirks */
> >      fprintf(outfile,
> >              "\n"
> 
> This is surely a sanitizer bug. We're unconditionally about
> to exit() the program here, where everything is freed, so nothing
> is leaked.

I'm not sure I'd call it a sanitizer bug, rather its expected behaviour
of sanitizers. Even if you're about to exit, its important to see info
about all memory that is not freed by that time, since it can reveal
leaks that were ongoing in the process that are valid things to fix.
To make the sanitizers usable you need to get rid of the noise. IOW,
either have to provide a file to supress reports of memory that is
expected to remain allocated, or have to free it despite being about
to exit.  Free'ing is the more maintainable strategy, as IME, supression
files get outdated over time.

So as long as the free'ing action is not unreasonably expensive, we
should just do its, so from my POV I'd

  Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


