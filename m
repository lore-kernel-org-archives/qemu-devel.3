Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93A63C5AC67
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Aug 2026 13:03:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtm89-0006M7-Se; Tue, 11 Aug 2026 09:02:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wtm80-0006JE-PM
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:02:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wtm7y-0001pl-QJ
 for qemu-devel@nongnu.org; Tue, 11 Aug 2026 09:02:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786453365;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/T4pHmsimFLqT38WvekMsdFy2xTedO/JMlFZBr1velU=;
 b=G4Vw8V+Hv978V8DZctwqfz2jNjC5r8cDv9iaOTLLgjrEbuMjXSffUIQey/7n2KH96CWKjT
 PnOQfDAaK2N0cml63y9azRe5HoS7yvl1ETSxe1qfl/ghl3twt4Y5dBEs3N/45+gF0fQXk1
 3YDT4Isw7MUAJvLwbuVCKyJItFShJCY=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-196-swf1vlp2NxW1jvBn0PFXAQ-1; Tue, 11 Aug 2026 09:02:43 -0400
X-MC-Unique: swf1vlp2NxW1jvBn0PFXAQ-1
X-Mimecast-MFC-AGG-ID: swf1vlp2NxW1jvBn0PFXAQ_1786453363
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-cb835525b10so3994650a12.2
 for <qemu-devel@nongnu.org>; Tue, 11 Aug 2026 06:02:43 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786453362; cv=none;
 d=google.com; s=arc-20260327;
 b=SQscLpsnFRaWMwqjZuvuCZqJhaQQYGvSrVvBWq5DdpGbFvFKLAc4ChmLTE6C7SsrpU
 uBhRrqfHvs9o3SlxglsGt0QwODoF2IUSAhDHcftsMWsIybrHYU3PajqK0UmhOnbN0dQX
 J4n/kTR69VFa9dKvf3ts2odWsSWd7Ro2HrcYiOjZOslqur8Mv4cqfK3K+gDfuYeINVOn
 Fp0+a6418jTiVq2BPX1mYwcLBArp+xqK9O/FBL3cIWPzvStfXYZD1fR0uEUTwesMCiUc
 lJG+8cmYkS2mnGEZ+uO+AB/WoF86mbaXmxLuG5RY474oOEbNZvlwyAupdTHWbnZRBwwL
 F8TQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=/T4pHmsimFLqT38WvekMsdFy2xTedO/JMlFZBr1velU=;
 fh=clj/N3aH4K/xfvVAs99VTHE3zWNs21ViYr0khAbs26E=;
 b=Kxp4ovQFv3T5tq3AI5ysEY77ZMpTWNOc51qEUhv9Qoc58LHpP+rXKXSuBbc2rkplzq
 gjuKMbkUGOT94Mk9Su7t6OLhuMfamCMQ/M39vV9qpQ26r+ZMndgZrl+klN8xBKNr3C3T
 1jS72TTpm3+ZCymk2tryIy8pT23Z8lElUQCQ+UUJwW8KDx0nHi2zNnor5B38Zl75YXm1
 +fOMPtHdgLNzP0yVseFY7gv+dquiinROWPflJdgdM7rsKevH0yWpoPWbeTaOykS+pZam
 mYQuwl3tziKgWesxevNieHYHUG6c9LYq/nNbwgIb+TGR29pYqXhJnpXU9j/iJcK72/l6
 zyLg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786453362; x=1787058162; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=/T4pHmsimFLqT38WvekMsdFy2xTedO/JMlFZBr1velU=;
 b=FiKHyAfCaimdkj8vwxTafHAnJ3j5zqqC8rz4E5dNKuel0LkI0cRoLzRKDR6h52oCB1
 +6D+3bIC5I4YWPTqs33/ZhyfculIx42riNun0l0i5T2z9qoleWcxIN6lRhM8sRxvfwZL
 T1YeLDB3+RMyovzwmvJc0id9WFQqcl1lJW+bC4hzU49yh4k1BtzRD+VMutritwDq6pMW
 Ygq6eXZZkK5tQBtkrW8kU57vjBwIimC4uCX+elyRf9QlmEJG6IZuWAOKIRS55ABPwQS7
 ipBv280XqfeYS9wOlwQNtWbnMszpVYFtzGDubjKCVWCF1rFJX2Z0uMQE1jDfalqwcb6F
 C2uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786453362; x=1787058162;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=/T4pHmsimFLqT38WvekMsdFy2xTedO/JMlFZBr1velU=;
 b=PkVLPuzMmJ0/s1qgAax4VJggyOmORWmh9th6unWn6QQqQSz7iVjSC3Gzt/uBpnUh72
 VzadRlXlZmEpog5eBFT0j7mThYPh5YKyqm768CZv9TDlTWaSUT5OXLO9xtajLcMc7+Rj
 bvW+yYVeVuApoeHQvgNTgVok01zrtncAw4dUBiSaz8FBkGeWP7lJhTWDKA8qXItkZkpu
 bmhUeZGxUREbP+tdItDoqiFLLT1iPZmiCyewpavLMyX0fTg4eIXMewIhz7FXuJ5Npni8
 s0oGsaxRhIiRD8U+X2YhD0pDkZI7d2j2Mqw1CHt0RRcXJ5Pzh2iZrXxbQd9dSazdUdBw
 EUzg==
