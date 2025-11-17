Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FC6CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 07:43:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vKttL-0003Sq-OC; Mon, 17 Nov 2025 02:43:19 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtsw-0003Rf-2u
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vKtsu-0005ui-6L
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 02:42:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763365366;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=C0Y4M8+NX7tANAXldXz3ofawHVWZXdO3U/J/Xyv4eaM=;
 b=WRbHsmhJw3rwzNn5wqIWNi1zlLqhKjbGRA+f8Uk/xgW84QiITmcgkMknFnrgjf9aaQ0zam
 FCaWockkuY92Ho58MR8FqQLQPYNuxKCm/qHMGvlVLuiboo2fmRgt9ZzcAU2+vtOHTP3Fgh
 zdBZjBw9MbGBSaeL7gEtelnyA2J9P0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-70-7-rbIaQBMZmC72-W0Zcd8A-1; Mon, 17 Nov 2025 02:42:43 -0500
X-MC-Unique: 7-rbIaQBMZmC72-W0Zcd8A-1
X-Mimecast-MFC-AGG-ID: 7-rbIaQBMZmC72-W0Zcd8A_1763365363
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-42b3086a055so2635412f8f.3
 for <qemu-devel@nongnu.org>; Sun, 16 Nov 2025 23:42:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763365361; x=1763970161; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C0Y4M8+NX7tANAXldXz3ofawHVWZXdO3U/J/Xyv4eaM=;
 b=rDUGd4eTlXx+UaPSLbXXDnles73znBk4O4L9RKwVC73Y5FRBaLm6KZjppkHTuRhFfh
 DRecu8JfAtCHSEUBcy+7nuJsIimu15QSdhv5ncP9rHYQ7nts4ytviZVPS9PgGTCyRzsm
 tNlBECM4qz21kywVXe/UJbxfkdhfeJ3o7am6b9CsEL14JJmn3bzCA/UFfv+zKeDJJbId
 tC8gtA4A8+neAJ0lpXHof7VF0+vx/Zwc8Z36KpRMRWZ6J3bGsDcU2Qg5015g+/8WTWDV
 s4FsrnQIxE+GlfTo3Qh5Iky+29eTpjQutvOliIwyyAp/++w60WV5r8wzeR7jWxjFx2vJ
 3k3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763365361; x=1763970161;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C0Y4M8+NX7tANAXldXz3ofawHVWZXdO3U/J/Xyv4eaM=;
 b=gxPoAMr3mCy9gMDmugnr7JDuyekeIbZWMxc1UifKqUphKn+VyIrB1MtdjslI4WCOD2
 sjwRecuPEOkeAtZnhH/fn40DdTFELZbBSW/nhbfeqZrqOOt1pTAbTrVC3487myW2M3rk
 kTXUMdTP+H0eHlIXnJjbR+txOpBeDYDRhz3L8/pwYWnF576MJH7iLANTfDwgDIGBcoa8
 gdJTCBIrKwsj8hOyByxQIllfNzKtu493Cmed/ucC4hBzIZwbEGSM7338Tmha4NS1Wsqv
 BilRSTw/rN0x3dWUQPp5kmORf3vDkjz24jWyl9WW1rqoc2SnORwN1wLgDmo1y0BQinbc
 W1fg==
X-Gm-Message-State: AOJu0Yxp08gButvegdT5pQteYSlEmPVor38xkER1AoDBPekhlaeoTdO2
 4krbnH3ntPSs2QkhMzdqG39ShLgfmrIUMuGRhfiBv7xIsRX6IvjUwQpMO/2M8cXwYBcRi0HRgl5
 gPNaFCeXSu/GkxvLBmsODRgzq2e4sVNIfaTjQacEDkXB8uL5LngO6eyBQDNEl6Re7/L2hOZcSMp
 dujU6RLCd5f2cSq0jkwWYe24KeyWqM5ohP0iPBCNsI
