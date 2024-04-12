Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6341FC4345F
	for <qemu-devel@archiver.kernel.org>; Fri, 12 Apr 2024 11:54:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rvFTT-0005Qz-7D; Fri, 12 Apr 2024 07:53:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvFTR-0005QV-7L
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:53:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1rvFTP-0005N2-Ot
 for qemu-devel@nongnu.org; Fri, 12 Apr 2024 07:53:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712922818;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j7hWBKIAyBw6jgPbTNH+lqA7uOFmsZI15xA0xyu4X74=;
 b=WxZpTf67dNY5VQrqCa0RV9DL02u+DnNDxFKcR6e1VmZNQ54ONfxnepOpCOcg6AFCC5yroH
 QXzz+/fdTwdpTnCCmtCdW8LNSc3lV1SjWcJEQ8M1zMP8kC/OEbZDskFw6d1FqVJwiV+u6z
 Y92UYMmQu1N9RGZ+QBEKWhAQ9+XcsrY=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-4r8sTHwdOCKnjeG2p5w7zw-1; Fri, 12 Apr 2024 07:53:37 -0400
X-MC-Unique: 4r8sTHwdOCKnjeG2p5w7zw-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-516cfff88deso613713e87.2
 for <qemu-devel@nongnu.org>; Fri, 12 Apr 2024 04:53:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712922815; x=1713527615;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j7hWBKIAyBw6jgPbTNH+lqA7uOFmsZI15xA0xyu4X74=;
 b=JRncvU97IOWppN8rI4JKGoapKpbsSEmmQlvP/DSgR3/ntA7WLs+v6NG/B1YPGhcsFQ
 z3DNZnahvFAdT1ccQWsw9oj4Hqqvs+D2+0fSJLvpWZGIQpFpit3Ye6NNpkUpzmvhbS6j
 pI/9He/ihwYF3P8QnUDEOQBOEflAs5+SwuXcIshTkbl+m8AXi4/50dv/OGkAiLsF/cXx
 /KUvsVuDF1E5DWJipJnUGr00N2akQvT9wgGhXT578PN7Oks/S9ONE33b5oa+H12ceonl
 RosUQPD7cuA3EBMOshlRzX2WfBFenY2Kv29j8g+eHlsr6a0wwj3aSEUBt1s/20CAzWkW
 kAlQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWieDv2tHbMu0b2lWJ2GU7SN3IfK0rbWalqMhorlRd2lFfIzfjGEsWf6+H9yyGMA6giW928HyTnfCR9fgy3VCi8g5D4SI=
X-Gm-Message-State: AOJu0YyP/y2/SToOX7UVlI8Ugunf3RAOtD8J5kexhB/JeXkuLsbnzQa2
 p+U+AAvqb4nysN1DfE3zzX7GSQzS+iZut/r0uw3CZpYFo0Ez4yUvkKGamX1L3+sz10OcpvpfQN4
 rGeU/8UkY0hDT/eJni1c7oq+RAwg67BeHdsB38WCfTZHhKCxSzYc+ggqHkcBs5jzntpAaeJS/tQ
 ppzJQVSxJNWAzoYZhMp4j84jiHgdM=
X-Received: by 2002:ac2:528c:0:b0:518:7e4a:2035 with SMTP id
 q12-20020ac2528c000000b005187e4a2035mr1161904lfm.45.1712922815567; 
 Fri, 12 Apr 2024 04:53:35 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE48o3THnFHJhM63yPTxw4l2QVzMDlyNyvNmh41taPJYXcCYGyEiKSP+9aIOgZFyVI3gk5uz5HuyJjsKDcdSH8=
X-Received: by 2002:ac2:528c:0:b0:518:7e4a:2035 with SMTP id
 q12-20020ac2528c000000b005187e4a2035mr1161892lfm.45.1712922815119; Fri, 12
 Apr 2024 04:53:35 -0700 (PDT)
MIME-Version: 1.0
References: <20240402081738.1051560-1-martin@geanix.com>
 <81117f0e-407b-4729-bb78-cbadc196c8f1@proxmox.com>
In-Reply-To: <81117f0e-407b-4729-bb78-cbadc196c8f1@proxmox.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 12 Apr 2024 13:53:22 +0200
Message-ID: <CABgObfbA1rxXPfo4QiH7jczxRXi-=RtGAUXNEQ6MMy70zpqeRg@mail.gmail.com>
Subject: Re: [PATCH] Makefile: preserve --jobserver-auth argument when calling
 ninja
To: Fiona Ebner <f.ebner@proxmox.com>
Cc: =?UTF-8?Q?Martin_Hundeb=C3=B8ll?= <martin@geanix.com>, 
 qemu-devel@nongnu.org, qemu-trivial@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -41
X-Spam_score: -4.2
X-Spam_bar: ----
X-Spam_report: (-4.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.103,
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Apr 12, 2024 at 1:52=E2=80=AFPM Fiona Ebner <f.ebner@proxmox.com> w=
rote:
>
> Am 02.04.24 um 10:17 schrieb Martin Hundeb=C3=B8ll:
> > Qemu wraps its call to ninja in a Makefile. Since ninja, as opposed to
> > make, utilizes all CPU cores by default, the qemu Makefile translates
> > the absense of a `-jN` argument into `-j1`. This breaks jobserver
> > functionality, so update the -jN mangling to take the --jobserver-auth
> > argument into considerationa too.
> >
> > Signed-off-by: Martin Hundeb=C3=B8ll <martin@geanix.com>
> > ---
> >  Makefile | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/Makefile b/Makefile
> > index 8f36990335..183756018f 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -142,7 +142,7 @@ MAKE.k =3D $(findstring k,$(firstword $(filter-out =
--%,$(MAKEFLAGS))))
> >  MAKE.q =3D $(findstring q,$(firstword $(filter-out --%,$(MAKEFLAGS))))
> >  MAKE.nq =3D $(if $(word 2, $(MAKE.n) $(MAKE.q)),nq)
> >  NINJAFLAGS =3D $(if $V,-v) $(if $(MAKE.n), -n) $(if $(MAKE.k), -k0) \
> > -        $(filter-out -j, $(lastword -j1 $(filter -l% -j%, $(MAKEFLAGS)=
))) \
> > +        $(or $(filter -l% -j%, $(MAKEFLAGS)), $(if $(filter --jobserve=
r-auth=3D%, $(MAKEFLAGS)),, -j1)) \
> >          -d keepdepfile
> >  ninja-cmd-goals =3D $(or $(MAKECMDGOALS), all)
> >  ninja-cmd-goals +=3D $(foreach g, $(MAKECMDGOALS), $(.ninja-goals.$g))
>
> Hi,
>
> unfortunately, this patch breaks build when specifying just '-j' as a
> make flag (i.e. without a number), because it will now end up being
> passed to ninja:

Yep, I've sent a pull request with the fix.

Paolo


