Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C0F5CAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 16:46:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v3zxR-00041G-5c; Wed, 01 Oct 2025 12:45:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zxA-0003wi-Fp
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:26 -0400
Received: from mail-wm1-x331.google.com ([2a00:1450:4864:20::331])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1v3zx1-00081k-8f
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 12:45:18 -0400
Received: by mail-wm1-x331.google.com with SMTP id
 5b1f17b1804b1-46e52279279so30735e9.3
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 09:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1759337098; x=1759941898; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=tPaV+VFWxQXUIKu08GdGOFPhuZfOnUHddrLWV+7K1Lw=;
 b=e6Ek/HcMVpojx6AdQB4UUJSeFb/ZRgphbgDWDP5j0rDDBI2Eu/Kz6UsCknqwS3jpJZ
 hMLCJQCBBW/Ou590a0Xpyh7jdPILU9CkaOKchY4KQmmlaOwE2ICvHoSR7Qo2/Bk9oCKP
 lxMB763uC461GOW9pUlwW1yIxRbpKgL/+GxBcubjkHp/L5sf0uRwA58wtYng0Nz5qD7U
 OOSoYcZbLEl1IDfr6ZngQRh9ijjPa+NgUwfYmd1A19F0EMDA73QG0n0QGhagUJxJUQs7
 wF+r6FokR7QdwqTGyQKHn0WOGhpfUsf4Zc7ey57oDj6RUPoBsPkc9ppfSao56QQH53z0
 KAgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759337098; x=1759941898;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=tPaV+VFWxQXUIKu08GdGOFPhuZfOnUHddrLWV+7K1Lw=;
 b=OFPMm9KEYvrF8nWK6sYVCZs12fhqbN4EmwOArIa8f1zt3Oar0ourGd4E6rrKfsKduC
 Rod4xptB8Fjk+mAnKIcweT9zzKQAbe5jWqX0sVWLJawuTF369U3ukN7EB4t/uyPxHNSW
 jRmUSO+ALEjYlvhxQ+TtttjAI754/D74YVy29EHz8FVPZHNRzC7jC4ojSJedAsXs6RH+
 TpSRhBa0wyNrFYzXDFc0n6+TJcI+3si8k8jWV0GbU964CiO04MxxL5iewaRnHUPH5qvx
 J2zev84E0yDJnx4z81lt2WfVhqlSruSVDIgHBWFcAkYj5wATnvbgNjZtpjEZwDLfiDIz
 zUIw==
X-Gm-Message-State: AOJu0YxmlTiqJ3WXLZYuUXjj6isphSR58uK7GrnEC4SNv+/LDhc4wgrO
 eHjFSyLU2FpRN4SslZcT143GUBlcV0UCEE3B7wXsggjAqZ4KZJ4EmuHPpW29Ij7QUhgU40oucDV
 nzT4TfT5iCA==
X-Gm-Gg: ASbGncuqtav17kDm46nSEo2YBSijTxfDCBQoOVjYXxUF4pw+GvsUZYKXCkMtf7hKxkb
 7yLggpcUAZl+Jyi8in6djmow/yzgnMv9QyabV3Ft13PJ+NMD3Ai18Iaw6cJ25aHaih9FgelPwDk
 AoxJ98BsS04DsMvQdby0isDIUFEiNRYCLeYQjl10eqfnm91OvJ3k187tLWe4LSQ0ORZEgSqdOlI
 07MuL6ekmeBWn7/VC/0EMHB3Na0+fADN0mTTnNu7kWSNZY71FkKVPVOsnvteC7epON0k0Z7Qmke
 PeAt8pcdJe/WG451lxY0bTpnoHpxADUpZCJavK9OCb88K0r6jgscjSWJzS9ZVAoryFIKkCsAlvE
 Oh6ARRZW8rOOJFxYSMb4B/tCLYFTS4JaXPabUm+F6+vqejDtg1jfNlcNp0OFenDGv6ReKjJniZI
 mqR7yA9F3H7lsLXFjvGPTh
X-Google-Smtp-Source: AGHT+IEkbIsBMTIstQ0lP9y8hSs1E0dcxoBKUVnIcQD9/CDQ0YIod8B2npgW5sGEVlTBXLntX/axNQ==
X-Received: by 2002:a05:6000:24c8:b0:3f9:1571:fdea with SMTP id
 ffacd0b85a97d-4255781b8d0mr3521580f8f.44.1759337098555; 
 Wed, 01 Oct 2025 09:44:58 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-40fc6cf3835sm27970896f8f.46.2025.10.01.09.44.57
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Wed, 01 Oct 2025 09:44:58 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, kvm@vger.kernel.org,
 Peter Xu <peterx@redhat.com>,
 "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 David Hildenbrand <david@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PATCH v2 0/6] system/ramblock: Sanitize header
Date: Wed,  1 Oct 2025 18:44:50 +0200
Message-ID: <20251001164456.3230-1-philmd@linaro.org>
X-Mailer: git-send-email 2.51.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::331;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x331.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Usual API cleanups, here focusing on RAMBlock API:
move few prototypes out of "exec/cpu-common.h" and
"system/ram_addr.h" to "system/ramblock.h".

v2:
- Do not use ram_addr_t for offsets (rth)

Philippe Mathieu-Daudé (6):
  system/ramblock: Remove obsolete comment
  system/ramblock: Move ram_block_is_pmem() declaration
  system/ramblock: Move ram_block_discard_*_range() declarations
  system/ramblock: Use ram_addr_t in ram_block_discard_guest_memfd_range
  system/ramblock: Use ram_addr_t in ram_block_discard_range()
  system/ramblock: Move RAMBlock helpers out of "system/ram_addr.h"

 include/exec/cpu-common.h                 |  3 ---
 include/system/ram_addr.h                 | 13 ---------
 include/system/ramblock.h                 | 27 +++++++++++++++----
 accel/kvm/kvm-all.c                       |  1 +
 hw/hyperv/hv-balloon-our_range_memslots.c |  1 +
 hw/virtio/virtio-balloon.c                |  1 +
 hw/virtio/virtio-mem.c                    |  1 +
 migration/ram.c                           |  3 ++-
 system/physmem.c                          | 33 ++++++++++++-----------
 9 files changed, 45 insertions(+), 38 deletions(-)

-- 
2.51.0


