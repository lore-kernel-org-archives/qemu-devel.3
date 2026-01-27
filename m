Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05B4FD2FED9
	for <qemu-devel@archiver.kernel.org>; Tue, 27 Jan 2026 18:53:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vkoBa-0002z7-GZ; Tue, 27 Jan 2026 13:53:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBT-0002nI-MC
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vkoBR-0000fR-Fe
 for qemu-devel@nongnu.org; Tue, 27 Jan 2026 13:53:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769539980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=bSQBUP82UfnEPifvcVzGz2pjO71OwIYPszGWXoN9Z1E=;
 b=AlBVAWj5qnK4wRVRAmJgWl0rGMWpHNkkeXf79Ktp7agW2/LR0Pw9XLl4waBk6cON54QOPr
 C2/gHaAlZi/ZGUfZWCeFAfA/KZdK0EiZxpvsVdfDil/0K5AzP5z+arXfcB4YyERLph/6RK
 4TCsMOKWyUPcKPb140XQJjOtBRGRNVY=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-307-STeewqkkMxmN3_xgdB1VYw-1; Tue, 27 Jan 2026 13:52:58 -0500
X-MC-Unique: STeewqkkMxmN3_xgdB1VYw-1
X-Mimecast-MFC-AGG-ID: STeewqkkMxmN3_xgdB1VYw_1769539978
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8947c4398c4so195643476d6.3
 for <qemu-devel@nongnu.org>; Tue, 27 Jan 2026 10:52:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769539977; x=1770144777; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=bSQBUP82UfnEPifvcVzGz2pjO71OwIYPszGWXoN9Z1E=;
 b=LsQkX5RcZ+TW7FgN8OyKvqWNHjQKjC5yTgyojIXXCe5VmWTIhW/neHa7sjBF/oMXVn
 cVToaklZPEFWpidOJyq52zOgpIvKUaXXmW8uzQyQDlXUHyvCH8HgaGrtPT3wYYRIIKAQ
 2t6kG/j5KLQSR01hTD7C0FmGwhm7lGly6iboaSXueLbekTSaZuorKSuAWJAE3llJ5go0
 P1L8m1gcYSLH3wr6XyVSu9bzSYA+D0B1I/aQvyFPx4KuLdMEMr0TTwFtiDZG37P9gaFC
 Pzf4q2QHE1lir/q5p3W7CQ0JYEaUlXhVxKxyODc/CWwztHkDXktRYH6cqaJDcTB0byVs
 qgIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769539977; x=1770144777;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bSQBUP82UfnEPifvcVzGz2pjO71OwIYPszGWXoN9Z1E=;
 b=V/Fe1exE0Eau7lnL7XEa/C+7rhQd9gJTf0kDcx7RzgDFe3kYwUN+0Jj0yJAz96JtlU
 lGY/PU13xTEFcXCSSKfbX7p+eNdhhjrEeK29f+AMNv+UUSAp8NtpmHY1j6Ad6LjDkejc
 ZJq9s4Z3EVxR6HDUXmSvrgokLq5pdazZuvtBdYgaK1B7MUzEWpsSADnLkxj5LMj2+TZO
 I6abNdH9rc1XdCC62JoSkHfRfaalY4apmVMb/ed/SGMcPAGpmo5lfoIi5LWm22ekKJMk
 VxcNWEpoyAZhdEC/s1S/8BQgAapVJTKi7x8fWLuVntNeXAAsPSwxqwNhakghqlvu9Cmi
 x6Mg==
X-Gm-Message-State: AOJu0YxlDDIlXG4TOwHd2FvguZtyXKEw1NyLaXqEh7RKnone0U2bgPxn
 nomOij6sK1hzxQQ/h9C+k8wcTTa0Gw1elmp8fzUKT1htSA/qGNAX/qanN1WteBnFULaNQ4wZua5
 ObhCdTysnrLjvuzpgPaCjROB9bYQrAEx9CzKgKZSaPKLzsfhnhDKyyPGXsjLtvry4pJgl/Wx4ny
 j+8O46H17Yl1mj6qTiMUGSAIntFSglIOzxLvG18g==
