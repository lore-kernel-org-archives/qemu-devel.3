Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65971C27C4F
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Jun 2024 05:09:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sHchf-00009N-CL; Thu, 13 Jun 2024 01:08:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHchd-000090-KQ
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:08:49 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <manos.pitsidianakis@linaro.org>)
 id 1sHchb-0002W2-Lo
 for qemu-devel@nongnu.org; Thu, 13 Jun 2024 01:08:49 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-35f27eed98aso601847f8f.2
 for <qemu-devel@nongnu.org>; Wed, 12 Jun 2024 22:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1718255324; x=1718860124; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to;
 bh=gTXaqNSSsDYAEPUjrpC/YF3hm4eaFDRtbINcjV/Jorw=;
 b=VjF9xAoNeszp8rx8RW9/yaGS8w3KNVaIefqakAYKWqvINCuACQJzP7KSpOSNU3kMrK
 r3MqXbfZ3MLkDvkzgSG81k2+SSzFVHhayov7eXH6ZUbQ76GQygZPVK7RiUvo2l0xIADF
 SWVwuCwtLfXi2oTnBcpgxwNX7rs/6EQ92x5DRA0uAeO+CHf+IFVFP5rTh6A8SCcFUHqf
 zqZLoISuVD08P2zmUZ6jYQ2MnnNy7rtuGd0lIpICU5hwzxmWye6sLwXk+yGcvEBgu2Qf
 vQ3se1OJS4Xpfuih1S1QFidP/thjRKumSNx0xqZ9q1lEMtz7sn5mFZEmnt5jqW8H1no3
 F5Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1718255324; x=1718860124;
 h=content-transfer-encoding:mime-version:message-id:in-reply-to
 :references:user-agent:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=gTXaqNSSsDYAEPUjrpC/YF3hm4eaFDRtbINcjV/Jorw=;
 b=feAhEMtJ4Oj1d7AsrWyipzlu5WM+e3Hlq/x5Q5oM7rPjv3KiEICiZuslrvCgPjSWCx
 XmDxBc6HVVnsEqsFWA91P4hr+a73q7blRLVOt3fOkNOpzZ1OQGpF4NAOkwybIDJ0m3yj
 hVd6wkHw8k2g9O5AVdbr/atxvK0wKHn4ZZlmugkiMWc5Nl0oZ8FgRpEnM21AHBY0uNl+
 5Muuah9VPx5+BecwOHT/nVYBAjs+rtd87C9RQ0vnd1ccUAfVooaVFJLEdvxDoNWlIKrI
 NuFJEFVuuRxNO84ONGLoOdYhnXsdZaToqCya3vmskbi7HZAg+3Nc7qrIuLEx3turP7uS
 E6Mw==
X-Gm-Message-State: AOJu0YwavcbCiaZK499a5ToFkVd2qEfP9PGILqecEGMkgMI2sZxC9HOq
 pkJzRWgYfpJ2lPu5LGSU3afcQq3/ozI8uewN2TUNyESBB6Qtf6k5KgPkMDLSTtUyWeUvcLxIuJ8
 6v78=
X-Google-Smtp-Source: AGHT+IH2eg3aeeGzWUSODdEoIOi8fO7tS8K5zuZ/z+4LnawJto/eJQBQRd0zxGHnt509F5Wzmf/KIw==
X-Received: by 2002:a05:6000:104b:b0:35f:30cf:b4bd with SMTP id
 ffacd0b85a97d-35fdf79a736mr2535569f8f.20.1718255324525; 
 Wed, 12 Jun 2024 22:08:44 -0700 (PDT)
Received: from meli-email.org (adsl-105.37.6.1.tellas.gr. [37.6.1.105])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3607509c8d8sm573554f8f.32.2024.06.12.22.08.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jun 2024 22:08:44 -0700 (PDT)
Date: Thu, 13 Jun 2024 08:06:09 +0300
From: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
To: qemu-devel@nongnu.org, Peng Fan <peng.fan@nxp.com>,
 "alex.bennee@linaro.org" <alex.bennee@linaro.org>,
 "peter.maydell@linaro.org" <peter.maydell@linaro.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>
Cc: 
Subject: Re: Qemu License question
User-Agent: meli 0.8.6
References: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
In-Reply-To: <AM6PR04MB5941BDF756878B3CA208D07D88C12@AM6PR04MB5941.eurprd04.prod.outlook.com>
Message-ID: <f06ai.hy2gx5h8080@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset=utf-8; format=flowed
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=manos.pitsidianakis@linaro.org; helo=mail-wr1-x434.google.com
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

On Thu, 13 Jun 2024 06:26, Peng Fan <peng.fan@nxp.com> wrote:
>Hi All,
>
>The following files are marked as GPL-3.0-or-later. Will these
>Conflict with Qemu LICENSE?
>
>Should we update the files to GPL-2.0?
>
>./tests/tcg/aarch64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/x86_64/system/boot.S:13: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/riscv64/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/float_convs.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/float_helpers.h:6: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/libs/float_helpers.c:10: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/arm-compat-semi/semihosting.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/arm-compat-semi/semiconsole.c:7: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/float_convd.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/multiarch/float_madds.c:6: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/i386/system/boot.S:10: * SPDX-License-Identifier: GPL-3.0-or-later
>./tests/tcg/arm/semicall.h:7: * SPDX-License-Identifier: GPL-3.0-or-later
>
>Thanks,
>Peng.


Hello Peng,

These are all actually GPL-2.0-or-later, in fact I can't find the string 
GPL-3.0-or-later in the current master at all.

Manos

