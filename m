Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 16A8FC3600B
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Mar 2025 16:11:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tx6oc-0004bT-Ul; Tue, 25 Mar 2025 12:07:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o8-0004Un-Sj
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1tx6o2-0007Me-IM
 for qemu-devel@nongnu.org; Tue, 25 Mar 2025 12:07:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742918829;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version: content-type:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=aPucCJcezmnrMHSlX3SuWvFnIYSF1kQvwN+fpOZv8bc=;
 b=DHR0501YwRm5+KqcXCTzlspHA9N3ZQSe223X2msLLUG4uUWDTBWsuYOvkw+X+xIiRn2G9n
 76Zniy4I1hw9HaViEZWttjD85mw2N/fRM37bALP7P3b8EOdcp2gTsLWgUncphIBZFxYSNf
 4x1I2Ulo7WfJoYtceIMfBlR1XbJ47WI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-589-be4OaaM4PZ2y59Kep1kPZw-1; Tue, 25 Mar 2025 12:05:43 -0400
X-MC-Unique: be4OaaM4PZ2y59Kep1kPZw-1
X-Mimecast-MFC-AGG-ID: be4OaaM4PZ2y59Kep1kPZw_1742918742
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-3913aea90b4so2205496f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Mar 2025 09:05:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742918742; x=1743523542;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=aPucCJcezmnrMHSlX3SuWvFnIYSF1kQvwN+fpOZv8bc=;
 b=VddIMfTVxb19sbNUFKRxffm7nfm684IugGcbn4KrwMeasE7tYm7q6ax0MpL9OOHBS4
 pWuIGQIPssmb2Y9CWSryOZr9wJsrcdbrJBTGqUE7FMPlwe55yLDrCMxCf36LhXLHm5Fh
 c6qYBNkRgP0++DDBOUpjyNGRdePKm26g+89n6dBG2OUSRFMIGdTXVMSEwe+oVPMz3JN1
 3w50+0gWqknhOnQmB1GvO9s7wMKpe4/jp07NV7iCjSpcMbaQCa5UuORVnqGSB8oXXnM1
 nPU1+7NXyLiWo/dkfzyEvzQ6Np53HSyzDlEvj9rAYoOOFuJF0+eb+ev532ZU64N7Vn4Y
 YeUg==
X-Gm-Message-State: AOJu0Yw8N9dQgszPIxXQHoAhal32Gv64Ggq7hLzsuIfqBI6z7tFS/EH/
 8hfWb54KU7LWbyvsmtmEhQVqTgWxw4A2M/PLZYhvmOojTPnOerYRkve+lPHLkpEwiYv5aMnr4AK
 9PXJQtUk7rFlxv1hmdvrrThv/V853qiltFyIlv7cWjD++MePl7tly
X-Gm-Gg: ASbGnct54pDRJCfVaDQEw80D4nMn49SnAlRnasOehLBtg5dborBpMae8khed9+d/yvf
 AWGwncFngCzazNmleOSYDKCV/ni8fulJ7GDWdl9clLtz+PBzhvbhYP9K+85c8q3U1iscRiZfQZm
 JMYwIRfMQMTc07TRJU/nzWrxWmuvoMcU3ld9E11+oZOF9DZ5O/VI7OelYyaDjb/jXdRaEtfiAP6
 LdIEVvKsbJ261C/j/7t9NM72CCJGbi7ZDm8f9QRyjxCQc8k9f9f8Y2+WJY83dTSDB6+ezQfuCey
 cFBmHLcGkHKYKho+t3/gr23zDA4LtA6AcFy1UtfsCXJRf1yS9xFGEV9iw7E7G/3ywtI0bXJ1/Q=
 =
X-Received: by 2002:a5d:6d09:0:b0:38f:28a1:501e with SMTP id
 ffacd0b85a97d-3997f8ed9dfmr16321952f8f.8.1742918741681; 
 Tue, 25 Mar 2025 09:05:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGj2CLKK4M/NmBl8C8a4MTh7WVAbcrdNFmWbdjYrrKO+gE0EQ1LLOtAm+Sz2wbRJVrfQAikbA==
X-Received: by 2002:a5d:6d09:0:b0:38f:28a1:501e with SMTP id
 ffacd0b85a97d-3997f8ed9dfmr16321910f8f.8.1742918741294; 
 Tue, 25 Mar 2025 09:05:41 -0700 (PDT)
Received: from localhost
 (p200300cfd74f9db6ee8035b86ef736e5.dip0.t-ipconnect.de.
 [2003:cf:d74f:9db6:ee80:35b8:6ef7:36e5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-43d4fd9e960sm153568945e9.29.2025.03.25.09.05.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Mar 2025 09:05:40 -0700 (PDT)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>
Subject: [PATCH 00/15] export/fuse: Use coroutines and multi-threading
Date: Tue, 25 Mar 2025 17:05:29 +0100
Message-ID: <20250325160529.117543-1-hreitz@redhat.com>
X-Mailer: git-send-email 2.48.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=hreitz@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Hi,

This series first contains some two bug fix patches (one more than the
other), then a couple of small modifications to prepare for the big
ones:

We remove libfuse from the request processing path, only using it for
mounting.  This does not really have a performance impact (but see the
benchmark results on that patch’s commit message), but it allows me to
sleep easier when it comes to concurrency, because I don’t know what
guarantees libfuse makes for coroutine concurrency.

In general, I just don’t feel that libfuse is really the best choice for
us: It seems primarily designed for projects that only provide a
filesystem, and nothing else, i.e. it provides a variety of main loops
and you’re supposed to use them.  QEMU however has its own main loop and
event processing, so the opacity of libfuse’s request processing makes
me uneasy.  Also, FUSE request parsing is not that hard.

Then, this series makes request processing run in coroutines.

Finally, it adds FUSE multi-threading (i.e. one FUSE FD per I/O thread).


Hanna Czenczek (15):
  fuse: Copy write buffer content before polling
  fuse: Ensure init clean-up even with error_fatal
  fuse: Remove superfluous empty line
  fuse: Explicitly set inode ID to 1
  fuse: Change setup_... to mount_fuse_export()
  fuse: Fix mount options
  fuse: Set direct_io and parallel_direct_writes
  fuse: Introduce fuse_{at,de}tach_handlers()
  fuse: Introduce fuse_{inc,dec}_in_flight()
  fuse: Add halted flag
  fuse: Manually process requests (without libfuse)
  fuse: Reduce max read size
  fuse: Process requests in coroutines
  fuse: Implement multi-threading
  fuse: Increase MAX_WRITE_SIZE with a second buffer

 qapi/block-export.json     |    8 +-
 block/export/fuse.c        | 1227 ++++++++++++++++++++++++++++--------
 tests/qemu-iotests/308     |    4 +-
 tests/qemu-iotests/308.out |    5 +-
 4 files changed, 965 insertions(+), 279 deletions(-)

-- 
2.48.1


