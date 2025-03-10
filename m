Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF0B6C282DE
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Mar 2025 15:15:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1treq8-0007MP-UY; Mon, 10 Mar 2025 11:14:52 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trepk-0006uf-To
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:14:25 -0400
Received: from mail-wm1-x32b.google.com ([2a00:1450:4864:20::32b])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1trepi-00082r-EG
 for qemu-devel@nongnu.org; Mon, 10 Mar 2025 11:14:24 -0400
Received: by mail-wm1-x32b.google.com with SMTP id
 5b1f17b1804b1-43cec5cd73bso10623185e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Mar 2025 08:14:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1741619657; x=1742224457; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=cYRtVdei7pNdl/ANTtkKx+JpRO5AgxaFdT9Rt3FJCQw=;
 b=JzMsr0I94dh5cXkovmbsySr4cPbi5s1R3S+kQdK5/8rBeqKVriprICN5TWJKFG8If3
 9xTa+zSYf9aDVDMbEzNPoO5DVgymCwuw+0f/udIdIyhlFbfm/L5nZ+vSi2dTRnnhm6+a
 YUSJ6yQ5TokM+dEEUgSjhbc4DImde7s087l1eMEJInCbxyG7/w+XbZGs7B9rdjhxWu+B
 0rP7NdppZADQzFT5kM6s13gnJXZrnIzq9oZovWY2pxQ6DW2NsU7DA4pt8Xa7Z/lX5TVf
 lOlV8rOjQ6sgKqqrrmgq8dsH2gM3QxcKlBvjdN+QKkpQaQJ0X7xtAxMpLHikuB4xLHfx
 eChQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741619657; x=1742224457;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=cYRtVdei7pNdl/ANTtkKx+JpRO5AgxaFdT9Rt3FJCQw=;
 b=dBQnkoCMjV91CJrdMHNTXsCrxQ0XYYsqM3Xm7FwSSNpHCTtk9SWJVFexkC8L57s4ay
 86+KAjdfMqyZdJ1IlNHGy4DFHbr6VQS+p3NLOXNdq/EMMFN2wPDtOkI1LFvrE59x/t1H
 XZ5jA6p92yFj34MQfzuC8BTPWDqEuJuvpyjWhXAbVY/PSTRDPxM+MrwBesQwb55nSwM5
 1d7qOfIQqYsZ1A982D170x5ZGVw0xArlqkN0EzcYcaS/HclNYxedGRhXHF5YY14aN7A0
 Ju5x6aYuios/r6UJVSr23yvm22EDLehmAxo+QQwiC6sALFx7RTGcgFVy6JNj21k37BfF
 xTFg==
X-Gm-Message-State: AOJu0Yz+Zr1LJhth3vLibYCMarWu9K6AFNgF0cJJnqmrm6vZ2frKrS6Z
 tEPLq1UGO47MN7L8AqB7UAQcSDbQzxms/YTgux4Jz2Co8BHW7rh5uBK3j6zqgsUH7RkiyRYco8r
 rE3M=
X-Gm-Gg: ASbGncs3ixCenVa7+QGu3bDAyqA13G2p5omF3B8u3Szm3xA/PvTDXdy9ebYJs3d6zs9
 TIRVCTU8H7+9nV+6OT8r4j1yGUI5VuRWd8Lu0A64k0ODxl9QTm2snN0n6jsmtBwCjPY3SOxbO+p
 O+5vHO+aKvw7CWluzGY0aG9egRd/emk4nQMxh+y/sPbEmc+KmYiMi7GEMXnbSDLJM4R1dFg2z6K
 b45YJ6kz55k+BIGd/pmnwTOzxUm6p9jwbqjgo1b7D/3HMc4Ix3zfElew+o64zG3RH2KmN8zczMe
 4ODNqJ3rW5k4wLZyNnkXgFjwar3OpXxZt7dvhh3UzgMicZreYoXd9vCgzi2EBAnrvIc2mQBGNuX
 5HA6FUTBTBqtl4l0991s=
X-Google-Smtp-Source: AGHT+IGOflPdn5gR0UFWl+f4o3k0xEeNcM5QTiE2SuwN7EuOlX8YvcKf/oU0XQ+eKjHnQj35LRYeUg==
X-Received: by 2002:a05:600c:1c14:b0:43c:f0ae:da7 with SMTP id
 5b1f17b1804b1-43cf0ae15acmr42364365e9.7.1741619657467; 
 Mon, 10 Mar 2025 08:14:17 -0700 (PDT)
Received: from localhost.localdomain (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43ce5c35709sm89530915e9.19.2025.03.10.08.14.15
 (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
 Mon, 10 Mar 2025 08:14:16 -0700 (PDT)
From: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
To: qemu-devel@nongnu.org
Cc: qemu-s390x@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Thomas Huth <thuth@redhat.com>, David Hildenbrand <david@redhat.com>,
 Anton Johansson <anjo@rev.ng>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Zhao Liu <zhao1.liu@intel.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Ilya Leoshkevich <iii@linux.ibm.com>,
 Eduardo Habkost <eduardo@habkost.net>, Yanan Wang <wangyanan55@huawei.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Halil Pasic <pasic@linux.ibm.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Markus Armbruster <armbru@redhat.com>, Eric Farman <farman@linux.ibm.com>
Subject: [PATCH v3 0/4] qapi/machine: Make @dump-skeys command generic
Date: Mon, 10 Mar 2025 16:14:10 +0100
Message-ID: <20250310151414.11550-1-philmd@linaro.org>
X-Mailer: git-send-email 2.47.1
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::32b;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x32b.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

We are trying to unify all qemu-system-FOO to a single binary.
In order to do that we need to remove QAPI target specific code.

Introduce the TYPE_DUMP_SKEYS_INTERFACE type which provide the
qmp_dump_skeys() callback, have it implemented on the CCW machine.
Machines not supporting this interface report a QMP GenericError.
No HMP change.

Since v2:
- Use machine interface (Daniel)

Since v1 [*]:
- No QMP rename / deprecation

[*] https://lore.kernel.org/qemu-devel/20240530074544.25444-1-philmd@linaro.org/

Philippe Mathieu-Daudé (4):
  hw/s390x/skeys: Declare QOM types using DEFINE_TYPES() macro
  hw/s390x/skeys: Introduce TYPE_DUMP_SKEYS_INTERFACE
  hw/s390x/ccw: Have CCW machine implement a qmp_dump_skeys() callback
  qapi/machine: Make @dump-skeys command generic

 qapi/machine.json               | 18 +++++++++++++
 qapi/misc-target.json           | 19 -------------
 include/hw/s390x/storage-keys.h | 16 +++++++++++
 hw/core/machine-qmp-cmds.c      | 14 ++++++++++
 hw/s390x/s390-skeys.c           | 47 +++++++++++++++++----------------
 hw/s390x/s390-virtio-ccw.c      |  3 +++
 6 files changed, 75 insertions(+), 42 deletions(-)

-- 
2.47.1


