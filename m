Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DDD1606A320
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Nov 2026 18:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=tenstorrent.com header.i=@tenstorrent.com header.a=rsa-sha256 header.s=google header.b=BiUZAMzX
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xQqKc-0004NB-PK; Tue, 10 Nov 2026 13:12:30 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xQqKO-0004Kk-Uk
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:12:21 -0500
Received: from mail-oo1-xc30.google.com ([2607:f8b0:4864:20::c30])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <asrinivasan@tenstorrent.com>)
 id 1xQqKI-0001B8-L3
 for qemu-devel@nongnu.org; Tue, 10 Nov 2026 13:12:13 -0500
Received: by mail-oo1-xc30.google.com with SMTP id
 006d021491bc7-716d052dc23so1031611eaf.1
 for <qemu-devel@nongnu.org>; Tue, 10 Nov 2026 10:12:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=tenstorrent.com; s=google; t=1794334328; x=1794939128; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=gUlmtfEjX78lIxkSHv2meEGklaTgBOn1Y2yu0qD6weg=;
 b=BiUZAMzX7DCkBvPFXCD0Y8aAxiuAMUcYKV7WyWbXFiz0u5YMkNUsU+tcweyYIZ16Gx
 e+vpICxMaIK/dXHms+QdfQz3Zf7hitsSG8krErYfsvpFeHcnTBFxHTOEtTN7vjID/tc9
 N68lpeDvrN2QZyCYSspo1/QsxsPTZwmVVXQ1zri1Vz9VxFJ0A+xYtyi/DWMHW16QLOCb
 zV2S1HBp7si4arQMdrX2A/5PbloZ5BOJX3Q586oV3V1DE5+gnbnxDbYPzXTSSjB2DvQg
 D9yCPsI6fk2UphYas1e8mfXj+2QC5oQI+W/06b/YnFr9xRWlVEtL66TeuScldt9eYh9S
 vMJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794334328; x=1794939128;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=gUlmtfEjX78lIxkSHv2meEGklaTgBOn1Y2yu0qD6weg=;
 b=npPo3xAJNgLjp92nhIxm9QP0FNSwlhLjxfwjZKPh/JU33OejLiYv95pacyhRGE0dTK
 o+2JkE20xHIxKoc9aS40Qtexmux+rkz436/6vLnq/m6O+0U+/iFGnijF0gp7kexDvtH3
 pknN3lrv820x9upjHrPGfrD0jaQieVrboWKS/sZQWI3hTo1dm7m4UfRjoZARMnG/Ojkc
 MvaqkbmPO7oTUXOKkgwI8C03ROr/rALjNOdrRzbJkvACqZ0rhwyHu3h7byGw6uqwPaeI
 B7vl9QU2GChHRQdW0xhQSble0/DJmfweB0HozwgqSuO/5BBNztZ3Vkmu5IFq3k1i9cvM
 1DBQ==
X-Gm-Message-State: APuU4Z9bfYySGUzlimGvlAHT0Qo8GB69klNPgpVoeIBBVnZ/8ORIvqzc
 +EGZXEpknUBWSoKZR4VYwKeqndM7dZ0lL0PH8sMvkYKSTXk93k+d9oCHmbOWLXg+Vbk=
