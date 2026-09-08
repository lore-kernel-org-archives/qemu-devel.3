Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE167C79F9E
	for <qemu-devel@archiver.kernel.org>; Tue,  8 Sep 2026 14:56:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x3xFJ-0007xl-RR; Tue, 08 Sep 2026 10:56:25 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xFG-0007x5-PI
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:56:22 -0400
Received: from mail-yw1-x1132.google.com ([2607:f8b0:4864:20::1132])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1x3xFF-0005z2-B1
 for qemu-devel@nongnu.org; Tue, 08 Sep 2026 10:56:22 -0400
Received: by mail-yw1-x1132.google.com with SMTP id
 00721157ae682-855a66e5b5dso37010847b3.0
 for <qemu-devel@nongnu.org>; Tue, 08 Sep 2026 07:56:20 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788879379; cv=none;
 d=google.com; s=arc-20260327;
 b=Kl50ve0Z7h48roxaZnC2b1jw3DrTyc0a02C/25H3HTdHNxIkFF3hz8hdR63pFiLLsM
 OmOEpGxtgijWqVMEL5OuosodRD36bpAa7lj2Ge2zEASIwBHrpYc8VJ+S9xjKKR3YRlkP
 dd5wqyHU/QDcVsoRcep5RK1unIbOwjmlGSLiXl8AbviLR5/4+V8TEnLDYh0XnpufDW/G
 euy9EMeqMK6Rnvl/pL9XcPVvle9srqtMIUghQCbwslyQy80ClkrKRfBDGbVOpPtp6VVk
 WBgzpfKks2WEZg2ua5Y7/55GCLjDoZUc9U7mN6hIvPmLQKNgtpwfzoCiVVvHjAvF95/+
 Jdeg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=aea30uAJahSyrjD6axRQL0jLi+7umrAFeIWrCDGKvvg=;
 fh=ieLaz7e/0RpAqfE5XLQ1RcBHWjTUv1z6arE2SouQh04=;
 b=cYfmtNf/bB6xYRvR/rsuDDiC/SNZ96soishANACD2exqX676+OsldsBaVmXNjfzI+Y
 UfV/QGFxFXZWgKMhz2Fmm8TWy6N9BgAmMruCsKQk4/otAOp5U1GYTwqSnWdhxlJVtjQF
 0vePploRPsE4pEnErXXXaAMQGg1GiiHzSnEYzQebd/4+v6CXnOvWR2/qZF/rTQ4PazJy
 cyM/bnRDqj2gTWKiuUziToUZ86vYq0k/uh2e2rcDqaH+ApxWS6N7RHabrDvi+I360D7n
 MeC/RnI7tEwaYjdPcK174Px5ryvQw83SHS/BKQPsk2nmby7q0nfn0SAbYtfF0VflhDF9
 gB2g==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1788879379; x=1789484179; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=aea30uAJahSyrjD6axRQL0jLi+7umrAFeIWrCDGKvvg=;
 b=SEouqArOWmrUhbkvQrm1Nvajm5p8T2cWlX+4q9ZZVzsnfjOb0rWa8l8vBJwjwEcp5S
 SkXcTGCpYRyGCbJPkf658Pf974tTp+MgweErMqGxbuuA7VOvWwABUOX9Muy9revjyLyf
 RYRW7X/o1eSeo5EQe740OqILSH5f9EEDvi4bWpXLiGfz8hC6IoH8eTuVCYg1MLlRd4lU
 3ppo/+ouBhQnnFLXIa2sFTb9njtq2/oNx2uDxTCsityi8fU88f4Ti47ESqsw9KJgLfgE
 9Avn6rX1G0A19wsETnQl+greKR1U4CxXgD48JrkJzv6ISNWpN4uU8pbPZRTTO6Kr9Puz
 Achg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788879379; x=1789484179;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=aea30uAJahSyrjD6axRQL0jLi+7umrAFeIWrCDGKvvg=;
 b=rsUBn3nUG0gg59dFn3HpqiTdSVLNUdWXJuEggNRRvLpW9t1fY5Zw12KgDy9jZBwKu1
 9Qk9Z/I+LTrA28QZd5xkzdtYm4641M4Ekv5XAE3Tb8/TZK+8yrSecsBubEGhGfDaVmp/
 q6RFxhdWNefNV9rm7vPNs+LgksyyYgOgbCC98gf0zQ52z0noSXkWAMhqetj93d+nil9T
 lwlsGagnp7DfIxzbN5LBWWeo5oBP+HBnTbhTGooDkkOo5xriZmjjh5wTMDwGCvNemBya
 9Fr5UmFyWjQ6E+4lm/w0/Tp9HcrUZP6x8GjtmTu/WQarQYs3xLqDOxZEqVWNrM/3c4Nz
 y/ng==
