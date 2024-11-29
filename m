Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1537FD6EBF7
	for <qemu-devel@archiver.kernel.org>; Fri, 29 Nov 2024 10:33:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGyJI-0005sM-04; Fri, 29 Nov 2024 05:33:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tGyJG-0005rd-8h
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:33:14 -0500
Received: from mail-ed1-x532.google.com ([2a00:1450:4864:20::532])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <r.peniaev@gmail.com>)
 id 1tGyJE-0001VH-QL
 for qemu-devel@nongnu.org; Fri, 29 Nov 2024 05:33:14 -0500
Received: by mail-ed1-x532.google.com with SMTP id
 4fb4d7f45d1cf-5cec9609303so1910061a12.1
 for <qemu-devel@nongnu.org>; Fri, 29 Nov 2024 02:33:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1732876391; x=1733481191; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=f20yQ3A8rIaA9LjjtPbwfAgssJYyZVaFYuEIkxbdWcA=;
 b=QsbhR/F4LVEWTgHXyKThDZQ/90e5q+bsojt6c1g6LApxhJC1+2Khc8fdVlwMf9D/A1
 vNRh/uNLV2d4ZwrtRo/sVCGg/VJ4vs+mFv7/25BJXqa5h1x8uF9INbNP+rSBNa2h9lqN
 D0FpzW7jkNDpAc43tDKnWrIwXQlYTxXEez602IEc5D92dGE47Y4k7F1u9pU2xSWs3nUh
 amPFCjjt5lNni7OsI2iK2SEfy1npJlbvl2jMpehyuLHYIA40bHPyNt5VsIcB/443KkIH
 OJ6anlTaITnL+5BNp2SWR7XQgmd4A05Ttiv22MYh9Goj+1PglCjX5i/lW/S5WWbuW77i
 dbLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732876391; x=1733481191;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=f20yQ3A8rIaA9LjjtPbwfAgssJYyZVaFYuEIkxbdWcA=;
 b=ahMpYojxrJhRq8mg1WR3+RdxcSgljsd0/O5X7jMq9Vau94XhQ8DrZ8PmB20gC1ho0G
 nhBsh6FiCtTyZahlM9bR4h6puxTIX05MEsTHYgasK8aEUmPbkEGmodwetEVtExaXmT0q
 qMr+tCdKBlDFM+cQBW9cd+VnWHPV5+7srny7CIEzjbWIc8PdyjwxV/5gUKpdWXGCpL6K
 t1hSG2hvYrff52uyg848oyZBNZHdVgO3wn295Bar8oULO/CrU7G0BEsb0HwSwaKgNlC4
 feFsZXwV58jm4W2iczBRBjj6DdIwZ391itR0wc+1Fz70FWW+LZOFXJze4HdeNQmwngmf
 8a6w==
X-Forwarded-Encrypted: i=1;
 AJvYcCVVEfssM8DBj/HyKz15vxv7c6rp1kgjYkAMDufakn+rdRCke1F2rHNBrILbmDM6hvM4bfiH2YpYbbfT@nongnu.org
X-Gm-Message-State: AOJu0YwyJhJHuIrbIMKVyda4PSh+nfa0PEfHWtiNBevOUJyCCUUVIMmi
 uk9Arcp4V8SkCKX4WHIkEDMgHo4I+SKWgZjkomijwVgPrJtHD/o0
X-Gm-Gg: ASbGncu/1N6Sv9fFTPzyyR7EVOesXQNowLVMZOa5sYcQFNgy4Ldj9el/4H/2P+HmiJ9
 a9p7MK/VuC17saQdrtzffbhabzrABl6+swAPIqrtco2hqBmmeulg5Xyf6t9jGuFygPr3zHukch+
 4WDAqg2xZOOOM9UAF96ePuWGRXI9znpcH/zJRUhsYhQkhrM+ZUu0eFvX0KXxPnH9pfCjgEUSULA
 fKHyb1STw44qRbsxTnZCsNQjxCsflhpKyqTJfOGv7QedXxwfzTGE5VlJrc=
X-Google-Smtp-Source: AGHT+IHcAktCZZC0SsOGWOFYlC/ynrOyUqqjtiCRXIERhgFeKwN3MlRycLL4TytiStGcAQGMmnRsuw==
X-Received: by 2002:a17:907:254e:b0:a99:529d:81ae with SMTP id
 a640c23a62f3a-aa581062752mr768508366b.55.1732876391152; 
 Fri, 29 Nov 2024 02:33:11 -0800 (PST)
Received: from think.fritz.box ([2a02:8109:8384:1400:4166:755a:3476:5f1c])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-aa599953c81sm160300266b.184.2024.11.29.02.33.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Nov 2024 02:33:10 -0800 (PST)
From: Roman Penyaev <r.peniaev@gmail.com>
To: 
Cc: Roman Penyaev <r.peniaev@gmail.com>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Cl=C3=A9ment=20Mathieu--Drif?= <clement.mathieu--drif@eviden.com>,
 qemu-devel@nongnu.org
Subject: [PATCH v3 2/2] chardev/char-mux: make boolean bit check instead of
 find_next_bit()
Date: Fri, 29 Nov 2024 11:32:39 +0100
Message-Id: <20241129103239.464061-3-r.peniaev@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241129103239.464061-1-r.peniaev@gmail.com>
References: <20241129103239.464061-1-r.peniaev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::532;
 envelope-from=r.peniaev@gmail.com; helo=mail-ed1-x532.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

This patch simplifies (and makes less confusing) bit checks by
replacing `find_next_bit()` calls with boolean AND operation.

Resolves: Coverity CID 1563776
Signed-off-by: Roman Penyaev <r.peniaev@gmail.com>
Reviewed-by: "Marc-André Lureau" <marcandre.lureau@redhat.com>
Cc: Peter Maydell <peter.maydell@linaro.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Reviewed-by: Clément Mathieu--Drif <clement.mathieu--drif@eviden.com>
Cc: qemu-devel@nongnu.org
---
 chardev/char-mux.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/chardev/char-mux.c b/chardev/char-mux.c
index 9d67b8bd9ab8..e13042d3810c 100644
--- a/chardev/char-mux.c
+++ b/chardev/char-mux.c
@@ -336,15 +336,12 @@ bool mux_chr_attach_frontend(MuxChardev *d, CharBackend *b,
 
 bool mux_chr_detach_frontend(MuxChardev *d, unsigned int tag)
 {
-    unsigned int bit;
-
-    bit = find_next_bit(&d->mux_bitset, MAX_MUX, tag);
-    if (bit != tag) {
+    if (!(d->mux_bitset & (1ul << tag))) {
         return false;
     }
 
-    d->mux_bitset &= ~(1ul << bit);
-    d->backends[bit] = NULL;
+    d->mux_bitset &= ~(1ul << tag);
+    d->backends[tag] = NULL;
 
     return true;
 }
@@ -353,7 +350,7 @@ void mux_set_focus(Chardev *chr, unsigned int focus)
 {
     MuxChardev *d = MUX_CHARDEV(chr);
 
-    assert(find_next_bit(&d->mux_bitset, MAX_MUX, focus) == focus);
+    assert(d->mux_bitset & (1ul << focus));
 
     if (d->focus != -1) {
         mux_chr_send_event(d, d->focus, CHR_EVENT_MUX_OUT);
-- 
2.34.1


