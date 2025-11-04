Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B235DCCF9E3
	for <qemu-devel@archiver.kernel.org>; Tue,  4 Nov 2025 16:31:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vGJwS-0007dE-KL; Tue, 04 Nov 2025 11:31:36 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJwB-0007c9-Ta
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vGJw6-0003x2-9H
 for qemu-devel@nongnu.org; Tue, 04 Nov 2025 11:31:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762273868;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=mZhOhNk8L+ywXDZp/a6UEPcgmooSTjn81Iqhl627VxA=;
 b=dUclAZef/EjomaDfaqN/d0uLvtT4M6pXNyDfI56gM8Qokvq++5lkiuszmKwZaPIaz+TrE9
 kFAWrp24gqp50b+zoynLQWor5ajN+dD2dxUMjwFGD2f5swrpyl3m3uEVhhhST1EqCT6zBJ
 J6VCMu2/n8nu4iDpICBVH2UTNrJj0Do=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-QazH3NnIMVGWfsvcI8gC9A-1; Tue, 04 Nov 2025 11:31:06 -0500
X-MC-Unique: QazH3NnIMVGWfsvcI8gC9A-1
X-Mimecast-MFC-AGG-ID: QazH3NnIMVGWfsvcI8gC9A_1762273865
Received: by mail-ed1-f71.google.com with SMTP id
 4fb4d7f45d1cf-640bb21b512so2880362a12.0
 for <qemu-devel@nongnu.org>; Tue, 04 Nov 2025 08:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762273865; x=1762878665; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mZhOhNk8L+ywXDZp/a6UEPcgmooSTjn81Iqhl627VxA=;
 b=Aopc9QZug5vO34/M1sh/f+dg7B1pl7CqKTKM4RinrgBULgN6ranI3u24CBl8Hscyxj
 R7eNFSfDfnk+iqzq3+qULlUY2wiV1z4AdleaiOiNrahK62Hcq2fsuDLDEXUKLvowGm4T
 c0DZrZSElYevC6EHB3KvWT5SGcqKKblWC9SE+x2Za/5n072lHc1SsAz3bY0NAgSu9nQv
 iqmfaZcoTPaS8mRYo4AWRtI8PQNY9iizp+ybqael2c4kdwIuZ6FlbUGJf7y4vFd+H5ey
 QiujDy+qQEfQt+cs8/U+S5oiGOiFIiEuqIZaXFG7SV8K6itmuP/IHYyCGfHvDfJCMNzT
 scoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762273865; x=1762878665;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=mZhOhNk8L+ywXDZp/a6UEPcgmooSTjn81Iqhl627VxA=;
 b=PiAT+SAytFMU9xbOBxc7D0oz3Qq8CdsCaOwBcGK5mRa2bSF4/NDvnCMb6d+AeELAUI
 3GJh2edFCFjfQnWEk4sm4gVm56SQRDTzGday3tyw+LC3edcwz8eTppcW3CzwXMMXcFm+
 zUWyCc2v1FZKurYRu/uBRzY5zedaEvvDTOplyvT1fwJsIHJjMuguQaeAj0oPIGsRT6QA
 JRNUH3z4MEkMzB5rukSfMWNP3dSsrIp114GMcUKOj6Cg5lL5ViEpB1MphOZR0KD06fqt
 W4pITqLzyxx7rS/EKcoVKKDpiWE6ixE1IGftN9aSzFqo22cABlMjsCmrQEBS0BYThVzz
 /Atw==
X-Gm-Message-State: AOJu0YyIvvk4alw9xF6OhpCFfyoNWBDD+FXH6zEOA6+y6B+FQQZT0Uuw
 Mqbw4w8oLSOXxZE5Bsos7O2rfV16p4nxCMROZQLGGQVoYj4hrQHg5lSlcDdmYIXP0GCQczGBce9
 vyhe3BLYhrn7vR1LBNQzDDA2H8kJoQDknb3WrBhPghpjCycx8uGLokcpi4b2BF+8f55BoVaPfll
 TVAxy+CDN+8d2W3QaAKnfYYjlZAXsDCt5xN77Jspda
