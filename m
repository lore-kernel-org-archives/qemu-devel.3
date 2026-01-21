Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61828C44501
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 11:00:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1viVw6-0003ct-DX; Wed, 21 Jan 2026 05:59:42 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viVw4-0003Pd-B2
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:59:40 -0500
Received: from mail-wr1-x42b.google.com ([2a00:1450:4864:20::42b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1viVw1-0007w8-Sn
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 05:59:40 -0500
Received: by mail-wr1-x42b.google.com with SMTP id
 ffacd0b85a97d-432d256c2e6so5524346f8f.3
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 02:59:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1768993176; x=1769597976; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=xOTSclcs1qm3AW4VgmJ74H0mVLzF3969HljuRmIapsw=;
 b=aDp+F4Bh7Vo8E9cQnAx+XC9Z7cSi7vOB+UMloPZp/dckk26Cmn5QJhWnf1TJejLhfU
 sGRwuUd08iMkvexARd9EW1BehfX4JUMPwyoWZmulDysKTPpW5BpQhQFxRLzXAy6/D+f9
 wczLaIX69HyPhdJ7KA3TKhZOejrQ/Hm0r2U0pAViCj1mwGZXdNk1abGsnMX/ALP3WUzD
 GpWV3WstbcyzBA8urSk+9jHivlCDgIK9t7aUoLnz15Tzm3s/1vpg63eySyLT0pHIE2H8
 hoNZT6nJf+umzsLNimRISYR2taRSEJky7y1WB5YSaOk7co+0MVkTykgagodE5r0QqWeS
 r4Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768993176; x=1769597976;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xOTSclcs1qm3AW4VgmJ74H0mVLzF3969HljuRmIapsw=;
 b=jzcKdUic+ceApYYbxcPhwu12WIDOueIfG+cIfmb+T4MX8+nz6CDLcT7nuGvHr2HI9O
 gskl98/0GcxqBZxcJPIzXtJr5taq5Q7C5TdSGdn4dHLVWug5ZAkKMKPm+d9BE9ohOp3j
 wVlN8qY+pbKKg4m+/0c5j3+WmE3Y5zWy/Tavi/u4u1Mco+Q9imxMV1n45BVeqQLWkK+Z
 XfpXnGAsSxVoZqEff6HnVIJ8Sy18BEGiLxFPen1sRfBJNkcruaGELF2OCrTdmhFXyPsR
 G1YXC6QhRoDhSGk4SeKIKjOOQ2xRH7djF+1QJp4OsXBnxs4brks6WxWrn/2wUlFC6gBQ
 6qYw==
X-Gm-Message-State: AOJu0YyN3mI+1yAvwABWE7eQjeDiA5QL312uckDhbYWxAZpkRhjjSnkO
 B64nV6FLmvhWgHTwTv/mksz2KxPha+DU+aOwXC4jzcfRVx2Ro8J99qoXKWIriEEjpDogaQAOty6
 TUmMnRzw=
X-Gm-Gg: AZuq6aJbWjZI2gjcZiY6tLfGCQusK+Gwp6ScbIAthoaJEkOcxpyx+eLyldTR5u0pQo3
 KxtGUIG+LdLErKjjplQb6O7PpSkJURdb47nPYuS60LL3zUn8mqiHkAS8EfrsisI3kYuIBgqfVnq
 lqYTU5mgKh90TRt/fRU8wP6TaPkdsOBXs7rsNbJUv5G+cOA3agOWRKHbZqpuZ0PlcOyiPBu7DC/
 sSMBCwwbjCXfD1E7wJaRay7Qrm9E+W7Uape5HDudSS0ZYKAr123U+3BemXPLa14MYxzi/HmwpLA
 62WIt3Rbdcxrbu7pmN+5/eLRRwf3llgFp+nME32j3kh4fuYS1ym7Ihff5kRAcBjb4XQhDgL5iH4
 jjNdE1DI4jS214nbqB5n8PKxpsBSMRJa9kCpBTk3gj7TWg5MfPNxiDnBS290tcTGqarITTme7CQ
 KVRf2JCEglRtz1
X-Received: by 2002:a5d:5d07:0:b0:431:66a:cbc4 with SMTP id
 ffacd0b85a97d-4358fed7986mr7898914f8f.17.1768993175675; 
 Wed, 21 Jan 2026 02:59:35 -0800 (PST)
Received: from draig.lan ([185.126.160.19]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4356996cefdsm34524352f8f.24.2026.01.21.02.59.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 02:59:33 -0800 (PST)
Received: from draig.lan (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 62A7D5FDE8;
 Wed, 21 Jan 2026 10:59:32 +0000 (GMT)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-arm@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
Subject: [PATCH 0/4] GIC DEVICE_LITTLE_ENDIAN clean-ups and potential bug fix
Date: Wed, 21 Jan 2026 10:59:28 +0000
Message-ID: <20260121105932.135676-1-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::42b;
 envelope-from=alex.bennee@linaro.org; helo=mail-wr1-x42b.google.com
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

Following on from my RFC on Monday I have split the
DEVICE_LITTLE_ENDIAN changes apart from the corner case bug fix as
well as updating the other GIC regions.

Alex.

Alex Bennée (4):
  hw/intc: declare NVIC regions as little endian
  hw/intc: declare GIC regions as little endian
  hw/intc: declare GICv3 regions as little endian
  hw/intc: avoid byte swap fiddling in gicv3 its path

 hw/intc/arm_gic.c              | 12 ++++++------
 hw/intc/arm_gicv3.c            |  4 ++--
 hw/intc/arm_gicv3_its.c        |  4 ++--
 hw/intc/arm_gicv3_its_common.c |  4 ++--
 hw/intc/arm_gicv3_its_kvm.c    |  2 +-
 hw/intc/armv7m_nvic.c          |  2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

-- 
2.47.3


