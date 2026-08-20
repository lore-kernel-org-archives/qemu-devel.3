Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BDC6CC5DF86
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:55:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5z5-0005Jf-7p; Thu, 20 Aug 2026 12:51:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5z1-000567-Mn
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yz-0005eD-Vl
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244673;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OfPTh6t9zdyti56yu2qnQYYPguSgVH4/TPG5cx8jIgg=;
 b=DgC3unSBcva3zOwIZ0AsxaJUJsXFcp5PKnUL4vCSX0vKM5JejZaeeRACx8+Ai1DxNeGntR
 GFR+hw4RUo54gsHbQUdONawvSMAEJzCMieZUmNlzLj2tRoVnEIzt1mFL9+Z/VbktrFgVl5
 /Ry9ndR9VUw00T2MLJ1SmgPLXSACreQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-Lls1y7bNO2ai8PuJis38Cw-1; Thu, 20 Aug 2026 12:51:10 -0400
X-MC-Unique: Lls1y7bNO2ai8PuJis38Cw-1
X-Mimecast-MFC-AGG-ID: Lls1y7bNO2ai8PuJis38Cw_1787244669
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4955fd77c18so154415e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:51:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244669; x=1787849469; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=OfPTh6t9zdyti56yu2qnQYYPguSgVH4/TPG5cx8jIgg=;
 b=uDwtnAFqsd4eQd4ru166vcJQsDfD9aAvNZlCSfV4Bq1kihPO7wyvnG7kGBcCh7K8+s
 z7ZOEXwsVSSdx4ucl+rlHaF6Y+PP5Y2kXqevJEo4G8gKh0+hbSs4eBxB4yV5cEqOGSUg
 L6KeF3Gva5KeHqZtxXSAf2D7G5snAZVdQ8dC9Nx3qAbvg4oHabJOL3uNy1ZL24v2jArk
 Z6xgxedmfiw32U7ZN/jutXQ3HaWAYI0c3bTfyIvrrIAc3q7twPJN8GUt+Jks13MP0Zcw
 aLp09Be6CZ3BMUwO3caDtWa+l9NcmPTAxdAK1PePOtpsvEhkJ8NOXl/Pk+UcVq0ZmpL0
 A1QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244669; x=1787849469;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=OfPTh6t9zdyti56yu2qnQYYPguSgVH4/TPG5cx8jIgg=;
 b=BjgXBW/U7p2G3Q11n8Dks5H0XwZ3sSAMVZnYz/2MaKHTQDv1fbTkM4nzWcqoutFTlj
 QauB9w976+FUvfRs/UA1N4YMgFgGtpZ/N3YUPL0e9J7uSCVFDv904bk7qt+VATUPG3nV
 CqMd1B96gnQdMl3F6amhpTVBY+PUBrOhWYKhTZPpvAywpxwskZjEsNoKwHTPxMjlTtYI
 pq10Hi4KxG3zlGzm19CpBlBoGsiz+dTKR/YvCo7pSrr3+CoCH5o6JnS8ozBHWRs+I1pF
 67SldRxmOpCNTh3ZaoPLV1GIExhLxTPO2QMWIQHKy2dsgp1OUUFVrXLjUbp7+T9zQjlw
 weiA==
X-Gm-Message-State: AOJu0YxEcDcnM6aFX2y6P3un4nk6+sPgQ/aFIq1Q2mUH+3j3oIt5721T
 euytuKkEjMhUhlAHuggrnGsj/6hR72jJraduH982f/Iam5Q1XYvOMea0qjioaLZY/xLrnz0VZr6
 R31VnN96OTNJ4sTEQnofu7KjBaaC6mf0YATQg6x5aVnOdcqZqMoJuuGP7PTM9d404qA3fxIC9W8
 iautGND9VVO07G1pFSQS38gcknCmKXcgNNeOAGLsoQ
X-Gm-Gg: AR+sD1122FF1kUv3eEyg1kqAN8UbEyjwtBaRmavxSn+0BkKqK3v3I1D06snfSkv3SGt
 6HxmrByCccyxEzuFFw51Stju5GCf0xn/NjIhIX6VkUhx8yHzywvVMHfkCztdTGoYxZwjgra5b6e
 8t6iGyFh6CSnqNEku5r0J/jAT0hlIiyDM68l9KScuJYelNz4prrab5hdYwEVa2YXtCkiUjbe1Jy
 6hD+bfqtIpmY7s+NXGCqkkUX8a6T0QLISUTQxKurBHCrCXiW2XbqcluKYUeRv6NwFK6MuRmF2jd
 8G6Qh7D8KgdinuHAszdroOafmZkvnUvEVXUltYjp9Q747hWz5B+a1CamQusUzFWVzGUeztiXS8i
 rfDBHGS7SuZ4Addesf9+xP829SazOYy4N4sjomVxggo76jPRyyov9fnaCogmHb5hbggisW5lidR
 +srNE=
X-Received: by 2002:a05:600c:c168:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-499b8327af5mr4961425e9.8.1787244669505; 
 Thu, 20 Aug 2026 09:51:09 -0700 (PDT)
X-Received: by 2002:a05:600c:c168:b0:499:7024:9d4a with SMTP id
 5b1f17b1804b1-499b8327af5mr4960445e9.8.1787244669120; 
 Thu, 20 Aug 2026 09:51:09 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa11fd3asm144569975e9.8.2026.08.20.09.51.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:51:08 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: "Naveen N Rao (AMD)" <naveen@kernel.org>,
 Nikunj A Dadhania <nikunj@amd.com>, Tom Lendacky <thomas.lendacky@amd.com>
Subject: [PULL 24/53] target/i386: SEV: Enable use of KVM_SEV_INIT2 for SEV-ES
 guests
Date: Thu, 20 Aug 2026 18:49:27 +0200
Message-ID: <20260820164957.1895963-25-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260820164957.1895963-1-pbonzini@redhat.com>
References: <20260820164957.1895963-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.346,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: "Naveen N Rao (AMD)" <naveen@kernel.org>

In preparation for allowing SEV-ES guests to enable VMSA SEV features,
update sev_init2_required() to return true if any SEV features are
requested. This enables qemu to use KVM_SEV_INIT2 for SEV-ES guests when
necessary.

Reviewed-by: Nikunj A Dadhania <nikunj@amd.com>
Reviewed-by: Tom Lendacky <thomas.lendacky@amd.com>
Signed-off-by: Naveen N Rao (AMD) <naveen@kernel.org>
Link: https://lore.kernel.org/r/f2a7778ab26b11a8de90e170ff984ccd29dc05a0.1779281646.git.naveen@kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/sev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/sev.c b/target/i386/sev.c
index 52379855b3e..9cdccc872a3 100644
--- a/target/i386/sev.c
+++ b/target/i386/sev.c
@@ -1697,8 +1697,7 @@ sev_vm_state_change(void *opaque, bool running, RunState state)
  */
 static bool sev_init2_required(SevGuestState *sev_guest)
 {
-    /* Currently no KVM_SEV_INIT2-specific options are exposed via QEMU */
-    return false;
+    return !!SEV_COMMON(sev_guest)->sev_features;
 }
 
 static int sev_kvm_type(X86ConfidentialGuest *cg)
-- 
2.55.0


