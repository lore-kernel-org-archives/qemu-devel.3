Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBF4A1061B00
	for <qemu-devel@archiver.kernel.org>; Mon, 30 Mar 2026 14:35:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7Dhq-0003UD-8l; Mon, 30 Mar 2026 10:35:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Dhh-0003L7-JP
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:35:00 -0400
Received: from mail-yx1-xb12c.google.com ([2607:f8b0:4864:20::b12c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7Dhf-00031W-AI
 for qemu-devel@nongnu.org; Mon, 30 Mar 2026 10:34:56 -0400
Received: by mail-yx1-xb12c.google.com with SMTP id
 956f58d0204a3-6501d242e2fso1576523d50.3
 for <qemu-devel@nongnu.org>; Mon, 30 Mar 2026 07:34:54 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774881293; cv=none;
 d=google.com; s=arc-20240605;
 b=A1xbLWAZot+EpRPWnBYeGgVMNMvhkxcLCfzho9Uid+Cs6XjxTz9TqyzGdcS8qbMAm/
 NWR9SxBKquoGSJrmckooSadO2FWYFLtqfNjFZlpgRxcD1Nzh1MGlI1fycyibqZ51LOog
 FFHS9klwiw+JXsjVpNHhVXEdZ32/VuulUVzG79BM3lFnMt1eNSk/0NCKwK4jvu6rg+v6
 cBtF1AJ3+DbMjkaXhjM0V3hlVCxSFzI0vE4Ac9QAXapcIbcN8ZJOZVV6SGSm7791ZU9p
 IiKyvs0z8j/q+a8i3ae7aVD1ZNHg4cFePQJHtAD8K6PRlHdnSR1+z1GrN5Oci2/KjdLN
 EdCw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=eGmC6ISR4eICpFRyQtInOa86aZ3GqanzfizPphF8LOc=;
 fh=B22JtR9ZUsXUrdiOg5Iw9LSBCcKra7oUC9BuSyZP/90=;
 b=EwNGyiGZvCodvrn3B3uXReoIYikJxoT0YzcdJ9FtUrD/VEXgS+tb7xp2nuRBPpftOl
 tYHSQLl1tcHzkds36vAobIeRCPWNso52KX7AhXY0aqHAPTjNVcxsR/QfoLurrYxTCFaI
 QNMaRrHaNB+P2Cs/tOIobP6ilERZFq7TUgrUDcBLT1oXm7zGrHibn4OUU5A8ev39kGgG
 8XErPMaZcqdP9FdL3YFcJCTfiAbXzU5I/aQ7CRcOHxYNV9THkGQYvjmD5Ozwq4jJDDGe
 ru+EufwO7aMDo4+lj2pTHRtslp9NfGtXNDf5Ma31jmIDTA/PRsX1BwXo4uCnslU2k/Gi
 9Odg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774881293; x=1775486093; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=eGmC6ISR4eICpFRyQtInOa86aZ3GqanzfizPphF8LOc=;
 b=ObopGxWy7uD/+4/D+aBYMa/fc9XNXeil0pQUgyOEt62JT/LdBgILo9GmQbanJYdLWt
 c88Q29qPLlkB7RsWzjI0+mUlB0QiokwN5ZLS7jC65eStkJRZzj8+AkoS/VCkubdG3Yup
 Nao7zY0EJ2MKle9kdg7EkqaciXZYfJnooyjQb1X+V3tFoG9rVvJY1l1LttxltStziEFQ
 R7upvQ3umquEFKJF+Q+MxIe+hjpsyNlX2IpEnz2AXLMn0g4bYs+bzwHexPYOjRqRQotZ
 nR/8Zkyjq+iSFJ158DCkRagPeDemIgPz2o0aeqW6LbVjeZErZAQC51NxWHb92rdHiIWR
 Mcbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774881293; x=1775486093;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=eGmC6ISR4eICpFRyQtInOa86aZ3GqanzfizPphF8LOc=;
 b=cY4dyrpInV+URvn2OKzaeNs3Lt4tx31VE7oP0xrqxNVJF+DRBbDqURDe1gTYs0Lovo
 yW2OTsuRn2A5eAqoO6eVv+eg7MgHzfDtLmQVl2mhLD5GtCu6d43Yc292TJbHcJ37/u2q
 QYWeTaD3kP4MlXd7deNQFvYc3SVemM2dy4Rm43PeH2f0e1Tw0HpXvVBF72GYJZtrxlBn
 re2sgyWs7aFP8uKN2N0+f5wSKLDLvyT0MKn+Ve42FCd4TgUFPhNDFBB3+TIg7k7oQ2wW
 5UN5HvWEgv0nzvu7TyBdlvmWnItYi/YvOn3s+LFqxmPSzMccByhCyvZ6RnWSxt1NcZbB
 AVeQ==
X-Gm-Message-State: AOJu0YxWq9+5uGFtLOpMkTGLdYdl4rfHoqCkF1M2890n48kFv1m7wtem
 GILrCwIOJ5M3y+YicoqNG99CZXwZZLNIjQXswpR4OgGquCoI0uh7hBEuhYRCOKzfqrO+17o/iHH
 KEcUgot8KYgIv1841a5b7o+67f31IT+0pFp6FO4C2vg==
X-Gm-Gg: ATEYQzyWrqRneGweeQRWDCpGXDO1jjrpvAtESulKaZXhVM4wAZ8VqCoSlpG9bANirup
 jF6PnMyAIO2IEhF3Gaj+DLogTv5TZuwVX+ukqYzSUExix+u7rBsx/y45XuiMhWOWe7a0x7PpMni
 T3MVCLYHufGJcUaqQMvlFuaWUpmP+n1uDFndhZuBeU4hZ24Dvizxp6UqF6pRdkP8f+WBwhKD1/O
 24344VvZNLRz5cd4TRoAaGzYz2ZNyatFPNUAbzNgg5g9E//Ir0tiqjUSZhhz5bqXSOoSNbDB64A
 ZER4Gtyt60sA/ogd0ucVo4G3SG8cIeGqhgU0rN6SyXdx+sZpA1JNUsUwP5Lk1GV0ovM=
X-Received: by 2002:a05:690e:138f:b0:64f:fc0d:6247 with SMTP id
 956f58d0204a3-64ffc0d63acmr13579361d50.1.1774881293329; Mon, 30 Mar 2026
 07:34:53 -0700 (PDT)
MIME-Version: 1.0
References: <20260330115017.256211-1-pbonzini@redhat.com>
In-Reply-To: <20260330115017.256211-1-pbonzini@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 30 Mar 2026 15:34:42 +0100
X-Gm-Features: AQROBzAAuEHpUbSkYWWmoLlGiIP54FlTH7KRz8nOvY6leINQiJ5H7_mDLGi7T9M
Message-ID: <CAFEAcA8DdyHM-5BOhWvMGHi=+g0HJ4jLw0AVaQ06s_3j8hUxJQ@mail.gmail.com>
Subject: Re: [PULL 00/12] i386, lsi patches for QEMU 11.0-rc2
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::b12c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx1-xb12c.google.com
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

On Mon, 30 Mar 2026 at 12:50, Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> The following changes since commit 91f6a9cb1b0f11afa74ef7fb20d5579d9dfbe020:
>
>   Merge tag 'qga-pull-2026-03-27' of https://github.com/kostyanf14/qemu into staging (2026-03-27 18:41:05 +0000)
>
> are available in the Git repository at:
>
>   https://gitlab.com/bonzini/qemu.git tags/for-upstream
>
> for you to fetch changes up to 0f254f70d4fcf668b27bd7c5970761afe13589c7:
>
>   hw/acpi: Do not save/load cpuhp state unconditionally (2026-03-30 12:14:22 +0200)
>
> ----------------------------------------------------------------
> * more WHPX fixes and documentation
> * hpet: fix bounds check for s->timer[]
> * hpet: lower HPET_MAX_TIMERS to 24
> * lsi53c895a: keep SCSIRequest alive during DMA
> * lsi53c895a: keep device alive during SCRIPTS execution
> * hw/acpi: fix save/restore for MIPS Malta machine
>
> ----------------------------------------------------------------



Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/11.0
for any user-visible changes.

-- PMM

