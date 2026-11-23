Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18734606A31A
	for <qemu-devel@archiver.kernel.org>; Mon, 23 Nov 2026 11:35:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=nKnI+eQA
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xVSKW-0005kL-In; Mon, 23 Nov 2026 06:35:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSJx-0005Za-LP
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:35:05 -0500
Received: from mail-yx1-xb134.google.com ([2607:f8b0:4864:20::b134])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xVSJw-0001aD-0k
 for qemu-devel@nongnu.org; Mon, 23 Nov 2026 06:34:53 -0500
Received: by mail-yx1-xb134.google.com with SMTP id
 956f58d0204a3-67583c777abso3084481d50.1
 for <qemu-devel@nongnu.org>; Mon, 23 Nov 2026 03:34:51 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1795433690; cv=none;
 d=google.com; s=arc-20260327;
 b=JzRVu64DgaPW4vq1ZoYIudW8WfB+5EyYJwg4De+8vXsT9CNPAFImTFQJmIucr5soFK
 KF4ULznPMp+dprhzwult3nwwAaNrHcBU3umHoNnf9glBC2tCqzPjUW60wrkWCM1zp+Tb
 57muNNrLerXQ39p5nfJF0w217Nvz59AWRCkdIPxUfSyqPbnUH9WC0I7OnRnyjt1P/+38
 Td7CdpjhFABfDCbxwm0nPkZ9vIY/fH17u09sjyrPXIbcOAc60PCzBoinCPVKx01tLxmU
 jKDNiTTg45a5OazBnSiumNSGQ0us6Vavu2oNxNsMFPbltgT4o8mEjvI5Dg+GU4133Fnd
 4Q+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=7r3aoO4bhWZhB1GeACZdgFlYoDBFvSGPgfe8yoob/ps=;
 fh=IfVNTi1A3NbvhnLPwhk/3mZfH63i7FsTWIp8ALqEEp8=;
 b=C0iIhUcRAVscF5HJzYo6+kSHYM6QeX76O34mfF+0b2U3ca+cvGAWB9Ztxv0J+NVhXm
 M2+gEj7zYmq42zF7ZcwRqX64pYmfkmmXGcW0YnQXHR5u0ByUJd8nTung0nE3L6+syUkp
 IKXZV7Y3uOdRk3wpnY2VYu2E8Ib2CxJQxa8SaLiTbEmexVxY9N6DcGpZ8xKyhQVOWbCf
 OvFzqwUdtVwS9XBUqIBx0vy4h5ReOVFDvr6M6vPEHZ1lQsd1aRM7m4/hYbNhxC5OQzRY
 0Swa8RZp6T/9JU8irsJb6QBmzD8FLe4r8ZcVqhNOOZNgorYu7UoWDJ2rqvjw6VBSSJ66
 lktQ==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1795433690; x=1796038490; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7r3aoO4bhWZhB1GeACZdgFlYoDBFvSGPgfe8yoob/ps=;
 b=nKnI+eQA8eSF8vn1vPdafG/6rHH7oLkFkWoGLiUzRr0/ys5lh0YjwGZOCEUeNd/M7j
 NMzYwS+FRzqB4ebJszB/Vd11T1TX1+81+ElRrH7wrxHAmmS9LSiUmykjrhmPTXbLv5za
 hIhTmhET4FhwiOeHm/J45B7o7Nmich8k8VCg3/gRaj0PHOz6KCnO/Rc9yXM914JEuUgX
 nlpVGcphDbiI1Yvx5yctU22iLCVgG052tpCKJvevyNTLppDoMG6hVtSbSs8A79gHridX
 lxLEUJqW6C+fQtKS2CroAB9i8K9KBVkGc6EZhSck1BhSIGIt2B5zDtn4ITsyRh8tmvzE
 OqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795433690; x=1796038490;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=7r3aoO4bhWZhB1GeACZdgFlYoDBFvSGPgfe8yoob/ps=;
 b=YL1wAVcYYMwXMkXhGoQGD3pkmn4AFGtyBqzRjTIjTySXw2+E/Sfp35kLvNClfpliSy
 f3o+5Fm85YPVHJmBe/K9H/PXZEEUlVzqxwBlL9Q7sW2l8YaaOUvvKRvYjwFTTbYvB03C
 7ZM9t6Pv+XkDjuCCckLH8LqvbJCpKhxeBiliUT2Q63x8dsoUr8c3JjQLzmnKLYKu5f3g
 DrZzNPLUv4h2GtYxLseb1sepam932WqEzlwzd3lbms3NFwU0i8i7UOUNXKOcNxl6iWMU
 PAnWjUxIGvuMFbRivKPCR9tXHTPYGWg+9091imTK9Ojs2oHegPtunthHA9vJATndGfIn
 3Tfw==
