Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 875CDC531C9
	for <qemu-devel@archiver.kernel.org>; Sat, 25 Jul 2026 11:53:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wnavW-0002Ii-Lw; Sat, 25 Jul 2026 07:52:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnavO-0002Hx-9G
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 07:52:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wnavL-0003Xl-VJ
 for qemu-devel@nongnu.org; Sat, 25 Jul 2026 07:52:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1784980330;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jUicF8+0PQzjkNPpqUYxV6sqKjt7zQAlA9KYujX4b2M=;
 b=ZtpkP/gbyQeEFGfNJw6g8AxVzdgEFIvIpunt62h4juITbPVB9dGPumR3+ItOEIqo31tCPP
 K6vnYaCsvq6hH4aff8ACD5eOBaD/elw4iBUC5PHyy2gl8TU+CYpOM3g0e+Ev3KEVWHoFsV
 //+7DJm4oPU6pNKIYXwuEDhQS3D+3b0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-Z7mgohPgNwK4DzsklFqA2g-1; Sat, 25 Jul 2026 07:52:08 -0400
X-MC-Unique: Z7mgohPgNwK4DzsklFqA2g-1
X-Mimecast-MFC-AGG-ID: Z7mgohPgNwK4DzsklFqA2g_1784980327
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495569acf8dso8384275e9.1
 for <qemu-devel@nongnu.org>; Sat, 25 Jul 2026 04:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1784980327; x=1785585127; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=jUicF8+0PQzjkNPpqUYxV6sqKjt7zQAlA9KYujX4b2M=;
 b=l9mj8FWmtU9C+gvOmIXEAEGPVwCrddDb7ys7hG409WgJfjbFwiiPpe6v4aOcFKxoL7
 HlOS+v5D4iePRAkULu9MxYE1BUnvfUcx4z6tqksol8jRqbC4hlA6etK69SSL3gGJAJxl
 cARaOcxh9Rd22Ot+miIsCog9R2ai6xDldqHaU3RxXJ/fQoZj/3WsZrg9CK9FWJTQppD6
 M8L6cPyEIiXbg2Am+O7AT5GEsv8Fa/VSpwvOsdLghUbi41zGuaW2it3nJfpUDhp4rnFg
 2GJtYlcDIk7LLnGeikAObbZGm1I5XmYQtxpS9qbtiYGYFdvTawcXf9+Ve9fVJgSdSsDH
 nnpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784980327; x=1785585127;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=jUicF8+0PQzjkNPpqUYxV6sqKjt7zQAlA9KYujX4b2M=;
 b=SOlULMPfppy1HT7a1cyc2GHDS7vCzovybYjnMvDN/HrWvTEn7gBqxM2ryo5/LbeNdz
 JPDmjjoY9hEyZrjQyuXPHhJZROcny7uITjy73EUu9NgzqXYJQA4jRm3XaOiiVmSZiNjK
 dshCsr33+joGJm2p6AKmRSDXBIp3QvWNaBTXS/HW79+8foyTxPBae++qK96ESCrWSPBz
 guj6ibVMCBATnQofRGreZSgHXNezKJyBtbK2NoxZzLz0iMljdWHxd8IVGWVA8qxitZyP
 X6dvphiybw1LSCgb3JI0Kwgi7HzctIYOmCXfW1KvlF425zyPn0yja1g0ZPCTokaa1kIZ
 n1iw==
X-Forwarded-Encrypted: i=1;
 AHgh+RqxwFafbeDUNrN27fsd7wkhuGfDkjBV65L3hnYeltFtfjdOKDxRCwZfzdxtxaMYSz8ECtK3hQpzePt6@nongnu.org
X-Gm-Message-State: AOJu0YypbX9QslmPESV7dCMQ7k4ZSvBByw9O8Hvf6FXL1UianFW4DdmC
 Zg5/8ea9l327EmLRN18I0LaxDFH5sWH4PdAPTfPKoefUV5Ee4MwHou3KEzIRbi77ld1YWKqeN5i
 XQqtUfWYUw3mOJ5PRr064OEJSyS4sl7CGuAYJjizzU5TY6d9hOoxx/NrL
