Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 833B6C531D2
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Jul 2026 14:05:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wmu36-0006pZ-GG; Thu, 23 Jul 2026 10:05:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmu34-0006ou-W5
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:05:19 -0400
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <stefanha@gmail.com>)
 id 1wmu33-0004Vm-Ar
 for qemu-devel@nongnu.org; Thu, 23 Jul 2026 10:05:18 -0400
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-698a9f11776so1106062a12.1
 for <qemu-devel@nongnu.org>; Thu, 23 Jul 2026 07:05:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1784815515; cv=none;
 d=google.com; s=arc-20260327;
 b=XkN74Ui/wBTXgbbqgAndK3tLr76FEKo/tU0zKX7NWU0ZXfuhpmc/XOxcdur3EXNNWc
 9F6pqv/EjhU/KqSUF+eL8LzeKA/GL9o5H4xHe9M4y8Rc6PcT4hL8P8cqSvgWqlYj6CLA
 Vve1r8LMo6mcRuiQg+nor+BHEiFDvPiA2y13NaJmVMil7g15yoV3CVaYJh4syVCgPO2w
 pcaEgCEYnWk0JTB+xn19DGyAF3mdq0l79sb2dyaJIzPSsP+yqI1uCMYeKPcH3nkAqNdr
 f+BaB0SfN7u6AruuKwricLw7rE9KC1Vwn4vUP41MhTbcFQ4X4wc6ex5z7F9oWM+GB7Hw
 n2xg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=OUphSWHet/c3ZXY8L2Y7HqAPVcKZBRTEEAOedJ/IGZ0=;
 fh=sBJ8lI44AzxsJbmCedclDsDPoBNgPBZ2cFpF6InV9g8=;
 b=OiaVKmPDHQ0ptIeDVZP7F8Rq4Dm6NYnc6s5wicKBAyGn8tLKF8DLh/ozzRSoVKPsa7
 UAugf5NgWS6bJa851LsnlM+dtdiDiv7c/Yn16Gc0m5OSdjKgKu0lckp3o4AmWi5HLS3A
 KGYsAffafJcgFnAsEsH1azXuJ8vMTUwk0Nr+bRP8gwkn4ZYm6H9IGp4FL8/eJDff8jwb
 vCrHH9goNusQb/3zGCRucHzWqRP1pM/eJ8vWX2UE49NsLn0bTuJLZlSXrpOvKxaFqqKR
 4pgv11emjoNsUdeRqNbERC/QxpU+scK9KO8MN6NzfJTpxizRAFunxFrGByHmlp2j6kg3
 Ch8Q==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1784815515; x=1785420315; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=OUphSWHet/c3ZXY8L2Y7HqAPVcKZBRTEEAOedJ/IGZ0=;
 b=Nkuh2SI7s3GhkgDMU5AxnnVtFv9zmYyOETjGck0npiEB8IL+uhBNH05RVQNOt5fmb1
 U8DZyz/tk1YDjILXfz7DwjNLUTohVc4So63+/xRBdMfr2NmugkSa0uQvvh+y4AUzJwdz
 dahB5wQxv1w6EkASjnu72T1PFLb6t1vLLnz8SWqTJIxFriICEDiXppDT/DVmCJnIDTUf
 5h1BB65ZM1NGfS9xMkvEm+eDJYKitBABgLLHoJ2u8dGpnmyiBI1jmpcjoHbT9MdRIiB0
 aU92aH6ldxO9dFa7q5sKn+wV9N1QZgXjQ9rP5RT0EgHfsVljZTjnW7N/XhN2zUxrp8KK
 DhLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1784815515; x=1785420315;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=OUphSWHet/c3ZXY8L2Y7HqAPVcKZBRTEEAOedJ/IGZ0=;
 b=mgiL6FsK4N7rdWzZuvnaNi8J2J2kx34FPV93TIMzwKg+Q8w5Z9En9x56GH+jJ4xQyr
 rdJApzO+bD+XDM0xgEkIQfjiyJRK+rRgujCFureL3X8D7SEWGWj5hao2FOGDmWhA264Q
 9T8JIRk+R3gIPVdrsSbSNEIkQ0lWbh7hWkfrX3JMHCzULWVz7KK/J27HlDCI0b0t5L0w
 hnCNBo3BxxTWe5iZ7uv0j3nkgs165lZsFA01kst2BLzE1tNXZpM7G3uvbgYIstHhJb7r
 xOb5OXgXZz7WRn7tdq5snFeaet0pqsir/nUnuL9XxMia457BxKEDdlIGMxjsBkSVKUOy
 xiYQ==
