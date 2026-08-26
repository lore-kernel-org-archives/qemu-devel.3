Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EB89C61DC6
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 06:58:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wz7a3-0006yv-IY; Wed, 26 Aug 2026 02:57:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wz7a0-0006yT-JQ
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:57:48 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wz7Zy-0001bx-Iw
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 02:57:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787727465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oCNPYeEYCpq8Q49IeIFz4BY4/8vtagTj4T5PifCzfrw=;
 b=TH6u1Qf5kDzml0Rnbd3TwekJ/48P44AlzZhoQn3t/UWQyOQi+Gc+Mmjh1kBHSdoev+YPRI
 A77T8iJeua+RGlAWH3bp7TdtQd5uyCHg5tLa+mWga7pT2BPLmeF+ISfyM+w5SzTwb9Ypm3
 3W53HV/qC8lz2gfKeoEcCHgbmD4DO3Y=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-WOV8LncaOQCeW2SR7tRdKQ-1; Wed, 26 Aug 2026 02:57:42 -0400
X-MC-Unique: WOV8LncaOQCeW2SR7tRdKQ-1
X-Mimecast-MFC-AGG-ID: WOV8LncaOQCeW2SR7tRdKQ_1787727462
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2ccb6823efcso7798865ad.0
 for <qemu-devel@nongnu.org>; Tue, 25 Aug 2026 23:57:42 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787727462; cv=none;
 d=google.com; s=arc-20260327;
 b=d+chO8lc/9eH+gIgQ/mpPDCm320opwmMfvUmpzpZoecUniMjbMCmtsefMACXzTcBUc
 hrZbrIPX1AO05OQ80fIlAPs+9xPy6X4se7K23VQsEI4mGaPxQ4RJwOz+NVIDmkuHpI4S
 I5WQN4L9cPH1x+czPXTUGJPWTLNI+YFc1+EytNzyv3g9I/Ut2FId/pAAiv5bOZR3TtF8
 kWAfAcpNc7IMNG8vimS7hLmNoFkUgX7O7Yl9/2FUyTiBgtpVeerLo82hOc3fsmmI/3Lu
 Q6cM5hkLXEKEZug3r+h5sdZ2bcJHx+Xh+eMDvdPPhmcX1O4PcDykCW1H/n1/7F6nlfkC
 a7VQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=oCNPYeEYCpq8Q49IeIFz4BY4/8vtagTj4T5PifCzfrw=;
 fh=SMgQw19GZ1Z3t/Pfym9mKfxAECzOKKdzUPAYjo5G3xM=;
 b=M4Z6rVhFB4uoyT3SzUwb4SL8HkndFXf+f5eawxFhqyIfMMLsCuQzkzGOxHUl9o2jCw
 keSBGjAt16EWg25vO39QeZQyLWs1z2Buy64tzRH6dGdRdo926OWWk0p5wUlLJUi5UHib
 yNiihkOmtbBtGWyJ6f7jEZk7FprZi3UAoLJ8B0xPSwIS4sWUnntUhdIj62otquFeiPqq
 ZNqMMZGHG2vnRG5/ndazp9Pt3LPwEZsW/b9gj4A9gL6LeI00RGm8p55cIgP+MDxkqP8R
 x3Om2cceS95GI9JGlJ9BwpZjZbTBk80RNde8Nlyyu/jrFtz1kIMS3AwV1jPui1A5aOHL
 lqNg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787727462; x=1788332262; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=oCNPYeEYCpq8Q49IeIFz4BY4/8vtagTj4T5PifCzfrw=;
 b=t1jOfuyB6b2Z3HfQILowB/0UhHqycuBPyhgGlJ1r6D1dF39XkgFS1ikzlmHQH10o+s
 VkzMBNAf3XecUGx2i34Fs/Cs5DV9Q3Z+pjT7orXawbEwdNZ8lqRxWCXZJ0HOXxLiJ2PD
 6D1NecvFsTnKatxZEgswI+j7PmEHEI6w7Z0vVm0X4vzRwq369sMhBD1h6vGBSFJ8X4xL
 HEIk87C4vZ5FrY0VqhfKK2PLol99bxUgudLVKoCXqE/GoofZPaPohxBvMMJPmagJoa2W
 lsuApsyVSGp4oLrjt0k8hgAmVXmEiQeWqsDSacQYZDhjvzwGqyRNtK0H0ykrHZ1L85fn
 T+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787727462; x=1788332262;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=oCNPYeEYCpq8Q49IeIFz4BY4/8vtagTj4T5PifCzfrw=;
 b=nizhslalk1TVVQnVj//a8X56Cyk/xplG0wVwXM0c5R2lLE12BHvEaNWtHZrZ+tit3a
 +8myXlaT0uF8zrrtANJ4lU+eOaZngxOHtZ/NF5rV0x7BRMxa4cZ2p4cl66YcCd19dwFi
 dekKsBZsD67DOqzgRH6xqyqH6V/CFPI1jjoSD+KREBHtggF1lnFUIjrMQRYLv2+MAjGB
 DpyEtYy8BL7dc31hUeROsNcZElmWgun2+ItEezCqyk6sBd5Q2GklDkzrZpKcV06s4yt+
 QtqpHLePYl1yhFEKDIqJ0pXFBWh6BcVXOkE33Hkfrp9w/zkBxikteGcvbjMphMq+EfVb
 FWCQ==
