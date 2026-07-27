Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E958FC531D0
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 08:49:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woH1O-0004BZ-48; Mon, 27 Jul 2026 04:49:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH1M-0004B2-Uw
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:49:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1woH1L-0006Jn-CO
 for qemu-devel@nongnu.org; Mon, 27 Jul 2026 04:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785142150;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=7kGEMn6eHQoaN4NfeViWqhPxe4bRXVeNsFNfkePmaKU=;
 b=An8c8WJk2Q4KtPY33b0o+HAUzyEMEev5V3oouq9ShQ8tzvsDBxHfJvbaRLp0jDtjqS8ISE
 70/WT3cArMZrFoAKyFPnR49/nL8L6E5wvrRcUK5dxSe+5waKlEM3PvwJGohndnQ4Pht2Xs
 6ezhSc5fDL515i5svYWtqUESIiyFya0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-587-Se4cshPePiK4Ct1nGUy33A-1; Mon, 27 Jul 2026 04:49:08 -0400
X-MC-Unique: Se4cshPePiK4Ct1nGUy33A-1
X-Mimecast-MFC-AGG-ID: Se4cshPePiK4Ct1nGUy33A_1785142148
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4954b1c6310so23234825e9.0
 for <qemu-devel@nongnu.org>; Mon, 27 Jul 2026 01:49:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785142148; x=1785746948; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=7kGEMn6eHQoaN4NfeViWqhPxe4bRXVeNsFNfkePmaKU=;
 b=qZ4NBdHNSxm/3zIEf+LXuqg6OyMaiZh04H3zccRujzq/zr825zjvbjK0gelNaOsiPd
 uOlz/lMQT4aRO/hC5wCZOxpqRE4J49tRrcNYxY57yg8+GMwLI62t/JS6zaxuLPhKISLX
 h7abzU85y1nv+xFKnIsx7iP2bF9wymjKutrX0Wnu79MoZWCCa5LADbzBxFaRc9qUxnFd
 zCU4LpBvyIDeOO5Pt5ku2CW2lTKyUW0mNQzPVPWnzMuuBkV06lc2aHWlvoc+MLOEqaxa
 lFN2DDnhX6uR5bBtvXaOLVTc4xrAHiOXP7Eg/30aSsZqPoPrO4egsrfRpIHA7VtRrLqs
 q42A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785142148; x=1785746948;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=7kGEMn6eHQoaN4NfeViWqhPxe4bRXVeNsFNfkePmaKU=;
 b=HOy50tZULtdRYdHqVldordCOfotgEOaF3UdppL5QOovsWtpJCBcxBBoeKhHUkrgc0E
 Zfr09kK+CUhzujBveSr0uJZCiJY7Nd7UJfox7TvFnGa/ro/oXiXs3KGY5yANeZ4Ph64q
 /wryRsGJ6HWiy8xwTi7ie/cFqseiZnjlTtNqkAokg6LUI7c5iiVBsbsZtPBChJMNTGQR
 Ma2T/FdDIpx8cUL/6idoBCkvT6D2AIlp4CRnBWleEoVB3LOM+KVlUksHj0ry88cXT9Br
 7hXbYi78mspRLU59Vcl9XDS29CA4BY+TX5h5yFdOVEGvm96qrSnoPzveICNbDMJbQ/1F
 a/Rg==
X-Gm-Message-State: AOJu0YyOk/2ogrL05huQT5WvMQaXHRrCbpRR79NUi8RwaPRvrAkh2Pfi
 fXn6csFicKv/v480uHa1H1j+l7ErCn6rGaZkr6/8lae3yqCdihfH97iCDU1MJenmVVoYloFOjsF
 qXFRIBMYcK74abCFnj6c+Gwe9A7FSkL+3zPizmnertuv6xBwtLy1rMtdp
X-Gm-Gg: AR+sD13/WLS0JwX9CW+SNqCZJMe5WD9qbq1jPAAcNIlqL4hDt1Ba3725UM00BCr5X3+
 RCzeMyG9KuZdjxbx2TfinV5Si82fSHTpd1ljrqeHPt7hEtnki+dYQOlUrJc3+g7JliaPE6WCJc6
 iF4rbNn1p5LHR9bk/lGeHznVR2CIwAzlulZ4pv5klUXavN1u0d+JEO4cC3sJXB5ZrR+ac3caR3c
 2Vx32alOH7qjzd3RkjaS65mXWROXn98EnEEKitocZOpFq0RcDhmsnMTE3rGDw3HJnuY7xMqtE9C
 i06K7sxPiIAaYqtSi7fe0+XNHONlhZLjqbYbB8Lm28cT7gcgKxg5DYs8SqBh8psByoA2xVPj9gn
 SIgv9FF3xie1BQ+Uw9ZdnwA==
X-Received: by 2002:a05:600c:354f:b0:495:5062:17f9 with SMTP id
 5b1f17b1804b1-496b5702398mr112625625e9.30.1785142147415; 
 Mon, 27 Jul 2026 01:49:07 -0700 (PDT)
