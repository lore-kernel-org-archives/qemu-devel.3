Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F5B2E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:54:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQvt-0007sa-J5; Sat, 27 Dec 2025 04:49:57 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvr-0007a9-BS
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQvp-00075A-PH
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:49:54 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766828993;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=gev2NNF2dqiftBJvy8sN3F/ml1DsaMn3F4NJUClQyYI=;
 b=WIy/KOQhejQBxU9Gz5VyyL82wOK4ePYqbqNgzMBZJfUEDTkBdGhZ4AuXyNIOwDFkCTA7Ze
 1qg0vBsRAGg+3CnpViPP16hpLzAqcJdWPlG19gAIwaFAwSOMJhvyF4aRln1fNSnFcSSNH/
 tSGYCJh/P3nW62yKqgLhJ7MJry81uaQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-kJwGelpNM8OwdIE0jJ1BuA-1; Sat, 27 Dec 2025 04:49:52 -0500
X-MC-Unique: kJwGelpNM8OwdIE0jJ1BuA-1
X-Mimecast-MFC-AGG-ID: kJwGelpNM8OwdIE0jJ1BuA_1766828991
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-430f527f5easo4798781f8f.1
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:49:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766828990; x=1767433790; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gev2NNF2dqiftBJvy8sN3F/ml1DsaMn3F4NJUClQyYI=;
 b=B6oBI3aJddpmq7kLN3eeX8Ikw6Ca5CWrCFybct/GZKyy53u6Ff+EXps3KvMYHWuVOT
 KY83YHSysu7/DOiI5HIeF2YTalK9xFZgnxKgGgbUk3Y5jaRitfOYNhwg2ch/869Q348a
 9y2Ps1xTroS8syzNapaLny47jdgnemox/IhIovlOrH+3/j7IMeBc3nYPcnqqwT2TRdP8
 +fPgXdms7IZuqQf+FfHuNY9kEYafHgOTkAQGbldzbboSK0teE90Xmv7DjbyDe3707LZY
 85ytMSDaDJY8lf7T6FHpESKsg+1KUKRIOrE4pC+dz+2MqLZoYg198Ng67Gu0NyoK4jmp
 qZ5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766828990; x=1767433790;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gev2NNF2dqiftBJvy8sN3F/ml1DsaMn3F4NJUClQyYI=;
 b=i+oJuRKdSEM/y1ZM98CD8GvjyH86+eD0ZY7EYOoOXr0gBz9g3PsAgw10HUqlL9+JSk
 bEVxqFh2DvqwWSJF4ud8BTTg1unelOeaUlFgBE33W3lNvZsE+6eHFmqGYx/FQgHDn4vY
 BSGho6Gmzhid624C3Zza6yHwNqmzBBv9MABOfjv21r6frwAxWhbM7lwsBveB1rtq3s8I
 f+u2S0wgeaLCzfijk2S71nf0jMETVbcIX+tmJw5BdHZ/e4jdRH4we5PuMOuKBFBvlfUL
 +aK3ThQ2JLuRc804Qr8PCZrswo9+EgaheLDkGJ51s0Ip0gcGuNG8dxGRsHMHzG9FK0gN
 yi6g==
X-Gm-Message-State: AOJu0YyAkcPxe1SOAoBymPRW27dpthOPDKbD/fU2LbHqGg0ClEzby3jT
 7em5bSMjdQkoMgSt7E6exbjou+lWdiksV7U6mIsAPwDALg4Iq6V+Ywkp+vUL4BgCKvpGg90bW21
 z+Dl0FD85m6qgRq2QLmTsl09IvL3OAzK8KZDmUI9+i8pwiX1hBjusvvN60Q6LvgeLInKKtN07QE
 rG294OxdTVBB2VJdnmGfNcehmOj2qbnuOb4OV2vURB
X-Gm-Gg: AY/fxX4MHNKNCudGxpYT6e13LSLIh25wHZ3n9/Kg7AOGG962oL1ezM+ANQmv7Xpux0h
 XfyaxafbLU32yg9Ij448InjZfVq5jVPogYOP8scrnuIZf5qZV4Abujsi1Z9b7w01pJWzKma4jdB
 oulqViygyx9EYEVccqGi3mp3rFvvqRr3oGGZNMf5fWxFyBzgMSOiVGq37IjIAKdk8gkeDdnzflJ
 irL/cxhmIgTiZQkeNn4RGmMGTRLUuBiLVjqdHOBnfEYpIEw7EEBDOGsYwDwNoZBiTLilGrGPoNk
 YkfntapDu4TM9k8xPdw58siArj5BDL/hySJHoqv7Uf8DtwYjX9MdTvT4763bM+hdjZAQzPyhjZw
 +7BBWFyyyp0oaQ3wlNp1CMopBv4Z4bvM5jwCrLYCGuPhc5CxWjFULRXXNfTfacLGZOJxuuDHRgy
 UYx2jLCs2p2CDJv+0=
X-Received: by 2002:a05:6000:2389:b0:430:fe6c:b1aa with SMTP id
 ffacd0b85a97d-432448c9ddemr36031553f8f.26.1766828990142; 
 Sat, 27 Dec 2025 01:49:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEleZCevkbjb051zoC+8Zgwj0IrR/HhCsUJ56HfpB8U4F03xMGoTf+8uWaRHJVjEPc+cTQaag==
X-Received: by 2002:a05:6000:2389:b0:430:fe6c:b1aa with SMTP id
 ffacd0b85a97d-432448c9ddemr36031527f8f.26.1766828989707; 
 Sat, 27 Dec 2025 01:49:49 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea227casm50090292f8f.15.2025.12.27.01.49.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:49:47 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>, Farrah Chen <farrah.chen@intel.com>,
 Zide Chen <zide.chen@intel.com>, Xiaoyao Li <xiaoyao.li@intel.com>,
 qemu-stable@nongnu.org, Richard Henderson <richard.henderson@linaro.org>
Subject: [PULL 116/153] target/i386/tcg: ignore V3 in 32-bit mode
Date: Sat, 27 Dec 2025 10:47:21 +0100
Message-ID: <20251227094759.35658-42-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251227091622.20725-1-pbonzini@redhat.com>
References: <20251227091622.20725-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

From the manual: "In 64-bit mode all 4 bits may be used. [...]
In 32-bit and 16-bit modes bit 6 must be 1 (if bit 6 is not 1, the
2-byte VEX version will generate LDS instruction and the 3-byte VEX
version will ignore this bit)."

Cc: qemu-stable@nongnu.org
Reviewed-by: Richard Henderson <richard.henderson@linaro.org>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 0f8c5d16938..dfaffec599e 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -2665,7 +2665,7 @@ static void disas_insn(DisasContext *s, CPUState *cpu)
                     goto unknown_op;
                 }
             }
-            s->vex_v = (~vex3 >> 3) & 0xf;
+            s->vex_v = (~vex3 >> 3) & (CODE64(s) ? 15 : 7);
             s->vex_l = (vex3 >> 2) & 1;
             s->prefix |= pp_prefix[vex3 & 3] | PREFIX_VEX;
         }
-- 
2.52.0


