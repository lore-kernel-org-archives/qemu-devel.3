Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A34D4C5478C
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 17:08:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rg6N6-0004Ov-7C; Fri, 01 Mar 2024 12:08:32 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg6N2-0004IA-Nv
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:08:28 -0500
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1rg6N1-0002fc-3V
 for qemu-devel@nongnu.org; Fri, 01 Mar 2024 12:08:28 -0500
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-412ced8ef97so782235e9.3
 for <qemu-devel@nongnu.org>; Fri, 01 Mar 2024 09:08:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709312905; x=1709917705; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yIsxd3I49dEeoEihY92y12I5QN6KFVksMBQbYfAFd0k=;
 b=Bp6DkDEtxrPlRZutCpHhPysohDuXummihHJnF20fQw4NEMACsynojMEY5BuM8v6PeX
 ArbdLsGVdEUl2jFdfuB+gMJfHvBE1G4DlNWYeZLZ6PbIcYiK+aw3rzn9gcFpuzO7yx7S
 3vE4xY+7jBxhMVTG/Hy2HQwkzx6k9lnko7CRYCiKTZCXWoHO3r6O7AqQrGnFzpA06PV1
 7txmKPTz4ZWTnlB40c4gq29LcImgEJhAfxQP8OABJ8hrr5vV+z5PKs3BXENcXVG753br
 pvxEqLRwRptOMQbfevm0V5O2W791kWvFot0uhMMrAD1JH6kNbfUX3o0vpijUl4jpJGxP
 2R5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709312905; x=1709917705;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yIsxd3I49dEeoEihY92y12I5QN6KFVksMBQbYfAFd0k=;
 b=Nznx5OZOnGxu36+qaDWpYoLtduZThoNToX2s06BfI8zWsIagZuEzjnzU8APtg0CexC
 qz1rLbYEWbdKGjDdnv6suJam6NTkAlun6wrXWAhB0GYDE4NwuwRKDc2DTCTS2mFAvDlz
 dnv0yf1XbnYpjWM0HAA4YVA4Cj2ufSDS6TFLIu3xOxN4Hc8RQ7mUP28TWq01aFDBVsqC
 iK5FQT86fs1XCOMZemg+WRvT8VCODIiKjlR+kohjM7fL2bAXXSMkvAbi36ehnBJovrg1
 9dODWcW1NRfw3al6MLQg8oGg+7Ig3dMhq/CUZVjW3Wt7XOHzl5fF22VG077E+VSevxbV
 o/IQ==
X-Gm-Message-State: AOJu0Ywp+hm57DBwiJVNfNGJwlMntYGzKLIEZeTWxDvS7w7ncbAOjMBG
 6q5/NBzlb8sC8eIri8IL7LK4k80pop07nJoW+EVLCupaSGuz6oUvt50IrlK8UKE=
X-Google-Smtp-Source: AGHT+IF/04gw/RkqLIbw8xez/beiUpqog3Zmj88Frgy30DgiLIcrkJ88jnJeBOUjtNlvcLKherqjQg==
X-Received: by 2002:a05:600c:45cf:b0:412:ca55:10ec with SMTP id
 s15-20020a05600c45cf00b00412ca5510ecmr1148930wmo.19.1709312905208; 
 Fri, 01 Mar 2024 09:08:25 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 jn3-20020a05600c6b0300b004128e903b2csm8910607wmb.39.2024.03.01.09.08.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Mar 2024 09:08:24 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 9A47B5F7B4;
 Fri,  1 Mar 2024 17:08:24 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Vikram Garhwal <vikram.garhwal@amd.com>
Cc: <qemu-devel@nongnu.org>,  <sstabellini@kernel.org>,  <jgross@suse.com>,
 Anthony Perard <anthony.perard@citrix.com>,  Paul Durrant <paul@xen.org>,
 "open list:X86 Xen CPUs" <xen-devel@lists.xenproject.org>
Subject: Re: [QEMU][PATCH v3 4/7] xen: let xen_ram_addr_from_mapcache()
 return -1 in case of not found entry
In-Reply-To: <20240227223501.28475-5-vikram.garhwal@amd.com> (Vikram Garhwal's
 message of "Tue, 27 Feb 2024 14:34:58 -0800")
References: <20240227223501.28475-1-vikram.garhwal@amd.com>
 <20240227223501.28475-5-vikram.garhwal@amd.com>
User-Agent: mu4e 1.12.0; emacs 29.1
Date: Fri, 01 Mar 2024 17:08:24 +0000
Message-ID: <87o7bx5187.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=alex.bennee@linaro.org; helo=mail-wm1-x330.google.com
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

Vikram Garhwal <vikram.garhwal@amd.com> writes:

> From: Juergen Gross <jgross@suse.com>
>
> Today xen_ram_addr_from_mapcache() will either abort() or return 0 in
> case it can't find a matching entry for a pointer value. Both cases
> are bad, so change that to return an invalid address instead.
>
> Signed-off-by: Juergen Gross <jgross@suse.com>
> Reviewed-by: Stefano Stabellini <sstabellini@kernel.org>
> ---
>  hw/xen/xen-mapcache.c | 11 +++--------
>  1 file changed, 3 insertions(+), 8 deletions(-)
>
> diff --git a/hw/xen/xen-mapcache.c b/hw/xen/xen-mapcache.c
> index dfc412d138..179b7e95b2 100644
> --- a/hw/xen/xen-mapcache.c
> +++ b/hw/xen/xen-mapcache.c
> @@ -396,13 +396,8 @@ ram_addr_t xen_ram_addr_from_mapcache(void *ptr)
>          }
>      }
>      if (!found) {
> -        trace_xen_ram_addr_from_mapcache_not_found(ptr);
> -        QTAILQ_FOREACH(reventry, &mapcache->locked_entries, next) {
> -            trace_xen_ram_addr_from_mapcache_found(reventry->paddr_index,
> -                                                   reventry->vaddr_req);
> -        }

If these tracepoints aren't useful they need removing from trace-events.
However I suspect it would be better to keep them in as they are fairly
cheap.

Otherwise:

Reviewed-by: Alex Benn=C3=A9e <alex.bennee@linaro.org>

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

