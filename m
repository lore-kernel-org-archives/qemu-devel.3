Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AA8FD3C546
	for <qemu-devel@archiver.kernel.org>; Wed, 10 Dec 2025 13:17:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vTK4G-0004pX-6x; Wed, 10 Dec 2025 08:17:22 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK49-0004nB-Ia
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vTK47-00033N-Oz
 for qemu-devel@nongnu.org; Wed, 10 Dec 2025 08:17:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1765372630;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hSg+oVCV3IdL9Yy96Y2wTbbdhygKLBdpYIrlT47bwzc=;
 b=ST1H0XfH1sVeZCaZ9t6S5zKwDd5/HoBpb7s3DqYnFi1RYi6LEiCgBxC8tjPV2wDqlXBwTu
 lEABV7QUvowYriJWfk6yEhutOHWME5zY8T+cqO+DC4WRPmnlrtsY7ePrMDLYDTgLlLCrbp
 qeAd1W9iVKVGqIjmlfCE0Js/J1Lhwf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-269-RoS05mViMUSKph6H-VaGDw-1; Wed, 10 Dec 2025 08:17:09 -0500
X-MC-Unique: RoS05mViMUSKph6H-VaGDw-1
X-Mimecast-MFC-AGG-ID: RoS05mViMUSKph6H-VaGDw_1765372628
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4779da35d27so66310935e9.3
 for <qemu-devel@nongnu.org>; Wed, 10 Dec 2025 05:17:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1765372627; x=1765977427; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=hSg+oVCV3IdL9Yy96Y2wTbbdhygKLBdpYIrlT47bwzc=;
 b=oZ6YRbBQDF6ntzIdCLHxp9Dt3RmwGeKlE8+2T90oczpKP/l5sUfRnqU0utk4Dg2xV6
 vYAYQjKFY2rNZ+Ql4Hevf50ivh4vGl7G6Nr9B7ivQZoq/ywG+Q8f82hCkSGZepFWD6i1
 G5S3UzvmUIv93iMM63VP45b87m0XRDQBWB9V+39fGbekfZxBgwRjjGb+oe0jmklW0M4x
 NDLyd/58JZcEdi0uMnHg1Asmsot+5gHSEA/xhGSs0u774FuLfFwCVwhGNUowi7SdHytn
 vvp7VXVNcGkbFsI31BvGiMGu1s0sW0dlTazrkChyfKa21Wy2bEEuimXoY3yOXmH68Mj0
 5SyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1765372627; x=1765977427;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=hSg+oVCV3IdL9Yy96Y2wTbbdhygKLBdpYIrlT47bwzc=;
 b=dIUHiYZIyFkkH3xdOHEMFMQjXzWLsvZ13k2sWL0mETKfAo4glO7bKNHVI+0trDngEt
 HXpU6QTrJeH0LDRQ2KFOAf2UBITUsmx6F+/rD9Ex21ZzJuiI2cTsjuJWntHBVdd+nFPx
 sjVIRgxXiqt6hZquVgA5cX4yMqo8fJV35zZkbv9LISkxLPtCyYXt/Cxk8uLOUtwagSb6
 FYldF0KVV3BnyVwIIYVH9rNRUqxmW7nFtEBmYqH/TT9gdfTx4unGz29S1xn0qR6Ra/B3
 ouFqLi1UOS/hEZ56ZBF7oy//PWoJWgFLYImQFNv/EqSxeijxwiEQZwZrZKp5jYuK17aV
 QO7g==
X-Gm-Message-State: AOJu0YwQiDTT58AYrrzO1dKtChjGnWl7J7O1dAlAgFiGY4BLJapp76w7
 KWZhnNLHXvG6Rm0sK8BtnW7kyx+CuCvH7uAudmbgmaTiYPHxiUelop87Y3Xb3WyM3RCMMTWivEp
 GexUvvG+9h+AaHc526opBs3GO+/HgZoV6bEFzbGBGLtNPiFAWEr+6S/KsvYw0wCLN/XIzoYUhw+
 N+Fy/yvUjDoTikQ84Nldk4N17zHjtZBtripUPxGuzR
X-Gm-Gg: ASbGncsHhQqZW2z8Xw/z6lBDMnNnAwykwF7DAEUvcrogLsqsF90IofBWOn9p6fXz1/C
 Yqwi3AlJUtqpyfcc9V+IMIzDzCslkNKCzbW6C0/cg45p2lHjFSRHEyvhXwnmnVSzu+mnXYhz3Z4
 +aAlkeu7wU6PR8gjFSqBPZkpQKnfAaISBTtVgQI+CbqF+LSn3CSRxl7g0a6okkrxMQpDk/2jQ31
 FUqvGI9qMEm95sP4dE3Nkun2bTz2qOtuj8is79rL21lOETEPQN2mhJuWo6cudY3Z8Q7ZnDCDnrY
 MmJelAkinKqDr1rgfwxzvLLdtjX/w7p0Snqxjots0fXen5rUfD1HzXFYBGN5VUINrluZjPnP+/9
 5m5MkZC/6kHJAMQKQQEdGVYali89Q3wIQpI+RtPIu1+qwADD6F1sFmGwMC0IpyfTaOi3vKBckD5
 ov65uxeTFJr3DplXU=
X-Received: by 2002:a05:600c:4f84:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-47a8384334emr22469045e9.23.1765372627397; 
 Wed, 10 Dec 2025 05:17:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE6CL8hKQP8sIHl1dR31fcuE+BwKGjkeoe8gRBLjlPYBwzNZBfjYuk47Ofwa14pinYQVAGwsg==
X-Received: by 2002:a05:600c:4f84:b0:477:7a53:f493 with SMTP id
 5b1f17b1804b1-47a8384334emr22468635e9.23.1765372626928; 
 Wed, 10 Dec 2025 05:17:06 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47a82d7f778sm52576995e9.11.2025.12.10.05.17.05
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Dec 2025 05:17:06 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 06/18] target/i386/tcg: remove do_decode_0F
Date: Wed, 10 Dec 2025 14:16:41 +0100
Message-ID: <20251210131653.852163-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20251210131653.852163-1-pbonzini@redhat.com>
References: <20251210131653.852163-1-pbonzini@redhat.com>
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
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

It is not needed anymore since all prefixes are handled by the
new decoder.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/tcg/decode-new.c.inc | 7 +------
 1 file changed, 1 insertion(+), 6 deletions(-)

diff --git a/target/i386/tcg/decode-new.c.inc b/target/i386/tcg/decode-new.c.inc
index 213dbb9637c..ea8e26f7f98 100644
--- a/target/i386/tcg/decode-new.c.inc
+++ b/target/i386/tcg/decode-new.c.inc
@@ -1430,15 +1430,10 @@ static const X86OpEntry opcodes_0F[256] = {
     [0xff] = X86_OP_ENTRYr(UD,     nop,v),                        /* UD0 */
 };
 
-static void do_decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-{
-    *entry = opcodes_0F[*b];
-}
-
 static void decode_0F(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
 {
     *b = x86_ldub_code(env, s);
-    do_decode_0F(s, env, entry, b);
+    *entry = opcodes_0F[*b];
 }
 
 static void decode_63(DisasContext *s, CPUX86State *env, X86OpEntry *entry, uint8_t *b)
-- 
2.52.0


