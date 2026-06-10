Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76996CD8CB9
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Jun 2026 10:11:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wXFty-0006oJ-1f; Wed, 10 Jun 2026 06:11:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFtv-0006nV-UN
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:11:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wXFtu-0003cc-AL
 for qemu-devel@nongnu.org; Wed, 10 Jun 2026 06:11:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781086269;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=KUsCq6ZdNwrKiz5GuwKHsVpmC/P5Ssgn8g9ykuXP/EM=;
 b=VMIfysgHk4xKr8jMY1fdvM8i1pXXOJOlFWLgT30ghWqVZGn7PovekUQVVP6LsuvY2C3tud
 kSNMxszX6aOz93mQ5Bz361xwnQXNDPfq0OBowH9qi1bUjfA0pxBOurSm3fDFBiurrYD/n1
 sZeKi2cGb1fGsRCamgajH+ju1Xd7CrY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-VsGaGFGePUGJxTgX_7sgXA-1; Wed, 10 Jun 2026 06:11:07 -0400
X-MC-Unique: VsGaGFGePUGJxTgX_7sgXA-1
X-Mimecast-MFC-AGG-ID: VsGaGFGePUGJxTgX_7sgXA_1781086266
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490a767b782so52156475e9.2
 for <qemu-devel@nongnu.org>; Wed, 10 Jun 2026 03:11:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781086266; x=1781691066; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=KUsCq6ZdNwrKiz5GuwKHsVpmC/P5Ssgn8g9ykuXP/EM=;
 b=X06dVJdjGZ96Mrazv/D90dmOqoXRHtI/nApiCzIq7Swyp0Qn+63ku41QzvnugwC0PG
 fnwW23heYyntx7cerybyF1v2AtVUbsHhzWKCekPYLtnuYq/gkfaG1q8RuQpRRhfkSo/q
 Mkp7s2jQPQCEVGAWW0Fpu/CbfbztxbeUbZASLTuOSjpsmtnqf6FeGQFga4danUOMjGrM
 KIntMAamfqlMCPpOtBRDCl0h2LTOprn5ZX9dvXh51efhkCBBXT7EBqWojNbWxdJM/SPD
 kalLCarAMD3KAJsZ7xd3LKX3A4WkkL3jNRYk2pmAkXc24CMoTtQt2vs/Pq4zYRawrM59
 svGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781086266; x=1781691066;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=KUsCq6ZdNwrKiz5GuwKHsVpmC/P5Ssgn8g9ykuXP/EM=;
 b=nr8x2ODfi5k5uY1ujMmt38WIXU30UrQmKAILKDq8gCnDlPsc+sbLr1VIL1+2tOzkXI
 VJzL/JQbQ7X9OGUBfm7SyJXO8hQoNFf8BVaJWg1s7TrUmHaWL4dfQPVL8nJ5Toi3iR4S
 V1Et1Z0jwM4AQOBFdVeP38GgleY81oM08si5+cqwfYquDbTDwe2vKKWNsIieLzJsLVj0
 EwgRPayrcqD8tM7JDH45gzOa4pbAoLwrDalaV1daGpSuzD38X84jJhE7K89m4w+xs10/
 mjxT1rIKP9JO7yhW6j4lV5YgGd30FJbmTXihe6cJFOSEG1gGtVke+8zMt/9sO3LDwabe
 nkeQ==
X-Gm-Message-State: AOJu0Yy671MMeaGOViFeqYmmgEtGnffedpG5GQAqaxOj+LLjZWsJQ2A/
 PrjYsYOkTtOFQ3VMNTTuutu8yXNyg7rzKetvo7Bx5PaH9VjVJdspNfmHlKiPPMtWQgD0gLfOgk3
 OAWIetVGYourSxuaclX+PtIZwlGNj24pqLrc88zt+eRB+WE34JxFfvD/2
