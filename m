Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42A96C02181
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Jan 2025 09:52:52 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tbGID-0005Pm-3A; Fri, 24 Jan 2025 04:48:01 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFu-0007By-M7
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tbGFt-0003vD-1S
 for qemu-devel@nongnu.org; Fri, 24 Jan 2025 04:45:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1737711935;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yvbr/euLYmsi01MyC/bxJYSQaCK8iNl78JJ9FTSlmig=;
 b=aztr62+fVqIDyAjMGheHp5SRgo9ts1zNSXmKqjv5qezd+KfJvqJv2JmEk0SbX4NXTbSJjk
 Jt6lzIvDlmzuyzSzrnCvm59hO5/xKuXEGfMZmVIZW0gLL9VgmjPEdnmzCFpYaVP9CGC4Kg
 RLNfmIoDCshPlPCRa7COMyqs6UiYTK8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-110-kaD5ZBWrMeGlUNqvchK06g-1; Fri, 24 Jan 2025 04:45:33 -0500
X-MC-Unique: kaD5ZBWrMeGlUNqvchK06g-1
X-Mimecast-MFC-AGG-ID: kaD5ZBWrMeGlUNqvchK06g
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-43673af80a6so13352135e9.1
 for <qemu-devel@nongnu.org>; Fri, 24 Jan 2025 01:45:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1737711931; x=1738316731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yvbr/euLYmsi01MyC/bxJYSQaCK8iNl78JJ9FTSlmig=;
 b=xJ5RymGhpLOW8c8t1uNiOk3j8BgkXo3VBBE2oPfrWhltBcr+Lwj6KgqP5WE1lyd79w
 w1yG4PVcXY4Fuwab90Ih/is1GYAUtH8ReHVvJgEXl3W5qWuQux6cHPcIcEyv6J+jmoo/
 XhEQVO24DQ76AOYHb8/nT5BApIQudLcKBFjCtiX3FxjWj9759YyVwRZDIU0X0dfD/Ziv
 /fi07Mn1f2XVTTGOzZRegSIFQ0sUReVQcVraW9cj7LwZlYz0QVUseYaO8TM8ANTzMwAC
 WNFvbUvP3Agr31hkyHKf/wKm7eLzlMO9xXK2TsnlbBGlAEaR1BvbvuuNbKI/EmY4N//t
 ifmA==
X-Gm-Message-State: AOJu0YyfSbfgspM6qI1hHNSTdObRDQLE7PP7UTQctvsx6atYj6ZeCWtR
 lYPsEAgUp/6bDGjs0B5YCWqjh4ipmXgt3qeqzdgKc2wvJBV5lsO3YaQ7MXVrhhhClMCiFbsuqBb
 MLQnAJG86MUdOee+FrYZwMcKw6UnpTQpSbqTWZmruci8y/n909nzgPgVtmG3c0zvGJXBZrC8roL
 nmgcS7718s+BCSYXiGrXPNcKqWWBz+AUSspufxIHs=
X-Gm-Gg: ASbGnctpgQtJQvTpeTdlPzDQO9rcT7ZM1YWGNELRX4viHRI5+GFBH74xI5Ku4l9ElPe
 wmyMJyebGKgXe4fOZE99O1kp6wujV6oKtEAFzP+VFW5tZsr6DyMc5uz9aUwPkGjoCzZDNtFvf25
 LYxeLqGn3Rp0ivJmnh31YT3FaF/vMfJRpFf75wyIExEH4QAhl1oOL4o3yERPwS8Gla3H9UYSAr+
 +njimnAoshJhNa4+3aERPMXQFqEEejKOU1/PE0mnwcWEFRGFl4iYiHMJUROjDifTwgYvdPT/A==
X-Received: by 2002:a05:600c:511b:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-438914304a8mr213647055e9.25.1737711931674; 
 Fri, 24 Jan 2025 01:45:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFKkR6w5XYAxB63/i7et5JL3JLz14imn+MOMh1OUbq69Am4fQn2rUta9B+G2TNyg4bTxmuKrw==
X-Received: by 2002:a05:600c:511b:b0:435:14d:f61a with SMTP id
 5b1f17b1804b1-438914304a8mr213646855e9.25.1737711931269; 
 Fri, 24 Jan 2025 01:45:31 -0800 (PST)
Received: from [192.168.10.48] ([151.95.59.125])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-438bd48a906sm20805735e9.18.2025.01.24.01.45.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Jan 2025 01:45:30 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 24/48] memattrs: Check the size of MemTxAttrs
Date: Fri, 24 Jan 2025 10:44:18 +0100
Message-ID: <20250124094442.13207-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250124094442.13207-1-pbonzini@redhat.com>
References: <20250124094442.13207-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.043,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

From: Zhao Liu <zhao1.liu@intel.com>

Make sure MemTxAttrs is packed into 8 bytes and does not exceed 8 bytes.

Suggested-by: Philippe Mathieu-DaudÃ <philmd@linaro.org>
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250121151322.171832-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/exec/memattrs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/exec/memattrs.h b/include/exec/memattrs.h
index 4fde4eee843..060b7e71314 100644
--- a/include/exec/memattrs.h
+++ b/include/exec/memattrs.h
@@ -64,6 +64,8 @@ typedef struct MemTxAttrs {
     uint16_t _reserved2;
 } MemTxAttrs;
 
+QEMU_BUILD_BUG_ON(sizeof(MemTxAttrs) > 8);
+
 /* Bus masters which don't specify any attributes will get this,
  * which has all attribute bits clear except the topmost one
  * (so that we can distinguish "all attributes deliberately clear"
-- 
2.48.1


