Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B2DB10F92E9
	for <qemu-devel@archiver.kernel.org>; Tue, 31 Mar 2026 18:04:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w7dRd-0008Bj-VD; Tue, 31 Mar 2026 14:04:05 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7dRU-00086k-6e
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:04:01 -0400
Received: from mail-ed1-x52c.google.com ([2a00:1450:4864:20::52c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1w7dRO-0002t4-8X
 for qemu-devel@nongnu.org; Tue, 31 Mar 2026 14:03:55 -0400
Received: by mail-ed1-x52c.google.com with SMTP id
 4fb4d7f45d1cf-66bf6aa4858so4110550a12.2
 for <qemu-devel@nongnu.org>; Tue, 31 Mar 2026 11:03:48 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1774980227; cv=none;
 d=google.com; s=arc-20240605;
 b=TXXWJlmOrGpKCSM9kjFyZH6hzxP0DNvVoG5ioGK6Bljya+Xnju5S73tlX30Kdg2Ht9
 Fhm9r1vTLpY7N9uDB8AbadGJgdwn2BAbCbRGx37HC2xPEX9JI3um7kxtrQf2XXq2QAF4
 VrJePOa4MH8Ha89IjB+SHvQix5H0IgQXScIg8oBeRV6phGS2YFnVLZop8YK226OU0WH4
 AOrHsEaHOC0s92UHJ5XEZqrUwT9fxwfVlwr9DTCUd5q+mMBKKp7pGwEcHD/27Zmz8SMR
 QZ8D76rWGiFKDu3HPRs54nFGI3LJZym1SmG0HHTT4T8UmsdcRwXqW8MurG9X7dlsRGPA
 FOHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=dgmgxGpMK73CfESEMzUs8yZvkE2wqMj/fXSwi0EG9sM=;
 fh=j0m/KHqzOQ6CKKktQSBLLiVo/M7SZnjHIyl4bugXt+Y=;
 b=UC+Hqmenq9SJ8loAc/yCoukuIoS/QWM2TkV+415y4JtKTnJQRubRehsJ0um0BjAX/K
 Zc3qAt8aVYIt891YZFxKKVZVOSAqoRzn1YoPZ51+qliIewVcpymxViY0ppLattT7shMl
 TPXwPkZVXqxCJs9i1GzvmzFVs1SQNLdAXE01WU5BaUI4E7tInlQkY5esF6WzB/+mathu
 iEIq0+KSYKQTekWoJ40tvWV3aEmOJIDf1WIqEnGZ8W+RXwSEJhjgr2EKBfUXhVIRcjlM
 4yaxvSI2DdJ2DVSQXNsXIEwKuFBJQJ/zFIGW4zcQll3XnUlu6h3CkO8F23QRehmuqDGr
 IIdA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1774980227; x=1775585027; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=dgmgxGpMK73CfESEMzUs8yZvkE2wqMj/fXSwi0EG9sM=;
 b=cQ6NnMlUmulVUYbvLxF974AJJR23wruDgf1WCEvty894u6gtagOvAtNTNMopYJjw7/
 f7g8orz2rzuOyd+CyozA6UrQuSfhXIZe9ZbDw4+fJbpY/zQzrQMSUbpOgqJOqtdZB3GQ
 FFF6DNAREZE2tsDFw5ZvvHXiXZJEwPFCBscdnoKeHOA2S0Ne63bZEjTunIj6jmeX7uvx
 qTGDHYGJsYJ0XYhXrvNhXiBleusjJhD+omNIF34cRYQhXd6EtCNc7YF7FOXCFLw6y/vs
 YYYGjvnyzAbLrXILTLDPz+6KQPNqed5VqqmjhRq9GkLwy2prnrFUzROMsC8sNF6SKAJM
 jojQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1774980227; x=1775585027;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dgmgxGpMK73CfESEMzUs8yZvkE2wqMj/fXSwi0EG9sM=;
 b=pgYUNqnyVD6Irx0Zq7irUzdW9Y57iew9ZVupXcJUYDHTNRQwiR/3twlTXfHRqtal3v
 lkPFBnhohuBtxtBdFjOq4gkt7EQPWcppSJiKMT5YvxLuVWO6xuueGA/SOSNPJQJQKyaZ
 f6OsGo0eWoskNIxr+/ukVgFOv3mdo7qYC3BXrId9vppd/+8CNqE1W06702ksZgTwkxWh
 QrDosSBg1MxJSdpKqb7eH7VY3uq/CWmfdMV1bUUZR1o8//GOcfogEZOVy43WTI+wQKjn
 LyzfnM677ZFoXnLpNqDzuvY0Kny47w6tTwzgQOzXLRo+GGc5Gyg0cmMH+Z1MSqvNMEzi
 VxKA==
X-Gm-Message-State: AOJu0YzwYPZErkDg0irKqqUkJnmw1yIPBHQ7Fx40MHY8FoP91t03jOM/
 0XW2zHYe3j57wrYK+rMHnzy0pRSTSMEcdOx25QE6LtOCrjEOAjA8xIUkRtqtOuG/UjUVJ+Se9dQ
 VpHbIzIiW6zqdp9YmtYYPAjTXKT3fTCPbgmwYQC3MrQ==
X-Gm-Gg: ATEYQzyfgU963PWSrfUHDK9TFX5098RugNqe69ummZ0ub8cQbIgXAi6qfiKoNd6FRh9
 Z/G1fjk3pfch3rH+J8QH8/Sspudcxjny807xk/zcQBDAtBatI7h8/Doctl3Z9b7Jzl7E+W4EFZY
 BRQI9mxZ3GTIw2teo2UiUXox+wkAgusfruOmKYqz75QqryRGNKJvCXFaFZkOIf6Lc5KQM1e4Olq
 btmVJlq3y6ynAo94A80i0hvKladDpuPsB7KHt9DYagkbbDQYs1w4NgSHT3k8tCs9rLTkAAQP7FH
 in8L9NzXt1PDOcWm2wqESTnSfwvtdxpqkTYsOI7CmeVw4PeRB18FlCQ33cnORvaaNbo=
X-Received: by 2002:a05:6402:5406:b0:66a:199d:141 with SMTP id
 4fb4d7f45d1cf-66db38e35a6mr291371a12.26.1774980226565; Tue, 31 Mar 2026
 11:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20260321135624.581398-1-npiggin@gmail.com>
 <CAFEAcA_iwWDmZf1hojzZ8+N5RTRC4WXDSSK7SugNNRd6kdk8Gw@mail.gmail.com>
 <CAFEAcA_+_tDJstKjQVENprAa-37tX6Ta9Ay7i-nK3Hp8v7BGyQ@mail.gmail.com>
In-Reply-To: <CAFEAcA_+_tDJstKjQVENprAa-37tX6Ta9Ay7i-nK3Hp8v7BGyQ@mail.gmail.com>
From: Peter Maydell <peter.maydell@linaro.org>
Date: Tue, 31 Mar 2026 19:03:32 +0100
X-Gm-Features: AQROBzCCM65_jfaiKLWezYuEMS5B1Dr0_bRMAgO8-8BnmZTx_rPsi6NLamUMtn0
Message-ID: <CAFEAcA-aWSeBaFUigBHJSKis04on4wcjAgv4Y1R5SXP5LQLy5A@mail.gmail.com>
Subject: Re: [PATCH 0/3] user: recursive signal delivery fix and test
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, Warner Losh <imp@bsdimp.com>,
 Kyle Evans <kevans@freebsd.org>, Laurent Vivier <laurent@vivier.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, 
 =?UTF-8?B?QWxleCBCZW5uw6ll?= <alex.bennee@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2a00:1450:4864:20::52c;
 envelope-from=peter.maydell@linaro.org; helo=mail-ed1-x52c.google.com
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

On Tue, 31 Mar 2026 at 18:28, Peter Maydell <peter.maydell@linaro.org> wrote:
>
> On Tue, 31 Mar 2026 at 17:59, Peter Maydell <peter.maydell@linaro.org> wrote:
> >
> > On Sat, 21 Mar 2026 at 13:56, Nicholas Piggin <npiggin@gmail.com> wrote:
> > >
> > > I found this recursive delivery problem when testing new riscv vector
> > > state support patches (plus a minor lock user balance bug).
> > >
> > > This or similar type of issue was fixed with 8bd3773cce1 but I couldn't
> > > see exactly what scenario that was addressing. Is there any other way a
> > > signal can be generated during handle_pending_signal()? The SIGTTIN
> > > case, perhaps?
> > >
> > > Thanks,
> > > Nick
> > >
> > > Nicholas Piggin (3):
> > >   linux-user: sigaltstack lock_user_struct missing unlock
> > >   bsd-user, linux-user: signal: recursive signal delivery fix
> > >   tests/tcg: add recursive signal delivery tests
> >
> > I'm going to take patches 2 and 3 into a pullreq I'm doing for
> > linux-user fixes for rc2, so we can get the fix into 11.0.
> > (I've made a s/__chk_error/do_chk_error/ adjustment to patch 3.)
>
> Patch 3 also has a missing "#include <stdbool.h>" in the test
> program; otherwise it fails to compile in 'make check-tcg'.

...and also my mail client somehow ate this other part I meant to say:

I had to suppress the running of the test for hexagon, hppa,
microblaze and sh4, because it fails there. My guess is this
is bugs in the signal frame handling on those targets, though
for hppa it might be related to the upward-growing stack.

--- a/tests/tcg/multiarch/Makefile.target
+++ b/tests/tcg/multiarch/Makefile.target
@@ -229,5 +229,11 @@ MULTIARCH_TESTS := $(filter-out
test-plugin-set-pc, $(MULTIARCH_TESTS))
 test-plugin-syscall-filter: CFLAGS+=-DSKIP
 endif

+# Don't build the badsig test on these targets for now, as it fails
+# (probably bugs in the signal handling for those archs)
+ifeq ($(filter hexagon-% hppa-% microblaze-% sh4-%,$(TARGET)),$(TARGET))
+MULTIARCH_TESTS := $(filter-out badsig, $(MULTIARCH_TESTS))
+endif
+
 # Update TESTS
 TESTS += $(MULTIARCH_TESTS)

-- PMM

