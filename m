Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A7137C19F2E
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:30:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnes2-0006rd-S4; Thu, 27 Feb 2025 09:28:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnern-0005XK-Ds
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:59 -0500
Received: from mail-wm1-x332.google.com ([2a00:1450:4864:20::332])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <peter.maydell@linaro.org>)
 id 1tnerj-0004uo-Rx
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:27:59 -0500
Received: by mail-wm1-x332.google.com with SMTP id
 5b1f17b1804b1-4394a0c65fcso10896025e9.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:27:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1740666468; x=1741271268; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=kJd1wUN2x5bfQR4Jfp0V/+z5Bg/vV6VOnXXzfjzia94=;
 b=pvEvbo5vCNSXH0G1RrTPCSyrK3ALxNvQcEOVheGkXv62bz7dqt06zSNZh+M5eIw49m
 gVpj4JD4EdqkO0lLOsnlIT39+nwnnvsNuhcO+dmXpD9NcJVsAF6mfdJTM1d8zMhNFf9D
 DrHMaY5sYFQnPiZlhiB8bDjb51RwSBaby5tB2yEwbz8qUvZ4kIqI0CCiJ8SGjgiMn9kd
 A/mFlVuphcH0lKm5L/6w8GRZJDnnCRqiJgFW5z7Hu8jJW/9GTgRk3B/DMywpksEGhsJF
 C6A6MqHE1syQLczVuAnt/Jop1lB/ZCOOF+pNl1Uf4Gngm7t2I2JTgScod8KuC9x+HqoO
 BqIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666468; x=1741271268;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kJd1wUN2x5bfQR4Jfp0V/+z5Bg/vV6VOnXXzfjzia94=;
 b=QgFTqMdOq1MRqhNLAYC75m8j+omfFl5xtMFf3AlwOxB0JhmNf9RvTjxEt/H5cwRNnD
 z5nUX3db6QXKoRoZrJQAebCCekXqgMA3MSkUSygEfRaJMk5QsOH2E1yTrlhXb09iMTCf
 wZPAmdgMMP6N9Fkn9ixb16Hq7nD2CJgMlwK92cHMfZCQpRTJisyIIqd+eWhhoF2JfMfR
 5/U8l9P+PDHBUjpwdou1i6kcb2pC7yAcUUJvC8zaQrtu+u5OWMhBOJ0evdjKuIRRAtTW
 xDGblg9q6sAvo8RlUIynsM84TSu5bnr25IF28HKfJy4CB6etI+wnCVtMoUNQlhBwq+j+
 jG5Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCVBhp17aRzQXCoN0JRETbZ78YVhKbLjlaikPEl9U3PeWvJ5j38pXdCngEROoRiZqR4G8rqzyaAx1vBv@nongnu.org
X-Gm-Message-State: AOJu0YyTiURfyYqR5jLWkNyy9B0TitRkjfa9QHXqtzDEw0Ib75cPfcwR
 vmz9GmL7El7XQ3hQ6JmY9r8X5rwCsdFUrV11LgEY5RD4oyz97TY9/o3Y+qfTuK0=
X-Gm-Gg: ASbGnctW9qjk7Jyz1VWwHrbDbYAHZQbVYKJMnb7P59RW4HZ8HO2uUb2Rd7cur6l78Ny
 JvOh2dMUv+BGBNd8+ei3jG5UHIvNGeoNxJl3P1CtEvsJgos0jd8MNgBrMz8YS3ngO8U0oMcrQlm
 0u6ivTWWGUvwzj1x+qMe15tl5SZKmgZEHwn4yxnYaAzCAQFfgW0tqyR+S0MmiYJtvUDzlyyvon/
 V6KcaQt5bdba49SZzhs3oNbjh3NkXhC/mkWUGofxAYWPp7Z4Qcg5d4oWGVJRa62adI27+32NHev
 f1hX0Q+X4ZIsl6dAUcIFEIMqsOlAd10u
X-Google-Smtp-Source: AGHT+IEcQgnMxu1rniBpYBo9WTVvKavGdK+erh3OAoRcRkRQJqJ2r5lzN5KkXMeorbqp8kqnWhggzQ==
X-Received: by 2002:a05:600c:154e:b0:439:a0a3:a15 with SMTP id
 5b1f17b1804b1-43ab0f3c907mr149526955e9.14.1740666468204; 
 Thu, 27 Feb 2025 06:27:48 -0800 (PST)
Received: from orth.archaic.org.uk (orth.archaic.org.uk. [2001:8b0:1d0::2])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43aba532b8dsm55968335e9.14.2025.02.27.06.27.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:27:47 -0800 (PST)
From: Peter Maydell <peter.maydell@linaro.org>
To: qemu-arm@nongnu.org,
	qemu-devel@nongnu.org
Subject: [PATCH 0/3] target/arm: Fix LDRD, STRD atomicity, fault behaviour
Date: Thu, 27 Feb 2025 14:27:43 +0000
Message-ID: <20250227142746.1698904-1-peter.maydell@linaro.org>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::332;
 envelope-from=peter.maydell@linaro.org; helo=mail-wm1-x332.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Our LDRD and STRD implementations have a couple of bugs:

 * if the LDRD address is 4-aligned and the load crosses a page boundary
   and the second load faults and the first load was to the base register
   (as in cases like "ldrd r2, r3, [r2]", then we must not update the base
   register before taking the fault. Our current implementation does
   a sequence of "32 bit load; write to Rt; 32-bit load; write to Rt2"
   so it mishandles this kind of insn.

 * if the address is 8-aligned the access must be a 64-bit
   single-copy atomic access, not two 32-bit accesses.

This patchseries fixes both of these bugs, and then cleans up an
argument to some utility functions that we no longer need after
the first two changes.

Note for reviewers: please check that I got the MemOp right:
I believe that MO_64 | MO_ALIGN_4 | MO_ATOM_SUBALIGN expresses
"8-aligned addresses should be 64-bit atomic, 4-aligned addresses
should be 32-bit atomic, less-aligned addresses fault" but I'm
not sure if I've correctly understood MO_ATOM_SUBALIGN.

Thanks to Stu Grossman for reporting the page-boundary-crossing
fault bug, which prompted me to look a bit closer at the code and
notice that we weren't doing the atomicity right either.

thanks
-- PMM

Peter Maydell (3):
  target/arm: Correct LDRD atomicity and fault behaviour
  target/arm: Correct STRD atomicity
  target/arm: Drop unused address_offset from op_addr_{rr,ri}_post()

 target/arm/tcg/translate.c | 137 +++++++++++++++++++++++--------------
 1 file changed, 84 insertions(+), 53 deletions(-)

-- 
2.43.0