X-Gm-Message-State: AOJu0YyU12Jfp4wknqEicfxHdPtMOG53o7fTFcfjv9IxIS0TrpgaH++b
 lGKRcQJMTiqqPt1GmOKh66A1FnjA0zZUmkjjRZq26P1x2ddVD5h+2wzHWxt27HChVV6VJfybV3/
 /Adeb8gdaXYz72HNO7B3Q/lUL+FsjhINEpeLlUz5NOhf52239vUMVAzsIahViExNLNR+wFhy/GJ
 2/4Cn8IxXya4YY3oOZOx3BN7Qb5yBrL4I=
X-Gm-Gg: AR+sD107tFBVbJsLhkNLaWiqWoKxZ7cuiJ9kIhOP7ev8e+XyIUbJpytKi6wYewQctuH
 ila+qzvMDy9f8992s42ffj/5esoAQyuXeV5oKHVUF9BxuxeDFTBXhJqulHmMu9WC7zsWCe+sTGm
 mB56L7tzDoTo5nIr4jPbRQKrKMCe70Z8WyVQAX6y6QiA6ogij1mckvxOZXo6hfe74AMY8zAZ0B4
 9n2wsW/iP6hI33oBnhdR0hRkCohgzaGeQ91vmbSlu/UrBqH4/3fETRtr3R9rGfilkoLigIYRF/C
 iw==
X-Received: by 2002:a05:6a21:d83:b0:3c3:9a7f:7309 with SMTP id
 adf61e73a8af0-3cc2bac424amr4519312637.26.1786453360822; 
 Tue, 11 Aug 2026 06:02:40 -0700 (PDT)
X-Received: by 2002:a05:6a21:d83:b0:3c3:9a7f:7309 with SMTP id
 adf61e73a8af0-3cc2bac424amr4519155637.26.1786453360152; Tue, 11 Aug 2026
 06:02:40 -0700 (PDT)
MIME-Version: 1.0
References: <20260626-qemu-no-hmp-v2-0-8af31bc54c61@redhat.com>
 <20260626-qemu-no-hmp-v2-31-8af31bc54c61@redhat.com>
 <anoZpbLdNBtcUYbr@redhat.com>
In-Reply-To: <anoZpbLdNBtcUYbr@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Tue, 11 Aug 2026 17:02:28 +0400
X-Gm-Features: AUfX_mx0IguRPCbVz314omiyHu-sN2-GAA1ZybcoP8GG_INEU40TD3oQFVWp9Vk
Message-ID: <CAMxuvawNxhdZeX44T=Rd1HTdmBaRYy376LQw2LSrxaYPOsMfgw@mail.gmail.com>
Subject: Re: [PATCH v2 31/39] util: guard monitor_vprintf callers with
 CONFIG_HMP
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.102,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Hi

