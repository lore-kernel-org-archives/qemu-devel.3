Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3B2FF8855
	for <qemu-devel@archiver.kernel.org>; Tue,  5 May 2026 20:30:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKMMO-0004c7-5K; Tue, 05 May 2026 16:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMMM-0004bI-RV
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wKMML-0002ft-32
 for qemu-devel@nongnu.org; Tue, 05 May 2026 16:27:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778012831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Dyb96gHjBVyrb1hhDEwJgJ8h7wgrV0AQCUFZ7NVQicg=;
 b=TsEi5XDOGopZC7vkTqBl7NmTsFM6NeRcdKKSoV9M/3YimwwLZ/XKBPrqGr5hlajr3TF6+R
 2ahwGRrI/R+nHct1G4yq9q36lWHyjXDCoacKwrbSQxoIruhy6bejlfMr3DYCVlfiNHbip+
 yWyEqomA+jLXJdOas+V/+3Jy2jDipwk=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-402-cEsicOsgNryq82rIoSbxhA-1; Tue, 05 May 2026 16:27:10 -0400
X-MC-Unique: cEsicOsgNryq82rIoSbxhA-1
X-Mimecast-MFC-AGG-ID: cEsicOsgNryq82rIoSbxhA_1778012830
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8eb04352924so815313085a.1
 for <qemu-devel@nongnu.org>; Tue, 05 May 2026 13:27:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778012830; x=1778617630; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Dyb96gHjBVyrb1hhDEwJgJ8h7wgrV0AQCUFZ7NVQicg=;
 b=WzkNo6eWmEkArALze6qYwMFf/l+CZaA+KOgP6mDS+cJJPU8I/xEB2FIZi82ghLQRdS
 e9Ei1GpFn/YHb6EWzBnO9ylfCm6xydmnnitoMA4tvH2GpHKCOAon6Sh0AoV3oMLbcwTz
 k7M0GM/txAt8mDEA3b7Av05EXJW009chSbl5s9FRvnXh30dIUTFhonWoHxD6P8cj732S
 h4ytZYWqU9jjUOs7qSMo++uiu2M29KhmvVU5Qmi6hdzMdaisdwt8HhEgu5Go4yJuc+O6
 X+WZ379JDHW/O+9lh4r2fB2J6b2r9W8yR5WZ/iqy2gXhv3UkeVHW6zuAEksr+gRjvSuk
 as4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778012830; x=1778617630;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Dyb96gHjBVyrb1hhDEwJgJ8h7wgrV0AQCUFZ7NVQicg=;
 b=IDuZWkGF1dNxVoRTmJOqS5U1MjMGGGXp91CLxgcqjCetyy8F9NZhF8QM5IL5f+ENqa
 FLuEbgY+ZVzV4d/2ZYiBOjF/kiozAHc/8FXjC5yEjB5+iWarRRd2oMGS4W+mioKY3KFp
 irX+63aj7ojRwWpXugOtMJbMP9er24TewNkNqJe2un4xveFBs0ojo904bCFCby34iJSu
 jSykx+inhIZgLTpEwrdPTsmQrXA53WXFAwVJat9fLRC3Alea/x2FncwedIk9oFbSh8XS
 kGzz7yAN976YcE0p8jJMKevvwqKp4D0iBEodJ6wBPHlQZdL2vpAo8aS1pxnXk42UqtYX
 oRdQ==
X-Gm-Message-State: AOJu0YwM3IydTf+UasrAmSD5hDtmH9kTRGaoIC1O6GNX5AtbVumG1QRK
 sMXYxpyfCOSpuc7s2t2xYD9F6NTu6wbtSklAbtZrGFN2lJXU96kBnklxlCpS45q0FOl21ke5Tho
 7Sb8SFS9O5gpBedGMovRyXIQbKZNy8zMoN3PllPI/c8+yF7wKRyC6TMIUZtu+eczymfcql5k6o0
 ouGkbPTJql+joBcgxB2sL1e1PMRgSe3bWZNeQ44g==
X-Gm-Gg: AeBDiev58QDCyZpWQ474KSrTQkck/ppus2ayHxCWzNgyVfRhRzvQHKyd/dVM49DDrt+
 pLzqH2dYO8azw6u3BbPYJKUpevQGnNM4ns5n7xZWBwMV9MG0Wfd3sfTDH/WtdYLncPnQaQ8j24T
 ukNBhdwLP6ZYVyrhg2Ffi1Ux0lS+BzGi0DN/Q3mus44bwn2CN3A7JClWhzEa2AhjOo8vee25pGi
 AD7t2ulTCPpZ36A+UbtF75pgu66DhY7hXqXT4IBMl2n+QDrMwzB8+yfc2NlC6T4BgsMhFFqgfEo
 MWSOQbmVtbbbX/qP3j2RvAQfM9/g5/5SihveBL70sVRIf5tIpvyappVQVFsyHZmT8Z7aTwMO40g
 XlIdzbvBMaBnHavWNyLEfwisLfmsuN/u6v+0o2ihb7NDk1YWf12pjXmk=
X-Received: by 2002:a05:620a:2804:b0:8e8:bedd:14b2 with SMTP id
 af79cd13be357-904d69d8de7mr101666985a.43.1778012829880; 
 Tue, 05 May 2026 13:27:09 -0700 (PDT)
X-Received: by 2002:a05:620a:2804:b0:8e8:bedd:14b2 with SMTP id
 af79cd13be357-904d69d8de7mr101658685a.43.1778012829095; 
 Tue, 05 May 2026 13:27:09 -0700 (PDT)
Received: from x1.com ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b53c6b8123sm155283806d6.35.2026.05.05.13.27.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 May 2026 13:27:08 -0700 (PDT)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Xu <peterx@redhat.com>, CJ Chen <cjchen@igel.co.jp>,
 Tomoyuki Hirose <hrstmyk811m@gmail.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 22/23] system/memory: assert on invalid MemoryRegionOps
 .unaligned combo
Date: Tue,  5 May 2026 16:26:39 -0400
Message-ID: <20260505202640.1011006-23-peterx@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260505202640.1011006-1-peterx@redhat.com>
References: <20260505202640.1011006-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

From: CJ Chen <cjchen@igel.co.jp>

When it comes to this pattern: .valid.unaligned = false and
impl.unaligned = true, is effectlvely contradictory. The .valid
structure indicates that unaligned access should be rejected at
the access validation phase, yet .impl suggests the underlying
device implementation can handle unaligned operations. As a result,
the upper-layer code will never even reach the .impl logic.

Add an assertion that the MemoryRegionOps doesn't specify
this invalid combination.

Signed-off-by: CJ Chen <cjchen@igel.co.jp>
Tested-by: CJ Chen <cjchen@igel.co.jp>
Suggested-by: Peter Xu <peterx@redhat.com>
Acked-by: Tomoyuki Hirose <hrstmyk811m@gmail.com>
Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
[PMM: tweaked commit message]
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Signed-off-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260428093339.2087081-5-peter.maydell@linaro.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 system/memory.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/system/memory.c b/system/memory.c
index 225bbe38c3..739ba11da6 100644
--- a/system/memory.c
+++ b/system/memory.c
@@ -1573,6 +1573,7 @@ void memory_region_init_io(MemoryRegion *mr, Object *owner,
                            const MemoryRegionOps *ops, void *opaque,
                            const char *name, uint64_t size)
 {
+    g_assert(!ops || !(ops->impl.unaligned && !ops->valid.unaligned));
     memory_region_init(mr, owner, name, size);
     memory_region_set_ops(mr, ops, opaque);
 }
-- 
2.53.0


