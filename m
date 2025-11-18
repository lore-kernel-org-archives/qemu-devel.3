Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B0FBDCED260
	for <qemu-devel@archiver.kernel.org>; Tue, 18 Nov 2025 10:30:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vLIyA-0006Tg-3P; Tue, 18 Nov 2025 05:29:54 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIy7-0006TJ-Nk
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:52 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vLIy5-00030t-HN
 for qemu-devel@nongnu.org; Tue, 18 Nov 2025 05:29:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763461788;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=R+hfx4DRO3dhZpmsIc6t8HCrbrlGqdcYs6jIPnvq7Xc=;
 b=GhESwLtXY7/d7cX0FOTvA7+PMeCefKc5sANuE+p4etjWHriSMzlGUXt/5hsRnuXu/eSfL7
 Olysd8rYaod2TH4f0VYyBsz2wbic2O+nO6pVCxwTEzOszV1rCW/lLWcW30NW+q7F5eNyrZ
 ifOI1uFVlpQ27uLszDU9o21jDaoCPMI=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-376-0g62ZjiHMoeAxTGJ1P0sUg-1; Tue, 18 Nov 2025 05:29:46 -0500
X-MC-Unique: 0g62ZjiHMoeAxTGJ1P0sUg-1
X-Mimecast-MFC-AGG-ID: 0g62ZjiHMoeAxTGJ1P0sUg_1763461785
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-47777158a85so47081055e9.3
 for <qemu-devel@nongnu.org>; Tue, 18 Nov 2025 02:29:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763461784; x=1764066584; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=R+hfx4DRO3dhZpmsIc6t8HCrbrlGqdcYs6jIPnvq7Xc=;
 b=MTnvyuupz+u6WaMCilt0X+yJETZXVD0O4Hcou3WVgMqv3yDJ9VCTYsGm+vHLyXi/46
 J3CZUKWGPoCqy6cYETsYH79aIlSBceT2l7ZUeNmd0gm+3RunFkVIV1STWlPfja5+VO8e
 4cxSJu9RYstoUzCsxQG3jrZu5dcPE4RwqCRMmmiP86/qfI1C0gYisYCIBMeCXBejHUQb
 lSTZtu0SVVbN+xoULIjTXcmFtq07Wfbd/GnibSg0Fix4fZ1KuqL7kVUah/BQLsr/AFvF
 gBRFe4C8/c218GS1GaxusdXXdtzAZHsgj+ox/emP92ExGpil2049hPaIgwNSEF2agkVk
 DnlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763461784; x=1764066584;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R+hfx4DRO3dhZpmsIc6t8HCrbrlGqdcYs6jIPnvq7Xc=;
 b=XfElXX8DID6WtVL3JPLIX7oXQObdhEL5iKWOEkK2Ns3cYS2w7FPuQvW5Wqr+FrCkB3
 5XHqFNal4c5Migfj9z1rzfBzYI7YWFxhm3+G+vBP7Jmwgd8Mox7p4E6E4RrqICPnZ5Ze
 GDVS9UmNOsEjcYPDbMJrpjxHd9uT0p6YEr1bi9tSw2QJnEVO31mTuOT1RVX/k9Z5BJa/
 qSWAMU0gWmOQYqauZv/sYVXH1tW2mgbpIkWPad3NBgi+76dUC3Ca6hX3nibuIwFG0bjG
 BM9X2Ho13ktYrqsb8V4AKyunQILXDixF2ztU+1euhwcifol5gxKibpnihG9ODiBXzY7Q
 bUkg==
X-Gm-Message-State: AOJu0YxacMpQ6dxqbY3cAf3y6kQ1kaCmtelqdbfWZvpNXRszXj/g73kv
 5DEv0J0Mbt45nCRW9rszncjZAEzZz9V5PWf/Oc+CONNliOQKdyRiMk2qtOxWIIJz2P6zwK8gTN1
 auTy3s67hUfTvrVaGuTP1gcf1+eANynjVxFkjBus7fDyp15TM5cnMLocT1+hQ+aidswCtCqP5fn
 EzqbAKzxSHtTddMeGZ7hVgIkGGrKYq22/ugM1p0wqR
X-Gm-Gg: ASbGncuemOAcxKcBZ2C8yx5XlA3Foww2Tu8t1OkodqR0ng42ZQ3CHrFRfmdLMrhxvno
 aS4DysH03dXfJgQEUr16uAS4fIWm5BKajHPrW7hnqx5u6j8qxxAJ0p9nhWm/gBYz6p6bCk9gcCH
 fEXIpCIHh19PwOyQrCsEgdQbOk1/9TGRQbOAOBVM+eNzIiEVn3i1dCdUkZ5YC0gvTHcDqymhag2
 pVeU0nJK/oBo8/RZggehv9ad257+zvVA4hIwqml3jAHHO7TuLNRrNqZu9ajxT0SAguZATbr0a3+
 XqjXl4A4jZRIrmQOT0KBxbHPl0AUWcoqfTZF2mCMbcHLehfWPAPZMjvjjVti6QpIUDAwbsPljHH
 sUBd3MtvVvfqDMBCVDkJ+8ulDwBzZZBKkQHe9dwVBdRo9aSksCTZS63GoA4h4Od20JSVIjRD4PM
 idq7JpqcXF7yr5pPM=
X-Received: by 2002:a05:600c:c4a2:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-4778fe9ac28mr138363725e9.21.1763461784430; 
 Tue, 18 Nov 2025 02:29:44 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFfgbzfPgvHk3YqWqplWecTFG4RW0B8VVpUCTha647QIbQ6ItCgggD1aNtQytxHnnz+dIerTw==
X-Received: by 2002:a05:600c:c4a2:b0:477:c37:2ea7 with SMTP id
 5b1f17b1804b1-4778fe9ac28mr138363475e9.21.1763461784003; 
 Tue, 18 Nov 2025 02:29:44 -0800 (PST)
Received: from [192.168.10.48] ([176.206.119.13])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-477a81c567bsm55651695e9.9.2025.11.18.02.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Nov 2025 02:29:43 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: jsnow@redhat.com,
	alex.bennee@linaro.org
Subject: [PATCH v2 0/3] mtest2make: clean up and make dependencies more precise
Date: Tue, 18 Nov 2025 11:29:39 +0100
Message-ID: <20251118102942.551194-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.1
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

You probably have never thought much about scripts/mtest2make.py, and in
fact it has seen only a hendful of commits in the last few years.
The idea is pretty simple: gather the list of testsuites and their
dependencies, and turn a "make check-*" invocation into calling "ninja"
first and "meson test" second.  On top of that, it magically turns
SPEED=thorough into invoking up to three suites named XYZ, XYZ-slow
and XYZ-thorough.

But even this incospicuous script can harbor a bug, or rather an "I
didn't really think too much about it" situation.  Dependencies are added
to suite XYZ independent of the speed that is used in the meson.build
file: add a dependency to a func-thorough test and "make check-func"
will build it at any requested speed.

Fixing this is a one line change with some cleanup performed on the
front, and that cleanup is patch 1.  This (at least to me) also makes
the generated Makefile.mtest file a little bit easier to read, which is
nice to have.

Paolo

v1->v2: support "make check-SUITE" where SUITE includes a speed

Paolo Bonzini (3):
  mtest2make: cleanup mtest-suites variables
  mtest2make: add dependencies to the "speed-qualified" suite
  mtest2make: do not repeat the same speed over and over

 Makefile              |  4 +++-
 scripts/mtest2make.py | 43 ++++++++++++++++++-------------------------
 2 files changed, 21 insertions(+), 26 deletions(-)

-- 
2.51.1


