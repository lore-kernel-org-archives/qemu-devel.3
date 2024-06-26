Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B8B8C27C4F
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Jun 2024 11:07:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sMQU9-0005F8-9l; Wed, 26 Jun 2024 07:06:45 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQU8-0005EO-2t
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:44 -0400
Received: from mail-pg1-x533.google.com ([2607:f8b0:4864:20::533])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1sMQU5-0004dQ-3q
 for qemu-devel@nongnu.org; Wed, 26 Jun 2024 07:06:43 -0400
Received: by mail-pg1-x533.google.com with SMTP id
 41be03b00d2f7-718354c17e4so3231786a12.1
 for <qemu-devel@nongnu.org>; Wed, 26 Jun 2024 04:06:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1719399999; x=1720004799;
 darn=nongnu.org; 
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=aVMd78b6JawTzRGixWbj2f43TTFf+ku1C/f1kUzbhHI=;
 b=xtEdbG08MVbLd/rSixsmAk4+qqSd+jtlQlSE+rO12qxLQdSrhsA6JMZqHqo3N6DqCk
 mc6U+q5GyN9SMPu0SDVkjMSms4rqd28sLkd3irZrBsQDTuhVz0elMax05s34+RtkfnH9
 w2ZNpSsjGU77lboJs1yQTPwMRU2imKOjDcSmvydwpEO5HvZngp3Qdm9840Sv8V49Y8ev
 RN5au6dfueS2An07W6b56yqp0vSP9KYl8rLLeEwcPFEvAL/l+dlac7XDSODNGFsMgeBD
 q1uLGu6Pn/owZU/x2ZAQBdIHCL/37jFMbDe619LWB4auF44EAIJ/gp0KHMJEwPJW+hJp
 FFaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1719399999; x=1720004799;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aVMd78b6JawTzRGixWbj2f43TTFf+ku1C/f1kUzbhHI=;
 b=nAfjn04wp9SG5/9cXY+jH8HYD5FN10vDLiG0BdJ4hlDmT34lwTE3z1dCJch52wJH+x
 4Qc7Wp/K3qftiOfvrp7xMOWfbeYHw9eb2XXDhq2poNwDDQ3IWO9YDctWKFzSB2VlM3Lz
 GB7HuYTQHh9IvnMkC622kv0HvEaXzOiUJBaTYREe31DA/voGvVx9YWTviWskTaINp6Cj
 Zn5JnblIO860QTk8H6+IYQR52qpmR6aYaHFjGqUQ2lbaIMh2+c+yOQ3f2C8EzcurK7WP
 IOp0H72myiFesH83M8HslWCkQNsAxubJyRUQBQpiHc03tokSCh7daWKgbkJe12Od/AP0
 VbyA==
X-Gm-Message-State: AOJu0YzpBS7FLKUV1j7CSYSIxrZvN9973uju7m3p7rSMYUQqeXIZ0lsq
 bty4FBXd9rer34TEDrsFSAgE0a7oHwgAGu0azsmwvrXHtD7Qal994DDrogP9I1k=
X-Google-Smtp-Source: AGHT+IG1bzoSOGYQ2lGHznKmZQGCC60NwCu2HAQyoTDeJ7aUrVSGq5FWysUjahFzyDBY8jXiMZeY3Q==
X-Received: by 2002:a05:6a20:1dc:b0:1be:c3c8:10f3 with SMTP id
 adf61e73a8af0-1bec3c81354mr575694637.9.1719399999159; 
 Wed, 26 Jun 2024 04:06:39 -0700 (PDT)
Received: from localhost ([157.82.204.135])
 by smtp.gmail.com with UTF8SMTPSA id
 d2e1a72fcca58-70672e24d7asm6842235b3a.114.2024.06.26.04.06.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 Jun 2024 04:06:38 -0700 (PDT)
From: Akihiko Odaki <akihiko.odaki@daynix.com>
Subject: [PATCH 00/14] Fix check-qtest-ppc64 sanitizer errors
Date: Wed, 26 Jun 2024 20:06:23 +0900
Message-Id: <20240626-san-v1-0-f3cc42302189@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAC/2e2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMyNT3eLEPF0DS/PEtMQ0kzTDZCMloMqCotS0zAqwKdGxtbUAKu9zylU
 AAAA=
To: Eduardo Habkost <eduardo@habkost.net>, 
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>, 
 =?utf-8?q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>, 
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>, 
 BALATON Zoltan <balaton@eik.bme.hu>, Jiaxun Yang <jiaxun.yang@flygoat.com>, 
 Nicholas Piggin <npiggin@gmail.com>, 
 Daniel Henrique Barboza <danielhb413@gmail.com>, 
 David Gibson <david@gibson.dropbear.id.au>, 
 Harsh Prateek Bora <harshpb@linux.ibm.com>, 
 Alexey Kardashevskiy <aik@ozlabs.ru>, "Michael S. Tsirkin" <mst@redhat.com>, 
 =?utf-8?q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, 
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>, 
 Paolo Bonzini <pbonzini@redhat.com>, David Hildenbrand <david@redhat.com>, 
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org, qemu-ppc@nongnu.org, 
 Akihiko Odaki <akihiko.odaki@daynix.com>
X-Mailer: b4 0.14-dev-fd6e3
Received-SPF: none client-ip=2607:f8b0:4864:20::533;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x533.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=unavailable autolearn_force=no
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

I saw various sanitizer errors when running check-qtest-ppc64. While
I could just turn off sanitizers, I decided to tackle them this time.

Unfortunately, GLib does not free test data in some cases so some
sanitizer errors remain. All sanitizer errors will be gone with this
patch series combined with the following change for GLib:
https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
---
Akihiko Odaki (14):
      hw/core: Free CPUState allocations
      hw/ide: Free macio-ide IRQs
      hw/isa/vt82c686: Free irqs
      spapr: Free stdout path
      ppc/vof: Fix unaligned FDT property access
      hw/virtio: Free vqs before vhost_dev_cleanup()
      migration: Free removed SaveStateEntry
      memory: Do not create circular reference with subregion
      tests/qtest: Use qtest_add_data_func_full()
      tests/qtest: Free unused QMP response
      tests/qtest: Free old machine variable name
      tests/qtest: Delete previous boot file
      tests/qtest: Free paths
      tests/qtest: Free GThread

 hw/core/cpu-common.c                 |  3 +++
 hw/ide/macio.c                       |  9 +++++++++
 hw/isa/vt82c686.c                    |  3 ++-
 hw/ppc/spapr_vof.c                   |  2 +-
 hw/ppc/vof.c                         |  2 +-
 hw/virtio/vhost-user-base.c          |  2 ++
 migration/savevm.c                   |  2 ++
 system/memory.c                      | 11 +++++++++--
 tests/qtest/device-introspect-test.c |  7 +++----
 tests/qtest/libqtest.c               |  3 +++
 tests/qtest/migration-test.c         | 18 +++++++++++-------
 tests/qtest/qos-test.c               | 16 ++++++++++++----
 tests/qtest/vhost-user-test.c        |  6 +++---
 13 files changed, 61 insertions(+), 23 deletions(-)
---
base-commit: 74abb45dac6979e7ff76172b7f0a24e869405184
change-id: 20240625-san-097afaf4f1c2

Best regards,
-- 
Akihiko Odaki <akihiko.odaki@daynix.com>


