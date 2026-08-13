Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9BD6DC5B572
	for <qemu-devel@archiver.kernel.org>; Thu, 13 Aug 2026 13:45:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wuVjq-0000uI-VL; Thu, 13 Aug 2026 09:44:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuVjj-0000tr-RA
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:44:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wuVjf-00072q-Nv
 for qemu-devel@nongnu.org; Thu, 13 Aug 2026 09:44:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786628682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=6zFk2ryYhvlN8BTlzFrzDqs2Qvsl528I2HnQquLxGPw=;
 b=RuNfThx2AcX4EwOGTd2HmJW4e2XtM5jPDx6Y6AjmPPTuJ/NKho2tqwtWJKzx+s8lhAcxqe
 AxhEtdLognD65D5BmUz46YINLh6WwbX1HS+MiJ1mXoAcTWEX+Cz4QNNv/F6+W63kQ4i89h
 6QO0VJp7Vw40LZCPGCkDclEH8zKvoAo=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-IJ7PhRfcMeqrMX5nZsFDLQ-1; Thu, 13 Aug 2026 09:44:35 -0400
X-MC-Unique: IJ7PhRfcMeqrMX5nZsFDLQ-1
X-Mimecast-MFC-AGG-ID: IJ7PhRfcMeqrMX5nZsFDLQ_1786628675
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-92ef13b61bcso94782585a.1
 for <qemu-devel@nongnu.org>; Thu, 13 Aug 2026 06:44:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786628675; x=1787233475; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=6zFk2ryYhvlN8BTlzFrzDqs2Qvsl528I2HnQquLxGPw=;
 b=JDXxJiGHxuRlc9ZzDdg+pGG+mVbInDxptI+VFWWLWwYPo+xn18bx4EhOLILX2RGv+q
 UzhYRk7waYLNJai0mlqDmjAJYV+GlaD5sUKJvhPs1S9iQhG7+bB+VYpdL20rKraFQIHF
 VqZO0AyNvd22Hqu9HYsFe74YxhUlGmUbtdj36WUGOmuoRMrtFCuz7WawROOPWE8RT2Mf
 PBKOYzXiN/hKpATg00h/rhq3PHZDL/qh4j6hcUIbpOXcNKk0OAYzqpdYuH3evV/Yzo8h
 vVMsqmhAjPIpO7wwV7CL7B6TPeoMkGAG/1bST9TRuHN0VxAyX+oIyoe/RM1lHj5zI4vS
 ZGlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786628675; x=1787233475;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=6zFk2ryYhvlN8BTlzFrzDqs2Qvsl528I2HnQquLxGPw=;
 b=dLnTGAo/O3T2I1IOveMM2P83Er/qijiIaEFTid+Ha96yhzTnHlEOKqiMeLM9IbLZ9J
 Vr4EG2YO+6f7GUCfqkwG7FpsrrMkX9qPAfu6r/OalP8LByXu0rTiJrlWh5/+0p9DC7Ki
 i0IQQkMsCMORORdViw03KVp6b6GkscMjqxKbODAn2lnrqwHelq6QpWC3kDsqcwzlRzMU
 z0e69Vg+vP5JbTao5i/0ZGOMCU52xnx6pD+hBm73rn7Kdd+HrzUt5U9lOvrEtUhe3WUE
 pCTbfaZQhJdUxa+4Is2XmZvxPMjmlKdJoJuTASy3aLXdjsrnL+fnlI6lmAQPp/eua405
 Sirg==
X-Gm-Message-State: AOJu0YyIihnY2RY7vb3rAV3baT5MdZOuPyyrmh/nMh+6H0pdg/gD5se+
 Qz/twhn1rxUMZBgY+nacxGCtX5QU/R1CN3dz450cyXJsuiFN+MKNq90j94XHI1pMfcqG/yZSRkk
 JgnR/3+Mcttkc+8CuwpXcesOSURXuwpKlhMTEzxQPT8jeWGh2YxFXZW/+PMKrOZMzBMJ4ig6IJ7
 h1g4g6Apfz8qdk3GYq4GDXGJ9VL6a8IS7I1Vk8WA==
