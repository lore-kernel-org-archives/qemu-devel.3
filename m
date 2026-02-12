Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 636B5EE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:49:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvc-0006dW-QZ; Thu, 12 Feb 2026 09:44:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvT-00061d-HA
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvR-0006Gv-JI
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:15 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907452;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=h7mzYSXU/d7IGRVFubgbC3pj3BXXtorod57WfcEtQGE=;
 b=MMXSVnnwDRWm5v+6J/PJ3toh2D+7Ws8mjcwmBRyl9wpNzRUvp2UWTXtqMn6muDtgqCyVmC
 PAApJMjegjb6HQxacGnqnN5eTSjenSLFkWOkVdB1gN/HvhBA0SA7h5mFl+opJEARmwO7Us
 kNVgqin9HQRFebCkx2FZaOz0XpxoWXg=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-593-qs4SU57XNuSYKEhwVNX4Yw-1; Thu, 12 Feb 2026 09:44:11 -0500
X-MC-Unique: qs4SU57XNuSYKEhwVNX4Yw-1
X-Mimecast-MFC-AGG-ID: qs4SU57XNuSYKEhwVNX4Yw_1770907450
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4376ecafb7fso1824749f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907450; x=1771512250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h7mzYSXU/d7IGRVFubgbC3pj3BXXtorod57WfcEtQGE=;
 b=CEXLtdrpoP1iFXrARAN5P5MppZfeRDgg5vG/p4pSzREEclFELWgUcu/lpYfvkEBXTW
 eIkw8STB4fuMuOYqhEF/KsqiVx71Vsz9T4Eopa/4fXgltm0kC32su6gIOZHqXH7QxsbZ
 MWcq6GYqPrkDbe0rLFv1S+dTXPPkk/5QEivjdViLGPWnlVdfvWCU7pbpih274NccVw3/
 E3PD5FmAnihMwWyM7TkzYtIazF3KM9R3XInDKVth3Dz4Kq7+mtjgtos1saZ0+kxzubEk
 H0Yup4qI0r1I7EkZcJJstGqXQ9WUj3te4D2i6vG09wU/annsDFC6MDMjQZs8IOxanq38
 7gfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907450; x=1771512250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h7mzYSXU/d7IGRVFubgbC3pj3BXXtorod57WfcEtQGE=;
 b=aVBfLncGpx0G8zO/QJG1/qH5EB5O6uQkVA6JLAJ8BpCCzXfaiNmsiGZ2gGiTWTBLgG
 FM+z/eWL+A+FCjlEdIV8jvqrrD1ApBUv1N+JPA0payoIM/iAZet9A8onrqOA97gfHZjB
 r4YQrYclIaJXdVYngnmZSdzmW1VSO549t6PCMLJQSRXBKC92062LzLO4jyxqfTO/6zWl
 kvgEbm9cYYRTI9WSvKN1U3WRmATcbm9Rx0UvQE0NBffeViVpqxGBNe7JToka8ESnx8UX
 6FxxbdZKyMczLmhiiTKZfmX7KU1JSnbCH+dcg46gJBvygKA6uqkU1RSt0gBjXSX0miga
 P/cg==
X-Gm-Message-State: AOJu0YzMfvBHHStZ7gypxMvI6ylvURz9gXGIqReI7bzPAwaurqUcBU3o
 9zgzifSx3dTym+1xlh9PY8W1FXtJ6TGdVUNCdEetKlrTkO0ShDBAXHiyfac2e0cKTKuVOBvQiI/
 Sc9HTyMvxf44mQGyWjjHNdQWqywZ6cemHORFsiYp5ohyp4K0VAfNdhXAgBCEaNaR+1TufoeI6Y3
 AW8gZ8g3UrUdjsuxeoajoIDgz1fp2O1hhgjM/SI5gs
X-Gm-Gg: AZuq6aInDvQAxPAIK78ihLUlPUR44tgNWdQPO6sAAvPUlv71UalhvjRkSnjYIHoYno/
 oN+epZGIs9yI2JwQSWnOT2Z7LEkcPew/gXGiO7JtvikdpvTg2TEmk9I8mDqemzUHV9JpmjNvAWq
 Uz1pm9pJgBnBet+CGe4ZGiu6i+osNI4lz5/GdeXZnhcqEqSHXIDXE3MZw1WA5oyfZPhNdX/PI7+
 ynFzAEc0LAL4NWdBFexs+Yo5EunA6B8MZzytCY+X49/O/LmuK91AzsVxdAdAsFdel8ZrFNlSpn+
 hggu9gUAj0tlx5eCpZUxy9Wom/Mll0SV8oNNXAEeSjBlUKQ5lEUmmXgx/cFHPd3Z700EigROr6F
 vPzC1zqQ72EEedICqcx5ztjswtJdjLLStM2HSG2VWMbZaH3n1dR8+mYquT+j/bairdLc0vWS1QZ
 n4U6dlMee+E0m6EBugbttKN5TALsGumngJtR/coVgh9bpBRvVcRMc=
X-Received: by 2002:a05:6000:184e:b0:437:6c2b:2f47 with SMTP id
 ffacd0b85a97d-4378f112ee2mr5111026f8f.11.1770907449765; 
 Thu, 12 Feb 2026 06:44:09 -0800 (PST)
X-Received: by 2002:a05:6000:184e:b0:437:6c2b:2f47 with SMTP id
 ffacd0b85a97d-4378f112ee2mr5110874f8f.11.1770907448339; 
 Thu, 12 Feb 2026 06:44:08 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783e0196bsm13502245f8f.23.2026.02.12.06.44.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:05 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 36/41] qdev: make release_string() idempotent
Date: Thu, 12 Feb 2026 15:42:38 +0100
Message-ID: <20260212144244.22579-37-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

So it can eventually be called multiple times safely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250429140306.190384-2-marcandre.lureau@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260108230311.584141-3-csomani@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-properties.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/hw/core/qdev-properties.c b/hw/core/qdev-properties.c
index c2e3f0543fd..ba8461e9a42 100644
--- a/hw/core/qdev-properties.c
+++ b/hw/core/qdev-properties.c
@@ -551,7 +551,8 @@ const PropertyInfo qdev_prop_usize = {
 static void release_string(Object *obj, const char *name, void *opaque)
 {
     const Property *prop = opaque;
-    g_free(*(char **)object_field_prop_ptr(obj, prop));
+
+    g_clear_pointer((char **)object_field_prop_ptr(obj, prop), g_free);
 }
 
 static void get_string(Object *obj, Visitor *v, const char *name,
-- 
2.52.0


