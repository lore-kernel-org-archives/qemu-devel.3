Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B6E22C54F5D
	for <qemu-devel@archiver.kernel.org>; Tue, 28 Jul 2026 15:53:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wok78-0002bj-JL; Tue, 28 Jul 2026 11:53:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok77-0002b9-9E
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wok75-0005dD-Lo
 for qemu-devel@nongnu.org; Tue, 28 Jul 2026 11:53:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785253982;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=7HtDANrxly1ui/R/sOqfni30fW/2eNWwKTxoC2FIz+8=;
 b=Hs1K8IcAYwXGfPCq2/nlKBHzu+OC/pX7B22hnRCKrjSeZdGhOSZty3VcmD/0G0mlN4XlnT
 wO74BFwMyLSRMTEasS8Ue2igCNe65ReH0SxGPKVkZQJTpDGuVu8K5FUVsH6Sf988MWmLgc
 KOqw/r8Q5PfZ+C475Hx2f7RRDUF7t8g=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-482-yhBQz9QZM_asd_qy8_3rDw-1; Tue, 28 Jul 2026 11:53:00 -0400
X-MC-Unique: yhBQz9QZM_asd_qy8_3rDw-1
X-Mimecast-MFC-AGG-ID: yhBQz9QZM_asd_qy8_3rDw_1785253980
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8f0f45415cfso51202416d6.2
 for <qemu-devel@nongnu.org>; Tue, 28 Jul 2026 08:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1785253980; x=1785858780; darn=nongnu.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=7HtDANrxly1ui/R/sOqfni30fW/2eNWwKTxoC2FIz+8=;
 b=RAvmy/Viv1PgRbJS3YU3KkWbTJPTf7diRDb5Z/seqakdQoin3RaA8FCdeedwuw3ZFR
 DWnAkQ5h0LOT2rpCGAbvwDkkFSJHwJ4b/SGzFKnJq64DlRAxqtGyboNcPH4elhEAAJW0
 WYMBYkO8yajWqmQfNOM9yLFQUEg2dYsZLBN+CGmNS8tkoqMe1VRb7NU5n1IgYE3QDOb0
 gunXPGfdQTX5Fs3HIO47Kadw6zO5enV+iS5Qekd2fpLfcQ6CP2jw6dUIm/6vYIGmb/wr
 NgM4AayGMwY8TvTybHAvQu69gRON+DCHWmA2CR1ah4ApiN43Plgv14RzssgwQWgpeeeK
 rGaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785253980; x=1785858780;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=7HtDANrxly1ui/R/sOqfni30fW/2eNWwKTxoC2FIz+8=;
 b=LJJaIREyh/rpQQPVhJJ7lBf6QaSzcubpRA0PS/Guqzed+4AGMMWYPH1Ezfo3IXmGED
 GNHNfOeYZ8VqQkZp3ghwzDzO97NGk9AuvPGPS5ctKVc2S/EdIYlC0ECK6usfyuHgEHwr
 acAq+tarPSB5EiYFE7MRjb6geV76BAFSJagL8uS0Jk2mJhuqrYYVeVL85G22rFu2O7oE
 0AOMn6vjdUHJt/rJuNQEJOrOCNMXHT7rZ3ZbFX1/eg+iW4LxOMGZN7OQ4FnwjPzYt6Ck
 P71tpC4bQeHIyoJgk9AO0Ptp/IOcQknp1uHD+pfEMxgjKHbH/xKBy67kBKd2iKRpvmTs
 jM4Q==
X-Gm-Message-State: AOJu0YxBqUDjl73s1FDrmBUc2rD4EtKhcAor8z10EHYlTt+DWyZC2LLO
 TRBF6zbQqYtXGKdUjKXhuX8EAUD5/NFqlk/TFTefWqFFZJ14rMF8yVs/hW8vCpvLzHAG1upcNq7
 HJIggyng4+/uaYibptfERCG5/Q3wlvyf1KKfuT53u/IqvWY3YnevWMPRlVHxcGbNOD4q4rEcYyn
 VRvrfQOIjekO/rtjT/Ab7YQVkQb9TGi5+L3VhYtg==
X-Gm-Gg: AR+sD10Uee0td8B4T4yZgUJnudjPh/Mvnwa3EKQzlzw9vfemczQG4CuwovlQbxi2lbS
 gtjwiGZx0NyBaZWD+ZIKTdTG9K82kvnxptT+4KCZ89qhBf20Op3hkwnFKV+uQpZCPg2NAy8fJ4N
 hW7XU7UFByqCUVKBAo/SlWHobl7+PJEWXifgGNql5y8DjuE4Vkc0hf/Eo+xSESHwxrivB+I3+9k
 MHOy572SRiIwuoIc4+MsEupaPkrzMNadaAdeQbFxNPWim58M7REmNJbINTvDtsvEotajthYUB2R
 9z7/PMDNeHdyab9NtXAPg9CVCGYoVI+sREfGX7FysANm5yFOgRbPCy4D4wbD7Rmaiw==
X-Received: by 2002:a05:622a:102:b0:51c:709:b81c with SMTP id
 d75a77b69052e-529d6ff4324mr27771051cf.32.1785253979620; 
 Tue, 28 Jul 2026 08:52:59 -0700 (PDT)
X-Received: by 2002:a05:622a:102:b0:51c:709:b81c with SMTP id
 d75a77b69052e-529d6ff4324mr27770641cf.32.1785253979011; 
 Tue, 28 Jul 2026 08:52:59 -0700 (PDT)
Received: from x1.com ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-529e2dd54dbsm492481cf.23.2026.07.28.08.52.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 28 Jul 2026 08:52:58 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, Fabiano Rosas <farosas@suse.de>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PATCH 0/5] migration: Hardening fixes for 11.2
Date: Tue, 28 Jul 2026 11:52:42 -0400
Message-ID: <20260728155247.1894355-1-peterx@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -36
X-Spam_score: -3.7
X-Spam_bar: ---
X-Spam_report: (-3.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This is a small batch of fixes from recent reports on migration, the plan
is this is only for 11.2; we don't need to rush on any of them.

RDMA migration has its own small batch.. It'll take slightly longer so I'll
send them separately.

Reviews welcomed.

Peter Xu (5):
  migration: Fix possible overflow in vmstate_handle_alloc()
  migration/multifd: Validate next_packet_size in zlib/zstd recv
  migration/multifd: Replace assert() with error_setg() in recv paths
  migration: Fix rare hang of migration_channel_read_peek()
  migration/ram: Check for RAMBlock size mismatch when parsing

 migration/channel.c        | 26 +++++++++--
 migration/multifd-qatzip.c |  5 ++-
 migration/multifd-qpl.c    | 24 ++++++++--
 migration/multifd-uadk.c   | 24 ++++++++--
 migration/multifd-zlib.c   | 11 ++++-
 migration/multifd-zstd.c   | 11 ++++-
 migration/ram.c            | 11 ++++-
 migration/vmstate.c        | 91 ++++++++++++++++++++++++++++++++------
 8 files changed, 173 insertions(+), 30 deletions(-)

-- 
2.54.0


