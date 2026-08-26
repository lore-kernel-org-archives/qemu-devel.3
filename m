Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64C11C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 19:10:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzJ0b-0005ZH-9Z; Wed, 26 Aug 2026 15:10:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzJ0V-0005Yk-LC
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:09:55 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mlureau@redhat.com>)
 id 1wzJ0U-0008VS-4P
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 15:09:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787771393;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UI54ihRye5WuTb+5lLrRnCJeFEVcX8YehASulQJZGTc=;
 b=BNBmHqrE7pDWSWLjGOwMAhTAfHx8KgLOx4e6his6qdSwxPni/irdsm5YpBYMQtO5CrM9uJ
 Y/VvIzib6GZtFFHkeyluurMEMqbwE4r6b1+QIDvuecE2mswUWG56VQZU58t0/WJZ2A5MKs
 3JhZuyLaxWhSxe0IarBp5NEXRmWtdtU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-WTXKX3l-NgSvs8XR13Q-Rg-1; Wed, 26 Aug 2026 15:09:50 -0400
X-MC-Unique: WTXKX3l-NgSvs8XR13Q-Rg-1
X-Mimecast-MFC-AGG-ID: WTXKX3l-NgSvs8XR13Q-Rg_1787771390
Received: by mail-pl1-f200.google.com with SMTP id
 d9443c01a7336-2cfa55c9430so15333765ad.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 12:09:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787771389; cv=none;
 d=google.com; s=arc-20260327;
 b=fAgw18r0B0OWXcX7TtlL93ZBAPEElW6Y2FCd6f7DrqsNCrVtpoRqh8vhbOLZZs2uMZ
 xH2UXXKgvm0lP2gWjfHrMar9rLmCIeEiDquQv5Qu7ESXERRDbpmTgvj8JroXJsOXovZS
 7JEmCa4W5eAyu4RvaymIOptc66VXzBcQbDtlyfWjrMUy+kO8sAVXJB2FJcvoO2Gtkut+
 GHFZjt2yoUH++eHYFJleEXhRBT8TtO0to+g8yW1iStzdcdhhpL+nAX0wNUPvTfJAEK/T
 TAIx6UlmpLsnZKiJKWfOJFk4azL9VZ+BkYkld7IbcvmIiIFJqpoEmCCn3KJMgMdAU7lo
 ZSPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=UI54ihRye5WuTb+5lLrRnCJeFEVcX8YehASulQJZGTc=;
 fh=yZXqnuTGa6cs5/5ALRRPkSe2BSmCMet9xsCVoVoToJE=;
 b=fa7uZamOuz8bxA8ypAUZdLLdTb1cpyxJ9cTaY1bqYcl95W1VmbojZwuRyOKcD58xWI
 I/7AFjeR7YnZI3aPiCKz80zu9Hy8NVIM5jd5hanIZwLi4oKq05EFxMGh3nIAAkaDRUfJ
 0GbnAWyTRodE1+lGobh47S4yE5b7h545Qhw4fXHvXfKZx1WK4FSXPpb0L9PdMAHGOa6G
 2cMI0lRDFyopEGgQawfwL7H/DNcZuK1k5RzCGF+W9Ufk3IzLZKhVoz4EKkEi0G1/u9TY
 zVN5Ruqty8TLn1lq1fKzWikeTJgd6cB8CSagOey++4mjTuc+Mn3yp2S78q3+dxCLiPlS
 bV8w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787771389; x=1788376189; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=UI54ihRye5WuTb+5lLrRnCJeFEVcX8YehASulQJZGTc=;
 b=CYvove/xYTOAdOKghCsnW7F74poKlgkm+MVgsEusvIXBkTEoh1JNP0X/wzSFBGx13G
 +N9f4tj6CBjxDGnw94XSlDBuKGFHdiegx7h9gUXr2eM+IKryZlAVYRvi0Auw0XUxei8y
 G+cO5AhGaQ0xksyKeWB6yHsBAklRT4zU3qSjYTqyUawkBrS0EsQKfqDWEdoJVH5YWdWD
 j2hoVw2wQJz7SEuij75n2gQp9isWoMBL2e5A2XraE4KxlnrLRQHRiIkk1QN2H3KWC96b
 wiDH/YLBGspNFWLAn9lnuLRUBRyzL9siwhZOBBw4AqC0i20/opJJHpbau6wwYxJwi6KO
 7MIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787771389; x=1788376189;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=UI54ihRye5WuTb+5lLrRnCJeFEVcX8YehASulQJZGTc=;
 b=VU5wtpOxC5XU1kdAZzwv1WVfu3NN25Oh17R7l7WqbDK1PMVcpb7zT/sfW+YaxNZN9U
 dNJNtKgebqCJpwmyqxKKPL0z59zQxj076FECelL9bRGK5/Omvp0N6EoArC2kqCGCU4tL
 mHp7u513/oivg3MZ7SKTgFZDP15NfoH/SgbgkZHPBEAAxStOPktYtax4mJFN+a6tFqDM
 2PYlXziFJ9MnxQm/ejh1SrG9VNT8vvvXbBLFQBYJjrk76uLLOjDiKw8TEmJ/sQX3b0vN
 ZqePHLqRTTLHNGwUuPC0iTYrE+7oMm4bl/gtuoCmZmtqnmSB2AlS+XVIZLCt7pCawY+g
 FCfg==
