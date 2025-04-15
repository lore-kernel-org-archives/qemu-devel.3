Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C9A3C369AB
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Apr 2025 14:33:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u4hKg-0004kQ-PZ; Tue, 15 Apr 2025 10:32:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4hKe-0004k7-U7
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:32:12 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1u4hKd-00075p-6i
 for qemu-devel@nongnu.org; Tue, 15 Apr 2025 10:32:12 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-5e5cd420781so11061904a12.2
 for <qemu-devel@nongnu.org>; Tue, 15 Apr 2025 07:32:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1744727529; x=1745332329; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1Ad/nuwCVu/ba5LSqvJQ29TW9vE6/3wohUCRmNHQL5w=;
 b=JMFGsE+7qEgNZenMtC9sbbxYhIG6ccA0F6rmRT9Qt5K643zXFtzB959Nj6URLEUIjM
 PBgD/Lklw2l4ZVix2/0r5iMrq3/QDI1RNP5CxxortjZ7l4ni0rR10Fdrav8RWHTQCm7F
 eQozvvLqSEWiuSlgQd/pwUYygVXVtiXTspjSYU2eoCeQvJF4SyhS3xgkkT8djSPs9ogF
 QoqCVEC3/lKQWkF+2/LZylcSkW5XfdaXvcbhihyp7obPTYcCC9hN+qxbQbRb61GSekog
 vMDFXhmf1GBfGs5tWi1Wbsj5Yc1ptNt2ABLvbyBRZJ5hAbwQLOqVM7q82MM9qevGInwW
 Bzwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744727529; x=1745332329;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=1Ad/nuwCVu/ba5LSqvJQ29TW9vE6/3wohUCRmNHQL5w=;
 b=pP6ScuEtL8hpoysGfGF99+Ovt9isebHjMhFTW+w9gSOkQ/LDG6G+ec/DwBkvO0XL8H
 815DAf0ytAqa5GbHhJ04CEM/fJDx8DQLV1KOnxkcNunrV2yrnNFXafESw9fOLHVbtHGz
 nupfSRDuZT1hX7J0sUcE8LG+z+9FtOeG5eV21/7VPznpMHtEhM654tC96vNuh/mvkxtv
 PywbWnB/9G3hDt5JC55cHThCpY45osj64IMyslX/C/8dci3E5LNkHHbQ+P5aN32BY7bl
 cgNgpbkW3hQkNV/ZfrwPIi44xHnZtJ5dPuxVtmb1VFmof9KMh6lXtQDTQEB3uo0K7yBD
 Voyg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVX8wGEHUs0puWk94hVlkLDSkADcYZEThAFJ5dJEKN5RN4tEg3R5Y7G2qhWx4bUmsx26/YELBaevdL1@nongnu.org
X-Gm-Message-State: AOJu0YzVsEzylD7P5qD2dUeSOKLDj6KHjfF1MSysQ3PiKQQu4RdeGbKn
 RRLOLp5I7TjWW6yMFdQupD1OuJwwekOP4cEDwL72AyO/X7d+knc1X8WhBsEOpWENMpsNvNlSvGU
 lBxX4w2rt83oKQ2wJnaKLvBVxrMY=
X-Gm-Gg: ASbGncvaYkj2zZ9kNKc34M2hnZt9pnOSZInkolsWCUi4AiobN67ytJtTvKEBS4ckNec
 G4+HUTkjKKz+i+I1yXI4yFq/eBKmLGEd1uq7KgwfMtTGeB4sTYSftxK0Ekqe/q8YrrsPjt/16zM
 xh0tXs5HFskSjTe53vp3la
X-Google-Smtp-Source: AGHT+IGz871MHoXyv1fddy324DDfTNvAE2Igc2lV265f2Yi2xzPicxBC27kXck5ENDWwZFnUaauWLUXpDM4lw7y4Gps=
X-Received: by 2002:a05:6402:42c5:b0:5ec:922f:7a02 with SMTP id
 4fb4d7f45d1cf-5f36f650eaemr15187185a12.10.1744727528693; Tue, 15 Apr 2025
 07:32:08 -0700 (PDT)
MIME-Version: 1.0
References: <20250415061353.185589-1-clement.mathieu--drif@eviden.com>
 <20250415030653-mutt-send-email-mst@kernel.org>
 <20250415123330.GB270228@fedora>
 <5cb4ac03-c45d-4534-93b9-2723fac030c1@eviden.com>