X-Gm-Message-State: AFuF++nkLZROzvsxArZUxo5AHm7RgcbHi8CWTEPry0NlAxlikKHiJ8hY
 /pDVoKNDcy9r08iHcMvkZYBauiOgG4mkkFaOWHfDW1g5apdUzQdQ1NENYefCOXR5eoV1EA8xUV7
 0zP9UtLbDN3h5L+RQLzH0s4+AbX/twQxD/zkxftyE9SXDngSwQgH+nvAz/EJCXuq8oSPY/613r4
 lAUtzjaRwTx+lnZx3/+emcDtzWe+tKdNw=
X-Gm-Gg: AR+sD139jks6RT7qNiRfqIf+02r2i510Rie09c1vAx+u2gho4PacvYv1lBitoHGd50g
 TwT23ZI+uV5izfU1pMFpJ7Ckf/ZyRtw0itlZXZ+yOLA6v3Aw30TQG5ybKETthC9v82aa0K9yyZx
 cAW4DqAbOXuJN1M3gfKcE0qdagnRE1M0S+QtM9HVuyBNzMQVxDk9CahzavbzTGa2rHSdHPlsJp5
 LOoU+UjQY1ax5xMKsG4MUHb3oZHvbagkmB5pgxQgO8yDtJ1QHws/a4drWQBntAd7025j9VL7Vnj
 aA==
X-Received: by 2002:a05:6a21:4cc2:b0:3c3:7a0a:18a6 with SMTP id
 adf61e73a8af0-3cf85468c88mr9443879637.18.1787727461598; 
 Tue, 25 Aug 2026 23:57:41 -0700 (PDT)
X-Received: by 2002:a05:6a21:4cc2:b0:3c3:7a0a:18a6 with SMTP id
 adf61e73a8af0-3cf85468c88mr9443760637.18.1787727461107; Tue, 25 Aug 2026
 23:57:41 -0700 (PDT)
MIME-Version: 1.0
References: <20260816-qemu-no-hmp-v3-0-e53fc35bc550@redhat.com>
 <20260816-qemu-no-hmp-v3-34-e53fc35bc550@redhat.com>
 <aoxQ--22A82pLhIf@redhat.com>
In-Reply-To: <aoxQ--22A82pLhIf@redhat.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 10:57:29 +0400
X-Gm-Features: AcwNN1XL7a0q3dTvOavwZyWUYI4d4jufgKRC1avFnJwTz1SxkDhsXtzPDeoitrM
Message-ID: <CAMxuvazaDtx3pTMjsZ5Pcdeh0PEd0J3t5m1EOXFWnkL2WhUU1g@mail.gmail.com>
Subject: Re: [PATCH v3 34/49] qemu-print: switch to use monitor_cur_hmp()
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 Markus Armbruster <armbru@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, Aug 24, 2026 at 6:11=E2=80=AFPM Daniel P. Berrang=C3=A9 <berrange@r=
edhat.com> wrote:
>
> On Sun, Aug 16, 2026 at 11:13:01PM +0400, Marc-Andr=C3=A9 Lureau wrote:
> > Note that this fixes qemu_vprintf() (and thus qemu_printf) to do as sai=
d
> > in the code comment: print to current HMP if we have one, else to
> > stdout, instead of trying to print to the current monitor (which may no=
t
> > actually have hmp-only print capability/callback and fail silently).
>
> The question is whether that commented behaviour is actually
> what we want ? AFAICT, the comment has been wrong since day
> one - it always printed to HMP, and /dev/nulled for QMP,
> and stdout thus only in non-monitor context.
>
> I'm not convinced that qemu_printf family should do anything
> in QMP context - /dev/null feels like the right behaviour.
>
> We have warn_report/error_report which go to stderr in QMP
> context which is right.  I don't see a use case for
> qemu_printf to stderr in QMP context.

I dropped this patch and instead made a documentation update in v4.
thanks


>
> >
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >  util/qemu-print.c | 9 +++++----
> >  1 file changed, 5 insertions(+), 4 deletions(-)
> >
> > diff --git a/util/qemu-print.c b/util/qemu-print.c
> > index a2d1f0244168..0eecc05b0330 100644
> > --- a/util/qemu-print.c
> > +++ b/util/qemu-print.c
> > @@ -21,9 +21,9 @@
> >   */
> >  int qemu_vprintf(const char *fmt, va_list ap)
> >  {
> > -    Monitor *cur_mon =3D monitor_cur();
> > -    if (cur_mon) {
> > -        return monitor_vprintf(cur_mon, fmt, ap);
> > +    MonitorHMP *hmp =3D monitor_cur_hmp();
> > +    if (hmp) {
> > +        return monitor_vprintf(MONITOR(hmp), fmt, ap);
> >      }
> >      return vprintf(fmt, ap);
> >  }
> > @@ -53,7 +53,8 @@ int qemu_printf(const char *fmt, ...)
> >  int qemu_vfprintf(FILE *stream, const char *fmt, va_list ap)
> >  {
> >      if (!stream) {
> > -        return monitor_vprintf(monitor_cur(), fmt, ap);
> > +        MonitorHMP *hmp =3D monitor_cur_hmp();
> > +        return hmp ? monitor_vprintf(MONITOR(hmp), fmt, ap) : -1;
> >      }
> >      return vfprintf(stream, fmt, ap);
> >  }
> >
> > --
> > 2.55.0.543.g5ebe2ebe4ea8
> >
>
> With regards,
> Daniel
> --
> |: https://berrange.com       ~~        https://hachyderm.io/@berrange :|
> |: https://libvirt.org          ~~          https://entangle-photo.org :|
> |: https://pixelfed.art/berrange   ~~    https://fstop138.berrange.com :|
>


