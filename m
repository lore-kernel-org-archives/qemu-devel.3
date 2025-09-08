Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 60696CAC581
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Sep 2025 15:33:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uvdqX-0005uJ-Bc; Mon, 08 Sep 2025 11:31:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvdqN-0005so-Pv
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:31:48 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uvdqF-0004OS-NA
 for qemu-devel@nongnu.org; Mon, 08 Sep 2025 11:31:46 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-60f4702e399so1208852d50.3
 for <qemu-devel@nongnu.org>; Mon, 08 Sep 2025 08:31:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1757345496; x=1757950296; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=05jcsh7eYIBeD1LtC0LB0k/QRXQnJApE7xyhtoLjIxY=;
 b=nOR4RAxzoGa9HIMksyyydOezZA871gvU/jb0q7uJd2sGegcFPIAIlih0smcD2d1rzc
 9W5OA9uKIPMFwl+X9IKCGoZ0+i/KUBUCQVPX8RsbQ5SDdCS2nUwt0+bj0yy9yqP8S+AN
 n4IAnl624SqnabHo8UlBRa/upY8DE/eqli7d1ycmrWOGZt3dGsqoTzEYS3R4kyXfzvuc
 U/J0Wqx4r7x3dk/oFGKVmwO2QRZhfPUke6sNEOjcNACKBTL6mXuIj3cdGtewGhJotM3y
 dM2hc3oZF3r1KqK/XPBpnj5csyZBeYmDsjSdmYyOkK9fsgVzM/OUoOjDW/m9D8c9sArT
 z3/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757345496; x=1757950296;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=05jcsh7eYIBeD1LtC0LB0k/QRXQnJApE7xyhtoLjIxY=;
 b=LoUXDf6uSiSEiIUR8pwp55xCzQqGbSwpU2h37fEP7UlNt3O4o3fTYPaLfU/Kr+UaMG
 +pwWqqdId9JF/CYx4AD/OIiXjOAes05MWDU3Hlu4d+w201ZEdiobCu1+rUFPr2SM/zr0
 gW/f6a3VuoEe4dccEqsOKJKK1WUmBMQHa706sG2SbEBPt1crpMJ6hKeiFC4V/qGqffJM
 WMN/ugzmVn7oCcku5FgA+aoJ3J+PP1Ncg0fJhvOc/qvY+X/W7V2o20a0h4Opa7XT5PVZ
 rRR/cZSCqxAZ0zTYPr0gRU+4Atsf9QEqGyv5htUOyFd7HMeqXQF1VkynoG9Xb2WUZBPv
 KvIA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUmDFBmJfY7wU5XpkAXa8XpTnk90QV3xNpp7uCLOEw1mzkxgQMKX6IBZH4L4k5AgsfSCLDtCsMvj+iv@nongnu.org
X-Gm-Message-State: AOJu0Ywe4JwHPjMHycGI7ieu6Cw6w7pLjS0KNPlVn/lKQ4s4GOKzWKT2
 gUlMWrmrIYhp/ML9uWkPWO2mLUoOgrV2vgGCWiH4toweLlZypdTNYJUogxh+uc/pGBnIjU37hg0
 PRzdqG0ArucF9ZYm7IazyFhyv7N+SJARuHVRaWZXtPgCOzRuUAiDc
X-Gm-Gg: ASbGnctSc02nMNNLQIrnmVj1fFl4YqxjvShp3GKJRsP5n2Oj/aVGX12h5aTgyZ7BUM4
 euyKhaq4z0OA/HtoXCMXqMeSpqeQ4wPnfUXyxfTQBjOuskq2PXuK7E2Wcm2STkvYtbT56/kfHST
 3USBS87xEPQREkfYkLrbvrGm7vWjvVzHu15c0WuyHZhESfRIpNLhxWaomQswdRnyxmBv9fHtWN7
 hvjmJX6utzUnLkwoJo55P4aonN51A==
X-Google-Smtp-Source: AGHT+IGUYpyzC5avMMdP/mLGOTQFXdcn/gsTBcrHyTT5nmB65JMbBeej8qK8Sfb827QDfNIJf13OCdVCqXsF8Quyf00=
X-Received: by 2002:a05:690c:9688:b0:722:85cc:3970 with SMTP id
 00721157ae682-727f4384950mr73561387b3.4.1757345496275; Mon, 08 Sep 2025
 08:31:36 -0700 (PDT)
MIME-Version: 1.0
References: <20250906-use-v1-0-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-use-v1-7-c51caafd1eb7@rsg.ci.i.u-tokyo.ac.jp>
 <cd21698f-db77-eb75-6966-d559fdcab835@eik.bme.hu>
 <f1eaf445-d80f-49b2-b722-8767feedf9be@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <f1eaf445-d80f-49b2-b722-8767feedf9be@rsg.ci.i.u-tokyo.ac.jp>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 8 Sep 2025 16:31:24 +0100
X-Gm-Features: Ac12FXz7tZPa0w2F5GHz3aM-B3fYBsdl6I-cRMAouMbjfLdF9YMhH3wTzXljHog
Message-ID: <CAFEAcA8+fm=6B5Mu9eaBjhCXicpYhgot1p9zV3X5=o5c4tcbFg@mail.gmail.com>
Subject: Re: [PATCH 07/22] hw/pci-host/raven: Fix AddressSpace exposure timing
To: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, Peter Xu <peterx@redhat.com>, 
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Richard Henderson <richard.henderson@linaro.org>, Helge Deller <deller@gmx.de>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 John Snow <jsnow@redhat.com>, 
 qemu-block@nongnu.org, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Jesper Devantier <foss@defmacro.it>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 Nicholas Piggin <npiggin@gmail.com>, qemu-ppc@nongnu.org, 
 John Levon <john.levon@nutanix.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>, 
 Yanan Wang <wangyanan55@huawei.com>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Aurelien Jarno <aurelien@aurel32.net>, Aleksandar Rikalo <arikalo@gmail.com>, 
 Max Filippov <jcmvbkbc@gmail.com>,
 =?UTF-8?Q?Herv=C3=A9_Poussineau?= <hpoussin@reactos.org>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, SPF_HELO_NONE=0.001,
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

On Mon, 8 Sept 2025 at 16:21, Akihiko Odaki
<odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>
> On 2025/09/06 18:03, BALATON Zoltan wrote:
> > I had a series here: https://patchew.org/QEMU/
> > cover.1751493467.git.balaton@eik.bme.hu/
> > that changes this for raven (among other clean ups) but I could not get
> > that merged in the last devel cycle because of PPC being a bit
> > unmaintained. I'd prefer that series to be taken first instead of this
> > patch so I don't have to rebase that.
>
> Looking at the series, "[PATCH v2 13/14] hw/pci-host/raven: Do not map
> regions in init method" moves memory_region_init() and
> memory_region_init_io() from raven_pcihost_initfn() to
> raven_pcihost_realize(). This should be avoided because these function
> calls add memory regions as child properties, which may be introspected
> without realization. Perhaps you may drop the patch and rebase your
> series on top of this patch, or let me rebase this patch on that series
> without it.

I think that patch is fine. It's OK to init MRs either in
instance_init or in realize, whichever is convenient for the
device. Initing an MR adds a child QOM property but they are
not intended for generic introspection. A MemoryRegion is not
part of the public interface to a device unless you call
sysbus_init_mmio() to declare it so.

This is part of a general issue we have with QOM, where we
use QOM properties both for "this is part of the public-facing
interface to this device" and also for "this is internal and
really we're only using a QOM child property for convenience
of having things automatically cleaned up".

thanks
-- PMM

