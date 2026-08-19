Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7525C5B572
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Aug 2026 14:40:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwhTC-0002FK-Ug; Wed, 19 Aug 2026 10:40:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wwhTA-0002Cm-T9
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:40:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wwhT8-0005Ki-DL
 for qemu-devel@nongnu.org; Wed, 19 Aug 2026 10:40:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787150441;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=T4QpriLZKWe/hiir18GbeBXW/29DCNfP4ONmwmzFDLo=;
 b=S0lgBTLQYyWdcILAB0vA5nlgH1W9AsyUJclfLOP2C9j+ntOkH7d5YFpNeFL/8844b7KJfG
 UAjU2CF3gSufgUp6r4YwAVOP5VAgC7lYTb92V+Q2/HFEVcWdWWjSG4pLHU1/eczGM0llpk
 TSb7jYerEYN6Ev6Vgm6B789Zc/WuKyc=
Received: from mail-vs1-f69.google.com (mail-vs1-f69.google.com
 [209.85.217.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-eTzDviOkNIW30--zV-9zrA-1; Wed, 19 Aug 2026 10:40:39 -0400
X-MC-Unique: eTzDviOkNIW30--zV-9zrA-1
X-Mimecast-MFC-AGG-ID: eTzDviOkNIW30--zV-9zrA_1787150439
Received: by mail-vs1-f69.google.com with SMTP id
 ada2fe7eead31-74ab80df960so848380137.0
 for <qemu-devel@nongnu.org>; Wed, 19 Aug 2026 07:40:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787150439; cv=none;
 d=google.com; s=arc-20260327;
 b=PD1bx4vlhr60BcxdHR8VwH/fWFuGmRHALFXXcicdgBAGgHk/4OxZO1LM50x6jfEteL
 TrBZvvoY3YIoJhgiUwar9y6Tin/D3WfkWpQKMqPLt1yWt+zPZ7KG/CjCdXIZU7tfgD/h
 JW2i47I83ZcGC69id2AmmDwWxMVkBgI3RO/DoH3sDJIPieYvBDSV/7PPnZEJk43ndm9c
 jev9DYc+4aPkgoo+hP+6opcxvbsIoO8rbjg29YqkX/eJyz+HRbkIxd29Mriv0khd5xyF
 wGlQtr6GtpNKb+kRf8pq66CieQsgPqdhffz5voaIdr711o9X6DVczqBqEAZYgCXXYreQ
 3exQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=T4QpriLZKWe/hiir18GbeBXW/29DCNfP4ONmwmzFDLo=;
 fh=FKtoCj4XD6OpVdi0DweDlfa4+epTwfYgT5XFB8G09ic=;
 b=VxCDR5+OtAbWnYJ9IliTEukQAIVDnlRowwZ7dJzlRS5rS8aZaGqpg0bGzKlrsdNMOg
 lUETF5qG3XB7JZVSCdMDRqTGSwFCj/97bbgDQro6xgRsbbt2fP4+58f/RR/klJOfF0/e
 TjuQDgjxJ85poUNhFAj46RAAj1Uz2KhkEov8RLJugC3iRZdi7CtWvSgJCZcRH6T1Nekh
 n1GEkiFEhcrdMNoYLzHTP3EKuaIufzwPye3AGcR4CXja6X3QANSZd9ZtsOIrGLrUjoll
 RiJFNsbCEkOo4cQYCkSCT3sgOZAkVbMigVyAUPyE3XUqJpZUTixAS8bZRhfbfld3j+dp
 fOYA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787150439; x=1787755239; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=T4QpriLZKWe/hiir18GbeBXW/29DCNfP4ONmwmzFDLo=;
 b=uIImtZQF3VC5YX2VNCwiJVPpgmKFGtGabDn/kgpA0wO4EHSwldMc7744Q+9Ten1xlJ
 o3BZFDOXxJ2zgwqELgROO6j7fwSNNILhlW6lI3IukMkjfj4y7yo5od9W7ZNPGjX6guK/
 WWj4u+5yBKO0+PUInQFwnrqeknsoIRUV/JlWOJJhXVKGmE23rejcDT0zyWxLMLEuKVue
 fXVRoualu9obfD3tEiU6bNCPAzrAK9HBm0HH+IZy+oB684J64Gny7fHndrab0tgY/RAR
 EeMsd0OHYgk7Z0B0QNaKMnCo9cNFRmu9YdtSXent1Fu4h5r7gxPmPMNWW4YFUnmpIOD4
 3hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787150439; x=1787755239;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=T4QpriLZKWe/hiir18GbeBXW/29DCNfP4ONmwmzFDLo=;
 b=bulji75SMIqcci7BunbuEdQRZXEiCXA6ng4szukD+hAHWk1UiHF2i7tx0Do0LXcAeU
 827FNgHclMMRGiUyfSgtA87Jzi5x7y6lQcxD0HcfIyum9WHNR4INSFtJ5TtgY1aKzke2
 aU7gUamurPyQOM06tkJrQ+nbymDPhb+HE/qhH1BEzScYT9eqVznCLqkAPJoAsuOgPvgy
 rICU0x9giZc7M1NUckwnCwstr6xNoqL3sCC3ne9G6R27ObPoiOuCFt1eKbWWGlL/g4R+
 +OHyIrIG6/cRtPLNwa9Xth/697vA+WLfHWAUBnMmcxxqMwsSjH0e9+AEx5YAgi6O6abO
 tW/w==
X-Gm-Message-State: AOJu0Yy/GbA7AL8ftFPhIBbeRqsdHusTJlDqs5nzytKyN6s9MNz8ZGm+
 NW233XWrIlJUOTGF6Kej0IMbQVYALhjQkRQdvN7eR32upst+rZFijtDLCXuckdVSYiScgA1Bq61
 jFyYSDZI1QB8nVaC2AEgrxGnOhW9KwPmNeEQDz6s4mGnJRsWIAfVEqtPctJ1IUoyOpbqCQND0We
 wFTulyxHXzOViiS59n9zChHpZs8J+EB64=
X-Gm-Gg: AR+sD10UGFTRkNuj6VVeQzFvqGWr2nNo60yYgXRqOAVW9uNaoF3fjEZcoEoZ3lctQyD
 HeUEosd3i2i4Hj7LP8YUu40xpvBfIT2RwNhdzBbX2NguDc8CNbAcfQ4sFzdYUoWxr6mJJEJ9m3v
 irP3a+EYnGbkG+6jJlBkXreTg0+JZ0CaiSCFiNYoEY73e632GS11kma9+QHcbol8CbIHaiRnZGi
 JoR8MIB4X6y5ZpZdQKB/NMqU71bFBzrmFntBnRUmRxd/P1gqo1JH6b8w6vgbnJQ1orF4/ThLp7p
 Zg==
X-Received: by 2002:a05:6102:41c5:b0:778:5579:c661 with SMTP id
 ada2fe7eead31-7785579c78amr1007690137.7.1787150438993; 
 Wed, 19 Aug 2026 07:40:38 -0700 (PDT)
X-Received: by 2002:a05:6102:41c5:b0:778:5579:c661 with SMTP id
 ada2fe7eead31-7785579c78amr1007657137.7.1787150438467; Wed, 19 Aug 2026
 07:40:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-47-e53fc35bc550@redhat.com>
 <aoW6xf9zfnua4_-O@gallifrey>
In-Reply-To: <aoW6xf9zfnua4_-O@gallifrey>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 19 Aug 2026 18:40:25 +0400
X-Gm-Features: AcwNN1XXd7QSS1PviVB52ZHagYr54ByiyZuwxSu2VA1D56fxSCp1DHbfL2sR2tU
Message-ID: <CAMxuvax3VGow-Dc8JEfXQOAYqm0iTHNs6Cw+YwXc=rjTh-Y5=g@mail.gmail.com>
Subject: Re: [PATCH v3 47/49] monitor: move monitor_hmp_print*() functions to
 hmp.c
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.341,
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

On Wed, Aug 19, 2026 at 6:16=E2=80=AFPM Dr. David Alan Gilbert <dave@trebli=
g.org> wrote:
>
> * Marc-Andr=C3=A9 Lureau (marcandre.lureau@redhat.com) wrote:
> > Those functions are only used when CONFIG_HMP, compile them out, and ad=
d
> > conditions for the calling code.
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
>
> Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
>
> > # The commit message #2 will be skipped:
> >
> > # fixup! monitor: move monitor_hmp_print*() functions to hmp.c
>
> !
>

good catch, a good candidate for checkpatch here.. :)
thanks

>
> > ---
> >  monitor/hmp.c       | 49 +++++++++++++++++++++++++++++++++++++++++++++=
++++
> >  monitor/monitor.c   | 49 ---------------------------------------------=
----
> >  util/error-report.c |  3 ++-
> >  util/qemu-print.c   |  4 ++++
> >  4 files changed, 55 insertions(+), 50 deletions(-)
> >
> > diff --git a/monitor/hmp.c b/monitor/hmp.c
> > index 10bcbe2a33cb..e3fc05f521a8 100644
> > --- a/monitor/hmp.c
> > +++ b/monitor/hmp.c
> > @@ -1754,3 +1754,52 @@ static int get_monitor_def(MonitorHMP *hmp, int6=
4_t *pval, const char *name)
> >      }
> >      return cs->cc->sysemu_ops->monitor_get_register(cs, name, pval);
> >  }
> > +
> > +int monitor_hmp_vprintf(MonitorHMP *hmp, const char *fmt, va_list ap)
> > +{
> > +    g_autofree char *buf =3D g_strdup_vprintf(fmt, ap);
> > +
> > +    if (!hmp) {
> > +        return -1;
> > +    }
> > +
> > +    return monitor_puts(MONITOR(hmp), buf);
> > +}
> > +
> > +int monitor_hmp_printf(MonitorHMP *hmp, const char *fmt, ...)
> > +{
> > +    int ret;
> > +
> > +    va_list ap;
> > +    va_start(ap, fmt);
> > +    ret =3D monitor_hmp_vprintf(hmp, fmt, ap);
> > +    va_end(ap);
> > +    return ret;
> > +}
> > +
> > +void monitor_hmp_printc(MonitorHMP *hmp, int c)
> > +{
> > +    monitor_hmp_printf(hmp, "'");
> > +    switch (c) {
> > +    case '\'':
> > +        monitor_hmp_printf(hmp, "\\'");
> > +        break;
> > +    case '\\':
> > +        monitor_hmp_printf(hmp, "\\\\");
> > +        break;
> > +    case '\n':
> > +        monitor_hmp_printf(hmp, "\\n");
> > +        break;
> > +    case '\r':
> > +        monitor_hmp_printf(hmp, "\\r");
> > +        break;
> > +    default:
> > +        if (c >=3D 32 && c <=3D 126) {
> > +            monitor_hmp_printf(hmp, "%c", c);
> > +        } else {
> > +            monitor_hmp_printf(hmp, "\\x%02x", c);
> > +        }
> > +        break;
> > +    }
> > +    monitor_hmp_printf(hmp, "'");
> > +}
> > diff --git a/monitor/monitor.c b/monitor/monitor.c
> > index da0c8eda86b0..7979cd1cbcfd 100644
> > --- a/monitor/monitor.c
> > +++ b/monitor/monitor.c
> > @@ -272,55 +272,6 @@ int monitor_puts(Monitor *mon, const char *str)
> >      return monitor_puts_locked(mon, str);
> >  }
> >
> > -int monitor_hmp_vprintf(MonitorHMP *mon, const char *fmt, va_list ap)
> > -{
> > -    g_autofree char *buf =3D g_strdup_vprintf(fmt, ap);
> > -
> > -    if (!mon) {
> > -        return -1;
> > -    }
> > -
> > -    return monitor_puts(MONITOR(mon), buf);
> > -}
> > -
> > -int monitor_hmp_printf(MonitorHMP *mon, const char *fmt, ...)
> > -{
> > -    int ret;
> > -
> > -    va_list ap;
> > -    va_start(ap, fmt);
> > -    ret =3D monitor_hmp_vprintf(mon, fmt, ap);
> > -    va_end(ap);
> > -    return ret;
> > -}
> > -
> > -void monitor_hmp_printc(MonitorHMP *mon, int c)
> > -{
> > -    monitor_hmp_printf(mon, "'");
> > -    switch(c) {
> > -    case '\'':
> > -        monitor_hmp_printf(mon, "\\'");
> > -        break;
> > -    case '\\':
> > -        monitor_hmp_printf(mon, "\\\\");
> > -        break;
> > -    case '\n':
> > -        monitor_hmp_printf(mon, "\\n");
> > -        break;
> > -    case '\r':
> > -        monitor_hmp_printf(mon, "\\r");
> > -        break;
> > -    default:
> > -        if (c >=3D 32 && c <=3D 126) {
> > -            monitor_hmp_printf(mon, "%c", c);
> > -        } else {
> > -            monitor_hmp_printf(mon, "\\x%02x", c);
> > -        }
> > -        break;
> > -    }
> > -    monitor_hmp_printf(mon, "'");
> > -}
> > -
> >  static MonitorQAPIEventConf monitor_qapi_event_conf[QAPI_EVENT__MAX] =
=3D {
> >      /* Limit guest-triggerable events to 1 per second */
> >      [QAPI_EVENT_RTC_CHANGE]        =3D { 1000 * SCALE_MS },
> > diff --git a/util/error-report.c b/util/error-report.c
> > index c20e157780fa..68471d8055a1 100644
> > --- a/util/error-report.c
> > +++ b/util/error-report.c
> > @@ -35,12 +35,13 @@ const char *error_guest_name;
> >  static int G_GNUC_PRINTF(1, 0)
> >  error_vprintf_mon(const char *fmt, va_list ap)
> >  {
> > +#ifdef CONFIG_HMP
> >      MonitorHMP *hmp =3D monitor_cur_hmp();
> >
> >      if (hmp) {
> >          return monitor_hmp_vprintf(hmp, fmt, ap);
> >      }
> > -
> > +#endif
> >      return vfprintf(stderr, fmt, ap);
> >  }
> >
> > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > index aabe670fda01..f4a7ce4c0682 100644
> > --- a/util/qemu-print.c
> > +++ b/util/qemu-print.c
> > @@ -21,10 +21,12 @@
> >   */
> >  int qemu_vprintf(const char *fmt, va_list ap)
> >  {
> > +#ifdef CONFIG_HMP
> >      MonitorHMP *hmp =3D monitor_cur_hmp();
> >      if (hmp) {
> >          return monitor_hmp_vprintf(hmp, fmt, ap);
> >      }
> > +#endif
> >      return vprintf(fmt, ap);
> >  }
> >
> > @@ -52,10 +54,12 @@ int qemu_printf(const char *fmt, ...)
> >   */
> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >  {
> > +#ifdef CONFIG_HMP
> >      if (!stream) {
> >          MonitorHMP *hmp =3D monitor_cur_hmp();
> >          return hmp ? monitor_hmp_vprintf(hmp, fmt, ap) : -1;
> >      }
> > +#endif
> >      return vfprintf(stream, fmt, ap);
> >  }
> >
> >
> > --
> > 2.55.0.543.g5ebe2ebe4ea8
> >
> --
>  -----Open up your eyes, open up your mind, open up your code -------
> / Dr. David Alan Gilbert    |       Running GNU/Linux       | Happy  \
> \        dave @ treblig.org |                               | In Hex /
>  \ _________________________|_____ http://www.treblig.org   |_______/
>


