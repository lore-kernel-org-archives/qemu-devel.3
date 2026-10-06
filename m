Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 565BACA5FF1
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 08:56:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xEN9C-0007YN-Ft; Wed, 07 Oct 2026 04:37:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xEI50-0001HH-Dj
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:37 -0400
Received: from mail-ej1-x633.google.com ([2a00:1450:4864:20::633])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <bogorodskiy@gmail.com>)
 id 1xEI4h-0000ve-Ra
 for qemu-devel@nongnu.org; Tue, 06 Oct 2026 23:12:26 -0400
Received: by mail-ej1-x633.google.com with SMTP id
 a640c23a62f3a-c2055573c8cso169021266b.3
 for <qemu-devel@nongnu.org>; Tue, 06 Oct 2026 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791342691; x=1791947491; darn=nongnu.org;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=v4kJEYeqON+RYqdz3owyGseUuZPU/HDl6yEF6gzPBTg=;
 b=GAAyR9HG5KVZsmWYqTCOrGh1/h/sKLdSIEbuqAzXG0X5ntjkC0y0GO0W0B8RMrqSEw
 Yl3/8LxPsq4Q2WIpm5sptXklHi8TFL1r2bqx6QecWMs+BVhz5CG+JDHY/1DN4mVXr75O
 M9Z1N1wlyoecfLsShQ22Iam//LM5W2zBSkMxyjI8xXRxLwBllJUPg5ecWwlv5bTQpoZC
 Wc1ZYIf+/BSYVguaFovq/L7fStpldutNxVKcyRm9hUJms2Pl4WE3FDuYq8QkHwzAnky2
 DNxOfjLp8Th/NxvTzmpVc4K4lHUvbSaKQ7XqJANJWieG2j2ma6Qdkxq/CxnsU5WP9X1C
 6m0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791342691; x=1791947491;
 h=user-agent:in-reply-to:content-transfer-encoding
 :content-disposition:content-type:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=v4kJEYeqON+RYqdz3owyGseUuZPU/HDl6yEF6gzPBTg=;
 b=AMUIE53IP7fQRZzqV6IbYJhHrb1i3SpxkzvgkE4CIj23+PZyo3KCzQRKy7gdUydOsm
 QIVGAcf6QLhc7sdMlOn7CIabPSrCYuEAFh3c1YCeApuYy8QMBNbrAQRHvh3uoSEExbUr
 2Rp3ee8u06zguP1wI1fkpQSMOHEXUObg9USLHbcfrRqsYmc/PEhHHTHxvC52mSwIw8EL
 ZvWiKVQWaSJ426IDT+z9mo1fiIDthsMo1A0e0tDyGg14friKfpJqRme1kyInzTL44Ff3
 tgv8wNoKZOVSsCjoVLWjOz9x3ix5p2x9MTkASY03NN12G6aoqBPVdPOUaYAjafkdQr59
 8iig==
X-Gm-Message-State: AFuF++ntnFrujADMM1IZUDcH7VHLJXqYDJ4QT9nxIQkZGsX3F9Zc/f/i
 9A+5BaRLIVoYRnMkHBj8Iba+RnYeaudh0tu4g5zV0JTPFKXVcvBX+xE8zvpoAYoNEas=
X-Gm-Gg: AYBFou3ETKu84bfoIIdMUosxWhX/i1L8s8JnKBoJMFQ60J6v7zdoWTWzD2xOPeXGNN1
 gVzeFdxNkjo2yH5xTSAno16tyD2N2n9bhHXBgeb8rhn/82YksppZqMcdnJKAKgyDk0RJnwmMJW0
 GIXd1ASAcjQ72t0bYh82Mdp3hS7PUNu9UkerMjRXxa3jLiRgLeBMUSwjJ8+hF0ThqZOVYlPl0XY
 W1FHoXw/oUmX0CuREJsfwBNJ6Jo8uGkk21hEZffaGS54/3MGnEqmmHXqym6RV0JjexQJ9U+FZ8a
 wGjhmLevLHEuRGKiggpLHcf83p7h04zD4DJQyabe9mcoykWoXSM+llAQQ1WWvdhwLNysD1ewZh8
 WYE5kQQ+UTHjjZpQr0lrTwgJ9zrwFtJp0F78TxVYIYm1N6QE09TgdW6NXS1n3bkCPc/OYR7iQvW
 uQ4scdR8T923WNG/F/beEOqa0/M7GBJWOSu2qOrG/3LgIpC+o+1DV3lqjsnMLy8PaytgrjwIXSa
 Py39tZ2l7xC+da/hdyH+Wsp7sl3XK7n+pbw82t7alttAuXFDxah1en7UOIT2JuPnNHTYZgc
X-Received: by 2002:a17:907:841:b0:c26:1649:47ad with SMTP id
 a640c23a62f3a-c316a026be8mr150283466b.35.1791290823276; 
 Tue, 06 Oct 2026 05:47:03 -0700 (PDT)
Received: from tulp
 (2001-1c02-1a15-3000-2727-f7d1-9628-aa81.cable.dynamic.v6.ziggo.nl.
 [2001:1c02:1a15:3000:2727:f7d1:9628:aa81])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c3172740353sm10579366b.15.2026.10.06.05.47.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Oct 2026 05:47:02 -0700 (PDT)
Date: Tue, 6 Oct 2026 14:46:57 +0200
From: Roman Bogorodskiy <bogorodskiy@gmail.com>
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Eric Blake <eblake@redhat.com>
Subject: Re: [PATCH v2] qga: implement 'guest-get-diskstats' for FreeBSD
Message-ID: <asTtwbtDI3XrhNAz@tulp>
References: <20260901192732.46190-1-bogorodskiy@gmail.com>
 <CAPMcbCp+-tGCWnuSRwi2745r=v8cdtTc0CqVCBg7y08UpAYTAg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPMcbCp+-tGCWnuSRwi2745r=v8cdtTc0CqVCBg7y08UpAYTAg@mail.gmail.com>
User-Agent: Mutt/2.4.1 (2026-07-04)
Received-SPF: pass client-ip=2a00:1450:4864:20::633;
 envelope-from=bogorodskiy@gmail.com; helo=mail-ej1-x633.google.com
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

  Kostiantyn Kostiuk wrote:

> Reviewed-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
> 
> On Tue, Sep 1, 2026 at 10:29 PM Roman Bogorodskiy <bogorodskiy@gmail.com>
> wrote:
> 
> > Implement the 'guest-get-diskstats' for FreeBSD.
> > This implementation uses the devstat(3) library which is a part
> > of the FreeBSD base system.
> >
> > The build system is updated to link qga with `-ldevstat`.
> >
> > Signed-off-by: Roman Bogorodskiy <bogorodskiy@gmail.com>
> > Acked-by: Markus Armbruster <armbru@redhat.com> (QAPI schema)
> > ---
> > Changes since v1:
> >  - Replace the guest_diskstats_append() helper with a simpler
> > guest_diskstats_info_new().
> >  - Drop the unnecessary condition for ios_pgr.
> >  - Drop the unnecessary guest_get_diskstats() wrapper.
> >  - Jump to error on devstat_getdevs() as it does allocations.
> >
> >  qga/commands-bsd.c   | 120 +++++++++++++++++++++++++++++++++++++++++++
> >  qga/meson.build      |   3 ++
> >  qga/qapi-schema.json |   6 +--
> >  3 files changed, 126 insertions(+), 3 deletions(-)

Hi,

Is there anything else needed from my side before this can be merged?

Thanks,
Roman

