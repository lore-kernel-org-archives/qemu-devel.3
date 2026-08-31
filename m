Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A866C624A5
	for <qemu-devel@archiver.kernel.org>; Mon, 31 Aug 2026 07:04:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x0w4Y-0001u7-0A; Mon, 31 Aug 2026 03:04:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x0w4V-0001tC-KQ
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:04:47 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alexander@mihalicyn.com>)
 id 1x0w4T-00027H-Sg
 for qemu-devel@nongnu.org; Mon, 31 Aug 2026 03:04:47 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-6a0de062db5so5144635a12.1
 for <qemu-devel@nongnu.org>; Mon, 31 Aug 2026 00:04:45 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788159883; cv=none;
 d=google.com; s=arc-20260327;
 b=m1rcM/yiRxDuLXiDHsvktFnZAOLRzS07jJj4p6Q58J9lTsJ9kcyf3pem0oriazzNpe
 NL8ITOBbauofeOc0yYiFS4hsaLyaHiHd937vr+W/djdz295NWU+EuIpMvpF2L1Xa9/qQ
 sZwsYp9j1JREXxBsA7QF+r0HC1I3flXS+EGp/Fdvc9KXQ7dbdFIXPICUJsTed97ngA45
 hPN5K88S6ZbfJ6hZQHdsI+TqdBqkp5egiw28zo20Y1xBLfrYsce3Gj+V+/WQiSTrSdZa
 A2WclaEZu0q3Gztu8wn5B5WRokjnelY58NuUq2MDM6dPxemr2hzgJB4X991ISdSwEF23
 5B+A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=JSPRRhdaFjGkIIgSssRGxfKUJEiw8u5JIadzvX6XUbM=;
 fh=6uVfJwzmfrZLdXBSV5iI6x6Nc2wlt6gd+Fo5tHMz9Uo=;
 b=hc/8GKpE/CmXAydCBK/p+1i1+OO52N/WuxArc9l9dte7P96URaoqGyTCKkTE0SGvwL
 Swmfo56E1H5XDlE1q5w7rgZE41ZYgIobJUAxlsNx6drdMZJxqtbZA79jlZv/Pm31T2O9
 GEHngr3VAtBihu5xIY/tbJFwPJ5ApmZKNwGJicV7jBdISAjq3m60LbfAQYvCpC03Qskt
 h1J5ge0Up98CCSTYp4X46RcVnPD7dphxbDHGIk+dU/Of0FHjEuWs0KI4CevqBfFIFR5v
 gd+5oHGHmPyzxp4TNTrkjwWCvUrA4wyGUatWvDHWU+wtqwaeCx9o7PnGreiD5YTajvH6
 9ZuA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=mihalicyn.com; s=mihalicyn; t=1788159883; x=1788764683; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=JSPRRhdaFjGkIIgSssRGxfKUJEiw8u5JIadzvX6XUbM=;
 b=IRluT8fJQX8OhGi3jzUO2kaifNQ4JYfAM6lxwO50WLd0kaLy2Cp0k1D+SrgKnZHExN
 uatAHWwCvv0KC8yFZay2jtMUuyCYI8oWLiQZYI3bgEI72NLhObraOCbli/94Bozb0XtM
 xr8fGP4BLqYsS5Qs8Vu6XYT6z3AU+dtR1Hd00=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788159883; x=1788764683;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=JSPRRhdaFjGkIIgSssRGxfKUJEiw8u5JIadzvX6XUbM=;
 b=Al5CqEEBsL6sANoOG1OWB5LUb9R0YzfKsnK+XeEdtKxqKQQRF3gx03XAnGKjIzeXGu
 g0N2DBwXRBY5kuiaVwnh0Y8SqytGtsBX3G97DD3zbTu5xyF4R67kmXLLIV+hvzY1nVkK
 PC9oApQ2YHSqsUEpSsi0MV19CwcHE1SO1iM10NI6kzkWNDRXSlJhj2KOWyigTgKcG/dP
 gb4ekAkGMSBn4Gtq4+7PpikTquzwSw06TDq+49Tqb6qwb2LmvBfBeBrbwd2MCY4thz+L
 8U3fJH04dQaxb7owpPl66wgjSQA6rKbMcDUcfmxMwD06wNiTEOsOwN5yQN8/fxyq4Bf5
 TNTA==
X-Gm-Message-State: AFuF++kHTLBPobIiSTu+LdSXzW7YQ5LQRcDs6PS4u+XaoLhgDqgeAy7s
 bXlKu4kxVDGWNgRVN+Xtj1aFpNJAflRp/56mKA6Y8vyABwqKosnZ/EpiEUoqg8Gu+rduiYhwdmG
 KZTUlBkQ9Mmozb/BaDO2E8mIQzBX31dSvQOoyoii2uw==
