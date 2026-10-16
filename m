Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB5FCC6B38
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Oct 2026 15:56:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xHkHN-0006S4-2k; Fri, 16 Oct 2026 11:55:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkHH-0006Rn-Nh
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:55:27 -0400
Received: from mail-yw1-x1130.google.com ([2607:f8b0:4864:20::1130])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xHkHG-0008Nw-72
 for qemu-devel@nongnu.org; Fri, 16 Oct 2026 11:55:27 -0400
Received: by mail-yw1-x1130.google.com with SMTP id
 00721157ae682-8b06c0794cfso944547b3.0
 for <qemu-devel@nongnu.org>; Fri, 16 Oct 2026 08:55:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1792166124; cv=none;
 d=google.com; s=arc-20260327;
 b=IymRc0zvrqr3qir+AYkAddTfGz9kFr0dAhFv8tBSrVQSoV2sA5rqJThtApyPcxPEus
 q2v34l1L7uWcdI5hJ1+onVkEpLilA81qHnqIE0tv6p1recno1LwfrMVUmdXcJq0Yx4XX
 fB+FZ5rOWp+i1J73azLRN5KnrWepNyAuhIJOhW6ehdo9sulTK1yO12o7ezgjLEOPFLJl
 UHjGOslUYY9zAtru35OhHPZ7WT+FX79m6Hse8XlJ6EkcOqqvroDs7/fz2OOiFC6LCSys
 U/nfPUd5zfcE26pUVD4kXpkoOYrLy/KSMDDtwJcLLuUTgNQPsi7XGcopr1XTAtpNbapr
 kPtg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=Z0U9nhI3/BkU5LUuDW+0BzjA0KXxkCMgNCafRerAKsY=;
 fh=Q6TFFMwBkM8R1iob7068Yy7sNUf/28I6iaMc+yNinl8=;
 b=IwdRSqGg1qLswow3iXKaOQ00MZ+zleswdFqzhZr+SWHl3r4nBIhnmqcQytXlWr6wPp
 UcRmZGG4h2WfSZh7l5+vDF6ZvmjE/crQdPd7o1Ja1dDh/G2dSGNvwtlpPytmkJjo0woD
 vQ1tyIBkRRHaWQqIsxrIkuJk1s9blSk2Ar/A4WQuGm89uzzyWiBYDGITOXyBUwUrN+jc
 fhi55hHQ7nfZZKd7xYxNJWjk4WL65J2N9110sMO9a9Xt5p6z5OKLldJO3iDMaUBSKhkf
 batSpsqHtxB2Pu/IJEGnJoG7Pq462DZcsOG9igPyWFISmWUMPvJV86gJfWglTRIdKKWi
 H5Kg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1792166124; x=1792770924; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Z0U9nhI3/BkU5LUuDW+0BzjA0KXxkCMgNCafRerAKsY=;
 b=BEu1tlQEZBCg2GLEykBvU6I/FVtQXJYLQpiLFEMp2UFfWKN7XxWLdvUsG/WEcctv88
 w9NvkJFSWxxTmJmBk+jtoD0uI2l5awfG2zj7gZxzwdOkZ9mBZTgz2SbpoQ2If4F1slBf
 27CVaS8Jds9RsQRUPSl+Qj7F7llSokzW/WmZf90gYwqfaJU8vVlzD5c5xYaECYe1vbj9
 bbs1ocM/zA3wG1XjYTZp0P9PAmjaBPK1evG0ruCoZMa6mu1rbpFGFkRzLu16o+ARfD4n
 xwkUoA7/QJ6qwSls4NjuhX718/eKPrhI+RcbqwiRuRo2dJdaw9W7TS5W5TgtO3JXoO8U
 DhXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792166124; x=1792770924;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=Z0U9nhI3/BkU5LUuDW+0BzjA0KXxkCMgNCafRerAKsY=;
 b=wcboPwMbba9jiFWJn1fLv04sZ2eD99T4okHaI1RnwA3zUIoq2x5i1kKelt9aJb4i07
 7ilxHwV729m83gkJqxH0rbfDPieVQ+w+SEj/bFg5vzomGff/+UOM0x8q4VUaz1BBtsTB
 y6YQYaJgLAYyOOnZlkVmjy2GRMJ5ac9CnOcwoqJHCOMaZIf6L3uThHloGktdjmXnpFhi
 /L4g7mdH+lHqN4WGTBhl3enqtuM1tXeob1CpqOHi37+N38k/XwlZ3Zja1wuSiMkK+0B6
 jFP9XA1CCBrwdOSCjrt0Ydu7trYlGdPppulIUzzrZFrmV9p9DAxNJvH5wUPCq2bkOgTa
 tB6Q==
