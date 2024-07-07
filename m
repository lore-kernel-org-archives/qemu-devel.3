Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E590AC30653
	for <qemu-devel@archiver.kernel.org>; Sun,  7 Jul 2024 08:47:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sQNXD-0007LM-O6; Sun, 07 Jul 2024 04:46:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQNX5-0007Jy-LO
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 04:46:07 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1sQNX0-0002db-4v
 for qemu-devel@nongnu.org; Sun, 07 Jul 2024 04:46:07 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-a77b60cafecso315663766b.1
 for <qemu-devel@nongnu.org>; Sun, 07 Jul 2024 01:46:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1720341959; x=1720946759; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=fEYHd1sh+EjPz8zS4wuHhYUp/x5fvS6WFSYzRfKIK4Y=;
 b=ugEGRtD0PPaB+1i2hUc14IILsPSi5pi+KdNuLrA5i1uyFvv2nT2E5bdsIXWdhieHHl
 JPBHgNzRWcFQPSCWOO62LbmTZRXG+GM2H/OxqD6qHm6N9eanbZBHwi0Vs36KFo6tz86A
 jmxmnyMZByhaEhBlRPDGklLJ5wRjoxMInLBk3qYWaqoPcO50V9vVQPO6xiUYYg66YBYa
 Zp/fwaIk8hIqUPj0dcqrakatUjlIaBO/wQbe6bjvKp3ZP/9as/mHXbc7r1OvZUGoe19i
 2c0sh/S1et0YHplUtsirmcqyJVHjOAY+RbqCqVJC53sCF007cWTgclqOCoFc9umvpNJR
 VcUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1720341959; x=1720946759;
 h=content-transfer-encoding:mime-version:message-id:date:references
 :in-reply-to:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fEYHd1sh+EjPz8zS4wuHhYUp/x5fvS6WFSYzRfKIK4Y=;
 b=kTD6w5fOnJoxJbBwETBJXkBFbVYSck5B468kF+fXubgSlBqajGUXfsXdaSioqEw0gl
 j8ZioQeDrV6e1rNF+2XwNIM3uNl/2C09b0YEDDAnUW7MaZO+IaT4sp6SDNvAhkBXRS/D
 zSCXvoWqKTAw7yxvHiQNRGQRgX7xyUgRMUYpSlwPt0GLBVRctREKvFZi9TgW24y0XXuZ
 +WGuSw5ziB0jHZNV9lCVJrRC2uQpT54+rwg8bLC7HFT5aMyiDCgf/zDt/uUCLLY94cRZ
 hhw1um0Kcf1c0VoNXqyQGsj+HVrrdpZF7VCZZAZcJPfs2upuFqjlHkKVg55PrAgIcr31
 +oWA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWA8ZbmQQ10cZeO7Pka2LtNtwngnd/1T/t44xwJ2TRlQDXmUDqQ1aG6v2bvVbuSLbl0Eh6ZV3/pKAW+MWH2SpIjS7iEslo=
X-Gm-Message-State: AOJu0Yzj5IJvWEl9vhlAOdyxJbIIRk8p0M9FAkjfEYqNaTH4Xo2qNT29
 1xXPzRepddA68EBxt7dfGqKNy0lvWhru9IzEyJD/5u555WkIpcb5qlDNr19voL8=
X-Google-Smtp-Source: AGHT+IEqTxgIjYAHeGxiTC62iXRay9Io+j73bhmKVTdLgG9WgBBopxUNhDuGb0w9phOZilXybXRtCA==
X-Received: by 2002:a17:906:ae47:b0:a72:6fc3:9946 with SMTP id
 a640c23a62f3a-a77ba4604d6mr535188166b.16.1720341958831; 
 Sun, 07 Jul 2024 01:45:58 -0700 (PDT)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a77df7949fasm139779566b.32.2024.07.07.01.45.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jul 2024 01:45:58 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 337BE5F8E9;
 Sun,  7 Jul 2024 09:45:57 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Edgar E. Iglesias" <edgar.iglesias@gmail.com>
Cc: "Edgar E. Iglesias" <edgar.iglesias@amd.com>,  Anthony PERARD
 <anthony.perard@vates.tech>,  qemu-devel@nongnu.org,
 sstabellini@kernel.org,  paul@xen.org,  xen-devel@lists.xenproject.org
Subject: Re: [PATCH v1 2/2] xen: mapcache: Fix unmapping of first entries in
 buckets