X-Gm-Gg: ASbGncsfj+68g0XHzfF29bNsUktVY5D4FMUNd/F7GpvbE7x8683GqlyP1bKwazR7zWX
 E4qBYO8NCEt3Bwp3/V2Eyq0vJqIBQQ/bDIboTJOxLUOUk76pDCX6jXGEjJhJ6YSjhqnTRjX5Kd/
 ecjgYIb9i53LowXaEXeqgq7ShcgJACPwK8epM3V1P5zVnghnLFzX4JnDfqAfLaGj6GQHOoMv/Kn
 cLyvBJ9UQO9zm1FDPc7gsm9ggrb6fP0smujo7D9+ES6uWEUulLildXJtkg/qQaYBf1TsMUE5yrT
 OelZlINq7tKIeKPV+c52KOtxq0i6PCwltZvRhngUsaDSMhmO6eSh2+5evPsRs/HU42xHBRc0Cex
 4gkRrZ06ctNErUXLaKuKya8Amch5nZ2peJWv13IB1MadI+7puTqzDp7oHiNGyui4MLkP/qzwEAm
 XL7i41
X-Received: by 2002:a17:907:97d0:b0:b40:8954:a8a9 with SMTP id
 a640c23a62f3a-b70704bc29fmr1576258366b.34.1762273864615; 
 Tue, 04 Nov 2025 08:31:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF83Hz9tcxY+yNI3WdPeblCsv23rjZa+NQ3lJNLOllvaDSumAjXlhTi+NJl3O2LEoo2VZpu1A==
X-Received: by 2002:a17:907:97d0:b0:b40:8954:a8a9 with SMTP id
 a640c23a62f3a-b70704bc29fmr1576256366b.34.1762273864125; 
 Tue, 04 Nov 2025 08:31:04 -0800 (PST)
Received: from [192.168.10.48] ([151.95.110.222])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b723db0f1besm252102366b.31.2025.11.04.08.31.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 04 Nov 2025 08:31:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/8] Cleanup patches for QEMU 10.2 soft freeze
Date: Tue,  4 Nov 2025 17:30:54 +0100
Message-ID: <20251104163102.738889-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.788,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

The following changes since commit a8e63c013016f9ff981689189c5b063551d04559:

  Merge tag 'igvm-20251103--pull-request' of https://gitlab.com/kraxel/qemu into staging (2025-11-03 10:21:01 +0100)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to fdeeb448458f0ed808a62314b57974ab16d3592e:

  rust: add back to Ubuntu 22.04 jobs (2025-11-04 17:13:25 +0100)

----------------------------------------------------------------
* rust: cleanup Error, add &error_fatal bindings
* rust: do not add qemuutil to Rust crates
* rust: migration: allow nested offset_of
* rust: add back to Ubuntu 22.04 jobs
* checkpatch: remove bogus patch prefix warning

----------------------------------------------------------------
Paolo Bonzini (7):
      rust/util: add ensure macro
      rust/util: use anyhow's native chaining capabilities
      rust/util: replace Error::err_or_unit/err_or_else with Error::with_errp
      rust: pull error_fatal out of SysbusDeviceMethods::sysbus_realize
      rust: do not add qemuutil to Rust crates
      rust: migration: allow nested offset_of
      rust: add back to Ubuntu 22.04 jobs

Vladimir Sementsov-Ogievskiy (1):
      scripts/checkpatch.pl: remove bogus patch prefix warning

 docs/about/build-platforms.rst                   |  10 +-
 .gitlab-ci.d/buildtest.yml                       |   2 +-
 rust/chardev/meson.build                         |   2 +-
 rust/hw/char/pl011/src/device.rs                 |   4 +-
 rust/hw/core/src/sysbus.rs                       |  13 +-
 rust/hw/timer/hpet/src/device.rs                 |  21 +-
 rust/hw/timer/hpet/src/fw_cfg.rs                 |   7 +-
 rust/migration/src/vmstate.rs                    |  12 +-
 rust/util/meson.build                            |   2 +-
 rust/util/src/error.rs                           | 272 +++++++++++++----------
 rust/util/src/lib.rs                             |   2 +-
 scripts/checkpatch.pl                            |   8 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-aarch64.yaml |   2 +-
 scripts/ci/setup/ubuntu/ubuntu-2404-s390x.yaml   |   2 +-
 tests/docker/dockerfiles/ubuntu2204.docker       |   6 +-
 tests/lcitool/mappings.yml                       |   4 +-
 tests/lcitool/refresh                            |   4 +-
 17 files changed, 207 insertions(+), 166 deletions(-)
-- 
2.51.1


