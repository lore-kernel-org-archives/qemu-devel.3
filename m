Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F576FF8873
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 17:29:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIV8T-00023X-58; Thu, 30 Apr 2026 13:25:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV87-0001cD-5S
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wIV84-0004yw-JT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 13:24:50 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777569887;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kGcNGipMDv2VbhEQgYnig4nrprd7fxf9TY/U3ZsJlaQ=;
 b=Ax4Vh0VruCzngvOy0gSvTN6i+etQ4uehxanebvjFNb/daaJvLCcKc2xpEKRAYFsPoNxWvH
 sOZ7w5JHxenNfUl4ZO/ZPt9hokSfHuYBSnhkBqzJoOlxuhUSM7bJ/L7iDKxdQlCgUiqjR3
 yJy7rbMvBmbgC1T6IAcYbYPnnUSLy0M=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-dAuatizFMDGLb5oe1hF5cQ-1; Thu, 30 Apr 2026 13:24:46 -0400
X-MC-Unique: dAuatizFMDGLb5oe1hF5cQ-1
X-Mimecast-MFC-AGG-ID: dAuatizFMDGLb5oe1hF5cQ_1777569886
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8b0312bb1dcso29653776d6.1
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 10:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777569885; x=1778174685; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kGcNGipMDv2VbhEQgYnig4nrprd7fxf9TY/U3ZsJlaQ=;
 b=a26JgAXkKxDxbx7R3q0xkgKg5G0Ct+mY9GT4IpRb9cqyJa5C7meaGWOWJiBsyhrtv+
 7Ez7un0+bYkfksRq3H9bbWPKlRK3twPmVcjwLh9Z+9TNYnOl3iozgKsAYUIP2cxLZ77H
 ZTP8ne4ReVsKCLf6j9Hd8qcStz9v/FMSEZ+1SLFhO/B/5I+eNfBRtaE/J14PwXRNUn97
 uGq1uBkFf3vGyaCyNnFXrcpVDdC3/HXawAtQYH/NZNn2FFxDtkYcgPfiP3anS6Kb0D+I
 pwypPy9ym5lME8Y+sjT1zOdzOzSGdIammxmfDzW/TL87YFZIftxONUk8IScbqy4upcZb
 eCQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777569885; x=1778174685;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kGcNGipMDv2VbhEQgYnig4nrprd7fxf9TY/U3ZsJlaQ=;
 b=rf+5lHn+UnQaX5mq8t5CNUgHSlEJvvDwDCIyBN0I1niHXSJ3CbMUA8G3tjOqiy7Tjg
 SQRJqhxComPdov6l1yHXkPbNqQsb4DgOdtpbgCGMpU30G4vUZMDKDvS5ExA3ETa8dxpV
 0fxXuJavnOCC7Mhjma4bwEbLeOZ9xyPyiMHHUXFgL6ra+JGaWNYUBHmUsqucKMVyWRnA
 6RVZDbRqpv1UaR1LOV6xgW9qGWkSWdB12oNnt5msKiM0++STuaKPYqMNaTkaWOhIl/PW
 l+JnqPj4uUe1FEgqW8tTu7cuvnu6/pNrXZaVFvleXWfBhlKdYVcobrFrBXDY1ko5xDQq
 Mhcg==
X-Gm-Message-State: AOJu0Yx2838Oaro0A4GZF6fpWZMwCGtA+txNy4wBS/FU8kl2YUZFwuov
 8zWtkhMM+aOzWf35O2QpwUqI5lZx6fJ6H08yluPt1benfeF5yfcPX+z+XQlNVPseSkFTpwBffc1
 C4FvuzjZf/UrFIQFdk/hMMV+x3xPtMi2IVg/7HuyZa2oXcyMNrKD/kWy+iSA16fC/DKbq0NfqLY
 obYzWdSSEy+0AmHZozEySWsWWKACC6qrsGv8MyvCY5
X-Gm-Gg: AeBDiesLcg+oXcb2qIx2R7k5M3gd2scEno07OSOQxZ8KYgvBcynzE3P3HZgEFF2Xtss
 g7AT37DvFoiMPF1r9CVeb+iKEzh6Hufuo0yF2gahvnhHsNAbhHv3rc9eXGLlAiktPPMlFg2Zqw9
 4d+B9dnOyWPx0qX3qMkRbt5CoxcQzvv013Vf7rSm88ET4uPtUSY/+2KP2rHKzY2NU/UfKD7OP+c
 35yg1uD7/ese3BbTEL801UForzz53w3xYxjS2GZwCIoOBEgTDsAXSQeoe+p1rt07rHcazykBI+A
 Yn1pXXHA5ngBv63UFJKEUA2vxwrnwodlVrmhOxjSYXgsCmhbOSs2ZbeNN6C5lUgvSMxEaZjKKfr
 WhJ87aR/o+8EYpi9VZlvN8UjgKskWw9nnd6HgkB5r0rx8BuX4+QnNLHuDBGN4sBNlvUSv9Mxwg3
 y6iaxVJck4P17kSDmBlY+FkdrnkLDwlxu27Tk=
X-Received: by 2002:a05:6214:c4c:b0:8ac:a611:740e with SMTP id
 6a1803df08f44-8b3fe7f45b5mr56487146d6.28.1777569884995; 
 Thu, 30 Apr 2026 10:24:44 -0700 (PDT)
X-Received: by 2002:a05:6214:c4c:b0:8ac:a611:740e with SMTP id
 6a1803df08f44-8b3fe7f45b5mr56486536d6.28.1777569884440; 
 Thu, 30 Apr 2026 10:24:44 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ff47571dsm22966516d6.43.2026.04.30.10.24.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 10:24:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 51/58] target/i386: make xsave_buf present unconditionally
Date: Thu, 30 Apr 2026 19:21:57 +0200
Message-ID: <20260430172204.1006673-52-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430172204.1006673-1-pbonzini@redhat.com>
References: <20260430172204.1006673-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Mohamed Mediouni <mohamed@unpredictable.fr>

This is necessary for the xsave_helper helpers to compile.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260422214225.2242-28-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.h | 2 --
 1 file changed, 2 deletions(-)

diff --git a/target/i386/cpu.h b/target/i386/cpu.h
index c14237967b5..2a6c54dc293 100644
--- a/target/i386/cpu.h
+++ b/target/i386/cpu.h
@@ -2270,10 +2270,8 @@ typedef struct CPUArchState {
     int64_t user_tsc_khz; /* for sanity check only */
     uint64_t apic_bus_freq;
     uint64_t tsc;
-#if defined(CONFIG_KVM) || defined(CONFIG_HVF)
     void *xsave_buf;
     uint32_t xsave_buf_len;
-#endif
 #if defined(CONFIG_KVM)
     struct kvm_nested_state *nested_state;
     MemoryRegion *xen_vcpu_info_mr;
-- 
2.54.0


