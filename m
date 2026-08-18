Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF37C5DF7D
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Aug 2026 14:03:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wwKPW-0001WP-AA; Tue, 18 Aug 2026 10:03:26 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwKPV-0001WG-CZ
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:03:25 -0400
Received: from mail-yw1-x112a.google.com ([2607:f8b0:4864:20::112a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1wwKPT-0005iz-Ro
 for qemu-devel@nongnu.org; Tue, 18 Aug 2026 10:03:25 -0400
Received: by mail-yw1-x112a.google.com with SMTP id
 00721157ae682-836cd7310f4so68156027b3.2
 for <qemu-devel@nongnu.org>; Tue, 18 Aug 2026 07:03:23 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1787061802; cv=none;
 d=google.com; s=arc-20260327;
 b=ECd/mIXfOPZ1lOuiW7VhEIvwe+arzzyfl7TFhHvG8vmtucZz3oG2cO7IHWhB5HnL3F
 iaWiwkEESuGt2ZiYSoMocCFjxhjPXxBWV7ZVTFdEi9FxEfjz27sq0u32tfvviHcwnj6J
 EHoG4sMlLiKPH8oruMiLzz/ogEzeXnUC5CkMKhY991u2hQ91LMpiOMcYkUV2m1eeNvDD
 5OUj8d4eNFA4/8ab9LtutpjvvLpQ7Z+zo3cntLVodKgrc1wuGaLd2HAYf4PFxINJrCQU
 ee+WpTXPnS4te66xFpYS1atI+lRWJuZpm868hxkKQDesbUkWOtE01kgfFX+6F1ki+3+S
 z1Yw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=xqmSH7rKhXpyvcDkX0xmdOYeOqzlvueBooi8CP/oDWQ=;
 fh=eMDsoceTh+qEKGXg87odlf9TUI1qcdgjK+uqGVUsplE=;
 b=jOkS7rXfkDnbrDDFG+aaDtOz0Yz4p64cqzOHP7TPe4JeNN5MOhC/tPvZX4XOsmj9hD
 bk8TnQ3vjDFhxttzQgNiYfN7WWGzvrjFI66ccU62Wml1ARLR0EtMRF/fWAocwuVvSD47
 cgvZ2e9KRSS7M8km31mlXk28So+5Zzzl0b60cWBcHpLasjg7LgDYZPWGTM1PR0VWNHPE
 rQLoy8BgzaQjW+tlYS0tn+VYhFVgrxFHo3BU3Q2v0ic8wI/Yq/zVWGAwhpkHhNQ+16O/
 cwuyP4/Up51/Ne/Kfn6obI9R8lCkp4/Btvc5WU21loYEAxid4Dzh5z3qh5EoainO8qVf
 Eixg==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1787061802; x=1787666602; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=xqmSH7rKhXpyvcDkX0xmdOYeOqzlvueBooi8CP/oDWQ=;
 b=SWabq2eNvFYM1LrYJtQRS7h0CjoxplpoQfomKg6zYg4E+MKrpofH8uJ6EhrPTX1IEf
 fe2uoNwdz1hbPCMxHxVYwXo5i/QtW+btObVzvkSR8g29qbzaiKoCL49L9eLpHxlz580V
 zDAtlXpFr9/ZU6Uii+jsnxTW0L+e9gFNx0TeK42GW6NujZQIfH9vsFMRpLhl5EqhJ6rq
 QmgK0SsJOfahHU/UZS3XlW4+7KH9IsXQMaA8gtMWpsViZ1k+BtSB472rbbKP1Mf3FX+3
 Zdi/JAy1QYjn0IQgYxkYqyEomZmyLopJCZkDB/hzdqfzojiB486jJEKDIPuvzYozlf0n
 cn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787061802; x=1787666602;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=xqmSH7rKhXpyvcDkX0xmdOYeOqzlvueBooi8CP/oDWQ=;
 b=LglRoou4aG7vP4Csl/KBJPm40x4NjRWattRI2huvEY3nTenSNEpeXnUzaRj8rdRzoR
 v0HRifenx73Z+5ZnjGvIG7AZSnTb47Hq2ucFIZXL20zlZeVzmmJslMGOa+gNN0dAt8CI
 +bst6hoseOaJJ5wJyop56nHxGsNCUFpFYCqCz7ba3jhapWAhwz6B8zvUny5AQI4ucCUk
 XP7DanE5dGQfs1bbr0g4wyWrM7hY2xvpUW/nV3crQhl+rtP6iUjhDUo0xRzfVGMX3YS5
 hlJw2iEsjCGfFI+CSaD8Vbrpy+cKT//ehI8hNUc66k+or31wym+N1IhlnesWDFAkdD2c
 aAKA==
X-Gm-Message-State: AOJu0YxhB9srwFJELm23YzfCfkXR1bZbbgZNWHuiwSQEz75eQNfBaIzC
 wGj7Ee8i82WXxQs0gJ/c35Z60RrCurexf2+zbTva/CO7HtzfXO0lW+dqPvxp8V9+ddxlqEBtTN1
 ep0044YKPRQnRyGRqnXBgaDRpPmAVbEgM1RqbO2Gmbw==
X-Gm-Gg: AR+sD12Y6XyDhhMyQlHjwvP85DDTWYseP0fim4m2gyPAl7klLD2+G4zeHinpJxWSqxr
 lZVrzbtDnuqfntJUpaA9cMwwrTcmfVzO41DpPtYS3FJZofqxetQZjdzVFj091E4r+0c5qU6ZJg0
 wnuZG9Mo72hA5DmOLYu0gIKL/SQI5e7fwVgLwkSGZ/ca4JnoUXAEY5Um4cM+uH6Z6zsDREjB/H+
 XEPI2RNR4UKSXoKAXrpcPc3P1EpWsvz940TZWI1tW234Pomh3ZwMob37GAsmQwzN8zDQWWyC5mJ
 oa91URsLS/Rw0trJ3HGgySmanPzxxMAlGCTGKardiFOxCOgLr5wCg4oV74HQurYkADTcQy7iiPI
 u2/ECKFJsPZIp/FP2i5tUIi623xz9Eg==
X-Received: by 2002:a05:690c:28f:b0:80b:9f4e:a70 with SMTP id
 00721157ae682-84131a3e483mr36809407b3.26.1787061802065; Tue, 18 Aug 2026
 07:03:22 -0700 (PDT)
MIME-Version: 1.0
References: <20240603160933.1141717-1-peter.maydell@linaro.org>
 <20240603160933.1141717-4-peter.maydell@linaro.org>
 <aee65084-b827-4ef2-9c3c-af40c5c5b0cf@oss.qualcomm.com>
In-Reply-To: <aee65084-b827-4ef2-9c3c-af40c5c5b0cf@oss.qualcomm.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 18 Aug 2026 15:03:10 +0100
X-Gm-Features: AcwNN1VBzMSC5ET-GwbElloUY5SK3gS6rg9yR-FrgevkgvTpCyA14hQZvt7_P4Q
Message-ID: <CAFEAcA-Kv+G14+3AVPgP+jGbogC8nARiiE7vsR8L+J+e2CmmgA@mail.gmail.com>
Subject: Re: [PATCH 3/3] accel/tcg: Make TCGCPUOps::cpu_exec_halt mandatory
To: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@oss.qualcomm.com>
Cc: qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Tue, 18 Aug 2026 at 14:35, Philippe Mathieu-Daud=C3=A9
<philmd@oss.qualcomm.com> wrote:
>
> On 3/6/24 18:09, Peter Maydell wrote:
> > Now that all targets set TCGCPUOps::cpu_exec_halt, we can make it
> > mandatory and remove the fallback handling that calls cpu_has_work.
> >
> > Signed-off-by: Peter Maydell <peter.maydell@linaro.org>

> >        * Return true to indicate that the CPU should now leave halt, fa=
lse
> > -     * if it should remain in the halted state.
> > +     * if it should remain in the halted state. (This should generally
> > +     * be the same value that cpu_has_work() would return.)
> >        *
> > -     * If this method is not provided, the default is to do nothing, a=
nd
> > -     * to leave halt if cpu_has_work() returns true.
> > +     * This method must be provided. If the target does not need to
> > +     * do anything special for halt, the same function used for its
> > +     * CPUClass::has_work method can be used here, as they have the
> > +     * same function signature.
>
> With retrospective, has_work() should be idempotent, taking a const
> CPUState, while cpu_exec_halt() is expected to change CPUState
> internal fields.

Mmm; we added the "should be idempotent" comment to the has_work docs
in include/hw/core/sysemu-cpu-ops.h, but it still takes a plain CPUState*.
Constifying wouldn't be trivial because e.g. cpu_env() and cpu_test_interru=
pt()
and so on take a non-const pointer.

-- PMM

