Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33B62CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 04:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1unrRc-0000WT-OW; Mon, 18 Aug 2025 00:26:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unrG3-0005nC-ND
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 00:14:07 -0400
Received: from mail-pj1-x1030.google.com ([2607:f8b0:4864:20::1030])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1unrG1-0002Bk-Ul
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 00:14:07 -0400
Received: by mail-pj1-x1030.google.com with SMTP id
 98e67ed59e1d1-32326e7baa1so2886362a91.3
 for <qemu-devel@nongnu.org>; Sun, 17 Aug 2025 21:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1755490443; x=1756095243; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=o7DezmuwfjbPRIU2hYkSmLkMWVfXQ4fggw3uYW+YQzI=;
 b=PqBztlNuM9xlaawq8px0u+vIMpvcys4JF5NhbyOrE/IuFTUV61qIJlavq9l2LTA0MH
 cKNDWMIx+l3zX3wPhcm7Fp9bFLAzz9s1Tb/IQA9lXSMG266doMQa1epdLq8HacjlYHkl
 Lk+k/gwlpAudkiol6TloXaQ+KxlCEOOhcYw1/xCnHbQ1kkFxzVpN9QhGbHn8FRGCpEfX
 piW6urKQkhDeeqTSnGbe8wJx/Ir1wDPgXkWgdMvqLfPfPKiwhmrPq+/ag2ds6XF96gRt
 UawRRHGC/SpWXA7jGPhcI1DY12XWVovSSozniTw9AlSOC1FQ/ZI88RuSajVmO9Vn/sUs
 K9Ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755490443; x=1756095243;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=o7DezmuwfjbPRIU2hYkSmLkMWVfXQ4fggw3uYW+YQzI=;
 b=qjL7z76woUqTDgAJmBqrHN2iZ7BNEsBIkWAqNd7FsRhGmDCG/aG3LodGLizi4qRf7r
 jkrpjJamxCnX5+aJXoTUWnstzoa8KAwaLRVZz5PeNbhT79aiW7mUeNpmwPnxPxt/I2Q0
 8wFZ8e62anc0+Q5VShchhVSkNOkcDfJv9RmGHvAPcBeiv7jGeK5BYYel7Ytw8ajNunFC
 e7opNlHrXeDpC/UVxmBgPmM3mPkvhCIfbazCOGLdLjEVrw88Fr9YPLr7q99aAfFxSV1w
 E9nT68tLzi50UzyrwOjS1o2FzDEh53Rf86qd9b5nc0XlaNmKMvL1eB5ss8Z8eQFeVD7c
 mhFQ==
X-Gm-Message-State: AOJu0YyyFfky60czws76rlRMF7N3aRhSzc71z6nF0as7WreiHw1pIXhP
 yVaAvsIYGKE918ZJV+r5asidoFyOjdcNyHII2LgCxTkgIHj3qdY6I7d8IH05Qdlil6xWOtufK9J
 M8eIK2gE=
X-Gm-Gg: ASbGncs9vfKHWYjLEASLXWfhy+B4s5Eyee5Ll5+slSyyuwZvo2Fy4XxF8RtpdwkMc8r
 /7tYB4AS5sctbEA5ClH9LbEGJiepm0l3lf/JQy6H4oQeoFI7MOJjJbk3i/CM7Oy97PEXABAgihq
 1jaYx7rXt4hvg6tvnV9yMTCadojkXFuwtHNKydMi3ijVK3ApgOY5h7FlckBTtrZ9TjqHg9hll4c
 tuHThD5kBxkVH1doBpn2p6pTvFqQXCYMfp6saF52X+4W420Y1MnC/aQn/C28/zlCZpnsox2p7/5
 PpO0xfe9lln88jgGXivnyE/uudQAmkhsaDVWTeSV87W4JVBPVbOe548LvIcFKk5/Jjva7VLyPsv
 WXf9i8dYjJf6rbMGqiela5u/qAJ4jyN+DClbsbfDf3in4OJ0=
X-Google-Smtp-Source: AGHT+IGKjweePcn2HRKhrvWC2ZYQ1F5nagLzSElu/nDR/LZ6sLs3vN7iobRQjB/d/VBXNMWx3ikMFA==
X-Received: by 2002:a17:90b:180f:b0:321:c567:44bf with SMTP id
 98e67ed59e1d1-323421849b3mr14035859a91.29.1755490442670; 
 Sun, 17 Aug 2025 21:14:02 -0700 (PDT)
Received: from localhost.localdomain ([206.83.122.207])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3232f8c8e4bsm5498344a91.2.2025.08.17.21.13.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 Aug 2025 21:14:02 -0700 (PDT)
From: Richard Henderson <richard.henderson@linaro.org>
To: qemu-devel@nongnu.org
Cc: mads@ynddal.dk, agraf@csgraf.de, qemu-arm@nongnu.org, philmd@linaro.org
Subject: [PATCH 0/7] target/arm/hvf cleanups
Date: Mon, 18 Aug 2025 14:13:47 +1000
Message-ID: <20250818041354.2393041-1-richard.henderson@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1030;
 envelope-from=richard.henderson@linaro.org; helo=mail-pj1-x1030.google.com
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

While working on other things cpregs related, I noticed that
target/arm/hvf failed to produce a sorted cpreg_indexes[].

I wondered if that explained the migration-test failure that
we have, but no such luck.  (I have no idea how to debug that
test, btw; so far it is still just a mysterious SIGSEGV.)


r~


Richard Henderson (7):
  target/arm: Introduce KVMID_AA64_SYS_REG64
  target/arm: Move compare_u64 to helper.c
  target/arm/hvf: Split out sysreg.c.inc
  target/arm/hvf: Add KVMID_TO_HVF, HVF_TO_KVMID
  target/arm/hvf: Remove hvf_sreg_match.key
  target/arm/hvf: Replace hvf_sreg_match with hvf_sreg_list
  target/arm/hvf: Sort the cpreg_indexes array

 target/arm/cpregs.h         |   3 +
 target/arm/kvm-consts.h     |  11 ++
 target/arm/helper.c         |  11 ++
 target/arm/hvf/hvf.c        | 230 +++++++++---------------------------
 target/arm/kvm.c            |  11 --
 target/arm/hvf/sysreg.c.inc | 146 +++++++++++++++++++++++
 6 files changed, 224 insertions(+), 188 deletions(-)
 create mode 100644 target/arm/hvf/sysreg.c.inc

-- 
2.43.0


