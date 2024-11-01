Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2131AE6F07D
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Nov 2024 19:09:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t6x0J-00067G-10; Fri, 01 Nov 2024 15:08:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6x0G-00063x-DQ
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 15:08:12 -0400
Received: from mail-ed1-x536.google.com ([2a00:1450:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1t6x0E-0001r4-GA
 for qemu-devel@nongnu.org; Fri, 01 Nov 2024 15:08:12 -0400
Received: by mail-ed1-x536.google.com with SMTP id
 4fb4d7f45d1cf-5cec8c4e2f6so206412a12.1
 for <qemu-devel@nongnu.org>; Fri, 01 Nov 2024 12:08:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1730488088; x=1731092888; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=0vtiMNhzKfUFAqcXulxp6DAOe+CmXOMpBwel/k0P/TI=;
 b=kdRALoIRWpPCz1w3KOElBvQ9z0wy+lHFutysiS9xoSCRmqOMwX9IqyUr8K8fwGcH6h
 V7n6lIxWfwY3dkW2JnaerMG1xjvJ+b7R3Za/aAlIxACzX/o3nlJJRSYVEb0/B0u6o6tm
 SwiqiWmZV6ZkbdcyEY2iUr1Lbi4jhQezu6V2cMtR244giDWbVtN8j396Q1lA/nysYD5A
 seBNI1cFLpNxNA/aOi5UOGwV7ILKrizQi0Hn54fIfSjUVgmnmRq/6kg2033u0bBQ26ok
 +TBbDW7LVUnv3ap6+JQLcEtSNGiDidY1AtmDKCaFDAYTYax0aMqerCv2bEFcuDRLFBt5
 8ODg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730488088; x=1731092888;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=0vtiMNhzKfUFAqcXulxp6DAOe+CmXOMpBwel/k0P/TI=;
 b=hx45wI/aVGeqnJl1WMFA+vdaAsa9JW6Is9YHbG+vX6w5TgUEQpDuwzYXEe0W7oSaWe
 ifaK3FRfSHPNPuari5Rn9fQUqcX+ATUxNCELcsKu08K3q0hPI3kUeIOOrTetJMYfpcho
 RLmHe263Vy33ZpXSc6xr3p9io6aRoo1Q1QED6oJj6Ytr74fF7eKoWK2j05qVF6J/Xgtu
 DEHpOB5R0qZM0go5Z8sN7M+eurmZqaj3b7b9ZRb2HEP3yGcrucYfkyaRi0NjWy9YQOin
 LF5uDKoCWrtLAR5yYREaR4GYkwT2Rl6lqH+bBALHJ2z3CcS+G0uMIBkerXuOQD/zefPf
 ymMg==
X-Gm-Message-State: AOJu0YzD8ABt+DVFb5LoxRKs/ElmnexzA4SruWTYmTZTCnq0fShIq3bz
 w5xHfoiN/WhMDG8el4nmK17dDt095S3NxLdGG5EiYEWnm/ydT0++bzplazNUf+u+1gJHPK+NN55
 h/MMfhbELqTPNkwvWZHe05lfV4e022XzK91mfFVe4BE5OJumW
X-Google-Smtp-Source: AGHT+IE5xI9Sb9wJU9tVBPO7DDcJF08I5b6Q9+zBwP1ury7UjgzJndjyeqtN7J4hkHBKgO7yTm68XgQwcJ/Pr/xLs3A=
X-Received: by 2002:a05:6402:d0d:b0:5c9:39d8:58b3 with SMTP id
 4fb4d7f45d1cf-5ceb935c4f2mr2718636a12.23.1730488087889; Fri, 01 Nov 2024
 12:08:07 -0700 (PDT)
MIME-Version: 1.0
References: <20241031174832.6574-1-thuth@redhat.com>
 <20241031174832.6574-13-thuth@redhat.com>
In-Reply-To: <20241031174832.6574-13-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Fri, 1 Nov 2024 19:07:55 +0000
Message-ID: <CAFEAcA8eQdD133X66a=0qxsNaOiVYpmi3PfGXK-CkOENXLWXaw@mail.gmail.com>
Subject: Re: [PULL 12/14] tests/functional: Convert BananaPi tests to the
 functional framework
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::536;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x536.google.com
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

On Thu, 31 Oct 2024 at 17:49, Thomas Huth <thuth@redhat.com> wrote:
>
> Move the BananaPi tests from tests/avocado/boot_linux_console.py into
> a new file dedicated for Banana Pi tests in the functional framework.
> Update the hash sums of the assets to sha256 along the way and fix the
> broken link for the buildroot image from storage.kernelci.org.
>
> (Note: The test_arm_bpim2u_openwrt_22_03_3 test is currently broken
> due to a regression in commit 4c2c047469 ("target/arm: Fix usage of MMU
> indexes when EL3 is AArch32") - it works if that commit gets reverted)

I think that the patchset
https://patchew.org/QEMU/20241101142845.1712482-1-peter.maydell@linaro.org/
should fix that regression.

thanks
-- PMM

