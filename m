Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 275F1E6F090
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 14:34:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY3QM-0003Je-PC; Tue, 23 Dec 2025 09:31:44 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3Pb-0001P1-56
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:31:00 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vY3PR-0003r6-Mx
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 09:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766500243;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=zi9Y9cTPFP/vgj+iqezmt6CCctlne0VxIJRp1HznPmw=;
 b=QVfbpuhIFgdQl4wgwuTKQQAAnX6is2HCaskgY2yIYuJdef0PBBf8fo12f6gOid27CVS45i
 jUvJeRrnEB8Mez9EX5R+1zX4XZu9WCb2cPj30RlCnSAL3V6JIN8MJwMWnPr4NztdWxFp7R
 fwS8vNSeJiIAXiHIHDJUKjCZEDJ90s0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-591-eBmN_ywhNKyogKfKaqmXGg-1; Tue, 23 Dec 2025 09:30:42 -0500
X-MC-Unique: eBmN_ywhNKyogKfKaqmXGg-1
X-Mimecast-MFC-AGG-ID: eBmN_ywhNKyogKfKaqmXGg_1766500242
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8b9fa6f808cso1432442185a.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 06:30:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766500241; x=1767105041; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zi9Y9cTPFP/vgj+iqezmt6CCctlne0VxIJRp1HznPmw=;
 b=sKy59Y5dC7+yrxfqJblQ8nYLnc1nbXL44zpnapsIlf3GYASLR4SqGmfAtUMZQ5XBgD
 yaSYXhhS8W52z8UpClShwNQGhmHUGhjbt6ZuAzKstnFF9NRFVgtGLHV4j84G3Xmpdj8u
 m5He83siR8i/x5Dy34HcRcE2FVHcTKTG9Qw9FrgZ9vKY0Z3UxRmCITpKasXnAOdOV425
 I+hNMCTpC1aQGqz6PIUtDXDTrqWCF73/yaaiUl1YgX+CO1ZyLMxxl+1EicXJ81cVa4De
 FkW4AGXgwUuuSGhJMkHuh0vwrxGv/e1q3rBmueSgIW4WL2scrNirmIzOaFpBFNBDfjFL
 sBmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766500241; x=1767105041;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=zi9Y9cTPFP/vgj+iqezmt6CCctlne0VxIJRp1HznPmw=;
 b=Wxf75m5K971tzCeNd6Fv5VLp80AuMxx1J4kPwJ184XVdU15WnzZgEC1wuR1g9mBHYy
 otU5KyZRCjyajU4XCWu7lKwnnYXccY+uMHEeLmWLEcXeg9e+kaCS+8owx1fItQpIY4LD
 WWijQl1rs3OR8pJdndcqNwPSb8k+9rGVKyQ73uQsQuNMq/qQdtWVyJ8Bro7LcNtqia89
 KM/gaDC1P8D0YeztBOrKtLdr/8DB5l9LqBWqN/C3JLXj29aZtsPAmu6w2KhzIBar2lMx
 PnVacouFDQCFIfU+LABFkWz5T7vX7Chf6HlyvM3nLYcaVO2+X44ntn5Wn7ReedReYkBY
 7S1Q==
X-Gm-Message-State: AOJu0YzvGDUkXIOhTgnQgVcXLwNAANv9ur2SGdFatK64WcfvSQs2jPaq
 1FgXc2EnM0qTjsPer4bKcWf7OuhfMyO0RQZYpQqPbhJIjRR2jjMK091aIXPBm+PiacLZG/gZ4Mc
 9QXGSYDuGvy0gqDWQWgOQm1KIx9ciCmja5kGNTLAi+Qm3yGwBJKrIIKyoNX1KhS9JMpVDJkumEh
 5q+ZdHrT+/iLbyXOSU+7JsYxa1p7y4nGKvsAJmBA==
X-Gm-Gg: AY/fxX6ralQSGpcrtssg7dap86M7zkoIL5yoP03RU6Q8SrLUcXRel75C7qjKbx4c4dc
 worK56k735Vt70lgGgfpGqyRtgHAcYvLgtZkVuVg/1PZ0jMygeWKBKfu3fFXxR/9YaTcrnvoeNm
 0B0q0GO7i9boh7GwtfEF7cN4KlOwMTD8IltyBPnb6suWVXkjPEPiAhwVbSOe5nPh9Xq2aYvLDrf
 N+Kcz5BDyZqk7NAUdqHC1Lac/EZh15kYBPpBDH/w67UNwP9Y8+M+O+Nns8uBZ+AaoAOItz37joL
 qnYRI6fnXd3XwxJST012kzKMmbHMZdNSXLOy2b3gS4CWfkd8LNhgmGCsWDB+UJARRwSK/DDiflC
 Kwds=
X-Received: by 2002:a05:620a:4714:b0:8b2:5649:25ef with SMTP id
 af79cd13be357-8c08fbdd370mr2322115685a.21.1766500240850; 
 Tue, 23 Dec 2025 06:30:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHn6xigRA/tigcXQrX9DxF4E7YVSpCnsWjYCFxRtSTceB3ib8b5i2Gi4l8un5kaKYwxa8m0/w==
X-Received: by 2002:a05:620a:4714:b0:8b2:5649:25ef with SMTP id
 af79cd13be357-8c08fbdd370mr2322106585a.21.1766500240226; 
 Tue, 23 Dec 2025 06:30:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c096787536sm1096163285a.4.2025.12.23.06.30.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 23 Dec 2025 06:30:39 -0800 (PST)
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, Peter Xu <peterx@redhat.com>,
 "David Hildenbrand (Red Hat)" <david@kernel.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Subject: [PULL 31/31] MAINTAINERS: remove David from "Memory API" section
Date: Tue, 23 Dec 2025 09:29:59 -0500
Message-ID: <20251223142959.1460293-32-peterx@redhat.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251223142959.1460293-1-peterx@redhat.com>
References: <20251223142959.1460293-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: "David Hildenbrand (Red Hat)" <david@kernel.org>

I don't have a lot of capacity to do any maintanance (or even review) of
"Memory API" lately, so remove myself. Fortunately we still do have two
other maintainers and one reviewer :)

Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Peter Xu <peterx@redhat.com>
Cc: Philippe Mathieu-Daudé <philmd@linaro.org>
Signed-off-by: David Hildenbrand (Red Hat) <david@kernel.org>
Link: https://lore.kernel.org/r/20251222141438.409218-1-david@kernel.org
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 MAINTAINERS | 1 -
 1 file changed, 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index dc6235e174..2dc3625a68 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3251,7 +3251,6 @@ T: git https://gitlab.com/stsquad/qemu gdbstub/next
 Memory API
 M: Paolo Bonzini <pbonzini@redhat.com>
 M: Peter Xu <peterx@redhat.com>
-M: David Hildenbrand <david@kernel.org>
 R: Philippe Mathieu-Daudé <philmd@linaro.org>
 S: Supported
 F: include/system/ioport.h
-- 
2.50.1


