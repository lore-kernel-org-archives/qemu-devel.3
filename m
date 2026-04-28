Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FCFFF885A
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Apr 2026 15:54:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wHklJ-0001LQ-Fo; Tue, 28 Apr 2026 11:54:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wHkl8-0001Kb-Hs
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:54:03 -0400
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1wHkl5-0001lP-JC
 for qemu-devel@nongnu.org; Tue, 28 Apr 2026 11:54:02 -0400
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-677f7c29af6so10954705a12.2
 for <qemu-devel@nongnu.org>; Tue, 28 Apr 2026 08:53:58 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1777391637; cv=none;
 d=google.com; s=arc-20240605;
 b=TLGZ/9l9arR+5LGNPX6xzlJg329NqMj79oB4+a/i9Egs2hnbgHPww2tyMi4niF504E
 NV5wyceV/F2eWrAL+RwE3kiO5yq3jp2Ua9kMJeCmKv5aZkFAn3G3zmun2rhXFtQqAtE+
 4I/r14HBTiJl7U0P5Yn3g0iCEUJm2VnxCDAGhKfbgaCoiVR8KtJEkfvJ6FlfkzSDtoi9
 ZHuEpc5Kau5jhEtPztr51a6ZkaY0s759Wj8sKlhSyH7mrpd/+/ZvHX4yYgLzSYKBKyFt
 9snlNHWjf9Em0oQyUSfTPz/xG7lEYmmncM6BE/c6fzQAdrEe7Ux7aDsTsk/Oq9v7LjJM
 x3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=sThl5b2cMIJp2X5GmVXdJIfTNGON8LS8JRXk08IaLIc=;
 fh=D9CzFiLxr3Y70oAa1ZIwt3HUZNzfcjTOYmZrFFoRx/A=;
 b=Ff+X6Saske0I1ISVtmPaV+hsaupTK1Xz4t7qf5PmbdilPCYvLSNbLN7xevMRqwZfuz
 h0NZjW6UTlGAyC51sHeRCNqAsPVQVXrdDJM4JuefL83nwE4hjk1Od/OfMaZhOVO5eiVY
 hiduHpHbd2wbfLikZMM/oGwnZhDtX8oulX1gjxuMqylRbm0uR+g2bE3m8V+6QIdGq85R
 T3ofErfHttSdDC9+b+XcugVjbtmZL/Sz+RaY33INiqTD0Gu8MVQpwpUiOQtaaLW3ZTFX
 S3VCIiDZMzWo+/xsHnqU0ZERp6g3r0TnIMjJDR/rPEJKsiCFeU8VJibJxv6uukOYSz/R
 MDeQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1777391637; x=1777996437; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=sThl5b2cMIJp2X5GmVXdJIfTNGON8LS8JRXk08IaLIc=;
 b=SiVJ+Id9vnvZBfDk4n652ig8Auy8VkbVJGuEY/yWRzyjStftgHylRAMxAxd0dUBZSD
 1r3DjKqKk15mAsATosXK9Fidc7u93NcdCITCVvMl0cqdRiJAsDjqyV/GWNUp2uHPL0Cv
 f/kBvlY0fRBxXgYMZlQvs3d2BmyWWq73Eef3c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777391637; x=1777996437;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sThl5b2cMIJp2X5GmVXdJIfTNGON8LS8JRXk08IaLIc=;
 b=DCqI0PJow9o1Y0DQXvNFp5ojuGGN9QNdjbXcf7YSaBd9mliFpKs1kGSPlPWyjRtsIe
 PTv8g+y/Si8w9c3v5ntTnhR0qZo7CLLuJ7Hq2YC788G5m5f43K3VBcht+r+aVZouNmht
 2iu/NG3rBoJyzXRKqxGnN08MZ6ZBTy9tuAbxsxg3fiNjxvnVyIIBcQVvOgc7u7EBqV72
 zHhPFohqgSoykap3LyP5UZZlO23fL6h4QcEElUkZsE3vv3K5S5Xd75NXB42yhY/00y3+
 Q3CHZkTDda2z/sgOziIAf2WfA6OP32DD91LsnczVx8LBGFvu9vpfj2xAGCa7c0/x3k6S
 GIVg==
X-Gm-Message-State: AOJu0YxNYlL7Doerd0IVU2XbiJgwBsYQwtpoiPAvf4W1yYwL4fO4fCps
 R/Mem/YRo4Xx1z0FobUfFzBdNOAmgFklCSUK2lTI1W0M3AKWD5YyCotxzUUXzMPVmifa6Pcg3fG
 azmfU9okjx+8E+GUeiPANxjaZnYhjydslPNa1tXFXNg==
X-Gm-Gg: AeBDiete649hr44Hpuh961R03P/OUDmb70x1KrgHuwgBHWz9bGGrLODJpw+S5GrcRG6
 sX3SPNdMqzn7yj7KeRMt39p6Iqu5kOdHeHyEaChJwhOVYROCGK2fp8fc36n5RUsmApHQJvPy4bI
 hRRa3GyXnbH5RoIo+CoIPyFgkvUc5jJ10/n206iWiCGB75NF6SU4/GmWMKSL1iR/L7krnMgW7mC
 uw8MtGsLu09B34/fGovsbYXf1ZLd3zp1qxG3aUrtPRRh8Fo4brtomcbUk/xJhnKI9UrDAp7XWaC
 MhOwc/H4MIvOX14o5AtfZmNqkjVT
X-Received: by 2002:a05:6402:5412:b0:66e:8ca6:e79f with SMTP id
 4fb4d7f45d1cf-679bb087971mr1927216a12.13.1777391636593; Tue, 28 Apr 2026
 08:53:56 -0700 (PDT)
