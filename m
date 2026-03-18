Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8270CFCD0DC
	for <qemu-devel@archiver.kernel.org>; Wed, 18 Mar 2026 08:33:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w2mKo-0000sL-QH; Wed, 18 Mar 2026 04:32:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKe-0000qH-Ai
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w2mKb-0001md-Rl
 for qemu-devel@nongnu.org; Wed, 18 Mar 2026 04:32:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773822763;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Y9U5Wt1s39BR5h8oUKFepF93A2M+7WJwMHQ7ZIgORsU=;
 b=L86AMIwQaDwTSFYguey9X0CKGJtqrfD+YOpl7NBRSUn+OGMdaMBk173IEA00JyxyGW77rJ
 lx4uGwE0hfFQP/f6WkSJgPh3oSv+2RHEIkVC3XZ1XCzYR1S2SKMd3Zi+RUk9VZYb5fwC1M
 gAsLGl9GAsWfvZJAuJpqubWI/AADiag=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-9-cRxBjVXzMZq0zozflQ-cCw-1; Wed, 18 Mar 2026 04:32:42 -0400
X-MC-Unique: cRxBjVXzMZq0zozflQ-cCw-1
X-Mimecast-MFC-AGG-ID: cRxBjVXzMZq0zozflQ-cCw_1773822761
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439bab2d095so4287028f8f.3
 for <qemu-devel@nongnu.org>; Wed, 18 Mar 2026 01:32:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773822760; x=1774427560; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=Y9U5Wt1s39BR5h8oUKFepF93A2M+7WJwMHQ7ZIgORsU=;
 b=LpP8qI21C9JtToIGYdNpOIqAKBX/WAWmOsIplJ+lDOy4j45Bjfz3fdYZ4ABaauJuq5
 q9/r16hiaXiVKuvloIbZskSt062SlZY9uxeOy+C+GkZ0+teeUxxfwuJUdn/cEIppH2ki
 nsuTf9GmgdJ5T7Jta1anJ3ioztICb2p+JtNSJeVnbrBCGRP1J8+cyssfGJjZC3/Kp2vo
 9XNs9STOWatECfIGI9s5Toue3MSOIxGbCLQaKITBJLeoQXXJ3zCxzGmG0B/gT29i0vHD
 Ob/RKpHw3oEXEjMwlynaxRWUhMDtQ9hxA6zoI0VgE/hPwjFHnD+Xx9YqoyOuf5QuZ9xb
 JyEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1773822760; x=1774427560;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Y9U5Wt1s39BR5h8oUKFepF93A2M+7WJwMHQ7ZIgORsU=;
 b=a9lBMOkbvq11oIUJ8U2AakMNbEmCx3E1bqY9jp5T2hCBbdl6c/VamRiK8suL1vPYVu
 IZJK7uMjfCEOlNXbyjACeUmFVjTnq8N+V19KmSXAv0otMDrY8n8fQvwMqtB9YMzczE2G
 uTKjnrhN7khKrzSzyS47M61tmUqCzowS81c8CQdj1scRxpXWdQhnyfBmFWqg+kGAApeJ
 3npzmEZP1HwNHVzfaQKwyWd3VuzR5IL490e+obsp2phtZpMhvCJYY4N9cZTjDUDQ6ki8
 ZMDr1fpdEaK0Xof3KUnzlKMwzT5DhSZL3kp+rehW0ldOcEfMbrGPUiiFbwckeCmFl4DD
 pE8w==
X-Gm-Message-State: AOJu0Yzh3N7ENDkGGiiirNlBkKAzgRMMkrc3Wwlmb+Bs6mqq1AyoT0DX
 wS4Oq6OBhBXbPsnA0WYByX8izIOahCuVX3VoV15/MZl1JesMD1OhgEEsKrzLLj33tQh3w+X5ZF+
 S0ymRx22Z2lLU/HOvO+bkx5qgyyPJGEcDG518mBBQNVe2zMtPkXUyKQ4dwPpWh6g0KDGnwrEOkT
 38KuUYBia8r1exRyVNqpvGsb7o6Dlc3HuFUO2t4FUQ
X-Gm-Gg: ATEYQzzny/6tvEMAxboPWLshrZ+Q+O3ADp2jsL8Ioc4M3/VCXA5O+3eq+luMgBSEi96
 vYgYb2gslLV6w7icGOMVqyryOdCo+JMBTrWWjCt4bIlP/UFkYgZ837HR0xLjV4/N5GewGfeItDe
 gJ+Nbi99Hzs+uu6sHRyis54VcMrgrN417Xso03pXiHps6sJASMuX/7VXtE3OUcGhjpmCQFwFclf
 vPVoc4mbZ3yZSDGlf7udmwX0ApBBSXvF7up3XFD/NUfHD4c4SDW8amw8/JqT8yUmwDq7RWoSg0l
 goW6Lupn1cTy1boyt+/LHtDOWxB9uGZuvr4VRPDdSwJWMrCt8eiNJognoH4rHuW9KYs6cxSjQ6U
 rAuXhGpj30HMUemhmk6NlZNUZRxRjYkxNbXTCSIzQFnQBruj4lfgoQRUepOUvT/zw3DixX2/mBU
 vgJULqT8pWGwmpRzI/UANgSeY0U4Q=
X-Received: by 2002:a05:6000:200f:b0:43b:460a:b13 with SMTP id
 ffacd0b85a97d-43b527c6a75mr3786235f8f.44.1773822760390; 
 Wed, 18 Mar 2026 01:32:40 -0700 (PDT)
X-Received: by 2002:a05:6000:200f:b0:43b:460a:b13 with SMTP id
 ffacd0b85a97d-43b527c6a75mr3786181f8f.44.1773822759828; 
 Wed, 18 Mar 2026 01:32:39 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43b5189970fsm6203616f8f.27.2026.03.18.01.32.39
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 18 Mar 2026 01:32:39 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/4] Last minute changes for QEMU 11.0 hard freeze
Date: Wed, 18 Mar 2026 09:32:34 +0100
Message-ID: <20260318083238.1132609-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

The following changes since commit fff352b9b6080e580aa1fadd29b4eccf4cb2922a:

  Merge tag 'for-upstream' of https://gitlab.com/bonzini/qemu into staging (2026-03-12 15:21:06 +0000)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 6257754bb9b00b52018951096a9fba28b98a5b0d:

  rust: suggest passing --locked to "cargo install" (2026-03-18 09:20:57 +0100)

----------------------------------------------------------------
* runstate: handle return code of EOPNOTSUPP properly from rebuild_guest()
* meson: do not hardcode paths to generated files
* rust: fix build when --disable-rust and meson < 1.9
* rust: suggest passing --locked to "cargo install"

----------------------------------------------------------------
Ani Sinha (1):
      runstate: handle return code of EOPNOTSUPP properly from rebuild_guest()

Marc-André Lureau (1):
      build-sys: use the "run" variable

Paolo Bonzini (2):
      rust: fix build when --disable-rust and meson < 1.9
      rust: suggest passing --locked to "cargo install"

 docs/about/build-platforms.rst                      |  2 +-
 meson.build                                         | 12 ++++++++----
 system/runstate.c                                   |  4 +++-
 tests/docker/dockerfiles/fedora-rust-nightly.docker |  2 +-
 tests/docker/dockerfiles/ubuntu2204.docker          |  2 +-
 tests/lcitool/refresh                               |  4 ++--
 6 files changed, 16 insertions(+), 10 deletions(-)
-- 
2.53.0


