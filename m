Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E829CCD98DA
	for <qemu-devel@archiver.kernel.org>; Mon, 15 Jun 2026 10:04:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZ4A6-0000Ez-3d; Mon, 15 Jun 2026 06:03:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZ49v-0000E7-Mb
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:03:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1wZ49t-00007O-Vu
 for qemu-devel@nongnu.org; Mon, 15 Jun 2026 06:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781517787;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=dHkDtQCs+k1JtrXGfFOWbYx7a3/UZwhKCaP7RHOGn7U=;
 b=FJ6O13a9gKADphnWcZeBjvVY689FBee7NRkWYYSnasQRIbsGUBclHMkaZVSXfLVfEJWPy2
 uuTvqULqzodOZQadZ5bNfNkU77VFPea5CTkAETPOq/7ldowOQ6av0rRGwQimVuSB7OjiTP
 BVWWmrZ790OKYbtUWyLeERe4ufx0B2I=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-59-oCWgFGreP6KptjgcpRubtQ-1; Mon,
 15 Jun 2026 06:03:04 -0400
X-MC-Unique: oCWgFGreP6KptjgcpRubtQ-1
X-Mimecast-MFC-AGG-ID: oCWgFGreP6KptjgcpRubtQ_1781517782
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 520C71954B2B; Mon, 15 Jun 2026 10:03:01 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.2])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 223C31955BCE; Mon, 15 Jun 2026 10:02:50 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, mst@redhat.com, peterx@redhat.com, alex@shazbot.org,
 richard.henderson@linaro.org, peter.maydell@linaro.org,
 berrange@redhat.com, philmd@oss.qualcomm.com, philmd@mailo.com,
 david@kernel.org, clg@redhat.com, pbonzini@redhat.com, phrdina@redhat.com,
 jugraham@redhat.com, liugang24219@sangfor.com.cn, dinghui@sangfor.com.cn,
 shan.gavin@gmail.com
Subject: [PATCH v2 0/2] system/memory: Make ram device region directly
 accessible
Date: Mon, 15 Jun 2026 20:01:57 +1000
Message-ID: <20260615100200.266968-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: 8
X-Spam_score: 0.8
X-Spam_bar: /
X-Spam_report: (0.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_SBL_CSS=3.335, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

 hw/remote/vfio-user-obj.c |  4 +-
 include/system/memory.h   | 15 +++----
 system/memory.c           | 41 +-----------------
 system/physmem.c          | 91 +++++++++++++++++++++++++++++++++++++--
 system/trace-events       |  2 -
 5 files changed, 95 insertions(+), 58 deletions(-)

-- 
2.54.0


