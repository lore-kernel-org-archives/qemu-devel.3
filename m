Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7600CA1006
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Sep 2025 13:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ut4eL-0000hs-RY; Mon, 01 Sep 2025 09:32:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut4eG-0000g6-5A
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:32:41 -0400
Received: from mail-yb1-xb32.google.com ([2607:f8b0:4864:20::b32])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ut4eC-0002DH-E1
 for qemu-devel@nongnu.org; Mon, 01 Sep 2025 09:32:39 -0400
Received: by mail-yb1-xb32.google.com with SMTP id
 3f1490d57ef6-e98b64d7000so866496276.3
 for <qemu-devel@nongnu.org>; Mon, 01 Sep 2025 06:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756733553; x=1757338353; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=LD+gRScFdfF9na5A+FC6NsHrnfDmMo8/pPnHtu42lvM=;
 b=osC+XoiNYawKqYjwsYWdXh5WMxonW5vcQ0Zi8d+/cR5gthplNBUDJjPQQKKzhKwIFI
 O5QKu+cYvqRT7BuM44/Ds+xVTLwDM+A59RTUipNK/mhIzmGHWNcUfQpX36RHB+uBSydv
 H9Lo2adF5bed/7OC3+HLmKdqwJC/vvnA0NmezwcQbIJ7pJYJxdbKl/4GVQQ7yhnK25Fi
 YW86iL4/nUEkkhMMG+wWyCREXJVYcUuY1eLyqZnSDOQ4g9XV0gtXZvlgI+MUbD45NMRg
 dFmiVxJLzVrKJkFK86UOnN9e7hKkCllp8Y7w9raKubnQlHZ2kNcDFJhwqBDiVEDe9e/O
 MhrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756733553; x=1757338353;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=LD+gRScFdfF9na5A+FC6NsHrnfDmMo8/pPnHtu42lvM=;
 b=ADPP946n/7UuOKWJE1XKWfcpzJO67CIDkohTOR7F2P9SH+fpYhzQrGfejymtbdLqZf
 jyFFbQUNvY7nx1N/hO27W+arNUcX++UNQVSrDGlTbyAeDHQP+bVkrVz7QTmkYRYteyvx
 vYTmWFUjr7O/GAd6EVD8LbyLztSI6Wqhxgn37OLM8xqJl23QUpNrq80pyuVbSEmloAMa
 8qkZ0Uq2obo8HYyQnajdna+Qp6OO2sZjmwSP2ZXdCxzbtAZ+Y+HSEihJDnYj/vBVyNlt
 MPQdhHSwoozW/oisb+JRCj32etGDGfIQhZSwNixzoW92ywvzJ8ShZKM4krOjvik8yyMF
 QjrA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWZR1Gpco4DFnrt70AVWlxDteDlbt8+eanE7G4UukPeVDTc79nIb6rl3obbbiKkyDpvqJDqj9dccgSs@nongnu.org
X-Gm-Message-State: AOJu0Yx7eN/Ueuwj2sH6Z8iLYipCZ60eGz2dV/nFwtlQQqlIwT8QehWE
 QQNadeeKp+UuJaoZckOos52FXpoye3qnn57sZbVcdUzRUGz3nKE8kG9qEmoYJiJv6eYNZDz12sk
 6Ol/UrFrkSjFUEGRSUad+FqrzE4UOLs9fM+z2s2cvwQ==
X-Gm-Gg: ASbGncuNWSGJPFPBZ/en/tfVJOTZNeP9Bx0wgzf9p2mTzvdWSW6QCLNZtJ9+MCZH0gm
 x2hV/7Bd4nWM8HOaUH03z8KL2AZTr0zau6epMClEHdSU/HraJkq5QcTnpt094MAt1ZI1nBzkeFd
 vK1w+GQtPrGiIR0TjbZFD6E6fQ+U2E+FnSlznEXUvhC/FrpF9o1jzWD5ZSRpAJt68deBtDOJR/u
 0WY96wm
X-Google-Smtp-Source: AGHT+IGIw+GRqgjbitxEbEjSdCljcGcC4OivjO9jhKtDzVQufjr55ANKJvc0cMu5Q6GxmffsBalWDPVDJMCfQmXX65A=
X-Received: by 2002:a05:690c:610e:b0:723:2012:53fc with SMTP id
 00721157ae682-723263b527amr43715747b3.16.1756733553293; Mon, 01 Sep 2025
 06:32:33 -0700 (PDT)
MIME-Version: 1.0
References: <20250901132639.1123726-1-mark.caveayland@nutanix.com>
In-Reply-To: <20250901132639.1123726-1-mark.caveayland@nutanix.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 1 Sep 2025 14:32:22 +0100
X-Gm-Features: Ac12FXz1quSnaWRsn_FolPtMmSWdoNYi2I1qi3-dUHs26AHr4RbNQq879FsNl0c
Message-ID: <CAFEAcA-XcyWQcX5b6ZO1CrsxqmbgNb9z_jGQN0tD06O5sdnBQQ@mail.gmail.com>
Subject: Re: [PATCH] hw/i386/pc_piix.c: remove unnecessary if() from pc_init1()
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>
Cc: pbonzini@redhat.com, mst@redhat.com, marcel.apfelbaum@gmail.com, 
 eduardo@habkost.net, imammedo@redhat.com, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b32;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb32.google.com
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

On Mon, 1 Sept 2025 at 14:26, Mark Cave-Ayland
<mark.caveayland@nutanix.com> wrote:
>
> Now that the isapc logic has been split out of pc_piix.c, the PCI Host Bridge
> (phb) object is now always set in pc_init1().
>
> Since phb is now guaranteed not to be NULL, Coverity reports that the if()
> statement surrounding ioapic_init_gsi() is now unnecessary and can be removed
> (CID 1620557).
>
> Signed-off-by: Mark Cave-Ayland <mark.caveayland@nutanix.com>
> Fixes: 99d0630a45 ("hw/i386/pc_piix.c: assume pcmc->pci_enabled is always true in pc_init1()")
> ---
>  hw/i386/pc_piix.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

