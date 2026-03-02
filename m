Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C6A5D58E7E
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:44:24 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyso-0001Ut-2h; Mon, 02 Mar 2026 03:44:06 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysk-0001Ss-U8
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:04 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwysi-0001VM-6H
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8PTQ2BRM/m3YVXHv+WYxXuCIrKW0fl7sZurT0v5FJ0=;
 b=gCaP7boVgBhkF2ELol3es5DecnpUng+HBSGeOb9FVt7E2tMRt8i/g1LZd+QMqfgjxCr8v3
 lEvPjI82V6kHNcl+/F6DAmNqcQJpDn+qW10KxMzPGI8vrP++Bapm2hwpMpGDgUYI/VzYFh
 S6Eu+B9xk51VDuOLnTrflbjH7olfNww=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-150-WUSxqJdIMGCV97DxI-i9ew-1; Mon, 02 Mar 2026 03:43:57 -0500
X-MC-Unique: WUSxqJdIMGCV97DxI-i9ew-1
X-Mimecast-MFC-AGG-ID: WUSxqJdIMGCV97DxI-i9ew_1772441036
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-439b484ee04so482086f8f.1
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:43:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441034; x=1773045834; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=a8PTQ2BRM/m3YVXHv+WYxXuCIrKW0fl7sZurT0v5FJ0=;
 b=A1OXzx/WIFT2y6WgaVEd3FuiPurIbLjl2+fzmeokalr9pxlbEuBCglkCfK3zJUSQHY
 /TPWlLzSpfXW2TFXve2rol2magvkA0LK1rZYdo59lrLhxc4+/7OLExvI+ZoqEZdbQuNn
 4IEGwNVtQqQ16et3/Tm8rrCTBMtcDppKuRAgjhxhuBwrzJwWBc3dwRw1zc/NN5c20PYY
 ZHvY8n5wqM9cjD/rgihydYViMlGi+Vr8dYLGa2a4nY8Ss6tup4EV/IUTlkTPQHhCbRv4
 ZITywyvOeAiF9xVudJqYv+rK7AydS1SqptbcsH1NRWzgDk8HFVsQn1zzNJG50RsHd+SK
 hrWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441034; x=1773045834;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=a8PTQ2BRM/m3YVXHv+WYxXuCIrKW0fl7sZurT0v5FJ0=;
 b=CbzkxcUmB5wTnQLmhjOqiwAWvJGgR/PefdguuIrtEs95y5clGrcNCjipv0HbT+4BqI
 Fkf4kxExVrM1HgyBfrMPVMYfcZW1hNuVOeftnRVte5Qbn69LqLKqLSGe9cHKZ16+IAGf
 zHK/phh6a8gSK9Uy78PNzCJAFqFTGFA5WcD6ZPPcM+1hKKUofQXuJHlX+grzG0WC+WZm
 m/qAdUjnINgd13Y2xMuSloxqM7jhpbXnucC5Fwr8tcQLAEJRwen32jepfSfA6TZ6moZB
 aULQ/AnHGx9Rew4n9S4THzJRjKbBq0OndcQaLcJaWLG9BZBkPYtvGUYqXr3i6M3hIY3m
 FrZA==
X-Gm-Message-State: AOJu0YybzQS55nfiKVLCWXukIB7cAgOcZpKPc/+UpFtMD3qX2pcN+T2f
 JAJlt0AqkR4t1xPi3NAvTphYpcWheqR0mCfEraASa+vRndNFhsly672Os3unZ0PCMriXLI15For
 i1KKTznom24R2CDwILw0heZTaFwpqaErAUTZW82u2Unhe73IdeMLOH00AnD/H0feqzR6refDjS2
 DUVM7uOiPFV/nnSTqSjN8YdRInW6k5jdWW9HCQ14iB