MIME-Version: 1.0
References: <20260419130139.15554-1-alexander@mihalicyn.com>
 <20260419130139.15554-9-alexander@mihalicyn.com>
 <20260427200004.GF218226@fedora>
In-Reply-To: <20260427200004.GF218226@fedora>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Tue, 28 Apr 2026 17:55:12 +0200
X-Gm-Features: AVHnY4JU2msPbaEwLXyLaHfJBZKW7STuhkw5QbWLS8Kvf2mUUfdThjtsZdGXUIw
Message-ID: <CAJqdLro_fUh0-yEjum0z6c2FvNsLjr95MMaA7EX810dqm+=upg@mail.gmail.com>
Subject: Re: [PATCH v6 8/8] tests/qtest/nvme-test: add migration test with
 full CQ
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Kevin Wolf <kwolf@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>, Laurent Vivier <lvivier@redhat.com>, 
 Jesper Devantier <foss@defmacro.it>, Klaus Jensen <its@irrelevant.dk>,
 Fabiano Rosas <farosas@suse.de>, 
 Zhao Liu <zhao1.liu@intel.com>, Keith Busch <kbusch@kernel.org>,
 Peter Xu <peterx@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::530;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x530.google.com
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

Am Mo., 27. Apr. 2026 um 22:00 Uhr schrieb Stefan Hajnoczi
<stefanha@redhat.com>:
>
> On Sun, Apr 19, 2026 at 03:01:39PM +0200, Alexander Mikhalitsyn wrote:
> > +static void test_migrate_check_nvme(nvme_ctrl *ctrl, test_migrate_req *reqs, int num)
> > +{
> > +    int i;
> > +
> > +    for (i = 0; i < num; i++) {
> > +        NvmeCqe cqe;
> > +
> > +        if (reqs[i].handle_cqe) {
> > +            continue;
> > +        }
> > +
> > +        cqe = nvme_wait(&ctrl->admin_sq);
> > +        g_assert(nvme_is_cqe_success(&cqe));
> > +
> > +        g_assert_cmpint(cqe.cid, ==, reqs[i].cid);
>
> Please check the endianness in this patch. I don't see an le16_to_cpu()
> call here.
>
> Maybe other NVMe DMA structures or registers are also not converted
> to/from little endian. This test must pass on both big-endian and
> little-endian hosts.

Ah. I cared about endianness conversions but haven't tested this on a
BE machine.
Will fix this (and test on arm64) in the next version, thanks, Stefan!

>
> > +
> > +        #define GUEST_MEM_READB(field) \
> > +                            qtest_readb(ctrl->pdev->bus->qts, (uint64_t)&(field))
> > +
> > +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[0]), ==, 0x0);
>
> I was trying to figure out why phys_identify has a pointer type although
> it is a guest memory address that cannot be dereferenced in C code. I
> guess the reason is so that the GUEST_MEM_READB() macro can use the
> address-of operator instead of explicitly calculating the offset of
> ieee[0], ieee[1], etc? I found this confusing and potentially dangerous
> (the compiler won't stop the pointer from being dereferenced if someone
> does it by mistake).

Exactly, that was my intention, to be able to use address-of operation
in conjunction
with structure-dereference operator. To prevent accidental mistakes, I
used "phys_"
prefix in structure member names (like "cq->phys_cqe" or
"reqs[i].phys_identify").

>
> It took more time to review the pointer trick than the straightforward
> approach would have taken. I'd avoid it, but it's a question of coding
> style and up to you.

No problem, I think the fact that this code confused you means that my idea
wasn't that good as I thought ;-) I think I should then change a type for
phys_identify and phys_cqe to u64 and then add explicit address arithmetic
or continue to use "arrow" operator but in a special macro like
GUEST_MEM_READ_SOMETHING(...).
WDYT?

>
> > +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[1]), ==, 0x54);
> > +        g_assert_cmpint(GUEST_MEM_READB(reqs[i].phys_identify->ieee[2]), ==, 0x52);
> > +
> > +        #undef GUEST_MEM_READB
> > +
> > +        guest_free(ctrl->alloc, (uint64_t)reqs[i].phys_identify);
> > +    }
> > +}
> > +
> > +static void test_migrate(void *obj, void *data, QGuestAllocator *alloc)
> > +{
> > +    g_autofree gchar *tmpfs = NULL;
> > +    GError *err = NULL;
> > +    g_autofree gchar *mig_path;
> > +    g_autofree gchar *uri;
> > +    GString *dest_cmdline;
> > +    QTestState *to;
> > +    QDict *rsp;
> > +    QNvme *nvme = obj;
> > +    QPCIDevice *pdev = &nvme->dev;
> > +    nvme_ctrl *ctrl;
> > +    test_migrate_req test_reqs[] = {
> > +        { 123, true },
> > +        { 456, false },
> > +        { 300, false },
> > +        { 333, false }
> > +    };
> > +
> > +    /* create temporary dir and prepare unix socket path for migration */
> > +    tmpfs = g_dir_make_tmp("nvme-test-XXXXXX", &err);
> > +    if (!tmpfs) {
> > +        g_test_message("Can't create temporary directory in %s: %s",
> > +                       g_get_tmp_dir(), err->message);
> > +        g_error_free(err);
> > +    }
> > +    g_assert(tmpfs);
> > +
> > +    mig_path = g_strdup_printf("%s/socket.mig", tmpfs);
> > +    uri = g_strdup_printf("unix:%s", mig_path);
> > +
> > +    /* enable NVMe PCI device */
> > +    qpci_device_enable(pdev);
> > +
> > +    ctrl = g_malloc0(sizeof(*ctrl));
>
> I don't see a g_free() call for ctrl. Use g_autofree?

sure

Thank you very much for your reviews!

Kind regards,
Alex

