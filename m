Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27D19CD98F6
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIh-0006ll-Ge; Wed, 17 Jun 2026 10:31:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIf-0006lI-Dq
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrId-0007qQ-VE
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706687;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=m+5mqgZNw+BewGFyL/ROgj/mTd2mWBA2DvDTABIH9Qw=;
 b=U7Ie9W8IXN2aHjm2fa0R+Qx0GZAZbpu7y1no2io0r/9r3qN8JjfECEX4MQQ5x+mcPwSnFc
 lesiA8hL/pZcB86j/qiskO3D684DPZMz5btFWwtuqtwE/CPmnpO6bh5TWJYQsez+hhY+xk
 R5FXcdXTddVwz5Djhsiw0U57IbPqgJA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-48-QzOeFrleMO68ts89l5nafg-1; Wed, 17 Jun 2026 10:31:25 -0400
X-MC-Unique: QzOeFrleMO68ts89l5nafg-1
X-Mimecast-MFC-AGG-ID: QzOeFrleMO68ts89l5nafg_1781706684
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-462c1cf9003so590277f8f.1
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706684; x=1782311484; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=m+5mqgZNw+BewGFyL/ROgj/mTd2mWBA2DvDTABIH9Qw=;
 b=jb9zUg2bbrBkxhXAVo9H13A60rrCNMWU6l1ISvIioml3JRqhrVF64WGa9anuhoiqED
 upJqk3S42BzBkYhYV7wOHwOW3npX+rtSVJCASI+lN9mngN4aiKQuFCiBcNNPtHad+JDa
 doW9/KgQqE15bB2z0GwCWVJ83fbHBjrKsxHLEM53x8S3vt5Gee6D47UGxo5Q8djW2p28
 0X7XgKVBNLs+RB6XAR0phSk5fAhrlxlJlXhYAvZkJVjLMrlFYpUXLKnNHIAqBqckz7nX
 ueeyHPpEprBizdOceirxHqEPKO6hs3ZdcmNdBnwAYlPHtnuOd/FxyWfzd0c/XfSSRUDK
 YFdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706684; x=1782311484;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=m+5mqgZNw+BewGFyL/ROgj/mTd2mWBA2DvDTABIH9Qw=;
 b=BXNA1v/Ne80Jqu4Dc0vjjhsnAEWdU70TDu2Jzw0WuX92xkcBpZDqB60mbAuMcn9cpd
 WuffNV/Jpx+yaF1Uyuf1LddPNjFI5Dw3s5ZTbG+RcydcQjiIukSHrKLnoXY2ognh4+lf
 2/gFbTryzdim9bC97T02NjYBnvVTUW+4ab6LPFlRMhNyJ+ghtfYBe1mP3odM+MYKTIy7
 RWv4nk56+s+/CtQd//eyyFX89lQsUPgy0j7jzg0r/BGpWWC29LKBVZ1vVPFdUbODoHIE
 2/ITDDH1dvrlARkb0lg7QzYfeRze4rpoeLFqxAeDehoyXzN1hNAHh5Ly/D/QS2cS6EEC
 Sesg==
X-Gm-Message-State: AOJu0YwrZqAZEaxYtUMtJbtuN7cJAYSssiJj5ydUlEAMQVY/RC9hPy5Q
 tmuZCGcCmMW8vucSahtZn9+yS+eRzLU5vkoBiKQnYO5xT5b7z1O5bq8PxTfJIhob0hkJCHgyzjE
 pCCacrsHuTlFjKqk1MuB1RbbjnvIxGW9t2BQqopspc9cmhCh8wNPMvAwigXDTlNCpqvZoh2DQjH
 GE0/oH2CkDeoREOL73TModn98sXXGt5Vb/fVrgjkdK
X-Gm-Gg: AfdE7ckXBXBfW08bQ8aAPfO5AfxLvPoRwM8I1hUcI+kbj+4Sw/4SQI/lZMg/Fr8JfoB
 rfW3BmDA7qTY4LJ2LyNJYSyknXZ21JiN6uEsYRlB2Bpfs4pbhQleoSXSZhu3jBHCdKdM1W4sfxP
 bR2uUlzR4gHlS3yle9LZxI5at7oGq9lZ+R/kevqTKubbjdP9NMqCKc+z/NbZqizLANKpNhCgI9J
 1v7u2dYyiQs11AAnOiyByAD8XhlANyBpggGuKmpprK/RHiFSfLGCdBbBRorc+qvjOPSSeu8A1sG
 kLgG1syDfMQEZ7i8cH1wbg2IOWDXbwPfogfUUgAxYsdT/exi5JWqmwfbljnqK1vYIwh1o7LAPQR
 LyWv9aRhP8ONhXBUl5xdueDxJ8lincNspP+5YCpC6kIzaBpdA3Og7hefZIG3XoZn4QnE1F2WScN
 0ikcU/b7u+gAwd0UZF
X-Received: by 2002:a05:6000:1787:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-4623bdcc225mr6641759f8f.0.1781706683941; 
 Wed, 17 Jun 2026 07:31:23 -0700 (PDT)
X-Received: by 2002:a05:6000:1787:b0:45e:739b:3e3c with SMTP id
 ffacd0b85a97d-4623bdcc225mr6641691f8f.0.1781706683248; 
 Wed, 17 Jun 2026 07:31:23 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f26434dsm55903901f8f.1.2026.06.17.07.31.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:21 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Subject: [PULL 13/16] qga/meson: Allow to use MSVC message compiler 'mc'
Date: Wed, 17 Jun 2026 16:30:43 +0200
Message-ID: <20260617143046.445322-14-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Link: https://lore.kernel.org/r/20260330113906.168002-5-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 qga/meson.build | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/qga/meson.build b/qga/meson.build
index 85bdacf7e2a..cfa2157efb2 100644
--- a/qga/meson.build
+++ b/qga/meson.build
@@ -104,7 +104,7 @@ endif
 
 qga_objs = []
 if host_os == 'windows'
-  windmc = find_program('windmc', required: true)
+  windmc = find_program('windmc', 'mc', required: true)
 
   msgrc = custom_target('messages-win32.rc',
                         input: 'messages-win32.mc',
-- 
2.54.0


