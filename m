Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 483EDCEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 17:10:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL2jI-0002HF-2d; Mon, 17 Nov 2025 12:09:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2jE-0002F0-Fr
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:09:24 -0500
Received: from mail-wr1-x42f.google.com ([2a00:1450:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vL2jC-0005iZ-QY
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 12:09:24 -0500
Received: by mail-wr1-x42f.google.com with SMTP id
 ffacd0b85a97d-42b31507ed8so3660548f8f.1
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 09:09:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1763399361; x=1764004161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XNaDklzqrpgK+9SSRYOIvoc5Tgwti/B/zPRmb70ML8w=;
 b=c4gmIN999yY4FY3nOPaTfkkylZ1H6ZM2PBHtlMyoECOeHRH6LROTDKg1q4tzlHYsu+
 NIwXcY7NNStxzoAdZCsUMjhT/NVoqi94SQnilAnhLR5ABTEOrkVgXJ6LOiJvlm6rcmDX
 LU1+ZvXGYnVthwh0S7/Fq3nIP17cDurwU4sXP3wiFOVWIDiGsGn4HDWlZoBgWDQdTh6O
 dMwaXatXwRo5i5tUaLsJHrdL5eohLdSXehOyek0exheMJrzbA+9BLLb+hfENSK56r/44
 5vA/WVA+Hp4Uk7oyBsB2NwPz2DugTSBwjHlMXr0pavuhRoQW/XtE3J3YJPLCZG9fzBjB
 Vp3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763399361; x=1764004161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XNaDklzqrpgK+9SSRYOIvoc5Tgwti/B/zPRmb70ML8w=;
 b=d4xsE6No3ZGS+i90ltIHmcZwIpAm5B7xOyJraqJF3TIwa6/tsCSZeQCr26xrYBiQ6E
 LNxMvb1U+BewnOpan50S+L7TSPhFJJHRw8Hr00rdVj1khLEAECUXAeUNBVjN3A36gsTD
 XSib37+HFBDT7mdByS3KW6+IyPoV3PBLqN/E1KYv6YzCJX/jywL1GVvilQRycqAxTlvH
 UF0MMNN9sXbJkM3tWz2oLb3IgD1ToOrP05R9aB1qSAcG6eRpMW8IJmrJuzUTS+tm5sO6
 tp35XWZWgqU0Ru67gFDP4Sj/j1ypdKXR9irjIOg0hTorjhiad7lQDxQ+R0KBAOiWzrOI
 EB9A==
X-Gm-Message-State: AOJu0YzDPfxzGHpJcXkx6aBV1qIvR6jb+MuhulgjcrcFnPtCGiIVdXh4
 kmOHV2nanHUiDjNpsJEiB2YEF3pCtaG8keVpRQfnJvS8ogBoY9HTlMSt/gns5Bv4vCJj9nM0EKA
 zMx3EXVt0BA==
X-Gm-Gg: ASbGncuj9f5c2zf8ExrZF79tkvk+Zoefw/cR2Snl/mbyKHEd135g003Rc79kH9qQj4c
 bdjxsPl0BAxkdQBlU3nFx4ezl95yaY7qVFUvvQ/yL1vwsb3YGCdEER1eqhc7VT2ToXaFGtEYliU
 r41u/DqmoIqO7n0IZyl6LStx3vE50LtTJ96u0Wj3i1KCx4yPvgylcs0g/vdql/iVcaGJH1Eckc/
 OY9YBXoS9e4tQtX2zAo7AodMt7u4nXV12Y/EtY69srCpgEAan2atRWkxAcTS6RCmLWGw6HIFFGG
 aD5xA3q/5xhJcUUcWKtxt7To7SfyhDIc1EwVYZi/0VHCJexSfEl/cwKDYE5ADv2kMNBBVxUiNER
 zj2TB2Z+P0pyYmzd/mhBT/So4CGBw6vt4sD/oIOfrJBFyirjLGpeNR19tN1F0ngEVaG6eJ0BWgS
 FgHaKLqkH0BtRhBtLDUdrYIpn2ghiTlonXMXZwbk9xW4bN3N6rqd/14Jo5OkqF
X-Google-Smtp-Source: AGHT+IHG6XcRuXhbeGTAJlhBQwAVZPlRuzCXi0EjCGnyseLuHceyPB6Lf7SldcxzFfwHCo8G34CGrQ==
X-Received: by 2002:a5d:5f90:0:b0:429:8a71:d57 with SMTP id
 ffacd0b85a97d-42b59356aadmr12039290f8f.27.1763399360647; 
 Mon, 17 Nov 2025 09:09:20 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7b14bsm26845848f8f.9.2025.11.17.09.09.19
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 17 Nov 2025 09:09:20 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-ppc@nongnu.org, Chinmay Rath <rathc@linux.ibm.com>,
 devel@lists.libvirt.org,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Thomas Huth <thuth@redhat.com>
Subject: [PATCH-for-10.2 v2 0/2] docs: Update around MIPS/PPC host removal
Date: Mon, 17 Nov 2025 18:09:16 +0100
Message-ID: <20251117170918.80248-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42f;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x42f.google.com
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

- Clarify MIPS host removal
- Mention PPC host was removed

Philippe Mathieu-Daudé (2):
  docs: Correct release of MIPS deprecations / removals
  docs: Mention 32-bit PPC host as removed

 docs/about/deprecated.rst       | 2 +-
 docs/about/removed-features.rst | 8 +++++++-
 2 files changed, 8 insertions(+), 2 deletions(-)

-- 
2.51.0