X-Gm-Gg: AR+sD13a3L/S/HTo1GcVGudbPYm4c1KC8udx0VQT1IyJngq2K4W1aoiWpynBoIfOfB0
 eIBIfVl9fVlSSn76TNYfp+fhgePsnWpa32ujE+nV7rbCHxHr/S4N2hrI+SQb7emKK7Be69Tzd38
 ZTn4jWN69ey37mny3+weD7/NlKUk6hYhsB3wTvlYpPovEdNT04ulkZZSAghNHs5F0/L3mdGV3A2
 Osvq4hb1Qgy1ikedqmQXKy26frcE7j8g63erDHbnN64wrpDXYN7j3w8AJUqyxKObgyCP2RRt8de
 z0yxRpdywTStsRcWRFDegfmT4Nu+GBHHfSLoDlJgKgLn7fDaA2mFpPZlmoswaoNjrwm96YXd
X-Received: by 2002:a05:620a:2685:b0:930:f1db:b9e7 with SMTP id
 af79cd13be357-936bfade9c4mr547258585a.38.1786628674680; 
 Thu, 13 Aug 2026 06:44:34 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:930:f1db:b9e7 with SMTP id
 af79cd13be357-936bfade9c4mr547250085a.38.1786628674034; 
 Thu, 13 Aug 2026 06:44:34 -0700 (PDT)
Received: from x1.local ([2605:8d80:6cc9:637f:db7f:22cd:4098:82fd])
 by smtp.gmail.com with ESMTPSA id
 af79cd13be357-936c199b579sm150352885a.21.2026.08.13.06.44.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2026 06:44:33 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Richard Henderson <richard.henderson@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Peter Xu <peterx@redhat.com>
Subject: [PULL v2 00/10] Next patches
Date: Thu, 13 Aug 2026 09:44:31 -0400
Message-ID: <20260813134431.2678787-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -28
X-Spam_score: -2.9
X-Spam_bar: --
X-Spam_report: (-2.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.759,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

The following changes since commit 84f07211cc5b4fc6a371559bf8a5de4fb068e648:

  Update version for v11.1.0 release (2026-08-11 10:04:46 -0400)

are available in the Git repository at:

  https://gitlab.com/peterx/qemu.git tags/next-pull-request

for you to fetch changes up to 89f15c1362970150bf5711cdb84b9742c0db0cd8:

  migration: Fix rare hang of migration_channel_read_peek() (2026-08-13 09:41:40 -0400)

----------------------------------------------------------------
migration/mem pull for 11.2

v2: fixes macos build error

- Dongli's patch to add cpr-transfer support for HMP
- Fabiano's doc update for migration on security issues
- Gavin's fix for MMIO access support for memory APIs, reverting ram_device ops
- Sam's migration test build fix for !ASN1
- Peter's a few migration hardening fixes

----------------------------------------------------------------

Dongli Zhang (1):
  migration/cpr: Add HMP support for cpr-transfer

Fabiano Rosas (1):
  docs: Add security considerations for migration

Gavin Shan (3):
  system/memory: Use memmove() for directly accessible regions
  system/memory: Use qemu_ram_move() for directly accessible regions
  system/memory: Make ram device region directly accessible

Peter Xu (4):
  migration/multifd: Validate next_packet_size in zlib/zstd recv
  migration/multifd: Replace assert() with error_setg() in recv paths
  migration/ram: Check for RAMBlock size mismatch when parsing
  migration: Fix rare hang of migration_channel_read_peek()

Sam Heney (1):
  tests/qtest/migration: Only build tls_no_hostname test with TASN1

 docs/system/security.rst          | 22 +++++++++++---
 include/system/memory.h           | 46 ++++++++++++++++++++++-------
 hw/remote/vfio-user-obj.c         |  4 +--
 migration/channel.c               | 11 +++++--
 migration/migration-hmp-cmds.c    | 18 ++++++++++++
 migration/multifd-qatzip.c        |  5 +++-
 migration/multifd-qpl.c           | 24 +++++++++++++---
 migration/multifd-uadk.c          | 24 +++++++++++++---
 migration/multifd-zlib.c          | 11 ++++++-
 migration/multifd-zstd.c          | 11 ++++++-
 migration/ram.c                   | 15 +++++++---
 system/memory.c                   | 41 +-------------------------
 system/physmem.c                  | 48 +++++++++++++++++++++++++++++--
 tests/qtest/migration/tls-tests.c |  4 ++-
 hmp-commands.hx                   | 12 +++++---
 system/trace-events               |  2 --
 16 files changed, 216 insertions(+), 82 deletions(-)

-- 
2.54.0


