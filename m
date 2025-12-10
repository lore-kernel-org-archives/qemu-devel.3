Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86614D3C54C
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:17:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK47-0004mu-VN; Wed, 10 Dec 2025 08:17:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK40-0004ln-PJ
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:05 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK3w-0002xJ-P0
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=84+6hgUmdVgnIW9T/FlHkEEt7uKdnj2vJAVLACVcr50=;
 b=SnB3AR0/oSMgxszwMV8fXBgmMaF+bcqVi3HFs4RUk6pc35pJWmcMUH9H5DNMiwwABL9NPe
 s+WhbrHa/IGnibBxbm4T6M39tWIDohR87WcCEPR+/xkY74IM/tPpVUO6pYMAya+3KIL7O5
 dQY0RqUmJ7sEIQS5F4N299kwLnnvYx8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-507-iPKgmKaCPxWscrwgbTt7dQ-1; Wed, 10 Dec 2025 08:16:57 -0500
X-MC-Unique: iPKgmKaCPxWscrwgbTt7dQ-1
X-Mimecast-MFC-AGG-ID: iPKgmKaCPxWscrwgbTt7dQ_1765372616
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-42b487cda00so3965401f8f.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:16:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372615; x=1765977415; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=84+6hgUmdVgnIW9T/FlHkEEt7uKdnj2vJAVLACVcr50=;
 b=LTBhAxnl6ljQjYhSwDx+nVMm3cHjcVW/nfm4zwWgwxMxgtJYAKajZmt3CeKpf1tWL7
 TgHpwfcoWggZzh+Hyx/VoznuxnWfRrjhWp56iMnJZQdT5WvgsPFs+jR6ctG8btoQMM44
 F+s3MWMXhj9AHMPqnWcBOLSljRMgpJ8mN4jYLTP7yQRJUEYVjmIh3Vx7eWjisAhdiQVk
 bmIypZNG3pT493+8LMlp9YEFQrMwVs30GLHweVdUPgj43sMxCrUQPyyfJcjNglTUVMln
 fOvFNMZvwAY0105BUFOpcHwo3nFhVgzGBGSAGrX8MszEIbgAwyUBV/Z02ODewmsnSyFh
 g33Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372615; x=1765977415;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=84+6hgUmdVgnIW9T/FlHkEEt7uKdnj2vJAVLACVcr50=;
 b=F3z6e3MmUiW7vsec6mXh2eY+Xy0nHmQBLHVBdUiRpigmuna9k+5Dd1NqQ+PVEB6kD3
 FRUBQPIUIl39P14/BJ1srlZU6nKpF1SWMWKpYDBzc4I+ORtYSG+uIf8ymizsmat8tYhR
 oYsqWQ3Hbdkh0GWhdNPyFqzUNCsMrkdpN5xoKpB2DEg1G88iYMegi10n88cwCJbi6173
 mSX5rQ7Uoe3+ZbaEZuVx/thK02+nJbfcGhZgVtaAeDRKiXsKBmWspIOERmn3iTkImGR2
 e+TFG+tojBfUmAcC0qBcW0W5aZsWuMCzUG4ISyR23FvrVoLXp6ZWO77hXXlcZEHDvJQb
 hnJQ==
X-Gm-Message-State: AOJu0Yy5OHfcU677snpg3vb68DvbMNAw/hJKhvBR5USykORnqprmeRko
 VCPi8aII4Xson/Rqu91ARd9s2q9UKeSQWYe5Fr+FSgTeIwxYFHvqXm12uZUeo//zQoThgUGaX4X
 glu9QVCezdxRofM549hLW3OVbpP3pN6c7HwZRrk9yjfsWh8pkPOFFsgq7hlp7Igi0H0NASEI4Ky
 t3hsgVXum3BgQA4cIlbxrgHG2uzDKEICdaBz3MRxFu
