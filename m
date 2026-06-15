Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11B45CD98CE
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 04:57:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wYzN5-0008TB-Jq; Mon, 15 Jun 2026 00:56:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wYzMv-0008Sp-E5
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:56:17 -0400
Received: from p-east2-cluster6-host9-snip4-4.eps.apple.com ([57.103.76.195]
 helo=outbound.st.icloud.com)
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mhjacobson@me.com>) id 1wYzMr-0006Ln-Hg
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 00:56:15 -0400
Received: from outbound.st.icloud.com (unknown [127.0.0.2])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPS id
 49BD4180069D; Mon, 15 Jun 2026 04:56:06 +0000 (UTC)
X-ICL-Out-Info: HUtFAUMHWwJACUgBTUQeDx5WFlZNRAJCTQ5JHVoHRQNGD1YCWgZLVxQEFVsHVghdEkoXXS1aDhwTVhUTC1NWXxUXG1wAFxlRTQ1YWwhbBA8fTAxRAkIFVl5KDB0EVAddBV1WUAJaS0IES0VoXAVcHEAXSB1faktWFAQVVkNUBF9QVBFXUAtZAkIPSAVcAlsGRQxMBEMFWAZCC1UCQFoDWBFaF1EeWAVyHVxWUAJaVRIEQAhWUF4IXh9MHA==
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
 t=1781499368; x=1784091368; bh=SpABRAxcxBQANtZ0NQiPeqiAtsM7d/4AzCugTanRa3s=;
 h=From:To:Subject:Date:Message-ID:MIME-Version:x-icloud-hme;
 b=Xs/si42NpW4+Z8YVf5Yi3YrveB20RC+cQ582WOxT84vjaLnBbd+gohTD1MsECCvaZS6ZyJDJrhlwSBFfCuMhN2lj6dH2bJy2MF3763Y+sN3AXoyNNhJjlV6/qbcX6uZtixCJfORS9x6qIQxET9poNr1Fuyjnyc7hhJWzPgdcDy3mtsjjXD7M8vdPgfxTn1aUZ1S+x+aVGS6e6XIhce6ZiRDvIJPpctoPsLk6pMe6PPEsD/Pb4h+t1yW2XFyZU7eEY9S+L/6+i4NPwVY4Nd9yIkcQoitXvBKvu8BBX4K5Mqt51DbLiFMw7cI6NhHOmWzIaHbRlRws/GUhxJf1q5DjRg==
Received: from localhost.localdomain (unknown [17.42.251.67])
 by p00-icloudmta-asmtp-us-east-1a-60-percent-9 (Postfix) with ESMTPSA id
 D3ABF1800294; Mon, 15 Jun 2026 04:56:04 +0000 (UTC)
From: Matt Jacobson <mhjacobson@me.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Matt Jacobson <mhjacobson@me.com>
Subject: [PATCH] configure: honor --extra-ldflags when forced to use
 objc_LINKER
Date: Mon, 15 Jun 2026 00:55:47 -0400
Message-ID: <20260615045547.23422-1-mhjacobson@me.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Proofpoint-GUID: -wPAFYyFR_j2GbYteoP37oOvBaS9dDb8
X-Proofpoint-ORIG-GUID: -wPAFYyFR_j2GbYteoP37oOvBaS9dDb8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE1MDA0OSBTYWx0ZWRfX+2/Ty5XFKeZi
 FqY6DUkZ3IY58niLSkKDu4SKKrc/sNKJ/Vakx55zmlYj8yeSOdw8eKjc6+WiLPiXKzzKDCWJP3F
 eOmNrONLvs+8Gs6Y+sPK83l/3HGVABRdWbF1EWqQDf7ZYKfUqr5427ryrwCZ/ewHNr3/InCMi3F
 rXrpCGw6+LwuJTvD8/3wiY9pcJ+Qr/BSAmPaoMaC1s4NPfqQRF98psAIqo7jBPV3GK7ZXLhhspz
 mM6kywwF6uLUdne6y2CZnGZgdq8u9AQAKZth1FgZG7jJ1lNn8o23s0B1rB6YqSVVzvmoztw9Iyh
 k15jJot3k7uyrqVSjvW
Received-SPF: pass client-ip=57.103.76.195; envelope-from=mhjacobson@me.com;
 helo=outbound.st.icloud.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

3220b38a8d had the side effect of making the individual target link steps
use objc_LINKER on macOS, because `coreaudio.m` became visible to Meson as
a source file.  (The preexisting presence of `cocoa.m` is masked by the
fact that it gets built into libsystem and then extracted back out as an
object file.)

`configure` correctly passes `$EXTRA_LDFLAGS` to the "C linker" and "C++
linker", but it neglected to do so for the "Objective-C linker".  Fix that.

Signed-off-by: Matt Jacobson <mhjacobson@me.com>
---
 configure | 1 +
 1 file changed, 1 insertion(+)

diff --git a/configure b/configure
index d786d3a7c9..d773c3c46a 100755
--- a/configure
+++ b/configure
@@ -1849,6 +1849,7 @@ if test "$skip_meson" = no; then
   test -n "$objcc" && echo "objc_args = [$(meson_quote $OBJCFLAGS $EXTRA_OBJCFLAGS)]" >> $cross
   echo "c_link_args = [$(meson_quote $CFLAGS $LDFLAGS $EXTRA_CFLAGS $EXTRA_LDFLAGS)]" >> $cross
   echo "cpp_link_args = [$(meson_quote $CXXFLAGS $LDFLAGS $EXTRA_CXXFLAGS $EXTRA_LDFLAGS)]" >> $cross
+  test -n "$objcc" && echo "objc_link_args = [$(meson_quote $OBJCFLAGS $LDFLAGS $EXTRA_OBJCFLAGS $EXTRA_LDFLAGS)]" >> $cross
 
   # Only enable by default for git builds and on select OSes
   echo "# environment defaults, can still be overridden on " >> $cross
-- 
2.53.0


