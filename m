Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BF99CD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrID-0006cS-6J; Wed, 17 Jun 2026 10:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIB-0006bu-SR
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:30:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrI8-0007a6-5K
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:30:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706655;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpwcWeBuo0q2w/B8rRegV8dflyxdBlz27GTf8UtE9Y0=;
 b=eL2Nsaq5I7co1Zj2RLAeZG7jx59l15eAq/iVsH3Its7ECzu80iKQJTRM2R9+UvUSxOkhHG
 dQ33utHS/oph8PCaWq9Rh5NK+kSJIyL6krQhA5gFokjMtmuP+tFn2DCDCnfecWb94OgDZi
 r5Re4zQ6xKIIxVhhnrmy208N8Y7w0fk=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-148-RfxEbjbCPAi10dOvaXf3Ew-1; Wed, 17 Jun 2026 10:30:53 -0400
X-MC-Unique: RfxEbjbCPAi10dOvaXf3Ew-1
X-Mimecast-MFC-AGG-ID: RfxEbjbCPAi10dOvaXf3Ew_1781706652
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-bed16fc8424so514600866b.0
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:30:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706652; x=1782311452; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=MpwcWeBuo0q2w/B8rRegV8dflyxdBlz27GTf8UtE9Y0=;
 b=GOP1jSM/0d/ShC1mS8ifQ3bc5S8GhCgSaEt1K6HWr9Fk1PmSVE5anjpOM1giGyD5jF
 ckhCPLZQQ5zUzXHpyO/IuwTEZNkkhXiOEWLeJoUo537wUQ1zJ4L4yIvabJzBwkjPDNLh
 g5VbUOpCoxld0WBGtR+zor5xYFWGfEUsdwNOdzPwQrkELd7zDYNKUwyTjZ3k4HYnXySR
 v9vOGIolRhOppME8dpubWqlNLxw0RsBqbznekF2Hhw/REgfLeCDYvaXiB9gAh0zwnVs9
 7jRS+SGeEEiB6qpQnRMaekL7m36VCpoq7cz0w8jq1Lf5SD+EJQCv8gEUCnSuwg2mgBRf
 xHlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706652; x=1782311452;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=MpwcWeBuo0q2w/B8rRegV8dflyxdBlz27GTf8UtE9Y0=;
 b=dXdPchoYzQOeZn2L0wPNUg000iZrxPXPhV5IvVbJDPRxwtf3JZTkxNQgoNe3Cpypk9
 euGK+GuDPaukLZ1ugmUYEPzU2VYvElyYid67k6aFaA3Lmqd16jxGE7Dp8opP4g3JnF84
 q3cdflhHyhmn4xioTOtNG5jBgdeChrA6/QKsjgWMg6ZSO+kdOcmHOo3YJ14AWST4qvyi
 zQaL43rh4t/0jGsswi1biPic+1deqdDglefmUxPJyCc8WBk/q6l2u//v/tqbuMcTQMZm
 B9ZtObLBaqczPnLVwg8UNRxYTQ4ISViRLpZ7SqVyp7M2hlikMA7BI5VDzNNLFowr21Mo
 mPDA==
X-Gm-Message-State: AOJu0YwJ6Ls7d/AF7i1ROWNfpNmwBIKU3pwO/aojJtdE4NbRe+eR8eFb
 REWKmQ8yYpfAxsaXBNytEWaxsz/eZSDJdBFArklObugcFrBdSNkQ531UDo+p2oTRzrIeo82jaI4
 4+LaNAvInHq96PFCO2fR2iQO3AuNqPyz/U3pXzAzpaCdsk2GcYEL0cL26YRySFi0WQrTXvUhp+t
 PFEpQwvkAc5C3usEqYVV0cApYNAS1OtN9O5oKKMsL+
X-Gm-Gg: Acq92OHGGComdxXtUCUmsCcC3DEDEGutl6BxlCmo8YJwtV3kwRgZ16fhzxMY8ytoHBR
 IWwXQCmHu0LUhs7yRGo84YkZlC0moNQc7+6OuXvo1GLOsT4rLSJtoFsg2hrdjOechANQdm2WZIl
 Yfa3rtpz1siYYu6Os5MEnchlTO+/fVYdq5PyqB5bpnWqrPQOXQemL/+7SBtt0OqFMy+9FkzR+28
 QiOHpUGkb8zxOJUUfNXL6r0grephxPfr177ShuP1GVntXgOwzF6cDP5GqCGBXePS8pWo6+6M1WT
 URopCO6+N2x0ucvBX5HfKu4/FawNjSvaBrbcjiS1TV4qp9VEWbwUQjYCMzt2riydXNOJIcBmDtl
 PD157PuG86MIVciDqBr4503ROAk+YkqCPM73u1A/WKJhho9R+GZMipKmo5jXBgSY9mLqgqEPG93
 ZcpB9G/0pVaw3RtjOV
X-Received: by 2002:a17:907:3e84:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-c05a521d4cdmr247983366b.17.1781706651850; 
 Wed, 17 Jun 2026 07:30:51 -0700 (PDT)
X-Received: by 2002:a17:907:3e84:b0:bd7:f75a:817c with SMTP id
 a640c23a62f3a-c05a521d4cdmr247981066b.17.1781706651236; 
 Wed, 17 Jun 2026 07:30:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c06079325adsm107149866b.58.2026.06.17.07.30.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:30:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>
Subject: [PULL 01/16] rust: fix incorrect dependency in Cargo.toml
Date: Wed, 17 Jun 2026 16:30:31 +0200
Message-ID: <20260617143046.445322-2-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Reviewed-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 rust/bindings/hwcore-sys/Cargo.toml | 1 -
 rust/bindings/system-sys/Cargo.toml | 1 +
 2 files changed, 1 insertion(+), 1 deletion(-)

diff --git a/rust/bindings/hwcore-sys/Cargo.toml b/rust/bindings/hwcore-sys/Cargo.toml
index c20024e921a..b5ae33da8ed 100644
--- a/rust/bindings/hwcore-sys/Cargo.toml
+++ b/rust/bindings/hwcore-sys/Cargo.toml
@@ -21,7 +21,6 @@ chardev-sys = { path = "../chardev-sys" }
 qom-sys = { path = "../qom-sys" }
 migration-sys = { path = "../migration-sys" }
 util-sys = { path = "../util-sys" }
-system-sys = { path = "../system-sys" }
 
 [lints]
 workspace = true
diff --git a/rust/bindings/system-sys/Cargo.toml b/rust/bindings/system-sys/Cargo.toml
index 7e527130ff5..1e0fa8cf79c 100644
--- a/rust/bindings/system-sys/Cargo.toml
+++ b/rust/bindings/system-sys/Cargo.toml
@@ -20,6 +20,7 @@ common = { path = "../../common" }
 migration-sys = { path = "../migration-sys" }
 util-sys = { path = "../util-sys" }
 qom-sys = { path = "../qom-sys" }
+hwcore-sys = { path = "../hwcore-sys" }
 
 [lints]
 workspace = true
-- 
2.54.0


