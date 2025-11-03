Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EF25CCFA03
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:15:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1mD-0001A8-8I; Mon, 03 Nov 2025 16:07:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1mA-000192-CN
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:42 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lj-0005R4-3E
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:07:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762204031;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=oY2id3rFEVPzvrffR4IZg61aFvVc7inxMPEhQ7ItsAI=;
 b=La1oGigJN2PddBZ4zHXofpLGks44Z7+f09jE2uS/yvcYrk2TrtLHFnYbzTHUTOJuqWj7kl
 Y363us1rYBpZ8lYDafVw2MUj3U3yDFgW4bOkvQoPcsRTcdhGKapHde4V4HzsasitRJ/ukw
 sYUEvx5McNB5JoXBRwMf0GSObawszZ4=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-695-aSUJGqDoPeKFvV-TIQ3UpQ-1; Mon, 03 Nov 2025 16:07:10 -0500
X-MC-Unique: aSUJGqDoPeKFvV-TIQ3UpQ-1
X-Mimecast-MFC-AGG-ID: aSUJGqDoPeKFvV-TIQ3UpQ_1762204030
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8908a248048so1185751085a.0
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:07:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762204030; x=1762808830; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=oY2id3rFEVPzvrffR4IZg61aFvVc7inxMPEhQ7ItsAI=;
 b=kCWPnqNK+y12OZK5IT8xlL1sGHpDxYfbDfHjcYCYTB+MY2rfMh9mD87lcGiTyCDyeM
 5SI3x/blIwwDBtukIMa1p2FmIl3jrrQ+kzshgx41kCPX2Kj2SNqdvJv47JtfHkJLd15z
 wEIvc8oXhCCqgr2K+1i4GZ1lTokSozaenIigEM7INuNAbm95WX5CpHqscagM5aKI3885
 j/yqctI8oxBweppHNsmDBf05vPor7K+/CjufYKHg+I9PdDdgvZDB/8az8Bb+rhcHSRhj
 6F7D4/wqYEWCGIfWSBska+oTvfGQ5+9LUB6uqi6DxQSbArK2jB9H3yJUkFQxbXTOzLYm
 3WlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762204030; x=1762808830;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=oY2id3rFEVPzvrffR4IZg61aFvVc7inxMPEhQ7ItsAI=;
 b=pTa34B7/NoDjxqNYnHi5wq3ZduvcZxH0mYUGNN4tXld9FQ1/41Pp1jhd0YSWQyPscV
 gLB7u1sW5kXIvE0J+j/olpZ9cgK2vr4iE3bdEU+FZd7ObTBSVocQ/tdXvKJdqjjp0vgt
 R3CqE7hcsNpaqKBzEq99kYAT+bN/ai6HQT8MGLn7SAFZKt4WkzkNxqB1Q/NGdNhumFE6
 5cmhILY8kGPTZBBG0uLAJD2vLRrb8OTovXki3zCP7RZPslBnUAmt9Ns71zsDM6zaEXkb
 2lr3KsR4EWdBMcE8wY6qEil5lJCH89YJyE5faTT0pwrIEqwaa/VZYZc0LYfWUOfvg63B
 OQVA==
X-Gm-Message-State: AOJu0Yxy4aHZvVwppsvQS7q9m8AzZtrgYrjVexU4l/JZTT1Jo8Zef3Nw
 GzAnvnsDDLXjQWkDmugqnYG/y2xAzP3UMQNFk/pZzKUjWp+XExPU2aedJTt7dyDT7Gn1EoDvB9f
 6+Oshxqnf17LDFV4V+bxwrm618AP51oOw91xoM8gHhGtVXLmqLS962O/YakUeM1L1pFdpueHIsd
 IlVlGud0Rfy4AgEOz2hLD4JUdfMfBLPp0239TxAA==
X-Gm-Gg: ASbGncvuNkwWSFloIy08EHUBBN1hDleQsRbAs4jCOTLaVddIUpizv7LPRwGx11We52h
 OLarLZLre3lrYeNS/zME+xWwlQoWkB6hZjqWbEoAq1VUgi7HBoXjHU5Z3Wh4FFR+REOSk9q52Vk
 LuUwDJ2lymBqi2yrGjHl8pBmWnyUQy9ZURx0hv//4vUfVwf+yLeCJjcA3CfZTnou2rg/TFb/3kh
 qqjD7LJEzN0EnYde8A+6bipPe+EKREAWY4DVIe7HAYF4Yi5vJDBShEIyp9lB7IJZ36Bx/Au4IyD
 UnQbfsXC3f4LJw/pjyYyUudysncXASkAtGqwTy4kkICVScsOxcVWbPxWLdB5PFjA
X-Received: by 2002:a05:620a:1924:b0:883:b565:1acf with SMTP id
 af79cd13be357-8ab9b3ac76dmr1775846885a.60.1762204029359; 
 Mon, 03 Nov 2025 13:07:09 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGRZ6OjdfDD+TQ8XTjqLTg1SjK2wE8DkJdCLLkZQhP+lsEQY77zvMcplyzZzomB++2xOf9cog==
X-Received: by 2002:a05:620a:1924:b0:883:b565:1acf with SMTP id
 af79cd13be357-8ab9b3ac76dmr1775840985a.60.1762204028752; 
 Mon, 03 Nov 2025 13:07:08 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.07.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:07:08 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 29/36] migration: Flush migration channel after sending data of
 CMD_PACKAGED
Date: Mon,  3 Nov 2025 16:06:18 -0500
Message-ID: <20251103210625.3689448-30-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Juraj Marcin <jmarcin@redhat.com>

If the length of the data sent after CMD_PACKAGED is just right, and
there is not much data to send afterward, it is possible part of the
CMD_PACKAGED payload will get left behind in the sending buffer. This
causes the destination side to hang while it tries to load the whole
package and initiate postcopy.

Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20251103183301.3840862-2-jmarcin@redhat.com
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/savevm.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/migration/savevm.c b/migration/savevm.c
index 232cae090b..fa017378db 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1142,6 +1142,7 @@ int qemu_savevm_send_packaged(QEMUFile *f, const uint8_t *buf, size_t len)
     qemu_savevm_command_send(f, MIG_CMD_PACKAGED, 4, (uint8_t *)&tmp);
 
     qemu_put_buffer(f, buf, len);
+    qemu_fflush(f);
 
     return 0;
 }
-- 
2.50.1


