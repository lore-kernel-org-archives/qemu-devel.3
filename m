Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE068D2AB36
	for <qemu-devel@archiver.kernel.org>; Tue, 29 Oct 2024 12:27:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5lIv-00068t-IF; Tue, 29 Oct 2024 08:26:33 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIm-00067q-Ep
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5lIj-0000TM-Uf
 for qemu-devel@nongnu.org; Tue, 29 Oct 2024 08:26:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730204774;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=y33qZbUFSEkyc3rFEJRYkzEkfYIPqDHFZ0ucvjHIYUA=;
 b=RlkRCYhIRR/UoVY733+s6+iQevivc/06sHhv4LyTfPiGzlzONnLoLByYhMHZTRIz7kZxMs
 qLTrwYFkd7x3J3giDuQ88aoBMJ0903N2xpS6xeMG0chZrmHrLNmq2F9kmYnZtmiC9mRWzP
 zy9b7bKF0m79IiaUW/3fKBFMCJJCTZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-260-1JgxfUe0NcG9VkAns1QMqw-1; Tue, 29 Oct 2024 08:26:13 -0400
X-MC-Unique: 1JgxfUe0NcG9VkAns1QMqw-1
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-37d4a211177so2637924f8f.0
 for <qemu-devel@nongnu.org>; Tue, 29 Oct 2024 05:26:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730204771; x=1730809571;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=y33qZbUFSEkyc3rFEJRYkzEkfYIPqDHFZ0ucvjHIYUA=;
 b=UCSfDFTll8ieWFBpzxqhVDtgBaWGtk/wDCiQYI036zJvLFlJjdywCdGEo/Td7oZxbs
 iqHLPVRfrhHnVuR8Z/pGmHZ7ipX0jxIvi2Aj5aDQd67zpWc1Z6Q+dvNXTYbJoyJu7y/d
 j5X4hfR2SEFj8RK1YdAjDj3lq2Kyj/kfae7lDv83hITOALeen7GBdtCsWfUE4MUnXBHm
 jT1iUBl5vVMcJa55Pg3iMqTQEXq9YO8uNZb82MkgaSuEfXWotxL72KMnYHuyPvvmTeVO
 NVkS41M62yn2wnxrTBOA1CcnqFqTPEWudID7JZWyQBbMnC8YHfbn/9VZG5rhFP3iYhbx
 yLTQ==
X-Gm-Message-State: AOJu0Yyu+3YaVtPOWvZFH7za7p6A8/SZqq20qiyLkpgAdSHYdwfs2YbZ
 m3h+MChUQ8YvecAgk6NL96TOqkKOv/EMIVKf9gXdhotiITPyQlasq1zEuVADLizry2Ff/nnEAV8
 VF7wi8idc2bvwgHNGM4qPCrUMD8Sq6Gh3reOYpSQyu0axaV8tJ47M3v66CBgQnZUc2tdPXetcjB
 1o2KZp2xHT1oPnJx7tkOWNE1GoXOyU07xr/gpf/MM=
X-Received: by 2002:a5d:484a:0:b0:37d:8084:160b with SMTP id
 ffacd0b85a97d-38061127f9cmr8169765f8f.23.1730204771147; 
 Tue, 29 Oct 2024 05:26:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuERZ35J6x2bt5BXerTtvIXSOQ2Chkcjgneanh2N0DEjfL3TYncVVgPFBoXs2XHHG+bNVGNw==
X-Received: by 2002:a5d:484a:0:b0:37d:8084:160b with SMTP id
 ffacd0b85a97d-38061127f9cmr8169747f8f.23.1730204770679; 
 Tue, 29 Oct 2024 05:26:10 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b47a41sm12367293f8f.52.2024.10.29.05.26.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 29 Oct 2024 05:26:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 0/5] qom: module loading cleanups
Date: Tue, 29 Oct 2024 13:26:04 +0100
Message-ID: <20241029122609.514347-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.302,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

While looking at possible Rust APIs for object_new/qdev_new (one of the
functions that rust/hw/char/pl011 uses via FFI) I noticed that the support
for modules in QOM APIs is quite random.

In particular, loading modules is done by object_initialize() and
qdev_new(), but not by object_new(); furthermore, the loading code is
duplicated between object_initialize() and module_object_class_by_name().
This series fixes that.

Patches 1-2 are small cleanups.

Patches 3-4 let object_new() use a module if the type is not present,
like object_initialize() already does.  To get there, all calls to
type_get_by_name() are changed to either type_get_by_name_noload() (the
old function) or type_get_or_load_by_name() (which looks at modules
like object_initialize() and module_object_class_by_name() do).

This is enough to let Rust code use a single function object_new() to create
QOM objects; the function can be wrapped to allow writing something like
"PL011State::new()" instead of object_new(TYPE_PL011) as *mut PL011State".

Patch 5 finally allows modularized user-creatable classes, which are
not allowed just because the code uses the non-module-friendly
object_class_by_name().  While there are no modularized user-creatable
classes right now, there is no real difference between them and
character devices (which do allow modularization).  This patch could
be left out if desired.

Paolo


Paolo Bonzini (5):
  qom: remove unused function
  qom: use object_new_with_class when possible
  qom: centralize module-loading functionality
  qom: let object_new use a module if the type is not present
  qom: allow user-creatable classes to be in modules

 include/qom/object.h    |  8 -----
 hw/core/qdev.c          | 21 ++---------
 qom/object.c            | 80 +++++++++++++++++++----------------------
 qom/object_interfaces.c |  4 +--
 qom/qom-qmp-cmds.c      |  4 +--
 5 files changed, 43 insertions(+), 74 deletions(-)

-- 
2.47.0


