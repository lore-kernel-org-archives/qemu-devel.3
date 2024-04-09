Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A441DCD128A
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Apr 2024 19:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ruGhx-0001s0-KG; Tue, 09 Apr 2024 15:00:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruGhl-0001pT-9e
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:00:34 -0400
Received: from mail-yb1-xb29.google.com ([2607:f8b0:4864:20::b29])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <horenchuang@bytedance.com>)
 id 1ruGhj-0006fc-7y
 for qemu-devel@nongnu.org; Tue, 09 Apr 2024 15:00:25 -0400
Received: by mail-yb1-xb29.google.com with SMTP id
 3f1490d57ef6-ddaad2aeab1so5191062276.3
 for <qemu-devel@nongnu.org>; Tue, 09 Apr 2024 12:00:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance.com; s=google; t=1712689217; x=1713294017; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=5CBvcfp0rqG8/aCbqDf2QUOPCz/n3wHa5btTw1mm84E=;
 b=epphVPTx+qw/7j5kLJir/7olNg43xYOyNvpCCIoQZqVNFLEoDGwO4xobDpDKDDfaJd
 NATHrzc2IVSLJmq5DjKUWQeJX0UiXCrTrfUPeiIqnPrAtgnye8Bi2QAVe3vaXdzEm//+
 Rmr/bknmmiQrerTDrJBmx7/+53mwwszaYeeGAW6fwYBYLOk+i5ls4zu/XMJlJ0OANnJm
 P1aQyDZF3F4Oya6Jb1RGuK8ESvcxf1QD+ENEuiE4rJ3D379LVciEcswK+0JcAz1gsevW
 GS7ZYbPiuqeZbSaIXcYmgW5D/Zq4tqQaunNIoEl8HcdibdR/kOpEqJzj2tKpPQvu3MNl
 LEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1712689217; x=1713294017;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=5CBvcfp0rqG8/aCbqDf2QUOPCz/n3wHa5btTw1mm84E=;
 b=NmvbGQRJGmP3ltPa5m+1af4Fep1a2lW1A/AYfvVeHIViX3P1fIPabHbzHJSslugaPW
 NQXbbX0UMsFj1LACgDLHb5WLS14G15aXFTo+ewf5P3X6DbbHj9IsTEs3GBDtNIX0Q9R/
 jL0hrOnoznD9YBF4Ha3kTuR67EwXp7Uu5UUcnxZTOGTm00YmNs2oFpG4cIYlboSkUKYn
 t87TdAPhOibFSNETALbJ4TvB0snjrZjlsKGDrcMTILnVqzOgqwbBI4gGl+MQ1ixOWV4O
 9boCyrQk52QM6lIOKGjBkqtUkLLP4+MLCllWk2tUaKfiSDycOqmFLTeImCQFcVwDST/8
 LUOw==
X-Forwarded-Encrypted: i=1;
 AJvYcCV7oRBwSI+UBrJHa/SAFf9GX4420yK1ZTev5Bi6GDnfHLTBfKxszJlqZvZROoRIdbRrLFinO1rQG31dVbOP4G9HSo1Ly7s=
X-Gm-Message-State: AOJu0YwOC5jxxqd6UNCjwYm6Y+mgmcoIfLvUn3gs36647EpX8tN9KZ1o
 bMYfeApADDSOGNacecbesq1M42XdGoyD+/pB2qaZ9nwXfPL0F8DiJaykLoN35xX27dMKBP1WoJ+
 Qj8iwMHU4rr20Sn6kz23j7tMzE1IOhHTH0hmGdg==
X-Google-Smtp-Source: AGHT+IGW6ppz/qE4BrLvmNCRDbTF9xfQE/vBrRFhezaSlxNTiNANoYpDGSEDGNZJ8OzMKjviuEREaTWu0J3o1ZesD1c=
X-Received: by 2002:a25:2748:0:b0:dcd:ba5a:8704 with SMTP id
 n69-20020a252748000000b00dcdba5a8704mr700084ybn.24.1712689217227; Tue, 09 Apr
 2024 12:00:17 -0700 (PDT)
MIME-Version: 1.0
References: <20240405000707.2670063-1-horenchuang@bytedance.com>
 <20240405000707.2670063-2-horenchuang@bytedance.com>
 <20240405145624.00000b31@Huawei.com>
In-Reply-To: <20240405145624.00000b31@Huawei.com>
From: "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>
Date: Tue, 9 Apr 2024 12:00:06 -0700
Message-ID: <CAKPbEqrTvY4bsRjc=wBWpGtJM5_ZfH50-EX4Zq2O_ram9_0WbQ@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v11 1/2] memory tier: dax/kmem: introduce
 an abstract layer for finding, allocating, and putting memory types
To: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: "Huang, Ying" <ying.huang@intel.com>,
 Gregory Price <gourry.memverge@gmail.com>, 
 aneesh.kumar@linux.ibm.com, mhocko@suse.com, tj@kernel.org, 
 john@jagalactic.com, Eishan Mirakhur <emirakhur@micron.com>, 
 Vinicius Tavares Petrucci <vtavarespetr@micron.com>,
 Ravis OpenSrc <Ravis.OpenSrc@micron.com>, 
 Alistair Popple <apopple@nvidia.com>,
 Srinivasulu Thanneeru <sthanneeru@micron.com>, 
 SeongJae Park <sj@kernel.org>, Dan Williams <dan.j.williams@intel.com>, 
 Vishal Verma <vishal.l.verma@intel.com>, Dave Jiang <dave.jiang@intel.com>, 
 Andrew Morton <akpm@linux-foundation.org>, nvdimm@lists.linux.dev, 
 linux-cxl@vger.kernel.org, linux-kernel@vger.kernel.org, linux-mm@kvack.org, 
 "Ho-Ren (Jack) Chuang" <horenc@vt.edu>,
 "Ho-Ren (Jack) Chuang" <horenchuang@gmail.com>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::b29;
 envelope-from=horenchuang@bytedance.com; helo=mail-yb1-xb29.google.com
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

Hi Jonathan,

On Fri, Apr 5, 2024 at 6:56=E2=80=AFAM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Fri,  5 Apr 2024 00:07:05 +0000
> "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com> wrote:
>
> > Since different memory devices require finding, allocating, and putting
> > memory types, these common steps are abstracted in this patch,
> > enhancing the scalability and conciseness of the code.
> >
> > Signed-off-by: Ho-Ren (Jack) Chuang <horenchuang@bytedance.com>
> > Reviewed-by: "Huang, Ying" <ying.huang@intel.com>
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawie.com>
>
Thank you for reviewing and for adding your "Reviewed-by"!
I was wondering if I need to send a v12 and manually add
this to the commit description, or if this is sufficient.

--=20
Best regards,
Ho-Ren (Jack) Chuang
=E8=8E=8A=E8=B3=80=E4=BB=BB