X-Gm-Message-State: APuU4Z/7MntnL2QjJj7X63vdY7p6xzLDoJC1ytPQfD7conJMArvJXxec
 CzIronlcMxyCui3zXLGGF3eIxUlZHCdI7cDJUCsQlmhvPYG148D+ODVhYmP5lYezvgq4gfae41E
 gWKJJiloth0YEgjJ3viBzoz39rpgF+5j/ZrU27Dsi0w==
X-Gm-Gg: AZFdTZei17Z0xv2HBbPcqKydPH1xT4z6pxv+V1pljoQVc7j0OGDMjFK809AnNEN58op
 f1v/JYouOcz5n8MiiQQ7WDob0KpEztESAuNhqXQ8uOzziGUAcCkkvckZJcqvRut1ZUusNVIe7TZ
 3hBuZa2VB0PWZuy8ykvu8OBLmBH6P9+OV1ZgKXZ6JXXryu0jpvhOsDuVXukl5ul+rbrC01/kP/C
 eHjed3bKlPgrzSHZjVX8l07zojGb9aYksdvkc8rhxAaWfEtS1gBqOUyVQ5gwc0AK+DHr/r5jPl4
 J8knM89MOTXNqEHquK0hiiAjU5gnyZtmOzBAhEi1wfSL/nAFYCxNnv+Gn6i+nB+4drAhTkh/2Bm
 xDsiOj8LCEMy0Jnfs0FjzW18sB+x2OIlK5VAFxwxc1ePNQq4JbCQo6+VGepbqvPHpo7gnuK6HTG
 X65gVujnUXgQnbUzXWG4NU
X-Received: by 2002:a05:690e:419a:b0:67b:e7b9:7a58 with SMTP id
 956f58d0204a3-67df44dee3fmr3450977d50.44.1795433690421; Mon, 23 Nov 2026
 03:34:50 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261113165015.1150646-1-peter.maydell@linaro.org>
 <CAFEAcA--1GLGf=7tmkzQZ=QRPApLTdsdFskgbSibYPDF0o626w@mail.gmail.com>
 <41dc8ba1-839c-4c56-b7d3-876a72fde6fd@redhat.com>
In-Reply-To: <41dc8ba1-839c-4c56-b7d3-876a72fde6fd@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 23 Nov 2026 11:34:37 +0000
X-Gm-Features: Aa3M54rrwRNlHdlL-7STh4xrKua48cMir2tSLo5d03SlCG-1VSu9-43qLAV6G_o
Message-ID: <CAFEAcA-krvOZrOTwXBdPWOjocXuuM4jTwaTf-NCB1ofju071Sw@mail.gmail.com>
Subject: Re: [PATCH] hw/net/rtl8139: Limit DMA transfers to plain memory
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org, Jason Wang <jasowangio@gmail.com>, 
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b134;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb134.google.com
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
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On Mon, 23 Nov 2026 at 11:32, Thomas Huth <thuth@redhat.com> wrote:
>
> Am 23.11.26 um 12:28 schrieb Peter Maydell:
> > Ping -- could I get a reviewed-by for this CVE fix, please?
> > I can fix up the unnecessary "inline" keyword.
>
> Reviewed-by: Thomas Huth <thuth@redhat.com>

Thanks; I've queued it to target-arm.next.

-- PMM

