Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D7F7C78854
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 14:43:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sreqT-0006NH-QF; Fri, 20 Sep 2024 10:42:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sreqS-0006Mk-Ll
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 10:42:52 -0400
Received: from mail-pg1-x52f.google.com ([2607:f8b0:4864:20::52f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <chigot@adacore.com>)
 id 1sreqR-0008LN-4q
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 10:42:52 -0400
Received: by mail-pg1-x52f.google.com with SMTP id
 41be03b00d2f7-7db637d1e4eso1591541a12.2
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 07:42:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=adacore.com; s=google; t=1726843369; x=1727448169; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=QV3tkCJZpqYIsFZt6bE5z89vyV7l9fDqhMQq/+HqN+c=;
 b=e6qNzR+gyPI6WU51Bhlpp96okSFHSdO4eIDSh/73yNIgbD8lwQOBjKHnac0pMYeDKU
 6/7SmM6FHrMQcUBlgFBZLlLb7rUSennuuiOQQ3elxY7liP3X2FWOYB5u9bIMLn8qIwKe
 jNMGQTtjDzXT0nS9syRZfVI9UB8cGbpjiiVlS88WDm6iXbAC107E6JT03n3zN5tuSHIx
 uHNI9RxZyYOG2jbsAoC6QDpVl8k3sKO1vEQHX0ue7VG2opeXORqUWhqWqi4xn1WTHeTf
 9jFYGsmC+TBrScfpqzSj5n67bYJ6CdfBhWvu6DUfu0WC06sv2muc2fl2S0ug5lChn7PL
 YhJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726843369; x=1727448169;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=QV3tkCJZpqYIsFZt6bE5z89vyV7l9fDqhMQq/+HqN+c=;
 b=k3vKC4T/jS5wBHdeENBcKcIGIzO9TnoBektCT3YhKdL25p6SzIpAJod7iNu2dEQa8q
 L3KWJsg6TSDkf3QkdvvhtHIbXa2YN/Krh6XqPovzUtRsKfV6Beppy/ndPuNgRC+mpJ/o
 d2dUxeDoViUZyfRcYPPdBVfEmRysyc1DyUjDP1ARiGt+Gw2gIzzp+nMkqs9aSNt82ZX8
 sCHe3rTXvqJ7hwDn/DU5aBTb0N16JA6je/4i+IAcNpvu+9CBDWAz3bg8T7VAqArlnRAQ
 UlGKu/AWy8SiM7p10ghMusXkx9KVW9KjsvVFoNGErZO5s53TokM35lDwUAeOcZ8WxevQ
 YOAQ==
X-Gm-Message-State: AOJu0Yx/8KAdWONsTsEHnCAwXy2Q99JkwEXZ5m+hUsbdTuCDkmzx7w0B
 6YBRV1iRTtAr73lNIh1G0vSpCUA4QSF9WkmaHhqOme0dX/PE66xwmA5CxhwBAbA/Vgp9WP5Ot5i
 C2fcKV62EzLVRh0BiBSVzOSRF4J1nBVmkDiyp
X-Google-Smtp-Source: AGHT+IHv5OfwWi1qtFNbvZdEo+wFohtmYdrs+Nn4Vhxx45SC/4QwWivWJCdW4gGVq6/aZDrHGYih/G+lwDGjcCTHybc=
X-Received: by 2002:a05:6a21:39a:b0:1d2:e81c:ac76 with SMTP id
 adf61e73a8af0-1d30cada9e0mr3431563637.32.1726843369276; Fri, 20 Sep 2024
 07:42:49 -0700 (PDT)
MIME-Version: 1.0
References: <20240715084639.983127-1-chigot@adacore.com>
 <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
In-Reply-To: <42fe0e65-e1c1-47be-9ba1-9a43e4a05192@kaod.org>
From: =?UTF-8?Q?Cl=C3=A9ment_Chigot?= <chigot@adacore.com>
Date: Fri, 20 Sep 2024 16:42:38 +0200
Message-ID: <CAJ307EjvT1PES6VV96NRj+PNtbhjqRiHX+b73wAReaQjQHfv3w@mail.gmail.com>
Subject: Re: [PATCH] hw/ppc: fix decrementer with BookE timers
To: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>
Cc: qemu-devel@nongnu.org, npiggin@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::52f;
 envelope-from=chigot@adacore.com; helo=mail-pg1-x52f.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Hi C=C3=A9dric,

On Tue, Aug 27, 2024 at 7:40=E2=80=AFPM C=C3=A9dric Le Goater <clg@kaod.org=
> wrote:
>
> Hello Cl=C3=A9ment,
>
> On 7/15/24 10:46, Cl=C3=A9ment Chigot wrote:
> > The BookE decrementer stops at 0, meaning that it won't decremented
> > towards "negative" values.
> > However, the current logic is inverted: decr is updated solely when
> > the resulting value would be negative.
>
> How did you hit the issue ? which machine ? I didn't see any error
> when booting Linux 6.6.3 on mpc8544ds, e500mc, e5500 and e6500.
>
> > Signed-off-by: Cl=C3=A9ment Chigot <chigot@adacore.com>
> > Fixed: 8e0a5ac87800 ("hw/ppc: Avoid decrementer rounding errors")
>
> LGTM,
>
> Reviewed-by: C=C3=A9dric Le Goater <clg@redhat.com>

Unless I'm wrong this patch has not been queued yet. Is there any
reason for this ?
I just want to make sure it hasn't been forgotten.

Thanks,
Cl=C3=A9ment

> We have some automated tests with the ppce500 machine which it would be
> interesting  to extend to have a better coverage of booke.
>
> Thanks,
>
> C.
>
>
>
> > ---
> >   hw/ppc/ppc.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> >
> > diff --git a/hw/ppc/ppc.c b/hw/ppc/ppc.c
> > index e6fa5580c0..9fc85c7de0 100644
> > --- a/hw/ppc/ppc.c
> > +++ b/hw/ppc/ppc.c
> > @@ -729,7 +729,9 @@ static inline int64_t __cpu_ppc_load_decr(CPUPPCSta=
te *env, int64_t now,
> >       int64_t decr;
> >
> >       n =3D ns_to_tb(tb_env->decr_freq, now);
> > -    if (next > n && tb_env->flags & PPC_TIMER_BOOKE) {
> > +
> > +    /* BookE timers stop when reaching 0.  */
> > +    if (next < n && tb_env->flags & PPC_TIMER_BOOKE) {
> >           decr =3D 0;
> >       } else {
> >           decr =3D next - n;
>
>

