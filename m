Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A049F5141C
	for <qemu-devel@archiver.kernel.org>; Sat,  7 Mar 2026 15:43:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vytnA-0001SX-6G; Sat, 07 Mar 2026 10:42:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytn6-0001D6-5C
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:08 -0500
Received: from mail-wm1-x32e.google.com ([2a00:1450:4864:20::32e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1vytn4-0002Qq-J7
 for qemu-devel@nongnu.org; Sat, 07 Mar 2026 10:42:07 -0500
Received: by mail-wm1-x32e.google.com with SMTP id
 5b1f17b1804b1-4852c9b4158so5997025e9.0
 for <qemu-devel@nongnu.org>; Sat, 07 Mar 2026 07:42:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1772898124; x=1773502924; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=3sbiV+H5M06szdNZTbNdyja9k8Sdt8kDUSoFguffq2c=;
 b=ROaXuuGBgruSbmW+4isgZZGjEEDCpxm/fgD8Rgq0BlnAQdYVnXeFfgG04Fs6H99RC/
 AFZdgQrnypttjSH6gGQ9OCHHHFOs6EZE2hFoj/rZIKwgDpNvNKRw5i9/BgZI2ivLzmNr
 xt92tDoCMWFx6DLe1mL+9Aq6rVDsgLYfKR8Q0CvKz/Xy5z4lnCt32G9eEaHRjjM2tZqM
 eEP5TGc/hc5QFW7b8NpqYTDYVAAQipTJEeZKrSJ+Q1CZ7I4BSltFak71SH6ZEyMIRQ6+
 642D6z6cvCQ8Rk2lE3lbyskfdSHItQ3EohjkVyxszBxzuC9n4Fjy0TxTRSqss7zGjCZF
 h3CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772898124; x=1773502924;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3sbiV+H5M06szdNZTbNdyja9k8Sdt8kDUSoFguffq2c=;
 b=PHic9EWub2ouKhO2B3jltc1vgYrSdA9u36QX+hGpG415g8CdBw2UJuTmYCUp39jO78
 Bp4oFfJEjokZ2bk88G9ZVs6+Op36Qmo8W3dLbFb3raMBvjkiE/hqYxscExJarTBNSqUv
 wUPdImVdxtpPdUmQpweoRkMWnXCWCR8wuNBkeg3KO47Yy8hOkvo5mCPYsGQnYGNVMBvA
 uVfIsOW7zBu2jnggpwv5MwBoWQ5zFv8J14pkV1hjatWAwkUUqNndLDj/5s4UVWGfWizM
 1G66YrNheRtW6YHKFrSMHDgpJFfwZAknDHjGlb1G0xoSAvZFM6NbxRgi37p685xLwki3
 7amQ==
X-Gm-Message-State: AOJu0Yx4UxjBRFCkVo5KoWWu1GEUiUNv7DuVCDIOf1wmfSCUmC65+uhl
 epjXKwqQa+E0APfccKflTjLnOCXXrFiWT0pi3FUQPO8hPzryISw3GRrVodOxhTeNoFX1URxGmiD
 +5dcpuJU=
X-Gm-Gg: ATEYQzycpzWDitQx7zhk7AEo+Qlh1Fd/PNhQayXvaEexboS66BVQjWs8odEf3QW39/n
 ApUDwrM41aUW858iPkZPx+yIDaQ+0WSY3/WY93dWtRLB6zobxu81+duBH7CvqnWXwM/WsBKz3ys
 pv46Eo7f/xNiTd+QMe2WbtGQBWDxGjh8BrgYDAvMEErcqbaNdG9DKxoycASgJWsVvXM+Mkj3ABm
 EwsRpS7UqDLJ2bgi9s5GMsPN2LpwsRF029A414qXhTsN11+SPyqV5IAIqa5A46tthzja+Geo/cB
 DhhCEvHtVqSZiZYB5I/tON+x0tO+3AhnK+ch6ly7s+4MZ/wD/xE0v+lWhbqjmK98Iwb+SWf6omU
 EwuUcxBqMTdb5rCGA9ltMaP2wSllkx+KXUxggxiUOajuiZzfFQ+L1O/hfv0VVGdjqW8C6qLw354
 YU//bwa9fFgp4Pn7Ux/S+ouJZbeuGhFrpI15UbvJoGnacj0CAQRI/5M0Cq27kLkd1L2Y7yF18Y
X-Received: by 2002:a05:600c:4710:b0:480:20f1:7abd with SMTP id
 5b1f17b1804b1-48526978dc0mr91060155e9.31.1772898124259; 
 Sat, 07 Mar 2026 07:42:04 -0800 (PST)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4852ad0ce60sm151843335e9.12.2026.03.07.07.42.03
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Sat, 07 Mar 2026 07:42:03 -0800 (PST)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: Igor Mammedov <imammedo@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Yanan Wang <wangyanan55@huawei.com>,
 Thomas Huth <thuth@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>
Subject: [PATCH 0/6] hw/i386/pc: Remove deprecated 4.0 machines
Date: Sat,  7 Mar 2026 16:41:56 +0100
Message-ID: <20260307154202.86309-1-philmd@linaro.org>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32e;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32e.google.com
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

1 y.o. dust Thomas asked me to rebase & post:

The versioned 'pc' and 'q35' machines up to 4.0 been marked
as deprecated two releases ago, and are older than 6 years,
so according to our support policy we can remove them.

Based-on: <20260307152635.83893-1-philmd@linaro.org>
          "hw/i386/pc: Remove deprecated 3.1 machines"

Philippe Mathieu-Daudé (6):
  hw/i386/pc: Remove deprecated pc-q35-4.0[.1] and pc-i440fx-4.0
    machines
  system/hostmem: Remove HostMemoryBackend::use_canonical_path field
  hw/i386/pc: Remove pc_compat_4_0[] array
  hw/core/machine: Remove the hw_compat_4_0[] array
  hw/virtio: Remove VirtIOBalloon::qemu_4_0_config_size field
  hw/rtc/pl031: : Remove PL031State::migrate_tick_offset field

 qapi/qom.json                      |  8 +------
 include/hw/core/boards.h           |  3 ---
 include/hw/i386/pc.h               |  3 ---
 include/hw/rtc/pl031.h             |  1 -
 include/hw/virtio/virtio-balloon.h |  1 -
 include/system/hostmem.h           |  2 +-
 backends/hostmem.c                 | 34 ------------------------------
 hw/core/machine.c                  | 12 -----------
 hw/i386/pc.c                       |  3 ---
 hw/i386/pc_piix.c                  | 11 ----------
 hw/i386/pc_q35.c                   | 25 ----------------------
 hw/rtc/pl031.c                     | 22 -------------------
 hw/virtio/virtio-balloon.c         |  5 -----
 qemu-options.hx                    | 10 ---------
 14 files changed, 2 insertions(+), 138 deletions(-)

-- 
2.52.0


