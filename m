Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96200C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:17:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJ7v-0006sb-IZ; Wed, 26 Aug 2026 15:17:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzJ7u-0006sN-IU
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:17:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzJ7t-0002Wg-7S
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:17:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787771852;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=TnPwYQQCLG5EwGMFMNfkHPtD213tl1kqbBEbCh/GXFI=;
 b=gafI07/j1VZHiHowFZx4zsc42s/I6M9v5ScgKQyZ5hTkG5zuBGPokvYcKz+Zre6fI26jxZ
 uBKSBkLS4O9G4TIU8PdjuFfUlWmXNs6qhnKa3AuztXL15MQ5B3Ie65f8Y1MUlL1Xz/zHnE
 5ef8+1K79bWiu71s1f8PGmcyoOFfHuQ=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-10-0SGFACNeOUixlG2ODqDZ3Q-1; Wed, 26 Aug 2026 15:17:30 -0400
X-MC-Unique: 0SGFACNeOUixlG2ODqDZ3Q-1
X-Mimecast-MFC-AGG-ID: 0SGFACNeOUixlG2ODqDZ3Q_1787771850
Received: by mail-pg1-f198.google.com with SMTP id
 41be03b00d2f7-cc1b8088202so1260734a12.3
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:17:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787771850; cv=none;
 d=google.com; s=arc-20260327;
 b=A3/tEnjnLF2nTNnNi78R5QD34nIC9oBsb0yhNOXbygTLRi6kxdf2KQ9xXW6dpKC3ln
 upNKpE/NniOGBY8NSnhe6Xi1lgdJ7GssEffGanirQxPnfP/7Y73PaavFzStSMHuTk4q9
 qM2WCxM2Jz9uoUO7ISgrQDXXTTBLrDVc+jc7YhmXNvM2A7U6T8zknUMpwLdVSf9r/z4P
 aKUWLSUCkAUX8dmvR0zCA9XT50c86ISSvZrdFwngvt3/EMF258NVI4kQd8Fp19ZnB9qs
 kgeHbwAo6vIBZLq22Q6otm0oX8yqExL7lTsUy4ZUNpKvt+IhZE27t16tPhpz1Ev0rZw/
 5FXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=TnPwYQQCLG5EwGMFMNfkHPtD213tl1kqbBEbCh/GXFI=;
 fh=PcuXpK2bfC7EoNuuaJPQqLtQ9sEGkoQsnR4/5XYLgv8=;
 b=pQ/L0GtkhZaq7mEed3qQ4bw7R6Erqjo+AnmLYfq25KC3XIb4KAluE/8HwaHvKCTJ98
 nE3efXJ0DqYSQN/27kVbARVBmi/V4OGy3SQ3jXAy2W4Ic5nnmIPcnIDO/OwBnYFdH0FX
 BvNEFFGc2qdPEAfmEm9v+s2YrXd/5JFy2HM7i4hz981gLVzee+M74Asch/E5Ei1Y1oyi
 VBrfCtwVU70UeL5ATcHxLOsMQPLST3lT582lWxZ2PfPMQcNuLdvg/inCwlNSVYadPtWL
 aUuMvjGDusq5K5gP9b+3/M8GCyA5ahAZdmQLMjvgZzRLlCgfsn5VXmL+V80nTAVQngEx
 AcMA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787771850; x=1788376650; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=TnPwYQQCLG5EwGMFMNfkHPtD213tl1kqbBEbCh/GXFI=;
 b=AxVe1F/r9vCrGeNZZ4t5eDDbi0ZNjuLpDfDbzaSktPks8AJ6ylThmDNjplsUqeEEkc
 VgX79r51sHGgNtnh25oB5zO/2gAubL2dCChc6yDwg7bQBouDra7npMBXRJR5wcO703gY
 Cys5989TRJme1LibcpVMHK4gbgIffWoTVH5kkIsfHAP1BZfBojxf6rDysUZG96r9M7VN
 Nk2YBFg0SvKGAzMjOPjF+eBYH2ks6EWzmph6pN3cjp7QAntPE0UpZ2u3yScNhWL9sGxS
 HYP87fism3LIib3H3Nc4iDNWckovRUEcSFIeqqCeUB3OsULn/S+6ewBuzYHEDzU3bk3K
 HzyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787771850; x=1788376650;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=TnPwYQQCLG5EwGMFMNfkHPtD213tl1kqbBEbCh/GXFI=;
 b=YCF3R+Skv7tAeaZipB6Xed1lIfOJjFXL0OqUoze9no2iOycUFvhBZqwXNdE6zVU2b4
 u1xi+MJp2LichKYecufNlcPT1SeNhPl//e0qH/8Raw92xqmp25UU1EapeI3l1F3wxtCD
 eqyuYA1+FgmmQNrDG8ITjZIYaQyjAnMNy016jkHJBzj/wv22H7dmTT2+/IQQR34m/Oaj
 5ou9MgCVsCmiLBJyDl4S9u8RR4wO1BXQSEfrjgc4ykZRw8ZDNLfTVGXRKMSj8CE64BWI
 Kgpr4byH0PX93gK5HCjgvSfPUX9J2MUtHj6kn1my7/5kfxW0rm6eRClxffneZl/K+DRA
 Pv/A==
