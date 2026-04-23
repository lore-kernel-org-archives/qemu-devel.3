Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3ECC7FDEE42
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 18:33:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFyqt-0003dy-1z; Thu, 23 Apr 2026 14:32:39 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqr-0003df-K1
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wFyqp-0001Lb-Lw
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 14:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776969153;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nEIuu17nPKDkT0coRpUN6hkx+mN+dMTOWQeqnuqo60U=;
 b=MtdUHNRbjZm5nfgD7q97lA/FFbrT1kDq80YWpACkYGvCn0+FFlScQbHPXMBsPIBPAmkxWh
 IVZ27ZoOug/RfW4GofpN9CYILPxJggJxcxGeXISNpQQ68TzyufxFKw1uW5az9dtBbWo196
 kLFhx1jIJ+Bxl6jnj46s7cwGNSlx+mQ=
Received: from mail-qv1-f72.google.com (mail-qv1-f72.google.com
 [209.85.219.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-335-BGa0UYERNROAkMmxHiBcVQ-1; Thu, 23 Apr 2026 14:32:21 -0400
X-MC-Unique: BGa0UYERNROAkMmxHiBcVQ-1
X-Mimecast-MFC-AGG-ID: BGa0UYERNROAkMmxHiBcVQ_1776969141
Received: by mail-qv1-f72.google.com with SMTP id
 6a1803df08f44-8a16036c90eso176000246d6.2
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 11:32:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776969141; x=1777573941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nEIuu17nPKDkT0coRpUN6hkx+mN+dMTOWQeqnuqo60U=;
 b=GEM0afMmFCBgp6CKwIGzcJdoEbVL21wk9iSZm28igGM5yQFBKOQ0xPiJU1QTi0e9Md
 vFKAVJbyQh7DA8ARa0AuOluWpGiqvAf4aC7uXvqkG+alagpErRvXxOQnLQlYuVMfFs44
 Zyfl6UtZqzOy24LS1VAWZ9zOk1Ut3gPpgarIaD5/UzrFxjWNJrvqotNnYkGCRi9USjXq
 21F8h9u2Pz9+6YidqTTivL/usScBHWzjpHDXOHAdAHEv6v4WPg3AiofjzmIEVeyriJeF
 tjWwwBqYfx1G0wO4cpMvfu6tiJvX9YtkwHZCNcSW7kSDP3AXBg+rFT7MkI7eioyOy++D
 IaPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776969141; x=1777573941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nEIuu17nPKDkT0coRpUN6hkx+mN+dMTOWQeqnuqo60U=;
 b=V4UhkVWT9VMcludDcw7TJCx5MCjFTrF7d7tLHrcwZhfLq31J2Pg56narJAHBrhS5Uf
 vr7/H9Ex4YziV47noFYs1oMFRNTazgj4TSakPOnxlKTSB9xiWVUPX/DYreU/jYSbak7+
 dcp06cUA40TTFF6RG1qKgNtbr/o66PDTu3Twkc1OOBO4DB+xnmfCazy0oyGrXw43dq0C
 fgBgcwobG3JeNctVFgdQmGwcrOqTT26LjPR1VnrMqhn6EGHfKgNPOfVSt3me7qtzFeoj
 ZcfhrgZhzkqI53qyCRwrN5+6Qzl1ly44gZW+QXNGoBwgztQdoEHSJc0smBgpiw8s7QXW
 Y0uQ==
X-Gm-Message-State: AOJu0YwVia5PxVZunDcfA5lac8OlXXcvUDDmC50SA6JLPazscLuSZ0i/
 Ygxlx69deT79XZEB7vYhM3yhrA8YfZjeKkVbtCls7utr6PPKfxwBn8Slm2Y+g3eLmePJTOQE/5a
 /oFlZV2FjbZOxJHlTyY0smg7Hi/oIztNK5e7o4G0cVkdsuestf+XTFnJZFh35sF+TD6Y4bawkkF
 JWZM82ohVrlLA4VLIhEQa+W8TGBp7EQ4ER4vF0XQ==
X-Gm-Gg: AeBDiev5B8ws+CtSMH+u+97zMn/+BLIVyIPwUwYW8MutKNzgIz923ahb7fjw9xeq/Uv
 PstLdmEv5M3FegCRsT6T4nyaJJec5dqAS5PhFkrZxQ2/H9j+Ha5e2P59A3Iwyiq3C7vMAapoPLY
 zUuY7rkpnQeB58qBc6ppH6cuLnF29bh0DxNcSFU3JqcIT6hMOybNtRhx3wLdy1lT4IVESsUn+xB
 Mp7iUTuBUOX/IAaX26EtG0NphrwD3L46PxsndSKMkCbjYTknHtyLIQVn65Yb1q9c1rP0ll1cIFx
 W/hP9Q7sHk+aZbxW9rV/F0iVpyTUwSOdTmgg13zPA8SqT1V8AFW1pviqn6yntPpmk2jwXg+Ove0
 TYpJ5p0VAK3Y3p9VKnkdj3ztjNNSLytQwqcZupeLhxJwp894cJTflEi4=
X-Received: by 2002:a05:620a:2685:b0:8cd:7271:65f0 with SMTP id
 af79cd13be357-8e792566ed4mr3934854885a.44.1776969140652; 
 Thu, 23 Apr 2026 11:32:20 -0700 (PDT)
X-Received: by 2002:a05:620a:2685:b0:8cd:7271:65f0 with SMTP id
 af79cd13be357-8e792566ed4mr3934846185a.44.1776969139881; 
 Thu, 23 Apr 2026 11:32:19 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b02ae92fc8sm160665566d6.40.2026.04.23.11.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 11:32:19 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Li Zhijian <lizhijian@fujitsu.com>,
 =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, peterx@redhat.com,
 Zhang Chen <zhangckid@gmail.com>, Juraj Marcin <jmarcin@redhat.com>,
 Jason Wang <jasowang@redhat.com>
Subject: [PATCH 0/3] Three small fixes over qom-list-properties crash
Date: Thu, 23 Apr 2026 14:32:09 -0400
Message-ID: <20260423183212.468047-1-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Markus's report is here:

https://lore.kernel.org/r/87a4uvw066.fsf@pond.sub.org

These three that are relevant to either migration or memory, so I had a
look.

Peter Xu (3):
  colo-compare: Fix QMP qom-list-properties crashing
  system/ioport: Fix qom-list-properties crash on portio list obj
  qio: Fix qom-list-properties crash on net listener object

 io/net-listener.c  | 14 +++++++++-----
 net/colo-compare.c |  9 +++++++++
 system/ioport.c    | 11 +++++++++--
 3 files changed, 27 insertions(+), 7 deletions(-)

-- 
2.53.0


