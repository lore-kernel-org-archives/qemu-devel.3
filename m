Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6269ECF8574
	for <qemu-devel@archiver.kernel.org>; Thu,  3 Oct 2024 10:21:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1swIH5-0000RU-5g; Thu, 03 Oct 2024 05:37:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swIEi-0000NG-Lw
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:35:07 -0400
Received: from mail-lj1-x22a.google.com ([2a00:1450:4864:20::22a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1swIDz-00016T-0k
 for qemu-devel@nongnu.org; Thu, 03 Oct 2024 05:34:59 -0400
Received: by mail-lj1-x22a.google.com with SMTP id
 38308e7fff4ca-2faccada15bso7851611fa.3
 for <qemu-devel@nongnu.org>; Thu, 03 Oct 2024 02:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1727947948; x=1728552748; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=keauJ5uKWDGk1vURGpPsSf3/hOl1FhrfQ4AArH0jO/0=;
 b=keVLk7ALan7ziK328t+6/jbIET68m9CazkCxNWucQWBfg0nj3v6is9fwa+ZiHFMV4I
 ST2vInmTv1GIc6oBmuG6sGG4CMYCl+ywim1SIvRmCZQToqioxbar9CVRLLXy+EA0x07P
 HuSXw74QrGvpovm61ZFdOJvXSnTil3/fTwdfHzpf8G0N7gbmS5DLO3s4I84nTP1Vb83a
 HOJgEnbViSgOMe5R+fjPMqy/pkyV7enwQVBs0yZBd75NznMTmT3kRQQVVpYk5fGAPXQG
 Ghgx5z1l2Ru5v4TJGFl2WqnpKLZhOibcVYEEMEZ2LeBFs+1sbCcs0FWJi3z5o/lglrJ1
 tSJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1727947948; x=1728552748;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=keauJ5uKWDGk1vURGpPsSf3/hOl1FhrfQ4AArH0jO/0=;
 b=sqLx/Ep97pm4VXVHG8ihOnaxqv0ghzzWJBz5bRu0MDjZe344rPu4SiGYITrRIfAFqK
 yg2dLdq2k5ns8QZ7YcJV0H6PjL5NL2sHEimOhH9ZMIUDaWBj2OPpENhfONSqJQg8rExS
 yUtCBdL3SK/iaLJ2toiFR53DIv1LGsIs9QQJC6qbf5UB7pM173a6cxVVy0NbmSBuR1Qb
 nsdzmjGD+7wM2MXVQBDyOuLCdLdo/YdO9waEEj74r5kWrltV4XxKErh4Ty6VO2MAEYvX
 Hq6+ucQ7aJr71InaNS7JCha7AtGoTPv+md0gQv0ULVbyVwD/R2Cxl9mZ9LEc28ywiJiM
 2JOg==
X-Gm-Message-State: AOJu0YxOChBp+BQWclroSME+RRrE2kyh0vRTGlfe5FuX+Z4NczKdQsSk
 ZXXutERupLAhgyq+ZcG0Ta3ZFK7aZg2ah7jRdtpcEdGWkl6y5XONjZH8S+jtDHbwyjrQAkiIa8b
 8B1Uz41DKlZXLbYrhOSWQda0UIMImj+JLzWU5fA==
X-Google-Smtp-Source: AGHT+IHSsvYClCg23lAg/JZ6Y7dGABSb3LZfg3E/Ovj9Em413KduCgq3Zh+i6aYKuRzRs6NV33YJQNqpUW/LLaxaO3Y=
X-Received: by 2002:a2e:515a:0:b0:2fa:c0fc:e3d8 with SMTP id
 38308e7fff4ca-2fae10e7f15mr26969121fa.38.1727947947755; Thu, 03 Oct 2024
 02:32:27 -0700 (PDT)
MIME-Version: 1.0
References: <20241002125226.282193-1-thuth@redhat.com>
In-Reply-To: <20241002125226.282193-1-thuth@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Thu, 3 Oct 2024 10:32:16 +0100
Message-ID: <CAFEAcA9FuJ4dJwu6oXt4Tkj-2Y5yg2i2c0OBBav8FQGOJX+WNQ@mail.gmail.com>
Subject: Re: [PULL 0/5] Fix mips64el CI job + some other misc patches
To: Thomas Huth <thuth@redhat.com>
Cc: qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::22a;
 envelope-from=peter.maydell@linaro.org; helo=mail-lj1-x22a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 T_SPF_HELO_TEMPERROR=0.01,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Wed, 2 Oct 2024 at 13:52, Thomas Huth <thuth@redhat.com> wrote:
>
> The following changes since commit 718780d20470c66a3a36d036b29148d5809dc855:
>
>   Merge tag 'pull-nvme-20241001' of https://gitlab.com/birkelund/qemu into staging (2024-10-01 11:34:07 +0100)
>
> are available in the Git repository at:
>
>   https://gitlab.com/thuth/qemu.git tags/pull-request-2024-10-02
>
> for you to fetch changes up to e5a007001824f9cde0db58cc960d4efcf1b93f27:
>
>   tests/tcg/s390x: Test modifying an EXECUTE target (2024-10-02 13:01:26 +0200)
>
> ----------------------------------------------------------------
> * Fix mips64el in the CI
> * Remove unused sh4eb target
> * Add an additional EXECUTE TCG test for s390x
>
> ----------------------------------------------------------------


Applied, thanks.

Please update the changelog at https://wiki.qemu.org/ChangeLog/9.2
for any user-visible changes.

-- PMM

