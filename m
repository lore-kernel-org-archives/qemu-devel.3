Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4B639C48286
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jan 2024 13:08:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rSzRr-0005Eb-Hd; Thu, 25 Jan 2024 08:07:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRn-000567-Vh
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:12 -0500
Received: from mail-ed1-x530.google.com ([2a00:1450:4864:20::530])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <andrew@daynix.com>) id 1rSzRl-0001kn-Lf
 for qemu-devel@nongnu.org; Thu, 25 Jan 2024 08:07:11 -0500
Received: by mail-ed1-x530.google.com with SMTP id
 4fb4d7f45d1cf-558f523c072so7996189a12.2
 for <qemu-devel@nongnu.org>; Thu, 25 Jan 2024 05:07:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1706188024; x=1706792824;
 darn=nongnu.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=M3SM6i36WcoNv9Eb0tJ7o9bjxd/YEs0hdGEkoQAyC6E=;
 b=BvvIQozjVCGQQTwyVbqlX8uR6Zbc3sMxf8ePZlV3diQoy3wfSPwINgpgoA6/OWItOO
 sYe3TBrHUw8JOWcP5o4D286iGHDvr+iPtl70LW+oLGLO7Ze953nBbYuQfbhYQEpgYU3e
 dnPBAwdduENY4hc7mGcmxfZoyyyjVjgk7XzD7ISJ0vdWqIgyVw/ZObO6TmmTpkV5nxYn
 cvQABl32UzXs/u/YdzjQewRbjZoglujfVofV78DWO/Iva5U2n+z9uea3GLI2WMXsdQs5
 UyPLwV7KWfOo74Syj9f9WIUkWpAfnkncQqI3ZpjiqRp9v9YAiu4D6a56fZKSf6I7ZwcO
 6ZiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1706188024; x=1706792824;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=M3SM6i36WcoNv9Eb0tJ7o9bjxd/YEs0hdGEkoQAyC6E=;
 b=tJjxlrYS5Y/TtxDvh/QhuR50qS3mMM2CprxYDzbjQnbSnKLsxUyNn+LlsVChI8vH4m
 h2hfevjy7ZnZ7L90aUSfUY/PwGUHupT4HAYL7bJUAHOkC7FS/5xvH/LbgbzRV8kWiFPW
 uSiRj+nmzSrRaILAMG20N2DzyOdr3FQ+rzjbLOW3jtTzW78rjfvgFvoXNkpsQaTpsoFl
 GdN+7BYvUuWdsOFCoUuzL6adRqdr/pftDfaqOljJahP/fN2r2iWLwPVKa21gI5ZQnbHO
 CouSVYu1lvj1OG2m2rnlwsoz+UgkX+JgAwWkro2lOLsFWSaWdMCgm5bqZz+ouUiTnNDh
 SxmQ==
X-Gm-Message-State: AOJu0YyZSFf7EYrL8nzYq91WzHnIXUT7KYoRfI+S4pbs7PYSeMs4pAgO
 B9SkyRUy/q9pG2Jv4g5rVf4eO+bG834L7qaVocIIiZWPUlMoJ9FV85YCtP0KXnk=
X-Google-Smtp-Source: AGHT+IEG52o369ZBCvCOMzSLF6l9YFR1MU39Y7EQi6nA2qDJyH3EUKDv30egbeMwYbMGdOfHDUX7dg==
X-Received: by 2002:aa7:dad0:0:b0:55c:415:612a with SMTP id
 x16-20020aa7dad0000000b0055c0415612amr302482eds.151.1706188023768; 
 Thu, 25 Jan 2024 05:07:03 -0800 (PST)
Received: from navi.cosmonova.net.ua ([95.67.24.131])
 by smtp.gmail.com with ESMTPSA id
 er25-20020a056402449900b0055a829811ddsm6558709edb.48.2024.01.25.05.07.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jan 2024 05:07:03 -0800 (PST)
From: Andrew Melnychenko <andrew@daynix.com>
To: jasowang@redhat.com, mst@redhat.com, armbru@redhat.com, eblake@redhat.com,
 qemu-devel@nongnu.org, berrange@redhat.com
Cc: yuri.benditovich@daynix.com,
	yan@daynix.com,
	akihiko.odaki@daynix.com
Subject: [PATCH v8 0/5] eBPF RSS through QMP support.
Date: Thu, 25 Jan 2024 15:06:49 +0200
Message-ID: <20240125130656.425607-1-andrew@daynix.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2a00:1450:4864:20::530;
 envelope-from=andrew@daynix.com; helo=mail-ed1-x530.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

This series of patches provides the ability to retrieve eBPF program
through qmp, so management application may load bpf blob with proper capabilities.
Now, virtio-net devices can accept eBPF programs and maps through properties
as external file descriptors. Access to the eBPF map is direct through mmap()
call, so it should not require additional capabilities to bpf* calls.
eBPF file descriptors can be passed to QEMU from parent process or by unix
socket with sendfd() qmp command.

Changes since v8:
 * rebased and refactored QMP interface

Changes since v7:
 * rebased and refactored
 * used SPDX license identifier
 * used DEFINE_PROP_ARRAY() for virtio-net "ebpf-rss-fds" property

Changes since v6:
 * added comments to ebpf.json
 * added libbpf version requirements to meson script with BPF_F_MMAPABLE check

Changes since v5:
 * refactored ebpf.json

Changes since v4:
 * refactored commit hunks
 * added explicit BPF_F_MMAPABLE declaration

Changes since v3:
 * fixed issue with the build if bpf disabled
 * rebased to the last master
 * refactored according to review

Changes since v2:
 * moved/refactored QMP command
 * refactored virtio-net

Changes since v1:
 * refactored virtio-net
 * moved hunks for ebpf mmap()
 * added qmp enum for eBPF id.
 
Andrew Melnychenko (5):
  ebpf: Added eBPF map update through mmap.
  ebpf: Added eBPF initialization by fds.
  virtio-net: Added property to load eBPF RSS with fds.
  qmp: Added new command to retrieve eBPF blob.
  ebpf: Updated eBPF program and skeleton.

 ebpf/ebpf.c                    |   69 ++
 ebpf/ebpf.h                    |   29 +
 ebpf/ebpf_rss-stub.c           |    9 +-
 ebpf/ebpf_rss.c                |  153 +++-
 ebpf/ebpf_rss.h                |   13 +-
 ebpf/meson.build               |    2 +-
 ebpf/rss.bpf.skeleton.h        | 1343 ++++++++++++++++----------------
 hw/net/virtio-net.c            |   63 +-
 include/hw/virtio/virtio-net.h |    2 +
 meson.build                    |   10 +-
 qapi/ebpf.json                 |   66 ++
 qapi/meson.build               |    1 +
 qapi/qapi-schema.json          |    1 +
 tools/ebpf/rss.bpf.c           |    7 +-
 14 files changed, 1059 insertions(+), 709 deletions(-)
 create mode 100644 ebpf/ebpf.c
 create mode 100644 ebpf/ebpf.h
 create mode 100644 qapi/ebpf.json

-- 
2.43.0


