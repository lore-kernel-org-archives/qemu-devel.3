Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8FA4CA1005
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 09:47:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utNbH-0006S2-DM; Tue, 02 Sep 2025 05:46:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNbF-0006PK-9T
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:46:49 -0400
Received: from mail-yw1-x112e.google.com ([2607:f8b0:4864:20::112e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1utNbD-0002t4-JT
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 05:46:49 -0400
Received: by mail-yw1-x112e.google.com with SMTP id
 00721157ae682-72267c05111so28351587b3.2
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756806406; x=1757411206; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=bZmQYuV005SJFBxThazNx6cyRZk6D6FHdUOutz3nlWU=;
 b=EdlZKDv21G+EQSNaqmfh55jtNqG3XcTrxk9sOsoJa44II1xjsbXd+vI6kGNbBABjZx
 v3vNqXLYmeBRBHtQWQwBWCEPqgLe758PlYpZd9mn2QaOC+wkVMgtiycizJqF2szT2G1N
 cWCCudh0vfloAjwXFVX0bQ8vkMhiuUX9D4Co6blk8kuJMSsUFGYveeH68znvaTpcCtte
 p2dI61JWqsj3mLPSi3UhYPw2MD3EMklnWTprtzqdck+AFQ5/3RQog8DffI6OZn52ScIQ
 IACMibrM2Niq9eSvDR6n3gEgG4FvqgmEPYrI9uc8V0LqvX5O5+iLu+k/U0IZxzsD9Nvi
 VDnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756806406; x=1757411206;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=bZmQYuV005SJFBxThazNx6cyRZk6D6FHdUOutz3nlWU=;
 b=hawsJvqn709ydq7L1cMfhJOEnf8+1snvoC4z71tN4ObKpIL2tqi8Oyn3uNxZQqwaEZ
 +ckDj9JadicSOBKGX51A6P3wSwywaTalVBSF2v8pIWHIx4QhoCLVqgH+0zRs6JYBpAeQ
 ELOrKDFDAneO2ggjcrgsudRXNmCt/8zTyLBGgvnAXW64BriqRpUId0X/+5elXj81VH3f
 eQCqfYEY8BakksRxAKX8Znf4is2TnM0nIosNaUyJHmXAUULo73QFkwSRa8qiPHB8/vSE
 fJGM6MXYbd8kFRMz0lpIooB9CYmYvwI+zwNdeDF9gbicayczq2Ik3fuLSNuBAMb2UDXm
 v1hQ==
X-Gm-Message-State: AOJu0YylDUoJJk1WBTY6awhm8nh+iLi5vM/jRKYpesY5xgSFP9it4fux
 /031WO05v+0tSQV/lB+SQJGou8svbRlwuMqsgZX9SgEzT8MqKlsPTrvfDTD98dDazli7WSylRkz
 2sFw7W9/sJvgfX82mw8NxP0RkXRC75z4fexIqsX2zxQ==
X-Gm-Gg: ASbGncsbGO1SAnmojDG47wHKA+7Obb8VX/IHjzrBE8AAkcBSynr+TYqcYlckH+gvvTp
 46JPLsmPFmHQMuvWpRmX+GyURzuMkzwrrMUT+UZLnjpZy3ch5DKwUxkg2DcRQ65TTSLkharmGQN
 5b5gfpJWPMrTmo/k0BmUpR09WFXqNaCs1pe6IAsHH6WcJ0c3ZBO9UMkH8AaTBZIo93LlOqj1ug9
 osm/KkQRZ1wmQuIqmE=
X-Google-Smtp-Source: AGHT+IE49PTSbc3e2cMa4yd8ZcZQzy/L4hBLh4uVwNslx3XIBiSzIA4KDZ4sH283B3zR+oADdyRYRgESOXn6m2MEtNQ=
X-Received: by 2002:a05:690c:6703:b0:71f:ff0c:c970 with SMTP id
 00721157ae682-722764174d8mr120940527b3.24.1756806405649; Tue, 02 Sep 2025
 02:46:45 -0700 (PDT)
MIME-Version: 1.0
References: <20250820211932.27302-1-shentey@gmail.com>
 <20250820211932.27302-3-shentey@gmail.com>
In-Reply-To: <20250820211932.27302-3-shentey@gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 2 Sep 2025 10:46:33 +0100
X-Gm-Features: Ac12FXwajuLATfYIXcb3B8YipLG8ak0Nw0R6zYHBKbr3PkGTj8gKFVWon_6TAPE
Message-ID: <CAFEAcA_3d0x_BqOiMhBih1eynRa2mPLVkxZy7fhXNb+fwd8f+w@mail.gmail.com>
Subject: Re: [PATCH 02/10] hw/pci-host/designware: Create viewport memory
 regions on demand
To: Bernhard Beschow <shentey@gmail.com>
Cc: qemu-devel@nongnu.org, Andrey Smirnov <andrew.smirnov@gmail.com>,
 qemu-arm@nongnu.org, Guenter Roeck <linux@roeck-us.net>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112e;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112e.google.com
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

On Wed, 20 Aug 2025 at 22:19, Bernhard Beschow <shentey@gmail.com> wrote:
>
> Currently, all viewport memory regions are created upfront in the realize phase.
> This has several drawbacks: First, two MemoryRegion members are needed per
> viewport while maximum only one is ever used at a time. Second, for inbound
> viewports, the `cfg` member is never used nor initialized. Third, adding
> support for other types of memory such as I/O space would require adding even
> more MemoryRegion members, one for each type. Fix these limiations by having
> just one MemoryRegion member which gets configured on demand.

On the other hand, docs/devel/memory.rst says:

> as a general rule do not create or destroy memory regions dynamically
> during a device's lifetime

with a flat ban on doing this for MRs that aren't container or alias MRs,
and even though it makes an exception for the container/alias case it says
"Exploiting this exception is rarely necessary, and therefore it
is discouraged".

(I also find it harder to reason about, because it means I have
to think about MR lifetimes and references and so on, whereas
"create MRs at realize and they exist as long as the device
does" is easy because it's the same way every other device works.)

thanks
-- PMM

