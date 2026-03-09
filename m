Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F359CFCA179
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Mar 2026 18:58:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vzfnr-0003pd-1h; Mon, 09 Mar 2026 14:58:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnp-0003mB-R0
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:05 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vzfnn-0007nK-Sr
 for qemu-devel@nongnu.org; Mon, 09 Mar 2026 14:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773082683;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=gSFIY/a5+sOoH5S0gQiebtea0XRoX0BEx/vjGNG4H4H32nD/HwF7S5JC4YBr9NfhSqqoYV
 i3bOBfou3ebEOUXY4YIn/17fWaL0hpdyV8bog94Zb8fIiU6+q87Bds0+AAhHE/Gwt413Uw
 s1uPLrSBEB3cENiRGLcM+oy/XgSnWw0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-I6eY4XALNaW5mm2rnOAmrA-1; Mon, 09 Mar 2026 14:58:01 -0400
X-MC-Unique: I6eY4XALNaW5mm2rnOAmrA-1
X-Mimecast-MFC-AGG-ID: I6eY4XALNaW5mm2rnOAmrA_1773082680
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-48532df52c5so21122095e9.1
 for <qemu-devel@nongnu.org>; Mon, 09 Mar 2026 11:58:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773082680; x=1773687480; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=Xti5+MYActk/jT532C8kQFQnY0WhlsjKMTq57dRIYb8n62axjpaeQad9KUImSF4Xi+
 i9wGonuXQb3yWM1Qeee9Cz8ZpVhLlkBFOGrQAdTX4y8WLxFqL17fDUWUNuG3cWZkTHVf
 rfwyuz/tarOo9qjJFe5aNVNa+lBtv0KRrqaaHBOH2t2YLFhrUOgRtUC9htTCEuqqQdJT
 M5UFY0stOWfMKd6Uwm8weQle7gf/rhDqbuj6ScsvoLbXKlsV4xVmQbIm9uDAfRj8Nil5
 3wMhaDYXr4LFIATWV8RhOvGpJI6svTwx1RHa23w4SipJmZXsERGq/ArwMRikOB5yy/VS
 b1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773082680; x=1773687480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=uPhfCaHv6CHzKOjPkqk+tdV6bugz5au2t9vUldgffyw=;
 b=RJtNfh92v+hnS8ZHVuBtphOM9RW9PdTFkumIzOityFR6vQzFQqNiuOi/PW7+vniYCK
 U7Xh+HRCxlCvoQsADDOPKFNw6f89Rhwu7EXW3OTo98BA6PCjoy3JwrTXE5WsrvSQ7oP1
 5lEQnOAFZBzbUrGlsotfFk7eL3BNR2NPswvMTCC8Pr62z3KCeXFS3NzDWq7sYt62HDlh
 gTVozAK8q1EzRk4LScpFHeSfZyGewu+DfDTXmPIWIYLWWB9PM2whMOrMhjD4A6Kz8JeN
 nLlWQUifTZxBE2jCd8TFuqWYsMMUvTYBEKVS20xS3LPknCnPNdOOqcs1jIxhjE00kZ5n
 M4JQ==
X-Gm-Message-State: AOJu0YyW2AHcFuR3X/U4dMLxu/lNF4Nqvv7rkEIMTk2NGZmH48QOz3qE
 kC27WOgP+WwhOk0CsvGlZ4C7QgasU7Bog1w8WhuhBzOg7/dRzvBQ4Ou70T4YgCvtcW6XyK6sRbW
 Nh6w9mHTv3f+wFjvZwNsujqdBt9Gd3u11hvtlB5ARLipWu71r63g4GccalfZkJkvb9hGxHhtqsz
 m4PxtGmrfpcq0TCMvwVlSb9GQhTCPO9eWbdvlcO79A
X-Gm-Gg: ATEYQzyGDEeeS0Gjrs/spADlJUiip74+jqKGyaknH04tX3VaUJliB7qopBmbq9YhxQ5
 xmxVbL2uFl0xU1GEUeajrVLX2J6PnBJM4KgiQEFhfAg0iMoJFXW7ZunDUGNcs94umKqYmyDa1Fp
 SVB7yypbHgZl1m4xRzz7rs6O5TjwQe64+T/A6ow+PQYr/b/z7p+ECTihEOkzXsMXlYTc7/WjK+Q
 UWJIA4fUJkiptLD8qkIbA/uGwm+pR1445+veMD6O184RZUpDqbGH/ZgrEubrUvt1KBe7px9FO2Z
 w6Rz4MUqvbk1ZB8d7SmSs2xz6j2BBAk7ty4lm38nSultw3SMLqIh6we5SxacYyDiUIm61R5TYyT
 IHrIXVGhjAwkTXdIhktC6Z/HE7q1R76eysEIrkqD2KcgV11O6DQNjeoXN+iR2nYL/KNj0kObdb+
 /LNfzlivZBgQxbUl+plUr8L/pXjFY=
X-Received: by 2002:a05:600c:8b84:b0:485:3ca4:4ee5 with SMTP id
 5b1f17b1804b1-4853ca45149mr54933835e9.8.1773082679599; 
 Mon, 09 Mar 2026 11:57:59 -0700 (PDT)
X-Received: by 2002:a05:600c:8b84:b0:485:3ca4:4ee5 with SMTP id
 5b1f17b1804b1-4853ca45149mr54933455e9.8.1773082679112; 
 Mon, 09 Mar 2026 11:57:59 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48541a6bc3bsm11259015e9.2.2026.03.09.11.57.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Mar 2026 11:57:56 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Siteshwar Vashisht <svashisht@redhat.com>
Subject: [PULL 02/10] qemu-coroutine-lock: fix has_waiters()
Date: Mon,  9 Mar 2026 19:57:44 +0100
Message-ID: <20260309185752.76865-3-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260309185752.76865-1-pbonzini@redhat.com>
References: <20260309185752.76865-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

has_waiters() is testing a reversed condition.  The logic is that
has_waiters() must return true if a qemu_co_mutex_lock_slowpath()
happened:

  qemu_co_mutex_unlock            qemu_co_mutex_lock_slowpath
  -------------------------       -------------------------------
  set handoff                     push to from_push
  memory barrier                  memory barrier
  check has_waiters()             check handoff

which requires it to return true if from_push (or to_pop from a previous
call) are *not* empty.

This was unlikely to cause trouble because it can only happen when the
same CoMutex is used across multiple threads, but it is nevertheless
completely wrong.  The bug would show up as either a NULL-pointer
dereference inside qemu_co_mutex_lock_slowpath(), or a missed wait in
qemu_co_mutex_unlock().

Reported-by: Siteshwar Vashisht <svashisht@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 util/qemu-coroutine-lock.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/util/qemu-coroutine-lock.c b/util/qemu-coroutine-lock.c
index fac91582b5f..c82ee754beb 100644
--- a/util/qemu-coroutine-lock.c
+++ b/util/qemu-coroutine-lock.c
@@ -173,7 +173,7 @@ static CoWaitRecord *pop_waiter(CoMutex *mutex)
 
 static bool has_waiters(CoMutex *mutex)
 {
-    return QSLIST_EMPTY(&mutex->to_pop) || QSLIST_EMPTY(&mutex->from_push);
+    return !QSLIST_EMPTY(&mutex->to_pop) || !QSLIST_EMPTY(&mutex->from_push);
 }
 
 void qemu_co_mutex_init(CoMutex *mutex)
-- 
2.53.0


