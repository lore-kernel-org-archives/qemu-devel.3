Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07FF0E77188
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jan 2025 17:11:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tTOiD-0007vs-Vv; Thu, 02 Jan 2025 12:10:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robh@kernel.org>) id 1tTOiB-0007vd-GJ
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:10:19 -0500
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <robh@kernel.org>) id 1tTOi7-0003cz-F1
 for qemu-devel@nongnu.org; Thu, 02 Jan 2025 12:10:18 -0500
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id DBAB55C5521
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 17:09:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E469AC4CED0
 for <qemu-devel@nongnu.org>; Thu,  2 Jan 2025 17:10:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1735837803;
 bh=eUySbjXh+hkGbBWcKfYQVuzd6v3jDGfVZvfxVADnnb8=;
 h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
 b=Tr/SjGRGyS/Hb1XGsuNI6crN5DzE9BF63+NgUspgglYGs9NSwg2qezr/W/9pSo60I
 lbMH6E3VBKil+x/Te5ZXWdSLk+d1le2sdwqZWN8sZe/KUw+3uFB80q7S24svyx73Wq
 A7dIhA67jC433w9jiqYUCFl+eahDANfcK7h/wBeY4hsOFRS/96qq3VXZMo29tpywHC
 ffe3jxupIs74fn6NYMjzL/IvoJQlKQVYtR0z+1Uipy7Vyh3EikguAiyiaTu0T7Y7n6
 7b/ykoyIlNgSVILuVKUyxTdvENawxr5bmOts22zwwq2lx3rod8Kxju0+lmTcePg+3n
 QmkeB/dYwb9Nw==
Received: by mail-yb1-f178.google.com with SMTP id
 3f1490d57ef6-e4a6b978283so15429239276.0
 for <qemu-devel@nongnu.org>; Thu, 02 Jan 2025 09:10:03 -0800 (PST)
X-Forwarded-Encrypted: i=1;
 AJvYcCUjRTF4dT8lRn1/xggxYB6oA8vdchKlXbJq9iTgC3XHcrYgKIpp2L9tn5mzgwBbVs+xUI9wOPFFdBDl@nongnu.org
X-Gm-Message-State: AOJu0YykYYk5wI47nZlLHaeBZRR2WiY8NFTWWmXIKArMACSXeGG9g9dD
 ewfuklSPyUDZO48ti0a/5yi+1bw3LPNPQqbqofuTAZuanbMo45iL8AVhdSwCk1kmc+SN+uO+Wa5
 rjMikKBkoZc8MC8kxnCASi+oxpg==
X-Google-Smtp-Source: AGHT+IF47D5lU6JkW1Kaa8QtNoZZq0x6Cc1vWAXPrrSTATaCt/BbwteBWH387WUpXwiEeCXVuc/Km5KP4xkWM9QEsWo=
X-Received: by 2002:a05:690c:c07:b0:6f0:697:da5f with SMTP id
 00721157ae682-6f3e2b6bb89mr327909417b3.14.1735837803147; Thu, 02 Jan 2025
 09:10:03 -0800 (PST)
MIME-Version: 1.0
References: <20241219083237.265419-1-zhao1.liu@intel.com>
 <44212226-3692-488b-8694-935bd5c3a333@redhat.com>
 <Z2t2DuMBYb2mioB0@intel.com> <20250102145708.0000354f@huawei.com>
In-Reply-To: <20250102145708.0000354f@huawei.com>
From: Rob Herring <robh@kernel.org>
Date: Thu, 2 Jan 2025 11:09:51 -0600
X-Gmail-Original-Message-ID: <CAL_JsqKeA4dSwO40VgARVAiVM=w1PU8Go8GJYv4v8Wri64UFbw@mail.gmail.com>
Message-ID: <CAL_JsqKeA4dSwO40VgARVAiVM=w1PU8Go8GJYv4v8Wri64UFbw@mail.gmail.com>
Subject: Re: [PATCH v6 0/4] i386: Support SMP Cache Topology
To: Alireza Sanaee <alireza.sanaee@huawei.com>
Cc: Zhao Liu <zhao1.liu@intel.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Igor Mammedov <imammedo@redhat.com>, Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, "Michael S . Tsirkin" <mst@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Sia Jee Heng <jeeheng.sia@starfivetech.com>, 
 qemu-devel@nongnu.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2604:1380:4641:c500::1;
 envelope-from=robh@kernel.org; helo=dfw.source.kernel.org
X-Spam_score_int: -65
X-Spam_score: -6.6
X-Spam_bar: ------
X-Spam_report: (-6.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.185,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, SPF_HELO_NONE=0.001,
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

On Thu, Jan 2, 2025 at 8:57=E2=80=AFAM Alireza Sanaee <alireza.sanaee@huawe=
i.com> wrote:
>
> On Wed, 25 Dec 2024 11:03:42 +0800
> Zhao Liu <zhao1.liu@intel.com> wrote:
>
> > > > About smp-cache
> > > > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > > >
> > > > The API design has been discussed heavily in [3].
> > > >
> > > > Now, smp-cache is implemented as a array integrated in -machine.
> > > > Though -machine currently can't support JSON format, this is the
> > > > one of the directions of future.
> > > >
> > > > An example is as follows:
> > > >
> > > > smp_cache=3Dsmp-cache.0.cache=3Dl1i,smp-cache.0.topology=3Dcore,smp=
-cache.1.cache=3Dl1d,smp-cache.1.topology=3Dcore,smp-cache.2.cache=3Dl2,smp=
-cache.2.topology=3Dmodule,smp-cache.3.cache=3Dl3,smp-cache.3.topology=3Ddi=
e
> > > >
> > > > "cache" specifies the cache that the properties will be applied
> > > > on. This field is the combination of cache level and cache type.
> > > > Now it supports "l1d" (L1 data cache), "l1i" (L1 instruction
> > > > cache), "l2" (L2 unified cache) and "l3" (L3 unified cache).
> > > >
> > > > "topology" field accepts CPU topology levels including "thread",
> > > > "core", "module", "cluster", "die", "socket", "book", "drawer"
> > > > and a special value "default".
> > >
> > > Looks good; just one thing, does "thread" make sense?  I think that
> > > it's almost by definition that threads within a core share all
> > > caches, but maybe I'm missing some hardware configurations.
> >
> > Hi Paolo, merry Christmas. Yes, AFAIK, there's no hardware has thread
> > level cache.
>
> Hi Zhao and Paolo,
>
> While the example looks OK to me, and makes sense. But would be curious
> to know more scenarios where I can legitimately see benefit there.
>
> I am wrestling with this point on ARM too. If I were to
> have device trees describing caches in a way that threads get their own
> private caches then this would not be possible to be
> described via device tree due to spec limitations (+CCed Rob) if I
> understood correctly.

You asked me for the opposite though, and I described how you can
share the cache. If you want a cache per thread, then you probably
want a node per thread.

Rob

