Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F891CAC5AE
	for <qemu-devel@archiver.kernel.org>; Fri, 26 Sep 2025 16:59:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v2BlH-0004HK-C9; Fri, 26 Sep 2025 12:57:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2BlD-0004GW-BH
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:57:32 -0400
Received: from mail-yw1-x1133.google.com ([2607:f8b0:4864:20::1133])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1v2Bl2-0007sW-IT
 for qemu-devel@nongnu.org; Fri, 26 Sep 2025 12:57:30 -0400
Received: by mail-yw1-x1133.google.com with SMTP id
 00721157ae682-76c144b06fdso15901447b3.3
 for <qemu-devel@nongnu.org>; Fri, 26 Sep 2025 09:57:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758905831; x=1759510631; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=FCX6X/rfUuPsVM2XGqHAD+QWvtvxGxXBFrKjW02YChc=;
 b=ixKVgAcZrY4MLfMAG7OTzw22o1LiGz07LM1rEUIwNO3w8QjMUANZVCtUscWLHTjbCF
 gSwWGGTPCo7k+Y8B/CFnDib4nG2OtU/6l1TfTkqnHINKbByFCNI82wMvED8LbnIusUFr
 BgGE0+imQ0dRpVyn+4qN0cZtC7kj6c1gFunw6aU5mZCiLPVmRDqV/mzXlt+d/YwYk2Q8
 ZlzYtH5QGXt8soUPi1/UUAjEHw3p4aOdw6EYW0iNnPSopYG7UOYXB9mdYYAnW/mPacYU
 Ytz1Wdo9IRDVweUBtiXKnlugtEObxBtoCfO1kA9iDD9fwipQ0j9aF2cCmh7eO3gb3Crb
 DDAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758905831; x=1759510631;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=FCX6X/rfUuPsVM2XGqHAD+QWvtvxGxXBFrKjW02YChc=;
 b=GS2pWXzAql7kJDRK0SCoHtO1itc0cJ++3++Zetn3caM2E5k/zh9gtaM35sZvG9KBD9
 Qa/4hjo7cdhrka+wBsXt0Y67+sz4ubjmGBeVx6T//TiKWe1HSIBUTpqk8BWN2Cv0Evym
 efny/DLo8ss806UjyB63eoDbuvcdc22O7+/pnImIO5ARto0U8W71gYdkSsRCicPzS7cj
 5BFUkkDRc5chfm/dBHcjkK5ziiL71wK7ddCMRjXBPGAWwo0bP/+6ziB4U4qoDLgIVUB1
 DCE235QcGv/db5V1p3OwbxGahhIhIfDV7TM8is6rDgH1FVUB77yCTamUJJImOaeM0Ggy
 hVeA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVQPngJ/jFV97Dn7Blg+GjBkfbwmdbwpskJDUkzf/g5UsnHcPag6B0qF2tvZ84MLYN3vq5YvAYzwA/0@nongnu.org
X-Gm-Message-State: AOJu0YzOBYSGwzhQ4uUM7xqYknhBvix8cT8EhKwprkyAcTk2SdhCQq1/
 6VDVz0FnNyt+M+raqEXqZYp4kSkLq1a3TZQHwbGf/v8kYmx5nKGph5fa92fueRJZKxhMaekRGXa
 lagMEc0xfr0vcDLfrpuZvm3QRUjsbDU9XRbsQ/GlE2g==
X-Gm-Gg: ASbGncv62PNdDydzNB8RjJ3ajxzM9X0JdSHw3xXxS896jUcmHg7YRSeA8a4n6FGn6qF
 KhNPhkb41QgZmESN1Y46XR4cdjzGFKZLiD4+UxcbUDJFyo8Xla/op7FeDx3NvqX3C2r2CAhNsvI
 r43aZ1KitI9enXBu8mMinaa+019M+7RKPfHb+fGPpGG5tXsiYwHdN4x5fSFzv3AHyp1pjU9EHlr
 1prsehu
