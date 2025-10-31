Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6216CCF9FF
	for <qemu-devel@archiver.kernel.org>; Fri, 31 Oct 2025 09:42:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vElda-0006BC-8M; Fri, 31 Oct 2025 05:41:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEldY-0006Ak-18
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:41:36 -0400
Received: from mail-wm1-x32d.google.com ([2a00:1450:4864:20::32d])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vEldU-000644-3D
 for qemu-devel@nongnu.org; Fri, 31 Oct 2025 05:41:35 -0400
Received: by mail-wm1-x32d.google.com with SMTP id
 5b1f17b1804b1-475dbb524e4so12193815e9.2
 for <qemu-devel@nongnu.org>; Fri, 31 Oct 2025 02:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1761903684; x=1762508484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=W/LUMLW07ydoPx9ukxpuiOkMSqsMaJR5YW6Qt7lCr7M=;
 b=juCELnEdksQdFN34EUUdB2cJZvS+lsC1n4IRo5ETMHmKW9rBOR5ioeOKRQmXV8p29I
 YlHXaXND1+zpb/YRAAwxcfD/42hcYjsVqWqsCOCZey9dBox/jqeRlpeXq0pyvp5NO8vc
 JMyq7GVrXOHvZ7r+Ix2D9bJM/aakmoP5Iuyu8ZU/mlTzvLik04hopV5UrCBx1F3PDpGx
 Dbo2vTcWgJ4TbRcM2+4IVOMLBEbwhY4cE78XEutSyjvIDJQYC2JyMgEW6BtFFVchamxu
 G1qx9iCItSDRieyO93X1GOHlgYMGUjW0u8cdLxbSXQ8zpme+rmY2Rm1nnQkFa6fpIDOR
 XGvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761903684; x=1762508484;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=W/LUMLW07ydoPx9ukxpuiOkMSqsMaJR5YW6Qt7lCr7M=;
 b=O95tmLn7VJNfxTvJ9TXMiLhy1XEVSP6BmiJ6g+11BXu2kl6Pud6SUcsMSPXklwu1mR
 0E4cvYVdhfIWDyqcyyVClKDRpjurLyvHnqqT6a6RFv4u3/po82HF3cCMk+shTon+hT8J
 iVvcHnodUHpntm3DxpWESAKnSwa2ZNarcDl/17ccM434SqIgw0ZKbL/D5QE4Ux4xmdJb
 w+IOXDxvJp//G4U2XgGRtxd8qT0jhDi2/tSm8bQo8S10U+kaqTqfRt6Cu/KXU4dBo1dz
 4LvnvWW/HAQVIsd0j1dTN0eCf5C5nIhOmUJpD1uH1ndak01NBCqP7E45vxDM+AgmwnXb
 Qz4A==
X-Gm-Message-State: AOJu0Yyi3JM1XPtej3PVJXZvKefo6XjNwUxOJwWFZiUwAyJpRb7TgGi4
 171AGYAZWuGYV3cJ0gsiQJlWBaaZJPzkqvlSMsCqCpxs6rXKu8W4RieT3/H74a4BALFlSZb23FW
 tPxVcmwLHGyEZ
X-Gm-Gg: ASbGncvVv3GH3uaeZX2IlbRd8bJUCMh2F5XWO8eAfbi+k9kyMotyCUf1euJqeVcyF8A
 DJMYVoW9zlA4k7tEixyt7vEoctj9V3qYjv4CJCIl7xS+k2qMuIth4TNcjBcox47/WWrtr1IpuB6
 heF2ov0xR8gyApbrboi+oMPUQuy7jI9XBKv0fbD5kaD3LdjQDXguLS1+HtuX0nRUc4ot/i8OrJ7
 9MI+o0oo4g06UyI6BPAU4T4KuJ+bAol32tA+fPBk9ZkH9irY8pOvMNgue7MgV40GOTYstHD8TCg
 kBMevJCfTKb1pG7STWlEBmCypO0uAagzcYk1Jbfzr8DIrttjaJC/rgc0+kCKmKGU4QqHbJUzt5Z
 P53JxXm2LsgCGe16g8MCSKqNiVZGHRRJzbQFEPZdis6Wj2Sau8yaSnZXdqSazbZYL++F0ozQCKi
 HaHvGr+lzlGa+B4tzWyFQXQE5ny+H5psZ1yDIT/3Mle7N9SCpCTPZdaA==
X-Google-Smtp-Source: AGHT+IG/sRRWSdPqGmCqkSqgnk7MO+gWE8EJdbtF9RP9qfRBKafMCdABIR8cd97DQ9h7HsVOYswz2w==
X-Received: by 2002:a05:600c:a088:b0:477:19c2:9765 with SMTP id
 5b1f17b1804b1-477307da91dmr24485715e9.4.1761903684335; 
 Fri, 31 Oct 2025 02:41:24 -0700 (PDT)
Received: from pc56.home (adijon-656-1-155-31.w90-33.abo.wanadoo.fr.
 [90.33.190.31]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4772fc52378sm17682305e9.6.2025.10.31.02.41.21
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Fri, 31 Oct 2025 02:41:23 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/2] tests/functional: Disable flaky MIPS tests on our GitLab
 CI
Date: Fri, 31 Oct 2025 10:41:16 +0100
Message-ID: <20251031094118.28440-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32d;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32d.google.com
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

Disable both replay / wheezy tests which have been reported
as flaky since too long.

Philippe Mathieu-Daudé (2):
  tests/functional: Mark the MIPS replay tests as flaky
  tests/functional: Mark the MIPS Debian Wheezy tests as flaky

 tests/functional/mips/test_malta.py      | 2 ++
 tests/functional/mips/test_replay.py     | 2 ++
 tests/functional/mips64/test_malta.py    | 2 ++
 tests/functional/mips64el/test_malta.py  | 1 +
 tests/functional/mips64el/test_replay.py | 2 ++
 tests/functional/mipsel/test_malta.py    | 2 ++
 6 files changed, 11 insertions(+)

-- 
2.51.0


