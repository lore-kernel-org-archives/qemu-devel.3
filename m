Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C952BD58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:58:45 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzd-0007ca-QX; Mon, 02 Mar 2026 03:51:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxI-0003KQ-B3
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxG-0002Fm-Qf
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i8hWVygGjx0fXwShEpBvbBE7gALzYMVLC51muyruEpk=;
 b=cN0lPPHS5AZocQC3+QD+821sjtFuyAMsE5XNybi3YqgTondvcj+fWPcrueByCbuON5qv6j
 oKHJeVH3OxMqON1IKhgWHAmy0JCEr2SH+5Se5dM/2K2SjbyB2zb01hWwjZSO1ANntiu9Rz
 yFYq2wqoolu3kZp9TkNvDTbUbpBK9wU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-164-zcM1cdNqNp2GFbzHdIcNoA-1; Mon, 02 Mar 2026 03:48:37 -0500
X-MC-Unique: zcM1cdNqNp2GFbzHdIcNoA-1
X-Mimecast-MFC-AGG-ID: zcM1cdNqNp2GFbzHdIcNoA_1772441317
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-439ae2cba40so1005476f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441316; x=1773046116; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=i8hWVygGjx0fXwShEpBvbBE7gALzYMVLC51muyruEpk=;
 b=WLvT1gu++Hw51Z6ufzln9Rvmq0Aqn3IgcAn2HwJmWbakcLKv99pwAU/GlWUAFLtJW9
 AanFE3N9TlY/b70sVmlRaD+9xEwEhcTIiLJ6dPXQ/y+9HsfHUNwk75cTCFU6H9SHnaAi
 bepWbGgmmfzb7V+Pt6VfKkb+uFoblZSZtLEezs8STDK4DCXfyo6whvpSfFdzrhaBvqOT
 85dkMBNFZBYm82H8KBB5D91hlYToNUjsMlMgzsXFmMUurRtrOA1NbbWYiVUUgW7Ha2um
 NbDyx8IxyCME3Ds3QDFep5NZMntkHZw2QpNpKaJc8/kyd94Eg5r0432GzZ7HZTx3NYJK
 izVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441316; x=1773046116;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=i8hWVygGjx0fXwShEpBvbBE7gALzYMVLC51muyruEpk=;
 b=uBgtMTArbKxD4fsSI34jsAs3hL4M58T3MfhrE9K3aP+J5wh2Rs7Yf7gFz8K7SDQo+B
 OQIKs239a21KB4oESoku8CFF+Sc89BApaN4PjHfCXCV4vLYVMGPiZqiNwfxguI7gwLvU
 hRJ3sfjS6v47uMdyJ/s/5BpKK0ztkUTY1YIPLnTcB9Hk2jyr+tVsJELq8rjPaph5EEV8
 bAnLFknA47/Gc6zAxffHUP5a9d1pmBj7DZxomFMEU60hK08mUny+QKxnNtmdmpbir0Tg
 44tWsiP8JHLmzblFR1BZODP1absGV4JvxpcQ/RMnxHemb+Y8JCFzlFhKbfz8YLbcJb3r
 snxQ==
X-Gm-Message-State: AOJu0Yw+Hwp3Nmcz8eMUmx+jo2w/aUV/KI/oYH4LKyIG34XnnIci9PjB
 Vfz1xBKy1XRosPvxK8ufW8c9q/oz8HRKj1DDW8wIwGolCi/1qmFZPXumWQHFrjexRveBe4d4UWh
 Db6OVjLZFPsDvu5fhM5nbL4AlVdX+1wJifJYLQmqxiaVQQTFIn0bRlOV6zCsyAr2WAtzYysyvw2
 AGrJGMQU4z6GcahXKKkQc45PQbIhrWxJHWgJhEqFIT
X-Gm-Gg: ATEYQzwchOzdaKpegb+OHRPh3YIuvik06yHDXyaf7E7Qt6PGB7PndZjOZh1ggUBpli9
 +k6Q8NjEfbzf2GLq2mBByI0NJTmY2tCEvWISbpBOabBAWTNLlkmkoEARavtmfe3+31VZK5SAtRX
 3xVVGpXDKVbYuVser90DG98/KFHxDAvJBnTbTiD/jeQrfWdb2Byo/0/ddK1NLsULpQdUKm3qeap
 pH85KmfE5WwgW17vvstYM6gMmxd8q5rEIJH+N42mgsbSG0qpEPwz0y3EJQndsOcYA8+gSJjrEWz
 PSuCAdCKklaxIdlXnk0OU4sG2QKjSN0jW9IdJNeHhMP0J6ijc8t9IYEJ2Se86lQwb1SDN4rRGJI
 yF7vDjvkoodcH4egJRkQzv1KrtJrBZoQxri4YfaWlMvuHTIxwVQYDsJfHkSJCQTELp1LfuKm9OO
 mlKNEr/5U5Mg7uG2VGVRJb4zIgEBc=
X-Received: by 2002:a05:6000:22c7:b0:439:b5d4:2497 with SMTP id
 ffacd0b85a97d-439b5d428e1mr5928669f8f.16.1772441315806; 
 Mon, 02 Mar 2026 00:48:35 -0800 (PST)
X-Received: by 2002:a05:6000:22c7:b0:439:b5d4:2497 with SMTP id
 ffacd0b85a97d-439b5d428e1mr5928623f8f.16.1772441315229; 
 Mon, 02 Mar 2026 00:48:35 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a25dsm25513059f8f.21.2026.03.02.00.48.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:33 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 084/102] whpx: x86: remove inaccurate comment
Date: Mon,  2 Mar 2026 09:47:30 +0100
Message-ID: <20260302084749.474955-18-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

WHvRunVpExitReasonX64Halt _is_ triggered on halt with kernel-irqchip=off as of Windows 11 version 25H2.

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260226181930.53170-2-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/whpx/whpx-all.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/target/i386/whpx/whpx-all.c b/target/i386/whpx/whpx-all.c
index d98619facee..cfc63065807 100644
--- a/target/i386/whpx/whpx-all.c
+++ b/target/i386/whpx/whpx-all.c
@@ -1663,8 +1663,7 @@ int whpx_vcpu_run(CPUState *cpu)
 
         case WHvRunVpExitReasonX64Halt:
             /*
-             * WARNING: as of build 19043.1526 (21H1), this exit reason is no
-             * longer used.
+             * Used for kernel-irqchip=off
              */
             ret = whpx_handle_halt(cpu);
             break;
-- 
2.53.0


