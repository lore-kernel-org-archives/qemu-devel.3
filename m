Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6EBECDB47F
	for <qemu-devel@archiver.kernel.org>; Thu, 25 Jun 2026 07:57:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wcewr-0005ds-8o; Thu, 25 Jun 2026 03:56:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wcewp-0005dX-Ck
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 03:56:31 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wcewn-0003pM-Qm
 for qemu-devel@nongnu.org; Thu, 25 Jun 2026 03:56:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782374187;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=nd8AB2Dkqjkbk387LSpdDKafgypWUqUMWLkthYqiSuk=;
 b=UmxFCmUXPvmtnoYe2QhDuWOfKzZcLbJiHjBa4+P+ADvrpusNuzSl4DCQOuUVPRbUCeU6g1
 qLVDiMT7pYzRXAvXEzNMTC/ioSICp8zcaReFIIwxXi1k8h0GWZLEeuamFbGurY7v0lm4NC
 qONK5DJBj9HdQX1TPhG4Yd4Ho1ZY2Ds=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-TOc5e0AqN96hPvfLOKxpTg-1; Thu, 25 Jun 2026 03:56:26 -0400
X-MC-Unique: TOc5e0AqN96hPvfLOKxpTg-1
X-Mimecast-MFC-AGG-ID: TOc5e0AqN96hPvfLOKxpTg_1782374185
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-46c90c8fd42so1066806f8f.1
 for <qemu-devel@nongnu.org>; Thu, 25 Jun 2026 00:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782374185; x=1782978985; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:from:to:cc:subject:date:message-id:reply-to;
 bh=nd8AB2Dkqjkbk387LSpdDKafgypWUqUMWLkthYqiSuk=;
 b=b+LaTODU1e0NH84Haa03guHtMNJda4+9827q6Tve0XMsrZ6c6hGMZAkG9XhgjWQGp+
 BlhR/vYMm8ADPgyIXM7fMFAsWU7A3g1Ji52vM+Pxm+P1uVaRG/mgk/DKvODrXtk20gML
 uIYTTOFh96fyUGzx8bcnEBhjCTlPtk/5+/MS/NtSDAyMXr/V8nE/kyddeyo4f/V3vIRq
 aKGCr01CwvVKK5S9ESQR1XQ/l7y20n/dO5emZYeOK1PSrxFREe6cHKg94y2fB181QpCB
 /Y2FYr4w0agpd8aHj3iqbJplLouV0a1UocPBhRfjXM7yZJZ+Mcn3I0kDPY3PZacFWN7l
 comQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782374185; x=1782978985;
 h=cc:to:content-transfer-encoding:mime-version:message-id:date
 :subject:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nd8AB2Dkqjkbk387LSpdDKafgypWUqUMWLkthYqiSuk=;
 b=Yse3CiDROEWC9w5mcaAowgn72fwewQjA1Xm3hJFFwsPvLb4J0mQYlomOB9Jv3x73i1
 i+9ZWlhbxy1CNyl5t6+3AWIooA6QASl9goVg8QJUJMXlOwroBq5J4Tib9pXWO5x4B9C9
 NLWNp1nJIjbbdC3Hw+FglsUQASF6H4IkIb41dhaLz+okFWHpzJG5aS0Wor4AVEoJ9SBd
 AnSh25YB2eDuxPB0AVo20e4XdTMqw9n7J+/Gub7QELVywYqyowFPxmNYBkxWjS+gOfTv
 T7KJbbd6OQ7ea8tyToIA674Ua6hkBKo5nMWEVMBskJGS4juRSuKDA5ark9c7aQe9byBb
 /aaw==
X-Gm-Message-State: AOJu0YzLigspoitIfK8KuWcmeWxitxS7BZEGcfTfb97HfuHY7V6JMDxW
 G9DBFU96tsDFZuJR0dSOqDNTTFdd77Wkezrd82TqIns04wMrkyeciWbJbH+JD4Ff6E+fUBOHA5t
 oTKPs7hwl12Es1663hVgGrcu7SHvffplock2O64M+VPes8vozzNNslwoLAIdICiIor5MDoqaE7V
 MAswAlvf80dKWfUGgLtgsQuiUevBesD9/nDhhszWtj
