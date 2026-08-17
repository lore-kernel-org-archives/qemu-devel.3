Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE503C5DF74
	for <qemu-devel@archiver.kernel.org>; Mon, 17 Aug 2026 13:46:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wvxfJ-0003TW-6k; Mon, 17 Aug 2026 09:46:18 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxf9-0003Sn-TU
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wvxf7-00020u-D1
 for qemu-devel@nongnu.org; Mon, 17 Aug 2026 09:46:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786974360;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hwtXrsgaYsdxAr4JCLCC7SGP5kvBblaSG6HPpLkS3/g=;
 b=LL2GnttnHixiZvflUIht9685+P7gAeqGs/2+Ro+U65dD+ufef2EW/6Xe+H+Xkqd1b2iYNr
 Kfz6v9e4kPGupPin0jG4Lh+fDjmaJ77nQRwWCOl7vpN9bGmg3eeEwQH6H+1LeANd4EFmZR
 e5T8Fzz26IWIYUQJ1lXSE3yZcP97H9M=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-4j_sjj3VMpinz4LeIgWWKw-1; Mon, 17 Aug 2026 09:45:48 -0400
X-MC-Unique: 4j_sjj3VMpinz4LeIgWWKw-1
X-Mimecast-MFC-AGG-ID: 4j_sjj3VMpinz4LeIgWWKw_1786974347
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4955ce558d8so37404315e9.3
 for <qemu-devel@nongnu.org>; Mon, 17 Aug 2026 06:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786974347; x=1787579147; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=hwtXrsgaYsdxAr4JCLCC7SGP5kvBblaSG6HPpLkS3/g=;
 b=mtfwt5GhIWSJZkOOEUxyp9jlxGS7l87YaEB5o8pI5jYZgmigTC/F/gqD0gQxuOueBe
 qhERyxmLjggJNZavs8vEM7VfwK/5XJ1WNP5RU1zHPAyQwJpIB5tEOTwMAPhyPSoOCN8S
 P1xHAw6JupFqJQKktOUrFjatVRQWKEorqCn12dlrHNrcx3d8m4256W/QUnNxjqAQ5WlF
 x+AY5vLacLSghOzi7U90sVy4wTFlG8nRqXEP5T7wo3pz/3kaXEbG3hwL9/Z4iFZkMVg6
 6EsE7NYxW4VtfAh7zvj/qmIGRXhUKKHIql1FBehDYOKRr9UtLF/ZxOaenm6W9XS7iBaS
 jKRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786974347; x=1787579147;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=hwtXrsgaYsdxAr4JCLCC7SGP5kvBblaSG6HPpLkS3/g=;
 b=XAhw4ap3MzATbBPboNhwXuoJwTMzsugPNkz9swGlFfZNmJqG2E+O+JHeO/cjr8nsRD
 XJ6snwrYempuSG/SYTpoVao/ekN85ET5bJFy5VMG2XvXA+YNfyGhQ1o/7mMDqYOsSgi1
 pYVfd03vE/BehpANq4OSf8YQEVqGpUcfFAGYHIInGJevuh4vj8ZeYhZQhCiXwdKXgT4k
 Pb/NdOZ1E3eP+mMsiBXhYc/vCAg/IGrBAjs+qX4IHsYoMxAy2kzbD0qiSINncY7KMz26
 evE6fYqHQ9uQjMR7g/xiR8gJryuypi7UikaIgM4WF6bMW/q67UGLip/Ck5gsQ6wg8aDG
 bxsw==
X-Gm-Message-State: AOJu0Yz3r8A7o5nZmNYgSVzkMI6Kul4Wpr6xXlexF5yElXS5dcyaFxUG
 H2GXo1IYb8E8bnsSZP0SNI0A28eC018xKfvMD9XIDG5opegThM621CdGdvGU2Rbw2GExnzLN2gL
 LGr/+TF4zD8XPq2r+Y8SdTHJHm+JZzHlftsftvJvfmheniOupRT0KSViiargqd7KgA2rDSrFEZv
 6H91yjAT1FwhhsSfCyPmBGIRmDxFMxqRTegYbg8fTa
X-Gm-Gg: AR+sD11s7hGPuEmfNq6jDTrXkyCYxmO9T19ruz7wKvQuc6IqRx6cFUo7i+LtRUukA3H
 c4YyBHneGcrg3wyFGxKX8Y/G2xvhkVj53NGsvESS957ndahFuRnv3UhpJLniDe6EEPr+BNZMxAD
 OMR2RSw/y9gVl6xSPRGD4/b3B6+6fXwFh77kJC+3CUC3sYKnX1Kyp1uB4JxGb70BdC0je7o4PEw
 sx2byKnl5beUPELDWO2CjPNDV8ZqHp7QwhN0OMB47TmlnoaMWlKTxYaxnMhA0thszw6bcRevfPG
 L6oeLTLJk90OdY682+Xok1PO2vz37kTTIOfSKLqv/ycW1FeDdnfeTAvN/MQfkxx73lY9sENUH5i
 QoSvfV/tqabV+ylOkn0IdIOgf10qV62ECwKktffkrJq4kuqG4YMZqTo0Y0dkumzWy
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id
 5b1f17b1804b1-49987995272mr311367295e9.13.1786974347352; 
 Mon, 17 Aug 2026 06:45:47 -0700 (PDT)
X-Received: by 2002:a05:600c:68ca:b0:495:641a:bd3f with SMTP id
 5b1f17b1804b1-49987995272mr311366365e9.13.1786974346746; 
 Mon, 17 Aug 2026 06:45:46 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482a5b7834dsm3820542f8f.28.2026.08.17.06.45.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Aug 2026 06:45:46 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-rust@nongnu.org
Subject: [PATCH 2/9] rust: update Cargo.lock
Date: Mon, 17 Aug 2026 15:45:30 +0200
Message-ID: <20260817134538.924615-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260817134538.924615-1-pbonzini@redhat.com>
References: <20260817134538.924615-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.343,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Apply change corresponding to bff64138882 ("rust: fix incorrect dependency
in Cargo.toml", 2026-06-17).

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/Cargo.lock | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/Cargo.lock b/rust/Cargo.lock
index cbb3ca15f77..c94c2386d94 100644
--- a/rust/Cargo.lock
+++ b/rust/Cargo.lock
@@ -184,7 +184,6 @@ dependencies = [
  "glib-sys",
  "migration-sys",
  "qom-sys",
- "system-sys",
  "util-sys",
 ]
 
@@ -431,6 +430,7 @@ version = "0.1.0"
 dependencies = [
  "common",
  "glib-sys",
+ "hwcore-sys",
  "migration-sys",
  "qom-sys",
  "util-sys",
-- 
2.55.0


