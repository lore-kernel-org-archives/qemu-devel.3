Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDBC3E6F095
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:31:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3P3-00015O-Pp; Tue, 23 Dec 2025 09:30:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Oy-00011f-SC
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Ou-0003hV-OJ
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FJCxXjvbHoSTcTF3F7Cydt9isGH5zYxpLXCy6vGUHCo=;
 b=KQWm6EXku88ALOaQHYZ8FY5JzW6CkrRrZGPokZZCCv7OUynbu0MvIYl8PIURpDTy0Zw2lp
 fO2x1t/QcQBNYMEWMAChYqcbb0yrlFID7XhKBhylm3RTw670AQlbEj6w6cQfH/+68EOBjk
 rC/tDOzTMvdwZoXEAfuAsmtsQWzCnc4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-456-JZooz3inNwyT0FTSHU8vgA-1; Tue, 23 Dec 2025 09:30:09 -0500
X-MC-Unique: JZooz3inNwyT0FTSHU8vgA-1
X-Mimecast-MFC-AGG-ID: JZooz3inNwyT0FTSHU8vgA_1766500207
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8b2e41884a0so1308652985a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500207; x=1767105007; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=FJCxXjvbHoSTcTF3F7Cydt9isGH5zYxpLXCy6vGUHCo=;
 b=NtYnVkX4mGjl+oE8DHLacC7qm7qt0yownLVoMHM/r4O31TaRIog64RU3gsnxX0o5jY
 jEqKFyOF9CN/L88E7RZMrwtpRtwMzAW8jEpH8lNzhoTp3wa0pbcV0caL/+MrnOnKjEF4
 nQWBxZ3ZsoXp3H2ZcwEbFiL/IbuEPDNenTIzCw9qlV0atohFbc2ec5VjSvaHu0JyQ7Td
 u1K7okLoDXuxZRTIsXWU1Bolg6gPitlJ3kDYn5ajBNjbPMis0L/qk2O9/iZsxo0f6dIr
 HiSq2O4FZkE+YbXlIhYpLHQ9oH2qhoIezUMc5rptoRA41QI5O6U016y39/TF1iScKE+Y
 ne/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500207; x=1767105007;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=FJCxXjvbHoSTcTF3F7Cydt9isGH5zYxpLXCy6vGUHCo=;
 b=PWwcjv8Z5M4TdwN5b+cls5yRELGmgyml8XniHQ4r7Mb8fclR2PNBdmDY7jwAHMmwF1
 gPLyccBmALtaeYla/aXq9NP064A8MUSjJ9CbLRH53zOGmacWtjGSwI/XrDcRvOj4DGC8
 BFJYxFYDRWLElGmrBjtjeajukqUyDXIkDl+amBlQMFr2GCKEgJUWJcZH/AjVJS4otYA0
 0CzJJfzFb9V8RJafUQ4GCFaLKGvkpFQu04HxmzM4bKjUHHK1zY8PUUjoTHiVKJla1iHt
 SDOnqD6xnExeXrAJ32GhTZEGe7wtJwaNpRuYPp1poqCQdPCVOwet8t/UVxtBrhB3aKeH
 bEoQ==
X-Gm-Message-State: AOJu0YxQ4sTkemHG+wE2EtixGuXNbJNb7Mif9ZzA4LDELi3dSbgs8HWd
 Q7CpIp83CJfwgH95uQdQFfugVyZAqajf+ZnKBpldjXWoGYImVHxyR3sdejppwhpaiCec0epCDFF
 1seQEJ7zVkX2692qk/a/ZgH0TUERyDB9yzldgARxjXkpsSadM1TqTwx55+COmSacwmMYITzRbpu
 bC/Yth8FTpp58hfBMnfLKWlBXuATt0tMCTdqQWOA==
