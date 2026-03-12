Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B09CA105A583
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drP-00042F-Vd; Thu, 12 Mar 2026 07:05:48 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0drC-0003sG-EB
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0drA-0001NS-OP
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313531;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mNrlEVYF9uLdFdv7+S0z8E5kpmwdqX5udlX9IbVtleY=;
 b=O0qc7UGf3ZD4FO0jUSGq1YoZvsldCpDKUKclwfMvYlhfHRX0IYe2ZzIv+7kAJ7GPcJkQ4M
 Ml9CGcVQU81sUhMKhVPYAeksc2I3IdpmIRSG1I8gWmxkEItSCjDPUAA9Nnb9nrQHGqGoFT
 WzkQM81ufBNg6V8err4UQKogw/qARN0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-161-ywXRHx98NZOWXIDCLHwi0Q-1; Thu, 12 Mar 2026 07:05:29 -0400
X-MC-Unique: ywXRHx98NZOWXIDCLHwi0Q-1
X-Mimecast-MFC-AGG-ID: ywXRHx98NZOWXIDCLHwi0Q_1773313529
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4853ac455b2so8695345e9.1
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313528; x=1773918328; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=mNrlEVYF9uLdFdv7+S0z8E5kpmwdqX5udlX9IbVtleY=;
 b=XxifE3kH4m5fHI22MoxJUjU8uUfCVQGeu3POx9b7APy43m8tvt8T/vgDBaVI7ha1Ec
 /dp4y36E3IhlAN8YlwpGxwb3ioGGKUBfAvlVbBq1Wf/X/qLT+hPy1qGED6CtoRDDTw+r
 eXQoBq/egUvPnXjP8FwWyDjdPrJZEXcZEqfHwySKW4BPh1TT158teaUeW/BZwrwXPyIN
 co4PoPUse0QibCPPGaqrnVA4Cvruq+izXisNHnw0HRwLMsHEh5sUsRDF7hKM6gCxieXu
 9kVNCh9Wh53oFViUGbplm6GIdbciTv6dQr3fulpJSS/oHQS7Uq6HbFEybExR+3ljd9BJ
 RSWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313528; x=1773918328;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=mNrlEVYF9uLdFdv7+S0z8E5kpmwdqX5udlX9IbVtleY=;
 b=lZ1xb8B6zUbCAiOcY4AcQjAPMu05m9xJIIQOS577eB4C0WDwvwZObqgIHiA4fhbp3q
 2U7z8QneWCPnmiktp4tdhUxk4R1iJGWPWiTpipfAMPOKQ7Bn7q8YnBx2UbY1FqhBvDeP
 Kj3GBN94eYbiKSNybhZ2Tkknl50qKmKZshUQVwW9BtjpiWfqmwXKuk7OmWw38Uj7EZ+3
 XvNIPnml3ruuOR9tfr7ohpYTZHpUl6sAH9Ab3gFy12+ML4ThBjlU9CluVDXkJVeRRP9Q
 Pu//5/ANOC7zka2MOsJ1bfqdfJN8oeEl29IpMBJDBOJtYc+MAZVYHxRvlnQhCsJnCRQk
 36Mg==
X-Gm-Message-State: AOJu0YwDPC01OZUmWBKbDaTjsvSqBxT2laQo+psHLDWLZ7LQxZL2gQNG
 OBgn8RQoEaIxqPh0JkUtr1QfWNKPFvCQnAYv+D1MfFjU70R1vZGTDN99nTrMxBU3swgNSwz8BAo
 HL8EcICRZhFmhJDIvarXHcJxmf9DKINOw7oeyjBkBHJUqwZ/0qyiyqsJpEmvBNZr0AIbf8hv3bZ
 6ORYizGA508woBphCgRB3G62iILbr0ciy3J8gfXPRZ
X-Gm-Gg: ATEYQzwQoXkkAfUu3hroiwsKhsKva3ELrcJ3xjpymIBEHIF4UMzBdJ7dRTi2w4kx2uh
 0eOzGGN24HLGyZY+TNbEpMoJgDqnDnSfyj5F09FkkmUiy63G0AY4wndTB1/FOVtXqBlKRAhTHZY
 +4BjVWzGKGvegMqIRAR43vIIFAaZU+oSQzaTuuaRrcECo4vg9hxbFMbSvn5ZStM3bZQwsOvRyzC
 AuBAkPPAd8elIs0s8Jo1yhnhUI+lGHvNAn7pI8eAaJqgAZ8FMCfrfaEQ0TzVARbKKCLO05DylAi
 F2dPSI6Eup0R0o6czr9iq5e1FK9Y4pz34YIl69JsaADULK8moXUBmtBUtbGbpNQtInlWtU30AwP
 OlYEMX/ItN3hlHnFmz2RLH3lybl83FOhLQ9xYM2RXS+p3TLKv5ppWereFzzjMd4wMB7BxdM4w+M
 R1EUZoK1YFsNyEcgPNuave2Gs7EXI=
X-Received: by 2002:a05:600c:1f96:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-4854b0c737fmr97984295e9.10.1773313527960; 
 Thu, 12 Mar 2026 04:05:27 -0700 (PDT)
X-Received: by 2002:a05:600c:1f96:b0:485:35d3:ce59 with SMTP id
 5b1f17b1804b1-4854b0c737fmr97983835e9.10.1773313527466; 
 Thu, 12 Mar 2026 04:05:27 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4854a18de05sm44718275e9.0.2026.03.12.04.05.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 13/14] rust: Update Cargo.lock
Date: Thu, 12 Mar 2026 12:04:45 +0100
Message-ID: <20260312110451.685161-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Philippe Mathieu-Daudé <philmd@linaro.org>

Update Cargo.lock on top of commit  7ecd3f71079 ("Merge tag
'for-upstream' of https://gitlab.com/bonzini/qemu into staging").

Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20260309172440.66409-1-philmd@linaro.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index 801ac5f4f51..cbb3ca15f77 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -172,7 +172,6 @@ dependencies = [
  "migration",
  "qemu_macros",
  "qom",
- "system",
  "util",
 ]
 
@@ -351,7 +350,6 @@ source = "registry+https://github.com/rust-lang/crates.io-index"
 checksum = "0dca6411025b24b60bfa7ec1fe1f8e710ac09782dca409ee8237ba74b51295fd"
 dependencies = [
  "serde_core",
- "serde_derive",
 ]
 
 [[package]]
@@ -407,6 +405,7 @@ dependencies = [
  "bql",
  "common",
  "glib-sys",
+ "hwcore",
  "migration",
  "qom",
  "system-sys",
-- 
2.53.0


