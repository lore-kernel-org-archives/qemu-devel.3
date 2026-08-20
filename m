Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B166C5DF81
	for <qemu-devel@archiver.kernel.org>; Thu, 20 Aug 2026 16:51:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wx5yw-0004cL-5Q; Thu, 20 Aug 2026 12:51:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5ym-0004M6-U4
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wx5yk-0005X4-PV
 for qemu-devel@nongnu.org; Thu, 20 Aug 2026 12:51:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1787244658;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=c1K9klrhQHZKoPe0lHDf6bH+V/OALPdZXPiuQCqnwFY=;
 b=Q1fMotDnSiQRFKW3ceOfP6Kge7JjJbZK9KN/rsh0cec3vwK/uvwSMetygAucTOfG7yFNd7
 C7Ul47SW8/yeojDXcfhhcPfSUh1lo2NlnCJkhoKmyHK3VdImPvX5o23SmeeHvbNPzKpEc9
 WtHH2rzksYt1ie8VxcUqP3Wa577AvMg=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-_Vq0xYauNHua9_mk7hTDRg-1; Thu, 20 Aug 2026 12:50:56 -0400
X-MC-Unique: _Vq0xYauNHua9_mk7hTDRg-1
X-Mimecast-MFC-AGG-ID: _Vq0xYauNHua9_mk7hTDRg_1787244655
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-490a767c7dcso219005e9.2
 for <qemu-devel@nongnu.org>; Thu, 20 Aug 2026 09:50:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1787244655; x=1787849455; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=c1K9klrhQHZKoPe0lHDf6bH+V/OALPdZXPiuQCqnwFY=;
 b=j858GM7oKcLULH65WudOg4DJn0G0FasAZKemCVMAV1nuEisXChlUy8oMCJS9GGUS3P
 OALVgeXkHoEUSRV+sNPfLQCrMiZA/mnDDZ2tQMlNkE9NzRqK7BoH3ACiLjYHPhn28cTH
 5NExnTOqEoM/R7FkRCq4hIyJo6v2ALqnQoV/lmlhxj3UL5ynrdjohW9y35uVyMTZSYjD
 UFvBVbjflRcDCVf2+Mx7/6ZS3F5e3LXFST6vtXqN8sKtbzpXflM2DJdZ31KujCWgHjfM
 7EkjnmUcRIwbgPx26GCHpB5sYFAgOs+K4+MInHQ3PCtcjYMiQ04R/3aLhR/qM0+h2aUK
 w+qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787244655; x=1787849455;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=c1K9klrhQHZKoPe0lHDf6bH+V/OALPdZXPiuQCqnwFY=;
 b=EtahQwSjSK5LlOQ+noGuOLp6IOjH3m/pYtkRGkVZIFim8BNGe4as2kCpEsEXMCrmrV
 Cs7YkgrvBsESphC3RzkIyerTFJy55d/ZblE/eV/UlEUb3pdqLpghr5i1rWMTpBFTgJtT
 8GNsKirBlvfGLqNSangdYfkMb4rN39l0dkzOebvJ+NPjIywu+oAIsBuy7ig3qP8r7hjd
 3Jr7DxzLG2TQ4RxtxuYzx1G0ZITgvbG8LtdnUerxR2tWwvXg9J5NSzCilG+Jtpv5CLos
 PfL88lCqheqLTmzS5qxJAxtF4E/G+7fcyLAa9pnARAVsPU98cI9oAVB5bzov5a6SqaGa
 ojOw==
X-Gm-Message-State: AOJu0Yw+W2UthQVibuP6Df3Zl0f+/vj/o1a6HNrdHXfKufq3nnvQB2rZ
 kI/nfD92tge7WqtKqakov+v3imRCrnDvEgIg4WkFDzL3ASLg/uuFR2srRy9Cs3JiJpq21t19wZv
 m1XxOWdPuHKV3UTGYHnGAgSm5iKykiS6jJ4PqFNi5NgfM08SRu8COhsLig/ZPGZz4zHOifHcT+c
 0knmEh9WiJ3Hnz/4M3sL1MN+hrGNo9hUqRLsQuHETh
X-Gm-Gg: AR+sD11/BG+/Svho/wfDeWimBP4cW0ZxAUkxMRWgXDJ/coKWI9dO0IIQIDEwD2sHQqR
 Lm5FoF6ocRH6X2r7K4ml8WmAn07qR/ZaNg60GHf6+4QGUhwv4UqOcH7NMU1Cm7PD6gYztkBJg3h
 fWazh6iLjQYn+vYv22eL9FpQ049KP612KUQEzJsVHNNLTPtfmYVQ8k42fTF64TrYTk6riW0KNJK
 9Z7iWaPzH/ExkfdN/fi5Ey/JEVbklG82MoDHF0E6R5pK865qUAdrrICHnRr/1qkreNaXI32okOS
 uRpo06rn7JiSNbeIBHlgtageQPOkdEe4r6xvzxHt+fx96r2QncxyE6ELUjXj3p79OPAepukhc2E
 fMeowuoxg/SXtd3Jaxuht84rPkkOylMtDKJ0EhFH63CP6RuapEP5DLS8SNIRkcvhZ62d7oVf3Zq
 /1zC4=
X-Received: by 2002:a05:600c:4f09:b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-499b8455734mr3238415e9.10.1787244655284; 
 Thu, 20 Aug 2026 09:50:55 -0700 (PDT)
X-Received: by 2002:a05:600c:4f09:b0:499:ad2e:f7bc with SMTP id
 5b1f17b1804b1-499b8455734mr3237635e9.10.1787244654896; 
 Thu, 20 Aug 2026 09:50:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.34.92])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-499aa0fda98sm235823415e9.1.2026.08.20.09.50.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 20 Aug 2026 09:50:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 19/53] hw/i386/mshv: drop initial msi vector 0
Date: Thu, 20 Aug 2026 18:49:22 +0200
Message-ID: <20260820164957.1895963-20-pbonzini@redhat.com>
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

From: Magnus Kulke <magnuskulke@linux.microsoft.com>

This has been a warning before that was always raised if the machine has
a hpet. hpet_reset() will eventually result in mshv_send_msi called w/
vector 0, which we can safely drop.

Signed-off-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260710101534.664604-13-magnuskulke@linux.microsoft.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/i386/mshv/apic.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/hw/i386/mshv/apic.c b/hw/i386/mshv/apic.c
index 9188a93b2fe..ad326030bfa 100644
--- a/hw/i386/mshv/apic.c
+++ b/hw/i386/mshv/apic.c
@@ -293,6 +293,16 @@ static void mshv_send_msi(MSIMessage *msi)
     delivery     = (data >> MSI_DATA_DELIVERY_MODE_SHIFT) &
                    MSI_DATA_DELIVERY_MODE_MASK;
 
+    /*
+     * Vector 0 is not a valid interrupt vector (0-15 are reserved for CPU
+     * exceptions). This can trigger during machine reset, if hpet_reset()
+     * forces the PIT to pulse GSI 2 before IOAPIC's own reset has masked its
+     * redirection entries.
+     */
+    if (vector == 0) {
+        return;
+    }
+
     mshv_request_interrupt(mshv_state, delivery, vector, dest, dest_mode,
                            trigger_mode);
 }
-- 
2.55.0


