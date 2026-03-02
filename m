Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 642D2D58E7D
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 09:01:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzD-0004y4-PB; Mon, 02 Mar 2026 03:50:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxm-0003g1-E0
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:16 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxk-0002Ik-Ti
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:49:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441352;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NKcA6a+NHKs5mFrrvmvgtmWUQArMtlHNbVwmfEzyy3c=;
 b=WmWPoLjSrNVq38M+j/0aLIALWqjOzUwKLg5iVFMHqPKHI9dKdAestPfeOsjEH/K9NG771n
 8exW8SMWKn+XIdmlmPOa0J1qejHnSOTaBo788V+StLM+5n+unoc2fXu4hxL6mH6aj63Pkl
 sgf2ZObpAJzdiJ2YlYgwmnQW3TwHQlQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-nwj0E5tZNK-ME4b1Dwc2kg-1; Mon, 02 Mar 2026 03:49:11 -0500
X-MC-Unique: nwj0E5tZNK-ME4b1Dwc2kg-1
X-Mimecast-MFC-AGG-ID: nwj0E5tZNK-ME4b1Dwc2kg_1772441350
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837907ec88so48448355e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:49:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441349; x=1773046149; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=NKcA6a+NHKs5mFrrvmvgtmWUQArMtlHNbVwmfEzyy3c=;
 b=N5AQxHUubLcn8l87zApP52YipdOwPAR2awcms9km6a8WV6jJzKgco36vpUlEf3b0hQ
 xmvrpXLlLyZmx0n1LKxzqSPjK21ZaTrR1whIbaArY0pEzv1DZc+qxZFOVEFGq+mToj+c
 XLKPsiShIJks+zD2mC+tSUE3dvcsmu9qif+zRURbzi7C/PUM68tMV6dm4XVYo/0GsQmj
 ZTkGg9Hosl1pnKkb53w6WHnEub/5vfWvMJiNC1AG0lSEW1hVeG5tEmMJs3AKdaRudi1K
 UT8/fAov5MjqN0D7aOYdvRGFywMZSgrtsCsOqfWsA+aqUgmjhF4mbkXi2twJeGuSgU7g
 Uu0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441349; x=1773046149;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=NKcA6a+NHKs5mFrrvmvgtmWUQArMtlHNbVwmfEzyy3c=;
 b=FxKAmv6aH/vH10xF7Lc3ic6Nmt9/Gx4zfLlcUoQzAb3O1vb8X5m8JuP/MUPuDerUzo
 p/K5x5FoJMMbM2Oznj0hdVnYSUJN+n65QCAbP/NJWIqz1JNMVHXuhiz4gjtaj7wkgZrR
 csbf3Gk7WB99yx3MufvTbBJl/eZgf+NO4hnU4PREdYJQjnTZNZSI68pilDq0fj0O/SB+
 8wAPhZtUB4q28Wp4N3/UBeRnPWrXydJTY1KILOXO9Zdtg1CegMo8D0uNVKf2Bi8T/2BN
 tzsYnGwLzdL+8EIS2XxaTvnbzRnnJhLn3BfAdm8qzzu9e2vtZNt3T080TPdu+Vy3Cvnf
 YO8g==
X-Gm-Message-State: AOJu0YyWidIp+A2jwNMKKtG1H849m7ljuJsU1SO5nVUgMNLxrI347+oQ
 kZorQnpPf3ZZh+d0cSwbrbdhuGoqwjsz9r3aCWBw9P96frVU1yRWCkSZMdZ1w2Y0f1AokJj5XVy
 Nv5qOLO2P1TcbyAMXf259iMt8+VmY+WeU17Qfiq/rbnhwgJxWKYxNUIBJqJOsCmg1PrpcN72UPQ
 URe250cjfOGrm2BmV70xh1Yn0qwEn8BbDu9SUCpcyP
X-Gm-Gg: ATEYQzwl5FA64U/OsuMvl7AKNSYr3WEVFmYFPrymOiRYFRrFDfDRCmZ12YN51WVQjjt
 MCd0mZFyVukQmFFMp3saOKyeT0FObaiO8I6NrMUKSrT/sJmW376mIWucKSp933ildL6Pi9/gVdx
 eGsg9w2OYx1zG3lm5fkaYXE9oN0QBPkoCReuVjuMbdHOmEoaVgJ+28cskA4EBdy9jOkNqBmkUI5
 nM3gXLL/+Xsr6YsTwzQgqzbZCQFgmrwT7rNnOVNOnA1h7T9Nz7Ec7BqK7aqAVnQQPjqlyJ3Sy1+
 spYI846FHm4tOiJV/sVvbOaUfCHSOyqSJI5t2C3/vQUclquCvzB6gspXYsNfa/x1dJK6ex0zUqK
 Ykx7Jp08rMUTIbSCVCiR/a+4Ex0FAo2FJA2azoZ6F2DgWuveDTDtpJ96o5mVNaggmDb9xIAEJN3
 Jfa6RsoxVJ/HWQS+z86bbVAcU5+o8=
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483c9c2059bmr169736855e9.32.1772441349511; 
 Mon, 02 Mar 2026 00:49:09 -0800 (PST)
X-Received: by 2002:a05:600c:154b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-483c9c2059bmr169736565e9.32.1772441349026; 
 Mon, 02 Mar 2026 00:49:09 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439ae3f31dbsm12671072f8f.1.2026.03.02.00.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:49:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 098/102] whpx: i386: warn on unsupported MSR access instead of
 failing silently
Date: Mon,  2 Mar 2026 09:47:44 +0100
Message-ID: <20260302084749.474955-32-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260228214704.19048-5-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 2863224cd2e..4186be62ada 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1819,6 +1819,9 @@ int whpx_vcpu_run(CPUState *cpu)
             reg_count = vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite ?
                         1 : 3;
 
+            warn_report("WHPX: Unsupported MSR access (0x%x), IsWrite=%i", 
+                vcpu->exit_ctx.MsrAccess.MsrNumber, vcpu->exit_ctx.MsrAccess.AccessInfo.IsWrite);
+
             hr = whp_dispatch.WHvSetVirtualProcessorRegisters(
                 whpx->partition,
                 cpu->cpu_index,
-- 
2.53.0


