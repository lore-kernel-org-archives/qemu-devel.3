Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E19FCA0EED
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:36:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIR-0007QK-P1; Thu, 28 Aug 2025 13:20:24 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdhI-0006gd-CD
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:33:55 -0400
Received: from mail-yb1-xb2c.google.com ([2607:f8b0:4864:20::b2c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1urdhD-00083R-GK
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 10:33:50 -0400
Received: by mail-yb1-xb2c.google.com with SMTP id
 3f1490d57ef6-e96eb999262so632239276.2
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 07:33:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756391625; x=1756996425; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=QvRwGfIZpBEc9FYUwsPFl9GAOSGKzfV+sY2v7gLa1pmdVTt0VI56bh2xgoNlLTUh/y
 BxbGBbfkFp97ikCcUeO4z2H7ZiNrR3fIgdidk85NdHwSFdF4UlHQrMXUVTqJyx9LKyy2
 iULW38SarWGuFoeeCNGYC5QDN+GOciru2ajhT/QrrOthKfbMLzCXXxFKDGOsWCqQqEDE
 yGiTlhD+2VlPtdqrvo2Pho6XXPlT5AbCFEk+utM8V3SCVI/yfxJBJq+XTA2AfjWqUvdm
 143DjYuQPOATkjsRwPxNZ4ig/5KUuCtTVS8Q9sL6mOM4S1S7Um/NshXABVQs6w5OeL+l
 Biag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756391625; x=1756996425;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5hKop8A1AxZR6gYRUNJd+ddG/kwx4RbINvJrR4mJwro=;
 b=msaLvjbdQsZAdbPg9VpGZX2twL4jZExm0jycOCYF4PC2RHu9W/oNj+H0df7JVbQTXd
 5+P6MrI35gdajzArDpQ6ju24QaDUSS0rVpXMjNMdzDNMLcAKkKCIURieiA1ZTO//Zci1
 mIQ0XXxWRfSGuA3bY0hVuowv1z8WlAyj1agObt134Y+vI0sWQlsCKfvufJy5aHAi9dth
 +RR7lr4I+Pcynq2vg5Z3Yi/BnuBmKJvmHiXgUTVLRMJBpCBYHtshU+I4BoOBMe1yMRx4
 o4UAgHLVRzNNOR/4MRwjuJBjlSbAuNbackNvlg3HMyucGrbdB7Ntc1y/kJzOAoSaq2k0
 oUwQ==
X-Gm-Message-State: AOJu0Yw62lbY2MYuepF0xah6Yj2KmrOr3mD020CmX44YQAqsO0MI+dIH
 tGEUyXpTHa5CsLfdQ6Jyjg+8YWFXkcC5xwOD3wbNQbob7RnCPhp6tEx9NnENjMokFXqmDxzp1Bc
 o/lDl70OP3uUl05cgA5HuV7Sq21gmNtxE6yuqM+6PNg==
X-Gm-Gg: ASbGncuK0NRoN7KFLO4HLcqxiQtMiWpK3FiQQPLiNnFagsUnt91rRqwRmigvWzQyrSN
 1JLalOWyWVh1GC4DJAMaxQReLmTEF+o2j9hcJSOz2/n+UqBr/fXp+MQXVX64/DVDCzMlCKhISxB
 0m6zVrKmkhROfeVohJBrRCxpAERX6Yc1sELQO8rMWLn2Z86p1Htbd2pvUGUFZHXR5dTsg4VlkXm
 1alPtynZV5jxOiHilk=
X-Google-Smtp-Source: AGHT+IENoBHi2zW2Iu9QxMiEHvgQHBqM7//bd+AWOkYm1Xui+yjAXvHa2h68aTmzP+RXn9Jyzx5MxyQXdnwyiL0W+es=
X-Received: by 2002:a05:690c:311:b0:71f:9a36:d33c with SMTP id
 00721157ae682-71fdc41251amr239501037b3.46.1756391624538; Thu, 28 Aug 2025
 07:33:44 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-29-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-29-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 15:33:33 +0100
X-Gm-Features: Ac12FXxeUghF8yKnHXQy7LfnXjPKd4zpjM1VUAmNSsbvVbmWaMWM-1cexULOF2A
Message-ID: <CAFEAcA9zG46cZaR+CAM2dzHC7PwJ=-3wOPS7z178u9wC=1GFmw@mail.gmail.com>
Subject: Re: [PATCH v3 28/87] linux-user: Move elf_core_copy_regs to
 xtensa/elfload.c
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b2c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb2c.google.com
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

On Thu, 28 Aug 2025 at 13:09, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Move elf_core_copy_regs to elfload.c.
> Move HAVE_ELF_CORE_DUMP, ELF_NREGS, target_elf_gregset_t to target_elf.h.
> For now, duplicate the definitions of target_elf_greg_t and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

