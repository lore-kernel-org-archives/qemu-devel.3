Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E50E1CD343F
	for <qemu-devel@archiver.kernel.org>; Sat,  9 May 2026 05:24:20 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wLa9l-0000g2-79; Sat, 09 May 2026 01:23:17 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9j-0000fe-Vd
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wLa9h-0007F4-St
 for qemu-devel@nongnu.org; Sat, 09 May 2026 01:23:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778304191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=mQK+cWYpGtYATC2caDq1sP44DoZwy3++/RCdGJMIVcI=;
 b=FqcVUmb7ISvMSp6TuPfqre9zdFWWPVwRFsR8zLr7YoqIPVDbpmnDEWt+UkdtvDV11Qug3Q
 7KiLj0EvkNPHMH8p+k+cNTYV+I9EKWF+N6XSrYIxhNGpSuT4FFhiibcxT1fK58c/1oPyt5
 G2BwXtxQMLppPK8q2UisjzkdilV63kI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-310-eHv4QvgvM7mO06i858Kb1g-1; Sat, 09 May 2026 01:23:08 -0400
X-MC-Unique: eHv4QvgvM7mO06i858Kb1g-1
X-Mimecast-MFC-AGG-ID: eHv4QvgvM7mO06i858Kb1g_1778304187
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d7730e9e3so1655974f8f.2
 for <qemu-devel@nongnu.org>; Fri, 08 May 2026 22:23:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778304187; x=1778908987; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=mQK+cWYpGtYATC2caDq1sP44DoZwy3++/RCdGJMIVcI=;
 b=kp6VGTGqwu1F+7JRvIcFe+eOan1wlG7wvRSBWs+Zg8M1ecywI4/276/q19A78jHXVq
 1HfFJNi7nmcbQJbexnQV1EBGBGkFeXbaqGodFvrsMvUUu/8GFN+Fz4ipP5i55K7F7W5H
 eR25D2OaCZn+9T/A4fARNH3k/pyi4M+r+EPD95WOgNhn7aps5k6QVUHzhoDCO+UVoHtR
 qeM4Q6JNvypZs7Yyg59nrrUG0uDt1tNhcOnSLb3zwn9Md0IsSu0SMEFOkR/yRfJuJKR+
 hUY1JDCmIIR2e9aihmo7DSFzfsC2+dXkMcJ5+z08dWCvtmXgi1RWCWWvzURBaEavAgc7
 KUcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778304187; x=1778908987;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=mQK+cWYpGtYATC2caDq1sP44DoZwy3++/RCdGJMIVcI=;
 b=fJ8mqMXuG/2mf7OqW1lkzLnqOUjIgeWDsKbtqACpt5oQ4QstF1WP7jkpyU1HhlP/Z8
 NBPoHYJBzHCYbUpqoB+/8YXepXqYcwJr3+J30sEHm/pYeXlbCu7O+B8Q/BQLKk6arykD
 gA2vWgI2Wen0yEJHxNWG/LJNOOnKkB55V97dYVxVGKplhKVpNvFy2ana1AOvp0LPBBaV
 6k0dDi1rzT0UUMDShEHXr0NS2dZxPETU7pLoU1f6n4oXtbbbT8Xm9rMG5ijSdCQzEDrG
 XMs8pQXWZH4h6wnXjfQdYIeZ4tyvi7X24BMmpaq/6Qa4dl1TKi76ieekuYdFfrfHjZJe
 av5Q==
X-Gm-Message-State: AOJu0Yzy3MGDGkcSEouw8j7bufVT4dTBAAIEDPYID84gRfs/+rku8mx5
 LrQjKPloiwm6RGRraJtNH4Idj+ywJoUKcd5zRU4bD/5APjVRllZMSF9RgDrMMLX/0T0/5mbJ7BE
 7k5ZjEjlatFkVth2sTkaafHLtrRQEAP6DyHgoD0FjyA97ckZJGz9MJHPKYNvENEOt8tTXfwO/Au
 oBo9f13TRFgc6L8v1LKipI7GLygm2zPLaEuXvca7a1
X-Gm-Gg: Acq92OEazlIKNqd7wGfD3wZmVR12UV4zXqqyK4NKsDsljjEPJGNjDgJfasT9YfCrSwH
 K56U7sF2Mmv0HMgYc7EYiQqNOwODk0JPmWZE9GQfIzeSOQRbf5sag9LmDtufw35lORq31pmorDW
 pxz8bHqeGvwnWrJdIvReE1RrQ07OYlP7Ed7YHpcHeBfNKgobY0insjS8ak6Sc8ltJOdJyaJLXnc
 MYy83qPcIR76r+a3dcPQD/vIZRfJkry573P21GfHIyx3r1y9s11uzjwSHr4H9U6vrvhs/7D+9AQ
 G5k3oxaAdo2mBw5xjFpsyKwIOWl8r3XiMqksHAZhf1VtlkeR9+oxjowzWraRWOGJ1rBwRLDE6hP
 sqM+TXJa/OPkpgM04Acwt3Qi4Avny5sHBvpmshryZAVLoa76P6QO/9gsn/7ycov48p4y+VD3x5q
 Wui+f77mZUM608BA/Ibewt1/IJ4ldd
X-Received: by 2002:a05:6000:2902:b0:43d:3004:5fef with SMTP id
 ffacd0b85a97d-4515a6c331amr24599658f8f.7.1778304187021; 
 Fri, 08 May 2026 22:23:07 -0700 (PDT)
X-Received: by 2002:a05:6000:2902:b0:43d:3004:5fef with SMTP id
 ffacd0b85a97d-4515a6c331amr24599611f8f.7.1778304186435; 
 Fri, 08 May 2026 22:23:06 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.106.181])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm9405589f8f.25.2026.05.08.22.23.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 22:23:05 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 0/5] SCSI changes for 2026-05-08
Date: Sat,  9 May 2026 07:22:59 +0200
Message-ID: <20260509052304.2159829-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.44,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

The following changes since commit ee7eb612be8f8886d48c1d0c1f1c65e495138f83:

  Merge tag 'single-binary-20260506' of https://github.com/philmd/qemu into staging (2026-05-06 10:45:02 -0400)

are available in the Git repository at:

  https://gitlab.com/bonzini/qemu.git tags/for-upstream

for you to fetch changes up to 87c7b07fe4aa43dc7257b1e711faa835fac1cccb:

  scsi: handle reservation changes across migration (2026-05-08 16:40:20 +0200)

----------------------------------------------------------------
* scsi: register again after PREEMPT without reservation
* scsi: handle reservation changes across migration

----------------------------------------------------------------
Stefan Hajnoczi (5):
      scsi: change buf_size to unsigned int in scsi_SG_IO()
      scsi: adjust error_prepend() formatting
      scsi: always send valid PREEMPT TYPE field
      scsi: register again after PREEMPT without reservation
      scsi: handle reservation changes across migration

 include/hw/scsi/scsi.h   |   3 +-
 include/scsi/constants.h |  10 +++
 hw/scsi/scsi-generic.c   | 181 ++++++++++++++++++++++++++++++++++++++++++-----
 3 files changed, 175 insertions(+), 19 deletions(-)
-- 
2.54.0


