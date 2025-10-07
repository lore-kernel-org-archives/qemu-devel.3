Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BE72CCA476
	for <qemu-devel@archiver.kernel.org>; Tue,  7 Oct 2025 23:00:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6Gdr-0002yq-9U; Tue, 07 Oct 2025 18:58:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Gdn-0002yS-IK
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 18:58:44 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1v6Gdg-0000do-Bt
 for qemu-devel@nongnu.org; Tue, 07 Oct 2025 18:58:43 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-b5507d3ccd8so5572410a12.0
 for <qemu-devel@nongnu.org>; Tue, 07 Oct 2025 15:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759877908; x=1760482708; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kEjEmTrg9TRN6I0WIxmlrpHVf2AhqAuPdkgv9TzyxqA=;
 b=XCDNaCCPngLGeMT2lKopwXyBSllB9pdnTeFJzMHYc97tUjGX6M47rLKUBGYh0APWzM
 G+z3ze2VqYtmm74NT+Y+32Z3yY4wZwfF48H77Zf8EbxW7QGdoLWXiIVOWb0I0HemI7t+
 w6X/PqbjS1Afh0eJh/HeSQb0c0p+njIJyh8SHUyQXAU+Jz7nr2214GH7krZTjfWJAGo+
 rr/ZKppmvDWuZP7xaaNnUC5kskp9JG0khgyVeAL1kgh5sx3EPpEqFzU87JpDMsyb1YCb
 D13yd4tLo5uJtLlwDlcS1HoyYeXfYMWzhwgmomcXAXoaapPk1IfqXDk2bwtJV8NnMnHq
 Ipzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759877908; x=1760482708;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kEjEmTrg9TRN6I0WIxmlrpHVf2AhqAuPdkgv9TzyxqA=;
 b=wKsd3YL1YH0qb1FwKQoRrEm0cu7vWl0Re5BpdkH6HvL/G7hzh70tTPlYVZJiv5bMae
 QQztiPJhA+6V/2Tunz9uLhPr24VkH9nky+10L7nFqMyf8o2uBe/f5nR5BKJru/p/VqC3
 Bdb61bK5Fz0iA9k0kla2KQC320YxfgVjhh6EcIenIThL0Z6YLSLC6G7WsrYYm1u4cU4O
 5kl97YjK0P1Pxhn6GdrBb2XaRdw6lZQesfnJZg8XsJ+FDc5PoEnQAFcKfXQb7TLHuY23
 dDtLK6gNFUj8v1D/Qh3YBK7l78gLB7mqf7g/50MX5nlJS0friWz1kffTuaJoVT05SVUS
 iQCA==
X-Gm-Message-State: AOJu0Yy+ch3ZFwvrZoqs4l9VONTRv3PDJFTXsQP33rm5IuEfYjLm/aAf
 sWb6lgB+3IO8WJoaPqfenkCJLOWnvwBs3DcMKDW1Q9ABmZxt9tm/HruVJ/rseqokhS1qDj4eOOh
 CuFP1
X-Gm-Gg: ASbGncsMmijMXAhtmqFqRO7n6f7uWc7zR/+PWdaVKLWBySzVfPKYjk7Ti4hPgfpsczg
 ZijXYirww7s1wxPT9yZ+z/8Pev6aQldXaFCE0CeKCaPFqpfiAlkCxGj2YerkBtftatg4N0+Byo1
 fegyQt4FY0R/G7RDlPAB+jgRMH3K/7SnrophpVkNMjJuMbhLtUoPDvX/aymzcLJX/SBiTG/Urxi
 3+6frayXAwNYAs2DF1WvsHlTc8sjrUc1BnjGLVUGhgnFTgISRVNgBO8ANLiAbDLiH3WmyUrfF6c
 yqo62R4D2Mh+1Ozfx1rfW8rfVUeyaH6686RDrLtpkMnnAqTRzdBoXxtWx6zRYmIBJneah7Mf2xC
 6DNow9bSfwO1J78o2nJ5lowdYIZc9/UMmY1zuw1sIWnLMIAZQ3G6781OE6xkyEswRMfSrdA==
X-Google-Smtp-Source: AGHT+IEnY8dqpM/UVhDLpMsmRkb/3v2b8fbEo5aCYvnrYg7jq29PYB+9dHSuIdpA2aKT2zflbuVOqQ==
X-Received: by 2002:a05:6a20:7287:b0:32d:a476:7075 with SMTP id
 adf61e73a8af0-32da8139470mr1471442637.23.1759877907716; 
 Tue, 07 Oct 2025 15:58:27 -0700 (PDT)
Received: from [192.168.1.10] ([172.56.105.179])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b6099ad9573sm15841748a12.9.2025.10.07.15.58.26
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 07 Oct 2025 15:58:27 -0700 (PDT)
Message-ID: <38fccd90-57c9-4566-88bb-8f5e0232b34f@linaro.org>
Date: Tue, 7 Oct 2025 15:58:25 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PULL 00/17] testing updates
To: qemu-devel@nongnu.org
References: <20251007115525.1998643-1-alex.bennee@linaro.org>
From: Richard Henderson <richard.henderson@linaro.org>
Content-Language: en-US
In-Reply-To: <20251007115525.1998643-1-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::536;
 envelope-from=richard.henderson@linaro.org; helo=mail-pg1-x536.google.com
X-Spam_score_int: 12
X-Spam_score: 1.2
X-Spam_bar: +
X-Spam_report: (1.2 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1, DKIM_VALID=-0.1,
 DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 10/7/25 04:55, Alex Bennée wrote:
> The following changes since commit eb7abb4a719f93ddd56571bf91681044b4159399:
> 
>    hw/intc/loongarch_dintc: Set class_size for LoongArchDINTCClass (2025-10-06 13:54:50 -0700)
> 
> are available in the Git repository at:
> 
>    https://gitlab.com/stsquad/qemu.git tags/pull-10.2-maintainer-071025-1
> 
> for you to fetch changes up to 41f8f2be27736192bab29aa38380c9ebaae810fa:
> 
>    record/replay: fix race condition on test_aarch64_reverse_debug (2025-10-07 09:15:45 +0100)
> 
> ----------------------------------------------------------------
> testing updates
> 
>   - tweak .gitpublish base to origin/master
>   - restore .gitmodules to qemu-project hosts
>   - drop 64 bits guests from i686
>   - update aarch64/s390x custom runners to 24.04
>   - tweak gitlab-runner registration method
>   - make check-venv dependency for functional tests
>   - replace avocado's gdb support with pygdbmi
>   - remove avocado dependencies from reverse_debug tests
>   - ensure replay.bin doesn't loose events after SHUTDOWN_HOST_QMP

Applied, thanks.  Please update https://wiki.qemu.org/ChangeLog/10.2 as appropriate.

r~

