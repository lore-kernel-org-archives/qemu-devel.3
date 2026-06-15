Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7E395CD98CF
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:13:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYyhm-0000pj-04; Mon, 15 Jun 2026 00:13:46 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wYygl-0000dJ-PK; Mon, 15 Jun 2026 00:12:47 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1wYygf-0002TN-Vi; Mon, 15 Jun 2026 00:12:43 -0400
Received: from h183.csg.ci.i.u-tokyo.ac.jp (h183.csg.ci.i.u-tokyo.ac.jp
 [133.11.54.183]) (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 65F4CEde067027
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Mon, 15 Jun 2026 13:12:19 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=G0miaFo35kARU8Tn82NOa1rtaZHUT0Nk+A3UxFv5fQE=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-Id:To:Subject:Date;
 s=rs20250326; t=1781496739; v=1;
 b=jVybbq/zN+e7rKayhsxJyIuZvG8x5o+CuMRDF+fffjRjADZy/BHCnO15yKq/UALb
 qBrbB8MHowfkwUFFGcQ164L8zNF/+oQL3dJXXGFPO9w1NIbJbSLGvPUitJGPFczr
 f7qREfC35KLfhaaK+00UGi0PWIDnRV2SRNy7eY/yiD91dxKEFfWOvHuSGbdDnjil
 xddmQtJntqpli6mGaHIiPo7399X9r7oBlspNU3jc/OCywH2IQuucBSrMrUiuG0y1
 UcUTyIXJZV+wEOkydYOLp8q76FMAZ8KNZ+epdEeuZlCXPggYlA1zq30jL5RJzQGf
 3hC6vdKEncq4z10RNh9A/A==
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Subject: [PATCH 0/2] qom: Tighten object lifetime handling
Date: Mon, 15 Jun 2026 13:11:05 +0900
Message-Id: <20260615-embedded-v1-0-bb0c65bf126c@rsg.ci.i.u-tokyo.ac.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDM0MT3dTcpNSUlNQUXQOD5ERLi7TklCTTZCWg8oKi1LTMCrBR0bEQfnF
 pUlZqcglIv1JtLQC9aJbWbAAAAA==
X-Change-ID: 20260614-embedded-00ca98fcdb5c
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 qemu-rust@nongnu.org, Peter Xu <peterx@redhat.com>,
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Alberto Garcia <berto@igalia.com>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>, qemu-block@nongnu.org,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
X-Mailer: b4 0.16-dev-16047
X-Developer-Signature: v=1; a=openpgp-sha256; l=1419;
 i=odaki@rsg.ci.i.u-tokyo.ac.jp; h=from:subject:message-id;
 bh=0CUTOmc9YX29N+aQ+jpZB2twovhqklWdn4I2Lqy5quQ=;
 b=owGbwMvMwCWmMbc20y1CyJDxtFoSQ5Z+9fwmAcMD8zvlfzr2Heznebz35IMVmcJZzWUMH27vy
 fugu7eko5SFQYyLQVZMkSWlaDe3RnTtp8KE+BaYOaxMIEMYuDgFYCIrbzP8M712+I3RfC0xruNO
 /c6HP6s0H9miHrFht2t8XlKtZ07BbUaGnX0KewN/T7n8bPqv3sux16o9P3Ny3Dru23g47fBkmdn
 F7AA=
X-Developer-Key: i=odaki@rsg.ci.i.u-tokyo.ac.jp; a=openpgp;
 fpr=AEDC03C9AF734F2EC26A7BFFA4BAEAA73536753C
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

QOM has extensive assertions and prevents most cases that would trigger
undefined behavior, but two corner cases still need explicit handling:
temporary object resurrection during finalization, and references to
embedded objects. This series covers both cases.

The temporary object resurrection patch originated from:
https://lore.kernel.org/qemu-devel/20250906-mr-v2-1-2820f5a3d282@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH v2 1/3] qom: Do not finalize twice")

I also plan to make the embedded object reference handling a
prerequisite for the next version of the following series:
https://lore.kernel.org/qemu-devel/20250917-qom-v1-0-7262db7b0a84@rsg.ci.i.u-tokyo.ac.jp/
("[PATCH 00/35] memory: QOM-ify AddressSpace")

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
---
Akihiko Odaki (2):
      qom: Reject temporary object resurrection
      qom: Manage references to embedded child objects

 include/qom/object.h            | 39 ++++++++++++++++-----
 block/throttle-groups.c         |  2 +-
 qom/object.c                    | 75 +++++++++++++++++++++++++++++++----------
 tests/unit/check-qom-proplist.c |  8 ++---
 rust/qom/src/qom.rs             |  8 ++---
 5 files changed, 98 insertions(+), 34 deletions(-)
---
base-commit: 2db91528542672cf0db78b3f2cc0e22b36302b38
change-id: 20260614-embedded-00ca98fcdb5c

Best regards,
--  
Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>


