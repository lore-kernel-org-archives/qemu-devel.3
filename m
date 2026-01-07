Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C781CFD652
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 15:16:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdVF3-0007sK-1K; Wed, 07 Jan 2026 10:14:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEl-0007lG-Oh
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:15 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdVEe-0007NN-IK
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 10:14:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767798847;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=3WdHM6YG+d2y1FBwyt7qOE/5/Jojf0hbo+ugX7VBfMc=;
 b=eqb3bw68d/AbHZ67YoYVBwiZU9svmuqO3pHhd2PdidCBKr66XDA9MUL3qPQrhvspn55zoc
 D0jvtopVistyakWKLfFYJi/1eCQ6680N5efRzK0PCb/xp30PvJ+OzbAn0ZrVdf9u8tRPHP
 e1tmOnlWw+Gcft0CwpKh0ekpHH4rAD4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-648-RosZzTafPraFXNy2LzKq2Q-1; Wed, 07 Jan 2026 10:14:04 -0500
X-MC-Unique: RosZzTafPraFXNy2LzKq2Q-1
X-Mimecast-MFC-AGG-ID: RosZzTafPraFXNy2LzKq2Q_1767798844
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563e531cso13850515e9.1
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 07:14:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767798843; x=1768403643; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:from:to:cc:subject:date:message-id:reply-to;
 bh=3WdHM6YG+d2y1FBwyt7qOE/5/Jojf0hbo+ugX7VBfMc=;
 b=EUy4+Nkc8UsMMz8ID0YNEUU9e/my2LGCBSdVZICYUtuMZNfvxoZGLWvco2xbYmtlxk
 nEIUI7MPjOpJv+SKBWMEgzVMijOenCGJUKW5j31pHDt1Mlg8+kxgbTWHHspk3V5r7Q1S
 KvhNcxN64RnKzezYn2TgnZ8U1ez+Apu+HpN3q4MUNO/YI3JsY059ngGY53NpSsuNu2vS
 AO8zgIOShfNtRcV+jtfUntlneitXM2nogk7992SRFGGvWn2Ndm814Ok/PWaw8kwrByG/
 1tWjO8zmpMIChXJg6hxnB01jwRK98rn1+xqiteu+jCwpMzOJSrhp9kaNjyMn14Q0cGvp
 TGdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767798843; x=1768403643;
 h=content-transfer-encoding:mime-version:message-id:date:subject:to
 :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=3WdHM6YG+d2y1FBwyt7qOE/5/Jojf0hbo+ugX7VBfMc=;
 b=FJhwCYsxr9nmZ67ZjEEnk0VxKgxb/++ARzCNLI58tcukNnn/bOxAEvJDK2TzTIwk7b
 +uFWH15EshlLMiyxKZy7R/LBB06OpF3RIdV/QW1HxAKRBjtO+mIpvg5AfL/L3oEPicjt
 BhU5z0GRMbSOIPNMrtdaHyuWemzxe4G7qkDxZ22YfNVyLmj4Sxj7VVikL7uvmhbCxXrD
 u3jYfGEwsa5YSOq1pg4MujPriuO3CJ/+WSFnsn2Q4v3Mux9036lgjvfHBxVjlzS01nDG
 r5s7spqML5Y9YsRPvKuJk0tRTMBbdQD9Q0729o4VJ1AJsXne6JFVERqBuFrCBsTOEnHU
 b5hg==
X-Gm-Message-State: AOJu0YyNT1UujRF19bOQroqnZTgD8+FD/8Ihs6WgLWQ0eXvdA+ZXj+8h
 /JObrhmEympYezrIGBHZn/S4Hez4dO5kHG1GGNDjq6tQNzCUS9phaRJdQCrUkAxIn1SKyYEQgM3
 aDMKoB+SAdW9qpn99tk09nSa81i3yAj3acjjgrGSa276XWixn5l1RaHyzQRai8Ah/YN+iBrPxX5
 gR835r8RAV6W9Z2VClIiMrSRX1+OD+MW6CfospXBxC
X-Gm-Gg: AY/fxX4pNzQoEGRfCCfuRfXpfK9IOcRkuU/WL2nSyOcdfmiB/92/SAGrbxWk0Or9w05
 jq98jvg1r1RX6jH4187orhukcuq7I/P1HEM4ycuNyQflZM+m4jhUoezlPXP2T8VvmVDSkALr/vT
 DsV9GMHzlCA2smqhphdnyrfV4W6XWaMdcBhkPXf2sOQ2I0BKeH5/ojUzb8bEVpb29KL6vYFzIsZ
 iFf+YhD63NwW0FcJPZFr/x0hRCuHF7J4C+qApSdW2LdqzlA6bYXuIx2lGY6wmemlg9lrRkA7SQV
 dJJFoeL21xzjNqTaPIEcVU+bEnV2MGp/JZVtG+rwlIfZ96zVuwUajEOSm3S9YCc41gH/33kEng0
 2Ix6de/Zgmow95hyIvU6lCJTkZzsF2QVIsg6ZTzZomwH8GDeglVhk7y+5LYHaePu+QAunCrCkm9
 Xqu+UZdkFrod+r5A==
X-Received: by 2002:a05:600c:6287:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-47d84b17b7cmr34245745e9.9.1767798842863; 
 Wed, 07 Jan 2026 07:14:02 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHpGtO7Yn9b3S4PfQt6QhO4a/YgWHhqGrEQ6xUmMm3UbodcsLnhlbaIYdCWgiml8i0cqkAj/g==
X-Received: by 2002:a05:600c:6287:b0:475:dcbb:7903 with SMTP id
 5b1f17b1804b1-47d84b17b7cmr34245455e9.9.1767798842434; 
 Wed, 07 Jan 2026 07:14:02 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f653cd6sm108283065e9.9.2026.01.07.07.14.01
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 07:14:01 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 0/5] target/i386/tcg: more fixes
Date: Wed,  7 Jan 2026 16:13:55 +0100
Message-ID: <20260107151400.273916-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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

A bunch of fixes, coming either from earlier reviews or from code inspection.

Paolo

Paolo Bonzini (5):
  target/i386/tcg: remove dead code
  target/i386/tcg: do not mark all SSE instructions as unaligned
  target/i386/tcg: mask addresses for VSIB
  target/i386/tcg: allow VEX in 16-bit protected mode
  target/i386/tcg: remove register case from decode_modrm_address

 target/i386/ops_sse.h                | 16 ++++++++--------
 target/i386/tcg/decode-new.h         |  2 ++
 target/i386/tcg/ops_sse_header.h.inc |  8 ++++----
 target/i386/tcg/translate.c          |  3 ---
 target/i386/tcg/decode-new.c.inc     | 20 ++++++++------------
 target/i386/tcg/emit.c.inc           | 17 +++++++++--------
 6 files changed, 31 insertions(+), 35 deletions(-)

-- 
2.52.0


