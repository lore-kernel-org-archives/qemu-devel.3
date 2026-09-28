Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8893ECA5FA2
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Sep 2026 13:47:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xBBhY-0000re-T3; Mon, 28 Sep 2026 09:47:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBhT-0000pd-1A
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:47:24 -0400
Received: from mail-yx2-x0c.google.com ([2607:f8b0:4864:41::c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1xBBhO-0001hQ-DO
 for qemu-devel@nongnu.org; Mon, 28 Sep 2026 09:47:20 -0400
Received: by mail-yx2-x0c.google.com with SMTP id
 956f58d0204a3-674138cbe59so2149942d50.2
 for <qemu-devel@nongnu.org>; Mon, 28 Sep 2026 06:47:18 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790603237; cv=none;
 d=google.com; s=arc-20260327;
 b=gmb5efCQaGZZAeAzjkJa9HsaRunWbezgCBK9wg2qmvXGBpo52vPgSLGjGG3CtjdNZm
 3wYNrgt+QdKIGG8juIf1VLH47q2JeSyoCH1lk5Ax6YRi8tkCbSBKcE8/Q3VszJZ1MJXv
 Lv4HYKLT+Ozqv93ssAKeHioga/epSz5bWtdvmI0zL60QkWuH7ec6HQDHtsXsTUr0B3ye
 6frU4UMFd38zOSEZLfjOZ0eMNCIwcdyjCskDREcH4VGdewE/zwAoz3QqeAnC+G+13h0D
 h0y7NUu19U56Q1XzQ7PWZRgDJq1xxUTf99Cnno7vPk3ZM9Uvebt1yje1p8U1gMwrMajN
 +w3A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=D3EhREK3ZFIioeDYjJjTdCtC/aZbDyqG8MQ9EpA7BPg=;
 fh=19csRpazKedu9tRflGE64teBj66NPBVlHpICXacguJk=;
 b=Xe98sogLtK6j0vwG67OD+Wi2Z/jKfthevn6S644J3+cmWQvmr7Ob19TsWUIuENPy6/
 5Gvu3Hdg6Yj++DVVJif+N4C21XP3E8NGH5YmUcVniQoJX+FUyUPjjiopqud2nG8NcNY+
 EM64yGi3C7p/EdZFMzqsZw2oTYyScKRO80A9wLTu5G4LvNgxPQ12iDvrM8l35hQJRhQf
 7nsUPmfXXN9YsmRFQGna3ku9INuYdpItZrU8reYiDVc5MGZvVQsGmqUqNQqzxY+Qnqac
 /q8jl/dVx6vHbJVQ/VFE/+XAxz61xvSDqmeLFygX3bWnXjh53O0L27i3pA8ntCs7kmvA
 W8pw==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1790603237; x=1791208037; darn=nongnu.org;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=D3EhREK3ZFIioeDYjJjTdCtC/aZbDyqG8MQ9EpA7BPg=;
 b=weUNMWHwgbvxFc4Me6PtZDUAzMAcQDNcYrMoOVXUqye3cLMN6gOzYOEu/iyRXNAJKh
 J34Z7g7Zg1cs7ATQdXsatIBH+TIufT9m+KgUetljkSI8629U2p6GOBFpUwjpPJEJ11iU
 dw4K3Nsx11PCeqzgmv3P+o91T098SHcDzYq5vIrYb8uKfwhKY3rTi9y6V5EcAMkXwdxC
 h+MBBPQva6CYzTLd1e2flmagF9RF8SESEHp2Ml9+PagD9xgWZuqgRWU02t0DqUOZMYUI
 riwkUy1iP+JOMf1760iPONi1RZ/4enHPdVVJc65/1tdkTeNj4Fy2bGs1pmj9OqUkkQI1
 ahQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790603237; x=1791208037;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=D3EhREK3ZFIioeDYjJjTdCtC/aZbDyqG8MQ9EpA7BPg=;
 b=FhE7n16eWuuYE6lBmJLw6uWL+c/wnVf2coE+c1EqsTYH8/vwzl73tfwOR45gLBPG5Y
 UtSuzM91VDrXmZyVkiNzo7Nfl2/OGQvkU2jFuQ1dEwpMEBdu4spBsrVoUWiIEge3QHUE
 ZKlJDcRfxgkB6XlBb1qSRzWMzUxiPHdlCOWWUCf6l2U9dIGlctzWrXq+94jD8exSwuIb
 22xy3CiSLIZUgefYnwpGDkEVPRIHNA3slrQPDoAGbehrTgu+A4FT1janyDUEnf8IYHFZ
 ntulHBceYU1Ug/tYVxTMROSdqU8MmzLJLHHbPZ0UaKwq1wzInMJOMqTVqS0WXTSzp/yY
 lEZg==
X-Forwarded-Encrypted: i=1;
 AKwUvBylrXt9ihYHZyIVRFfyhCBHn4hf2U2jtKDDhhimk2N9UEN4Y20FG/wWGSJdEUg5dScOqU3qoWQ4UufX@nongnu.org
X-Gm-Message-State: AFq9FYJ/ePSoQ4UDPta7sH5Pz8jBJc2Rc/EOz8MYY+HsRiqf7tyhmnKD
 rDM7qhx/G/FXimQgXv8K1mJ0lchz8wsLbXMdPXrYRhsnpfr12//4/Y0sQ8tU36ezvJDow/JgaYF
 3Nn/H4qMzCADtFRbboziPbPD94qNNw7K2GU4acKdLJA==
X-Gm-Gg: AYBFou0iwWLm5I86Zw0icfsAiFlqnCXU2b30lxadjUxNofbqcIr3XHgv6ycgPsY82eT
 hTfj9YQnVLTwFex9STsEKAGmmBDNQJcl5w2IV795KBrBxbQwYC/cz8wOgM2RL7Az+ETLCpYWwgO
 rWYJziEig5VlhDj+I8BK+3rfav2hDxQeQqruSxjusvH9hK8oMaHbtOF87w9TyYMZUEb1MPSBOEm
 KsS7gANJcVITs2nK2vu04i+njCOlzLXK2RRBWxgt0A4dyD6K+O3d7m+exVL5WIdfICT4lUMVksg
 1MGmmu/A59B/KF0ewDPa5DgHqh+aSCcOCosEmyA2qko8GStV8dNCzYFohoerk9GL+ik/WvHWTmf
 I/bmwiVLDSWoBcqbJP7PufyOtaGRhcVrXpae8BPQ=
X-Received: by 2002:a05:690e:191a:b0:674:14bc:49ed with SMTP id
 956f58d0204a3-67414bc4ac9mr3058152d50.58.1790603237060; Mon, 28 Sep 2026
 06:47:17 -0700 (PDT)
MIME-Version: 1.0
References: <20260916165117.39764-1-sebott@redhat.com>
In-Reply-To: <20260916165117.39764-1-sebott@redhat.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Mon, 28 Sep 2026 14:47:05 +0100
X-Gm-Features: AclHuK_0cWJvuXI9w6ckERpSxL31YnHPnNaz6MLenPc9GBO34luEAup-VxU6JiE
Message-ID: <CAFEAcA9p9X0A76O1Dt8bQEfy4ZsOwXtK-fC1HQ=K4kzEQQesGQ@mail.gmail.com>
Subject: Re: [PATCH v6 0/3] arm: demuxed ID registers (CCSIDR_EL1)
To: Sebastian Ott <sebott@redhat.com>
Cc: Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>, 
 Alireza Sanaee <alireza.sanaee@huawei.com>, 
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, 
 khushit.shah@nutanix.com, qemu-arm@nongnu.org, qemu-devel@nongnu.org
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:41::c;
 envelope-from=peter.maydell@linaro.org; helo=mail-yx2-x0c.google.com
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

On Wed, 16 Sept 2026 at 17:51, Sebastian Ott <sebott@redhat.com> wrote:
>
> To support efforts to generalize handling of writable System ID Registers
> [1] this series addresses the demuxed registers that are kept outside of
> ARMISARegisters namely CSSELR_EL1.
>
> CSSELR_EL1 is moved within ARMISARegisters and accessors to retrieve
> and set the demuxed values are provided. Initial values are gathered via
> the usual KVM_GET_ONE_REG ioctl.
>
> V5 of this series was posted here:
> https://lore.kernel.org/qemu-devel/20260909144151.26803-1-sebott@redhat.com/
>
> [1] https://lore.kernel.org/qemu-arm/20260616132625.1732031-1-eric.auger@redhat.com/



Applied to target-arm.next, thanks.

-- PMM

