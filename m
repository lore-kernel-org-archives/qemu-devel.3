Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 691C3C021A1
	for <qemu-devel@archiver.kernel.org>; Tue, 11 Feb 2025 22:51:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thz62-0005be-1Y; Tue, 11 Feb 2025 17:51:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz60-0005bK-MF
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:12 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1thz5y-00052f-Cy
 for qemu-devel@nongnu.org; Tue, 11 Feb 2025 17:51:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739314269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=kLidyKEQz+z7EePA4Gpsn6MuzeO6r7+SbEpEclErY9w=;
 b=XSce88bBYPSsDSwMAoHFqa2JMe91QNjJDKD81zQMiuYwjgU0zaVtC3teI85iNOE2n/LTjv
 fWUaM3YS5dTnpbDzGyeYIWwKkgucePuc1rx5R03AV3NpMJYPcB0nTt1Y6SBK2WA+0+uIfl
 AlkkOJlqJU5J5rX+Gr4FVl9oZfj5IDk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-401-Lgl9E2lOMH-EK4XoxUeeSg-1; Tue, 11 Feb 2025 17:51:05 -0500
X-MC-Unique: Lgl9E2lOMH-EK4XoxUeeSg-1
X-Mimecast-MFC-AGG-ID: Lgl9E2lOMH-EK4XoxUeeSg
Received: by mail-oo1-f72.google.com with SMTP id
 006d021491bc7-5fca07d887cso291553eaf.0
 for <qemu-devel@nongnu.org>; Tue, 11 Feb 2025 14:51:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739314263; x=1739919063;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=kLidyKEQz+z7EePA4Gpsn6MuzeO6r7+SbEpEclErY9w=;
 b=ZVbGnl8yGMiqzQGOOB+xtihNy8zngHuN3TaGDA9a5L9+L8/ggjjS9xJno4HAebUFjd
 xHCO61Wk0q8w8P+hYYJh1nOWEZUXjaJwIsSL3B+0XfTqeApqUPN3riisptcAQMoO3wEW
 4zneBjNjDYS0ik1ny8vg6TWK9eupdkjiRtOqDAiA3OQK/modWgS/2iydhMk4l9SSl9Az
 ThwpgJORhorN5mJmBNc8iT6eydHA5FvHZuaJHUAduKWxSunqpTAgDmMr1Oh10Rj0Gi8d
 udiScb+YU5HjGnNsxHtNICxp3yawSPABX2GB5AytWCuhJzHefiNucaPUAdW7n3K1oyvE
 d/4A==
X-Gm-Message-State: AOJu0YzAjatCohDbJB3qU7jIzQ9DlQY/9SkjogO3pdjtWNFe/0hkwhMA
 tYli9onn0tTnRChIv4J7iX1uHJo66yU1Ei6nl6ZpLt0mmmlmHByZ4pdk9pA4p1cpTjz2zITk8dv
 AXwXnhsF36rRpQU+lb245698qXUfI4++cFmddD6mOgZOwM6ZdE+w7SuG3ATURSNz/6B2HAwkE7D
 ZZL5UZ5M4PpnK7KCnBMn259JLXAQtmfWA3ig==
X-Gm-Gg: ASbGncuKuefbOZb0XQAavatmGkJ46CeK/pKXNzE3+gzdvdJPD0UpGNp0vNknYeY1DKo
 sCt3MYj0/oqsIALZW3J5ihr46v0F0GBUgIlCtwnEs4+OCGfQ11c+1uL6ef0m2/TmxVTR1aph0Bn
 jcaWjr8xFP9dnjVsf7TjALdI751yFeGz8B31bW3goZVSxq0P78NWfafERJhi9f83uBYMQv6gUAi
 PgasGKEWeqeMXRGzHoGhundci4JEZOQ9t91TFxYXdT7OKpwReRjM2/r