X-Gm-Gg: AR+sD11ic9uo/x99xn6alsmYo8LdfueQqBFqmclflzUzH4sfKtRXrznmlRsHw+oeOLo
 AkDeA7V9YIpnpwg8mF9gsLQewKS61jgejgAPZEQFPBE9S+6D4eDkwIWPHi3uopTGY/EbulJ2p/g
 qLvl3Mj4i7Ld0o6SVkOPKPdbr5ss2NQz26R2K8MrOetxPuKyCiO9YiRY8NkWIPF9zmDXzpNxxGM
 6grNaFABJ2GmDq6wqIHR4JEgt2EZ5KU98LOicW3b4SR36hvAHMzETAGU47mGeFRszco0Gl9X+1Y
 LEcqAGhMHQXVk/AHVmd8IdOlQ2L5MQnhgxJTd4Ma9TMG4vSC5KaR14ldd4YWd0benL5dGWOe4G+
 fQy1LJ6+XiKhXvszh4cMcb2PnDa2nqBM=
X-Received: by 2002:a05:600c:b4e:b0:495:641a:fffe with SMTP id
 5b1f17b1804b1-496b573a1a8mr16566775e9.39.1784980326846; 
 Sat, 25 Jul 2026 04:52:06 -0700 (PDT)
X-Received: by 2002:a05:600c:b4e:b0:495:641a:fffe with SMTP id
 5b1f17b1804b1-496b573a1a8mr16566545e9.39.1784980326321; 
 Sat, 25 Jul 2026 04:52:06 -0700 (PDT)
Received: from redhat.com (bzq-79-177-145-168.red.bezeqint.net.
 [79.177.145.168]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-496b4f33b73sm60840475e9.14.2026.07.25.04.52.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2026 04:52:05 -0700 (PDT)
Date: Sat, 25 Jul 2026 07:52:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Cc: Michael Tokarev <mjt@tls.msk.ru>, qemu-devel@nongnu.org,
 Gerd Hoffmann <kraxel@redhat.com>,
 Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-stable@nongnu.org
Subject: Re: [PATCH v3 0/2] More virtio-snd fortifications/coverity fixes
Message-ID: <20260725074851-mutt-send-email-mst@kernel.org>
References: <20260420-virtio-fixups-v3-0-07aef1eff9d2@linaro.org>
 <99126226-5f73-4853-869f-0fcdc30c13a4@tls.msk.ru>
 <CAAjaMXagdexkBXM8acCq7d+N51BG1qLGs-J7Ctz+ZFe2zzSOFg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAAjaMXagdexkBXM8acCq7d+N51BG1qLGs-J7Ctz+ZFe2zzSOFg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -34
X-Spam_score: -3.5
X-Spam_bar: ---
X-Spam_report: (-3.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.419,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Wed, Jul 08, 2026 at 03:01:19PM +0300, Manos Pitsidianakis wrote:
> On Wed, Jul 8, 2026 at 12:09 PM Michael Tokarev <mjt@tls.msk.ru> wrote:
> >
> > On 20.04.2026 08:07, Manos Pitsidianakis wrote:
> > > Added checks for stuff coverity pointed out (CID 1547527).
> > >
> > > Signed-off-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
> > > ---
> > > Changes in v3:
> > > - Added Coverity CID in patch message (thanks Alex)
> > > - Link to v2: https://lore.kernel.org/qemu-devel/20260417-virtio-fixups-v2-0-4a0d8636a628@linaro.org
> > >
> > > Changes in v2:
> > > - Use g_size_checked_add (thanks rth)
> > > - Link to v1: https://lore.kernel.org/qemu-devel/20260416-virtio-fixups-v1-0-ec14e2de0852@linaro.org
> >
> > Hi!
> >
> > It looks like this patchset has been lost somehow.  Is it still needed?
> >
> > /mjt
> 
> Patch 2 is still unreviewed it seems. I might send a new series with
> more patches soon. Thanks for the reminder!

I think a bigger problem is that we allocate as much as guest wants
in the 1st place. Want to look into this?


> >
> > > ---
> > > Manos Pitsidianakis (2):
> > >        virtio-snd: check rx buffer descriptor size
> > >        virtio-snd: check for overflow before g_malloc0
> > >
> > >   hw/audio/virtio-snd.c | 24 +++++++++++++++++-------
> > >   1 file changed, 17 insertions(+), 7 deletions(-)
> > > ---
> > > base-commit: da6c4fe60fee30dd77267764d55b38af9cb89d4b
> > > change-id: 20260415-virtio-fixups-3bc3a1a1cd27
> > >
> > > --
> > > γαῖα πυρί μιχθήτω
> > >
> > >
> >
> 
> -- 
> Manos Pitsidianakis
> Emulation and Virtualization Engineer at Linaro Ltd