X-Gm-Message-State: AFuF++kKXcceM8Fi4jMwj5J7a2c+yxrXdZ+Q0FTJjwsttf2zBP7Qk1Ww
 hCd9unXevHLwejPoOkRPNRWyMY2QeUbUKG9RmBf0u32ekQ8xYg4SsjAP/csqi4N5DUf6ZD+n+GJ
 xS5a40oElB1nzcrcCv2gBJ0+CzQPPweUT68cz0AOIS6qceW5gg1mVS+LQsIKI54huEguegrGKDl
 b+j+y06l1wuUqlV0IanxI/g0ynYVYPDps=
X-Gm-Gg: AR+sD101SQd06wePDp0+iP1FFUHzWZ9b+YMhauHo7TyEYfUK8GKPapV0AwohSEffxMR
 WR9gO+cogAl7uLzbwd8iCcPXoPRHoLvnpS9D11aGwOVEUFD79OPLPHZiv8klmd9Y8sv3Q5ZJGPF
 ofE/qz0OqyIfEEexXw3Ry3vsVAnTyGvOQ5nhivAp+tKw7se0Ct32OVZCatTOWvTzSLOBQjmPg7R
 yFw90igyqM/J02qBCPQBaJDFXWTEU6tI90yDBZbCRmi4xioM9KjVo9MVXLTH5Ob/MwVEWWBjJOq
 wg==
X-Received: by 2002:a05:6a21:7008:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3cf8445170emr19247856637.14.1787771389519; 
 Wed, 26 Aug 2026 12:09:49 -0700 (PDT)
X-Received: by 2002:a05:6a21:7008:b0:3bf:7bf7:7913 with SMTP id
 adf61e73a8af0-3cf8445170emr19247731637.14.1787771388938; Wed, 26 Aug 2026
 12:09:48 -0700 (PDT)
MIME-Version: 1.0
References: <20260825-qemu-no-hmp-v4-0-af60857c2fbe@redhat.com>
 <20260825-qemu-no-hmp-v4-44-af60857c2fbe@redhat.com>
 <f5d26ec2-7d6a-4441-afd9-fa064d4da1f2@oss.qualcomm.com>
