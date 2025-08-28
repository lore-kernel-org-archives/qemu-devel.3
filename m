Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE03C8303F
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Aug 2025 17:30:17 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1urgIq-0008BL-D7; Thu, 28 Aug 2025 13:20:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureP6-0000gs-Un
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:19:09 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1ureP0-0006sr-MC
 for qemu-devel@nongnu.org; Thu, 28 Aug 2025 11:19:08 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-71d608e34b4so9051697b3.3
 for <qemu-devel@nongnu.org>; Thu, 28 Aug 2025 08:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1756394340; x=1756999140; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=4Uu3EFZkNH2F5WmF0qq/kp2M8jdcpiIHDjfmFgCTkQQ=;
 b=rASBkcdFMVWb79kuKQOyJYwCK68fFq0fdRwtBurT/QFi7sBH1xPWl++6xIeoT5oDF3
 kDnbYaFqXM28WQMkzd05xCs8qmNxZ6j8AHDtjuYiMH7EJnBl7ePLv/87GiyyNH9wEVxJ
 +H5pXTo7VeO2UeRIAR+VwSmmK1GIMZ8mQiUIqt0+fd/szUaznnh738K9dXDQUNk5fDVB
 Pxt2mbH7vBn/mhs4s33Vygn/2TuZ8RBjU5FXmAZQnRWkEfytKnFmbcMdMq80vP8oEBql
 KFbIt8XtlTDsmn+2Z0UpS97ZW+mlKNStP8c6bWIzpeUv0opSuBF+doGTnUk5ibWn7pbo
 i2ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756394340; x=1756999140;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=4Uu3EFZkNH2F5WmF0qq/kp2M8jdcpiIHDjfmFgCTkQQ=;
 b=rxcQGmeKAmgKymLgVxOqchcSP1g1YMSirk5FBe1gLNblnIuPjGm/RZ0u/4QTvHwrvQ
 VDzl+75S3dnF7vP7p1gx1Q+db5JpXC1tlI4gKdtBEJ+xKIa7621dodBUOlHkLyOxZ9Ip
 WmAJ1LruKOfJ6xxbyywIogsPIywYcwpyGGOw6YdKeG2acavdmuaF3iIHIEX4nMxn0jIQ
 59e2gHu0Js/6bCp9tq4u3R9dlPcLsuox7uyFY3r87ZKps3+yU8/x+gliKQGRHlX6mzOG
 qxN2TDCloTkzcT1pBklHGI3OK6RHkGLfyTkGIkVYlwj1djSgH0Rliz5QOjfTDz84oPae
 yUrA==
X-Gm-Message-State: AOJu0YzBoS5LXhQE50lWcjgjwo3vuN91SAE3xOI0em2n9n417OsxDebz
 iFeRnW8I+ZEy3hoDVz4LScsTUV+1IVe71WFP0zZDXENcheFVZKkwESaIZrcpVNmune6v5YQvZEv
 eKpxKxOrL76drgIhnd6CYp+ToupRXhRcXdrausaCRCiTrWk9xLMcm
X-Gm-Gg: ASbGncskXlI3SnSNwJ56KV8I2uV31p5+7o0+8UpPfCX7gT2H05rqojH+nVfB+wpgnHk
 AsBHqux3H1AYB17bKQNbSAeDORhsI5nzq0A+aUPqjy7nXhmgTkbQxulac0shV8JLpI1v28MaMc/
 M9NXq73Wk8LvhwZN7Yog63g116lePyaP67TCgw5sWmv6juTc/JvKBH5qa7SYvzhdmD6uUnLK0an
 C6sg+79
X-Google-Smtp-Source: AGHT+IGYJkFwIpDVH3OiLxqB50r3r7E8lO3e1gS5KjMkCaLZBoj2bqML6QoYUALytk79EYySVc6WLP8wi7b/uatNc1E=
X-Received: by 2002:a05:690c:4d47:b0:721:6adc:4364 with SMTP id
 00721157ae682-7216adc64c4mr12656007b3.33.1756394340242; Thu, 28 Aug 2025
 08:19:00 -0700 (PDT)
MIME-Version: 1.0
References: <20250828120836.195358-1-richard.henderson@linaro.org>
 <20250828120836.195358-57-richard.henderson@linaro.org>
In-Reply-To: <20250828120836.195358-57-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 28 Aug 2025 16:18:47 +0100
X-Gm-Features: Ac12FXzAz8etXCZt3nKNkeAwqLZcIydkN6QzuiMXhYi2dMi7-xLuGhOyko_nELI
Message-ID: <CAFEAcA-4ZjcLAmu_d1kx4E71uGPqLDDbjuH7W18bbEWyQaiQ+g@mail.gmail.com>
Subject: Re: [PATCH v3 56/87] linux-user/xtensa: Expand target_elf_gregset_t
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::112a;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x112a.google.com
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

On Thu, 28 Aug 2025 at 13:14, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Make use of the fact that target_elf_gregset_t is a proper structure.
> Drop ELF_NREG, target_elf_greg_t, and tswapreg.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

