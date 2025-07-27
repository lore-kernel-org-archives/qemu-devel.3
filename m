Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B2C0C87FCC
	for <qemu-devel@archiver.kernel.org>; Sun, 27 Jul 2025 14:05:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ug1zq-0006f5-Ej; Sun, 27 Jul 2025 10:05:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ug1zn-0006Xt-V2
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 10:05:00 -0400
Received: from mail-ed1-x531.google.com ([2a00:1450:4864:20::531])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ug1zm-0005Gk-EP
 for qemu-devel@nongnu.org; Sun, 27 Jul 2025 10:04:59 -0400
Received: by mail-ed1-x531.google.com with SMTP id
 4fb4d7f45d1cf-6150be62be4so1631978a12.0
 for <qemu-devel@nongnu.org>; Sun, 27 Jul 2025 07:04:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1753625094; x=1754229894; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OE6lXfQoczYjBjQ4RH4+wmtwsv/Rzy9alyWleTWOu9c=;
 b=igHp00Zg11ceHwwx8mcnHrh3HzTxxM5yFG0QqUgK14dtwwe5uUT6r3BFD/gyDh9oG7
 ZZt/QWYGfxvi2jGBw8Q89iCnC1bQd3Rd9sXt2XmJqu7CZUXNrXNPNvceC/JiSm6fs+ge
 yoQ6TUY2X/L/QNIf3/tO9wEOZmrtLfyZwQvA2tPnqUC10PQ/fb5mQknTj6DbzETHZ19Y
 oh1SXFkZ2B8HQuVgLkODn6H/DD+j6w1DaG31lQwinBvfBkCIrEEPHSUlh8ozkVI+MxuN
 GLm3nuqVVRjAsNl9XIgh3JgP1v7+4j2r+cNoC/tM+JaSxNfNcIHpfU6yCyUvTAamBHEe
 9qgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753625094; x=1754229894;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OE6lXfQoczYjBjQ4RH4+wmtwsv/Rzy9alyWleTWOu9c=;
 b=kVpnqRwZ2qe7S5qay//zMCNXzgpkL7BRRYnwDYLQ1obrQJCpRgulscCdNo1IBtmZmS
 2o5y7k1WzEqh+9eWbyjXeN8uwpIAGq3fMaVHr58VXkVfplezXcTCnB7IrbbP5Z7pTIfZ
 yiejQUh2Tmm8lLbzgGnW39i1x+HAvInOlJeBjwYVCR670aq9aPk+rLOE+C67xb9z5a12
 3N+GxAvX0a7FN0QvO8Gut10kNcJuXUnN3JwdzKZq8+xUoKcrjHO5IXYRAHOJXdzY4xgI
 /LFJMXDMJqDCrSgXz9r5/UZuE8RLGNqa+srqEvoS3nwA2fZwl5ApvL4DXXeTdhQM7RM7
 eQzw==
X-Gm-Message-State: AOJu0YyJM77AtFCF897vI+dXbFnrjdmsqAsttnfKfbIDgYKWLwuh+LhD
 Uw4IIk0yTvp8PutVCBYFierEBzyfnT/nEpnyf8Ih2p+fxyanh3WT/6dmQ9eKjw==
X-Gm-Gg: ASbGncvxLdBUoZzobhvrOlvTxEXra6g3iDs7kuWd70JBoBBkjov6coZ862Rc41bHYPt
 ZaMWrlg5IBj+S7kGaTHh1qvRSdESIjLX356fY4z7+fjnC5HyyooFipWcKVCkBOA6qnuufxhp6Z6
 zB3gXCZI+A1Fu49J0EM1bWiJR9RGirz4h5iuIve2wKs9gvkYQySFCSUwARYfZQF3qF9knB9ntGA
 viNbcUE2arusXY/F8wmmIUhBO4ztObh3ALaF81ac+mmKkL1ggG2kkK8umtT7uQ35QjQ7PS83r9z
 JsONfHmTZLAnayqP5hRGYQupjtXLNj4uMDwqhwp95mqU5iKo/yjIx+h0Wz9WqIVIB6PPxq99DAI
 +KQBD/853pppcqWaQcXjD7qNFm1YkvM8bfRDmJFCfr2joRJDC5Q+4XfkGJHDtehPPSHfmnkAmMa
 YsJuDObKOqmRbCQRYEvWvAqkvJ381Buw==
X-Google-Smtp-Source: AGHT+IFK+CgG+rGgJUofsetzGAfj569SNKsnWn33NNBINsSNfLifgPTTAFfvn42BIj1YNe70VGUbFg==
X-Received: by 2002:a05:6402:b51:b0:609:b5e0:5987 with SMTP id
 4fb4d7f45d1cf-614f1f1258cmr5897568a12.23.1753625093843; 
 Sun, 27 Jul 2025 07:04:53 -0700 (PDT)
Received: from ?IPv6:::1?
 (dynamic-2a02-3100-2d4b-dd00-bd73-623e-7632-a2ac.310.pool.telefonica.de.
 [2a02:3100:2d4b:dd00:bd73:623e:7632:a2ac])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-61500ae318csm2175223a12.55.2025.07.27.07.04.52
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Jul 2025 07:04:53 -0700 (PDT)
Date: Sun, 27 Jul 2025 14:04:49 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: qemu-devel@nongnu.org, Adam Williamson <awilliam@redhat.com>
CC: Paul Durrant <paul@xen.org>, xen-devel@lists.xenproject.org,
 Stefano Stabellini <sstabellini@kernel.org>,
 "Edgar E. Iglesias" <edgar.iglesias@gmail.com>,
 Anthony PERARD <anthony@xenproject.org>
Subject: Re: [PATCH] xen/passthrough: add missing error-report include
In-Reply-To: <20250717220207.171040-1-awilliam@redhat.com>
References: <20250717220207.171040-1-awilliam@redhat.com>
Message-ID: <DDB29958-4D54-4862-AEF8-1C43E11DDB8A@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::531;
 envelope-from=shentey@gmail.com; helo=mail-ed1-x531.google.com
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



Am 17=2E Juli 2025 22:02:07 UTC schrieb Adam Williamson <awilliam@redhat=
=2Ecom>:
>In cfcacba an `error_report` was added to this file, but the
>corresponding include of `qemu/error-report=2Eh` was missed=2E This
>only becomes apparent when building against Xen 4=2E20+=2E
>
>Signed-off-by: Adam Williamson <awilliam@redhat=2Ecom>
>---
> hw/xen/xen_pt=2Ec | 1 +
> 1 file changed, 1 insertion(+)
>
>diff --git a/hw/xen/xen_pt=2Ec b/hw/xen/xen_pt=2Ec
>index 9d16644d82=2E=2E006b5b55f2 100644
>--- a/hw/xen/xen_pt=2Ec
>+++ b/hw/xen/xen_pt=2Ec
>@@ -54,6 +54,7 @@
>=20
> #include "qemu/osdep=2Eh"
> #include "qapi/error=2Eh"
>+#include "qemu/error-report=2Eh"
> #include <sys/ioctl=2Eh>
>=20
> #include "hw/pci/pci=2Eh"

Reviewed-by: Bernhard Beschow <shentey@gmail=2Ecom>

