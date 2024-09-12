Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1C70EEB59D
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Sep 2024 12:13:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soigp-0003n6-97; Thu, 12 Sep 2024 08:12:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soigb-0003am-1h
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:12:33 -0400
Received: from mail-ed1-x52d.google.com ([2a00:1450:4864:20::52d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1soigX-00062y-Ez
 for qemu-devel@nongnu.org; Thu, 12 Sep 2024 08:12:32 -0400
Received: by mail-ed1-x52d.google.com with SMTP id
 4fb4d7f45d1cf-5c25f01879fso941637a12.1
 for <qemu-devel@nongnu.org>; Thu, 12 Sep 2024 05:12:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726143147; x=1726747947; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=pSke8FlFE4N6exTtc6EKOjb2LrZxkDR+LzQcBycp73g=;
 b=p/OKdYJZgFGpFyEQag1stIvoDStfVqwgk8IuUbySBy20Oljgm3519odDMbzhDJex/+
 0S62bG2rLNGjRtcPVDb3Ke069BWe08fb8ne3Jh/eGwuePSQHnJoog+G+OMhImLOwywP1
 iBJfQka+mebLNtDGdArRbmTKp47Xk8BIjfAyRIlws7PPmYslD1+tkKDq9b6WKvttcX26
 Nxa3V4AUvNBKB3SEUVXJYqR3349c9eySXDzV13GbCh2sCq/698l/v1MwvV9ecEyO+4Zh
 rVKV02NXppM6F3p8AaBfYkIrDZGZSGRTRtQWQaxche2RWxYuFJY9yJPQ68cBW8G0+Qr8
 +64A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726143147; x=1726747947;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=pSke8FlFE4N6exTtc6EKOjb2LrZxkDR+LzQcBycp73g=;
 b=Q+PSu2xDXFmrGTlOZkMu/PhKV80o0qs8PTiTfQ8o0nxItLTTkzY0UtsEybinOFLYFb
 58qMf8Q55c7tF4geiEZr63xJYd8v5ifSCYw9YQOEe/7qjj4coEXT1aeV0XUwn9o8qnlh
 ktwMho2/dUEh20UMYCxr/FjIuMsoyxO4DBNJNwP4ok374pjZr/QttSqC8T1y27d/I7Po
 M+0DvX/ifHBmXKJnvwK3W/ryO570T2M1leC9vPhOeuV1PYOFId2RC5BMA3Ldc5TYSUxJ
 imuSUlc3cPqk+a8ByKRxVasFimdag5LgxbaJ5dZujQuYRMFaaVWUmuLsPvwAzyuevg+7
 7q5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9trfDR5s3ktlFI7wAxfgW6uwnfjSkGTMXekuckGHzPzvtNgJnbeNtwmcFfZVYvA1MGenNhs8J9sAG@nongnu.org
X-Gm-Message-State: AOJu0YycsiDK31/rFcHWNaFdjoWc0y+oYqFByyEJQhtviDpLNfxlylQ3
 jFkV/2QczwSvcnZP2ajdFgdx2LAvWFYZJQUAkqD7nuXfmgZTzkCcpVa6FCDyz6ToTx2oZvIc7yz
 tQHoQCbKgPVrBuOdM/GM2iDo5NupV3lWk7WI/BA==
X-Google-Smtp-Source: AGHT+IETQd/3dKE+DCudKgky7MhTcKDOjT4e304Trb0+62Sgjre9CoznMfjV51Zt3iOwKhpGntAfXRHw7wfNzHrHWeQ=
X-Received: by 2002:a05:6402:3881:b0:5c0:8ea7:3deb with SMTP id
 4fb4d7f45d1cf-5c413e4c748mr1736077a12.22.1726143147135; Thu, 12 Sep 2024
 05:12:27 -0700 (PDT)
MIME-Version: 1.0
References: <20240912073921.453203-1-pierrick.bouvier@linaro.org>
 <20240912073921.453203-15-pierrick.bouvier@linaro.org>
 <a0608783-d6d8-4ccc-a431-5fc1e96e0021@linaro.org>
In-Reply-To: <a0608783-d6d8-4ccc-a431-5fc1e96e0021@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 12 Sep 2024 13:12:16 +0100
Message-ID: <CAFEAcA9rx6jSZ3SHa1=H+-r6H4KopK3dUG=qmqRgt=nVcs5ueA@mail.gmail.com>
Subject: Re: [PATCH v2 14/48] include/hw/s390x: replace assert(false) with
 g_assert_not_reached()
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org, 
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Laurent Vivier <lvivier@redhat.com>, Marcelo Tosatti <mtosatti@redhat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, Klaus Jensen <its@irrelevant.dk>,
 WANG Xuerui <git@xen0n.name>, 
 Halil Pasic <pasic@linux.ibm.com>, Rob Herring <robh@kernel.org>, 
 Michael Rolnik <mrolnik@gmail.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, 
 Corey Minyard <minyard@acm.org>, Keith Busch <kbusch@kernel.org>,
 Thomas Huth <thuth@redhat.com>, 
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, Hyman Huang <yong.huang@smartx.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-s390x@nongnu.org, 
 Laurent Vivier <laurent@vivier.eu>, qemu-riscv@nongnu.org, 
 "Richard W.M. Jones" <rjones@redhat.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Aurelien Jarno <aurelien@aurel32.net>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, kvm@vger.kernel.org, 
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Hanna Reitz <hreitz@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, qemu-ppc@nongnu.org, 
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 Alistair Francis <alistair.francis@wdc.com>, Bin Meng <bmeng.cn@gmail.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Helge Deller <deller@gmx.de>,
 Peter Xu <peterx@redhat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Dmitry Fleytman <dmitry.fleytman@gmail.com>, 
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 Yanan Wang <wangyanan55@huawei.com>, qemu-arm@nongnu.org, 
 Igor Mammedov <imammedo@redhat.com>,
 Jean-Christophe Dubois <jcd@tribudubois.net>, 
 Eric Farman <farman@linux.ibm.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>, 
 qemu-block@nongnu.org, Stefan Berger <stefanb@linux.vnet.ibm.com>, 
 Joel Stanley <joel@jms.id.au>, Eduardo Habkost <eduardo@habkost.net>, 
 David Gibson <david@gibson.dropbear.id.au>, Fam Zheng <fam@euphon.net>, 
 Weiwei Li <liwei1518@gmail.com>, Markus Armbruster <armbru@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52d;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52d.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Thu, 12 Sept 2024 at 12:59, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.o=
rg> wrote:
>
> On 12/9/24 09:38, Pierrick Bouvier wrote:
> > This patch is part of a series that moves towards a consistent use of
> > g_assert_not_reached() rather than an ad hoc mix of different
> > assertion mechanisms.
> >
> > Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
> > Reviewed-by: Thomas Huth <thuth@redhat.com>
> > Signed-off-by: Pierrick Bouvier <pierrick.bouvier@linaro.org>
> > ---
> >   include/hw/s390x/cpu-topology.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
>
> We usually don't precise "include/" in patch subject:
> we treat include/FOO as part of FOO area.

I would say either is OK -- if you do
git log --oneline | grep ' include' |less

you can see plenty of examples where 'include' was used in
the subject-area prefix, especially if, as here, we're changing
just one file.

-- PMM

