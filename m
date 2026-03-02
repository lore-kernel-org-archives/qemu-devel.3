Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ABC08D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:48:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwytr-00037H-5i; Mon, 02 Mar 2026 03:45:11 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytT-0001wH-MM
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwytQ-0001bZ-Ro
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:44:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441083;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=HjkgyPw4GIZy7xWS0r6nwvwf8hxxJ78+m9f+iA3D1SQ=;
 b=P/qU3DVWI/I+LotwCtnMxEYHgtJG1jzyjGHNoLOJO5BhJe5CwpcIR0bbgJoBK4MLRowONb
 hyuLwVGwQ6XIV/9acFsIOTGYaswlHHi+7CZHg4gCcIxfsL0GiQNHQRscqElYMXmUehQc/c
 y2RElVTCJakMXWzIq/VxHIPD1NBcp1Y=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-642-cfbcvh1IM3qfphLdUIsqDA-1; Mon, 02 Mar 2026 03:44:41 -0500
X-MC-Unique: cfbcvh1IM3qfphLdUIsqDA-1
X-Mimecast-MFC-AGG-ID: cfbcvh1IM3qfphLdUIsqDA_1772441081
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-4837b7903f3so52513065e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:44:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441079; x=1773045879; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HjkgyPw4GIZy7xWS0r6nwvwf8hxxJ78+m9f+iA3D1SQ=;
 b=Dre+TlMQ6fIocdTS47HfVq4zp7BwurKOs4+nUExdtwOAjyzbPHfiKU7N0U77WfK5yp
 qpkEd+VsUVZxBRoqFqjb1Cak6JkJPXOXAKZwOSzPjnPDgZ/2RiywuxvSWNBWMQo58u4k
 Q5oqbKapfm55eN5anU6fd8u3F3AzBFE7mDajdxrwJNSFZRWKz6Z/0m/ohLSsFfacntVS
 gCwY/37E6XEdsQWSa5E+XBNQfeP4aKXs+sDDhtkXnFfC1SoJzPEuu49KZmprdvN/t7FA
 sqPNbyRhQ5xS/B+vYnRetMY6aQd0JDfUAxDOfFv4GHUUdFnLjsPzVpQgIltgNzPVCA0w
 YrqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441079; x=1773045879;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=HjkgyPw4GIZy7xWS0r6nwvwf8hxxJ78+m9f+iA3D1SQ=;
 b=CipVMn5qKwvkz65/4Z5Twm3dC5CG/VlsEb2+WCo4Yd+xx/ASCOTspz4Cu3D+bUsF0T
 Z/WAkRNO34ir+z8i8IUJTpPidgpZ/TYj9ZOgZ32fAMXVTtch/zHpatWBLBN6KBAEtqrT
 tcV8G5QnuGmZtLVZarIb4/Lo33gY8VbNG3Sr8VFGsrA6lQW3GNG6tXJu567tL5pWG15D
 ldcW9eG3dBXNEb6285FCb6VnBbIK3wcqPJxQM7KfA0bn+RDRIly5cwmcCusS4CflScUn
 wPQtaydWEP+xMp6R9S0HpQt54nU7o/Pp9eHeqR2ut/iT3lgY/SY8UCEQ0tn3wJ72CqoV
 GBhw==
X-Gm-Message-State: AOJu0YzZuzKde5+j52LTWTfdExIiVSj/fpm+awX544G9NmMvUOnA/2XM
 Y596GOq6w6p8/40JVKxrD4Vm9u1uNbbmgqtzZuXd2X6JaFKi1oNOFqOOENC9f+kHQl3pD2qqjDH
 TMPt1IHOhVz68wx4UpP4/4eh6iRtmuMRF62mUSmh4Xclyr5z/NeAq+79OmLQf40VETuVopfuOD4
 G9F8Z6/rsRwKlpGPC4QEytN11VnXLqDqNe1IBBP8xq
X-Gm-Gg: ATEYQzxLxdVq7NSa9eDlTPvW7MEdbnIX090clcblbAGng8ya51MPo5Wb86K5EgWaLy1
 GXO0q5Ili7ZOGIAk/xIzgP7bN45vTGgOb3VGu5lN4N7ncRj2dhyMCU4g2Cc/33SnHoUBb8Y+H/t
 2uMceXymsvBcmRuHjYgLZy8b+e3aXrjXqSRGY6xb3yfKKLmyLfFon7E+N/nZ7GnBOdYuErPM6Lw
 W3FCzUm7e1R1sR86kStTvlpf3kBTdJEd8kl1E78a01SOywguwFn1/HQg9n/SzXKbAMDoiOVpwpk
 tK8iCbb6kf2++dJL473VMHk03XiZ6a4oaESZMQBw8eSFRqPIRbb25AVm91SzSRtpWwd/EVkGxEB
 6sZdjcB8t5lYFLfZ2p9oEXDOqyFo5jXsbam4efEBgslE07MJ6xnGhsU44rMTZb1/DZG9DikNmq3
 07976JdSjYgf7PAACPgwEPVln2pVM=
X-Received: by 2002:a05:600c:46c4:b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-483c9c2143emr191860395e9.29.1772441079600; 
 Mon, 02 Mar 2026 00:44:39 -0800 (PST)
X-Received: by 2002:a05:600c:46c4:b0:483:8e43:6dce with SMTP id
 5b1f17b1804b1-483c9c2143emr191859835e9.29.1772441079079; 
 Mon, 02 Mar 2026 00:44:39 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bd750607sm391021055e9.10.2026.03.02.00.44.36
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:44:36 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Mohamed Mediouni <mohamed@unpredictable.fr>
Subject: [PULL 022/102] target/i386: emulate: get rid of write_val_to_mem()
 helper
Date: Mon,  2 Mar 2026 09:42:17 +0100
Message-ID: <20260302084338.473368-23-pbonzini@redhat.com>
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

Signed-off-by: Mohamed Mediouni <mohamed@unpredictable.fr>
Link: https://lore.kernel.org/r/20260223233950.96076-22-mohamed@unpredictable.fr
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/emulate/x86_emu.c | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/target/i386/emulate/x86_emu.c b/target/i386/emulate/x86_emu.c
index cfa35561dd5..3aedd638a10 100644
--- a/target/i386/emulate/x86_emu.c
+++ b/target/i386/emulate/x86_emu.c
@@ -164,17 +164,12 @@ void write_val_to_reg(void *reg_ptr, target_ulong val, int size)
     }
 }
 
-static void write_val_to_mem(CPUX86State *env, target_ulong ptr, target_ulong val, int size)
-{
-    x86_write_mem(env_cpu(env), &val, ptr, size);
-}
-
 void write_val_ext(CPUX86State *env, struct x86_decode_op *decode, target_ulong val, int size)
 {
     if (decode->type == X86_VAR_REG) {
         write_val_to_reg(decode->regptr, val, size);
     } else {
-        write_val_to_mem(env, decode->addr, val, size);
+        x86_write_mem(env_cpu(env), &val, decode->addr, size);
     }
 }
 
@@ -548,7 +543,7 @@ static void exec_movs_single(CPUX86State *env, struct x86_decode *decode)
                                 decode->addressing_size, R_ES);
 
     val = read_val_from_mem(env, src_addr, decode->operand_size);
-    write_val_to_mem(env, dst_addr, val, decode->operand_size);
+    x86_write_mem(env_cpu(env), &val, dst_addr, decode->operand_size);
 
     string_increment_reg(env, R_ESI, decode);
     string_increment_reg(env, R_EDI, decode);
-- 
2.53.0