X-Gm-Gg: AfdE7ckZ7YIqfHrAsoegHbJ56P47wuy1b4DvH7OG8X3NEggmy5JrjaWSEk+jLkNAYG/
 Nw/PJxx7xAiX3euUhYek+jJu21cCtq6SLciQ37klNRAAUm8nvn+qbPBx4lwKG/q+p9Lo2BaB+wj
 6pw7yWN+o5yaw73b/N7wBenwJYRxgsiGaxhSUIC8K4a0j1slGvAvIUCmZHv+rdWqysbbM74/0xz
 RyTbvCgq4jdRhgg+JVTPooyMdHzeTI8w39nDIzU2MDbrQNYXMWHmZir4cV61AYkKKYKx1j108d6
 TiBC8Hgjr/Ux9e/frA76oHQLEJ4CVSwkpml0HjNBn4gRCcml47LoZGxkKC+ozYYSIHSM0WpAU+t
 IYbs6SsBjYrSfABZgx+zIepAiiHoFPqgrWuA8arNEcor+el8RYPDzl+UMn5LzZOhZfFxUhvpVJT
 Y9m3yB
X-Received: by 2002:a05:6000:386:b0:46d:7c5a:e9b8 with SMTP id
 ffacd0b85a97d-46dc18a50eamr2356050f8f.36.1782374184811; 
 Thu, 25 Jun 2026 00:56:24 -0700 (PDT)
X-Received: by 2002:a05:6000:386:b0:46d:7c5a:e9b8 with SMTP id
 ffacd0b85a97d-46dc18a50eamr2355973f8f.36.1782374184226; 
 Thu, 25 Jun 2026 00:56:24 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-46de7effe5bsm1899390f8f.5.2026.06.25.00.56.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 00:56:23 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v5 0/2] igvm: device tree support
Date: Thu, 25 Jun 2026 09:56:18 +0200
Message-Id: <20260625-microvm_device_tree-v5-0-bcff11fd6d1c@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33OSw6CMBAG4KuQrq2ZPoDiynsYY2g7lS4QU0ijM
 dzd0RUG4vKfxzfzYiOmiCM7FC+WMMcxDjcK5a5grmtvV+TRU2YSZAUVGN5Hl4bcXzwNO7xMCZF
 TTzllhUVTMdq8Jwzx8VVPZ8pdHKchPb9HsvhU/3tZcOC1AlPr1gOAOSb0XTvt3dCzD5jlAhGwj
 UhCdLBak+R0E1aIWiJiG1FccB9s4wL9AXb9iV4i5TaiCRHStGUTvAz1LzLP8xtHhIRMhgEAAA=
 =
X-Change-ID: 20260608-microvm_device_tree-0263c3b1be86
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
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

This device tree will be consumed by Coconut SVSM with the upcoming device
tree support [1]. This will allow SVSM to run on a normal CPU
(not AMD SEV-SNP) and execute all its tests using upstream QEMU.

Eventually edk2 will also be able to consume DT via IGVM, but the work
has not started yet.

In this v5, I'm adding a patch that simplifies meson logic. Adding it
here to avoid conflicts with patch 2, that needs to modify the same line.

[1] https://github.com/coconut-svsm/svsm/pull/1006

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v5:
- Added a patch, suggested by Paolo, to simplify current igvm meson config
- Added missing fdt dependency for igvm in meson.
- Link to v4: https://lore.kernel.org/qemu-devel/20260615-microvm_device_tree-v4-1-128a59fd2f78@redhat.com

Changes in v4:
- Using g_memdup2 [Stefano]
- madt directive is now protected by CONFIG_FDT [Stefano]
- Link to v3: https://lore.kernel.org/qemu-devel/20260611-microvm_device_tree-v3-1-dfb9cf0000b8@redhat.com

Changes in v3:
- Device tree is packed in igvm core code. [Gerd]
- Dropped microvm patch.
- Link to v2: https://lore.kernel.org/qemu-devel/20260610-microvm_device_tree-v2-0-4fb44730c49f@redhat.com

Changes in v2:
- First patch introduced a shadowed variable, fixed.
- When parameter area is not found return -1.
- Moved `qigvm_directive_device_tree` to backends/igvm.c
- Link to v1: https://lore.kernel.org/qemu-devel/20260608-microvm_device_tree-v1-0-730874ad0008@redhat.com

---
Luigi Leonardi (2):
      igvm: use idiomatic meson conditional for IGVM build files
      igvm: add device tree parameter support

 backends/igvm.c      | 55 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 backends/meson.build |  7 ++-----
 2 files changed, 57 insertions(+), 5 deletions(-)
---
base-commit: b83371668192a705b878e909c5ae9c1233cbd5fb
change-id: 20260608-microvm_device_tree-0263c3b1be86

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


