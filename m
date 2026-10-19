Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94FF7CCF2DA
	for <qemu-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:13:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xIjQW-0004Xs-92; Mon, 19 Oct 2026 05:13:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xIjQU-0004XF-M4
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:13:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1xIjQT-0001vW-0n
 for qemu-devel@nongnu.org; Mon, 19 Oct 2026 05:13:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1792401179;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=ppQmTYTgy5vliK2NTCy02bRgH3pcUzCbveXlZ+D1DTY=;
 b=JrteIRw1Lzk5bsxvOc3Q3/hY7lTyBQfnkaev0Cmst5Mt8EdH8rwHA2O6IcF9EPfmd8ZTC4
 VdbN/53hGwI86Ky4Od7BLe73ldWXssI5hKD9zPcwYGDwDteoddSt97ndELtON48tRTpGMR
 BJ58gn7vYkFY36GK7WwyNQyRQb54b/o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-638-q0TfzDZ5MlSu-5PkCLLtmA-1; Mon, 19 Oct 2026 09:12:58 +0000
X-MC-Unique: q0TfzDZ5MlSu-5PkCLLtmA-1
X-Mimecast-MFC-AGG-ID: q0TfzDZ5MlSu-5PkCLLtmA_1792401177
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4a1de9dac94so10828925e9.2
 for <qemu-devel@nongnu.org>; Mon, 19 Oct 2026 02:12:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1792401177; x=1793005977; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=ppQmTYTgy5vliK2NTCy02bRgH3pcUzCbveXlZ+D1DTY=;
 b=Odw++2RfEcIvyZPxMyKUVJOEnVvHUioanORB2ZdFy6pJNbULS5NMPUL7f/TtnOFhba
 iv27EYnMr5FlZl8I9Sr5+qAo+FJ1i7E3RgdjRR9y/4TPsrTpHGGmEomMMiNfvPPuigMz
 tFjwQyyvCgA8/7Z0MzWg/aW55w3MnW59MUHJMeTqcdPmqZ8HqqUZrRr5TDOsNGANLZdA
 T8O3bxTzdw8tHs4EQIHVTOqKZOqh9mNz9LaIqd+KlrF/rP7ge3026zLH09TZefZ3pOFT
 euYNPXygCP6Gnbac5+CAezjdukpPIbl4fgcbHqfYdHSOCVJ1Xn6eJzgM/2v1jctaAOm9
 SEgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792401177; x=1793005977;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=ppQmTYTgy5vliK2NTCy02bRgH3pcUzCbveXlZ+D1DTY=;
 b=qK2Ze+EKLmFLCSWIOY95w0ceJC2zM/f1p0VSrPL1Z9N48ltPgt9FsxZnkgba2YNd3O
 db27dA0XXTjam7aA6ldFjtbc909xPzvVtbwweK070EkhvEvwSwWkU9xe/JO7UdOU5al8
 Z4b9rw8Fo/vKn8nli3kcQkBUhR2JT2RoY5teGEpY05zT+p4NHHjacujxnASng1tWTV80
 figxq/iq4eAKj0Q2reicVH4ZBC4s8Dgq7PNn0UgKcvsm4JcdvmZraqTQDNYr42JOX4TD
 WjJF30xcKzIZ3nlg5uKy9p3H4XoC0GLNqezn87GxeN/0HhGToWskUXEY6lAUWg6y6j+j
 EnOQ==
X-Gm-Message-State: AFq9FYLCCFGbhMgrQ224rLEXbKUUeWHe0YMSk5jAzmKjDEiMKGkBz/kC
 wDeIliSE/AQR4cU0puUsXMC0kWlTKaViGn+DrkHLlxTgqVlfay03NXEgmDupEsIZaxGrWRR8Bb2
 L4q5w5lKXdHE9JsP+jMNKm1tt+M01YeYfXwHaWiIg+DrDiQxQoj9HB8F1