X-Received: by 2002:a05:600c:354f:b0:495:5062:17f9 with SMTP id
 5b1f17b1804b1-496b5702398mr112625255e9.30.1785142146952; 
 Mon, 27 Jul 2026 01:49:06 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-37-66.inter.net.il. [80.230.37.66])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4957f9928fdsm233687885e9.1.2026.07.27.01.49.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jul 2026 01:49:06 -0700 (PDT)
Date: Mon, 27 Jul 2026 04:49:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?iso-8859-1?Q?Marc-Andr=E9?= Lureau <marcandre.lureau@redhat.com>
Cc: qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 qemu-block@nongnu.org, Jonathan Cameron <jic23@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roman Bolshakov <rbolshakov@ddn.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Wei Liu <wei.liu@kernel.org>, linux-cxl@vger.kernel.org,
 Brian Cain <brian.cain@oss.qualcomm.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@mailo.com>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH v2 07/12] Fix some -Werror=maybe-uninitialized
Message-ID: <20260727043137-mutt-send-email-mst@kernel.org>
References: <20260727-fix2-v2-0-d0c4831ed7ea@redhat.com>
 <20260727-fix2-v2-7-d0c4831ed7ea@redhat.com>
 <20260726165049-mutt-send-email-mst@kernel.org>
 <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1C+jzxfbWbmLoU6vMobKUr0VFkpnr--FyPcy8o1=Q0vY-g@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Jul 27, 2026 at 01:07:32AM +0400, Marc-André Lureau wrote:
> Hi
> 
> On Mon, Jul 27, 2026 at 12:53 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, Jul 27, 2026 at 12:44:06AM +0400, Marc-André Lureau wrote:
> > > When compiled with -Og, gcc produces many false-positives
> > > gcc (GCC) 16.1.1 20260515 (Red Hat 16.1.1-2).
> >
> > it hurts if you do it? so don't do it then?
> 
> We are not far from getting it working, we can accommodate a bit of
> code while making it a bit clearer for the reader too.

I don't know, dead code does not make things clear to me.
And it burns tokens for LLMs)


I simply do not at all cherish to have yet another weird config
that will trip up CI and then I am wasting time either
"fixing" it myself or wasting even more time communicating with
contributors.



Used uninitialized warnings is already not great with -O2.
How about simply disabling them with -Og?
Is -Wno-error=maybe-uninitialized enough?
Default build will catch enough errors and that seems enough for me.

> >
> > > We already use auto-var-init=zero, but better be explicit.
> >
> > explicit about false positives?
> 
> Explicit initialization

I don't really think it's better. Maybe it's required to make the
tool work, but it would be even better to avoid the noise.


If I see A = 123; I expect it was worth my time to read it.

> >
> > > Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
> > > ---
> > >  target/i386/cpu.c             | 3 ++-
> > >  target/i386/emulate/x86_mmu.c | 4 ++--
> > >  2 files changed, 4 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > > index 5805d33ab92d..28e4435df23f 100644
> > > --- a/target/i386/cpu.c
> > > +++ b/target/i386/cpu.c
> > > @@ -7734,7 +7734,7 @@ static void x86_cpuid_get_avx10_version(Object *obj, Visitor *v,
> > >  static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
> > >                                           Error **errp)
> > >  {
> > > -    const AVX10VersionDefinition *def;
> > > +    const AVX10VersionDefinition *def = NULL;
> > >      CPUX86State *env = &cpu->env;
> > >
> > >      if (!version) {
> > > @@ -7757,6 +7757,7 @@ static bool x86_cpu_apply_avx10_features(X86CPU *cpu, uint8_t version,
> > >              break;
> > >          }
> > >      }
> > > +    assert(def != NULL);
> > >
> > >      if (def->version < version) {
> > >          error_setg(errp, "avx10-version can be at most %d", def->version);
> >
> >
> > what does assert have to do with gcc warnings?
> 
> That's what is expected at this point,

of course - it is dereferenced 1 line below.
what I worry about is people seeing this and blindly adding
these asserts all over.

> unfortunately the compiler
> doesn't care we help it here. I can drop it
> 
> > > diff --git a/target/i386/emulate/x86_mmu.c b/target/i386/emulate/x86_mmu.c
> > > index 8d4371467fd7..65bcccd4751e 100644
> > > --- a/target/i386/emulate/x86_mmu.c
> > > +++ b/target/i386/emulate/x86_mmu.c
> > > @@ -185,8 +185,8 @@ static MMUTranslateResult walk_gpt(CPUState *cpu, target_ulong addr, MMUTranslat
> > >      int largeness = 0;
> > >      target_ulong cr3 = x86_read_cr(cpu, 3);
> > >      uint64_t page_mask = pae ? PAE_PTE_PAGE_MASK : LEGACY_PTE_PAGE_MASK;
> > > -    MMUTranslateResult res;
> > > -
> > > +    MMUTranslateResult res = MMU_TRANSLATE_PAGE_NOT_MAPPED;
> > > +
> >
> >
> > This is not 0 as the commit log implies.
> 
> Initializing with 0 implies defaulting to MMU_TRANSLATE_SUCCESS - not
> the best choice here.

when I see this I go "ok there is probably an early exit I better
remember it" - and then it turns out there isn't and I am left confused.

-- 
MST


