Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52CC6C0219D
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Feb 2025 10:24:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1thQwd-0002N1-0C; Mon, 10 Feb 2025 05:23:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwb-0002ML-9d
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1thQwZ-0000Lj-Sw
 for qemu-devel@nongnu.org; Mon, 10 Feb 2025 05:23:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1739182990;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=PTpZU6C+PVHvakVak4NM4kkJCm6RFTzLKXCDFFbmoAQ=;
 b=FZ2STHFh26ZTEvQ4t3CjDxWXVHgC6fjrEAfSANqmSYW6LI9OhmcOqRBI5mzFeZUvCLg8gS
 IBbKWueb6DgMrMe95nin7YskDkGDqsmCDyk8TYKR3W2PVCYlf/ilKSgY6ExhfU23nkn0sr
 NpF/Z42uzgYz15Pyv5PuLrHJ6fJMx4s=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-501-1PvkXmhaNvaD3FjZmaH_Kg-1; Mon, 10 Feb 2025 05:23:06 -0500
X-MC-Unique: 1PvkXmhaNvaD3FjZmaH_Kg-1
X-Mimecast-MFC-AGG-ID: 1PvkXmhaNvaD3FjZmaH_Kg
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ab7912ce928so273491866b.0
 for <qemu-devel@nongnu.org>; Mon, 10 Feb 2025 02:23:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1739182985; x=1739787785;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=PTpZU6C+PVHvakVak4NM4kkJCm6RFTzLKXCDFFbmoAQ=;
 b=D2ab47iTpFkR4zYg5rzcHCDQHz1tDLe8QHVqkuUxhGSG7MbqkyO2SR0OcXPT2CsT3u
 yXII7RLMpkD6gW5sXjYsLfKpqaJwVmfY8nEx/0zAd+g2y293loQ23v0GXLtcom6yCA4z
 drQK6jcf08n7cebovZNVPG2pUT4BWZuArGsvQC7ScjdFUnRHRhL/emD42pUB0ifq/Sho
 U95r3sHkDNfBSiYyyqW6wovYD77gj1tS971KQIDjqHwysE4EFxo1VLEhbRgzPoloyFxP
 AtUT8HRBb4cofVpaYlNfrZ3ji1t58K4pDNqz5cA0rF4RdG45H6SvZhWZq6bsNlP8S4aE
 +DCQ==
X-Gm-Message-State: AOJu0YwL8oz56ZB/kJjXwRKaKnBN0fOcOARpD+aILepoFBLzvop2ce2y
 ANx+q/G7DdHwJCJAx1CnL2AGW4Fl22GOQf/ebUvVA+6ExQoIL/mQWFKiMXauPEza0MQ9GAybN4h
 fs+I7oMRRIlxexgoT/W1P6CM7VH1z2H0p1VpgdBZbJqua2Bp1aWAhZzzLLjDX5ExuPGipUE32Jg
 xCEYNYnUzZxGeB6PRY4OgQZHN0Ic7iZjZu/p31V8I=
X-Gm-Gg: ASbGncucLdMy9opsUnHBhYIpCyBI/XarjnU6wt0kXMB0razo21doq1D3QCwKNRtvBKh
 lGPzmGpzMmPnt28bW1/nxp9vo7yqrLKRetsm9AiXIhHRmsAFdKblfWxcopvpMJ+NhFfkHckmcnD
 YmbnONKLVaEPWRlege3LaLKmKwdgX3qimVJDiVgXnis27sF6Vd5b8YNsbffkwWUjo5y72IwQ/Ns
 GVNwpGKFKACYNgmwEFY1Lo9uuidVuSUWyIDx/9PTaGN8eRvPO+gLlReS2OyYoPpK2d/0JiL9GAP
 AWkbAQ==
X-Received: by 2002:a17:907:7fa3:b0:ab6:e04e:b29 with SMTP id
 a640c23a62f3a-ab76e84c376mr1551797766b.3.1739182984721; 
 Mon, 10 Feb 2025 02:23:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHf6fTBTf6Jag48tCbTAC1nJ/43O5xpujFkxLU5rYXDzbxpasSy6o54cM70TDxhlnwCLvhzcA==
X-Received: by 2002:a17:907:7fa3:b0:ab6:e04e:b29 with SMTP id
 a640c23a62f3a-ab76e84c376mr1551795766b.3.1739182984259; 
 Mon, 10 Feb 2025 02:23:04 -0800 (PST)
Received: from [192.168.10.3] ([151.62.97.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab784d4aadbsm733939566b.113.2025.02.10.02.23.03
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Feb 2025 02:23:03 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 4/9] rust: add clippy configuration file
Date: Mon, 10 Feb 2025 11:22:49 +0100
Message-ID: <20250210102255.2555097-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250210102255.2555097-1-pbonzini@redhat.com>
References: <20250210102255.2555097-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -44
X-Spam_score: -4.5
X-Spam_bar: ----
X-Spam_report: (-4.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-1.405,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
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

Configure the minimum supported Rust version (though strictly speaking
that's redundant with Cargo.toml), and the list of CamelCase identifiers
that are not Rust types.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/clippy.toml | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 rust/clippy.toml

diff --git a/rust/clippy.toml b/rust/clippy.toml
new file mode 100644
index 00000000000..5d190f91dec
--- /dev/null
+++ b/rust/clippy.toml
@@ -0,0 +1,2 @@
+doc-valid-idents = ["PrimeCell", ".."]
+msrv = "1.63.0"
-- 
2.48.1