In-Reply-To: <5cb4ac03-c45d-4534-93b9-2723fac030c1@eviden.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Tue, 15 Apr 2025 10:31:55 -0400
X-Gm-Features: ATxdqUEcOXqLmNRwTPjfibPpbkYDAjtTrIZ9IR4F8GG0x1LI5kWTKtV8rl9qlY4
Message-ID: <CAJSP0QW3a7+Eet+SyW4LPX4h4x4xtejAjaDe_-H6=8G41xJSkQ@mail.gmail.com>
Subject: Re: [PATCH] intel_iommu: Take the bql before registering a new
 address space
To: CLEMENT MATHIEU--DRIF <clement.mathieu--drif@eviden.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, 
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>,
 "jasowang@redhat.com" <jasowang@redhat.com>, 
 "zhenzhong.duan@intel.com" <zhenzhong.duan@intel.com>,
 "kevin.tian@intel.com" <kevin.tian@intel.com>, 
 "yi.l.liu@intel.com" <yi.l.liu@intel.com>,
 "peterx@redhat.com" <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=stefanha@gmail.com; helo=mail-ed1-x52e.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
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

On Tue, Apr 15, 2025 at 10:16=E2=80=AFAM CLEMENT MATHIEU--DRIF
<clement.mathieu--drif@eviden.com> wrote:
> On 15/04/2025 2:33 pm, Stefan Hajnoczi wrote:
> > On Tue, Apr 15, 2025 at 03:11:00AM -0400, Michael S. Tsirkin wrote:
> >> On Tue, Apr 15, 2025 at 06:18:08AM +0000, CLEMENT MATHIEU--DRIF wrote:
> >>> Address space creation might end up being called without holding the
> >>> bql as it is exposed through the IOMMU ops.
> >>>
> >>> Signed-off-by: Clement Mathieu--Drif <clement.mathieu--drif@eviden.co=
m>
> >>
> >>
> >> Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
> >>
> >> Stefan, want to pick this one up, too?
> >
> > Not yet, it may need to wait until after the release:
> > - Discussion is still ongoing.
> > - Is this a regression in 10.0 or a long-standing issue?
>
> It's a long standing issue

Thanks for confirming. Let's not worry about the 10.0 release. There's
time to come to a consensus and the fixes can be included in stable
releases afterwards.

Stefan

>
> > - Who is affected and what is the impact?
> >
> > There are still a few hours left before -rc4 is tagged. I will merge it
> > if consensus is reached and the missing information becomes clear.
> >
> > Thanks,
> > Stefan
> >
> >>
> >>
> >>> ---
> >>>   hw/i386/intel_iommu.c | 10 ++++++++++
> >>>   1 file changed, 10 insertions(+)
> >>>
> >>> diff --git a/hw/i386/intel_iommu.c b/hw/i386/intel_iommu.c
> >>> index dffd7ee885..fea2220013 100644
> >>> --- a/hw/i386/intel_iommu.c
> >>> +++ b/hw/i386/intel_iommu.c
> >>> @@ -4216,6 +4216,7 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUStat=
e *s, PCIBus *bus,
> >>>       vtd_dev_as =3D g_hash_table_lookup(s->vtd_address_spaces, &key)=
;
> >>>       if (!vtd_dev_as) {
> >>>           struct vtd_as_key *new_key =3D g_malloc(sizeof(*new_key));
> >>> +        bool take_bql =3D !bql_locked();
> >>>
> >>>           new_key->bus =3D bus;
> >>>           new_key->devfn =3D devfn;
> >>> @@ -4238,6 +4239,11 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSta=
te *s, PCIBus *bus,
> >>>           vtd_dev_as->context_cache_entry.context_cache_gen =3D 0;
> >>>           vtd_dev_as->iova_tree =3D iova_tree_new();
> >>>
> >>> +        /* Some functions in this branch require the bql, make sure =
we own it */
> >>> +        if (take_bql) {
> >>> +            bql_lock();
> >>> +        }
> >>> +
> >>>           memory_region_init(&vtd_dev_as->root, OBJECT(s), name, UINT=
64_MAX);
> >>>           address_space_init(&vtd_dev_as->as, &vtd_dev_as->root, "vtd=
-root");
> >>>
> >>> @@ -4305,6 +4311,10 @@ VTDAddressSpace *vtd_find_add_as(IntelIOMMUSta=
te *s, PCIBus *bus,
> >>>
> >>>           vtd_switch_address_space(vtd_dev_as);
> >>>
> >>> +        if (take_bql) {
> >>> +            bql_unlock();
> >>> +        }
> >>> +
> >>>           g_hash_table_insert(s->vtd_address_spaces, new_key, vtd_dev=
_as);
> >>>       }
> >>>       return vtd_dev_as;
> >>> --
> >>> 2.49.0
> >>

