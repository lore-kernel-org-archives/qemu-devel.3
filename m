Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F7EC5478C
	for <qemu-devel@archiver.kernel.org>; Mon,  4 Mar 2024 15:09:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rh9vx-00067Z-MA; Mon, 04 Mar 2024 10:08:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9vw-00067G-My
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:08:52 -0500
Received: from mail-ed1-x52e.google.com ([2a00:1450:4864:20::52e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1rh9vv-0002EN-5p
 for qemu-devel@nongnu.org; Mon, 04 Mar 2024 10:08:52 -0500
Received: by mail-ed1-x52e.google.com with SMTP id
 4fb4d7f45d1cf-563c403719cso6327608a12.2
 for <qemu-devel@nongnu.org>; Mon, 04 Mar 2024 07:08:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1709564929; x=1710169729; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=6KQKSKheR9W/Hcb/4Zeri+kzTUNTdAuqyfUiIitit7U=;
 b=uI69B0TJtUgTgUnxgfOUEMTVJJH6wtS1DvQ1opWYniDwEYcuC477VMXnXFWZtdI+PI
 u3nByHGD6sOcTO1wr31BW+NMo+zx3XbbI+yhXlhtXmm+VwjxlqHGmoJD3Wg+GF75vYMX
 PGAOji6l4CQyLyxEjEzzSWvSPidBwtw5F+QyBe9R+sjGM+cfrlp/B0RjHlIdfepfqx4+
 CABMQbH1MucDFomdMjo/zJxD/osIHRHiJisZMRHgKD1Y9cAJRRWp2er6YYOnCC7WnsOU
 H9+CiqRqWAuP22IYyY1zeedWKMJR6iSQjFjq1/SLiKWDHXvm+HTOfMlLrsSB6XvrkgNQ
 VA2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709564929; x=1710169729;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=6KQKSKheR9W/Hcb/4Zeri+kzTUNTdAuqyfUiIitit7U=;
 b=pjs41PDB3OeGFoxqnUgCiLBXUyJ+4nlTM4zeGYduXoD80Q+qnkCFeyak48/CIJN9q7
 Qf7QppVgyewA3rrzXquokjtT75Zbv+RqrW0MIUreMIl+mdUNc0cqtdqLqK7P/bwfBx3x
 Kr+FHiZmE1dJGlUpwr6s6jLQ8aXZfysMt9sSSmYfad1sf8c1ozuq7SZVGxW7cE7w7Vfz
 KhB6VdYrSfkIzdzKJUsOByy8KoSpxCaYjLIqyT18H3b/PnC1Gg+r88tTB+HhpMS/M0HS
 vYkZ1YWVkoGGwCUByVDIkxSqrXyeS5V07NAO/3AbVB/Fb/0+4YR1DHZ0Z4jcmj0kiRrz
 q4sg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW9RrV7K9TOBzXEOjaPf8sN16cdPFYol5uNpwhATvFibw9mlCySf2z1G+MNrDYQIRz9ktpMvubhvAO7my1l+CGDIJPjlDo=
X-Gm-Message-State: AOJu0YxJ+R12pQBjhhe6r2zXqmcrUIGk1zEgaf1uMEPJ/QMGF+ZkoalK
 GusULVPOU2X2vK9nIHqdq1DLNLvzOX5hruXVX8bXEaOc4N1HXRMiPqLIHND8XQdgWUoHbUz2eDJ
 4jnZF19x4UlBxVAWD6rIeTHyfsxlgQ/AHQ0JgMapVCZecu4CA
X-Google-Smtp-Source: AGHT+IGmkQ01HKKfdCWnoqp6mR4rjwWyMuzQpsD/6cg0Igd6R2/OQF3TMr2+Jz2qOcTU8nIHLpdLRF8jErwPk+DJDHA=
X-Received: by 2002:a05:6402:2695:b0:566:9fef:1ee9 with SMTP id
 w21-20020a056402269500b005669fef1ee9mr8770820edd.22.1709564929360; Mon, 04
 Mar 2024 07:08:49 -0800 (PST)
MIME-Version: 1.0
References: <20240229204407.1699260-1-svens@stackframe.org>
In-Reply-To: <20240229204407.1699260-1-svens@stackframe.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 4 Mar 2024 15:08:37 +0000
Message-ID: <CAFEAcA9NSNVkZdtqF=aw=eB=MpsHTFoH6Z1CQtiabn5mme092w@mail.gmail.com>
Subject: Re: [PATCH v2] hw/scsi/lsi53c895a: add timer to scripts processing
To: Sven Schnelle <svens@stackframe.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>, Fam Zheng <fam@euphon.net>,
 qemu-devel@nongnu.org, deller@gmx.de, BALATON Zoltan <balaton@eik.bme.hu>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52e;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52e.google.com
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

On Thu, 29 Feb 2024 at 20:44, Sven Schnelle <svens@stackframe.org> wrote:
>
> HP-UX 10.20 seems to make the lsi53c895a spinning on a memory location
> under certain circumstances. As the SCSI controller and CPU are not
> running at the same time this loop will never finish. After some
> time, the check loop interrupts with a unexpected device disconnect.
> This works, but is slow because the kernel resets the scsi controller.
> Instead of signaling UDC, start a timer and exit the loop. Until the
> timer fires, the CPU can process instructions which might changes the
> memory location.
>
> The limit of instructions is also reduced because scripts running on
> the SCSI processor are usually very short. This keeps the time until
> the loop is exit short.

"exited"

>
> Suggested-by: Peter Maydell <peter.maydell@linaro.org>
> Signed-off-by: Sven Schnelle <svens@stackframe.org>
> ---
> Changes in v2:
> - update comment in lsi_execute_script()
> - reset waiting state and del timer in lsi_execute_script() to
>   handle the case where script processing is triggered via
>   register write, and not from the pending timer
> - delete timer in lsi_scsi_exit()

Other than the s/host/guest/ comment fix,
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

I don't suppose anybody has a setup with the Windows drivers
to test this on? (commit ee4d919f30f13 suggests that at least
Windows XP and 2003 had this problem.)

thanks
-- PMM