On Mon, Aug 10, 2026 at 10:34=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@=
redhat.com> wrote:
>
> On Fri, Jun 26, 2026 at 01:19:32AM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Guard calls to monitor_vprintf in error-report and qemu-print so
> > they compile without HMP. When CONFIG_HMP is not set,
> > error_vprintf_mon falls back directly to stderr and qemu_vfprintf
> > returns -1 for NULL streams.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  tests/unit/test-util-sockets.c | 4 +++-
> >  tools/qemu-vnc/stubs.c         | 2 ++
> >  util/error-report.c            | 8 +++++---
> >  util/qemu-print.c              | 6 ++++++
> >  4 files changed, 16 insertions(+), 4 deletions(-)
>
> This patch probably isn't required any more.
>
> With the QOM classes for montior,  monitor_vprintf calls to a 'vprintf'
> class virtual method, or returns -1.
>
> So simply by virtue of HMP being compiled out, monitor_vprintf should
> do the right thing.

It does, but shouldn't we remove API that only works & makes sense
when HMP is enabled? The monitor_printf* functions are not just simple
stubs, but won't work without HMP. I'll try to improve this now that
we have proper objects.

>
> >
> > diff --git a/tests/unit/test-util-sockets.c b/tests/unit/test-util-sock=
ets.c
> > index b9f2453e299..23ebe1e26b5 100644
> > --- a/tests/unit/test-util-sockets.c
> > +++ b/tests/unit/test-util-sockets.c
> > @@ -73,8 +73,10 @@ int monitor_get_fd(Monitor *mon, const char *fdname,=
 Error **errp)
> >   */
> >  Monitor *monitor_cur(void) { return cur_mon; }
> >  Monitor *monitor_set_cur(Coroutine *co, Monitor *mon) { abort(); }
> > -int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort=
(); }
> >  bool monitor_cur_is_qmp(void) { abort(); };
> > +#ifdef CONFIG_HMP
> > +int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap) { abort=
(); }
> > +#endif
> >
> >  #ifndef _WIN32
> >  static void test_socket_fd_pass_name_good(void)
> > diff --git a/tools/qemu-vnc/stubs.c b/tools/qemu-vnc/stubs.c
> > index a865ce85f04..f476dd6d956 100644
> > --- a/tools/qemu-vnc/stubs.c
> > +++ b/tools/qemu-vnc/stubs.c
> > @@ -46,10 +46,12 @@ Monitor *monitor_set_cur(Coroutine *co, Monitor *mo=
n)
> >      return NULL;
> >  }
> >
> > +#ifdef CONFIG_HMP
> >  int monitor_vprintf(Monitor *mon, const char *fmt, va_list ap)
> >  {
> >      return -1;
> >  }
> > +#endif
> >
> >  /*
> >   * Link-time stubs for VMState symbols referenced by VNC code.
> > diff --git a/util/error-report.c b/util/error-report.c
> > index f832ad9b6b6..e2e46281455 100644
> > --- a/util/error-report.c
> > +++ b/util/error-report.c
> > @@ -40,11 +40,13 @@ error_vprintf_mon(Monitor *cur_mon, const char *fmt=
, va_list ap)
> >       * IOW this will only print if in HMP, otherwise we
> >       * fallback to stderr for QMP / no-monitor scenarios.
> >       */
> > +#ifdef CONFIG_HMP
> >      int ret =3D monitor_vprintf(cur_mon, fmt, ap);
> > -    if (ret =3D=3D -1) {
> > -        ret =3D vfprintf(stderr, fmt, ap);
> > +    if (ret !=3D -1) {
> > +        return ret;
> >      }
> > -    return ret;
> > +#endif
> > +    return vfprintf(stderr, fmt, ap);
> >  }
> >
> >  /*
> > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > index 7b9591035e5..ee80000722b 100644
> > --- a/util/qemu-print.c
> > +++ b/util/qemu-print.c
> > @@ -20,10 +20,12 @@
> >   */
> >  int qemu_vprintf(const char *fmt, va_list ap)
> >  {
> > +#ifdef CONFIG_HMP
> >      Monitor *cur_mon =3D monitor_cur();
> >      if (cur_mon) {
> >          return monitor_vprintf(cur_mon, fmt, ap);
> >      }
> > +#endif
> >      return vprintf(fmt, ap);
> >  }
> >
> > @@ -52,7 +54,11 @@ int qemu_printf(const char *fmt, ...)
> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >  {
> >      if (!stream) {
> > +#ifdef CONFIG_HMP
> >          return monitor_vprintf(monitor_cur(), fmt, ap);
> > +#else
> > +        return -1;
> > +#endif
> >      }
> >      return vfprintf(stream, fmt, ap);
> >  }
> >
> > --
> > 2.54.0
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


