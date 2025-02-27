Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C3A76C282C1
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Feb 2025 14:20:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tnekH-0006pz-Fu; Thu, 27 Feb 2025 09:20:13 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekC-0006n6-6k
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tnekA-0003gD-81
 for qemu-devel@nongnu.org; Thu, 27 Feb 2025 09:20:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740666005;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LJB2c4bxzU4WmleXJ0VX4oOrax270tsJkQEdT3TL6CQ=;
 b=JPQ6IEo7b23SziV76iDSYLxHbr3sIKp4FMvoeI5aYXNT5+i7iMoc41o6hvSEcjCSlE6D6w
 EuSqRd25/v7KGmZeSyrdappTiRCj/cKJiXlts/W6zo/cM3pfMoG8nzQpdhUF7M883wpzWv
 SGWsexRgqGqLhxAprOMnTRgwJ39wZUQ=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-X_g0KlgzP4S43QBinx6ECA-1; Thu, 27 Feb 2025 09:20:03 -0500
X-MC-Unique: X_g0KlgzP4S43QBinx6ECA-1
X-Mimecast-MFC-AGG-ID: X_g0KlgzP4S43QBinx6ECA_1740666002
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-abba896add9so116633066b.1
 for <qemu-devel@nongnu.org>; Thu, 27 Feb 2025 06:20:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740666001; x=1741270801;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LJB2c4bxzU4WmleXJ0VX4oOrax270tsJkQEdT3TL6CQ=;
 b=t6/a1DcSzvc3t2rEZP7D+TWltUVmSNUC7HV1st8Z3s74w6MWyFQwBgyFjvriLKDXCo
 BeGd7L2s1aHWveXmNb1GIKxUv+ogJjqlDu0hFa0SKIZSbX6mjaV07+8eM/chVN3BbNQI
 yU5zlHOO36Z09XZ3Ovcuyqe6pjKfpAzRcfe4olfXfw6gVFeidP9ke3wOrsPej9WANGFQ
 kXcLOvlR2GNNRGZpkxlna6oPmeH9RSq59dyMWVi3D8fFAFcr7Fu4haruw1VARVdQMkLz
 Ihbio+1Ndgu7OknwyeRHhpVGtl4esxKHnjPIy4ItvvITL5Vjnpmt2aal0NYsppuLrE2Z
 cHwg==
X-Gm-Message-State: AOJu0YxyXHV5YF0YpNFUF/+pqD150CmRWxp04kiVUJrBoh8LVJj1u+Yj
 Np0gwW8czTOKwp7ThYgFcqGMf3ol0jN8OGdqFMzN6kcmAAeETHoY3wE8T1Vas5sW7KNY8HFm5Fb
 ZUdxC3dMVHI27zLnUS02W2/ngAoX7snd5TX5MM8utbtyHnqxjVK54qvj6I1Vpcz2ufulNy2Z1tx
 XUiQebCA2HP8/jcjHbEO08tFoWKg5dD+/07C8qZao=
X-Gm-Gg: ASbGncsC/qPwRsVtC2iWvku0QfN4NocJM+s0598wRk01dh2QRE5svEHUMW2Ssr77QPo
 zxtbPYosQj/nYEBeInvHQYMwGJE02SqBcAaC4t1V9m5Bk+i30lUM6ArnjnqX+1VhbpvU4niRz1R
 Bx97Y1d5yKtfkcAUb7u7kb+gT1SWAA5ypKAiq8edKFakKRzVsENeBgOuGwdCga6Pzwx6d9Ddum6
 erqHKoesRc65APqpNpohkVR5Uj0qRgoH1nQczbadD1fDuG9hN0Ornw0RWK3m3TyUg6fZgskDwh9
 Kj8yTnpvNEBvnXW3tura
X-Received: by 2002:a17:906:6a19:b0:abb:6e95:b272 with SMTP id
 a640c23a62f3a-abc09a8091emr2753678766b.30.1740666001305; 
 Thu, 27 Feb 2025 06:20:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFN5q1EWZ4vpbjOAN8dICG2xZjo5vyycBjiz7KXuTPHwe5I3CuqRzdgEaQV0KEYm6igPgQFNQ==
X-Received: by 2002:a17:906:6a19:b0:abb:6e95:b272 with SMTP id
 a640c23a62f3a-abc09a8091emr2753675266b.30.1740666000845; 
 Thu, 27 Feb 2025 06:20:00 -0800 (PST)
Received: from [192.168.10.48] ([176.206.102.52])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-abf19aca8a0sm76306266b.178.2025.02.27.06.19.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Feb 2025 06:19:57 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/34] i386: Fix the missing Rust HPET configuration option
Date: Thu, 27 Feb 2025 15:19:21 +0100
Message-ID: <20250227141952.811410-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250227141952.811410-1-pbonzini@redhat.com>
References: <20250227141952.811410-1-pbonzini@redhat.com>
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

The configuration option of Rust HPET is missing, so that PC machine
can't boot with "hpet=on" when QEMU Rust support is enabled.

Add the Rust HPET configuration option.

Fixes: d128c341a744 ("i386: enable rust hpet for pc when rust is enabled")
Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20250217154416.3144571-1-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/hw/timer/Kconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/rust/hw/timer/Kconfig b/rust/hw/timer/Kconfig
index afd98033503..42e421317a5 100644
--- a/rust/hw/timer/Kconfig
+++ b/rust/hw/timer/Kconfig
@@ -1,2 +1,3 @@
 config X_HPET_RUST
     bool
+    default y if PC && HAVE_RUST
-- 
2.48.1


