Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EA8CCC5AD7B
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 16:52:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtTEF-0007pV-OB; Mon, 10 Aug 2026 12:51:59 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wtTEB-0007p9-8t
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:51:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1wtTE8-000331-R8
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 12:51:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786380708;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GACvxz+Gi8r20ZdVQ7KTd0KqO/j1EEg5JWiwJiwJph8=;
 b=cxdzIBI1IrxYK99KOtLGj1L8WpYIAGP+A2d8BrZUryn9FwcdjB0Ow+Wd8ZRm/V6WnTjGQB
 zYYfPdj6LUmXJqwGLjarlEuNir3kjufO70On02gCiwjXrLQe60wv1Q809yCSKD/JYiyEkD
 PYaDVg9AmU2K5r2X2WuBZjCsZDPm1i8=
Received: from mail-yx1-f72.google.com (mail-yx1-f72.google.com
 [74.125.224.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-694-bRQC7QT2PQmke4WzJPt_oA-1; Mon, 10 Aug 2026 12:51:46 -0400
X-MC-Unique: bRQC7QT2PQmke4WzJPt_oA-1
X-Mimecast-MFC-AGG-ID: bRQC7QT2PQmke4WzJPt_oA_1786380706
Received: by mail-yx1-f72.google.com with SMTP id
 956f58d0204a3-6693c3e04bcso6512841d50.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 09:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1786380706; cv=none;
 d=google.com; s=arc-20260327;
 b=eceoS4vVglPYTwEBwWP2QaTAWA9EpbIG1OoRnZJdbiRLuTVKtjXufP3jjE6FMYxn33
 d0aCb1ry0N2AmECcGGU9sS1D1b9j/P0XCNXAr0j4Fse6qp02XcpLvnbOOi0z6ZqX7uUp
 mZYh6+YXay7yWXQXKBQ8MAl5H06aaf+P+5FrfOPaOXY+Gemc5rHhgzVoEOhKGDXGvfbt
 /RlXSeIn3ZTmACp+GnFOZUfaIbHV3XnN3vFhUehlhciG5M8AoJWz474abbvt8uqyQmx+
 ik08doWaD26RHDoEqnXmkIzLhYZ91CNLZoQYnVrQBoDNNll+nNzyW2Q+cyOgaQQ6ilt5
 8POQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=GACvxz+Gi8r20ZdVQ7KTd0KqO/j1EEg5JWiwJiwJph8=;
 fh=CS5G7CdvRvg1fDoDIr88DyIMRsbd/ogKyrM5LeVMATU=;
 b=ZOQu1fnerRRiDvo4JzPcYNasPtBfvzlX6oY3lz4f9yYu+HXZUXKCT+7iYQgHPwOTem
 RsDn1Muv4KhdOjB36ku2muCLjouQufOy1tqlyw/rzBPUCa8PKituLeWqIw/v80TAAfwF
 qfoEWsVdLC2hzUay9UFZjxGinnJrA3uVwRkLvhFy1Oecjyfy5/g1hG6y626hC+j0X2Sy
 klHQaSTepfY+6+aTROHvDO5Nk55ybpzPqEX+1WGrlgQHxfnvwAZ1DJfNLGhO0sjciAeo
 /GTAPfyiqiAOZY4/yKGabc7G70kOtlpfYbI0mHpUJSooetfd8Yq9b9gLxHKBafoaFLcO
 5vmA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786380706; x=1786985506; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=GACvxz+Gi8r20ZdVQ7KTd0KqO/j1EEg5JWiwJiwJph8=;
 b=kO7heqqE7SDknDmFQSvybZWW+IPs//xxpD86uN6rkeUPDiO0cdNP2bvcT01QC3YLZ1
 hvVuXCLDdKVcCwn+c2ItNT7/SAZQhLH28O/I39cJzvKOgKNAcnWHW6rAZVsOgU44v9st
 pwiRRZchqiB6RmhUGPdFAZKrtxONK6Dl9hvzUqtPFM478utAGHi74QdxkDD4o8NYGmQE
 A5AesM/wzLuNEebkU0HD+y1pKDaBrHCULKLKROGAnsk4qGvLBjhkLOfLE0pipCnWm2/L
 p+Uh08brSAk3qqy+GPyH+AuJlzP4LvQg6+C+UQQpDUz1BEe1P9Ex59opH2gN6LrB/8Lq
 m2Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786380706; x=1786985506;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=GACvxz+Gi8r20ZdVQ7KTd0KqO/j1EEg5JWiwJiwJph8=;
 b=kS8BYbGIgWx8ZX/awSwiE00E/Me4hhTnWLnvN9vFIeVeE7Ybkh/QqP5a3cJvjk82sv
 Y93KF1B4Hik4gb9CyH/7y6LDwJzYUW3Ggcm4fH1WKg4lzV5qvbf+Qlo2HducvS7Yr2Gb
 IO/1dZIu3t/SwcnFu9OI8e8TgpNEuRR+VsCBGqID+Qr6oM4r/VorZDpsYNOkVbc7mnvS
 emC9Pw9we/zCxq9h+vhveh7HTeEYuUuD8Ujv13uFP4Jv4B/8oEgnnj14EzVWioOdaaVf
 7ALPfoaYWh91S9KEM7IP4gT3hIn2WDzRzGDHXchgz9Uh9S234AXi4/Lc97UA5kh2TVRQ
 FDqg==
X-Forwarded-Encrypted: i=1;
 AHgh+RqDdK4ugRAj/R2CnKSHRfXSB4ERxkgNB9prAMP+3zeK+U3aSXAwNpHzHu4Gzz5cg+Hj8wqIqRqXJi+S@nongnu.org
X-Gm-Message-State: AOJu0YxLLa9PnkJxsG4KHlfELn+b1GJPTNxTFD2tpoQ+azRwCt2sIoMw
 GOMkW4qCRs/yc+gwofRtfBECeGl13OiItE0Ayjob7dGZ0tp5/mjXyxoY6QUaFRbkAC1M8XioLPa
 KpUsncLOwlF9OJnLP9/OvmJ9HKoFikyKnnw54QxHQVFPAlZhl1v7f9tJ9UxOrkUS/GckoHchM4p
 TOMyOp9dX6kjnefQMmfEc1JxdUo2azsnE=
X-Gm-Gg: AR+sD11ZyUGYJ5hKmrh3VdxOIMxv/Tcjvtvm9eK7v+/bh98pEk+rWdwG1yxOrLp6iec
 Sw7bC32sA5RAK4nJblJft967cnyQS8NAFQRw6MUj3RyCiyEd4dCzPmaXkEon6UuiDrRaCJG2pu6
 KjkQ/okX4Cu77ikWcTyKlBdzsWKW92PcZt9fnV0A4FrPmFJbWWnqj2JVvHSKdMBydQMOkFS62sy
 VaM7Ddds+VvoXZn
X-Received: by 2002:a53:a786:0:b0:667:e04a:8a5d with SMTP id
 956f58d0204a3-6699ac1b1fcmr19888752d50.44.1786380705036; 
 Mon, 10 Aug 2026 09:51:45 -0700 (PDT)
X-Received: by 2002:a53:a786:0:b0:667:e04a:8a5d with SMTP id
 956f58d0204a3-6699ac1b1fcmr19888715d50.44.1786380704501; Mon, 10 Aug 2026
 09:51:44 -0700 (PDT)
MIME-Version: 1.0
References: <20260730081325.1816193-1-den@openvz.org>
 <20260730081325.1816193-2-den@openvz.org>
 <CAJSP0QUnp4=pPYQvGvTEoBCndvJb0o=Z0RzehP30KKK_svyXCA@mail.gmail.com>
 <f271fcff-4428-421b-b2b7-472cd8bf3cba@virtuozzo.com>
 <CAJSP0QX8JnTSWHQeQrH5dKHeC4oA9CMTzHAZNhzt_8gKorJ9Gw@mail.gmail.com>
 <3f84a950-d079-4e05-a3c5-daf81672b3e4@virtuozzo.com>
 <7239bc2e-b180-42ab-ae56-454557cb3194@oss.qualcomm.com>
 <20260803180228.GA365806@fedora>
In-Reply-To: <20260803180228.GA365806@fedora>
From: John Snow <jsnow@redhat.com>
Date: Mon, 10 Aug 2026 12:51:32 -0400
X-Gm-Features: AUfX_mxhmDLNlwlrsqhwE3wZmUtaRn3Y1MSbRFH6GmKvaxWL5BHxfzM5ubA0XrM
Message-ID: <CAFn=p-abWtYqGtCbH9XTK62oEPK=vLPjy-scwqR+crXvOQ3RrA@mail.gmail.com>
Subject: Re: [PULL 1/8] MAINTAINERS: add myself to IDE maintainers
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>, 
 "Denis V. Lunev" <den@virtuozzo.com>, Stefan Hajnoczi <stefanha@gmail.com>,
 qemu-block@nongnu.org, 
 qemu-devel@nongnu.org, "Denis V. Lunev" <den@openvz.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -14
X-Spam_score: -1.5
X-Spam_bar: -
X-Spam_report: (-1.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_BL_SPAMCOP_NET=1.347, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On Mon, Aug 3, 2026 at 2:02=E2=80=AFPM Stefan Hajnoczi <stefanha@redhat.com=
> wrote:
>
> On Sun, Aug 02, 2026 at 04:13:35PM +0200, Philippe Mathieu-Daud=C3=A9 wro=
te:
> > On 31/7/26 23:17, Denis V. Lunev wrote:
> > > On 7/31/26 22:18, Stefan Hajnoczi wrote:
> > > > On Fri, Jul 31, 2026 at 9:45=E2=80=AFAM Denis V. Lunev <den@virtuoz=
zo.com> wrote:
> > > > > On 7/30/26 16:55, Stefan Hajnoczi wrote:
> > > > > > On Thu, Jul 30, 2026 at 4:14=E2=80=AFAM Denis V. Lunev <den@ope=
nvz.org> wrote:
> > > > > > > Signed-off-by: Denis V. Lunev <den@openvz.org>
> > > > > > > CC: Stefan Hajnoczi <stefanha@redhat.com>
> > > > > > > CC: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>
> > > > > > > ---
> > > > > > >   MAINTAINERS | 1 +
> > > > > > >   1 file changed, 1 insertion(+)
> > > > > > >
> > > > > > > diff --git a/MAINTAINERS b/MAINTAINERS
> > > > > > > index 902db77218..4628793dde 100644
> > > > > > > --- a/MAINTAINERS
> > > > > > > +++ b/MAINTAINERS
> > > > > > > @@ -2160,6 +2160,7 @@ F: docs/specs/edu.rst
> > > > > > >
> > > > > > >   IDE
> > > > > > >   M: John Snow <jsnow@redhat.com>
> > > > > > > +M: Denis V. Lunev <den@openvz.org>
> > > > > > Waiting for acknowledgement from John.
> >
> > Note, Denis is not removing / replacing John, but simply
> > stepping up to co-maintain an area unattented since quite
> > some time. I doubt John will oppose to that precious and
> > scarce help.
>
> I don't think so either, but he should be involved in the process of
> adding a co-maintainer. There is no rush, let's give him a few more
> days rather than making the decision for him.

My apologies, I was entertaining house guests and was not reading my
email. I had intended to drop down to just "Odd Fixes" and could swear
I sent a patch to do so some time ago, but apparently this never took.

Obviously, I have not paid a single drop of attention to IDE/FDC for
quite some time and am elated to hand it over to someone with an
active interest in fixing it up.

The reason I haven't been paying attention to IDE/FDC in general is
due to the work required to verify and rewrite (often) low-effort CVE
fixes. CVE hotfix patches for IDE in my experience usually just added
an early return to the callback event loop to avoid a NULL
dereference. These patches often didn't validate or test the register
values or event loop state, and finding the "correct" error return
strategy was often quite a lot of work that involved testing on quite
a lot of operating systems to ensure we didn't break legacy systems,
and this amount of work was in conflict with my other
responsibilities, so it often got pushed by the wayside.

None of that excuses my silence and unexcused absence, and for that, I am s=
orry.

Please, please do go ahead and take over.

Apologies,
--js


