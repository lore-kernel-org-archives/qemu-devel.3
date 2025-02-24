Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03472C021BB
	for <qemu-devel@archiver.kernel.org>; Mon, 24 Feb 2025 19:13:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tmdt2-0000xJ-0J; Mon, 24 Feb 2025 14:13:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmdsB-0000Wm-RN
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:12:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1tmds4-0005tx-Di
 for qemu-devel@nongnu.org; Mon, 24 Feb 2025 14:12:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740424322;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=+CZv8sHLOB0qM3tny3Fy+V6o0KRH+EuQXZR40wZhW0Y=;
 b=HZgz24C8+zGjRQb+fXkwQpkByf1RW0xRPnU5mSb9PJ/v/5vEFRIMBFq5f8Pmd/lFPnaOce
 m/1P/5vDWlVoCiZngzbKmbM1wYNNbGlsp2gpUJguPHD2HLyiiWNL/J246OFed4+RhDat6P
 ADTRoYaObKqKqgZLju6/5Wc6ntJf6Iw=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-670-ZbyzmqDLOjW-YGeW0Eha_g-1; Mon,
 24 Feb 2025 14:11:58 -0500
X-MC-Unique: ZbyzmqDLOjW-YGeW0Eha_g-1
X-Mimecast-MFC-AGG-ID: ZbyzmqDLOjW-YGeW0Eha_g_1740424317
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D808A19560BC; Mon, 24 Feb 2025 19:11:56 +0000 (UTC)
Received: from toolbx.redhat.com (unknown [10.42.28.119])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP
 id F009F1800358; Mon, 24 Feb 2025 19:11:53 +0000 (UTC)
From: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Cleber Rosa <crosa@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 John Snow <jsnow@redhat.com>
Subject: [RFC 0/2] python: integrate linter tests natively with meson
Date: Mon, 24 Feb 2025 19:11:50 +0000
Message-ID: <20250224191152.2123003-1-berrange@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

It seems everytime I post some new patches which touch python code I
end up forgetting to run the extra non-default 'make check' target from
the python/ subdir.

IMHO, if we're going to pick up on linter failures in review feedback
(which is a reasonable thing to want to do), then we should be running
these linters by default in 'make check'.

This RFC is demonstrating a possible strategy to achieve that, by making
the python tests use meson in the same way as everything else, instead
of being stuck in the old 'make' world. In keeping with our work to
remove use of avocado for functional testing, this also removes avocado
for python linters since IMHO it adds no notable value over what meson
provides already.

See last patch for the interesting stuff, and the various caveats about
this initial PoC.

Being a PoC this is minimally tested beyond 'make check' on my local
machine.

Daniel P. Berrangé (2):
  python: be more selective in hiding mypy subclassing warning
  python: integrate linter tests natively with meson

 meson.build                   |  1 +
 python/meson.build            | 43 +++++++++++++++++++++++++++++++++++
 python/qemu/qmp/qmp_tui.py    | 12 +++++-----
 python/qemu/utils/qom_fuse.py |  2 +-
 python/scripts/__init__.py    |  0
 python/setup.cfg              |  8 -------
 scripts/meson.build           |  9 ++++++++
 tests/meson.build             |  1 +
 tests/python/meson.build      | 17 ++++++++++++++
 9 files changed, 78 insertions(+), 15 deletions(-)
 create mode 100644 python/meson.build
 create mode 100644 python/scripts/__init__.py
 create mode 100644 tests/python/meson.build

-- 
2.47.1


