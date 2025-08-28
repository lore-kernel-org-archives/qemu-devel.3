Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 45389C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:37:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgFu-00037X-EX; Thu, 28 Aug 2025 13:17:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdx1-0004h3-PL
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:50:10 -0400
Received: from mail-yw1-x1131.google.com ([2607:f8b0:4864:20::1131])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdwv-0001xE-BC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:50:04 -0400
Received: by mail-yw1-x1131.google.com with SMTP id
 00721157ae682-71d601859f5so8107347b3.0
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:49:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756392599; x=1756997399; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=mJ13lU8rE+BcYmQmfjnCJt4WaDRzZSp9Eq3hLvVCCUc=;
 b=AKGZyNU1/Qj6pFQNXGn6wvgX8djGnKfE0EVHOxuzCt0FkWhscLxf7BTvmbkNPItWX/
 cp8wzRJlhUsSalLLi+nJI456sver3Euf4w3T/wRpRBRjwB6hw9IuaTeC0+A2nQppWqf4
 GvvTX4TtgiEr8a0lQx3QFbAhAe3djlmircxsbzWrrR/m2OMSmH+KKdJRqQKUzzqcmqXv
 /01ACNAXITQDozTJtVtquWMS8p3x0jBvih2nALDMXBzHr+VQ4zQKrvqqM52QH7O+vsWp
 GPekB8hc77TxClEqrKb3E0VE/VvmdTcY2O+B8I6nEkYOQP9s6ockxstmhx2UR2o0K4Xs
 IFwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756392599; x=1756997399;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mJ13lU8rE+BcYmQmfjnCJt4WaDRzZSp9Eq3hLvVCCUc=;
 b=A7icCS8P2QoEca265ghKdTh21/0NYs8aERggLiXNaKMElKjq5O0nWf5U3+W8AAKLgQ
 AKI08tFBG453UIzVd2pKAByosDJzMBA5BqdgmvVJDvLAHh8T4XMjKuKzUrVmyka0PEsm
 6SPFsnfPZFvLOPNaRrGBNlJHbNFpxRkFWBb6ZTgNvkd11/DfydfHFPcdjyTPsstrDCV3
 zvZ8R/z+UCr1TdtXg1uOa1AZeXwx2Fw63+dZySHED6sWbFrp9bLTdRb7LUH/XNNH1L2I
 UoIVZYW7IK2DPW7iOv0fZRea0fnkPehleaizLXs8t0DMJW21ohOdwEbYSOHJLqkGH+FD
 U8eA==
X-Gm-Message-State: AOJu0YwTmb4DuQqt+LwrRm7YCFXyOI7JD/Mux4TMQbaw4EhxySMnwBbP
 4wNgkrBBwzLPnwrLDheZhvxj9JQH05/NfP6XFLOX5YlwKAhn86UCfrWP/MJu6wkLRsrXYMvzSwt
 Cr8FuTS3uSiXnIt9nbpzXDoSEyEojQ6boK80XozxFHhcNABXAuju8
X-Gm-Gg: ASbGncu46rV25QLqduqlgt2RZuwEgBPwL2OKJnG582OBuZo3+7okz3gvYYfmExizVJ+
 t+xtMZxvp6HKEpJ3SuenWfZqKENl5nqzadusaINC9APWAhC6oX82h8KfsUqRKtAn3SpfZ903jtZ
 Oa3fHM/WWqsgcbkUCWbWN5POudHb/ohpuGW5C3+mXaFj6Tm1EEK+fNay1Q5rc7JY1wvw/2f1zZF
 nGfrEIV2SkuquO1Aw0=
X-Google-Smtp-Source: AGHT+IFZaIVLXmC99P1PKT1Trx6fMEV4R0ygLZKxmx11oqajxkPei6IkjIQLWW+B4XEhevcagPLb76M4RjOgJhnS1k0=
X-Received: by 2002:a05:690c:ec8:b0:71a:2d5f:49b1 with SMTP id
 00721157ae682-71fdc2f0d76mr227478447b3.4.1756392598666; Thu, 28 Aug 2025
 07:49:58 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-41-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-41-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:49:47 +0100
X-Gm-Features: Ac12FXyk2rHp8r1KooMGAwYBOmk3Ak0w3gdb87vPJcz0vuFpqwffWLmRSBwH1sc
Message-ID: <CAFEAcA9miETsFRZ-8NRvoty9cJAPez=7V180iPeS953G9TRtRg@mail.gmail.com>
Subject: Re: [PATCH v3 40/87] linux-user/loongarch64: Expand
 target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
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

On Thu, 28 Aug 2025 at 13:13, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Note that the kernel's uses an array, and then it has a bunch of defines
> to create symbolic offsets.  Modulo some reserved fields, which we do
> not implement here, this is the same layout as struct user_pt_regs.
>
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

