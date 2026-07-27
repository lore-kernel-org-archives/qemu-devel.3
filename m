Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3FBA1C53200
	for <qemu-devel@archiver.kernel.org>; Mon, 27 Jul 2026 03:28:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1woBzr-0000lV-Uo; Sun, 26 Jul 2026 23:27:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woBzp-0000kc-SE
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:27:17 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1woBzo-0006Rw-12
 for qemu-devel@nongnu.org; Sun, 26 Jul 2026 23:27:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1785122834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=HKi1vM3pLDl7/7F3I1eSr+cjld9J2mKEQ5d34uUoAH4=;
 b=Chfb+vCb5/NlsF1EhN2Qt/5WDN28Wc+zDgH/Wr48C1Q3MNWppBIneDDrTrqhvS1HArGZ/b
 Txhhx/kzy+RJQ1+gd3WYj0RMaAAcwL00YdSMivSPCa926TkJZeD+dlJuJsZtAuElPBWyhp
 hvCMnYBpq68BLStk2YhMAbQBSYMlmRY=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-412-FdlThgtKMz-3E-BHhzAODA-1; Sun,
 26 Jul 2026 23:27:10 -0400
X-MC-Unique: FdlThgtKMz-3E-BHhzAODA-1
X-Mimecast-MFC-AGG-ID: FdlThgtKMz-3E-BHhzAODA_1785122829
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DE5CB1800345; Mon, 27 Jul 2026 03:27:07 +0000 (UTC)
Received: from gshan-thinkpadx1nanogen2.rmtau.csb (unknown [10.64.136.50])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 8EFAE1955F75; Mon, 27 Jul 2026 03:26:56 +0000 (UTC)
From: Gavin Shan <gshan@redhat.com>
To: qemu-arm@nongnu.org
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 philmd@oss.qualcomm.com, peter.maydell@linaro.org,
 richard.henderson@linaro.org, alex@shazbot.org, berrange@redhat.com,
 philmd@mailo.com, david@kernel.org, clg@redhat.com, pbonzini@redhat.com,
 phrdina@redhat.com, jugraham@redhat.com, liugang24219@sangfor.com.cn,
 dinghui@sangfor.com.cn, shan.gavin@gmail.com
Subject: [PATCH v4 0/3] system/memory: Make ram device region directly
 accessible
Date: Mon, 27 Jul 2026 13:26:46 +1000
Message-ID: <20260727032649.145381-1-gshan@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.133.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.58,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 HEXHASH_WORD=1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001,
 RCVD_IN_MSPIKE_WL=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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
to a frozen guest where a NVidia GH100 GPU is passed from host. The memory
in its PCI BAR#4 can be allocated as DMA target buffer. qemu has to take
DMA bounce buffer in address_space_map() to cover the DMA request. However,
the bounce buffer size is 4096 bytes only and it's exhaused very quickly
when the guest has significant disk activities on compiling 'cuda-samples'.
The full log and problem description can be found from PATCH[2/3]'s commit
log.

Fix the issue handled in commit 4a2e242bbb by replacing memmove() with newly
added qemu_ram_move() where the aligned and small-sized accesses are handled
by qatomics, and fall back to memmove() otherwise, for the directly accessible
regions. With this, we can revert 4a2e242bbb to make ram device region directly
accessible again and bypass the bounce buffer in address_space_map() where the
guest hang happens.

PATCH[1] replaces memcpy() with memomve() for directly accessible regions
PATCH[2] uses qemu_ram_move() for directly accessible regions
PATCH[3] makes ram device region directly accessible again

Changelog
=========
v3 -> v4:
  * https://lore.kernel.org/qemu-arm/20260616052552.389021-1-gshan@redhat.com/
  * New PATCH[1/3] to replace memcpy() with memmove() (Peterx)
  * Unified qemu_ram_move() for all architectures     (Peterx/Michael)
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

Gavin Shan (3):
  system/memory: Use memmove() for directly accessible regions
  system/memory: Use qemu_ram_move() for directly accessible regions
  system/memory: Make ram device region directly accessible

 hw/remote/vfio-user-obj.c |  4 ++--
 include/system/memory.h   | 28 ++++++++++++++++----------
 system/memory.c           | 41 +--------------------------------------
 system/physmem.c          | 39 +++++++++++++++++++++++++++++++++++--
 system/trace-events       |  2 --
 5 files changed, 58 insertions(+), 56 deletions(-)

-- 
2.55.0


