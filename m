Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94906CAC597
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 09:43:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzB9i-0003aU-FD; Thu, 18 Sep 2025 05:42:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzB9d-0003a7-Qa
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:42:18 -0400
Received: from mail-yx1-xb129.google.com ([2607:f8b0:4864:20::b129])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzB9Y-0003IM-Cf
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 05:42:17 -0400
Received: by mail-yx1-xb129.google.com with SMTP id
 956f58d0204a3-62adfdda606so452759d50.2
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 02:42:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758188529; x=1758793329; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sxP8LYMFqSAbtbWkGWrdaiOVoIBRqWIBOEuRswWJkEk=;
 b=yiBUPlX+tfunLqYOLGtj+9CLtrkjbLVvQg3KzQKNrvDcKEYiqhZhd+ZQXQNyv62vxF
 oWRnwoaTh2NhaUK74LLLVKrZ5+XXpU/TTUaYmb/+osnj+Tx5Ut9VbSwIqO+1olA8Kmma
 qj5ZRopV2cvE0vgVmik+F1JrDuwSdrAYcOSImnmxnO3TeoY3MunSq5IMNs3tKk5a1XzR
 g7k7NewYOduDgGNKdtVSQSGodmyzvfodRYhL57Ql4IgXMSeCsv+k7kBOX980xZ54EZQe
 GT144bdiunlpxMfTiK7a0T071TSrbmALKWLCPJAspXTof6pxuM9HpmL/3FFVEOJ4bNkM
 DI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758188529; x=1758793329;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=sxP8LYMFqSAbtbWkGWrdaiOVoIBRqWIBOEuRswWJkEk=;
 b=inJjIUne1M6xgMhzAM66dK4/tZqExn/2CR/EznK31cLGIVm6c4OqDulPxLjJXmeffK
 tiuxUsOlR9fktjNBiGRL90oLewjTKiE55EKd6QWLwCHZ6PtBgpmzy6AjEbuT0VKa1oA4
 Ewkcu8j6xkWzBfG9PgrRyAEaBJYVZrbxjkw2b5+tpn/iKLweI3tiiu7QLjO/4G5k901A
 RmsFYCoWvHLAR2iTzLR60GLEheDhzqKYfCvSZ0lniF8QRNsy6IvYlD+57aXrolm/B4NR
 qTKrqQJg2YtPcnUlHjohCFrfqoUYytnJGfCIdNdmCI4uaQJx4hVr7f3bxZyjsZ1wAS+j
 yj4g==
X-Gm-Message-State: AOJu0YzX/8nlTT9Ap/g3HAGzl52WvV2fJVtgxCK7ita1v9dvy6pl8SQu
 QSi/RcKRCTjAdBSMWr01pcZV7MeBgxoIPtv4myOjono3dNAI2+dLdaQNzHk0NazONLUeX3oEiUd
 ZmbW4pndXbFv9LHZSL8AG596edVR7/Da17HbAC61oXA==
X-Gm-Gg: ASbGncu8XNBE2tCvHNtsgRqiiivZYAC5JO90vuXLffkFBQKKYWH7uHvkP9VVYA29vgg
 qbTF0zWJGh5sdm1818u0Q7Yzw/7kG/XS8rTXvibYLa0u81r8cAuvEfo6zM95not9tvOUtbKtGJc
 ArQG8VDZX8G4wSWuUsJZmL8rJG4zGrd/RPEZ8RTLRFXDwSAJikKQ5G6UBqt7dQsIVIB1RHQ7SDN
 R9fvcGavC8cy2VTzQkQl2reJKg=
X-Google-Smtp-Source: AGHT+IFX2qnC9oNlIjXaxDgbEzXnFVoWA9GyskxdVRyt6HweyqJOSeP8YQKo4N2aY3yB6EjBHqZfOF9Qx7zRRI9cjOI=
X-Received: by 2002:a05:690c:b89:b0:724:fc2c:769 with SMTP id
 00721157ae682-738909bcc85mr43570857b3.24.1758188529287; Thu, 18 Sep 2025
 02:42:09 -0700 (PDT)
MIME-Version: 1.0
References: <20250916180611.1481266-1-peter.maydell@linaro.org>
 <ae07bd23-724a-4925-801c-d1f2b6d9abee@linaro.org>
 <e3f9275a-999e-4114-9950-68e3925aab7a@linaro.org>
In-Reply-To: <e3f9275a-999e-4114-9950-68e3925aab7a@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Sep 2025 10:41:57 +0100
X-Gm-Features: AS18NWDMxAbZnd5fBLNOLhfLqgQyFZEyzbtH6k_1R-WfB3ZtCQHeT0QpgkixfgI
Message-ID: <CAFEAcA9ZP01pX56GCATOTmmy=uorJ3jaHRq6rx9OAeF-B3rU3g@mail.gmail.com>
Subject: Re: [PULL 00/36] target-arm queue
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b129;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb129.google.com
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

On Wed, 17 Sept 2025 at 18:51, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> On 9/16/25 18:43, Richard Henderson wrote:
> > I don't understand why, but this causes failure on s390x host for hppa guest:
> >
> > https://gitlab.com/qemu-project/qemu/-/jobs/11379271029
> >
> > ...
> > # Testing device 'elroy-pcihost'
> > Broken pipe
> > ../alt/tests/qtest/libqtest.c:208: kill_qemu() detected QEMU death from signal 11
> > (Segmentation fault) (core dumped)
> > Aborted (core dumped)
> >
> > Even more bizzarely, the failure bisects to
> >
> > Author: Nicolin Chen <nicolinc@nvidia.com>
> > Date:   Fri Aug 29 09:25:27 2025 +0100
> >
> >      hw/arm/virt: Add an SMMU_IO_LEN macro
> >
> >      This is useful as the subsequent support for new SMMUv3 dev will also
> >      use the same.
> >
> > which makes no sense at all.  But it's repeatable, so...
>
> Ho hum.  It appears to be flaky.  I now see it without this patch set at all:
>
> https://gitlab.com/qemu-project/qemu/-/jobs/11391070227

asan reports a heap-use-after-free in the dino PCI controller
when running the device-introspect-test, which may be relevant.
The subtest the segfault happens on is half a dozen or so
devices after the dino-pci one, so it's plausible that heap
corruption leads to the subsequent crash.

I'll investigate the use-after-free...


==1771223==ERROR: AddressSanitizer: heap-use-after-free on address
0x527000018f80 at pc 0x5b4b9d3369b5 bp 0x7ffd01929980 sp
0x7ffd01929978
WRITE of size 8 at 0x527000018f80 thread T0
    #0 0x5b4b9d3369b4 in pci_host_bus_register
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:608:5
    #1 0x5b4b9d321566 in pci_root_bus_internal_init
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:677:5
    #2 0x5b4b9d3215e0 in pci_root_bus_new
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:706:5
    #3 0x5b4b9d321fe5 in pci_register_root_bus
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci/pci.c:751:11
    #4 0x5b4b9d390521 in dino_pcihost_init
/mnt/nvmedisk/linaro/qemu-from-laptop/qemu/build/hppa-asan/../../hw/pci-host/dino.c:473:16

-- PMM