X-Gm-Gg: Acq92OFXd+i8nEjOrgYrJ68plljLevqScY9sc6OxEuE7muCJuYfBkztlg8w0+uAggl2
 PiLaBFJ5rjx2FbwBtV0OSxlZMSMlCmSJTnptYnZIimSPjm6HWrJP98TJqjrVvsLC60jtIhb7BxU
 cVM6ca/Dt41ySYB192juzUzMOd3Dm9uWr/QuKQH8U54zu5CXsWfhoqHHfCKJkQ97nPmjtYo3SY1
 uD1GR5JaSp3sXyM9N5D4KTnoUDz+QNAgr/MJLgud0dlzF3zIn8Iz/5PYyNy6F3JEl/H7s5HKo4g
 PYq+yUp553J2Em1hsFJNYWsy81w0AWK8AXZniILZn4kvxUJqzKEIniy6O+8FjteLNbT3/nXHAo2
 kCebUrsemKUGRZHZkzRjaVc9s7mqD6O0PvXbeKOzfuM8OKmGDadFV4vPrRzHFhiF4LneAs738Sy
 a12UNmJtZUlNPipjKWKtLdm//7dPI=
X-Received: by 2002:a05:600c:314e:b0:490:a29b:e72f with SMTP id
 5b1f17b1804b1-490c25898d8mr377087405e9.4.1781086266471; 
 Wed, 10 Jun 2026 03:11:06 -0700 (PDT)
X-Received: by 2002:a05:600c:314e:b0:490:a29b:e72f with SMTP id
 5b1f17b1804b1-490c25898d8mr377087115e9.4.1781086266145; 
 Wed, 10 Jun 2026 03:11:06 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4601f2dc412sm73334514f8f.4.2026.06.10.03.11.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Jun 2026 03:11:05 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v2 0/2] igvm: device tree support
Date: Wed, 10 Jun 2026 12:10:56 +0200
Message-Id: <20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/32NSw6CMBCGr0Jmbc0ApjSuvIchpLSjnQXUTEmjI
 b27lQO4/P7nDomEKcG12UEoc+K4VuhODbhg1ycp9pWhw06jRqMWdhLzMvkadjRtQqSq17t+bmc
 yGmrzJfTg97F6HysHTluUz3GS25/6fy+3CtXQoxku1iOiuQn5YLeziwuMpZQvVERTLrcAAAA=
X-Change-ID: 20260608-microvm_device_tree-0263c3b1be86
To: qemu-devel@nongnu.org
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 Richard Henderson <richard.henderson@linaro.org>, 
 Gerd Hoffmann <kraxel@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
 Ani Sinha <anisinha@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 Oliver Steffen <osteffen@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.129.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

This series consists of two patches:

The first patch packs the device tree for microvm. This is a soft
prerequisite for the next patch that exposes it via IGVM.
Currently the unpacked microvm device tree buffer occupies 1 MiB
(the default FDT_MAX_SIZE), while the actual content is well below
4096 bytes. Packing removes the unused space.

The second patch exposes the device tree via IGVM.

This will be consumed by Coconut SVSM with the upcoming device tree
support [1]. This will allow SVSM to run on a normal CPU (not AMD SEV-SNP)
and execute all its tests using upstream QEMU.

Eventually edk2 will also be able to consume DT via IGVM, but the work
has not started yet.

[1] https://github.com/coconut-svsm/svsm/pull/1006

To: qemu-devel@nongnu.org
Cc: Michael S. Tsirkin <mst@redhat.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Richard Henderson <richard.henderson@linaro.org>
Cc: Gerd Hoffmann <kraxel@redhat.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>
Cc: Ani Sinha <anisinha@redhat.com>
Cc: Zhao Liu <zhao1.liu@intel.com>
Cc: Oliver Steffen <osteffen@redhat.com>

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v2:
- First patch introduced a shadowed variable, fixed.
- When parameter area is not found return -1.
- Moved `qigvm_directive_device_tree` to backends/igvm.c
- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com

---
Luigi Leonardi (2):
      hw/i386/microvm: pack device tree
      igvm: add device tree parameter support

 backends/igvm.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 hw/i386/microvm-dt.c | 11 ++++++++++-
 2 files changed, 50 insertions(+), 1 deletion(-)
---
base-commit: cc329c491768b2d91eb0b0984f3baa0bf805776d
change-id: 20260608-microvm_device_tree-0263c3b1be86

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


