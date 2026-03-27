Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D37F510ED674
	for <qemu-devel@archiver.kernel.org>; Fri, 27 Mar 2026 14:20:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w682C-0006Fh-6b; Fri, 27 Mar 2026 10:19:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6827-0006BR-BS
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:19:33 -0400
Received: from mail-yx1-xb136.google.com ([2607:f8b0:4864:20::b136])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w6823-0007UG-1r
 for qemu-devel@nongnu.org; Fri, 27 Mar 2026 10:19:30 -0400
Received: by mail-yx1-xb136.google.com with SMTP id
 956f58d0204a3-64937edbc9eso2080434d50.2
 for <qemu-devel@nongnu.org>; Fri, 27 Mar 2026 07:19:25 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774621164; cv=none;
 d=google.com; s=arc-20240605;
 b=NIMGuYo17gsoUi3w4QXw9SrRMEFatCBiqR4yZYAidKrTDUJa3AM+/8t6mU5dwCahbD
 ly3fNg+uXSuvaP+QSGdUulgxS5859ZXFEKH10sf3NxGhZTJXXHiVFrRj3rfovstCkGrQ
 j8najM7wwoKB92ywM4uwZuW/t/KxknBplVdMWMUN2TxYxsC+LgBYX64/D4Hcu9SMXzbI
 GDMaAk1b4+zY34XbzH1my3hh3JsWmEaLzx49AMNUOTp6ta6h0HPh3yDa34I7KClAaduh
 QD1JpMRa2wgen7oHoc17uNfOoLPUx/dabrsHAX0UwYQcQ+Jyxw4wgLW1uz71W2Pf9SRy
 x+bg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
 fh=j+Jf8Zo7HcoLWhELk7s24DG6J3SeNcVMMul7UByBgFc=;
 b=TBG3NFIN4+1tlJIj/h8SnWwpOBvKNc9e+d68FjQbRePpt0i/QmtjdN653fcc4cQFPV
 1UqsLgGI1Ko3ZCNeHwUChh4Kt4KXHD8G1dyfxdLBcyT5LIJC0Us3Csmfl2mnVbaIuuDw
 Gflah8CAEITzUppHK3X2P9ilhq4+WUkmggPg57oAz4m+/xpMKAIE11IF3/v+x8s0HeQE
 +yrq9cM8qGHoh+5NtruswFcG1uprgXjNObxZ3iMK7xav0DfjTFCY3bbrACdVsYXty7Hw
 9YkSLlT1eJUq/6qo8dkhmvy/hOAM2GNpBlaRtt3e8ac59f//qYpq0Atr4L/JNMrjiK1l
 j7VQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774621164; x=1775225964; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
 b=E9GO3Hs5UEJzTOylNTclcKT9dATa9kBCJVuzKZZ00AGOXS6aqsbCgWXWF0dCvPN4qA
 Etsy67mE0lE19UiguMi+bJW1que4j3SZgnVFXHEHtAXtkPVsuiKqe+y106CoY/jEwLWd
 r2YuhOppvIDzE4w7UwPQDtXsh/KlaO7KnT3CDNIkD3IGeRJYAdHUnYFMTT/DwxGtt1ac
 a1CJNM4X2zsJhM8d8yOnobN+gutePvrjGvf4fYvpkBSjee/ngjab9SVn79yT9fQyDcQ0
 ZVK7Zzt3tYuZJIRpzGFI8xg0JBTFcn6maCgHgJsd6vruYIqjg9eW9UcatSZavZ3Gr1Uo
 UgTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774621164; x=1775225964;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=4WjmeaXgV82+aZtxwTz6uUGHzaGhq1ymgyGOqGfqkNs=;
 b=VaTX+cvUDaHZ/ke2kVZKKs48UfBEjUluQK4M9EJfNlTXVmX2S3bJdZQt1+IyWcQEoe
 vhpjA4GU9Y7G4JoYQ0afuHv7z5W7VvYCy8Z4KDROZsHB82D5xsv73G/7YAiVeifT8jHz
 Xk9zvs7pSUIP4eQlkWGZykGjZmNRisy2Gbr7gtiC3oLOaB8XinkO29Bi3OYtIdoVRzCn
 0qCxvV1/DClpqbsfdbsg44FVlBNJw4oKDAMyhUPORYdDlYfv7RlKw7kJN1eGxj1AqydW
 N1Jwxe3LGpp+H26DdfM0Icp1vGfeP3fki3Hr4/TSAns7JCbCUHU9YD9+MNM5DOj7rEzi
 KMeg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXeqdFjgCSgxbMU2Wvndx/tR3ROo1+d8OzjNpx1d0Ft9mqvPJZbd8p4AuybpAehrJO7/Tzs4Oe7Rgkc@nongnu.org
