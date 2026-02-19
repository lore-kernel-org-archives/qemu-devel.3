Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 454B7E9A05B
	for <qemu-devel@archiver.kernel.org>; Thu, 19 Feb 2026 18:54:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vt9AL-0006l3-U0; Thu, 19 Feb 2026 13:54:21 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt9AK-0006ix-Ap
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:54:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jsnow@redhat.com>) id 1vt9AH-0007DV-DR
 for qemu-devel@nongnu.org; Thu, 19 Feb 2026 13:54:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771527255;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=muNJkDHkTZ0DlgE6VnrMP0Q+z0h1ZSqviga90icLIzI=;
 b=JOZVSMRDiDr8VSVZuPnOy6DsDbfER8OHZbcZrEnPWvrmWa2ri/Vvc0hMakk/iz3Lox94DY
 hQNuXEdg/jqkscjnPCWxV+Vseb1bx75ptgb79bW2QSaLMe50A+6CLw9eUXqGLr1ebaZv+q
 yEDHwXsvLNk6oJE6hXZiuRElgU6cTPw=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-635-L7Zg-1F_OR-o-P2qRJNANg-1; Thu,
 19 Feb 2026 13:54:14 -0500
X-MC-Unique: L7Zg-1F_OR-o-P2qRJNANg-1
X-Mimecast-MFC-AGG-ID: L7Zg-1F_OR-o-P2qRJNANg_1771527253
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CB4511800615; Thu, 19 Feb 2026 18:54:12 +0000 (UTC)
Received: from jsnow-thinkpadp16vgen1.westford.csb (unknown [10.22.64.164])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id 7378E1954117; Thu, 19 Feb 2026 18:54:10 +0000 (UTC)
From: John Snow <jsnow@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org, Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 John Snow <jsnow@redhat.com>
Subject: [PATCH v2 0/1] rust: use checked_div()
Date: Thu, 19 Feb 2026 13:54:08 -0500
Message-ID: <20260219185409.708130-1-jsnow@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.129.124; envelope-from=jsnow@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.045,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

When upgrading from Fedora 41 to Fedora 43 for our CI tests, (Which I do in=
=0D
https://patchew.org/QEMU/20260216212952.420120-1-jsnow@redhat.com/),=0D
clippy begins complaining about not using checked_div instead of=0D
manually checking divisors; see https://gitlab.com/jsnow/qemu/-/jobs/131691=
93931=0D
=0D
This patch aims to make Clippy happy and prevent any regressions caused=0D
by the lcitool refresh.=0D
=0D
v2:=0D
=0D
 - Fixed divisor/dividend order for period_to_hz; the correct order is=0D
   DIVIDEND.checked_div(DIVISOR); I had a thinko where I just inverted=0D
   the formula from period_from_hz(), believing it was a perfect=0D
   inverse; it isn't! Thank you very much to Richard Henderson for=0D
   noticing my mistake.=0D
=0D
John Snow (1):=0D
  rust: use checked_div to make clippy happy=0D
=0D
 rust/hw/core/src/qdev.rs | 14 ++++++--------=0D
 1 file changed, 6 insertions(+), 8 deletions(-)=0D
=0D
-- =0D
2.53.0=0D
=0D