X-Gm-Gg: AZuq6aJc/x4M7KZVwITvxwrO10nmT5ie2Sb76V6bDfF4emjq56f74ni7Abkl/4AFcMk
 pox/pqcDC5hC4hMCvGeY1G3bE7jytjfdQd5byIh6wB5KW9W7Q/wu+lM6jP73NVJW6/48PFq4EBA
 SnA6lSm8z3AeDz0jceC8TdQsf50Skh4JOYBDvRGCQloUEaNMHwecLeN9DvjxJpj+1L2kL5RYd6b
 8oSdGohnGKvl6A+pwcuBNh5UUFnbKgqUfITL5FFBnYCl6jOgJUlJf+6y0quEP9hjvlD+T0enVt7
 37kVGhs2vhT13Y06vKT8axOrXlqFGeAB1IB6qt8EyeTbDFLg2S+vCXMwDGLrFQfTvy2SGVsMaSg
 B
X-Received: by 2002:ad4:5943:0:b0:890:7e6d:432d with SMTP id
 6a1803df08f44-894cc96d3fbmr37500406d6.67.1769539977097; 
 Tue, 27 Jan 2026 10:52:57 -0800 (PST)
X-Received: by 2002:ad4:5943:0:b0:890:7e6d:432d with SMTP id
 6a1803df08f44-894cc96d3fbmr37500076d6.67.1769539976446; 
 Tue, 27 Jan 2026 10:52:56 -0800 (PST)
Received: from x1.com ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-894d3740e54sm2338466d6.35.2026.01.27.10.52.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 27 Jan 2026 10:52:56 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Lukas Straub <lukasstraub2@web.de>,
 Prasad Pandit <ppandit@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH v2 00/24] migration: small cleanup series
Date: Tue, 27 Jan 2026 13:52:30 -0500
Message-ID: <20260127185254.3954634-1-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

CI: https://gitlab.com/peterx/qemu/-/pipelines/2289719627

v1: https://lore.kernel.org/r/20260121223336.3381912-1-peterx@redhat.com

This is the v2 of the small cleanup series.  It used to be only for COLO,
but now for some other things too around dumping vmstates.

The small series growed a little bit, because I wanted to try Fabiano's
request to deduplicate qemu_save_device_state() and precopy's similar
version to dump non-iterable devices.

Changelog skipped, as too many things added.  Old patches should almost the
same with R-bs collected, though.  I still touched up some small things,
though (where I dropped the R-bs).

This should pass the new COLO unit test too, I hope I didn't overlook
something once more. Please anyone let me know if it fails.

Comments welcomed, thanks.

Peter Xu (24):
  migration: Introduce qemu_savevm_send_* helpers
  migration: Use qemu_savevm_send_header() in qemu_save_device_state()
  migration: Remove one migration_in_colo_state() occurance
  migration/savevm: Remove SaveStateEntry.is_ram
  migration/colo: Unwrap qemu_savevm_live_state()
  migration: Remove call to send switchover start event in colo/savevm
  colo: Forbid VM resume during checkpointing
  migration/colo: Use the RAM iterable helper directly
  migration/colo: Document qemu_fflush(fb)
  migration: Drop iterable_only in qemu_savevm_state_complete_precopy
  migration: Drop qemu_file_set_error() when save non-iterable fails
  migration/colo: Send device states without copying buffer
  migration/postcopy: Send device states without copying buffer
  migration: Introduce qemu_savevm_state_end()
  migration: Provide helper for save vm description
  migration: Split qemu_savevm_state_complete_precopy_non_iterable()
  migration: qemu_savevm_state_complete_precopy() take MigrationState*
  migration: Cleanup error propagates in qemu_savevm_state_setup()
  migration: Refactor qemu_savevm_state_setup()
  migration: Introduce qemu_savevm_state_active()
  migration/bg-snapshot: Cleanup error paths
  migration: Make qemu_savevm_state_non_iterable() take errp
  migration: Simplify qemu_save_device_state()
  migration/colo/xen: Use generic helpers in qemu_save_device_state()

 migration/savevm.h    |  18 +--
 migration/colo.c      |  16 ++-
 migration/migration.c |  48 +++----
 migration/savevm.c    | 312 ++++++++++++++++++++++--------------------
 monitor/qmp-cmds.c    |   3 +
 5 files changed, 213 insertions(+), 184 deletions(-)

-- 
2.50.1


