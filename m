Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19AB4F99368
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKn-00013E-Ad; Thu, 23 Apr 2026 06:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJs-0000bg-O4
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJp-0005Vg-Pi
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:03 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O/bgzj+cBYzib+ZwvZuAeH+b8dmvXBVQIfVS5BqtNx8=;
 b=ipXaEupIMA4otQsdm6y50Z+OG9yTBXuIIeO0KeyQabDlqi+y+OOeWBwTMz4+NRgMM3Loxp
 HFVaBD7IbZCkRgvqav8f1fWwSnoZyGmPaIvHz1/S1rry4AINGL+m4TFoEPA0tsX/vfOfOk
 XskFKt/aWl8e3r3249NwZWSPQpigcV8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-549-3T8SnFItPgOMS_JBTPQM-A-1; Thu, 23 Apr 2026 06:30:00 -0400
X-MC-Unique: 3T8SnFItPgOMS_JBTPQM-A-1
X-Mimecast-MFC-AGG-ID: 3T8SnFItPgOMS_JBTPQM-A_1776940199
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-43d7757463eso4263767f8f.0
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940198; x=1777544998; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=O/bgzj+cBYzib+ZwvZuAeH+b8dmvXBVQIfVS5BqtNx8=;
 b=WK+ORbR8Mge7X5nhIDXcob8WYorZB44VvSxO69Bvmy9EGQVXbBcTKVAffhdQH1VArC
 tZ0kAj7hR8ArsFTaPAyLhsUVaWjQ1L4glhAjUEwRiss4oUAARXeWimDvQzUKMWNpriPt
 FWdyv62AbKcjgRlAQ6N+z3F6H/r98KTSOKLL0CssY3rmSqPz6OnMMOo4DPh7ttnvxiTm
 PkUoBkXAHBnFuVIjdF8s3dSgBnxLlgOgaVg+0zz4LVMTViNIEFly/l822rjlUnj4zY8b
 N4M1CTK1cImGJut/UoAUr8xsmLqdFKnoRBFX0hNem4+6Zmzjcs3g29UPacHac+Ip64Va
 9a3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940198; x=1777544998;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=O/bgzj+cBYzib+ZwvZuAeH+b8dmvXBVQIfVS5BqtNx8=;
 b=XdswzJxz8fLtEgVQMTm+BX8OCAzJLzajRu4QgWFraY2qmnSxMjf506y10yi0uVj4m4
 pXZdwnRYjPuSr1A/JdUrH4uutnAcjwIT784ppbAvzvdbQ06R1Dwh/R498hQpWMpJO5n1
 X0OkipkVgCKt7S/nfyxPj/FP5xxYtMhWAxfXdOzEyXWZ/qfJz0b6UF8b1lUzjwOSScO0
 GKR9SyXH7tjdiUIn8qR7BLWxa5arXKJomJXCQJnEY1jpEFZMOxKd5SKynfuNuXPPvLrG
 pp1cqvuhFe5X0iU+WS2qRUR6VgbmZRTEgOXzTW/mcKIP9PDiDxyL8kBwlGHAGDiBDnFk
 yZSA==
X-Gm-Message-State: AOJu0YyVx//5b8IbVbOqNmELTH+vgzhd3I//Bma1hRx9E1aJwEyiFYyf
 D2S1Fdtffj6LZI41+MX87RFVaGRI5iHUCrib7ukLiMb5LTYzgwpuvC8MxWafnp3sxnUPANF95Az
 jInZHyHMIK2The6MrC6LJEQo60hb7dnASaNfXw7rr0dV6Hh4RHUaSPOx61R8pUJwzhghwdhyobf
 em86QYAAAUYqtMKRSggzYsx19HRyfPPaPx3pCLEUhy
X-Gm-Gg: AeBDiesP6ZGblTor1ZrKbvoygWuJvCLwza4foHE0qii6WCLo4/hZqGTNFO2M84bq0lA
 jZ0IGkNl7fmkv4nglOX5dcu1EvsiI108rjmZtmdUklcO/gsJIqevMEsbDTD4YLpmWoY632yAMAs
 uXgZp8uF8xTrvG07nc0S84uQkJgTFtSAkDL3cGJVlsd/waxIUr0q+T/GRm88EwY3CLueyYpmvtx
 Bhk1C77vsR47c+IzBpB/V4kaxlKSV7qTRO0KPy48eas4939FFP8ejHTQCkW0lGmoQ7PX4PcnZTi
 23dGnr2Y1u0++9408eMenE9JGtYFJWvnsEWgK4Zn9ObquQnPG1sFNfOX/tMm0V1xLWcdpUSrQwq
 ZAwIFEmBJJebzhTf0yEDc3vPBds/JS2hcdxylCiZbu49rXZ5m+91E43vlFUc8LrMDSzPvEWKdNh
 G04lWD2KVAu/Y0oMXUkFENUm5bQaaT4Aevusw=
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48a53cb8949mr138056665e9.14.1776940197839; 
 Thu, 23 Apr 2026 03:29:57 -0700 (PDT)
X-Received: by 2002:a05:600c:a305:b0:48a:53cb:8604 with SMTP id
 5b1f17b1804b1-48a53cb8949mr138056365e9.14.1776940197330; 
 Thu, 23 Apr 2026 03:29:57 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc177dafsm625788495e9.4.2026.04.23.03.29.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:55 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 12/25] hw/ppc: Use glib2 instead of strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:09 +0200
Message-ID: <20260423102922.443639-13-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-11-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/ppc/spapr_caps.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/hw/ppc/spapr_caps.c b/hw/ppc/spapr_caps.c
index 170795ad6ad..f4a26a85b50 100644
--- a/hw/ppc/spapr_caps.c
+++ b/hw/ppc/spapr_caps.c
@@ -129,7 +129,7 @@ static void spapr_cap_set_string(Object *obj, Visitor *v, const char *name,
         return;
     }
     for (i = 0; i < cap->possible->num; i++) {
-        if (!strcasecmp(val, cap->possible->vals[i])) {
+        if (!g_ascii_strcasecmp(val, cap->possible->vals[i])) {
             spapr->cmd_line_caps[cap->index] = true;
             spapr->eff.caps[cap->index] = i;
             return;
-- 
2.53.0


