Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CA628CCD184
	for <qemu-devel@archiver.kernel.org>; Tue, 21 Oct 2025 12:56:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBBu2-0005XU-Cl; Tue, 21 Oct 2025 08:55:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vBBty-0005X4-PO
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:55:46 -0400
Received: from smtp-relay-internal-1.canonical.com ([185.125.188.123])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <wesley.hershberger@canonical.com>)
 id 1vBBtu-0008Iw-1h
 for qemu-devel@nongnu.org; Tue, 21 Oct 2025 08:55:44 -0400
Received: from mail-yw1-f200.google.com (mail-yw1-f200.google.com
 [209.85.128.200])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id D1FDF3F66F
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 12:55:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
 s=20251003; t=1761051333;
 bh=teQ7noeix4gMctnSWDVFaMK0VGY4Pt2D3JojboZwfnI=;
 h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
 To:Cc:Content-Type;
 b=CzulezxKyUeQ4TJ34Lo+kP74+2Kw246XCtFwtL/l7ZbSUUrM2dqnYcwrJU8tzfSBK
 cgVE26+1Pqk7vvRxqA3ao1k9xImLU4rqcDaSCpt/c+UNzEJwEa6mrOX99V4VBk7XY6
 THlZZwSeQPrBAFrtB4FZqUxxHaYQ6qmmaonwimaAAMZpBB/A0h2NB02Cawg535jI/6
 BY65/H2Ys9KBmzEtfTnhw7kG/f2NoQBl9G2IK11rtNiB2KGm4KO0CCG/IbE1NSknPU
 +H9P9N7FroadAQvycrReqQooGKz552vI6ETRiP0gsuRuI8SN/IsfkPYGlbpuimn4R2
 ucuxpztXjbz3daMjkZcw8297kcyfttZHS+3NUwOirBi5n6ujUKPk2Y1G26u28GcH2l
 6r/1vV/NLZYG5Cl/wdkRI0GkRF4nPVYSb7lwir7HY4k8QQYzN7DDP6224VrK3sq0Ra
 dm/+WZRZZTAU/Xp6V+q6RpYw61vp/3QePOcNct7SSnRm8nmN9PFCeDjmXiR7fNbyB5
 WrxfUgUnLbLl9mhh9kTL7SKylRyDqk7JQO/4gzJV2qQazljGqO38ghN5j1rMcP5iX0
 ygMprN7QEkNAyVPOz76dxgwEgC6umrTQvn0fUXSWepeSGuT+Avqd7J/grlKnDHD/Ey
 MkgFAehpQvoo57yZJZjLGnmI=
Received: by mail-yw1-f200.google.com with SMTP id
 00721157ae682-7848b193cc5so41967657b3.0
 for <qemu-devel@nongnu.org>; Tue, 21 Oct 2025 05:55:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761051327; x=1761656127;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=teQ7noeix4gMctnSWDVFaMK0VGY4Pt2D3JojboZwfnI=;
 b=w6E2zBsISWr7BH8csWG8TwrlXWffj7LMPx4N2JEDHuwCpZugjxHBsvfho4v2I6xw0W
 RGnwAUXxc+amFOmNEcMTvJAqs6ENe/yb0xuRQtfRc0/w9pTIEaJMwm+WlPeDSqO3NfOZ
 cDiA0fGMhKYE+JXTUTeOvMuKi3uIcpebaXX+5XSglgIOdjWIPGPmQOo26cJ5EQCRv29Q
 gCHmzNkPH2lowsz67FhDw8uNiSLuZ25sTXMwYy8TzOSlrUhigBmFcRJo6UyAoapVbn6U
 mGS0boS+j5FpldPbb8qsMg5f3sEWQUHwBbW6vHvvk3l1oU1MNqomJ9pFGv+rDwsH+FSJ
 71fg==
X-Gm-Message-State: AOJu0YxOQBeXN+KkVAIfZMNBq5NimlG97Ptvw9Ah6ra2vSjYz823FU6O
 Ylw446h4kZiJWZBz5WuhLQr4wfG5awcA+skr4kcdv6UAwfU5TdGmlOnSi6L1+VIQ6y9pj31z4XN
 4RQKBYsvNvn9wcxHkD2hrF9QJ1tdgsCCMNmGem6LU1DiLmEPJyO7wPbdCxGaUFMdhlOz4hBNj/+
 Aepnv1TFl4xMSFw/l5QJMRf1NqFOK495N35FrLQv9AftCuO1o=
