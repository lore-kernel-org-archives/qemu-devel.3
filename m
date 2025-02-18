Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C5D7C021AA
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Feb 2025 16:52:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tkQpK-0003HC-Pp; Tue, 18 Feb 2025 11:52:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkQpH-0003Gw-Oa
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:52:04 -0500
Received: from mail-yw1-x112d.google.com ([2607:f8b0:4864:20::112d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tkQpG-0003pt-66
 for qemu-devel@nongnu.org; Tue, 18 Feb 2025 11:52:03 -0500
Received: by mail-yw1-x112d.google.com with SMTP id
 00721157ae682-6f4bc408e49so44396467b3.1
 for <qemu-devel@nongnu.org>; Tue, 18 Feb 2025 08:52:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1739897521; x=1740502321; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=SUg5hRemBTl583agbqIXv+TU9BbZVBk0hFvd+grZogk=;
 b=wTf2AkEXFcq1EL5mneP4Ceu80DO39nv5pH0mXB1ZOj/3cGylSwxR0KL7LCek9JHB7o
 Of5FO4W+Z8vF2nv7Vn3h2E/QbTUp2mNy9V7EI/40thzLrXiZezv+VXtt7ju19wMS4AH8
 a0TkHYNqMnGWTTnqm6powjc2XkzlVj38iMg2rqUQbmKusD37SNtzEqES9JImYWjW3IWN
 d9P/6wn5oSD9XZTbBOMC7OmYPSfgjJZ9D5wK2r8o4V8u702IzL1JZN+e2DMHvH4b8h3w
 oe+PJQoFXT6MopX/QviDsV3/NCOZ3DVSyQsca/1Td1qtCVGeYrKJ4eR6X8CWLdzeSNGR
 /fzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739897521; x=1740502321;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=SUg5hRemBTl583agbqIXv+TU9BbZVBk0hFvd+grZogk=;
 b=b/BiCmSPh5SjFCC4w3ZSoUJQOM3ByC0vBhvbheFe+yLrWzLgq6mPQKi10zpkVmuXhn
 j2A5rQfwGNHZ1NcJdKfU5AbfDqpzzEy+fwcdJwQCDI0TbIETJpguzVTf6xVW3ywfAFLy
 Hy2tk9zYmM30ANhkj6uu+pxaXEY1rJuRuV/muYlxPZSnZy9UDIyd3Hj+oyslAcZxxhJT
 CU7wXu1tU34C61LIi7kV1QKUdjNCtuUhI27YWyHkpSlecNmaZUVHd1QaXITBnt50EYfu
 c9LJMuWlkPjbswele3GmJzIuam2lY3lRMZ0/ktEDX95WhLeiJYYgqdxx0m6PtTST2rxv
 rCxg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWWKryirn07vCaP0Lyy7F8TaEK4f6ywPgCmg0YvYrmiDaq2cqIvTDEjobdFV8Sc2UHKnpoysdLavdqC@nongnu.org
X-Gm-Message-State: AOJu0YyJvSqFS0TX3S3xYppkLmm/4kWGP4Ukd255ZjkdoRJEdtzI8X8l
 w2cGRl5PajSValmh+cnZV4F9V1tlFAM4gatGANNO6pJWGHjW60mRlQhsNORV38MfA4RLKuyc2cT
 0PrYV6DtSYZilUxyDioPk8ApfW9XSb+ckdTCTIA==
X-Gm-Gg: ASbGncsnQKPYZOSb3XVRKJQBxrsUuBWxnTJ80JIc19ZeVAhmRJlkCH0w26OQ4Lt6+Sz
 tCtPZG/S1Ec8aRGNM733ay3OzyrOC5juMHhMXl28Ax4IF6Z+cHQWH86KjNN7kowqiolaMur/GDw
 ==
X-Google-Smtp-Source: AGHT+IFSBDMDskdJZhM3j45Vj5qf+6sGvSLwRxA4uxaIfiGTNEtJqe17CHndY3nC9BvVA1V5yZtmyJXNtiEBVwndkDo=
X-Received: by 2002:a05:690c:3703:b0:6f7:56f7:2398 with SMTP id
 00721157ae682-6fba56589bbmr4990197b3.7.1739897520952; Tue, 18 Feb 2025
 08:52:00 -0800 (PST)
MIME-Version: 1.0
References: <87jz9sq23d.fsf@draig.linaro.org> <87o6yzjlni.fsf@draig.linaro.org>
 <887b8dba-2a23-4e14-8388-729cbbccfd6e@linaro.org>
In-Reply-To: <887b8dba-2a23-4e14-8388-729cbbccfd6e@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Feb 2025 16:51:49 +0000
X-Gm-Features: AWEUYZnhooUUKPz4K6eif7fw_HZkSe6YUG5lBtFhqMgDa0ez7TpBtReD30u6aKo
Message-ID: <CAFEAcA8-yKK9ud4dUF2bEiK=VLpZdw53+smoxdHB48NeMHsw8g@mail.gmail.com>
Subject: Re: KVM/QEMU community call agenda items for 18/2/25
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>
Cc: =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 Alistair Francis <alistair.francis@wdc.com>, 
 Alessandro Di Federico <ale@rev.ng>, Anton Johansson <anjo@rev.ng>,
 Markus Armbruster <armbru@redhat.com>, 
 Brian Cain <bcain@quicinc.com>, "Daniel P. Berrange" <berrange@redhat.com>, 
 Chao Peng <chao.p.peng@linux.intel.com>, cjia@nvidia.com, 
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, cw@f00f.org, 
 dhedde@kalrayinc.com, Eric Blake <eblake@redhat.com>, eblot@rivosinc.com, 
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, 
 Elena Ufimtseva <elena.ufimtseva@oracle.com>,
 Auger Eric <eric.auger@redhat.com>, felipe@nutanix.com, 
 iggy@theiggy.com, Warner Losh <imp@bsdimp.com>, Jan Kiszka <jan.kiszka@web.de>,
 Jason Gunthorpe <jgg@nvidia.com>, jidong.xiao@gmail.com,
 Jim Shu <jim.shu@sifive.com>, Joao Martins <joao.m.martins@oracle.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, 
 Luc Michel <luc@lmichel.fr>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, 
 Max Chou <max.chou@sifive.com>, Mark Burton <mburton@qti.qualcomm.com>,
 mdean@redhat.com, 
 mimu@linux.vnet.ibm.com, "Ho, Nelson" <nelson.ho@windriver.com>, 
 Paul Walmsley <paul.walmsley@sifive.com>,
 QEMU Developers <qemu-devel@nongnu.org>, Roberto Campesato <rbc@meta.com>,
 Richard Henderson <richard.henderson@linaro.org>, 
 Shameerali Kolothum Thodi <shameerali.kolothum.thodi@huawei.com>,
 Bernhard Beschow <shentey@gmail.com>, 
 Stefan Hajnoczi <stefanha@gmail.com>, Thomas Huth <thuth@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>, 
 z.huo@139.com, LIU Zhiwei <zhiwei_liu@linux.alibaba.com>, zwu.kernel@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::112d;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112d.google.com
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

On Tue, 18 Feb 2025 at 16:42, Philippe Mathieu-Daud=C3=A9 <philmd@linaro.or=
g> wrote:
> - About { embedded / heap allocated } QOM objects: In C developers
>    don't want to give away the embedded model, as it offers free
>    type checks (while heap-alloc must use runtime checks). IIUC with
>    Rust it is the opposite, you mentioned is simpler to get build time
>    checks with the heap-alloc version, is that right? (I didn't took
>    particular notes about it). I'm interested because for declarative
>    dynamic machines modelling, it is simpler to use the heap to allocate
>    the objects, and I'd like to promote that more.

Mmm, I vaguely recall a discussion in a QEMU Summit a few years
back about this; we've got a mix of embedded-allocation and
the (older style) heap-alloc, but we aren't necessarily
completely wedded to embedded-allocation and for dynamic
machine creation heap-alloc is more natural.

-- PMM

