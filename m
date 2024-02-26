Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 39671C48BF6
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 13:38:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rebBD-00069l-Vn; Mon, 26 Feb 2024 08:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebBD-00069X-DG
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:38:03 -0500
Received: from mail-lf1-x12f.google.com ([2a00:1450:4864:20::12f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rebBB-0004bK-Fx
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 08:38:03 -0500
Received: by mail-lf1-x12f.google.com with SMTP id
 2adb3069b0e04-512b3b04995so3124438e87.3
 for <qemu-devel@nongnu.org>; Mon, 26 Feb 2024 05:38:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1708954679; x=1709559479; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
 :date:message-id:reply-to;
 bh=Sid+kGfDTcBF8GIDjZdmNFNd+SZJRPBYTDaoDuy7XuM=;
 b=RhI9rWFaLgmBdPDf6BJMz7aA6embwAeaRUyCtToMJYNSmnsuFglyZoLzyNuCohJSKq
 xLN1hfi24CQc9oB0AkuTGRk/ijnrjqEGM/vf1+hn8iLYprZN5+oPjGsT3FiEGUhFcL4d
 xdFK+aWp1qvKrMXTpNCx296e+HzD0mlGlPw2u1+sU4s7TkE+RC0w1JDsQ9y9YSf/Q5pR
 MNGfvfOgL7E0WuR8rq6rygF1yVFnF3mBX5YVpBcXd3pCWb+dx1uH5hBrL2PkipA2H9zN
 RTNoEIYFNccra9GxIcq2rYKmgjEEaEfGsieBrsW4zfrjtRWd89klN+g82yLL3NjFIfDE
 xH1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708954679; x=1709559479;
 h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Sid+kGfDTcBF8GIDjZdmNFNd+SZJRPBYTDaoDuy7XuM=;
 b=QFMa3pJK/BGwaeig4clyKajxK0K8a7LIy1VEKiklbDHsT/hgs/T7VS7EgGZDgKU2QY
 XlDuNYOTQtyjFOvjLA6f2lmWKOemrUuLltH4gPMGu9e5y+DLMY0yZhNsZXzDDhO5GbSV
 9zwPzXQQOCIcjic9T0xgUgeWCn+ivc6wmoar6KT48H39j2KSgigYh40BndEFV/THgpqm
 Sa+8ZDJT7LcVQakJIQapGPP5puFWdEvx7aQ82o5TC8Ka/nvXjsYpkCiTD1sj9owEdlSB
 mVTE7oGQaNMS6FlzBJJQYXxRCvo3V9ELv5joxkFpe4RN+fj5gfwRJ7R2kRT/sVwbkbFo
 2Bkg==
X-Gm-Message-State: AOJu0YyKFP2k+daxmHpXSM68vOTeCl4DmXJk8Wx/XmPnYh+0gAe8fX59
 jdHU7+DRy2l2sfgkXSfvTxwt57oFtAdth73SD2RmbGTj23ufqWlUHVlBhHUiotExBri64AHRbnJ
 Argde5ZDwaH0FZ/tPp0fURpqiD97eXmW41XkMjiNyHqrEaZtR
X-Google-Smtp-Source: AGHT+IG9qJVzx/rRnINeH1oGGXew5u2Rpv4720ESidUSGYqmBy6MQcIADtRLrhUCe9vTxDXAq0ctqncgMI77zk2Ezs0=
X-Received: by 2002:ac2:489c:0:b0:512:eaea:414c with SMTP id
 x28-20020ac2489c000000b00512eaea414cmr4055522lfc.1.1708954679366; Mon, 26 Feb
 2024 05:37:59 -0800 (PST)
MIME-Version: 1.0
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 26 Feb 2024 13:37:48 +0000
Message-ID: <CAFEAcA-3gSBhEv3GY9XeC-5nxjk9ymc7BnhUYF+Cu73tNE3uyA@mail.gmail.com>
Subject: 'make vm-build-openbsd' tries to download nonexistent 7.2 installer
 ISO
To: QEMU Developers <qemu-devel@nongnu.org>
Cc: Warner Losh <imp@bsdimp.com>, Kyle Evans <kevans@freebsd.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::12f;
 envelope-from=peter.maydell@linaro.org; helo=mail-lf1-x12f.google.com
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

'make vm-build-openbsd' has stopped working -- I suspect that this
line from the logs is probably relevant:

http://cdn.openbsd.org/pub/OpenBSD/7.2/packages/amd64/: no such dir

though we don't eventually fail until much later, in 'make check' with
        gmake --output-sync -j8 check V=1;

Pseudo-terminal will not be allocated because stdin is not a terminal.
Warning: Permanently added '[127.0.0.1]:33847' (ED25519) to the list
of known hosts.

ERROR: Python not found. Use --python=/path/to/python


tests/vm/openbsd currently has:
    link = "https://cdn.openbsd.org/pub/OpenBSD/7.2/amd64/install72.iso"
but the webserver doesn't have 7.2 any more.

Could somebody look at what we need to do to update this to 7.4
(most recent release), please?

I filed
https://gitlab.com/qemu-project/qemu/-/issues/2192
to track this.

thanks
-- PMM