X-Gm-Gg: ATEYQzwrtyizTkdReuQf/IMkx8GjTSF3ta/O9I7JZJQB7IzDP9GZcMdxjMvttQ2vFo+
 DdE4hFvYKXzcsIllOxdovXU5KnJz0NUi8gDzDd/9lapTySTTK7lXB9hasCtGUNNooy5P5UzkaI/
 fF2Ewy4y4wvXVqqAna17DuJrd0+BNwp6dLAqwlQdROf3egqBpvibB0+FFecVR4U4kOyRKlQXWTJ
 LDix+9X0DejEKDyDxvyu+xAYo9A60JCMG5Q4yH/9MPM+2w3m1pjpGzjeZJ1jcvNnBO/k6ASZ6LV
 Ny5uL2woZrb+4HGUngHf6oXmcXVFMmLatZp3D4tHlfqPL5qqICpUCskSQi/DXXgoZDV1uFVk+wN
 jPairFaHbVf/0Qyc6er+VxkVe87jSrVqa6GbjJXOjn5oToxXtTBy2UKMoISwwbl2VH1BGJKR8ow
 P1OfzitgbggpH4uN1we2byHdlKfyc=
X-Received: by 2002:a05:6000:400a:b0:439:ac16:bc6 with SMTP id
 ffacd0b85a97d-439ac160e0cmr10011957f8f.18.1772441034543; 
 Mon, 02 Mar 2026 00:43:54 -0800 (PST)
X-Received: by 2002:a05:6000:400a:b0:439:ac16:bc6 with SMTP id
 ffacd0b85a97d-439ac160e0cmr10011904f8f.18.1772441033945; 
 Mon, 02 Mar 2026 00:43:53 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4399c75a523sm25581437f8f.19.2026.03.02.00.43.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:43:52 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Bernhard Beschow <shentey@gmail.com>,
 Mohamed Mediouni <mohamed@unpredictable.fr>,
 "Wei Liu (Microsoft)" <wei.liu@kernel.org>,
 Magnus Kulke <magnuskulke@linux.microsoft.com>
Subject: [PULL 004/102] target/i386/emulate/x86_decode: Actually use stream in
 decode_instruction_stream()
Date: Mon,  2 Mar 2026 09:41:59 +0100
Message-ID: <20260302084338.473368-5-pbonzini@redhat.com>
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

From: Bernhard Beschow <shentey@gmail.com>

Compared to decode_instruction(), decode_instruction_stream() has an additional
stream parameter which avoids some guest memory accesses during instruction
decoding. Both functions defer the actual work to decode_opcode() which would
set the stream pointer to zero such that decode_instruction_stream() essentially
behaved like decode_instruction(). Given that all callers of
decode_instruction_stream() properly zero-initialize the decode parameter, the
memset() call can be moved into decode_instruction() which is the only other
user of decode_opcode(). This preserves the non-zero stream pointer which
avoids extra guest memory accesses.

Fixes: 1e25327b244a ("target/i386/emulate: Allow instruction decoding from stream")
cc: qemu-stable
Signed-off-by: Bernhard Beschow <shentey@gmail.com>
Reviewed-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Reviewed-by: Wei Liu (Microsoft) <wei.liu@kernel.org>
Tested-by: Magnus Kulke <magnuskulke@linux.microsoft.com>
Link: https://lore.kernel.org/r/20260223233950.96076-4-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_decode.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/target/i386/emulate/x86_decode.c b/target/i386/emulate/x86_decode.c
index 6ad03b71b07..7bbcd2a9a2a 100644
--- a/target/i386/emulate/x86_decode.c
+++ b/target/i386/emulate/x86_decode.c
@@ -2088,8 +2088,6 @@ static void decode_opcodes(CPUX86State *env, struct x86_decode *decode)
 
 static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 {
-    memset(decode, 0, sizeof(*decode));
-
     decode_prefix(env, decode);
     set_addressing_size(env, decode);
     set_operand_size(env, decode);
@@ -2101,6 +2099,8 @@ static uint32_t decode_opcode(CPUX86State *env, struct x86_decode *decode)
 
 uint32_t decode_instruction(CPUX86State *env, struct x86_decode *decode)
 {
+    memset(decode, 0, sizeof(*decode));
+
     return decode_opcode(env, decode);
 }
 
-- 
2.53.0