X-Gm-Gg: AYBFou048+Jf6MlKpwk99fDqjA61/dvbdE6+qKnxPjMZC0/nKj7NlQVk0CiTmlcsQnk
 J0539r+cDyAF9DBl6GW00iFdpa8UljaiUY1v0xZ04HwMppOFB+2qraTe4xkFccKHzTu3zGgFNsY
 67c1F/7h9KzNFLwU5K1RYmBD0VeNkunU2jpwmCQbfOvmdE7YflMRNqizL7J7xzPmYVW6WEfgtyV
 fydh7cCl8JtYS9MM+Z4ZsxQNy+HYGppcbbDhR19uZIn9tBv286m7mQHgFEXXppIQerqCuslfNoG
 YjcHFhxqGxZigQK+jM5h1z1Zk5gEKUYTJApOELU6mX7Hu2sDxnnDtgpJ+uTtmTNzHH4922B4uPo
 BVsjkIiBCSNyeoikRunOq6wI5V4l0sZlC/d4RBS+mRPlA3/WqnZf84eqmNTxPVsFAaitN
X-Received: by 2002:a05:600c:548c:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1d7610f2dmr150504465e9.20.1792401176694; 
 Mon, 19 Oct 2026 02:12:56 -0700 (PDT)
X-Received: by 2002:a05:600c:548c:b0:49f:dc71:e609 with SMTP id
 5b1f17b1804b1-4a1d7610f2dmr150504115e9.20.1792401176227; 
 Mon, 19 Oct 2026 02:12:56 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.36.232])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd50ae5esm24137600f8f.51.2026.10.19.02.12.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:12:55 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v3 0/2] igvm: add command line parameter support
Date: Mon, 19 Oct 2026 11:12:45 +0200
Message-Id: <20261019-igvm_command_line-v3-0-29aeacbd6cd7@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33NzQrCMAzA8VeRnq2kHd2HJ99DZHRNuwVcJ+0oy
 ti72+0gCOLxH5JfFhZtIBvZ+bCwYBNFmnyO4nhgZtC+t5wwN5MgS2gK4NSnsTXTOGqP7Z285cZ
 0SkOHiBpYvnsE6+i5m9db7oHiPIXX/iKJbfpPS4ILXspaVQAV1g1egsVBz6e8xTYuyQ8hQKhfh
 MyEcIWqtXHopPsi1nV9A4nX02n2AAAA
X-Change-ID: 20260930-igvm_command_line-ccb5a0bddda0
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, 
 =?utf-8?q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>, 
 Oliver Steffen <osteffen@redhat.com>, 
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.34,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v3:
- Removed "kernel-style" from the property description and QAPI
  doc [Stefano],
- Documented the cmdline property in qemu-options.hx [Stefano]
- New patch documenting the MADT, DEVICE_TREE and COMMAND_LINE
  directives in docs/system/igvm.rst [Stefano]
- Link to v2: https://lore.kernel.org/qemu-devel/20261015-igvm_command_line-v2-1-1f358acfdf2f@redhat.com

Changes in v2:
- Updated commit message and doc to make it clear that QEMU does not
  need to parse this string [Markus]
- Link to v1: https://lore.kernel.org/qemu-devel/20260930-igvm_command_line-v1-1-62857007d89d@redhat.com

---
Luigi Leonardi (2):
      igvm: add command line parameter support
      docs/system/igvm: document MADT, COMMAND_LINE and DEVICE_TREE directives

 backends/igvm-cfg.c            | 21 +++++++++++++++++++++
 backends/igvm.c                | 31 +++++++++++++++++++++++++++++++
 docs/system/igvm.rst           |  8 ++++++++
 include/system/igvm-internal.h |  5 +++++
 qapi/qom.json                  |  7 ++++++-
 qemu-options.hx                |  6 +++++-
 6 files changed, 76 insertions(+), 2 deletions(-)
---
base-commit: 9c88811b81a935a172c5c873b2ada2d9b38a5f74
change-id: 20260930-igvm_command_line-ccb5a0bddda0

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


