Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E16CC87FD2
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Aug 2025 19:50:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uhvlM-0005sQ-3s; Fri, 01 Aug 2025 15:49:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuF7-00043F-68
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:12:36 -0400
Received: from mail-yb1-xb36.google.com ([2607:f8b0:4864:20::b36])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1uhuF0-0003B5-J0
 for qemu-devel@nongnu.org; Fri, 01 Aug 2025 14:12:29 -0400
Received: by mail-yb1-xb36.google.com with SMTP id
 3f1490d57ef6-e8b3cc12dceso885474276.1
 for <qemu-devel@nongnu.org>; Fri, 01 Aug 2025 11:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1754071945; x=1754676745; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=7JmTGo/KyVbZds2is48qWAsFTZwo5rFrG43G7+Gum60=;
 b=aRb0bT9zm+mJ0hnJbW9APSqPfo0MYlrZFO8bw/qz7ES+jBz0+wYPr//hp45hjwY0ek
 N3gz5UbYFYdr69K20iS8+mcIoKYBdE7rzT0OKYDUC+Tui05za5sc60W94kPKJcS+vV6V
 AJhvNDxNd3dm7es5d6JnHLfhpa+4EXWX3SCM7zQKvmrJSEI6RuZzOoTrUcrMlIwTQuHz
 I0lkTXm2wdMvJhqMS0vOWMRgaTmeJqqbTJHj0u4pX/L8d4+UIXPmg6EFGHJ/clthzW/0
 Pc8my4THdNyJuK+JJ0YVjTjnW9WEgZJO8PwYIu++IyrrIlnKFqWnTBDkOfezEzVVVCkd
 +8sg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754071945; x=1754676745;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7JmTGo/KyVbZds2is48qWAsFTZwo5rFrG43G7+Gum60=;
 b=sRCHUXDncSyy2fiMW4P06SURCXR3FPhCQntWwpnZXR4drUKiH0uzeIZ3ReMnebE+Fg
 z/eaoltlmBi0o6h2671v+ghK4yG3rRTyOKLtJlHDUWVMhI/qsFMJsnwX2lhMvpCDO77d
 j+jlPr0PP79fLZLCUPNIlHsdUP4Elxv7XEMbfXYEvmu3BWNzdWiZ5g9qBUaXkhzgv5y+
 BZR4rJYEpBU1E4gyxqKp44d894FqvdizZUXAY4AQ6J+kzrqchZLcrfDRMjpk4CwCpOTj
 XjWFiPLTmd1fQYcxs4x2G5Tgq6qpVO9TVL5qGGXHSJR5lY+LeYQ5/7fWF5IiVi7bt0lT
 GeNA==
X-Gm-Message-State: AOJu0YxpzMa+1XF95I1BixBFMgEuG5s/iVGfG3PUPeAhfRB7aAvm9wJf
 glrsKMcfNaUguBkOetFjLtKVpNIvXBS2tOiF/5c6L04dMesZF6HmGYggv7SCAXPidVgiLp6gajR
 PRq5FHVTyHGXLp8+Htfvk2bH7aLJVHyma4mb3/fgANw==
X-Gm-Gg: ASbGncuSaOfRPVCe6sNY9/ZjdegI4NvoB/SdeeqkdIVp5Le8HRIM4PsbXdYGHoSJ7b6
 yc2V7p4qnQ35LasQ7dSSiLlU0nd+Wz1Ovqx1BU0Jas8UARGBFgB5FCOuYWwkT+tp12SPwx7k6Uj
 usqEBvCiFbiwXxWRc6fRS5qNOsZoG7NPjAF8qD6UPYZWbySEgRuUO4XZg8D18AWMLQkHQM9Da8X
 Q2J4Etu
X-Google-Smtp-Source: AGHT+IH0Pwn9bFp/qqpslZI3Bc23gRpamfA84WOPC6+q4rSFE2VPXiczSmqZ2+ereUfW9VUPT8PceLNZnzZYSPnS8JI=
X-Received: by 2002:a05:6902:6182:b0:e8e:4e3:7fda with SMTP id
 3f1490d57ef6-e8fee15ccfcmr747578276.49.1754071944910; Fri, 01 Aug 2025
 11:12:24 -0700 (PDT)
MIME-Version: 1.0
References: <20250730000003.599084-1-richard.henderson@linaro.org>
 <20250730000003.599084-61-richard.henderson@linaro.org>
In-Reply-To: <20250730000003.599084-61-richard.henderson@linaro.org>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Aug 2025 19:12:13 +0100
X-Gm-Features: Ac12FXxocAtb3v87cjHdGZA1N_b2JDX_OUnf2Z_SMHQy9RJ3MG45yMFOJvKn9O8
Message-ID: <CAFEAcA8Z2K-YTZDD6JcQSVpzryxWSLzBJOK7yG4PE8rp1A1CiA@mail.gmail.com>
Subject: Re: [PATCH 60/89] linux-user: Remove ELF_EXEC_PAGESIZE
To: Richard Henderson <richard.henderson@linaro.org>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b36;
 envelope-from=peter.maydell@linaro.org; helo=mail-yb1-xb36.google.com
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

On Wed, 30 Jul 2025 at 01:27, Richard Henderson
<richard.henderson@linaro.org> wrote:
>
> Use TARGET_PAGE_SIZE instead.  If the target page size may vary,
> using a different fixed size is wrong.
>
> Signed-off-by: Richard Henderson <richard.henderson@linaro.org>
> ---
>  linux-user/elfload.c | 21 ++-------------------
>  1 file changed, 2 insertions(+), 19 deletions(-)

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

