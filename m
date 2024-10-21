Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6301D15DA5
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Oct 2024 15:06:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t2tzG-0003yq-3n; Mon, 21 Oct 2024 11:06:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2tzE-0003yb-Aq
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:06:24 -0400
Received: from mail-ed1-x535.google.com ([2a00:1450:4864:20::535])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t2tzC-0003Pj-S9
 for qemu-devel@nongnu.org; Mon, 21 Oct 2024 11:06:24 -0400
Received: by mail-ed1-x535.google.com with SMTP id
 4fb4d7f45d1cf-5c94861ee25so2332528a12.0
 for <qemu-devel@nongnu.org>; Mon, 21 Oct 2024 08:06:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1729523180; x=1730127980; darn=nongnu.org;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aHVfiBOgNmdbZgMRSPscD65XRrYsmp8Bx8PVi0hGNMk=;
 b=enoWH+Y4W0CFKS+o/FyPHRz5PA2QV32k5MTkiIHRlRP0k91bCSJN+xLwImROIyPXEx
 PUnGowZ5ehFVybWEobm/9+so96sYnWa9aUXRnNByanRYnELml5PjpU7j8tP2TFzJEX3a
 7CD8xacWkn3fx9d4GtjAOOQLDwJ5cGoPVVxi6i0hWpovbssdhvx1L5NpwTg6Xk3CToE9
 +/vTco1kKlAD5Jl76QgTUGM6eSHMaCTa3hKpptwOIzBLNdqRJtKr5Ugo5MFMdwZaMI9r
 JU9wjlnuZaQE1riLADs8PbHYlTaKEHTEd1HeCCGMvkoGqwMJRJX/iyT5qYgBHFwtgeMR
 hlmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1729523180; x=1730127980;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=aHVfiBOgNmdbZgMRSPscD65XRrYsmp8Bx8PVi0hGNMk=;
 b=vN9hq1wYgyN8zVOcY1LezCiak2e9I/r2mBGzlGfieC3DwYJe4JGooMG8jJl45Qpuw9
 +5Sd3HSgoDk7evmL027JmEsxB1rojnhUiv84eypnueH5Yg6c1UCpN3BXk05zrRMSztR/
 znwCgCJm1q5+pKEgHj+P19BHUOLH0pFZbQuoTvT8Zw/JOYxhyOQeK7j3IGMHdQPHCAdU
 sukCHQsAuYftmKz+HCGE0r1Pwd6CDoIdvYa6IuocbgwfKdhqj385Ou79KhxVfJr5OJfF
 RFkVGsN/gitsms1fftxyhKeHuCb63xnfl/Z9nkZ5pR1JGWTcEqD0JulJiow10/KQY5q9
 W15Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXPPtmt3B//LCKHx9rGYl899pkjlYB5uOPXudYTZkPYiOLjSGTnKSiI900gthwWLQRXyN6xnfDg3W/5@nongnu.org
X-Gm-Message-State: AOJu0YyqzgE/jJqUZjFPr8GQTxyp0kVH7ylWhdUdsFiZC9H1biSB0wy/
 AcGqx4/SWJbKx8ChwndtvGvMKbi2ANHTxuhZaYpnGPHxmem+eH7hu9HXT169ds9XI4TV4JW6xFR
 xDSdKg/gEdGUwJdCbTxMZfQbDXM+rJu2SXLhvDA==
X-Google-Smtp-Source: AGHT+IH/AnGzVe5cIuryZ/BqoRYgUiSZbNgXU75XWSn4Iu/CtfFeJrYE0owtMAblNaWNRUrIhSq6buzwjPp+Kk+OHhU=
X-Received: by 2002:a05:6402:2548:b0:5c7:202f:ec9b with SMTP id
 4fb4d7f45d1cf-5ca0ac61ec7mr12275820a12.16.1729523180037; Mon, 21 Oct 2024
 08:06:20 -0700 (PDT)
MIME-Version: 1.0
References: <ZxPZ5oUDRcVroh7o@intel.com>
 <CAFEAcA8m4OeDHopFxCL3MP-cmu-PO5=2+MjNBG7YCudpKdoqDA@mail.gmail.com>
 <ZxZjqypRL7d2rMuQ@intel.com>
 <CAFEAcA-imJJQO=WAmCAHBY1MtszuPyyaD9OHWMRx88h-fjVvsw@mail.gmail.com>
 <ZxZwwe1ULIUqEdKN@intel.com>
In-Reply-To: <ZxZwwe1ULIUqEdKN@intel.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 21 Oct 2024 16:06:08 +0100
Message-ID: <CAFEAcA9E_-J3EJ+izeErnHDAwaP1LoctRaihu=5xTYrMSnqVig@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=5BQuestion=5D_What_is_the_definition_of_=E2=80=9Cprivate?=
 =?UTF-8?Q?=E2=80=9D_fields_in_QOM=3F?=
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>, 
 Eduardo Habkost <eduardo@habkost.net>, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::535;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x535.google.com
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

On Mon, 21 Oct 2024 at 16:02, Zhao Liu <zhao1.liu@intel.com> wrote:
>
> On Mon, Oct 21, 2024 at 03:20:39PM +0100, Peter Maydell wrote:
> > What I mean by "the private/public markers are unnecessary" is
> > that they don't tell the reader anything, because all the fields
> > in a QOM device struct are private.
>
> This time I really understand the question of whether it's okay to
> directly access parent_obj/parent_class. :-)
>
> > If you're not in the implementation of that class, then you shouldn't
> > really be directly touching any of the fields in the state struct.
> > (In some places we take a shortcut and do it. But really it's almost
> > never necessary.)
>
> Thank you for your further explanation! I hadn=E2=80=99t noticed that. So=
, for
> other code (code outside the class/object implementation) to access the
> fields other than parent_obj/parent_class of class/state struct, the
> most ideal way would be to use the set/get property interfaces as
> much as possible instead of accessing them directly, right?

Yes, or whatever APIs (functions etc) are provided for working
with the class. If you have a specific example we could probably
make some more concrete suggestions.

-- PMM