X-Gm-Gg: AR+sD11WThIrpwsnHT/YxW5IdUXez1b4uKSjYOAKS11Tld4V/rNP/RVidAXWOSUbt/d
 UBuSAFPQ5C3qiDlxJ19JHySj4MRHk/gq1lCCeRqqsPxqpvoXiNvdHP3oSd0Vf7hqen3DzpA/xoz
 8N+ePSjJW8jSBKgAn/xGiXdQP5hWEsxXOCoJ0W0OFRNlcoDYAu/m0e+V7wWyjkFLSTKR0+4UTT9
 XA3K3nxrwP4YqrzPaCWcSC6oMc9PcUoJtumVdBPKknFAZiqqfp8LQGVq1tEmXYXiOEoNo88qnar
 jJwCRbzJYPK53UU9S7G1o5K0QqGMAMaWYl9CH7EsyUPH08x/0AU8hMbdH6ZJif8oqu5BJEAtFdw
 uaw==
X-Received: by 2002:a17:907:f495:b0:c25:37e2:2d3b with SMTP id
 a640c23a62f3a-c25571b387emr1434356866b.10.1788159883208; Mon, 31 Aug 2026
 00:04:43 -0700 (PDT)
MIME-Version: 1.0
References: <20260803083046.110121-1-alexander@mihalicyn.com>
 <anCasYYUJBhDqOKS@AALNPWKJENSEN.aal.scsc.local>
In-Reply-To: <anCasYYUJBhDqOKS@AALNPWKJENSEN.aal.scsc.local>
From: Alexander Mikhalitsyn <alexander@mihalicyn.com>
Date: Mon, 31 Aug 2026 09:04:32 +0200
X-Gm-Features: AcwNN1ViMd0EzedgBTfqiM0fXlcrYCfmuU17JRYBQkSz6EVXrQO4-Lqt4xOnv-Q
Message-ID: <CAJqdLroHb7mwMx57zEpfhPcXsHwL0jCeEawCL1_f_ZYOytofRQ@mail.gmail.com>
Subject: Re: [PATCH v3 0/2] hw/nvme: support online resize
To: Klaus Jensen <its@irrelevant.dk>
Cc: qemu-devel@nongnu.org,
 =?UTF-8?Q?St=C3=A9phane_Graber?= <stgraber@stgraber.org>, 
 Keith Busch <kbusch@kernel.org>, qemu-block@nongnu.org, 
 Jesper Devantier <foss@defmacro.it>, 
 Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=alexander@mihalicyn.com; helo=mail-ed1-x536.google.com
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

Am Mo., 3. Aug. 2026 um 15:42 Uhr schrieb Klaus Jensen <its@irrelevant.dk>:
>
> On Aug  3 10:30, Alexander Mikhalitsyn wrote:
> > From: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@futurfusion.io>
> >
> > Dear friends,
> >
> > This patchset is aimed to support online resize for NVMe emulated
> > device. My approach is simple - I just implement (BlockDevOps *)->resize_cb()
> > callback and ensure that AER notification is fired to all controllers using
> > a namespace that is being resized.
> >
> > Testing.
> >
> > I manually validated this with Debian 13 VM (a resized disk was a root disk) and
> > Windows Server 2022 (a resized disk was a secondary one).
> >
> > Git tree:
> > https://gitlab.com/mihalicyn/qemu/-/commits/nvme-resize
> >
> > Changelog for version 3:
> > - rebased
> >
> > Changelog for version 2:
> > - checkpatch fixes
> > - rebased
> > - CI is green (https://gitlab.com/mihalicyn/qemu/-/pipelines/2602102750)
> >
> > Kind regards,
> > Alex
> >
> > Alexander Mikhalitsyn (2):
> >   hw/nvme: initialize ns->subsys for n->namespace
> >   hw/nvme: support online resize
> >
> >  hw/nvme/ctrl.c | 10 ++++++++
> >  hw/nvme/ns.c   | 68 +++++++++++++++++++++++++++++++++++++++++++++++++-
> >  hw/nvme/nvme.h |  2 ++
> >  3 files changed, 79 insertions(+), 1 deletion(-)
> >
> > --
> > 2.47.3
> >
> >

Hi Klaus,

>
> LGTM.
>
> Reviewed-by: Klaus Jensen <k.jensen@samsung.com>

Thank you, I wonder if you have a plan to take this into nvme.next soon?

Kind regards,
Alex

