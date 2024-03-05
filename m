Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C33FC5478C
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 06:23:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhOCp-0002dD-Hx; Tue, 05 Mar 2024 01:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhOCn-0002cs-E6
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:23:13 -0500
Received: from mail-vk1-xa30.google.com ([2607:f8b0:4864:20::a30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1rhOCl-0001eg-M3
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 01:23:13 -0500
Received: by mail-vk1-xa30.google.com with SMTP id
 71dfb90a1353d-4cb26623dc1so155451e0c.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 22:23:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1709619790; x=1710224590; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
 b=D+3Y6BpYGcqIHH/dr7vsu/BV7cBxUmC8jAHVb9DdzTBdZDTx3Gzjb9fw9rovnR1lJa
 sUjVtkAE2Bdkhy1J6pT5U4MIG59aOpD0gemPhUtzVoKKO9ja97j/3ote6Aj85Z62uqlE
 6u3TbrGaZ5ONYNxSD2rHLTpi1lWUgX1vR2Aaky3CnN4Cdic0scS653r2IsdoJ/KXucSl
 BTqrCwDFjLS+HDuG0AaJpjYObx0fL2X79kBjyJXe6TrIQo2gT19Qel67DJ+sGMARpcmT
 rGXEtF4sb/eb+sRwVsvP9h4a3YOT4hXZNIofv+5ttTpBa/qdNSqJKjFW9HH69E/izKnr
 rTKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709619790; x=1710224590;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MOnvvH2W03oK21Enygd77Kz3RD653oFonWkuoJk8SUU=;
 b=VNH5O36xD4uewuHrL4EHvdThM1g020/8mbMMqtIOuWsnIY9v4b1O2yYRNxYjog54R1
 VS4/KxJNrfEofGtl1a6tOruNb+I5rPjVRPTHbZPqf+p85PFgy/rHBW+Wrop2060N7E/0
 nbMynP0piaJLRzmTpgje9/paD8p4rPXcDudaBt+btoWKRHtsTUw7h/aDeKOYUMi89O5Q
 5aAfu0uEefgfnPBll+aiqPJXM7OkljRfPQHCiPxMkptUj+fU2rnrc7VArJj02H5QOvZ6
 Q0ClFFvX0bp0D0CteZTkP8JNyXXHbBhMb1399iLj1DgXzRdFwOzLGzj5AM42RbEmsxrn
 nEmQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCWhLColNxUMhDZcAqUjSXDzqlqZoy44DW5h7OA+f7+qbUxa+LkLj+9fDSHjMOLvpRD8luVUf84TNjwXyFa086Gp0ClUyUg=
X-Gm-Message-State: AOJu0Yxjf/PgvKtibITaMs+4GLHbiqj+J/kOF2d4mZSmfS/tNkNk81R6
 h7XZKvfJ+CvjY63eaaZQK67xoxttMm9RT9aMHTPGsYn3AUbbbh3x0dgxkmB12dwKPiNTgu9NyJx
 M3iDCFR/ScBAvs7Rr2dOpFwNu6hnx7OSCWQRCiA==
X-Google-Smtp-Source: AGHT+IF8wFchH2Tpcwl+m9+vC++9MiGH8pjEs4cet64MI10UrFTvnJG9+E2iM+RbR2/QpLJ5rn/dajElMcAyZ2RW5JY=
X-Received: by 2002:a05:6122:da7:b0:4ca:615e:1b61 with SMTP id
 bc39-20020a0561220da700b004ca615e1b61mr914463vkb.10.1709619790595; Mon, 04
 Mar 2024 22:23:10 -0800 (PST)
MIME-Version: 1.0
References: <20240301082248.3456086-1-horenchuang@bytedance.com>
 <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
In-Reply-To: <87frx6btqp.fsf@yhuang6-desk2.ccr.corp.intel.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Mon, 4 Mar 2024 22:22:59 -0800
Message-ID: <CAKPbEqr-0yPDW7qps24vJgVCtVOGy_Jm4kcc0FKUsL3d9APDsw@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v1 0/1] Improved Memory Tier Creation for
 CPUless NUMA Nodes
To: "Huang, Ying" <ying.huang@intel.com>
Cc: Gregory Price <gourry.memverge@gmail.com>, aneesh.kumar@linux.ibm.com,
 mhocko@suse.com, 
 tj@kernel.org, john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Len Brown <lenb@kernel.org>, 
 Andrew Morton <akpm@linux-foundation.org>, Dave Jiang <dave.jiang@intel.com>, 
 Dan Williams <dan.j.williams@intel.com>,
 Jonathan Cameron <Jonathan.Cameron@huawei.com>, 
 linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, linux-cxl@vger.kernel.org, 
 qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::a30;
 envelope-from=horenchuang@bytedance.com; helo=mail-vk1-xa30.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Sun, Mar 3, 2024 at 6:47=E2=80=AFPM Huang, Ying <ying.huang@intel.com> w=
rote:
>
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> writes:
>
> > The memory tiering component in the kernel is functionally useless for
> > CPUless memory/non-DRAM devices like CXL1.1 type3 memory because the no=
des
> > are lumped together in the DRAM tier.
> > https://lore.kernel.org/linux-mm/PH0PR08MB7955E9F08CCB64F23963B5C3A860A=
@PH0PR08MB7955.namprd08.prod.outlook.com/T/
>
> I think that it's unfair to call it "useless".  Yes, it doesn't work if
> the CXL memory device are not enumerate via drivers/dax/kmem.c.  So,
> please be specific about in which cases it doesn't work instead of too
> general "useless".
>

Thank you and I didn't mean anything specific. I simply reused phrases
we discussed
earlier in the previous patchset. I will change them to the following in v2=
:
"At boot time, current memory tiering assigns all detected memory nodes
to the same DRAM tier. This results in CPUless memory/non-DRAM devices,
such as CXL1.1 type3 memory, being unable to be assigned to the
correct memory tier,
leading to the inability to migrate pages between different types of memory=
."

Please see if this looks more specific.

> > This patchset automatically resolves the issues. It delays the initiali=
zation
> > of memory tiers for CPUless NUMA nodes until they obtain HMAT informati=
on
> > at boot time, eliminating the need for user intervention.
> > If no HMAT specified, it falls back to using `default_dram_type`.
> >
> > Example usecase:
> > We have CXL memory on the host, and we create VMs with a new system mem=
ory
> > device backed by host CXL memory. We inject CXL memory performance attr=
ibutes
> > through QEMU, and the guest now sees memory nodes with performance attr=
ibutes
> > in HMAT. With this change, we enable the guest kernel to construct
> > the correct memory tiering for the memory nodes.
> >
> > Ho-Ren (Jack) Chuang (1):
> >   memory tier: acpi/hmat: create CPUless memory tiers after obtaining
> >     HMAT info
> >
> >  drivers/acpi/numa/hmat.c     |  3 ++
> >  include/linux/memory-tiers.h |  6 +++
> >  mm/memory-tiers.c            | 76 ++++++++++++++++++++++++++++++++----
> >  3 files changed, 77 insertions(+), 8 deletions(-)
>
> --
> Best Regards,
> Huang, Ying

--=20
---
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

