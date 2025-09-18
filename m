Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFBA3CAC5A0
	for <qemu-devel@archiver.kernel.org>; Thu, 18 Sep 2025 11:59:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uzDIV-0008H3-0B; Thu, 18 Sep 2025 07:59:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzDIT-0008Gm-0k
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:59:33 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uzDIR-00053u-Hs
 for qemu-devel@nongnu.org; Thu, 18 Sep 2025 07:59:32 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d603a9cfaso6948227b3.1
 for <qemu-devel@nongnu.org>; Thu, 18 Sep 2025 04:59:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1758196770; x=1758801570; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=v0QmcdbAGzKbVLKrDsn19lvO1tQllTOqMLWBbikkfgs=;
 b=CPHmQt4Q99ePQ55dQYrcaIObGcG4e+Xz+wPFQo6Ah8/ym/gmaP8rEnQ79eG2MJbJ8y
 C4nYoKMQQ2GBVPkf9z/bqTEkiaCEXb2XKpmu9pOjX4PEQaFnmwpbJ1fRKy2+u7cxlNkN
 ZRVjbxs/96gy4VtQ2GtU98pLSsM6up/qSlewWWTrKdsEbWVozdkQo12sd72uFNcrYuBI
 RdwYBQ5rrr5mnWrvcE+9cqM1AcRg6iSt1D5+x0FbSazsPV9EKP0RrGCpAaThdTm8617L
 Tu/ufhvN0IuLejEK3KjrogSHNZnAs7b+7oDxgvMwbKdOHhFQTY3w9l7vOVfz7h0JDMdQ
 j4aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758196770; x=1758801570;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=v0QmcdbAGzKbVLKrDsn19lvO1tQllTOqMLWBbikkfgs=;
 b=YT4ygh5nem1QX1YsQTw2ewHdvObjJDb21s+az7ehLTtZ+7/N1FQtNlw6nrXZ9rqbpZ
 oAKbiUneTzcIZecoG5I4QFU1RluNPwAqgK2tL4bDIMuGxMu1MoDEUbny7WiKjMwjjEzh
 DIDeVLOEPp01GJxvDqMzJ7c7oTdemX9wyJsydzSc/n8m0QiMlB2Fq0WEvV6dlIDdRblk
 3+X3kApVAuwrh12OMJmDvhpsiCWOXDZrIjdGEDmfP/mNhtVrqvD7p7i6F/TarWzLlyks
 3qYxXkAKFDee6KRTSJPg+zCFlCDHc7gf4zr42BFtZ7yJ1J5zBA1cntdFNt7g39vUhhsS
 gIUg==
X-Gm-Message-State: AOJu0YyFJLZqiIcTZJigwgGldPLJ6GIoJ/2hz66bMfUjUh+04emfW+Jv
 ccfCOX5WnmHBG2MqsYYNpSZOPqKYWSJsKNPujmEUpSXf+/rOiPNAwquA7uNRENX7gH7MTCnxvbu
 EaEFqkA50LW5znYSRrfhnG2sp10WC22/ixfu1Z+61NuRxCX+G5KQ8
X-Gm-Gg: ASbGncvcoe5mugRMI1RroPJaeZcXiMy3Etlycl5w6hLda03kJewLcXG5aMHghAvU/Hi
 V37Led1wk9QyEyWqrYfOjEV82wjAfvUgwIhih8J+1yw3O+YfEhmcctksZTEyymZX8QqeuVUC7Ze
 UVusAf8GD0Hire6ePU2nyuNJPZeDlkA1PCGYjpnQqggKGbFtxqy4ksBZeg4aTCLDXKAJjqjGaR3
 pKoyg2Gt/H9u+PnqRVeAO0eRHQ=
X-Google-Smtp-Source: AGHT+IGK3aqORWWuWXMxEPqakPzMRwuLVt3174KveujZ4JAtYWS072soPPz0R37BDxeXmwdHPSN+ZgM3YfxJRmigI5g=
X-Received: by 2002:a05:690c:10c:b0:723:bce5:1aa6 with SMTP id
 00721157ae682-738903bcd13mr42643237b3.9.1758196769950; Thu, 18 Sep 2025
 04:59:29 -0700 (PDT)
MIME-Version: 1.0
References: <20250918114259.1802337-1-peter.maydell@linaro.org>
 <20250918114259.1802337-3-peter.maydell@linaro.org>
In-Reply-To: <20250918114259.1802337-3-peter.maydell@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 18 Sep 2025 12:59:18 +0100
X-Gm-Features: AS18NWB2Xo5VFOCzWxKFj8V4ZUDsX-jouWNwByyx2A0r7UXP2_b-ereNwo65lEU
Message-ID: <CAFEAcA8WJXL4NqZC5BQ6APwrxbaXmeSTGVwb58eJrLfQ2+bndQ@mail.gmail.com>
Subject: Re: [PATCH 2/2] hw/pci-host/astro: Don't call pci_regsiter_root_bus()
 in init
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Helge Deller <deller@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1131;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1131.google.com
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

On Thu, 18 Sept 2025 at 12:43, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> In the astro PCI host bridge device, we call pci_register_root_bus()
> in the device's instance_init. This is a problem for two reasons

oops, typo in subject line: s/regsiter/register/

-- PMM

