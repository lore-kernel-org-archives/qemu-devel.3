Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 85C6CCD98DA
	for <qemu-devel@archiver.kernel.org>; Tue, 16 Jun 2026 05:26:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZMJa-0006tX-OW; Tue, 16 Jun 2026 01:26:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZMJZ-0006sy-4I
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:26:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZMJX-0002NW-9y
 for qemu-devel@nongnu.org; Tue, 16 Jun 2026 01:26:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781587578;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=p6Ua9H0v6bjU0RhRgrvx285XBNcG1bsw1swhwSJnHys=;
 b=UM2dzLERpuV2MVyelnSJZReP/ZqFjenaTTI+K7YCsRw8EEoLdqVxfuW8Mawta8lJMF/Rv2
 TMY/4yWmTSr+WKNdaJOro2UFECYKj9gDld7HZDIbJSDfrGeYXCRaeV5XGPvEvMR1AQqH+T
 ITCInqFApARiaf4ZCZ7Pn5ICiMb3nEg=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-574-f9iEPjwLPtmWfKlC7J-Tag-1; Tue,
 16 Jun 2026 01:26:14 -0400
X-MC-Unique: f9iEPjwLPtmWfKlC7J-Tag-1
X-Mimecast-MFC-AGG-ID: f9iEPjwLPtmWfKlC7J-Tag_1781587573
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E5EB61805A13; Tue, 16 Jun 2026 05:26:11 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.2])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 09182180057F; Tue, 16 Jun 2026 05:26:02 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
Subject: [PATCH v3 0/2] system/memory: Make ram device region directly
 accessible
Date: Tue, 16 Jun 2026 15:25:50 +1000
Message-ID: <20260616052552.389021-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

All ram device regions was turned to be indirectly accessible by commit
4a2e242bbb ("memory: Don't use memcpy for ram_device regions"). This leads
to a hanged guest where a NVidia GH100 GPU is passed from host. The memory
in its PCI BAR#4 can be allocated as DMA target buffer. qemu has to take
DMA bounce buffer in address_space_map() to cover the DMA request. However,
the bounce buffer size is 4096 bytes and we're overrunning it easily when
the guest has significant disk activities on compiling 'cuda-samples'.
The full log and problem description can be found from PATCH[1/2]'s commit
log.

Try to fix the issue handled in commit 4a2e242bbb by replacing memcopy()/
memmove() with newly added helpers qemu_ram_{copy, move}() that works on
top of __builtin_{memcpy, memmove} or unaligned access friendly memory
movement in the accessors to the ram device regions. With this, we can
basically revert that commit to make ram device region directly accessible
again and bypass the bounce buffer in address_space_map() where the guest
hang is caused.

PATCH[1] uses qemu_ram_{copy, move}() in ram device region accessors
PATCH[2] makes ram device region directly accessible again

Changelog
=========
v2 -> v3:
  * https://lore.kernel.org/qemu-arm/20260615100200.266968-1-gshan@redhat.com/
  * Documentation for qemu_ram_{copy, move}           (Peter/Michael)
  * Support qemu_ram_move() for overlapped src/dest   (Richard)
  * Use {memcpy, memmove} if step is 16-bytes or more (Michael)
  * Code improvements                                 (Richard/Michael)
v1 -> v2:
  * https://lore.kernel.org/qemu-arm/20260612110307.1264798-1-gshan@redhat.com/
  * Rename address_space_{memcpy, memmove}() to qemu_ram_{copy, move}()
    and move them to physmem.c and memory.h   (Philippe)
  * Use memcpy() and memmove() in qemu_ram_{copy, move}() for the variable
    length case                               (Miachel)
  * Handle unaligned access in qemu_ram_{copy, move}() for all archs
    except i386 and x86_64                    (Richard/Michael)
RFCv1 -> v1:
  * https://lists.nongnu.org/archive/html/qemu-arm/2026-06/msg00307.html
  * Reworked solution based on suggestions from Peter Xu, Peter Maydell
    and Michael S. Tsirkin

Gavin Shan (2):
  system/memory: Use qemu_ram_{copy, move}() in ram device region
    accessors
  system/memory: Make ram device region directly accessible

 hw/remote/vfio-user-obj.c |   4 +-
 include/system/memory.h   |  43 ++++++---
 system/memory.c           |  41 +--------
 system/physmem.c          | 178 +++++++++++++++++++++++++++++++++++++-
 system/trace-events       |   2 -
 5 files changed, 210 insertions(+), 58 deletions(-)

-- 
2.54.0