X-Gm-Message-State: AFuF++mdnkiGUDxqaayBWSJghWymdmsMfHUDqL9DDau6PV10Ucrr22kk
 GWfnwf2KC/oVMqNCz7WzKyL+DUDXG9TJ9aYppcS6cxIQa3rni9x8RhhAMuPrBTa/XX9t0YUf5w6
 tbrs+uvsIisF4SaVCrORlcGpGpQFh6/SlvngKbiHqe0VNuIuVIpQuDEDorbx9ZbVM/W/7QvFjnQ
 godzfAbKHjAchdYy+N1aFNWUMqPkxw6BA=
X-Gm-Gg: AR+sD102xp6glGHyaKsZJ4ltjSy+RrSb/ydNB5K6Xvs1zo31fTeqHEiEjbinPAIKt4L
 ArwT8Kq30ZKi89AlFm6zd+CRKwzQ6Zb7cbq4s3KGl5gTq/7USvbN+8QQZ/yptqx238TNJ0adglj
 wv1di/HSFEI6wkUCwQRuefQlqtTEyx86NunFrRnaBFN/xnS50vzRPdPSRDYop44hlA/tqhlIXB/
 NqPjxyEFN9unX3yuT4Iw68O7ujAF6jT7MMI6Pof1+HlwSyuiUOVpXQPHZC50ZDD1cnVfpM4vd5l
 oQ==
X-Received: by 2002:a05:6a20:7f88:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3cf84e50685mr13454829637.14.1787771849741; 
 Wed, 26 Aug 2026 12:17:29 -0700 (PDT)
X-Received: by 2002:a05:6a20:7f88:b0:3cd:2e96:5929 with SMTP id
 adf61e73a8af0-3cf84e50685mr13454746637.14.1787771849222; Wed, 26 Aug 2026
 12:17:29 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-46-af60857c2fbe@redhat.com>
 <0d110721-caa0-45de-a528-5103c4d89407@oss.qualcomm.com>
In-Reply-To: <0d110721-caa0-45de-a528-5103c4d89407@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 23:17:17 +0400
X-Gm-Features: AcwNN1WsYJvKBJLMq2D1BoFksxGgYiDf-mp1crxoUuyZk1urRr0q5F-nGioo6yY
Message-ID: <CAMxuvayEYthyRYE1kV2zdSZR5wdxz2J3DMwaALhFGf2zkT=2hw@mail.gmail.com>
Subject: Re: [PATCH v4 46/49] monitor: move monitor_hmp_print*() functions to
 hmp.c
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mlureau@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

On Wed, Aug 26, 2026 at 9:51=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 25/8/26 21:09, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Those functions are only used when CONFIG_HMP, compile them out, and ad=
d
> > conditions for the calling code.
> >
> > Reviewed-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   monitor/hmp.c       | 49 ++++++++++++++++++++++++++++++++++++++++++++=
+++++
> >   monitor/monitor.c   | 49 --------------------------------------------=
-----
> >   util/error-report.c |  3 ++-
> >   util/qemu-print.c   |  6 ++++++
> >   4 files changed, 57 insertions(+), 50 deletions(-)
>
>
> > diff --git a/util/error-report.c b/util/error-report.c
> > index 78ccb6ea608e..111bfe29020b 100644
> > --- a/util/error-report.c
> > +++ b/util/error-report.c
> > @@ -35,10 +35,11 @@ const char *error_guest_name;
> >   static int G_GNUC_PRINTF(2, 0)
> >   error_vprintf_mon(MonitorHMP *hmp, const char *fmt, va_list ap)
> >   {
> > +#ifdef CONFIG_HMP
> >       if (hmp) {
>
> Would this work?
>
>          if (IS_ENABLED(CONFIG_HMP) && hmp) {
>
> >           return monitor_hmp_vprintf(hmp, fmt, ap);
> >       }
> > -

No, unless we add a stub for it. I don't think it helps much.

thanks


