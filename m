Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54A12C19F32
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:33:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnenZ-0005xW-5L; Thu, 27 Feb 2025 09:23:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemc-0003q8-VY
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnemX-00044y-9u
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:22:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666151;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OAGa/1zAiQKppBasu/YtxlNDeSsZyMqPAmmwgiPHU8k=;
 b=h3c/d85VvNOczNK81g1iY3ceQjCwzfY1L0e9S2H+HaU5oOV54dosazBvp0QvZTmYvm/Ao6
 kslBqmbP+8+UJ21a1Vv66HiUcjm+BqrN1/pN/3Wu+0PFU3JSrdn2ZrkymDunmJpBAUOwzz
 HhLDZwprip75BcXlSphyj1l6Cs7V6Io=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-252-Ey703yRpNyOlFO-nX5OZJA-1; Thu, 27 Feb 2025 09:22:30 -0500
X-MC-Unique: Ey703yRpNyOlFO-nX5OZJA-1
X-Mimecast-MFC-AGG-ID: Ey703yRpNyOlFO-nX5OZJA_1740666149
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-abb7e837a7aso112964866b.3
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:22:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666148; x=1741270948;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OAGa/1zAiQKppBasu/YtxlNDeSsZyMqPAmmwgiPHU8k=;
 b=UiHKzC+iBFhKE7DP+v+svtInU1xKNurDrP+JJN1722e2cTcOQisXmJgfPfApxldcPU
 I1gcLdRck/1lQU97Rar0uFpUbM7GIBrf2YcCQ6CwiJLzHHkR7gHnr6WTRX78SI2L4k2E
 rQ3lw0x7lXICDHBw1752tWPxmayVFIhtE/BXHZv8tOEHLLAnGkssiX9/BtgCZR4YZufm
 XwcsMWpQGtv5qQMNM7bgnPwDuzsHfQF8XZPbpLXPxi8b0+gC3KHB+pUU0YvrsA+n8YUp
 JfuTwbAKtsYOMeIjeFPSpTrEyQQSsoEda752JcTmk1FdLxunTl838cJJEe2VQmOTRY5J
 8g+Q==
X-Gm-Message-State: AOJu0YwX+14B/eLfz5aFf5i2OydknkLqURd8XCGAzvcCsHGRK4jZe/+2
 TfHNlTXczAm3Fitn2v5hO3l6/Cii8m0U7SZPDn0q802G1yMgJx0M+70G8YIKVXslLF08+nsRUYo
 ExHpqkzaHD6DlxKbTyEPXiBjVYlZQQh4VVDZIMRViH5CsfBE3YbdoS7q1qmUXwBTZn79cXLx4i+
 FMcDVBpGuYqjj8kdhmSPcAWYaHOFRh5PyrUS3H4bw=
X-Gm-Gg: ASbGncurjxlTM+c79haZgXiawBt8V28EWT75UMnuuq8TpBOM+u6JJKy1rYhUAuL9yEt
 kudCQ2iDLrQlu8XH8Ini9MU4eibAvZ8xyDmDRxxzAv3LPxG3FbkplRZedT9WAi7CAO4pq1YJoX5
 9IniasC86K9+Grw+GHyKF0Pco/uQa5GuEQRkZ6ECekB1wBSV8xFBT3m4J1CfxKatQn/f0HRGMOz
 lgJ1gH3wWhP7Xv76+EOc5elkBixKsx11XMaXVeMnYQ776jDaSn2Kq1PN4fTFKQzvOhbSHy0Q+AJ
 Phx+UOckrlB5KrKXiMHc
X-Received: by 2002:a17:907:c0f:b0:ab6:d47a:9b20 with SMTP id
 a640c23a62f3a-abc09a8a15cmr3264750966b.31.1740666148365; 
 Thu, 27 Feb 2025 06:22:28 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE4daWnQQOCN1bWh3SugyKqQgpaK2V8VPcdTd6AzyLvPLm6JBm1RPxBjICn07Gp4GTaMSKIQg==
X-Received: by 2002:a17:907:c0f:b0:ab6:d47a:9b20 with SMTP id
 a640c23a62f3a-abc09a8a15cmr3264746266b.31.1740666147824; 
 Thu, 27 Feb 2025 06:22:27 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf0c75bffcsm130517966b.143.2025.02.27.06.22.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:22:25 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org,
	zhao1.liu@intel.com
Subject: [PATCH 03/12] rust: vmstate: add std::pin::Pin as transparent wrapper
Date: Thu, 27 Feb 2025 15:22:10 +0100
Message-ID: <20250227142219.812270-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227142219.812270-1-pbonzini@redhat.com>
References: <20250227142219.812270-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.438,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/qemu-api/src/vmstate.rs | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/qemu-api/src/vmstate.rs b/rust/qemu-api/src/vmstate.rs
index 24a4dc81e7f..1e7ba531e2a 100644
--- a/rust/qemu-api/src/vmstate.rs
+++ b/rust/qemu-api/src/vmstate.rs
@@ -330,6 +330,7 @@ unsafe impl<$base> VMState for $type where $base: VMState $($where)* {
 
 impl_vmstate_transparent!(std::cell::Cell<T> where T: VMState);
 impl_vmstate_transparent!(std::cell::UnsafeCell<T> where T: VMState);
+impl_vmstate_transparent!(std::pin::Pin<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlCell<T> where T: VMState);
 impl_vmstate_transparent!(crate::cell::BqlRefCell<T> where T: VMState);
 
-- 
2.48.1


