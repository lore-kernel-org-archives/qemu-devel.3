Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D302CCF9F8
	for <qemu-devel@archiver.kernel.org>; Mon,  3 Nov 2025 21:14:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vG1lN-0000vL-MQ; Mon, 03 Nov 2025 16:06:53 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1lJ-0000uT-P0
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vG1l8-0005As-2M
 for qemu-devel@nongnu.org; Mon, 03 Nov 2025 16:06:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762203995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UWwOXYFZuCEMUZuqr0lusb7WtZ16ba8bYn8YGVwOYII=;
 b=DqrJcqwiapYfspwAogCFQOmQWiQ/VIldarWNtmpW9vkFdCKRuXAynk7Ju1XRc++MFRGdnV
 V3z3iF7SxbHcQLtdn7STQ8lcN/Swcn/S/QNh1STFwna+8Dby8EgXD4EgEfSjqlAglZMH8n
 fdMCoigF0Gza7Vcp2oSJGYS0KwrQneU=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-oMymz0LMMG2evwwpvfR8MQ-1; Mon, 03 Nov 2025 16:06:34 -0500
X-MC-Unique: oMymz0LMMG2evwwpvfR8MQ-1
X-Mimecast-MFC-AGG-ID: oMymz0LMMG2evwwpvfR8MQ_1762203993
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8a65ae81245so1487403885a.3
 for <qemu-devel@nongnu.org>; Mon, 03 Nov 2025 13:06:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762203993; x=1762808793; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UWwOXYFZuCEMUZuqr0lusb7WtZ16ba8bYn8YGVwOYII=;
 b=Ql951z1/t1uuRNNCNsHhRkmDu1OM8YIrk4f/NKNVCCrEEthS2VbHQ8bDho9o6lcoca
 9SwrKzfXg8kKMJYKHjHB44QTe+TxHknBxQ/tNVpo8t3a97aW8fqUtF209t/SaJbIC1RJ
 LkjuyqAI52UTM1Vxemlo2+YIP7AOsPmwyRGlqSUx2I91YgA7JYqJilblfonCP4wRN2hU
 UtzvoMbPvFIQ518g9soOmOJnLh0Oxx0ABOtgcnFx4FGQi6lyInBDOEkGQGaBJ0Ckp1dH
 aFV/cmCHS9wSs0Ha+wBZX4kKEmsnquICvw/iO+2NoLkHD+3EZu29CwnZXkLaKUrcLUU+
 /cvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762203993; x=1762808793;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UWwOXYFZuCEMUZuqr0lusb7WtZ16ba8bYn8YGVwOYII=;
 b=dwCcH1ykl7FRbdu0vEwMY64BTeOKB9pxmFBqNgQCTHumAYNhLLrAy0Kkh1LctuPyZ0
 ub6cn5T0WDrLJufuv3466rI1l/sibQ8nCjDiFYv5kcEW/bx6ViV+lVhoZVNmt3fp6waY
 3VgtQVCbu8an94p1g7rGVla07Gs4FiFwGRn0SR6nQ52Zny/wdd1L+wXlcNYKMFGLx0x5
 V0NLdgvkzYLlk5Pzm2fpNzIrHVPvOJVmR3CeR6duy4uN0vi5mYYhpnGTcUiyQ20lXRwg
 WVA5XIKVPSbODOsHjQQhBYlFWX+Bp9X4dOdSqyaM0YksfagBGhi49MSNLF1QAJHSgSQI
 bRqw==
X-Gm-Message-State: AOJu0YzeHA9ktOKcX/KCLw+NEceww4Shhdwe/s3+y+iZ3QmswhhTr/6R
 KTlZXl5eM+4LMASjWGimChx967gvVAEpHIQPHkC+M9anBQA4BkGP/NqQ6czEVjGNTfv/78xCzH3
 WveRwePT8tLR2SIuojVX6u1JGJw+0DT7VEIqw45f1vtCNZ0YUZLO8wrs+8x1XZVlHnx4j6JtMu5
 khW01hgWkHuCfypg1FcXY5csCQ2ZUv4ccTngvuog==
X-Gm-Gg: ASbGncsYjGSyMHkNDOQZml6Hrd74vGkMd+Si+ySPhiAWY5ia36VD+tCH5h1ZmEfKQJO
 I9xos+N4VvwoC/mlWS4vvsvlmLfo/dw7n3X77QqcJCMYHzo1wyMOc1Kzxd6Ymao9YdNbsGDeRRl
 eXUNkITIcwsJ4jMjF7sCSd/dZTxFVeTp613nosNgTWqsb8TW0SyV09ctOp7P6AytXW4xSr3DU/1
 Xrtc6nCOfbd9LHf4fQeWzOh2RX7OIYl7w5urTMLyaufhK90KLQSpRy7BaTz/NbxzaSM3OefryUz
 khIEfWK0ITMSbccvkz4CPHF0kNQpUpXRVPsY1c/fuZmf4DQXAzhud5fh5zgRbzoH
X-Received: by 2002:a05:620a:2953:b0:8a3:ee38:be9d with SMTP id
 af79cd13be357-8ab991a5816mr1494165985a.6.1762203992825; 
 Mon, 03 Nov 2025 13:06:32 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFgLk4q+yh9JDeWWOfKi/6pmwWvmlyXRLzpW+5mQTW2WcRAqnn9ffvXmwrbvyQWTVc3MHDBPQ==
X-Received: by 2002:a05:620a:2953:b0:8a3:ee38:be9d with SMTP id
 af79cd13be357-8ab991a5816mr1494160185a.6.1762203992283; 
 Mon, 03 Nov 2025 13:06:32 -0800 (PST)
Received: from x1.com ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b0f5468968sm57428185a.19.2025.11.03.13.06.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Nov 2025 13:06:31 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, David Hildenbrand <david@redhat.com>,
 peterx@redhat.com, Paolo Bonzini <pbonzini@redhat.com>,
 Marco Cavenati <Marco.Cavenati@eurecom.fr>,
 Juraj Marcin <jmarcin@redhat.com>
Subject: [PULL 03/36] migration/ram: fix docs of ram_handle_zero
Date: Mon,  3 Nov 2025 16:05:52 -0500
Message-ID: <20251103210625.3689448-4-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251103210625.3689448-1-peterx@redhat.com>
References: <20251103210625.3689448-1-peterx@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

From: Marco Cavenati <Marco.Cavenati@eurecom.fr>

Remove outdated 'ch' parameter from the function documentation.

Signed-off-by: Marco Cavenati <Marco.Cavenati@eurecom.fr>
Reviewed-by: Juraj Marcin <jmarcin@redhat.com>
Link: https://lore.kernel.org/r/20251001161823.2032399-3-Marco.Cavenati@eurecom.fr
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 migration/ram.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/migration/ram.c b/migration/ram.c
index 5eef2efc78..1384748193 100644
--- a/migration/ram.c
+++ b/migration/ram.c
@@ -3630,7 +3630,6 @@ static inline void *colo_cache_from_block_offset(RAMBlock *block,
  * determined to be zero, then zap it.
  *
  * @host: host address for the zero page
- * @ch: what the page is filled from.  We only support zero
  * @size: size of the zero page
  */
 void ram_handle_zero(void *host, uint64_t size)
-- 
2.50.1


