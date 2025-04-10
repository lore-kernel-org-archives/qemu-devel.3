Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FE89C369AA
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Apr 2025 22:57:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u30pB-0004Ky-Ez; Thu, 10 Apr 2025 18:56:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u30of-0004CC-RW
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 18:56:17 -0400
Received: from mail-pl1-x62f.google.com ([2607:f8b0:4864:20::62f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pierrick.bouvier@linaro.org>)
 id 1u30oa-0002ZE-0w
 for qemu-devel@nongnu.org; Thu, 10 Apr 2025 18:56:13 -0400
Received: by mail-pl1-x62f.google.com with SMTP id
 d9443c01a7336-22548a28d0cso19971875ad.3
 for <qemu-devel@nongnu.org>; Thu, 10 Apr 2025 15:56:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1744325766; x=1744930566; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=QjIu7/qZ5pK7+AKkntwNP9pN0X/CcwBU8WbweJ69aEc=;
 b=w5ooGFfISJ0cksoHUhTyFWpQFY9MKGru4EsS/OdWSfkVGy/9TTaUbhD54nhlj01Iop
 F4FBEedocoHkfWuj4xlB/tiXlEMPoOlsPl33JRuxelG2VoxnSeBaZyxRi3mApjrgR4hi
 5ZSBOGn3fpIcFAi/G+fofnSSv8SG/OjzHzUEQLNBMfufa4L6Lxvtm6Za/FldybUFxSK8
 /lV0dQ3txdy5xtt6yw753VrzAuvbl2xAwtZskTdKdMiBPJQ8D5CgVwH1pBgTN6HajfUA
 R9mfF7lQdrgvxmlAmgchz8QB3Fx4yhEiLCx9wFzMDZT3jaoeDzqzZXgca1y1z/cZK+i8
 bwCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1744325766; x=1744930566;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=QjIu7/qZ5pK7+AKkntwNP9pN0X/CcwBU8WbweJ69aEc=;
 b=fXtm2weDh6JvJ+kjvaeUK0mZjmXU6KDdFW383j7QJLlWanVE8nkbACep3XJpz7Kesk
 n/Al+ron7W4zZeboW/J0svjMoWEjfGm9shCOkPQ539EnZ7+V22B6RRfcQZV14wkZbHON
 T9ynd0l8zYY53a9o0Xibbn7D6xTRD/w9zzo3PWXxQy9B9avFVROYh71W/GLnFw6zf4+m
 8fqU/Wrl5QrMOy14gDd9qnj9nZTiJnVE592VROEPBA07ANixD8Qi+DnBfHzlHrOCGb5d
 hP/glvoJDCwFqb8rBmENUIdHMgkLAhP2t39ADFtPCMwW4pLzu+Sn1A/vNyARVGZTZDev
 IQ6Q==
X-Gm-Message-State: AOJu0YykiL6FRVTxUmZj4Bhxi1UDgE0pA7crH0/UfRCHuFyWAPegxOnn
 W+Grd/o5DDjEvIPoZWB5hb95LRdcyvqtTScflOTDA+aXQ/0ZaV/5PWz/yHKQ4APEe1yY/Doinx4
 BqPA=
X-Gm-Gg: ASbGncua+5ggPaFh33RoFz1NLM5QyxUddRKWtFeGJhTkZ6l+mT0kLxRw76/eA9eVRcz
 JSWgnvLheBdPDA0Dnbi3i+2jJZiDWH1pk1hZab3rmMUk1SE7u2+G1PnODgLsz2Eo1LbfeTl4UQi
 XpN2d5hfoheEGfVU5RUg62tTxZyjAx4RFpw9bGq1aSCoNv6XI6KDzpkDNuoLIysNk/uL8mOh5gH
 jXhmb4NlYXlnfx5qjooWIOXrb3vY5OZN09JiHpYdud1Icd6GGcdwZtLnkmUgLdAxdM1AKDvgy7O
 jV7v3xrGFDdEUBHA0EWTa6j4tCoLGQdx0dEfoPXF
X-Google-Smtp-Source: AGHT+IE65p9LO/uxC90TJh+p/HD5l/N0Z4idZlKAsB3FnfhVQwUkOHD6zZiPfk5A3zH5+rxxfhVmhQ==
X-Received: by 2002:a17:903:19ed:b0:223:4bd6:3869 with SMTP id
 d9443c01a7336-22bea4ab849mr9087845ad.15.1744325766414; 
 Thu, 10 Apr 2025 15:56:06 -0700 (PDT)
Received: from pc.. ([38.39.164.180]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22ac7c97228sm36249225ad.128.2025.04.10.15.56.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Apr 2025 15:56:06 -0700 (PDT)
From: Pierrick Bouvier <pierrick.bouvier@linaro.org>
To: qemu-devel@nongnu.org
Cc: philmd@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Phil Dennis-Jordan <phil@philjordan.eu>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PATCH 0/2] fix record/replay on MacOS
Date: Thu, 10 Apr 2025 15:55:48 -0700
Message-Id: <20250410225550.46807-1-pierrick.bouvier@linaro.org>
X-Mailer: git-send-email 2.39.5
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::62f;
 envelope-from=pierrick.bouvier@linaro.org; helo=mail-pl1-x62f.google.com
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

Recently, it was found that rr tests fail on MacOS, with a replay_mutex_unlock()
assertion. This is a recent regression, related to running qemu main event loop
in a separate thread, like first commit explain.

We first fix the regression, by handling the qemu replay mutex in the same way
we deal with BQL.
Then, we reenable the disabled test.

Pierrick Bouvier (2):
  system/main: transfer replay mutex ownership from main thread to main
    loop thread
  tests/functional/test_aarch64_replay: reenable on macos

 system/main.c                           | 4 ++++
 tests/functional/test_aarch64_replay.py | 2 --
 2 files changed, 4 insertions(+), 2 deletions(-)

-- 
2.39.5


