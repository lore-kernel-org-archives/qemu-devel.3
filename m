Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8984ECF58C6
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Nov 2025 18:09:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLmc0-0002ax-CX; Wed, 19 Nov 2025 13:09:00 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLmbw-0002Yk-Nq
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:08:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLmbv-0002s2-82
 for qemu-devel@nongnu.org; Wed, 19 Nov 2025 13:08:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763575734;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e4w9qUfBPNqlHWR761GYigXjDzqbKAXHlPl3evsHnXw=;
 b=GGqP+m6VlK9mD75IymC6NURH7KSIVt2genZbGTXZyyEmeki4f5vvXOBYEUS4xI/5wNMR64
 +Ecsc9XsQ6Zn0lQLU8QTO5GPa6lZtUuoL66Z/5Plu67zLFEH0CGNJir52z40TemMH9GMik
 5ArStutX0DNMns4zFIxJwGL8Y3PhBiU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-x1qFzs0-MJWlbiph_J5JDQ-1; Wed, 19 Nov 2025 13:08:52 -0500
X-MC-Unique: x1qFzs0-MJWlbiph_J5JDQ-1
X-Mimecast-MFC-AGG-ID: x1qFzs0-MJWlbiph_J5JDQ_1763575732
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-429c93a28ebso14486f8f.1
 for <qemu-devel@nongnu.org>; Wed, 19 Nov 2025 10:08:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763575731; x=1764180531; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=e4w9qUfBPNqlHWR761GYigXjDzqbKAXHlPl3evsHnXw=;
 b=hGgh/bWLiBiGGCEkNjkmJYT0NNJR6xZ2kbznOgqtAufpxLBDN4GO7Ydz1wCW0vlTtG
 0H1zMPvb5aJ5utLZ8IUJyo6JQ2Z0JGvi3B3kfp4kb88agpxUfympSYUvcp1XJ94Y9cD3
 75fDhKqyYHhPq0iXjc9jCAMycitmjySnLBERpicht74L66IPX/brGrv0L561HDUC9U7J
 BpfDlFH1Ouc0tCQApmz/iBjjYxw5/tgngw7a/ByPY1F/4E0MlNtCrXmGphedNKAuk2AD
 HMbqkZFjfnIdCMvfpDw5BYmlr81RcA/3LpTLiDZoDWYBhX37luEINSXikNslz9/eumLt
 PJCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763575731; x=1764180531;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=e4w9qUfBPNqlHWR761GYigXjDzqbKAXHlPl3evsHnXw=;
 b=TXd7xvZGa84nytpsTeML+IDiszByKDWDFBD5fgItJlNNcUKIUpGQdvoUEoAl438GeJ
 gHKuOOs8lVq0sxJATTKVZHVRCIyO+iCtkzSriZlUviQgxJqr828x05YqVTDrxBRjYxob
 TC0MR4Mxvf4cl7BOCkMqGiMA/qx0K7YjzH1MFH0fgX6sosvhciqeyXdTmkJICcsbvsVm
 rtCCeeTUKpxmmYvkRatVhEC08EoAyQ9EmSaSAk6l1XGk+HFgzHjXA3RZ3QFUArvvU+r1
 Rcp1Ew4RCyiAGYT4YjStYlQD5l6A7TE8AAospVXkWRUz46ePgK8OhbWOteuRT0DTCp9E
 gkhA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVKJ1MAoKJyLb6OL6sS/+ig0N7Bo2azvPur+GadVEu5oWJdZvvcZDI5woDyfAwsg7mvRB8jq9ne/5DR@nongnu.org
X-Gm-Message-State: AOJu0YyRSe4AHkVEpbiTZdTLl43T7/dJfM9UJYxKbD9gCPE+CLlIx4MP
 jzHffMzzE7E0UcS4Dvezg2ZTRZLHJnU0lFTBz6wmr0eUxMGDoketLfgVJLaq09JvXBmbcNVX6MD
 ZPj9NkIpRV7SOPZkKnujR33nlXT61JqAjHEI3fX5v166zg7g3S0ycwL6TyV/jcAOXSuTo74lYbT
 /1mM4sZ1GwS3RYtq4UjCJUO9PZSgpqrL0=
