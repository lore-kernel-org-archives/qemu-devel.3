Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC5A2C5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5zR-0007Ij-Jt; Thu, 20 Aug 2026 12:51:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zO-0007CD-L5
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5zN-0005hM-0f
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244696;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FzW4yeXeyJWx/8eO0YqfluhDmSC3o0/nya4t2vrCTKI=;
 b=NS2d4hYU0pkvy1yVQ0QmG86yiLtYec2uO/O8flSeisB9uzEZSQbe7k+1OltarzaEIPktGJ
 vTE68upQyJ55S/Y0t0eEkNsKc+JtDjEOdO343QRmihEVWBwDQI+2CUa2azu/j0hED6FjxF
 adG1zvUAXpeuMDCYF6zx2k4/JtbXl70=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-VPDs-nk2OgGwTnVdGUw7iQ-1; Thu, 20 Aug 2026 12:51:34 -0400
X-MC-Unique: VPDs-nk2OgGwTnVdGUw7iQ-1
X-Mimecast-MFC-AGG-ID: VPDs-nk2OgGwTnVdGUw7iQ_1787244692
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-495474a5fbcso284495e9.1
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244692; x=1787849492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=FzW4yeXeyJWx/8eO0YqfluhDmSC3o0/nya4t2vrCTKI=;
 b=ixavg+lkty01n6VmY2IxiLG1Cp3INM85OMxZclLnlQ7x9QV4PP9s6eB6s14zI2FUXh
 55XTNUFc4Q441/VyzgH7pYau8OFySKUHOyj+Ny6i/PqaV34k7ysy8f+jRr0ihR6NUsix
 SFJRFHpn2DAeXleBDR6HlSuZ5FTow9DIZ7gMcYbVOrEvRWurI1lPehrUPcVQBT4qKkSl
 FWVBNcaxUZCk+aDqsdLc2CuFux6Ee8nkhRRn7xb3thHfZy7YB6OZsfSOncfjJ8S/Gzs8
 LH0N3OHDj125vpw1kyrsdmzpJK6TXKwpy8xPDBcwiRzl6GJLl/0ebyixjz0kLyUM40ZN
 hUlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244692; x=1787849492;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=FzW4yeXeyJWx/8eO0YqfluhDmSC3o0/nya4t2vrCTKI=;
 b=LGmXZFdUNaXYw6AspFgPWep3P/6GijKEKbNiQtQ3LCOCQVJSPPpJ3kqMs8KEC/qha5
 H3ri9uSXjZepnY2rUb6w/K4hVjIOZRZxqVbI4bPDu3gpTS5NHB11VVRQhPr7uZlo/R1/
 kSMPz0c5W7evBINtC01Un0BFswtwagUHPh4yUZQY9335PWrjrLhQwREexiEQSmmKKav+
 +OprYXp9Vn2ut4MCChPWum1MM2J6mBMAPdszod+t3yDjmZL3eVeWHof02C4WcZVgaG+k
 PqOB4Wq/lozp3rqVUCR7P+uxI3y4Ynt00FkNHhCXAFGRsHXR/Pr7kHUIM2z+98PK9Pdv
 Rjow==
X-Gm-Message-State: AOJu0YxHBm90P0zhYBq2tI6R3+MyYHw5ZnVzZb6mL4bJNr9ur7Yfn0Dl
 HSU+k8LIU0O02U8LidI+ONKsIH0dbLimDm+pYIN5w1aT/q/PEvLim/Z0kN3HZZPPARa2+5hDlnM
 SOxYjTE0wnoye+HUQlF7KGp4e8wjPq4uyJNeTMQG46sLKbxAogyAnBWqZ/e8WbFyZDHGHfuQ/+r
 02qGjhLJqpb3iKdRT0CGkG3iGWG3AC9p6FFGQkL0sb
X-Gm-Gg: AR+sD10TFQU2vXs0Do18J3v18/TRkZL+6+xi0uwnluMbLiU7+SDhD89BaGRjt+ceTWm
 mY/GUl1tomL8z4T99PISrIycJsM8ETFcizH4d5yMdz1Rklep0vNiyY0H4m3Ga2fqXch17xr+OZ8
 vVduo256IWjYMZ8Vxlddv08oDWyJ+cBm1LIOIwGyosXhMHfEBtKp5udBQE7OzrObYHWheXu9L2n
 Ie8YC5jXnVFe8RsIGsELJexeXydLy4l9JxOiHTdo3WwVpF6ai/i2eoM9JSw2232XXAoHBO/TqjE
 xYmx5ZvwlkpbtlWDDTIHxtjUBbQpxFfZDRS8sTa2DIZhN2Hc/OtV/Hc+GFGjTH6wKguEVka9L1m
 wDV1k+7SRMbrEKlM+bgDhXCRiMriVPDEsfuupE5FhiAZKZX+Er/AC2feLMUyCixQZSjXgktkL9q
 ADCxM=
X-Received: by 2002:a05:600c:8508:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-499b84660ffmr3423605e9.9.1787244692546; 
 Thu, 20 Aug 2026 09:51:32 -0700 (PDT)
X-Received: by 2002:a05:600c:8508:b0:495:4572:21af with SMTP id
 5b1f17b1804b1-499b84660ffmr3422555e9.9.1787244692091; 
 Thu, 20 Aug 2026 09:51:32 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-482b14d05a6sm15330689f8f.35.2026.08.20.09.51.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:31 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 33/53] whpx: i386: enable fast hypercall output
Date: Thu, 20 Aug 2026 18:49:36 +0200
Message-ID: <20260820164957.1895963-34-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Already enabled on Arm so extending it to x86.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260812082814.27217-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index 634d5428219..1800ba8eb19 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -3247,6 +3247,7 @@ int whpx_accel_init(AccelState *as, MachineState *ms)
 
     synthetic_features.Bank0.HypervisorPresent = 1;
     synthetic_features.Bank0.Hv1 = 1;
+    synthetic_features.Bank0.FastHypercallOutput = 1;
     synthetic_features.Bank0.AccessVpRunTimeReg = 1;
     synthetic_features.Bank0.AccessPartitionReferenceCounter = 1;
     synthetic_features.Bank0.AccessPartitionReferenceTsc = 1;
-- 
2.55.0


