Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3347BC982C1
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 16:51:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6srA-00009U-3E; Wed, 16 Sep 2026 12:51:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6sr4-0008WN-6t
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:51:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <sebott@redhat.com>) id 1x6sr1-0001ce-M7
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 12:51:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789577486;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=AvkBO86Vxep0LTBS33hl/KqDyXBtcNpZip+c0HPjzUg=;
 b=FRl/BqY7MzQtHXNuue01v8UP/03PT5Te/R6whIZBVuFSV5zt35Qb3uAKf7iwjPImWhkfGW
 naz9yZRG3raKs9ydFFC7gUZc/LmIHp+Cp9josH6wF4icSxMO1d7QCz/+bftNljyYmRu7KQ
 NMrMqQKZ54omwirPVi3Kgx56Bd8DW4w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-PfTcnhrdPa-WR39mNUY9qw-1; Wed, 16 Sep 2026 12:51:24 -0400
X-MC-Unique: PfTcnhrdPa-WR39mNUY9qw-1
X-Mimecast-MFC-AGG-ID: PfTcnhrdPa-WR39mNUY9qw_1789577484
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e635a6002so65462555e9.0
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789577483; x=1790182283; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=AvkBO86Vxep0LTBS33hl/KqDyXBtcNpZip+c0HPjzUg=;
 b=fhrfy6D6ZdnzRGv4+AgvbaFSaFyS3uqVQXPOkU7ruwxKRTrUgQvUYtwRCMtSR5xEF+
 uJEOpAEu79x+KFYUQO+8AcJR8lHojkypBD9NYdnFwuBSTWzyhD4jvcTNSiz6RHAhiKqt
 NLuLSAy1Pr9ozmgcj+L64JF57/O4Twe07WuWDMDRRG18oED5CNVTccRXoid3VZryy37x
 637qeqC9qOdAHnqeArt1McD6fe47ZqD7JErUIUzpkWuUmC5TfD35DAq+vtoHDUXfaV8v
 q9BMXpNIyH3ZUiIwoY1zcrwjnD7Lyt/FfNBRHxy5jrokgWQQjtaxwUeWSC2LEflUgH46
 HYaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789577483; x=1790182283;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=AvkBO86Vxep0LTBS33hl/KqDyXBtcNpZip+c0HPjzUg=;
 b=sQenqv4i8OF4MF0puZ3aW+qqg+SjZOK/NtFxU8QtN3mxb5EqFNpOniQHzWQo2nrrtB
 yclGapbfsZaLurG9qj3fnwM4XSDZU6xu4z9JLk/W6MxVFy7/pnez251T+yfhKUYjGrwi
 xLnkVvkti175gPrqJFHeYf+MJ2EZkBlOXgPPzDRSoTUa63UGUJ6HS0zlR42/vej6T9iS
 AyG7QA89f62P2xM3e0DoXokY+aPPNlk9hgW7kIcQf1TkrpND+OlvturJd3AceGlMI5xO
 eSLLOaXZyvOnunXSe4tiGV9NCkleOYO1cd8Yv+f4RfByXTIsVzNsWA1MLSQM6xKnxuBG
 mJmQ==
X-Forwarded-Encrypted: i=1;
 AKwUvBzVHP8HlC8KHDaS6mEPw6inK2/MXSP65NYytpylAtL8xSkSpReiOBFANvril7vfRLwfMtLDwVrA+mV5@nongnu.org
X-Gm-Message-State: AFuF++mkeTFg788byjV41k9Dy+PTqH8XtBSrRRtcdTS9ixxjfBzYuN7I
 W2phQ0S2P2YsUQxpCTCmVPkwAUHiZ2hvQCRR8cegxZE8EU/BjW7e/WI4bIy9HOgJAucxdV4jCSs
 HRNDhhBkJY+Y3hRBotwx8RyqVVS+qHSlqr0bMQBujvadlB444LeBXwD32
