Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01524F55811
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Apr 2026 08:22:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFSr6-0006T3-43; Wed, 22 Apr 2026 04:22:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFSqq-0006N6-Lq
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:22:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1wFSqo-0006aY-F3
 for qemu-devel@nongnu.org; Wed, 22 Apr 2026 04:22:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776846143;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=v7mXcb0rV5YXLutrX/Be/AdZB7kg6iLn9t0pfFDYmrU=;
 b=U3KL70NXftYXoG/iw6b53G0ZKOwCCWtC5q7LvWIBn0jsBkt8IG8q98WYtY0W5xahmcSbdd
 N/AGDhIqryPq4NHlU71M3CZ3AeZRiZOtRo3edN0jzgyCaR6tXQP+68u9+Kpx49/seWX3Wc
 VizqwlAwEhvO1a5VyWo1bWTtXxXRv0k=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-517-Ej0-f1chO4-kQFX36aPKvw-1; Wed, 22 Apr 2026 04:22:22 -0400
X-MC-Unique: Ej0-f1chO4-kQFX36aPKvw-1
X-Mimecast-MFC-AGG-ID: Ej0-f1chO4-kQFX36aPKvw_1776846141
Received: by mail-pj1-f71.google.com with SMTP id
 98e67ed59e1d1-35d9278587bso6090204a91.2
 for <qemu-devel@nongnu.org>; Wed, 22 Apr 2026 01:22:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776846141; x=1777450941; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=v7mXcb0rV5YXLutrX/Be/AdZB7kg6iLn9t0pfFDYmrU=;
 b=cH0ZTWdnC+Aa6+bYyi7Qdxlg6h76Ycgp7KMOgXoUfBKhjF6GJYNt98H7pk9RWH/gHy
 cuLFD58d5y5RIag5ZstMSCMlUprXTo99gNl4ZzgoVLP/gBP/66HBpc5dLZN39ELpQBz+
 aKola9Qm1eHB8RYgnKw1tTYh3VGxrFzPpCKiy5cbozi5Fe53AfZlGZZQPjaizxNRw7+b
 HReRuCrK5cl6s3An6xlbeljROUI343EWtRtl/VCQWmmgtAIca6EDQidzacweh+fIi1pk
 odd/q4URM73mcifSRNfwB8DyO0DYHgLNnOQSM5Y0vbwQyGFi6VBBdRT98XKrRq0NL6Ba
 megQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776846141; x=1777450941;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=v7mXcb0rV5YXLutrX/Be/AdZB7kg6iLn9t0pfFDYmrU=;
 b=IziDA9QpIiPYKxNjG8opnOs51sKS9jwTodNLKIkDhQobdOAFyH0JtXy5zfrQpjRNN6
 pQTjJgKJigl3ynQObpy9c1hHSXhB0tbfZQwzc5DS7aOAqqyAbouwVkabD8S3jvHfs3d8
 yPOTRngzpuMKt6Vv3EQ/1jSHgzckrRPe/8r60bMwpA6jp+NjrZD9oknLRBPoerucOlpL
 8ho5Q+2mME7uVdC7FZdoa47Kq5Cvmw9TstCBJfW6zhEOtOSmUY7TCMBah4WHYQ7gu2J8
 OwsV52GsjxQWgERwFO2BD6hH3ZFa+an4OMdgFBsVW7UxTbRyR4dw/IwLuGYJM195gWO3
 33aA==
X-Gm-Message-State: AOJu0YzcCSkBQ0N4mXeDwmfe2KnYMiOYM8h2zPuU/TNt9kXBslif+igK
 fS+hvdHVUreisRb54ZN8jOO4eNJzMowtk5UT3zLeUviNgqGNbqSg1RNp7FBsPUQ3LEhUnUCD5vY
 d+HEwwyWoej8yU+hdzTt9B9L7234ZanVW4HlU8rPsVskmYHdaFvjQ2Q8bB91u5L2jXwLSBoh8od
 1uV740IBe+gF5WKb1fqXvIwmUIYcO7RvNVHkHDy7U=
X-Gm-Gg: AeBDieu5WVyZPdcEk8XB0dAB6sS/ag+cUFxbAgqQB0+iigZneZ202WXB447v9gENdyt
 Jrc8yJIterGAVcYWkesL5BwxYplnA48XzF6QwvzOliuXEtc+ojXpAx4RwwZr6DNeTsvQZVgdQjF
 4FuuorIFq5lp535JhTnNmZBUmTiiQakNX9i8MclVXy9Ce8/6JvHfpWexwQy/LGlr+YQtTE5q3JO
 sKBzGzMp1nKtAa+YvWqfuEZsUYeT/iUBe/YKPeNOdZdKvelJ3FD9pRK0W/rbVy97lLvzD1U2/XH
 SpaHD1musWDpXyydNM1LqI6pW4ZRBO3LZ1zCnAsiLTxurcV11EgqJZbkFTSCSdzxajfoyGYaMmk
 x/mRIdvHOC/WB+ZFX7Y7gEb/Te8/Oq9AJxgi7CspJsKv1id2wFrsQAm4uhxwf/QXy51JOYhTgWQ
 ==
X-Received: by 2002:a17:90b:4c8c:b0:35f:c1cc:fef0 with SMTP id
 98e67ed59e1d1-36140473e42mr22550687a91.13.1776846140830; 
 Wed, 22 Apr 2026 01:22:20 -0700 (PDT)
X-Received: by 2002:a17:90b:4c8c:b0:35f:c1cc:fef0 with SMTP id
 98e67ed59e1d1-36140473e42mr22550625a91.13.1776846140099; 
 Wed, 22 Apr 2026 01:22:20 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([49.36.110.202])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3613fabeccesm5991459a91.6.2026.04.22.01.22.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Apr 2026 01:22:19 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH v3 0/2] migration/vmstate: Add VMState support to safely
 migrate GByteArray
Date: Wed, 22 Apr 2026 13:52:12 +0530
Message-ID: <20260422082214.10390-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

In GLib, GByteArray is an object managed by the library. Currently,
migrating a GByteArray requires treating it as a raw C struct and using
VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
ui/vdagent.c

QEMU cannot pretend that GByteArray is a C struct and simply use
VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
overwrites the data pointer with a newly allocated buffer, thereby
leaking the previous memory. Besides, GLib tracks the array's capacity
in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
sync with the newly allocated buffer, potentially leading to heap buffer
overflows during subsequent g_byte_array_append() calls.

This series adds a new VMState called VMSTATE_GBYTEARRAY, which will
directly use GLib library API calls to create, or resize the object.
This is then used in ui/vdaagent.c replacing the use of
VMSTATE_VBUFFER_ALLOC_UINT32.

Changes in v3:
- Add assert() checks to get and put functions to prevent NULL pointer
  dereferences, as suggested by Peter Xu.

Changes in v2:
- Marc-André pointed out the problem of not updating the device state
  itself. To do that we should essentially pass a pointer to the
  GByteArray pointer. Remove VMS_POINTER from VMSTATE_GBYTEARRAY. This
  changes 'pv' to be the address of the pointer field (GByteArray **)
  instead of the pointer's value.
- Update get_g_byte_array and put_g_byte_array to handle this additional
  level of indirection, allowing safe allocation and updating device state.
- Link to v1: https://lore.kernel.org/all/20260406115247.4879-1-armenon@redhat.com/

Arun Menon (2):
  migration/vmstate: Add VMState support for GByteArray
  ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate outbuf

 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
 ui/vdagent.c                | 13 +------------
 3 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.53.0


