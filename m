Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6072E8FDD6
	for <qemu-devel@archiver.kernel.org>; Sat, 27 Dec 2025 09:19:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vZQPj-0002LA-Ls; Sat, 27 Dec 2025 04:16:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPc-0002K0-V4
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vZQPb-0002Ik-M9
 for qemu-devel@nongnu.org; Sat, 27 Dec 2025 04:16:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766826995;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5fbsu02M+KufXqyko1QhTUiaf/7nZFbEc0uUHDwr8p0=;
 b=LGtbdlQlHCl2D/xuYdj9SvJKje9vqqVXEfAK8cmws1S86NtH3gmGLJoton8HXUPBe/aKu4
 YGA+uXbLvSHyJ1AIXwm1ASn9uGG8X0JyyADcvpen/TfRwsgSRFI7S44nT9HSWNHfcmAlwz
 L4/J+A1IXuNGTdbTfJxr9+obMTuISc0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-550-HSM8JZE8NI6FJcQHYbX1_w-1; Sat, 27 Dec 2025 04:16:33 -0500
X-MC-Unique: HSM8JZE8NI6FJcQHYbX1_w-1
X-Mimecast-MFC-AGG-ID: HSM8JZE8NI6FJcQHYbX1_w_1766826992
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-43284f60a8aso423820f8f.3
 for <qemu-devel@nongnu.org>; Sat, 27 Dec 2025 01:16:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766826991; x=1767431791; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=5fbsu02M+KufXqyko1QhTUiaf/7nZFbEc0uUHDwr8p0=;
 b=QJIr3ScHtOzBPX/t1Mrh4C2sy7yubnRBctgkbGZy1xn0O0uvH0a1HlpbhrvAbdK5eY
 4nCRy6cHMcwTot3SnhIVu6Jd12lJOBwGP0FAffSmmD7LfwdlntEhzw55BYrOLH0JX0ls
 ZZfHp7SYVoK9r8mNum/hZZ33KVXDQc6kqAK8pNgDWV0ICmFWCEip6QpO6J5eKvegKFep
 z5n7NNAczkVGOlAmulA0+cF85/iiJgBhB+puyFworhKpFMEqJxRmHb2EUQq0MTElhRNg
 8iwOcvy2s0YCilpE2ZJ0edMmbLz4MrXjE3r3cIYSZYFq3pYxSS75W0pG/j0FJGOEzyp8
 vejg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766826991; x=1767431791;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=5fbsu02M+KufXqyko1QhTUiaf/7nZFbEc0uUHDwr8p0=;
 b=QR/Ft+qgzFY5Kv3Ad0uKpTT/kRueJ/AeHsDZzs8euqGmyhp3WnuBHv4Is0fGQGMXxU
 BuSfuDItOr2lxeks0JftdpOxUL5Hl8rH29IeQyuUtMdmMzHVT/IWBmKGPmcFzI2FW01t
 /1UBpahLfwWHdzZiaaKgkfegrpHbIU45M1UUqJhA5raYr/bhR9UqvjtGxSLWx5twzi2A
 05RG0UJY0pbf/yDRcQDuUT7nYGx0c2OHD3gHmcXyZCwoOu/bXDFoaYgHLtei38Bh4wuB
 sLixTZ+M1xrl8wj2gOW5ExPKtQxFL5BvAPZvcn+q3KEyPlb9G43COJ/WEFrpeK8cw8UG
 1BSg==
X-Gm-Message-State: AOJu0YzLwU2wOj8m1Li4HsqsH+3TVqrxEZZ9TiKfM0v1fJq0IS1A/H/F
 bPAVh4H9izYyurFeI/DPgwrhDJoe5tcgyXzN+DVJWpjXbpcxB48xx9Cfxnd0bR0nNp+tn2aQXq0
 0w1SOR1HHMA6QpFANo8eAmib4SB45mu+lrmUyNHO+yek6QuG9KakxlIAE6oWUubOM6mgQEdkVKq
 21X07frwPlgddfSDiHq6ghCtcck1A6RXC8W2P2Xtq6
X-Gm-Gg: AY/fxX75IqGlyvJfNH6BzjudtwuWmkGLqwQ8UqbtgKgfk+kJ6mF0Lj+UVE2gNxmxM0P
 EaKcWn4LfazLRx/45bvwvoLDjKQ9uKp+tJ0hGJiwQnV+L3jIOfoSkiDr9Otr5hvd8UupR2reVkm
 NGBRqbs+VdujorG70RFJ0jEmxlsKN2bqfT3g6CpIVSpgvwO1xBeIOMAo7VkD5OfvFiXuvOdzBmD
 z4A58RB5XxqI8BTQj/DkeoS+d8pPFglh9hvexVXes4fRvikrZ8+V83Me8g2Gx2sg0Vf5XXR30HT
 Oqa4gULIX14y8EMFYiDj1uhMMSH6ZpolJmvGCiSNlxbBsf2cvRxUVpYnIzZtk2vmdapX2hw4jvt
 jSOnuG+Yfcm1ZA4sH6sIJ6lh7Lhr81G76PrzyrI++ZNTRRnT4kdjwio+VSXZymb9IOjvh3SRGss
 cHtzD7tzv72lcyEu0=
X-Received: by 2002:a5d:584d:0:b0:431:8f8:7f17 with SMTP id
 ffacd0b85a97d-4324e4bf5bamr30368017f8f.10.1766826991074; 
 Sat, 27 Dec 2025 01:16:31 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEVUOat7hhtevo/pzHyk0leMBs23WoNNKPiTHhwYAp7DjCg51ktqn7VJJWhMF/IRs4cS8L5OQ==
X-Received: by 2002:a5d:584d:0:b0:431:8f8:7f17 with SMTP id
 ffacd0b85a97d-4324e4bf5bamr30367998f8f.10.1766826990638; 
 Sat, 27 Dec 2025 01:16:30 -0800 (PST)
Received: from [192.168.10.48] ([151.95.145.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4324ea830f3sm48613448f8f.22.2025.12.27.01.16.28
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 27 Dec 2025 01:16:28 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PULL 003/153] include: name the MemReentrancyGuard struct
Date: Sat, 27 Dec 2025 10:13:50 +0100
Message-ID: <20251227091622.20725-4-pbonzini@redhat.com>
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

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 include/hw/qdev-core.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/hw/qdev-core.h b/include/hw/qdev-core.h
index 2caa0cbd26f..5cf2db7ee11 100644
--- a/include/hw/qdev-core.h
+++ b/include/hw/qdev-core.h
@@ -208,7 +208,7 @@ struct NamedClockList {
     QLIST_ENTRY(NamedClockList) node;
 };
 
-typedef struct {
+typedef struct MemReentrancyGuard {
     bool engaged_in_io;
 } MemReentrancyGuard;
 
-- 
2.52.0


