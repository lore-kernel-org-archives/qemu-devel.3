Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 834D3CEACEF
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Nov 2025 16:32:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vL28U-0007Ir-Gi; Mon, 17 Nov 2025 11:31:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28Q-0007Er-Qu
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vL28P-0007h6-8M
 for qemu-devel@nongnu.org; Mon, 17 Nov 2025 11:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763397080;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q10xK85V9eTQ7DlgmxFXQKaQw89HU4P1/5M6DW8MO80=;
 b=djBwve7CUChijtL6E3E5Y3jqxG87rF6/tm/t8HSJzA/v8x5xd5P+YJCyPvIbNlLXBemrmT
 GAVLz3F82IIsKRtWMZe/9Ii5IqFzg40smFr4TCZoCMhuZG5snhH8pTmZijjL57d73RYK/N
 YrM8mMNlETgBLhDub+fIzcFmFHt/o9E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-swEOyHvwNvqe04gxMqzmTw-1; Mon, 17 Nov 2025 11:31:18 -0500
X-MC-Unique: swEOyHvwNvqe04gxMqzmTw-1
X-Mimecast-MFC-AGG-ID: swEOyHvwNvqe04gxMqzmTw_1763397077
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477a11d9e67so10849975e9.2
 for <qemu-devel@nongnu.org>; Mon, 17 Nov 2025 08:31:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763397076; x=1764001876; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=q10xK85V9eTQ7DlgmxFXQKaQw89HU4P1/5M6DW8MO80=;
 b=geUcogDZHUKWkacJmYl/A68zbvgMHtaSEp4NUIAbnZtTsnWv4Xxfgd/vO5DuXJgZn7
 iGdoqaARTtqHrOXSDmd6Y3vdrUYTWaZreVxNZmsDSE77tPgktHUZvwIo/KlFAE4F7Ivv
 tM+L9uSVHWrzPp4mrSUFMViYzlMOCjUjKtW3Uz07VjegSgM8jYJYnWA9VKIWREuTqVA+
 xWsREDJ9hR4fO5TQuPNOHisCso642exPtSP/bivle6sgh4QL/TzBwXHkEbCBzhe21Zru
 70czJhr3nSiOHIt4SWo7T4nHVYDAhYbZOzmr4T4DWULh+DAeEA/Etaay039nQo73XX2c
 j0xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763397076; x=1764001876;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=q10xK85V9eTQ7DlgmxFXQKaQw89HU4P1/5M6DW8MO80=;
 b=qFcdR4JrIFuXUaiU91ZmNePvIqUF8+Fe3kOOHBLQdferamh6ewEiJ/z/Eav7wxK3qh
 gX+BFzHiHMDpdVhD1BHgeECG4ljrb4q99CT+ghKPoxD9EOzedOeY+8L0c/sCfpysGS5j
 C9Spq/nmN3pv3C28I6dqKwdbQ0ynm1XNdasTvT4v7k5+nfT6Un2Ix/CnRfoMQtxPCKyk
 u3vM4Inld7msBdX5dJyucw0332plBDIZMaUTjNikgmaqnolAJ0jg2dbxcU4ckGQogtLm
 xE2Ba3et1OTaz/wbhcwkLG0C33pjBu/MuQSXKGLAcqQ13hTIkmPbI1McGGRKAST5JbeD
 IBNg==
X-Gm-Message-State: AOJu0YynLmn4q0ITWaV7yKMlmSGTH7mLFZnh4A4YifjS1zzBHy3Uz8kg
 IIx810Di7luhINqIiRCdHX3XJT7D0EaFxoYG3KpySUsk6pO7xzim9oBk+Ss+0yO7v4sAo6rnJYw
 btnMAok5emR+znZUORvd7c8lA+SAC3HwQqZu3tHAiMMwspScFv6d8l07tkuZ+/0Pxhxls6dQB+x
 TAQxO6n/6h2vTSQqT6QzI1voQvFOupXq87uHbOhVrQ
X-Gm-Gg: ASbGncs0KN31C0/IoxW5NAXEb08xfEy3XmnnZjXzHXhVdJAuQzIitbbSZS1dnK5c7EN
 uz6XrJ7A7cMHmflR914r/dNT57mx24dNhuLim4rxvcpXexJln1reyC6miy73ThDXeoG4ZUycvaF
 HENbyBGu93MvwTdK6W4aKq7rrLEqnsgGZrdXcKX0GF+ML54PeX7MFUYydOjjjxRII0qmkdNEmkF
 WmcyRIeDmhQnaExrMwEtJqHRkizmPvoH04ufpdaWsbWub07jlF7gmxx0bsDL2afWUsda349/aFB
 kKpkJyLjZY1HPf5oOCmRi4mA94lrziWCd5fyklkdPwx7zW73nWGRrIjhzvDVoFDbGAeFhelx0kC
 TaI9eZ8ikH8eoA3HeVph/CNGyxJILQHgW4XUnWQYzfWk1Vc4kSdPiDOFq6Z00R3rpTBRQY4mUvV
 YzvhWV
X-Received: by 2002:a05:600c:4995:b0:477:9671:3a42 with SMTP id
 5b1f17b1804b1-47796713b41mr56648895e9.35.1763397076592; 
 Mon, 17 Nov 2025 08:31:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE3HpuKHSyu3iQuP5dckY3VWg+ETMJqmu4PV6tG2+KdtfH0gE/+Mr5Er+be0J8wWi4TxJF7lw==
X-Received: by 2002:a05:600c:4995:b0:477:9671:3a42 with SMTP id
 5b1f17b1804b1-47796713b41mr56648655e9.35.1763397076129; 
 Mon, 17 Nov 2025 08:31:16 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47787e36ca3sm340067495e9.5.2025.11.17.08.31.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Nov 2025 08:31:13 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com
Subject: [PATCH 3/3] mtest2make: do not repeat the same speed over and over
Date: Mon, 17 Nov 2025 17:31:07 +0100
Message-ID: <20251117163107.372393-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251117163107.372393-1-pbonzini@redhat.com>
References: <20251117163107.372393-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
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

There are just three of them, avoid repeating them for as many
times as there are tests.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/mtest2make.py | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/scripts/mtest2make.py b/scripts/mtest2make.py
index d32eef2f7f4..2b706f94234 100644
--- a/scripts/mtest2make.py
+++ b/scripts/mtest2make.py
@@ -14,7 +14,7 @@
 class Suite(object):
     def __init__(self):
         self.deps = set()
-        self.speeds = ['quick']
+        self.speeds = {'quick'}
 
     def names(self, base):
         return [base if speed == 'quick' else f'{base}-{speed}' for speed in self.speeds]
@@ -62,10 +62,10 @@ def process_tests(test, targets, suites):
         suites[s].deps.update(deps)
         if s.endswith('-slow'):
             s = s[:-5]
-            suites[s].speeds.append('slow')
+            suites[s].speeds.add('slow')
         if s.endswith('-thorough'):
             s = s[:-9]
-            suites[s].speeds.append('thorough')
+            suites[s].speeds.add('thorough')
 
 def emit_prolog(suites, prefix):
     all_targets = ' '.join((f'{prefix}-{k}' for k in suites.keys()))
-- 
2.51.1