X-Gm-Gg: AYBFou1DuxdVcSsAUP0Ll/Z2xcQAoeV5LQxe8XMQ9bBCNEndxAp6UYg82pqNlSUZgGB
 5O8GwUcWE53HHA4Z597jcaJotnXgNZyWqkZxXwYP0l4E1GVusNH9EXCo3GvzxHu9YH1CBxeH26Z
 k9MYGQqNyXRmAln90VLkmqYpFIZQtoERNiYqbeKpXy3ejciCb16I7JzpJfITnFWFNqDlCM0c4Pv
 10E9NQepVdsFIzAwmS84O6LON/LYSRsxqzt97pavGlQHyd2crTiykbNmARUFcsgZq/sfUCjqofA
 D4tj86gZiej6LhYR5Z+gSEJXK3diCanVf/n2/vAWJmUKt8d0ZY1UsDiAgzHlngziT5/53Y4G18q
 RzZb+RR5BLeIvulxBt+Bn6k/qca/OJyC9MmxHdhSm+FVEbT1YgAvEwIy1YL0Tve9xknRXPsde8U
 qsPknclOGyInBYzsFdkR5fHZt9rcVpLjmX8j9k3zSh4VhKHlRbA3ZrFW4dUk0r4ymsfqEFZ62HO
 SfSg1AzPDj860ayAGXobFGK/x2VjdkyDUNLSvJ+B+SkpFDXPfnSMeVD0u0JHhYmYiphcPpaOkTs
 N01RCdqS53bNvu89aq/eN0Ye0i9VCH4bIlIiFpu0Fyr/tDw0DspIy+L+ICCVW4z1gKZ2nPLxrrO
 tR1o=
X-Received: by 2002:a05:6820:3512:10b0:716:c3a0:48db with SMTP id
 006d021491bc7-718a5a58816mr993607eaf.25.1794334328151; 
 Tue, 10 Nov 2026 10:12:08 -0800 (PST)
Received: from [10.200.24.109] ([12.55.13.134])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-718aa034ad2sm2063514eaf.13.2026.11.10.10.12.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 10:12:07 -0800 (PST)
From: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
Subject: [PATCH 0/2] m25p80: Clear write enable latch (WEL) at the end of
 SPI operations
Date: Tue, 10 Nov 2026 12:11:47 -0600
Message-Id: <20261110-m25p80_write_enable_fix-v1-0-3a2abc0072b0@oss.tenstorrent.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAGNe82oC/yXM2QqDMBCF4VeRuTaQiViXVxEJLsc60kZJ7ALiu
 zdtL78D5z8owAsC1clBHk8JsroIThMa5s5doWSMJqPNhZm1upt8K7V9edlh4br+BjvJW43FVOW
 Z5sJkoPjePOL8Kzft3+HRLxj2b47O8wOv92dWewAAAA==
X-Change-ID: 20261110-m25p80_write_enable_fix-d7f95301723e
To: qemu-devel@nongnu.org
Cc: =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>, 
 Peter Maydell <peter.maydell@linaro.org>, 
 Jamin Lin <jamin_lin@aspeedtech.com>, Kane Chen <kane_chen@aspeedtech.com>, 
 Fabiano Rosas <farosas@suse.de>, Laurent Vivier <lvivier@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, qemu-arm@nongnu.org, 
 Alistair Francis <alistair@alistair23.me>, Kevin Wolf <kwolf@redhat.com>, 
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org, 
 Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
X-Mailer: b4 0.15.1
Received-SPF: pass client-ip=2607:f8b0:4864:20::c30;
 envelope-from=asrinivasan@tenstorrent.com; helo=mail-oo1-xc30.google.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_EF=-0.1, RCVD_IN_DNSWL_NONE=-0.0001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The m25p80 model in qemu doesn't deassert the write enable latch (WEL)
at the end page program and erase operations. This series contains a fix
for that, to match real hardware behaviour.

This series also has a fix to the aspeed_smc tests. These tests exercise
the m25p80 flash model by sending page program (PP) ops, but do not send
write enable (WREN) before each PP op as the spec requires. The test is
updated to do so.

Signed-off-by: Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>
---
Anirudh Srinivasan (2):
      test/qtest/aspeed_smc-test: Send write enable before each page program command
      m25p80: Clear write_enable after page program and flash erase operation

 hw/block/m25p80.c              |  6 ++++++
 tests/qtest/aspeed-smc-utils.c | 24 +++++++++++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)
---
base-commit: 73294d096cc591e122fde9e63db4739de6d84f2b
change-id: 20261110-m25p80_write_enable_fix-d7f95301723e

Best regards,
--  
Anirudh Srinivasan <asrinivasan@oss.tenstorrent.com>