X-Gm-Message-State: AFuF++kqjqoQIO8/AHKqFntxWJpreZ5qLvAKMafKZtfXrlc2BXHiyhVB
 XXH6cLtIZ+fVOmutEhahc56uWk9ux8ZKkGglITth9oYLS64jEkUzG2eCpcIEktcQ4EibDCCfa1+
 F+APEjSFV7xt4eY/8SWHvV11CNUq+dXwNu/TMloT+Gg==
X-Gm-Gg: AYBFou0pSZxhjf7MpQ1meGn6tnfpL3nOXBuV4QHaYP5MNjnZou7v1A0ZFowBm3M0lmP
 wp1bIv+IFSK8wOmkw2bj0uGnjyWAgrX5+uL4RvndIJ9KmxbEBPzJkn3e04EzjTP+A1WLntTtZm/
 f3FqSvFSHyU0rEkRVqjrZ2J99S1XZ72DvwtMNJVukVkZgMXX01D7PfJjmPEpP6uG2xYiTGRAjSL
 z0QAVgVBTwxoYRTzljG10OWaRoMlcINLtin/xoSaLPvAPsrjRhmAi1dKQy6kuRXxLZb74S+fuPz
 Yf7LT0ucLiXUh+jXhPoABJOM4zk45kBMc5vIhDB/0e8xFqytAv9Hgt33wc7Bt5c1OXe8r5Jrgld
 RtZzOHuMLpzuNcc+WC7RCXaQOgJgK
X-Received: by 2002:a05:690c:d86:b0:873:ea3b:6c5d with SMTP id
 00721157ae682-873ea3b7835mr87908117b3.14.1788879379168; Tue, 08 Sep 2026
 07:56:19 -0700 (PDT)
MIME-Version: 1.0
References: <20260902122646.2848464-1-imammedo@redhat.com>
 <20260902122646.2848464-5-imammedo@redhat.com>
In-Reply-To: <20260902122646.2848464-5-imammedo@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 8 Sep 2026 15:56:06 +0100
X-Gm-Features: AcwNN1UK7HulAKdpMuERQzHuu6Leit53q_JD_3iEf5AOnqtFX8-EqOAIQB-oZyY
Message-ID: <CAFEAcA-+FC-uBwYr8KNhWN7SWzRZ3Q-EsF5bK-5F46T7toWuNQ@mail.gmail.com>
Subject: Re: [PATCH 4/6] sbsa-gwdt: rename sbsa_gwdt_update_timer() to
 sbsa_gwdt_wor_update_timer()
To: Igor Mammedov <imammedo@redhat.com>
Cc: qemu-devel@nongnu.org, leif.lindholm@oss.qualcomm.com, eauger@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::1132;
 envelope-from=peter.maydell@linaro.org; helo=mail-yw1-x1132.google.com
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
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 2 Sept 2026 at 13:27, Igor Mammedov <imammedo@redhat.com> wrote:
>
> The timer update helper computes the timeout from the WOR (watchdog
> offset register). Rename it to sbsa_gwdt_wor_update_timer() to make room
> for a separate WCV-based update helper added by a following patch.
>
> No functional change.
>
> Signed-off-by: Igor Mammedov <imammedo@redhat.com>

Reviewed-by: Peter Maydell <peter.maydell@linaro.org>

thanks
-- PMM

