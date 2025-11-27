Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82071D11183
	for <qemu-devel@archiver.kernel.org>; Thu, 27 Nov 2025 13:21:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vObw2-00060n-Od; Thu, 27 Nov 2025 08:21:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObva-0005V7-NJ
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vObvY-00025x-0x
 for qemu-devel@nongnu.org; Thu, 27 Nov 2025 08:20:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764249651;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=isO8fa7O3c4qBfTQUgy/eZ5GTanVVaRH/3OOX9kLqXA=;
 b=diQLxFL3POSmdSB7etNLZRwb2lJ+Pey2i2S4vcM0L2ve2PDR8gtHgLmVtnH+G383gH4UeG
 AQarx5xcMBfRmkZ5YxZrQPe1BQBkuSJst0kOfPfi/eDSMIDWbAuHuxY2O5nAdJHEhw8yma
 0rm276+NBnOM6vRjUEmirjItzt2XKd0=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-HzkMWxPqP1ytOOm0lOfzAw-1; Thu, 27 Nov 2025 08:20:49 -0500
X-MC-Unique: HzkMWxPqP1ytOOm0lOfzAw-1
X-Mimecast-MFC-AGG-ID: HzkMWxPqP1ytOOm0lOfzAw_1764249648
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-b72a8546d73so103625166b.2
 for <qemu-devel@nongnu.org>; Thu, 27 Nov 2025 05:20:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1764249648; x=1764854448; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=isO8fa7O3c4qBfTQUgy/eZ5GTanVVaRH/3OOX9kLqXA=;
 b=su4STghGjJH62oQoQ6Kqy+90fiBoKGSMY8mqxe8ev9n1fFRou9/B4klmNPKTZ/rUnj
 bHLBmgKf/lmpNle3AQIbuZwOzNmAHT0GtgBkHZ4+ES5++LOHaOO9l0CfU8knTXhdBcwy
 7f8rA/e3ncX1JhMjB9Tv71vspprAH5J4dKvveQTKyeP3yz5RA5IcVikDu/3e6o7exwfX
 tNuyrMjt7buWakBDbGWJxWHdYfZCjdxL2Ctx3wvsPfBdW9sYPqbMcAkcQboluzCMPmuY
 i9KBiPpgJWMZNkS6l0ZZnfwmfFdchEviZGkNPVkvcvwcQHPqxwWrk5XK+fQhBjPEl36T
 bMHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764249648; x=1764854448;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=isO8fa7O3c4qBfTQUgy/eZ5GTanVVaRH/3OOX9kLqXA=;
 b=QIBhFfQwfZCn5OaiKkV3XNqHuVOH1AEOrVzrqBxPV5fvNR6KFNu7be9Syliv7aCWwy
 4Avu711dnSxjKJUk2eFh7h6f5Y7QmhXA6vw69JcIjpmBACAsc5A9A46AWn3+Y0irNLdw
 mskOroOe2MSp26pXgMlysaH9oXOw597XpRSgtOjGwiFLB4kcLm4nwiyTF781i6A2Jwdn
 fK5rpv+2IraCnTAVqI8OQvfIIuAxd8yBufukc5MQeg833Tzu6szZ/BJTv7fF9RPBkCXg
 dgNV81ILPwOO2GvxSSmWyoIIe5263MRwNSZOPVDNK97flWcJjstbhX+8+1lT6EtdJXgY
 OL5Q==
X-Gm-Message-State: AOJu0YwafWXX38AeMwdxuI2tFbo+JaE3dk0XAanlyrIUgtzsW/PZbA0X
 bN2HpsbQBYbccxfDQErv/d3BhKtq3USZnPrCV0DpZH2fnVFvK+opjITd0IkdZTWb72T6xfTfQxn
 0FJLVbhoJisNa8MN2A9poO9S0TeNboTzFy1yaK1zfapzk+buWvXpeXpKhCJeqxESJnSsdUr14JL
 NcFpcc89PafDwxfsoP6NNSAU7gbFV8cS/svwQJJ0Y1
X-Gm-Gg: ASbGncujUPOr737L0D+n7QG1ItP/ZuBSFAX/LQxqAro4lThqifuaNShYavlnEmuyN3z
 e6Uynlig5JPUtGdBLs1wGyFSsuy8aCTcgYmocjLY26xji1y/bi3Mh68KZF7fKnSc6eZADKmZx7m
 C2Pzj1snRme734mlCDTx7yFFoB1AjoPRhFJdprjJ5K/EfJZ42OiEU6g2wEa+yaih3RnZFZOQ9HV
 vN5i224+TYlJDr2YVvN1kBbD57337nwefniDgP1G1kCzkjiiG2Tm6rbYbHbOeWCEJiU3XEO2NKS
 a0aBijG2vuR7NIr3SjZ/4xMimHiP+mLpNFIwGs3wiFhJDFjoWB1ak3hYix2yIMW42psX5dAJUsT
 oCq+eRZ0D4+cDzJNwmB2V5yrmfYBOOr/bKQya16RmwSDfsOw3ZWqhBIyPGTwIDttDvGV62KDOHu
 oVsNEOx6y3UVILQI0=
X-Received: by 2002:a17:907:72c2:b0:b71:29f7:47ef with SMTP id
 a640c23a62f3a-b7671b50083mr2523412566b.61.1764249647912; 
 Thu, 27 Nov 2025 05:20:47 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHduIIPVflFvWbNu/AZ34V1zSPZQ34GTNbBQlkL01K9Sx9DaVcBqCjb3AXVG16DZAv3yyCx7w==
X-Received: by 2002:a17:907:72c2:b0:b71:29f7:47ef with SMTP id
 a640c23a62f3a-b7671b50083mr2523409466b.61.1764249647514; 
 Thu, 27 Nov 2025 05:20:47 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-64750a6ea41sm1586055a12.7.2025.11.27.05.20.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 27 Nov 2025 05:20:44 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 4/9] rust/bql: make bindings public
Date: Thu, 27 Nov 2025 14:20:31 +0100
Message-ID: <20251127132036.84384-5-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251127132036.84384-1-pbonzini@redhat.com>
References: <20251127132036.84384-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.224,
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

For consistency with other crates.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bql/src/lib.rs | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bql/src/lib.rs b/rust/bql/src/lib.rs
index ef08221e9c1..2cdc551e21e 100644
--- a/rust/bql/src/lib.rs
+++ b/rust/bql/src/lib.rs
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-or-later
 
-mod bindings;
+pub mod bindings;
 use bindings::{bql_block_unlock, bql_locked, rust_bql_mock_lock};
 
 mod cell;
-- 
2.51.1


