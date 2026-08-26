Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B733C5DF97
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Aug 2026 18:16:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wzIAN-0004Qr-6F; Wed, 26 Aug 2026 14:16:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIAM-0004Qj-Fv
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:16:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wzIAJ-0005Kv-Ix
 for qemu-devel@nongnu.org; Wed, 26 Aug 2026 14:16:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787768157;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=+w/JRhpzqBffPEu2NzQdM/oSUmuuQLJ7dr/ZkpzxAbU=;
 b=NyjGrJw4V/bxS+rBQGonvN1O2WNEaDfeucjh0z+hLK60GeytFgrk80AwgQDJic2Vitn6KR
 APU8MGLR79TPJGLJ1/WZW4v9mfVkCECLfrBBc3vlu/83RUS7deeAoQPv7n6SKxPPgPEl2m
 xu2mBNcJX/W5EpayuHMPo4TVOiRfr4I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-zgpC8iQEOCiaC48xMfYNEw-1; Wed, 26 Aug 2026 14:15:55 -0400
X-MC-Unique: zgpC8iQEOCiaC48xMfYNEw-1
X-Mimecast-MFC-AGG-ID: zgpC8iQEOCiaC48xMfYNEw_1787768154
Received: by mail-ed1-f69.google.com with SMTP id
 4fb4d7f45d1cf-6a5dfdbf015so1357266a12.0
 for <qemu-devel@nongnu.org>; Wed, 26 Aug 2026 11:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787768154; x=1788372954; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=+w/JRhpzqBffPEu2NzQdM/oSUmuuQLJ7dr/ZkpzxAbU=;
 b=RW+PbFQ4TcsKd7Ph9OO5+94Yd/3MklW2M3u8KJK2sSZ1NUcQQa6huHQ2R6O02Sfmdp
 PT7Px/57VlwgGvO642F1EUQkPOGxg7wLXImvma/4+LHKll7tVBB999ftvoW0n5SvsfwO
 WcJXEiMux0w5ouSFgGQWPAyItXNOLc7Si115hlFHf5vSMum+OIou/QXL5LsErHztgr5v
 0dzHk5HSfPDMEeGRtdIBkth7kcmoxyCo1GDOOgBySTevDrcKgoA2pGlRnSApQS5loIlu
 xY0bFgy/2VYORP6x4PKY0u1XXxU9NwFuPgM1MY0XvXbeYVAbSSAI0NKVn/DXz+Zv9AGg
 xkvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787768154; x=1788372954;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=+w/JRhpzqBffPEu2NzQdM/oSUmuuQLJ7dr/ZkpzxAbU=;
 b=tG3RqgiZXoV/EAjpt8lKYzKKkQ8EGjexu9YqOHQBkS6KtfkYnSRulNhE2ujri3IGE6
 fYsKhLVtbkbo57kMVD8ba9V0k6WYQU2++HNjtA/QX9P/Lqk7t4Q3FMBCAQCKPZ0LJL1p
 iCmqNh267jO7FiLvEeWHj2l0zO+4ghIZLw5HC7WtE/ErfbQhdrcS8e0tBThiLXmi1n2X
 FH62VW0SRMOElZEQZmQoCbty2j1G6a8kvLf3zD1ixHjxmCs60RW2fGM4nxfV+8NdqR/4
 r6QFR4b31c5odHBWcVSl/MfCb3KyWIdTRNhqFj5sDOIZSVuirmFWAvkYyXrsUcPh/ezJ
 ZQbQ==
X-Gm-Message-State: AFuF++lGGBZQYH85Bo/1zztfBj7LFHoQJ1MYZuZXDW8rLOs0ecMKKBIv
 9Avfyh0FLmqAC8HynZPmCndQ0WLrgDizIGavetDxxxWEUYHSLPYN8GbGh/sZUMOxLF6fbnLeVlf
 p+84SVfaiwNB9Kz8WR8TAfOaUMX9wviM0HlVzt5oEoqDRdMUh1SVSgsuaGoedpLqDyG/K3jMaDi
 HWIN3OgCzwTDeZuammwE8bWbNK0HDVeiL/m+R33o8u
X-Gm-Gg: AR+sD12RpNR8Cj/+hS2ozri+ADTqcFD4++v6EhGlzwxJGMLzHigwYu6scFuCGJERTXr
 wXUrrU83VlO3QTEH1wWPQcR+BYu1Ds7JebXv/foQwTk5PPeHQRAvK/852URCgKFiCGF81wDPFrr
 zQh64MJkPOD1k49VKcvN33dR/4+xORGpTtZdym2+ZDgFxL9v+cw6AR60ZXZF53WPU1FUEof+lnU
 DxTNcWEdT8xyGSFO8onDhnixdznosH7FronxaNwQyq4AIp4aMkwGyvNnZm2ahgzWSDJVij14gpT
 KAFJxabK0v/A9I/0H20EfldcCOq8gwHf0KA/pwLZ7EXitL9VGt0FufjlRkydQvrAEhD0HvgR6AG
 pfRG6ew6EyLe19hvNa0OzVuRRSJ6k61UOdk7sApOanp7YHzhao0l7SH4XRQj0WbbalKE8DZzL6Z
 KDXg==
X-Received: by 2002:a05:6402:458a:b0:6a3:fee5:adcf with SMTP id
 4fb4d7f45d1cf-6a5df5e1a14mr13259380a12.1.1787768154440; 
 Wed, 26 Aug 2026 11:15:54 -0700 (PDT)
X-Received: by 2002:a05:6402:458a:b0:6a3:fee5:adcf with SMTP id
 4fb4d7f45d1cf-6a5df5e1a14mr13259286a12.1.1787768153915; 
 Wed, 26 Aug 2026 11:15:53 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6a5de8d1afcsm7269900a12.8.2026.08.26.11.15.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 11:15:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/2] vapic: confine the VAPIC region to 0xc0000..0xe0000
Date: Wed, 26 Aug 2026 20:15:48 +0200
Message-ID: <20260826181552.848617-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

The VAPIC region is mapped as writable RAM, at very high priority,
above existing memory.  If the guest is allowed to map it everywhere,
it can overlap PCI BARs or even SMRAM.  Ensure that the whole
region first in the 128K of low memory that are reserved to
option ROMs.

Patch 1 is a separate bugfix that I noticed while working on
this area, while patch 2 is the actual fix.

Paolo Bonzini (2):
  i386/vapic: unref MemoryRegion if vapic_map_rom_writable fails
  vapic: confine the VAPIC region to 0xc0000..0xe0000

 hw/i386/vapic.c | 18 +++++++++++++++++-
 1 file changed, 17 insertions(+), 1 deletion(-)

-- 
2.55.0