In-Reply-To: <f5d26ec2-7d6a-4441-afd9-fa064d4da1f2@oss.qualcomm.com>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>
Date: Wed, 26 Aug 2026 23:09:37 +0400
X-Gm-Features: AcwNN1VeXwLi5wVVNyC45d6X2yfq9zTXLsGU-6hNQIxMdG3mAh0XzbaC4GOSpaw
Message-ID: <CAMxuvayQNfzKLGrpf01Am=xSQZjd3uCTwnE0Lb1p1VjvySzH4A@mail.gmail.com>
Subject: Re: [PATCH v4 44/49] build-sys: make HMP source files conditional on
 have_hmp
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, dave@treblig.org, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@mailo.com>, 
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Markus Armbruster <armbru@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Ani Sinha <anisinha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Jason Wang <jasowangio@gmail.com>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Laurent Vivier <lvivier@redhat.com>, 
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org
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

Hi

On Wed, Aug 26, 2026 at 9:43=E2=80=AFPM Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 25/8/26 21:09, Marc-Andr=C3=83=C2=A9 Lureau wrote:
> > Exclude all *-hmp-cmds.c files and HMP-only source files from the
> > build when HMP is disabled.
> >
> > Also conditionalise the hmp-commands.hx header generation and the
> > test-hmp qtest.
> >
> > Acked-by: Dr. David Alan Gilbert <dave@treblig.org>
> > Signed-off-by: Marc-Andr=C3=A9 Lureau <marcandre.lureau@redhat.com>
> > ---
> >   audio/meson.build         |  4 +++-
> >   backends/meson.build      |  5 ++++-
> >   block/monitor/meson.build |  4 +++-
> >   chardev/meson.build       |  5 ++++-
> >   disas/meson.build         |  4 +++-
> >   dump/meson.build          |  5 ++++-
> >   hw/core/meson.build       |  5 +++--
> >   hw/i386/meson.build       |  4 +++-
> >   hw/net/meson.build        |  4 +++-
> >   hw/pci/meson.build        |  4 +++-
> >   hw/virtio/meson.build     |  4 +++-
> >   meson.build               |  2 +-
> >   migration/meson.build     |  4 +++-
> >   monitor/hmp.c             |  2 --
> >   monitor/meson.build       |  9 +++++++--
> >   net/meson.build           |  4 +++-
> >   qom/meson.build           |  4 +++-
> >   stats/meson.build         |  5 ++++-
> >   stubs/meson.build         | 12 +++++++-----
> >   system/meson.build        | 11 ++++++++---
> >   tests/qtest/meson.build   |  8 +++++++-
> >   trace/meson.build         |  5 ++++-
> >   ui/meson.build            |  4 +++-
> >   23 files changed, 86 insertions(+), 32 deletions(-)
>
>
> > diff --git a/hw/i386/meson.build b/hw/i386/meson.build
> > index 39ac8c9edc09..e16930c43197 100644
> > --- a/hw/i386/meson.build
> > +++ b/hw/i386/meson.build
> > @@ -24,7 +24,9 @@ i386_ss.add(when: 'CONFIG_VTD', if_true: files('intel=
_iommu.c'))
> >   i386_ss.add(when: 'CONFIG_VTD_ACCEL', if_true: files('intel_iommu_acc=
el.c'))
> >   i386_ss.add(when: 'CONFIG_SGX', if_true: files('sgx-epc.c','sgx.c'),
> >                                   if_false: files('sgx-stub.c'))
> > -stub_ss.add(files('sgx-hmp-stub.c'))
> > +if have_hmp
> > +  stub_ss.add(files('sgx-hmp-stub.c'))
>
> This doesn't sound right: this is a stub and we shouldn't bother to
> conditionally include it.
>
> hmp_info_sgx() is defined in sgx.c, which you #ifdef guarded few
> patches before in #40 "Guard HMP command implementations with CONFIG_HMP"=
.
>

Yes, but it depends on CONFIG_SGX (which is poisoined).
There might be HMP stubs that we can get rid of by the end of the
series, but this is not one of them.

> Otherwise:
> Reviewed-by: Philippe Mathieu-Daud=C3=A9 <philmd@oss.qualcomm.com>

I'll take it :)
thanks

>
> > +endif
>


