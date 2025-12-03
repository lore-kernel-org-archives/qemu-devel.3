Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57694D12D76
	for <qemu-devel@archiver.kernel.org>; Wed,  3 Dec 2025 15:04:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQoN5-0007jy-2q; Wed, 03 Dec 2025 10:02:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoN2-0007iN-5O
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:20 -0500
Received: from mail-wm1-x32c.google.com ([2a00:1450:4864:20::32c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vQoN0-0008U3-7q
 for qemu-devel@nongnu.org; Wed, 03 Dec 2025 10:02:19 -0500
Received: by mail-wm1-x32c.google.com with SMTP id
 5b1f17b1804b1-477ba2c1ca2so78217085e9.2
 for <qemu-devel@nongnu.org>; Wed, 03 Dec 2025 07:02:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1764774135; x=1765378935; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=YKDhGlR4MkvzY9+6K7yYOr1ESASqvVFWovzzGx7HNbQ=;
 b=bYx3LGD7dCyDOiBi31bLufM6Y+ZitBUDGYaCgc5FxVcOjW42Iz4cpqo6GFjhpdIpfR
 5f7QXKLQGyIGw5GVQYgurdOU7PIZojmo8BgKFDRBfN7boGjUxadpqwA57N9iY2Db55sO
 /I3kcGCsc6Cr1HhcIde2HFn8Us05jeKkgXCx1lOxbo0LqTqvrDCYFOK1ZwLdoG6brgAZ
 ouqFkVIMNrA6ek5B8m7FShF6x13Po70YDjKZU85su/ahet7vv15tik4+Y9zFyiaMf66f
 eN0++X2V3bivVSdx45HJPXovIoGzrlAsB9LaCosvRAAeiJRc+dbd6arLA+efyJygIoFM
 B82Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764774135; x=1765378935;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YKDhGlR4MkvzY9+6K7yYOr1ESASqvVFWovzzGx7HNbQ=;
 b=ZW0ifuGK3TZFiGCMpgWkeM3xismmuvJw+WzEan1AJlOZXH2uJmFerxuY/B3Ig9MlfQ
 zxbsF7TclJg7Ia3P9iYhEkIUa9fhqIHOFNHP4Mz64P9dyOsO2ItLAQfcbo4LCzNYZOS1
 cdu8fDnjQk5RWbQYQRcY8U2usndY1dFukdp9IqJWKQw1SwKTQ0hXWopYqUZKMXt+Tc1I
 UZm9lj+xHfhjtw4hAW/w2vQ8tQgeTfz3Cgh8KKEr7IAPBobgU4jbR4MpiuhC+xArT0UG
 vj+lYMrXx3R7snZ7aIPnRsRhsy4h698DWLubWtvw+tIzwSwhRb63jF4uU709cjIAmr2+
 hAhA==
X-Gm-Message-State: AOJu0YyrioAX85n3HyAnh/NeVrH8Q4MScrxWUgkAPOMAzMYPq3HylcSs
 8KQozn2tqZiiZX/X9N6LnmsUtpp+hdlREFQYr6gB0ZCnkaWn6xTFKl9cTYXfyLJB5Tw7l02ECnd
 52clJdSU=
X-Gm-Gg: ASbGncst4pyxfQUudYX5cUkfZQZ7+D4390L1VbpGcmT3vHRZ8tUDAJh3ln3A7f9mcJC
 8wqU71nAN++q+fycQ4e6xwV63pFLO4AM9qdus8Ufjdqe7XZkMkOpdnnhvqxWPkJKJC3I603de/5
 S5X+ZLNPK1x1qfko3/6XiEQxyqwgjykh3/EZJFY1w7lBlvPD1SgYVU7HVDY+crPg5NHhBofB1Mo
 6gJcZbRxvffMyRs5OQfcmKmY+/Tv4/YnzIAiYLO/jy/A2Ko7ct144uYUvPipuTq09mVo4228lnx
 vi8omG2cFlN9OfYMKo5iZOpNl5WunaniW74YCeEUj2eDmkeuJwEgnPUHMD8iPD107a+uLzj+5da
 kbyzyDknPVzanuJmZlFe48RZZCgmRDTaLKuc/4CQwiw0BDG96Pz0rLe3HgCHci+Numc+REbiOpk
 vNQNiw8+Nncbzan9kNCR8xhKu5EBF/JwsjujFl8R0ORgQj+qjql1DK8gtbKJ+6
X-Google-Smtp-Source: AGHT+IHf0GuyTs/yi6Af14DO6iSyQKsL9y5YkjcBMRrO5Dk0nmY34WMsju3lNYAkM0KcExXKvH1Vmg==
X-Received: by 2002:a05:600c:3ba3:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-4792aeed06cmr25825255e9.8.1764774134871; 
 Wed, 03 Dec 2025 07:02:14 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4792b178959sm20034415e9.8.2025.12.03.07.02.13
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 03 Dec 2025 07:02:14 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Stefan Weil <sw@weilnetz.de>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/3] TCI fixes
Date: Wed,  3 Dec 2025 16:02:09 +0100
Message-ID: <20251203150212.66098-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32c;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32c.google.com
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

v2: Split 2nd patch in 2 parts to ease review (Phil)

The first patch fixes an abort running qemu-system-riscv64 with tci.
The second patch fixes a make check failure Alex noted vs ppc32.

r~

Philippe Mathieu-Daudé (1):
  tcg/tci: Move maybe_{extend,free}_addr64() functions around

Richard Henderson (2):
  tcg/tci: Introduce INDEX_op_tci_qemu_{ld,st}_rrr
  tcg: Zero extend 32-bit addresses for TCI

 tcg/tci/tcg-target-opc.h.inc |   2 +
 tcg/tcg-op-ldst.c            | 222 +++++++++++++++++------------------
 tcg/tci.c                    |  19 +++
 tcg/tci/tcg-target.c.inc     |  14 ++-
 4 files changed, 140 insertions(+), 117 deletions(-)

-- 
2.51.0


