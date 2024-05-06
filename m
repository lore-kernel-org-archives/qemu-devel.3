Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80210C25B4F
	for <qemu-devel@archiver.kernel.org>; Mon,  6 May 2024 19:07:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1s43fl-0002sP-Av; Mon, 06 May 2024 15:06:49 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s43fW-0002jz-EZ
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:06:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <stefanha@redhat.com>)
 id 1s43fS-0000Ag-09
 for qemu-devel@nongnu.org; Mon, 06 May 2024 15:06:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1715022389;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2FC85QHFSou3g+VF+WZcEDgtuGCnshu1TV5DtCgjLS4=;
 b=M8Sauef9wGRc8fJCGBudznRXKClH6RmYU7yjpW6o4/unlHgXsVJGHJLYSrdj1oHaqGbn7Z
 WKoHlmNknIWZW6kDcbmReCQUO1D6to5+gMiwdP8kA3lmp5QCjC2y3JymYY1Ax0/GK2638q
 tPmVMSjQVHIAVDABFIP7V99Farz2kfA=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-10-4jFI02ctPa2UEbaLehaw0Q-1; Mon,
 06 May 2024 15:06:25 -0400
X-MC-Unique: 4jFI02ctPa2UEbaLehaw0Q-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 24D231C3F0E5;
 Mon,  6 May 2024 19:06:25 +0000 (UTC)
Received: from localhost (unknown [10.39.192.54])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1A5AC492BC7;
 Mon,  6 May 2024 19:06:23 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: qemu-devel@nongnu.org
Cc: Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Czenczek <hreitz@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, qemu-block@nongnu.org,
 Fam Zheng <fam@euphon.net>
Subject: [PATCH 0/2] Revert "monitor: use aio_co_reschedule_self()"
Date: Mon,  6 May 2024 15:06:20 -0400
Message-ID: <20240506190622.56095-1-stefanha@redhat.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.10
Received-SPF: pass client-ip=170.10.133.124; envelope-from=stefanha@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.581,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

This series fixes RHEL-34618 "qemu crash on Assertion `luringcb->co->ctx ==
s->aio_context' failed when do block_resize on hotplug disk with aio=io_uring":
https://issues.redhat.com/browse/RHEL-34618

Kevin identified commit 1f25c172f837 ("monitor: use aio_co_reschedule_self()")
as the root cause. There is a subtlety regarding how
qemu_get_current_aio_context() returns qemu_aio_context even though we may be
running in iohandler_ctx.

Revert commit 1f25c172f837, it was just intended as a code cleanup.

Stefan Hajnoczi (2):
  Revert "monitor: use aio_co_reschedule_self()"
  aio: warn about iohandler_ctx special casing

 include/block/aio.h | 6 ++++++
 qapi/qmp-dispatch.c | 7 +++++--
 2 files changed, 11 insertions(+), 2 deletions(-)

-- 
2.45.0