In-Reply-To: <CAJy5ezrfbAzwPWg_YABLy5NwCUiNa31FFR1nAZzy-WC3vXrMhg@mail.gmail.com>
 (Edgar E. Iglesias's message of "Sat, 6 Jul 2024 09:27:43 +0300")
References: <20240701224421.1432654-1-edgar.iglesias@gmail.com>
 <20240701224421.1432654-3-edgar.iglesias@gmail.com>
 <ZoawbAnukIBkYWCw@l14> <87wmm1m7i3.fsf@draig.linaro.org>
 <ZobuhcLHqUEy_bQs@toto>
 <CAJy5ezrfbAzwPWg_YABLy5NwCUiNa31FFR1nAZzy-WC3vXrMhg@mail.gmail.com>
Date: Sun, 07 Jul 2024 09:45:57 +0100
Message-ID: <87jzhxd1yy.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
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

"Edgar E. Iglesias" <edgar.iglesias@gmail.com> writes:

> On Thu, Jul 4, 2024 at 9:48=E2=80=AFPM Edgar E. Iglesias <edgar.iglesias@=
amd.com> wrote:
>
>  On Thu, Jul 04, 2024 at 05:44:52PM +0100, Alex Benn=C3=A9e wrote:
>  > Anthony PERARD <anthony.perard@vates.tech> writes:
>  >=20
>  > > On Tue, Jul 02, 2024 at 12:44:21AM +0200, Edgar E. Iglesias wrote:
>  > >> From: "Edgar E. Iglesias" <edgar.iglesias@amd.com>
>  > >>=20
>  > >> This fixes the clobbering of the entry->next pointer when
>  > >> unmapping the first entry in a bucket of a mapcache.
>  > >>=20
>  > >> Fixes: 123acd816d ("xen: mapcache: Unmap first entries in buckets")
>  > >> Reported-by: Anthony PERARD <anthony.perard@vates.tech>
>  > >> Signed-off-by: Edgar E. Iglesias <edgar.iglesias@amd.com>
>  > >> ---
>  > >>  hw/xen/xen-mapcache.c | 12 +++++++++++-
>  > >>  1 file changed, 11 insertions(+), 1 deletion(-)
>  > >>=20
>  > >> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
>  > >> index 5f23b0adbe..18ba7b1d8f 100644
>  > >> --- a/hw/xen/xen-mapcache.c
>  > >> +++ b/hw/xen/xen-mapcache.c
>  > >> @@ -597,7 +597,17 @@ static void xen_invalidate_map_cache_entry_unl=
ocked(MapCache *mc,
>  > >>          pentry->next =3D entry->next;
>  > >>          g_free(entry);
>  > >>      } else {
>  > >> -        memset(entry, 0, sizeof *entry);
>  > >> +        /*
>  > >> +         * Invalidate mapping but keep entry->next pointing to the=
 rest
>  > >> +         * of the list.
>  > >> +         *
>  > >> +         * Note that lock is already zero here, otherwise we don't=
 unmap.
>  > >> +         */
>  > >> +        entry->paddr_index =3D 0;
>  > >> +        entry->vaddr_base =3D NULL;
>  > >> +        entry->valid_mapping =3D NULL;
>  > >> +        entry->flags =3D 0;
>  > >> +        entry->size =3D 0;
>  > >
>  > > This kind of feels like mc->entry should be an array of pointer rath=
er
>  > > than an array of MapCacheEntry but that seems to work well enough and
>  > > not the first time entries are been cleared like that.
>  >=20
>  > The use of a hand rolled list is a bit of a concern considering QEMU a=
nd
>  > Glib both provide various abstractions used around the rest of the code
>  > base. The original patch that introduces the mapcache doesn't tell me
>  > much about access patterns for the cache, just that it is trying to
>  > solve memory exhaustion issues with lots of dynamic small mappings.
>  >=20
>  > Maybe a simpler structure is desirable?
>  >=20
>  > We also have an interval tree implementation ("qemu/interval-tree.h") =
if
>  > what we really want is a sorted tree of memory that can be iterated
>  > locklessly.
>  >=20
>
>  Yes, it would be interesting to benchmark other options.
>  I agree that we should at minimum reuse existing lists/hash tables.
>
>  We've also had some discussions around removing it partially or alltoget=
her but
>  there are some concerns around that. We're going to need something to
>  keep track of grants. For 32-bit hosts, it's a problem to exhaust virtual
>  address-space if mapping all of the guest (are folks still using 32-bit =
hosts?).
>  There may be other issues aswell.
>
>  Some benefits are that we'll remove some of the complexity and latency f=
or mapping
>  and unmapping stuff continously.
>
> One more thing I forgot to add is that IMO, these larger longer term
> changes should not block this tiny bugfix...

Agreed.

>
> Cheers,
> Edgar=20

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