X-Gm-Gg: ASbGnctP8gof6JW/YfwI6v7XuvOP7xN6Q0o/sSfpMBSfh8hjf2oiuXrDi276Fw9vYMu
 RsWXIYyrlTPWIEdPXZiAzVgFxegw+UaNxR5fHYWcmlC0wxMoceYjgx51RvYoEMxA/oBUOcl4vG6
 +XxFXhsHwU/OvrVgk47pT6+3/80IhLdFOa4I/FF0Y1DqnjtGocrlR6JlkBYls2jp0Hx88ogOMwh
 ir7ylbRpNjmCCXyyiajqCZGjtsX8jWCl4S3sk4yvqXmsJfdIXIpzp+s8iRcNsZ8a4l5YNY=
X-Received: by 2002:a05:6000:40de:b0:429:8daa:c6b4 with SMTP id
 ffacd0b85a97d-42b593497d8mr19539690f8f.21.1763575731484; 
 Wed, 19 Nov 2025 10:08:51 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEFM3+HiCKuo+MB8yCGXu3hopFkEu2pEqFtoOTpey/HAF3kWb7fs4h9KqgFD0kfB73wWdRQReAFNiiZ+raP7ac=
X-Received: by 2002:a05:6000:40de:b0:429:8daa:c6b4 with SMTP id
 ffacd0b85a97d-42b593497d8mr19539669f8f.21.1763575731072; Wed, 19 Nov 2025
 10:08:51 -0800 (PST)
MIME-Version: 1.0
References: <20251118065817.835017-1-zhao1.liu@intel.com>
 <20251118065817.835017-5-zhao1.liu@intel.com>
 <CABgObfZfGrx3TvT7iR=JGDvMcLzkEDndj7jb5ZVV3G3rK54Feg@mail.gmail.com>
 <aR1zIb4GHh9FrK31@intel.com> <lhuh5upzyob.fsf@oldenburg.str.redhat.com>
In-Reply-To: <lhuh5upzyob.fsf@oldenburg.str.redhat.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Wed, 19 Nov 2025 19:08:36 +0100
X-Gm-Features: AWmQ_bnP_jPIBa_pCEhGrRI1O_HVzZjEH7dyW6CfW-AYdWmRuTyzlIIDNIWUIl8
Message-ID: <CABgObfaXxJjOzJs_mhnq7_VnjgkMmirXhXXW7XDP=DindV6eLw@mail.gmail.com>
Subject: Re: [PATCH 4/5] i386/cpu: Support APX CPUIDs
To: Florian Weimer <fweimer@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, qemu-devel@nongnu.org, kvm@vger.kernel.org,
 "Chang S . Bae" <chang.seok.bae@intel.com>, Zide Chen <zide.chen@intel.com>, 
 Xudong Hao <xudong.hao@intel.com>, Peter Fang <peter.fang@intel.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, Nov 19, 2025 at 7:04=E2=80=AFPM Florian Weimer <fweimer@redhat.com>=
 wrote:
> This sentence (from APX spec rev.7) emphasizes the =E2=80=9CIntel=E2=80=
=9D vendor,
> > and its primary goal was to address and explain compatibility concern
> > for pre-enabling work based on APX spec v6. Prior to v7, APX included
> > NCI_NDD_NF by default, but this feature has now been separated from
> > basic APX and requires explicit checking CPUID bit.
> >
> > x86 ecosystem advisory group has aligned on APX so it may be possible
> > for other x86 vendors to implement APX without NCI_NDD_NF and this stil=
l
> > match with the APX spec.
>
> Well yes, but I doubt that the ecosystem will produce binaries
> specialized for APX *without* NDD.  It's fine to enumerate it
> separately, but that doesn't have any immediate consequences.  GCC makes
> it rather hard to build for APX without NDD, for example.  At least more
> difficult than building for AVX-512F without AVX-512VL.
>
> I just don't think software vendors are enthusiastic about having to
> create and support not one, but two builds for APX.  If NDD is optional
> in practice, it will not be possible to use it except for run-time
> generated code and perhaps very targeted optimizations because that
> single extra APX will just not use NDD.
>
> I feel like there has been a misunderstanding somewhere.

I totally agree and I think this addition to APX was very misguided,
no matter who proposed it.

However, for virtualization we probably should include this code no
matter how much I dislike it, because having to add the bit later
retroactively would be worse.

Paolo