X-Gm-Message-State: AOJu0YzWI1zeXqRX30nVDn8dVvGTUualbcJbWNH22k8mhvEFzW5AQ7ky
 b1tBPvCvoYyVYxYPjK5JILqcUqUF47gXoJS3W1GAP76r5eT/WdF57khOxvYkuTm7O0CEWxkFxuy
 xXlLZAs4nHlOq0RGepY7Thhb6vac50Jg=
X-Gm-Gg: AR+sD106HHrQJmGtO3EznWHY6X6nIq/ZofNy7yXE9Fjd1uEdzRO9Pff1sKIHd4GlhN2
 VSn/z2iWBovFkrWANTig6XFAuajA849aN3vJ/CimmMar75Zw95zJXEJvdDBrJverL0GEzi3aYRi
 hQynOz51hxn5p6z8xPyfNb/xeHcGu0piZyVb+p/UmAuZOFOFD3ONj/Z6BMyvmsKzU2AxkoPKrGd
 vuLXJlS6qqmiQp70kbJpIhZOxYpD3de5eAiOPlcV2wuZmrHUkqduSx//uZQRtZBlHg1hJr6c9H+
 brA43INzyZZpSvk6+n8b
X-Received: by 2002:a05:6402:325b:b0:698:de64:6aa1 with SMTP id
 4fb4d7f45d1cf-69f6cf10401mr1042807a12.10.1784815514902; Thu, 23 Jul 2026
 07:05:14 -0700 (PDT)
MIME-Version: 1.0
References: <20260722200951.553764-2-connorkite@gmail.com>
In-Reply-To: <20260722200951.553764-2-connorkite@gmail.com>
From: Stefan Hajnoczi <stefanha@gmail.com>
Date: Thu, 23 Jul 2026 10:05:02 -0400
X-Gm-Features: AUfX_mwo_j2sGrVt_Duj6KS03-cN8p8vvB6Q46TO7ZGnOziJsw5ck4gZRpZIWLc
Message-ID: <CAJSP0QWQwxCYL+xCOZNoNUSEXHdekSkEvGmcyThkVk3Od0=a5w@mail.gmail.com>
Subject: Re: [PATCH] util/iova-tree: gapless map
To: Connor Kite <connorkite@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, stefanha@redhat.com
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

On Wed, Jul 22, 2026 at 4:11=E2=80=AFPM Connor Kite <connorkite@gmail.com> =
wrote:
>
> iova-tree prevents mapping of overlapping ranges, but range checks
> inflate the effective size of regions by 1 byte, resulting in gaps
> between regions in the iova address space.  If there are alignment
> requirements for regions in the iova space, this can throw them off.
>
> Adjust range checks to allow adjacent regions with no gap between them.
>
> Signed-off-by: Connor Kite <connorkite@gmail.com>
> ---
>  util/iova-tree.c | 26 +++++++++++++-------------
>  1 file changed, 13 insertions(+), 13 deletions(-)

I think iova-tree is fine as-is and the root cause is
vhost_svq_translate_addr() treating size as an open interval rather
than a closed interval.

The "qemu/iova-tree.h" DMAMap struct documents the size field as
"Inclusive" (i.e. closed interval where the size only goes up to the
last byte included in the interval) and the code touched in this patch
was written with that in mind.

Looking at other iova-tree users in the source tree, they all use size
- 1 (closed interval), which is consistent with the iova-tree API.

If you fix vhost_svq_translate_addr() to use a closed interval, then
no changes to iova-tree are necessary. I think this approach is
preferrable since this patch otherwise breaks the other iova-tree
users (vhost-vdpa, intel_iommu, amd_iommu).

By the way, I suspect the fundamental reason to use a closed interval
is that the entire address space can be covered (e.g. HWADDR_MAX)
using hwaddr or uint64_t. The open interval representation requires a
larger type or a special case (e.g. treating ~0 differently) to cover
the entire address space.

Stefan

