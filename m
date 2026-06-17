Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 250E7CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:31:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIg-0006lX-Ez; Wed, 17 Jun 2026 10:31:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIf-0006k4-17
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIc-0007q4-86
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706685;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yFcQux/tAmWJGykxyHq+NKOI4I25Z8GS1E9kXCx1v+M=;
 b=HhwdRR6dc95gspk4Z/r/arOwjG98n1xEVPjH5+BuroSYG2b1g2+BYUGbIpdU2WmxqxYUS6
 OK52H5W/XLh4h+6HcrXaU+ZpZSXrLKdPEP82/4mE/Nj5uuS6lb4+VDDkbM1ahukyjBbYIY
 mDp8/R9/wNhQ5oGjTpk5cwGSbag46KQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-433-sJ8LFlIMMyST2c9muk-j9g-1; Wed, 17 Jun 2026 10:31:22 -0400
X-MC-Unique: sJ8LFlIMMyST2c9muk-j9g-1
X-Mimecast-MFC-AGG-ID: sJ8LFlIMMyST2c9muk-j9g_1781706681
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490dad70f95so59778685e9.3
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706681; x=1782311481; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yFcQux/tAmWJGykxyHq+NKOI4I25Z8GS1E9kXCx1v+M=;
 b=lRUMiApsYDmYXneZ9KhCNckh3nFg9Yho9vL4hiNAOOv5Imy/1Jo3HpIl9CFroccTMh
 5zWYeYS5gHpkyyhhJE4WCBqCoxoZZF1Q3x+1yBW4XdK0imJdOYUdFAP0+TbwaY4e0Xv9
 y87q4dZgnL9DH3Sb6OsuuhcpNOLjT4MuURvGMzNy1RaUIyk2W1FwEsnw6E+X2+z+NMG+
 TraLon8ceIPfMxUSPyDuqBfl0dLwYPHvCDl572XmYm4DN2NYEHrw7gUm0K9HuIH2g8L9
 ROzaXPtaH3xSXaO2AmV6J6E/1wyufl03GiUz7aKxJjKrbTRJMRgPEtn6spmN7ncnBheL
 Ajkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706681; x=1782311481;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yFcQux/tAmWJGykxyHq+NKOI4I25Z8GS1E9kXCx1v+M=;
 b=onyxAmln3WVO1S0mvUKxQvZK71nkHG1nPrLghfjXNRLd9Lp9DiMFJTWfv2JPvZX7jX
 etmSYWFk+P48hfZAbN36KR8b7Hx78WNrC7SMySTpxcoL94ApP+fXEoqSF8KKvJEUwSjA
 gmR2qjU3fD8CZa0xDYGbf0rDpmE4jiL8BsyNKFInlmLua/M3M6zDvQcT2r/S6TQCmuix
 7Mz6PeMcakMTQ0qVTHf9JpalVnUpW9+Kdkz9ysWW5riqceActSbYzeC6iVpmKskW6F9O
 Du2b95NSALex+2xO+Gp3BqC6vVE3+L8Wr9jfCA1UFv2oiFvF4z9SPo1wzOY0YtX9sqkM
 QqiQ==
X-Gm-Message-State: AOJu0Yw7Bl0EBLnmFGZVO/Ztup8EFEYyChanofHieGDctcCGTwfjzjGi
 QUgGVAlH0LAQMEbkIdS+nkDiWr3Cz1s103fMXHuTf11ok5fmnPdmHi0UUgLtU1oJiztwtotPMXt
 7c4N7Lq2EPJw+TJDXCG5C/vmDFTy6JtgUtM7YQ7Sjs7JZplju9pIoK8RIDMgAfscgEMB7n6kSK9
 4xP0XnFex1CXG8/VzDKLvBo/9lADTGgIN0Xy1IyZTs
X-Gm-Gg: Acq92OGawP8mKbHfERrQI2FZjouddr2HkeIaVFL/Pn4lV4mhifPgqSs3AwTCLr7Bvq6
 cBd3iajfV6RcVlm9K2y62MfGTqyAhEb9VYbfK5ZBaIzV0lOlDzx5wQm+Tr8NLXbz8ygaiMK7z/P
 HdRaxvxJluditicPQoeRj99gXr0E0Q77LCMcEv/cyVesuizzZzGKcOVL41THafG4DNzKvpk6MNW
 J/BO6RSNv15VwJpEK5XWn9Q+k6K8FICuxEr9iRVNWedp+JEDr27NOqaEtzm5JzfM9d9KcDnpSW2
 hFTu7xf/9267c0+k8oAOm4CwaaSORe4NPpS7yH5Ng9XiJTLu9oZOjSIgKGQFCJcQ3LJvn92Oa/J
 1zDVHEnUYfgKHaZ3QNwa5y5coLOEZgRAuWPXQj0XVxrmUIWomn2HZVSjTU2uuH/x6/BeR3AuzAb
 P5OTHFiQbrlCCQy9QW
X-Received: by 2002:a05:600c:4e92:b0:491:ba04:2ce4 with SMTP id
 5b1f17b1804b1-4923410c35dmr55893465e9.16.1781706680557; 
 Wed, 17 Jun 2026 07:31:20 -0700 (PDT)
X-Received: by 2002:a05:600c:4e92:b0:491:ba04:2ce4 with SMTP id
 5b1f17b1804b1-4923410c35dmr55892705e9.16.1781706679985; 
 Wed, 17 Jun 2026 07:31:19 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4922fa96f0esm184613725e9.12.2026.06.17.07.31.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:18 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 12/16] qga/meson: Use windows.compile_resources instead of
 custom_target
Date: Wed, 17 Jun 2026 16:30:42 +0200
Message-ID: <20260617143046.445322-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

windows.compile_resources supports more compiles and works
in both MinGW and MSVC environment. While 'windres' is a
MinGW specific tool.

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-4-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/qga/meson.build b/qga/meson.build
index 1c6433ef250..85bdacf7e2a 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -105,16 +105,14 @@ endif
 qga_objs = []
 if host_os == 'windows'
   windmc = find_program('windmc', required: true)
-  windres = find_program('windres', required: true)
 
   msgrc = custom_target('messages-win32.rc',
                         input: 'messages-win32.mc',
                         output: ['messages-win32.rc', 'MSG00409.bin', 'messages-win32.h'],
                         command: [windmc, '-h', '@OUTDIR@', '-r', '@OUTDIR@', '@INPUT@'])
-  msgobj = custom_target('messages-win32.o',
-                         input: msgrc[0],
-                         output: 'messages-win32.o',
-                         command: [windres, '-I', '@OUTDIR@', '-o', '@OUTPUT@', '@INPUT@'])
+
+  windows = import('windows')
+  msgobj = windows.compile_resources(msgrc[0])
 
   qga_objs = [msgobj]
 endif
-- 
2.54.0