X-Gm-Message-State: AOJu0Yzmx4vw10+sTQfMLsj6vdl4qDGu9qZFsptRwpLNxKcrBsAPL6wc
 PtkTdlnR185xtrggUl9E7Pi50GOWese8oWeM/yzKFV/8bFy3r6VeZosvJz+mhnLzMAyF3UvHxpB
 yqaSnohmOhK0LraMAEKhWijduUeiXz74pE+ZclFrzEA==
X-Gm-Gg: ATEYQzwrGQv0AyGvUPjB3kowjGIy8JZDR5bfjgLIrDEhsMxTRRTFYCCSitKCbyHbcLK
 QkAPMzjYjwldSKc7S+aF5Km9nbzkkFz2b/RPM/nVwXXLYulwp9MXriOb/uZIkqM9vXn1w2E2FVA
 e3+u1RRiTRndCBibrTsA9C4fHGPMw32CDhpryqbK4ixwMoMYzHzjSGORMFozBgBzlpf0RcTQqDJ
 qLhHeVu4BLY7Cq7OBowtrRJSepTrahfDJg3Zq2B5Eo0klYAcN1f/GgpPIWbgWJIIwM7oxes8R9g
 DJxMxNIjltbmhWPsjk06rvghd/Q9MlQqyoKdGIPFNs+mSKHzCBVgOe0cR/u86BtRbS4=
X-Received: by 2002:a05:690e:4810:b0:64d:6193:a760 with SMTP id
 956f58d0204a3-64ff71d6b38mr2131553d50.27.1774621164224; Fri, 27 Mar 2026
 07:19:24 -0700 (PDT)
MIME-Version: 1.0
References: <20260327134401.270186-1-kkostiuk@redhat.com>
 <20260327134401.270186-12-kkostiuk@redhat.com>
In-Reply-To: <20260327134401.270186-12-kkostiuk@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 27 Mar 2026 14:19:12 +0000
X-Gm-Features: AQROBzDFKAtaDnZ_CkP8sLNQj62KF0xDt5c24sJEJyOSFn4rOw6Vt4Bc3wmhX_U
Message-ID: <CAFEAcA-7uAnDm56JLJh-ASDGdSAv6EGoB5NNcKtbVGPuZzAYPA@mail.gmail.com>
Subject: Re: [PATCH v2 11/15] osdep: Remove unused strings.h
To: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Cc: qemu-block@nongnu.org, qemu-devel@nongnu.org, qemu-arm@nongnu.org, 
 qemu-ppc@nongnu.org, kvm@vger.kernel.org, qemu-riscv@nongnu.org, 
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>, 
 "Edgar E . Iglesias" <edgar.iglesias@gmail.com>,
 Alistair Francis <alistair@alistair23.me>, 
 Nicholas Piggin <npiggin@gmail.com>, Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Daniel_P_=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@redhat.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 Chinmay Rath <rathc@linux.ibm.com>, Glenn Miles <milesg@linux.ibm.com>, 
 Palmer Dabbelt <palmer@dabbelt.com>, Weiwei Li <liwei1518@gmail.com>, 
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, 
 Mark Cave-Ayland <mark.cave-ayland@ilande.co.uk>,
 Artyom Tarasenko <atar4qemu@gmail.com>, Max Filippov <jcmvbkbc@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b136;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb136.google.com
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

On Fri, 27 Mar 2026 at 13:45, Kostiantyn Kostiuk <kkostiuk@redhat.com> wrote:
>
> We don't use strcasecmp/strncasecmp anymore. Also, we don't
> use any other strings.h function. So this include is no more
> needed.
>
> Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

