Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C76E1D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzF-000573-0z; Mon, 02 Mar 2026 03:50:45 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxA-0003Jf-Jb
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:44 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyx8-0002FI-Dj
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fvVIHLANBHUcF399LGD4g3MZPY72/e4uDSib/lKjsjw=;
 b=CnJ4flQy6Iadun8IzVNQUfTZLKL1k9aGA7wGhQguJMy9MqN5mRg9q+8UkZxBU4xZqMf3w/
 EQx6LSakzVnXO+yI7zc30C/0BsFW7S+FF8lTPmqfmqczRLNfB7oO5glEYB/+F/AuC6U1mC
 /U1gYm1mptDQ0jmBtXi+cwPJhr3jLVw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-50-aWoN8bz-Nnq-xEQaKw7QDw-1; Mon, 02 Mar 2026 03:48:32 -0500
X-MC-Unique: aWoN8bz-Nnq-xEQaKw7QDw-1
X-Mimecast-MFC-AGG-ID: aWoN8bz-Nnq-xEQaKw7QDw_1772441312
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-439b4e653d2so709556f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441311; x=1773046111; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fvVIHLANBHUcF399LGD4g3MZPY72/e4uDSib/lKjsjw=;
 b=MtGOLrDVmnlYUxQvuH7hyrJeaL/8Fcyo53pvvUZyYh1oI7QZVKzFpg6fDohMskYNEb
 4WGlN79Hvczfty28g/oqjnvYq86aGgVcvA9ORsoxVQxCWPJ8A7HH6+Cii6kLWc1JslSe
 1M+1R1brrQtC0Sxpv8/6dNTCNtv57ecMTP/K0e26IFBka8/rtxHhdwfd+wgQz1V5gIY1
 AKyKBRP15hvUNarnzT4C/IOuuCUQDzjvK2463MvVH0H+Esao0jkyVhJVZzKsBcYpxvgz
 dIJc8WJHjp02FBzrEeSbTfE1rXCRFstQtWgrhXogQmIdbpZRKdTrNvfiZ9XXRdwMVFpp
 yBpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441311; x=1773046111;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fvVIHLANBHUcF399LGD4g3MZPY72/e4uDSib/lKjsjw=;
 b=iMmD7aZBaNmFtmDF0nJ74Epk9OBFsQcpwse7kr6nJ0tJZaXiFe2dVNDNfSJY/VXEE+
 eHvayYIslASMWN1eT42FcI5yXLHCt7JWLf0y33bOWF0Q3jiZDInAHIyOYK+H1PPO0tZZ
 OKj4O10FkGOjMFM7ceHtajBzI1SeFLTtWc/sSNhfozYxCIBQlqsMvNA3m4oLUdOG0hXu
 IqNWRDnBsFWfvjd3EdAYgnvO0jJxeYTAvmvWNN+iWaRv/Ww+MNNr2UGoFRt8OrSO/2fX
 TU2y2Zfp+SgzIcbogieSPbPpRqgy2IQpfDMCKSGV9gtqpq1XFYeeOgwFosEGu7KV1jbo
 rICA==
X-Gm-Message-State: AOJu0YxVPs7s/8iIecTfZr3dnZ6am3efNDSsUcurcM+B5w0Tkiz/0ICo
 KzTlFaaL1lgTgat8KnIc4SKexfKCV3FV48qcCb0rg2B7R7VMiy9iCmQVCJOS7H/XVjJy5Mnae8f
 13z4iclguIFwHzfPImZHBEC6qn3ssUm4KsHFti7IJDii9i4vAtfUqSM9C5kw2O0wyKBZ4/dtcal
 HKaWzGISya/QKkEuYPth36E6M18Zf9czQbW4IsAWWu
X-Gm-Gg: ATEYQzyjPk5KzDw+bybtOSaP9D38PFp76/vvG7wNDY9lkZOBpdyqywGgjpPA5+RQ/Uz
 xT+XJqyv91oiH2lVYE9LvT4tKsJwgvvkmSN135sD/rJv4nOcL5qwbcZe93mALZ451yd/JJsI0Bp
 IH+PPP7uzudjFcc0UkvL8bhNSZGe3qSCGlgk8A1662T1Z9xV5UTsVYSpBT4wqcyPhpW4tI0WS7a
 6KKDK+aQZc3t/cr+0giZPonCAf9iN9vaDjYlo+2VYCSJQKjYZbKpIB38hDc/DlAzW3L9YbUo/Lm
 3/7Sb3jJheqKnz8u1wqteeTI8GJq2Ytz8z+trDDelHKjth+w48Nvj9K6lwWOJMJqimkSUXtjLvC
 aiiRltq93mua8rts38xTFCI9extwGXq/PLTsjrsPyBq6j9W7K19uvd7lG6TfXaJhwZiJQqlNLlZ
 dWqwG+26ayDOr+X27u9czXEpb30u0=
X-Received: by 2002:a05:6000:3104:b0:439:b715:6f4b with SMTP id
 ffacd0b85a97d-439b715782fmr4148037f8f.57.1772441310913; 
 Mon, 02 Mar 2026 00:48:30 -0800 (PST)
X-Received: by 2002:a05:6000:3104:b0:439:b715:6f4b with SMTP id
 ffacd0b85a97d-439b715782fmr4147976f8f.57.1772441310259; 
 Mon, 02 Mar 2026 00:48:30 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439b6d540b2sm6405017f8f.36.2026.03.02.00.48.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:27 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
	John Snow <jsnow@redhat.com>
Subject: [PULL 082/102] rust: use checked_div to make clippy happy
Date: Mon,  2 Mar 2026 09:47:28 +0100
Message-ID: <20260302084749.474955-16-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: John Snow <jsnow@redhat.com>

When upgrading from Fedora 41 to Fedora 43 for CI tests, clippy begins
complaining about not using checked_div instead of manually checking
divisors. Make clippy happy and use checked_div() instead.

Signed-off-by: John Snow <jsnow@redhat.com>
Link: https://lore.kernel.org/r/20260219185409.708130-2-jsnow@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.toml          |  1 +
 rust/hw/core/src/qdev.rs | 14 ++++++--------
 2 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/rust/Cargo.toml b/rust/Cargo.toml
index ace0baf9bd7..0d24eb84e1c 100644
--- a/rust/Cargo.toml
+++ b/rust/Cargo.toml
@@ -46,6 +46,7 @@ redundant_explicit_links = "deny"
 [workspace.lints.clippy]
 # default-warn lints
 result_unit_err = "allow"
+manual_checked_ops = "deny"
 should_implement_trait = "deny"
 # can be for a reason, e.g. in callbacks
 unused_self = "allow"
diff --git a/rust/hw/core/src/qdev.rs b/rust/hw/core/src/qdev.rs
index 145e20a984f..b2e5441079d 100644
--- a/rust/hw/core/src/qdev.rs
+++ b/rust/hw/core/src/qdev.rs
@@ -425,18 +425,16 @@ pub const fn period_from_ns(ns: u64) -> u64 {
     }
 
     pub const fn period_from_hz(hz: u64) -> u64 {
-        if hz == 0 {
-            0
-        } else {
-            Self::PERIOD_1SEC / hz
+        match Self::PERIOD_1SEC.checked_div(hz) {
+            Some(value) => value,
+            None => 0,
         }
     }
 
     pub const fn period_to_hz(period: u64) -> u64 {
-        if period == 0 {
-            0
-        } else {
-            Self::PERIOD_1SEC / period
+        match Self::PERIOD_1SEC.checked_div(period) {
+            Some(value) => value,
+            None => 0,
         }
     }
 
-- 
2.53.0


