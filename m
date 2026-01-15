Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75294D44C4C
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 13:55:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgNoW-0002JX-2c; Thu, 15 Jan 2026 08:55:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgNoU-0002IP-Gi
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:55:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vgNoT-0004sc-0x
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 08:55:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768485299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=Ndms6K63jRJRGbuMXlSEcy4hbxYjKn9uqDQrRqGbwF4=;
 b=DcgBRXxEf5+7uTowV/1YCsoVNAy1maDPoLDCx6bsAY6mMn1jUDo9xkWLH2PGScEzx4g59t
 oFj1eYtyMvTIyK3jdt7em7zqS0kI9POHcxlZ8jLzEqEWGdELZNG0HjXiJJlm65MP7l9Ssz
 ptHd1tE6xnMrAwp3kTDd1V2ApJFs9lU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-519-pptVJoZAOQ2HSjgfa4ECcg-1; Thu, 15 Jan 2026 08:54:57 -0500
X-MC-Unique: pptVJoZAOQ2HSjgfa4ECcg-1
X-Mimecast-MFC-AGG-ID: pptVJoZAOQ2HSjgfa4ECcg_1768485296
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-432488a0ce8so715732f8f.2
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 05:54:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768485295; x=1769090095; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Ndms6K63jRJRGbuMXlSEcy4hbxYjKn9uqDQrRqGbwF4=;
 b=msiZNJea/w7vKlbvEYvZ71gLv7XsMCrIR0I0BUKJREUjbLWyiSgUC4O84Zb/HiC4vn
 JVTxLsm8JgLUVIY0NwWYiDTWx1SoSXraVk2uBj+uY0FgN1gCTTpFHiQrSaE0QBWow0Wc
 9xC7+/GxswpT3vt5v0PfSDdBLeB1a5Dm4lCmdt7qAZ3euulJGpBNtJJyVL4lxAl6TUE7
 xZtQ00MgV0kOWF7NT5f6WSypgn5YokdHE255YC6IvKH7ZfKH2zIMCHqHwk+w9bhItIlb
 dBwp+Do6lpdQ+381u0tFVe2zwttNWI7MV+dNB/w5UJteyVmXZqdLeLtHCG9MTZs4hxH5
 FoeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768485295; x=1769090095;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ndms6K63jRJRGbuMXlSEcy4hbxYjKn9uqDQrRqGbwF4=;
 b=JYqVYjwcWpAvB/lHtlzG2rVXr5Mmqqv6a8gelEZtxLuNu2oauUFus/PXCWx03COjL5
 /99pz7eLRNsQajMFPzohqe6PokuGB5KVbrDfdP+14tgyKq9JHgpwBVXBLjbvOKzRtY+0
 pE0H1aP9B+u+UkGKtSOI6/1ZidLfv9E+UYGdKs1N1RDg6EqxraKSKqlSPKq8ILUEmKvT
 JB60uyer5JXHvZeoIdVIpoeyjF4OigAx6M5oMGuVfZYL8YnYSFlNRI4sXaTeRDbMf86v
 slFhOwTSSEJS3XMmiMREY0uoF5PgAc+I3UI8rTFYKRA0CLe+xi17takTwIH1KHsBmqGC
 6vHw==
X-Gm-Message-State: AOJu0YwWFEm0apGVK04cyBTFmA7iVQ2Iesna29mux9b1agutt+iPFzmf
 o+z3qbEaVrl9+TyAyGilscGbeiY9z0E40aHcTezpum3PNWSo7VaLzVKZ/76ouimCgauvC//WGAu
 6JdqgvYbRTo5ZoA/yuEG2uF5dO5MnV/34hPdZvB6NeVn3fyTjuWoQKue55l6Bo78UzA93sqv9AX
 PULeyg5n0QwR6xj4Mf98r3S3keWhPD7+6HpsSZgmXK
X-Gm-Gg: AY/fxX7Q2YkJ77EOQNsgLDluPoXpS4C9RMrLVF67H+tXgiXh722YKLupYOnQsPEtJvV
 vt/T+nss7KzQN+WlZYGa//sHzKcTzwHk884PPUVgQzU6o34Q+YgoqyZtyEMoZHy5j0XsIthyKTZ
 TmdIRCvcoTKzFgwVNDaS9fz41EbJfJCN/vqsp4sd0YD81RPH5Rq2IPN2hvxKxCOSaIF4TqWYJIy
 WKAQqGp7KnJ7h1MUG/LC6Urx4RlSJiuz/mnGSh2FP56cSOu97rnR+aShczs7SyPMCmKgOu6lAhu
 MhR30f5p0kQ1YNBOHuY6G5vXqhxMy0iguNM6rnWUJzX2Lyd+GwCRGYVer8vLNGFi6OwC7Y8bhZN
 o3QF41e3m8A9yTwQkG3MKOJsi3jPzbRFJq0dIETAcoYQds73P3929aefhJd9rZDfU3HyykNOuyI
 gwvUF9KE9qw9dMRg==
X-Received: by 2002:a05:6000:2910:b0:430:f494:6abb with SMTP id
 ffacd0b85a97d-4342c4ee90dmr7071331f8f.8.1768485295044; 
 Thu, 15 Jan 2026 05:54:55 -0800 (PST)
X-Received: by 2002:a05:6000:2910:b0:430:f494:6abb with SMTP id
 ffacd0b85a97d-4342c4ee90dmr7071301f8f.8.1768485294626; 
 Thu, 15 Jan 2026 05:54:54 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-434af6d9039sm6185735f8f.30.2026.01.15.05.54.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 05:54:54 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: richard.henderson@linaro.org
Subject: [PATCH 0/2] tcg: improve instruction selection for extract and
 deposit_z
Date: Thu, 15 Jan 2026 14:54:51 +0100
Message-ID: <20260115135453.140870-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
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

extract and deposit_z are similar operations, only differing in
that extract shifts the operand right and deposit_z shifts it left.
However, their code generation is currently different.

extract is implemented as either SHL+SHR or SHR+AND, with the latter
chosen for "simple" cases where we expect the immediate to be available
or a zero extension instruction to be usable.  deposit instead uses only
AND+SHL, though SHL+SHR would be just as usable.

To get the best of both worlds, introduce tcg_op_imm_match to check
whether the processor supports the immediate that is needed for the mask,
and if not fall back to two shifts.

Paolo

Paolo Bonzini (2):
  tcg: target-dependent lowering of extract to shr/and
  tcg: possibly convert deposit_z to shl+shr

 include/tcg/tcg.h |  2 ++
 tcg/tcg-op.c      | 58 +++++++++++++++++++++++++++++++----------------
 tcg/tcg.c         | 23 +++++++++++++++----
 3 files changed, 59 insertions(+), 24 deletions(-)

-- 
2.52.0