X-Gm-Gg: AY/fxX7UO5RW/8rmFZPr9p3Ho8ZxWFSsRfYjNR2SDT6mz2wG4zkhFk/QOjRJV5MXet7
 oMlJMPuaNuea0Vq6WBSrI8KVD5cXkmON/58PsaYWsu/yX/2XosvOVYW+NEMdZ6MJdOYOYXwQYFw
 Qs1m7e5QLHGuS/n/kBgBWqbiup3l6u4epj/le4L+oinx05dLosZP73QZZ9td67Hb23rZO1XRs5W
 5hDU81mf5Ms0LB0+sXpOlTYXN3NUEybp8R3jBKEY8Y1GwOEhi1YTjO5V7JL9uerCKDYiizc3j35
 VXG9dogo1HW/efTyVUKkdkossb5pq9TEa/FiSrKKHzj9M7f0YfITcbraml3FSrEMrz/AZQLITwr
 L42I=
X-Received: by 2002:a05:620a:1a0c:b0:8b1:d2f7:9586 with SMTP id
 af79cd13be357-8c08fd041c2mr2235942685a.64.1766500206756; 
 Tue, 23 Dec 2025 06:30:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFqkHqlu72dGz634+VKDjEnLMdTmYCEkAmDtAx6ikSCtQamyuNJQ3PEbStrQNd1XgeM3ltMLw==
X-Received: by 2002:a05:620a:1a0c:b0:8b1:d2f7:9586 with SMTP id
 af79cd13be357-8c08fd041c2mr2235934785a.64.1766500206032; 
 Tue, 23 Dec 2025 06:30:06 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:05 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 Pawel Zmarzly <pzmarzly0@gmail.com>
Subject: [PULL 03/31] scripts/analyze-migration: Rename RAM_SAVE_FLAG_COMPRESS
 to RAM_SAVE_FLAG_ZERO
Date: Tue, 23 Dec 2025 09:29:31 -0500
Message-ID: <20251223142959.1460293-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pawel Zmarzly <pzmarzly0@gmail.com>

It has been renamed on the C side a few years ago. In modern QEMU versions,
fill_byte must be zero. Updating the Python script to make grepping and
understanding the code easier.

Signed-off-by: Pawel Zmarzly <pzmarzly0@gmail.com>
Link: https://lore.kernel.org/r/20251125173007.245607-1-pzmarzly0@gmail.com
[peterx: fix over-long line]
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 scripts/analyze-migration.py | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/scripts/analyze-migration.py b/scripts/analyze-migration.py
index 67631ac43e..a12ea9fc8f 100755
--- a/scripts/analyze-migration.py
+++ b/scripts/analyze-migration.py
@@ -107,7 +107,7 @@ def close(self):
         self.file.close()
 
 class RamSection(object):
-    RAM_SAVE_FLAG_COMPRESS = 0x02
+    RAM_SAVE_FLAG_ZERO     = 0x02
     RAM_SAVE_FLAG_MEM_SIZE = 0x04
     RAM_SAVE_FLAG_PAGE     = 0x08
     RAM_SAVE_FLAG_EOS      = 0x10
@@ -172,19 +172,16 @@ def read(self):
                         mr_addr = self.file.read64()
                 flags &= ~self.RAM_SAVE_FLAG_MEM_SIZE
 
-            if flags & self.RAM_SAVE_FLAG_COMPRESS:
+            if flags & self.RAM_SAVE_FLAG_ZERO:
                 if flags & self.RAM_SAVE_FLAG_CONTINUE:
                     flags &= ~self.RAM_SAVE_FLAG_CONTINUE
                 else:
                     self.name = self.file.readstr()
-                fill_char = self.file.read8()
-                # The page in question is filled with fill_char now
-                if self.write_memory and fill_char != 0:
-                    self.files[self.name].seek(addr, os.SEEK_SET)
-                    self.files[self.name].write(chr(fill_char) * self.TARGET_PAGE_SIZE)
+                _fill_char = self.file.read8()
                 if self.dump_memory:
-                    self.memory['%s (0x%016x)' % (self.name, addr)] = 'Filled with 0x%02x' % fill_char
-                flags &= ~self.RAM_SAVE_FLAG_COMPRESS
+                    self.memory['%s (0x%016x)' %
+                                (self.name, addr)] = 'Filled with 0x00'
+                flags &= ~self.RAM_SAVE_FLAG_ZERO
             elif flags & self.RAM_SAVE_FLAG_PAGE:
                 if flags & self.RAM_SAVE_FLAG_CONTINUE:
                     flags &= ~self.RAM_SAVE_FLAG_CONTINUE
-- 
2.50.1


