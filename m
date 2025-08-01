Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4D46C87FCA
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:31:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvTB-0000HR-Ub; Fri, 01 Aug 2025 15:31:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtsK-0007lk-60
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:49:02 -0400
Received: from mail-yw1-x1135.google.com ([2607:f8b0:4864:20::1135])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhtsI-0007F7-Ow
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 13:48:59 -0400
Received: by mail-yw1-x1135.google.com with SMTP id
 00721157ae682-70a57a8ffc3so20706987b3.0
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 10:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754070537; x=1754675337; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=5Kl4ZVYlzclb7C94ch0+3jyGf2Uqfeb2QPpQtDwJdPE=;
 b=bBq0gE+JEgMxlqGUNgg/ZpEAQPEdRT/XDconw/M6UaERVs1qEhlrsdlCSbwB6tmKze
 q5PeThJGAC6RBZUFDQ2XznXua0KkjMDy34kYqMLJcrIgWXxHL35jlnCW/FGn3Iui9fpd
 PFDQOjFgzHmJ0uApf5iUrYgXc4j5psdhQfuRVr+U4wZ9WrEsaSb8y5tNHXQWOfl1bghw
 Zvfzb6UndOJd0TSbGgUStdufbE5oQw/p8i9S0E2t9C2N+LLVnztTo5HanfN18CLEWmOo
 rQhnbkbsWR2dOL3JuX+y/wfDat4LGvxT05pzZcFlQ0kUQpX85SfWREMNt1+XiRLHE2qt
 2yWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754070537; x=1754675337;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=5Kl4ZVYlzclb7C94ch0+3jyGf2Uqfeb2QPpQtDwJdPE=;
 b=xQRL31qTviJAp9PNNiaqhhP9ZLz5Y0YWnG36aXVzmFUa2c47g2W03rd5qn3X0PVOJm
 dhW1Q1aAuYDS2I6pJcYzQmkQZmTZZi0JyUVqluu2K0kQKYOClhVX28f6bcdnQBfLnkUD
 w2zU08kx0beVookAfHVo6W03YWTxib6K8UJ9iIBHYoKl58Zp1S0C+z4A/yHQtX053Rox
 KDEU/D2uS+C+XHfJJDbTR1NPaG/McLpGKaWGWd55qehbrVCTZAbq6clwM4M78YsKysyh
 MmcQAadrpxZd6H5NGR2at+NmJqVRar2gXuMiDr0j2r6NlIpDvOMh1X8hJHXZ2LX30zyT
 WJhQ==
X-Gm-Message-State: AOJu0Yy0VGvxpp8CCRxOXbwYfLKjN4L2NAa0TbroX7GMDoJ3h7tcIS6R
 4l9Uhph3vWLbvHOIWE8JMLiAxKn/DsQOKSHh2+/QXgxgG23oFIVPj18RibRKMjwjhgqnUBKsmPU
 E1w8Duuzde9DBrBI5Bwoj725IwWOW5QHEFZa09bQXTA==
X-Gm-Gg: ASbGncudJEqB8+Qo6ZEIC5s2iFq54+mUxTeA9P/jV5E7YqH7sQmZ5+05QV1UEpbwHuI
 fRNFtYzLBUnEgbPm0ag5CGu10FL2KmZpBjoH+XjPh4q0Y3YUjMIdMbV2miUcvkSBwd9+LwLGMC8
 zbiaXhvDuLiqLnJucZqmZCoz9DpBhvm+nVHIUCGckXYtY5snYWUUPQYA1dnFITtS7ubbIQIWPHB
 +cbTHfM
X-Google-Smtp-Source: AGHT+IGx2NN40PUIF/j93dfDXzeFVcac22Y2p1tzjfLfGxhG+afGmmoTv57MpC0DDxqecPDLq/Or6wIpyxj9EPZmcFo=
X-Received: by 2002:a05:690c:6891:b0:71a:4550:8ac3 with SMTP id
 00721157ae682-71b7f7f5e83mr6579717b3.22.1754070537635; Fri, 01 Aug 2025
 10:48:57 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-50-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-50-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 18:48:45 +0100
X-Gm-Features: Ac12FXwoNy2t4Zyr495RgX_UHmPWjlRqENWVN1UKPdnIVf6n58mZfU78r7-2oZU
Message-ID: <CAFEAcA9CjcORMuUnZrEGuRBcxkBwhu+7oCmEZcZLmBoNWrTg6w@mail.gmail.com>
Subject: Re: [PATCH 49/89] target/openrisc: Split out target_coredump.c.inc
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1135;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1135.google.com
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

On Wed, 30 Jul 2025 at 01:38, Richard Henderson
<richard.henderson@linaro.org> wrote:

Subject line should say "linux-user/openrisc" for
consistency with the other patches here. Otherwise

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