X-Gm-Gg: ASbGncvX/+r5bTORJZnPjJwzdeUdQBvVHVzD2sjaxNXwVBDMeg2kHf4AHupHhxaFIVp
 l3YLifETfqAaZoYBomlaZP1gOcmxDnlfiqe1k7IC2owosyNb4AQOUeTp2K+680t/adUq2xiFGij
 rnDf0/7Pzgq+A7uIM583eG6EUa8yFbnCpjnTo2flaecSJ0P07LBrNyBixMATf0EFDvonJYe4UDY
 eD+qd0PSJuYVVw=
X-Received: by 2002:a05:690e:d56:b0:63c:f5a6:f2d3 with SMTP id
 956f58d0204a3-63e1624b72fmr11727869d50.34.1761051327346; 
 Tue, 21 Oct 2025 05:55:27 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEF/4UBnLMTnib4kkUWMEceV7R2YgIgdSHwRMevodP7zwh78sWb+Vl3tgXQ/vgOTCmsVEZzIoiBRfp0YO+YvSE=
X-Received: by 2002:a05:690e:d56:b0:63c:f5a6:f2d3 with SMTP id
 956f58d0204a3-63e1624b72fmr11727856d50.34.1761051327040; Tue, 21 Oct 2025
 05:55:27 -0700 (PDT)
MIME-Version: 1.0
References: <20251020-fix-3149-v1-1-04b2d4db5179@canonical.com>
 <edbc31b7-545b-416b-a5c1-eee3276ac9d8@yandex-team.ru>
In-Reply-To: <edbc31b7-545b-416b-a5c1-eee3276ac9d8@yandex-team.ru>
From: Wesley Hershberger <wesley.hershberger@canonical.com>
Date: Tue, 21 Oct 2025 07:55:15 -0500
X-Gm-Features: AS18NWCqBDAHMO4AXplXODcLnUsF6HOAYITOBZXQWwEO0YRBG0ftwrWr3Nspcy8
Message-ID: <CADzzt1CAxiFpVoXiH9=K7SJ1YTN3zRA2K=YxTgkibibRGuOcWA@mail.gmail.com>
Subject: Re: [PATCH] stream: Remove bdrv from job in .clean()
To: Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>
Cc: qemu-devel@nongnu.org, John Snow <jsnow@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=185.125.188.123;
 envelope-from=wesley.hershberger@canonical.com;
 helo=smtp-relay-internal-1.canonical.com
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_MED=-2.3, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
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

On Tue, Oct 21, 2025 at 1:05=E2=80=AFAM Vladimir Sementsov-Ogievskiy
<vsementsov@yandex-team.ru> wrote:
>
> > This can cause races with qmp query-named-block nodes as described in
> >   #3149.
>
> Hmm. But why it lead to segfault? Ok, children kept in global_bdrv_states=
.
> and referenced by the job itself (as I can assume from the patch). What's
> wrong with the state, so we went in segfault?

My understanding is that when bdrv_replace_node_common is called with
`detach_subchain=3Dtrue` then `children` is cleared. Here's a trace from
stream_clean (line numbers approximate on v10.1.0):

 - stream_clean (block/stream.c L131)
 - bdrv_cor_filter_drop (block/copy-on-read.c L274)
 - bdrv_drop_filter (block.c L5466)
 - bdrv_replace_node_common (block.c L5404)
    (called with `detach_subchain=3Dtrue`)
 - bdrv_remove_child (block.c L5335)
 - bdrv_replace_child_tran (block.c L2489)
 - bdrv_replace_child_noperm (block.c L2944)
 - bdrv_child_cb_detach (BdrvChildClass.detach) (block.c L1492)

I can observe that children.lh_first =3D=3D NULL in gdb.

> Also, would be good to write the segfault backtrace here, for someone
> to search the fix through git.

I'll include the backtrace from #3149 in the commit message of my next
submission.

Thanks so much for the review!
~Wesley

