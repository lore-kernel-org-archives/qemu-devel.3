Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DDAAFCCD183
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Oct 2025 07:57:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v6lRQ-0000FH-9j; Thu, 09 Oct 2025 03:52:00 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRO-0000F2-Kl
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:58 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v6lRI-0004VS-Br
 for qemu-devel@nongnu.org; Thu, 09 Oct 2025 03:51:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759996310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bcU076SoM74F/33kjQ/Q+W/mx4ZXb153IX1f2euibwI=;
 b=M1opwDJ0TB3VyCJ5gObKIxgNYGgYR1AmRKFcflZUX+dmEKYHks7cw9P1JHvb447bhDtlGA
 a76UkUYnhfZM6/VnzryKeIzrsvaR21va+XpLQpNEmAQi2mIX/c0JFs2Q3ahNQak5aXQOfS
 8MgBETYcLu9kbPWZ1PAyyYU6DI7AWZQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-oxb1izrfNa-Nh7oOCaKwYg-1; Thu, 09 Oct 2025 03:51:49 -0400
X-MC-Unique: oxb1izrfNa-Nh7oOCaKwYg-1
X-Mimecast-MFC-AGG-ID: oxb1izrfNa-Nh7oOCaKwYg_1759996308
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-46e3d9bf9e1so3607225e9.1
 for <qemu-devel@nongnu.org>; Thu, 09 Oct 2025 00:51:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759996307; x=1760601107;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=bcU076SoM74F/33kjQ/Q+W/mx4ZXb153IX1f2euibwI=;
 b=DQoumqOvbQpMFq95cwDVweEwtVIe+iZwKnEbCVN/jZLuZbIDPEE1qgvpzYWB/74MGa
 geJhqtBddtNbHjf1ZlOWEuaXRhTtKoyVQue3zIUB2vCGoTeW88f9PsJrsH6kqsbao4k8
 GvdD82LEytZLjeXaXzAPpy1xu2o10G0gWxUfTIOnjlrEaWMhgRsoWKS5qzf6TzYvdDeg
 fv0G+b/ggtr8hfI8IE1Lh1wjc9r35KyLYgHH/hxQ2RaH48JRAy5d6TFs9wqSo1yPDSqy
 NIsJ+4T8Yp80Nl5ZmnzcM2kUEgBJeD3CYfqw1mVpPVlM+oX9v0J8s/mB1YmXJ0aDDe0+
 Gvxg==
X-Gm-Message-State: AOJu0YyeXmuS0jlZw9yCYOmZTgZFOGr/9kZ9rP4/y0ciSuW4CrIlpSnV
 +KCJoaEAmWvynBUrjpYX8/tB5O6kAZRZB4z0aoXxRAZtiUPzbUEaf5uQr9SFlA6v0OBJdU6SfB9
 ZPNFM6XOdTodOlW3EWQ1sx3Na5OUrFmvvVADG+Vc0BSh+oiu2edNO7XLdQjNrOix5ATeAy6ghsI
 byaAv5SDrbqPMwqy5hZeHoFh6UKsW9ulOnN2LdQNlwoRQ=
X-Gm-Gg: ASbGncvXk7m3F52wYvfZfdSISIA8bqfD4UyKRO6zzg6CC6HobTexHswGvYZejTrY3nz
 T8DjBXkDq9SXc0K2ZsDzYBM//zbUqY+ibOiiBTFu9KBky7LVn4u6gu4chf2Bou8Wx6g6fyefalT
 pUCIugq/avACcta9josXWvKk0UqyLiXmw/Gz3W10cKfFIRj5PJkxMt1/8AoCmtO7FA2PVTVZ/nx
 N74T0s21NdaDM//Akgn6bHqKb3hkolDdxstJ9VK6ybbh2LzpyDIW9CEu+aA5Ci0rJDtxtTOkMAR
 WsbWHA4Rc0Wn9aMeR2jL6RyD/Kzvo55eDPMFU8VVlksR/Tls0PncMFwOS9ehYx34RigB/4i4Dl+
 UfqgQIF+VMTZQKV3IMU+CqGp++9XE7vOxRRFqQ2rxv0P03t/v
X-Received: by 2002:a05:600c:a341:b0:46e:39da:1195 with SMTP id
 5b1f17b1804b1-46fa9a8b3a9mr46844525e9.3.1759996307367; 
 Thu, 09 Oct 2025 00:51:47 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFXEG2+NoknKSyu0A7W0D3Dybmb6CnDsfaxxbjHCv2xdBMRFzAsRcXr6RT2mP4OXxd1ANJJ/Q==
X-Received: by 2002:a05:600c:a341:b0:46e:39da:1195 with SMTP id
 5b1f17b1804b1-46fa9a8b3a9mr46844285e9.3.1759996306916; 
 Thu, 09 Oct 2025 00:51:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.36.217])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-46fab3703adsm30865855e9.0.2025.10.09.00.51.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Oct 2025 00:51:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 35/35] rust: fix path to rust_root_crate.sh
Date: Thu,  9 Oct 2025 09:50:25 +0200
Message-ID: <20251009075026.505715-36-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009075026.505715-1-pbonzini@redhat.com>
References: <20251009075026.505715-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Stefan Hajnoczi <stefanha@redhat.com>

Generated Rust root crate source files contain the wrong path to the
rust_root_crate.sh script.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
Link: https://lore.kernel.org/r/20251007194427.118871-1-stefanha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/rust/rust_root_crate.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/scripts/rust/rust_root_crate.sh b/scripts/rust/rust_root_crate.sh
index 975bddf7f1a..f05b8d02108 100755
--- a/scripts/rust/rust_root_crate.sh
+++ b/scripts/rust/rust_root_crate.sh
@@ -4,7 +4,7 @@ set -eu
 
 cat <<EOF
 // @generated
-// This file is autogenerated by scripts/rust_root_crate.sh
+// This file is autogenerated by scripts/rust/rust_root_crate.sh
 
 EOF
 
-- 
2.51.0