X-Gm-Gg: AYBFou3e/0mKFvu2eBdfDWA21glSUxDs8MN/6uKJxKmVemjJ2GwvX6XoCS8ztr5wLkE
 0WYAyiJI1wdlIQUD5n8cRpZ9riZ92sS4j91Q5vv7888/K4/k9TWUL9PRETzbOuly7rA0oyNfsYk
 KIgrUZH5IyDIawpZF3Y6YU9kL8opmpePQbvuTbvCHRd0eWPYkb5sRDWxBNQyU8+qnpMh88KLMW2
 qcXzEr6em2DfJpqjO9zMp7F9kTSVhj3oBrJ+hx4RXSzStIzul/ELi83OxO3nHhaePnq2zvSTtr8
 Uzh9NtFdDKNGdqQmmaxEVnUz0lm1GT1cRzspnIIFIUX0EGUR3FeeQyu/C+RpCEG1jQ3SIeCYkqm
 wNtY4Xfyu/6coclLHxwpn7dY4FG+3RNYwJACi2QZ3vqrLLIHuvtDOJAQfHSLzrQUAew==
X-Received: by 2002:a05:6000:29ce:b0:487:10a9:57cb with SMTP id
 ffacd0b85a97d-48710a95810mr2180268f8f.49.1789577483733; 
 Wed, 16 Sep 2026 09:51:23 -0700 (PDT)
X-Received: by 2002:a05:6000:29ce:b0:487:10a9:57cb with SMTP id
 ffacd0b85a97d-48710a95810mr2180246f8f.49.1789577483377; 
 Wed, 16 Sep 2026 09:51:23 -0700 (PDT)
Received: from rh.redhat.corp
 (p200300f6af00a400b6f52cb1a2e89932.dip0.t-ipconnect.de.
 [2003:f6:af00:a400:b6f5:2cb1:a2e8:9932])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4870bf33e01sm9655089f8f.23.2026.09.16.09.51.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 09:51:23 -0700 (PDT)
From: Sebastian Ott <sebott@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Eric Auger <eauger@redhat.com>,
 Jonathan Cameron <jonathan.cameron@huawei.com>,
 Alireza Sanaee <alireza.sanaee@huawei.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Cornelia Huck <cohuck@redhat.com>, khushit.shah@nutanix.com
Cc: qemu-arm@nongnu.org, qemu-devel@nongnu.org,
 Sebastian Ott <sebott@redhat.com>
Subject: [PATCH v6 0/3] arm: demuxed ID registers (CCSIDR_EL1)
Date: Wed, 16 Sep 2026 18:51:14 +0200
Message-ID: <20260916165117.39764-1-sebott@redhat.com>
X-Mailer: git-send-email 2.55.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=sebott@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

To support efforts to generalize handling of writable System ID Registers
[1] this series addresses the demuxed registers that are kept outside of
ARMISARegisters namely CSSELR_EL1.

CSSELR_EL1 is moved within ARMISARegisters and accessors to retrieve
and set the demuxed values are provided. Initial values are gathered via
the usual KVM_GET_ONE_REG ioctl.

V5 of this series was posted here:
https://lore.kernel.org/qemu-devel/20260909144151.26803-1-sebott@redhat.com/

[1] https://lore.kernel.org/qemu-arm/20260616132625.1732031-1-eric.auger@redhat.com/

Changes V5->V6:
* incorporated suggestions from Peter

Changes V4->V5:
* changed diffstat format
* changed cover letter

Changes V3->V4:
* added R-B from Eric
* incorporated suggestions from Eric


Cornelia Huck (3):
  arm: handle demuxed ID registers
  arm: handle CCSIDR_EL1 as a demuxed register
  arm/kvm: get demuxed ID registers from kvm

 target/arm/cpu-sysregs.h     |  9 +++++
 target/arm/cpu.h             | 28 +++++++++++----
 target/arm/cpu-sysregs.h.inc |  1 +
 hw/arm/virt.c                | 19 ++++------
 hw/intc/armv7m_nvic.c        |  2 +-
 target/arm/cpu-max.c         |  6 ++--
 target/arm/cpu64.c           | 14 ++++++--
 target/arm/helper.c          |  2 +-
 target/arm/kvm.c             | 42 ++++++++++++++++++++++
 target/arm/tcg/cpu32.c       | 26 +++++++-------
 target/arm/tcg/cpu64.c       | 68 ++++++++++++++++++------------------
 11 files changed, 144 insertions(+), 73 deletions(-)

-- 
2.55.0


