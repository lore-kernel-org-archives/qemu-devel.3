Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABDD6C43458
	for <qemu-devel@archiver.kernel.org>; Thu,  2 Jul 2026 13:36:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wfHaV-00084c-TE; Thu, 02 Jul 2026 09:36:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHaU-00083j-Ni
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1wfHaS-00014o-AH
 for qemu-devel@nongnu.org; Thu, 02 Jul 2026 09:36:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782999374;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=utgm0XcZH1OQFlYYcbnG8kYHRsMRZSLs/jw2MKeR8kE=;
 b=iYVIcoRLr7Bsdu2/LHhXsiM/wbi3jeX9BDdHP9PgAri4itvOKWr1vbnF9++0jUbCYd+hMz
 CQBwc0lf9/BZj6qlaS6F7pox+hRDerYob7vkwhugHiPGl7Bg90o+j1orZijxILG40OjQeK
 U5nKgVRilSwPDYQThndTXhLJOsVLvv4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-88-9a2itBN6PtKHkuWqJr1w7A-1; Thu, 02 Jul 2026 09:36:13 -0400
X-MC-Unique: 9a2itBN6PtKHkuWqJr1w7A-1
X-Mimecast-MFC-AGG-ID: 9a2itBN6PtKHkuWqJr1w7A_1782999372
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-492488f8583so27585255e9.2
 for <qemu-devel@nongnu.org>; Thu, 02 Jul 2026 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782999372; x=1783604172; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=utgm0XcZH1OQFlYYcbnG8kYHRsMRZSLs/jw2MKeR8kE=;
 b=jBK8ExdkcBEVTvaSuIHWLtt+h3sfG5XgetpWmFWLmt25HdbwpAw06I/EQyxO8dHHjK
 H1dyTKdRrmCynkljhexyrAqodrW8jY+EBUYplAKXWrH2UHgY446BGLggiF4IOLJzGnFY
 kxUJrf7HbE1a3tLDRdGz4lQumNQyB/rMfdK3T7iICOVvlatI3CrgPOyt7OnFSEhup3l/
 RfOoKkS19iWKeHF8QOsxPfZzghdzve1ovYgPOo2fkVlmK5c/H4bxkSckxJL/L1q9FM8p
 0y8mfNticILJmu/mozqGFUR79oacgJ7RuBgIvpoKHFiQqnVckYR4EMpdpZfVIwAJJ1KH
 z8QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782999372; x=1783604172;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=utgm0XcZH1OQFlYYcbnG8kYHRsMRZSLs/jw2MKeR8kE=;
 b=tZR+7z61ah3mMvURIZMKTlhlBNLK2GQrKY8LOcWHqxEOz/9BrRy6ChImJhf6IMaCqq
 XJTDFMQcRVBfvr1JjPRilga78N6GBe8Mbdo/62e6g8JnGlKeO741TnfJHSiO0mC/xPYi
 Ve8EdD/0nu2QIQ1r7t9A1Y2gHzKYRQpozF9tDIW6mXU1DLD1AcisUigYCBj9xEQbznis
 AuCsN2O0Y+iVW8Xa/yqD3NS65QQqEvGlTv7XbFEq5IjG+u+EMYSbO0BhUmMjA/5Mf1hT
 /+p1GYIt7v35LNliHafekoJOqaDSEN/38RIzP21NeKMUIuu9BrwYNx5sXYpf+gRrByqA
 vgTA==
X-Forwarded-Encrypted: i=1;
 AFNElJ/fVWdEHQpH8u+xPmO1QspbDAMd/W3gu4/y36eFlh0vidhV+UCf4Zfpk/Y+rGgai+vtBeh/LS/xF6rA@nongnu.org
X-Gm-Message-State: AOJu0Yy+wS2SSbAQuLjJOSEmEc4uoe1LilEGKifMB6kvdHxGOKgOunIB
 7wiShW+G/50vFW5rmYF4S46N0ubljMKCSdn6niay2WdoaD4BHxzRa7gGWf49cgxMbK0H0HkIw5y
 LP0I5g5FE78fL97DI1NVFk8xBuq2pt0FeCvqfu+thsjwld7mVlKv0H5hF
X-Gm-Gg: AfdE7cnbGg5RjMUo9NHLFIa/fpPz0PihYYN95L4ws2STMkXVh3GvIrNDfv5bTnzyIpD
 xPgVF/u9sW1NGCW6xPxF9SzA+vGngU5rpBl0uyTprmhPSOLaxkwcnWukYaJqOt0cdUxMZxnrLbS
 LQv5UBiYhmAXKFYEmxKOH2JJhiCyKaHpJ+iiuIsjRzaQhDfp6E1PaVj3DtchUt8ii3HuuP3dQH0
 vi6nM9zHRhogXRKvUMXfWuN1Wf2HAy9wUt/Jrds651ZeMMG8xAZkavhyXlu/A09d7GtA/vBBqxX
 KyGCW0Ovi0txYcxqY1znUhUz7vZ4jsq5zhBflYuS3bnh3IOd2EiQl3lQB96A+CiCRp+0aThCYno
 pwkTCQV1LIEUtcB9EUsr5edBXtiXahOGV+KM0qkNcn1kPgfVJR1ufXRAKrMUqdNAOyaAQOstskw
 ==
X-Received: by 2002:a05:600d:111:b0:493:b243:8ffc with SMTP id
 5b1f17b1804b1-493c2ba5556mr72547905e9.35.1782999372014; 
 Thu, 02 Jul 2026 06:36:12 -0700 (PDT)
X-Received: by 2002:a05:600d:111:b0:493:b243:8ffc with SMTP id
 5b1f17b1804b1-493c2ba5556mr72547405e9.35.1782999371682; 
 Thu, 02 Jul 2026 06:36:11 -0700 (PDT)
Received: from rh.fritz.box
 (p200300f6af2a6100f239e076bbd76784.dip0.t-ipconnect.de.
 [2003:f6:af2a:6100:f239:e076:bbd7:6784])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-477db3dbb01sm9135980f8f.1.2026.07.02.06.36.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Jul 2026 06:36:11 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v4 0/3] arm: demuxed ID registers (CCSIDR_EL1)
Date: Thu,  2 Jul 2026 15:36:03 +0200
Message-ID: <20260702133606.34529-1-sebott@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

Handle the demuxed ID register CCSIDR_EL1 as part of the
idregs array. V3 of this series was posted here:
https://lore.kernel.org/qemu-devel/20260622135627.40573-1-sebott@redhat.com/

Changes V3->V4:
* added R-B from Eric
* incorporated suggestions from Eric

Cornelia Huck (3):
  arm: handle demuxed ID registers
  arm: handle CCSIDR_EL1 as a demuxed register
  arm/kvm: get demuxed ID registers from kvm

 hw/arm/virt.c                 | 19 ++++------
 hw/intc/armv7m_nvic.c         |  2 +-
 target/arm/cpu-max.c          |  6 ++--
 target/arm/cpu-sysregs.h      |  9 +++++
 target/arm/cpu-sysregs.h.inc  |  1 +
 target/arm/cpu.h              | 18 ++++++----
 target/arm/cpu64.c            | 14 ++++++--
 target/arm/helper.c           |  2 +-
 target/arm/kvm.c              | 31 ++++++++++++++++
 target/arm/tcg/cpu32-system.c | 26 +++++++-------
 target/arm/tcg/cpu64.c        | 68 +++++++++++++++++------------------
 11 files changed, 123 insertions(+), 73 deletions(-)

-- 
2.54.0