X-Forwarded-Encrypted: i=1;
 AKwUvBwp/T6YedcRoU2YA8AnJ6m2mv+u541FAo4iJ3/sU4hBQMqYsvjZncR6V67talkz3oWb7kfRtZQM6VpF@nongnu.org
X-Gm-Message-State: AFq9FYJC22nnjTxFFz/8VxjHUMntwbmyi0IN2IJv2SqQ0IeezmO8DBZr
 4sPFf+Cxyox5FJTXHVzMmzpY7b4YnRG8HvfrCJrEqhjIH9HIgf5IOrVh19yOUOXuMCtI63LWsN3
 A1LbD+nU2hQpVLdzd0qTw3dPzuOnhxhO666s01hJ89Q==
X-Gm-Gg: AYBFou3IFWpsPP3xsl8+e3eR0bBm7dFcbM9B+gxZ9QZ/lWewBLv+SuSk/3xiyNyypwy
 lbhLPJOvWzoM6wMdSoQXJ2vIVyiA73BSY6KRqPAfVfcyt2FptLOOI21MQLgiR+Zq8fUMqBNMNI+
 pTyAEH0t0jBNpJ/LkIDE5B/bAA+ltVXlup4wo2GWFqEEf/8J5Dnh+91EH/WEEtzHvXAn4uWIQQx
 eDwYRO+G+7fjGlFzw4SWR2FTjnYyBeV8NhoGwRYBS5Rch9iUpiUP37GedZORO8SKtVR86C6K/bv
 JQTHvaAWOhdt6n1adMI+Ihj+e7COLqTYvfgyDcblSjSquqsnIvBKcOOk7gr+x/QhKNchP9aF5zz
 YCThpXcL4YGG3KOV4X9FosYojzjXrvRkLd6vbEq7OflQoqoebosk=
X-Received: by 2002:a05:690c:fd2:b0:8b0:ccc3:27d2 with SMTP id
 00721157ae682-8b0f2176552mr1755087b3.29.1792166124207; Fri, 16 Oct 2026
 08:55:24 -0700 (PDT)
MIME-Version: 1.0
References: <20261016142031.1204281-1-mark.caveayland@nutanix.com>
 <20261016142031.1204281-6-mark.caveayland@nutanix.com>
In-Reply-To: <20261016142031.1204281-6-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 16 Oct 2026 16:55:12 +0100
X-Gm-Features: AclHuK9skk_bQb3K0JVtLihI0jZXbPpRninwyZ9Z8NqEK-mnjl_NGcwhfVRtaZs
Message-ID: <CAFEAcA-uaJtM6vkkqacrT04CP5WK=78odLu=BHH_z3CuuWPk5A@mail.gmail.com>
Subject: Re: [PATCH v2 05/27] i8259.c: rename PICClass to I8259Class
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, richard.henderson@linaro.org, mst@redhat.com, 
 sstabellini@kernel.org, anthony@xenproject.org, edgar.iglesias@gmail.com, 
 qemu-devel@nongnu.org, xen-devel@lists.xenproject.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1130;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1130.google.com
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

On Fri, 16 Oct 2026 at 15:22, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> This is in preparation for its use within a QOM type presenting a single
> emulated 8259 PIC.
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