X-Gm-Gg: AY/fxX7Ph+HyYkEU+HM2HRKUIkJECEG8NhBTrW4z5stwGz3FfZFpe1zoGKjb2wtXASp
 IPUaT4HrbcWSN1KtrfiHk6YGLf47A9upwninecOVmy+/i31k0jKV6tfBVcE3BzsIUXKs1jaOw1t
 fGP80qqGfG0KYsgFb//GVyBLcSVPwlRVXKUOeNOCQV4uiSp5wj3m2DWtQwOj4WUAooU9pyRSUYC
 3nZ8+IwAmiqZNUOToK46tJ1TVz36mPZKsGqsCZAVHc2P6D/9Cz8PFb/GsL0mkCne4QjG8wx8qzF
 1x+3SvUoBaKRwAw1zcXmFQv17n/3N+uwily5UPAtljcMkjoIaHvhMV95MprGYBIFTOJ3nlwjxEH
 haC9n4qwesXVX+u2TJ3oRidUE47uwxmjBCzmS4TqMkOFucNPcMmjNkes8GdIJuX3nz8toMW/B9z
 B0vWj72859eVSB66w=
X-Received: by 2002:a05:6000:2489:b0:42b:3062:c647 with SMTP id
 ffacd0b85a97d-42fa39d2f43mr2445703f8f.21.1765372615389; 
 Wed, 10 Dec 2025 05:16:55 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG3zZO6ZKvu5+VnzXb5No5wbU2QojuG1ZdUMxHpYZn+fTca2F4IOQisC7IrWmhJx9gNq+Px6Q==
X-Received: by 2002:a05:6000:2489:b0:42b:3062:c647 with SMTP id
 ffacd0b85a97d-42fa39d2f43mr2445671f8f.21.1765372614842; 
 Wed, 10 Dec 2025 05:16:54 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42f7ca4f219sm35842451f8f.0.2025.12.10.05.16.54
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:16:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 00/18] First round of target/i386/tcg patches for QEMU 11.0
Date: Wed, 10 Dec 2025 14:16:35 +0100
Message-ID: <20251210131653.852163-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This notably includes the last patches from the original set that implemented
the new decoder (cleaning up a bit the x87 decoder), more removal of temporaries,
and more size reduction for CC computation helpers.  On top of that there are a
few simplifications, fies and optimizations.

The diffstat is large but most of it is moving code around.

Paolo

Paolo Bonzini (18):
  target/i386/tcg: fix check for invalid VSIB instruction
  target/i386/tcg: ignore V3 in 32-bit mode
  target/i386/tcg: update cc_op after PUSHF
  target/i386/tcg: mark more instructions that are invalid in 64-bit mode
  target/i386/tcg: do not compute all flags for SAHF
  target/i386/tcg: remove do_decode_0F
  target/i386/tcg: move and expand misplaced comment
  target/i386/tcg: simplify effective address calculation
  target/i386/tcg: unnest switch statements in disas_insn_x87
  target/i386/tcg: move fcom/fcomp differentiation to gen_helper_fp_arith_ST0_FT0
  target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0 for fcom STn and fcomp STn
  target/i386/tcg: reuse gen_helper_fp_arith_ST0_FT0 for undocumented fcom/fcomp variants
  target/i386/tcg: unify more pop/no-pop x87 instructions
  target/i386/tcg: kill tmp1_i64
  target/i386/tcg: kill tmp2_i32
  target/i386/tcg: commonize code to compute SF/ZF/PF
  target/i386/tcg: add a CCOp for SBB x,x
  target/i386/tcg: move fetch code out of translate.c

 target/i386/cpu.h                        |  17 +-
 target/i386/tcg/decode-new.h             |   3 +
 target/i386/tcg/cc_helper_template.h.inc | 112 +--
 target/i386/cpu-dump.c                   |   2 +
 target/i386/tcg/cc_helper.c              | 280 +++++---
 target/i386/tcg/translate.c              | 824 ++++++++---------------
 target/i386/tcg/decode-new.c.inc         | 328 ++++++++-
 target/i386/tcg/emit.c.inc               | 109 ++-
 8 files changed, 845 insertions(+), 830 deletions(-)

-- 
2.52.0