X-Google-Smtp-Source: AGHT+IG9x5SkXRkralRpZaU/N74jpkChZy72It5tFjPWdefqcxREA6n70gXNrW2O0T71sfJuMJntsrGpIiA0MqaW8Po=
X-Received: by 2002:a05:690e:4ca:b0:636:2424:e081 with SMTP id
 956f58d0204a3-63624251d8amr5333045d50.47.1758905831109; Fri, 26 Sep 2025
 09:57:11 -0700 (PDT)
MIME-Version: 1.0
References: <20250906-mr-v2-0-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <20250906-mr-v2-3-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp>
 <aMHxhTIw2EGRyD4-@x1.local>
 <fe1969e6-bc13-4438-816d-b352926c33a8@rsg.ci.i.u-tokyo.ac.jp>
 <aMNMjetBDJfBiThl@x1.local>
 <4108b4f2-accf-4080-af29-a3f464d862f9@rsg.ci.i.u-tokyo.ac.jp>
 <aNRfHQoBgwBMjK04@x1.local>
 <CAFEAcA8wTsZiihr8-LKucTmeZwPBdnkdA-o3mUgaW1WzrADhOg@mail.gmail.com>
 <aNWgnBV-9p6UnsYT@x1.local>
 <CAFEAcA8qdWtdX0Xc0WAuT9eZsXbudV2g2=Da8pK6tEfytdMbpw@mail.gmail.com>
 <aNauXSMiP0LUWQ5J@x1.local>
 <CAFEAcA8x0mgrxepuKcPwLWfQF8H=giWH03+2sF9yzZ_5nk_dmw@mail.gmail.com>
In-Reply-To: <CAFEAcA8x0mgrxepuKcPwLWfQF8H=giWH03+2sF9yzZ_5nk_dmw@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 26 Sep 2025 17:56:59 +0100
X-Gm-Features: AS18NWBreSbkaTDViV4whmC5pPLMvE4LUZjOTA65YDWIibPICwuaPHwDswWdDU8
Message-ID: <CAFEAcA-Y_5ea8D82CLBuBoHAVwKqBLjpO8Q6giAGW=fXScheUw@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] memory: Stop piggybacking on memory region owners
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>, qemu-devel@nongnu.org, 
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, David Hildenbrand <david@redhat.com>, 
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
 Yanan Wang <wangyanan55@huawei.com>, BALATON Zoltan <balaton@eik.bme.hu>, 
 Jiaxun Yang <jiaxun.yang@flygoat.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Fabiano Rosas <farosas@suse.de>, Thomas Huth <thuth@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, 
 Dmitry Osipenko <dmitry.osipenko@collabora.com>, 
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1133;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1133.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 T_SPF_TEMPERROR=0.01 autolearn=unavailable autolearn_force=no
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

On Fri, 26 Sept 2025 at 16:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> I'm trying to repro the setup I had last year, but I can't
> figure out a setup where I can get hot-unplug to work:
> the "device-del" command documented in system/cpu-hotplug.html
> always fails with:
>
> "desc": "acpi: device unplug request for not supported device type:
> IvyBridge-IBRS-x86_64-cpu"
>
> Do you know how to get this working?

Turns out I needed to also add enough command line arguments
to get a guest to boot (which is a bit tricky when you don't
want to use the gui frontend because fontconfig et al are
full of leaks that clutter up the asan output). The error
message from device-del is extremely unhelpful here.

The command line I ended up with was

./build/x86-tgts-asan/qemu-system-x86_64 -vga std -display curses
-no-user-config -m 2048 -nodefaults -machine q35,accel=kvm,usb=off
-smp 1,maxcpus=2 -cpu IvyBridge-IBRS -qmp
unix:/tmp/qmp-sock,server=on,wait=off -cdrom
~/test-images/ubuntu-server-2404/ubuntu-24.04-live-server-amd64.iso

thanks
-- PMM

