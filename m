Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61AF2C88E5C
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 13:22:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6pZw-0005yK-E1; Wed, 16 Sep 2026 09:21:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZu-0005y3-2J
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1x6pZs-00033P-Nq
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 09:21:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789564892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=39cvH491Kj2qhfCGhVeMqkgEYTvIuzsvjq1PpKmD+oE=;
 b=hwHl8yQ25tpZpPsIBA2Kpab3rfz1lRkIzGRsaOt3HOQ0Uk4n0lCzLQM9tVRV79Fu9RSJR4
 qAForYzptogPFJCmZdBNjmlQc4GsbIowKCsxVHg9LV5FXLE9i0Ieimt4rIwlKNTaH5TxW8
 uLQBBwx8QpKDXTnCvbVEdWVDWBeG7/8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-HbbupPdCMvWDFHpKKRjpsA-1; Wed, 16 Sep 2026 09:21:30 -0400
X-MC-Unique: HbbupPdCMvWDFHpKKRjpsA-1
X-Mimecast-MFC-AGG-ID: HbbupPdCMvWDFHpKKRjpsA_1789564889
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-49e76a80fe5so42314345e9.2
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 06:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789564889; x=1790169689; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=39cvH491Kj2qhfCGhVeMqkgEYTvIuzsvjq1PpKmD+oE=;
 b=PX97e8bUWL4P4DSYyOp1ykkfDMyLaKvY2SxBJccmbetWnW6yjQg1AtG3dr7R7d/u0r
 J8w3l4sn2mptj94h1OMek8b/GY8fmlDYpfhW06zrmRwHM7q3urtZlHyDYFHMAOzBq4KX
 VLyQ1DGoIM2MiPygAspxfdymoa7R8yCCFK/nnkPftMqHbqqnVxIlPaYMH9gWeB7c08+S
 KusvORwPaSbDsiwUzpwJNodiPqTC46jivXNNpJ81opSbpx0fKXWoH1wq30aVwa/D//ls
 bfHJHPntJm+50uzXxT1vw/NUJMmqABH0xtY6xQn3lL3smQ+f8LZpqAHXUtBOyQW0l0uc
 5OQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789564889; x=1790169689;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=39cvH491Kj2qhfCGhVeMqkgEYTvIuzsvjq1PpKmD+oE=;
 b=aqu1h33wlCddrl5I24lRHcxMCEeieuUoszeqsCk74vJpe5jQicgrnMCsDy9T4NcBg/
 CSqQoq5xFe9w6it458/BtABMklpu19T2Igmn+kzIaM0nHpT3EVbwnjuZTO44Rvch2rkj
 jmAhl7SRSY6Z+6Zpclz9JSsZSN2paVNFrmZxCPxYQNFM/nqekSxXsNsFcTo+kBBr5vMK
 AtHujYD9/MoIXwKMpYcxP8YEJ3yyUaBFpnKCpO+pZ5PbuN6bl11vNrAx4WhdnW9r6kdA
 341cTDQHaX0yCZxMtYYdqe6PhvWhaaf0TBqLNgFojwUKf3P2EzJWmGeb3CqnvX8lfhv9
 ES5A==
X-Gm-Message-State: AFuF++npWgVpxbsNwDwafeLt5wQTeXC3JkU+x2ZQlz29Nj4y2XaHv2ld
 76lBbCsT6/xxTyjw8ZIAlLq5fegki0ANHNuuCGN8UDldEZfPsZxxPjDRvW21aZDDUczZnGf5yF4
 EQL6woYQ9z8PgAoSrcT7i8xCJ9NogJSBYHcAf3X6IwYV9EyGGR9vLN5+iMGyK2FhqUTBzdLpI/y
 MJU5T9OWHQtUM/AvcIXq9wA6jtxs4vHFy/eCcDL16N
X-Gm-Gg: AYBFou2seEHPdTd9NXKwfy7emBtfYEdTYA79qYxSKcP7VjTButSqv+dDYY0fvg7goED
 1txoEmoYpZBLsBc8m4kn3hSjuVV6ZXEOlRt7S+oTCoZbecanPhaVHen1yQoxxDq02vLtJJ8476u
 zfSRcJapM1wUBN5Miawbn/mAewRdbAG0xo+VL7psvSQ7o9yexTloB4yU9a43VjapaY58yoUFeke
 cT+dgpzxYXn/mvW9+iLWoA18pyZvTsPEl98jpLz7pLNWPxPw6QlZmgF/+2v/ecA9J3ARhZd+tlP
 utGAxGzuWw/FZDzCYH9zkEUdsT/8XzNGN1CoKY1ANpuoEbPS3gdqbBxsp8puJrVoT1djszk8eGk
 VQygRFvDo5VBFWeMBmdANth7UOQYP5HLPiPJwIVIUZ7gMucT+xmlZiKZh5xeefURTaA==
X-Received: by 2002:a05:600c:354a:b0:49c:ffab:551f with SMTP id
 5b1f17b1804b1-49eb73477edmr31610635e9.22.1789564889370; 
 Wed, 16 Sep 2026 06:21:29 -0700 (PDT)
X-Received: by 2002:a05:600c:354a:b0:49c:ffab:551f with SMTP id
 5b1f17b1804b1-49eb73477edmr31610145e9.22.1789564888858; 
 Wed, 16 Sep 2026 06:21:28 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.232.249])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49e83b02245sm98581695e9.10.2026.09.16.06.21.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 06:21:24 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: deller@gmx.de
Subject: [PATCH 2/8] ncr710: reuse ncr710_clear_pending_irq in ncr10_do_command
Date: Wed, 16 Sep 2026 15:21:14 +0200
Message-ID: <20260916132120.860910-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260916132120.860910-1-pbonzini@redhat.com>
References: <20260916132120.860910-1-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/scsi/ncr53c710.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/hw/scsi/ncr53c710.c b/hw/scsi/ncr53c710.c
index b87fed05a4d..12a9b69336a 100644
--- a/hw/scsi/ncr53c710.c
+++ b/hw/scsi/ncr53c710.c
@@ -928,10 +928,7 @@ static void ncr710_do_command(NCR710State *s)
         return;
     }
 
-    if (s->current) {
-        ncr710_request_free(s, s->current);
-        s->current = NULL;
-    }
+    ncr710_clear_pending_irq(s);
 
     s->current = g_new0(NCR710Request, 1);
     s->current->tag = s->select_tag;
-- 
2.55.0