X-Received: by 2002:a05:6820:1f07:b0:5fa:3bf1:f9df with SMTP id
 006d021491bc7-5fca301f2b6mr321249eaf.8.1739314263430; 
 Tue, 11 Feb 2025 14:51:03 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEwVeOnC0DYkHZcRWqhtgHpz0ZxAYb23tlrFiqj7QGbFngm5xAsWyNXQzKURtQqXCiyAxNFyQ==
X-Received: by 2002:a05:6820:1f07:b0:5fa:3bf1:f9df with SMTP id
 006d021491bc7-5fca301f2b6mr321233eaf.8.1739314263051; 
 Tue, 11 Feb 2025 14:51:03 -0800 (PST)
Received: from x1.com ([2604:7a40:2041:2b00::1000])
 by smtp.gmail.com with ESMTPSA id
 006d021491bc7-5fca0992fd0sm482515eaf.34.2025.02.11.14.51.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Feb 2025 14:51:02 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org,
	Stefan Hajnoczi <stefanha@redhat.com>
Cc: peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: [PULL 00/14] Mem next patches
Date: Tue, 11 Feb 2025 17:50:44 -0500
Message-ID: <20250211225059.182533-1-peterx@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -35
X-Spam_score: -3.6
X-Spam_bar: ---
X-Spam_report: (-3.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.54,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ffaf7f0376f8040ce9068d71ae9ae8722505c42e:

  Merge tag 'pull-10.0-testing-and-gdstub-updates-100225-1' of https://gitlab.com/stsquad/qemu into staging (2025-02-10 13:26:17 -0500)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/mem-next-pull-request

for you to fetch changes up to 3e05dedb9f3a4687bffbbc91e89e5c27887c5dcd:

  system/physmem: poisoned memory discard on reboot (2025-02-11 16:37:06 -0500)

----------------------------------------------------------------
Memory pull for 10.0

- William's fix on ram hole punching when with file offset
- Daniil's patchset to introduce mem-lock=on-fault
- William's hugetlb hwpoison fix for size report & remap
- David's series to allow qemu debug writes to MMIOs

----------------------------------------------------------------

Daniil Tatianin (4):
  os: add an ability to lock memory on_fault
  system/vl: extract overcommit option parsing into a helper
  system: introduce a new MlockState enum
  overcommit: introduce mem-lock=on-fault

David Hildenbrand (7):
  physmem: factor out memory_region_is_ram_device() check in
    memory_access_is_direct()
  physmem: factor out RAM/ROMD check in memory_access_is_direct()
  physmem: factor out direct access check into
    memory_region_supports_direct_access()
  physmem: disallow direct access to RAM DEVICE in
    address_space_write_rom()
  memory: pass MemTxAttrs to memory_access_is_direct()
  hmp: use cpu_get_phys_page_debug() in hmp_gva2gpa()
  physmem: teach cpu_memory_rw_debug() to write to more memory regions

William Roche (3):
  system/physmem: take into account fd_offset for file fallocate
  system/physmem: handle hugetlb correctly in qemu_ram_remap()
  system/physmem: poisoned memory discard on reboot

 include/exec/cpu-common.h |   2 +-
 include/exec/memattrs.h   |   5 +-
 include/exec/memory.h     |  35 ++++++++---
 include/system/os-posix.h |   2 +-
 include/system/os-win32.h |   3 +-
 include/system/system.h   |  12 +++-
 accel/kvm/kvm-all.c       |   2 +-
 hw/core/cpu-system.c      |  13 ++--
 hw/core/loader.c          |   2 +-
 hw/remote/vfio-user-obj.c |   2 +-
 hw/virtio/virtio-mem.c    |   2 +-
 migration/postcopy-ram.c  |   4 +-
 monitor/hmp-cmds-target.c |   3 +-
 os-posix.c                |  10 +++-
 system/globals.c          |  12 +++-
 system/physmem.c          | 121 ++++++++++++++++++++++++--------------
 system/vl.c               |  52 ++++++++++++----
 system/memory_ldst.c.inc  |  18 +++---
 qemu-options.hx           |  14 +++--
 19 files changed, 217 insertions(+), 97 deletions(-)

-- 
2.47.0