X-Gm-Gg: ASbGncsrXhV+zxANKK2qYBkOlXnGMPGxoyIiuQOmPQP3pCRwbFcxAo+zjknQ4SsHzMv
 AOgzL8cJTkXommhD0/HBEjUHmTyVCqGLxanE3fdumMM4m82hDgzmTQwDxexUZNMgO6rwreMpv0Z
 kA0bBDMBFFrZ9+LAZtf5NoA7aJ5l4QLJH1Byf1mXxVwXuiT5ncpgYDx77aklAr8geQMW8DZQbBx
 Uuy0Q3Ed3mMokfce2/c0k6fT3ekssNcE5KoOmZanPygLwSJJ3NYhbcy9XU2xTnjvhnGaWvNfglg
 GWZaX05jWJLDxjFbCD7oF+E+v5E6f6acMdjRCavji6PHDCSzjp3yGScy1F+vm3in2EX0ftq2ijr
 IffHvQe6O4Nu594hyWQ5DUUMrxlB101F6bj2/xthXTEgStQvKF15Ji92sHlPKrjpAR/c9/r0qiU
 bf3G6o
X-Received: by 2002:a05:6000:2913:b0:429:c851:69b3 with SMTP id
 ffacd0b85a97d-42b5938687bmr11168249f8f.30.1763365361363; 
 Sun, 16 Nov 2025 23:42:41 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH6uqIQNfbp1MOz1J/AjjpFXN4eYcOq8wtb9PtoJW1kLHKT5b2O3HLURN9g00ellg+coUOPLQ==
X-Received: by 2002:a05:6000:2913:b0:429:c851:69b3 with SMTP id
 ffacd0b85a97d-42b5938687bmr11168200f8f.30.1763365360831; 
 Sun, 16 Nov 2025 23:42:40 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b53e7ae5bsm24647881f8f.8.2025.11.16.23.42.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 16 Nov 2025 23:42:40 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 0/8] rust: add preludes to all crates
Date: Mon, 17 Nov 2025 08:42:30 +0100
Message-ID: <20251117074239.190424-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

This series adds a prelude module to all crates, so that
it becomes possible to import from each crate with either
of the following

   use XYZ::prelude::*;
   use XYZ::{self, prelude::*};

The latter is used for items that have a "too common"
name to be put in the prelude: util::Error, util::Result,
migration::Infallible.

Thanks,

Paolo

Paolo Bonzini (8):
  util: add prelude
  common: add prelude
  hwcore: add prelude
  migration: add prelude
  chardev: add prelude
  bql: add prelude
  system: add prelude
  qom: add more to the prelude

 rust/bql/meson.build              |  1 +
 rust/bql/src/lib.rs               |  5 +++++
 rust/bql/src/prelude.rs           |  4 ++++
 rust/chardev/meson.build          |  1 +
 rust/chardev/src/chardev.rs       |  2 +-
 rust/chardev/src/lib.rs           |  5 +++++
 rust/chardev/src/prelude.rs       |  5 +++++
 rust/common/meson.build           | 13 +------------
 rust/common/src/lib.rs            |  5 +++++
 rust/common/src/prelude.rs        |  9 +++++++++
 rust/hw/char/pl011/src/device.rs  | 22 ++++++++--------------
 rust/hw/core/meson.build          |  1 +
 rust/hw/core/src/lib.rs           |  5 +++++
 rust/hw/core/src/prelude.rs       | 14 ++++++++++++++
 rust/hw/core/src/qdev.rs          |  2 +-
 rust/hw/core/src/sysbus.rs        |  2 +-
 rust/hw/core/tests/tests.rs       |  8 ++++----
 rust/hw/timer/hpet/src/device.rs  | 26 +++++++++-----------------
 rust/hw/timer/hpet/src/fw_cfg.rs  |  2 +-
 rust/migration/meson.build        |  1 +
 rust/migration/src/lib.rs         |  5 +++++
 rust/migration/src/migratable.rs  |  2 +-
 rust/migration/src/prelude.rs     | 19 +++++++++++++++++++
 rust/qom/src/prelude.rs           |  4 ++++
 rust/system/meson.build           |  1 +
 rust/system/src/lib.rs            |  5 +++++
 rust/system/src/prelude.rs        |  8 ++++++++
 rust/tests/tests/vmstate_tests.rs |  7 +++----
 rust/util/meson.build             |  1 +
 rust/util/src/lib.rs              |  5 +++++
 rust/util/src/prelude.rs          | 11 +++++++++++
 31 files changed, 145 insertions(+), 56 deletions(-)
 create mode 100644 rust/bql/src/prelude.rs
 create mode 100644 rust/chardev/src/prelude.rs
 create mode 100644 rust/common/src/prelude.rs
 create mode 100644 rust/hw/core/src/prelude.rs
 create mode 100644 rust/migration/src/prelude.rs
 create mode 100644 rust/system/src/prelude.rs
 create mode 100644 rust/util/src/prelude.rs

-- 
2.51.1


