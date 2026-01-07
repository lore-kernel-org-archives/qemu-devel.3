Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87EA4CF6C10
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Jan 2026 08:49:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdPDr-0007nX-7B; Wed, 07 Jan 2026 03:48:55 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDn-0007lM-79
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdPDj-0008GJ-Cv
 for qemu-devel@nongnu.org; Wed, 07 Jan 2026 03:48:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767775725;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=I9Mz/L18GVHFDlojEQ71HB9aw/77jl0ygkqPYLbxK6E=;
 b=MDD2OTx1f7nw0qJYs3qEAMDAbRHnPXBbAuqGTY99H9/7c4A4EQrOGYnttV4mgTRBJWwgXx
 LiaAXyGRg3gc3srx/YM7W65XUt0eAAukAMhVL2Nv720c6FFwPO8pyeMSv0vubq0SrplU28
 LBIO8DiHHtlOUCmxaXPnj9+C3dK+jyY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-97-t-y0_781NIODEdj-4GunbQ-1; Wed, 07 Jan 2026 03:48:44 -0500
X-MC-Unique: t-y0_781NIODEdj-4GunbQ-1
X-Mimecast-MFC-AGG-ID: t-y0_781NIODEdj-4GunbQ_1767775723
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779ecc3cc8so12197655e9.3
 for <qemu-devel@nongnu.org>; Wed, 07 Jan 2026 00:48:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767775723; x=1768380523; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=I9Mz/L18GVHFDlojEQ71HB9aw/77jl0ygkqPYLbxK6E=;
 b=KMR2EWmqrDUtN2RtJxjLL1hMRi/Ugiya2aAkHI2x7Ntpwh/Ft374PYsyppc8CQKugL
 vsvNzeSS1hw2/YH4S8Lff/U2L+VA7LoX0HeLoqH2NL0NKroAee+GIT47ASqZxSXBp4y9
 H1Vphfs4SDTuMjoNtsG4vX+f0Y3IUIMAE5ag6QK5jlK2cSE0KzXeC8tnGcmIVhlv/2lN
 2YWxah9SCTbYZcLcrsRJg5fMOAALk0W7w70RBRGgy+NqCEsxcDzqP567ggU0ZkfGpn22
 sxgyjNEgOafx1cJY0lu1uZgYBT3SciY7QV/PBAStm+ZKjsh8QKuDltS3PwO15TLXwWjR
 PH5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767775723; x=1768380523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=I9Mz/L18GVHFDlojEQ71HB9aw/77jl0ygkqPYLbxK6E=;
 b=qkMGGkDVs6IYzEHYKogvGXK8jhrL/DztH8Yp77DCttyWNAs2UAJZZ1S8kniC+bO/5/
 B1NH6Zibl3BaImoAkkNbui577Eawp0cefOJlJCHH3UWQxEjzrDpC1Ufl35MWM4VWL24l
 j2PI8bhFWe5CZ7+X+70PRTnqlyETulYvexvrHl3RcHPygTvS5psEr0+6VLLLrLsToZiD
 ddjBeQxpZs6HvCVmY/oP+0NACmjxl4/2I2qVQTPCj8MZJLgnHNuxcClhuQvdyqwf2IfH
 zyiVGDLJ3pcTEflQsr3Hllk2yhEF6OBILbnj4TlsS1Wh+erfrRfPY9wkU54SqpRr2Ax/
 j0rw==
X-Gm-Message-State: AOJu0YwLCeS08tj1vPRIB/tZ7lxFvQPcPCG+HZ5FID4tKwq/T70QqZz3
 HdrgPS6gb88fHwEVXf5pFqFK7s93r9cHP7KTe3w5mU3WYQIV3N4WfpuXz9p3JmTvHCb17a2/eM/
 jJdiFqNCg1/08xTy+HpngKz0FuM8GUnXh8GcC3lDnvQVOh7C2HPth/2M/lhF1BZsY8j86K29Xpk
 6AyADDhM/Kin6d21n5y5PHut55ZK3fnSP4gRvF6aWV
X-Gm-Gg: AY/fxX4+qpdWsym8816wAAoDu6I1s3T6r0SvVXi4fGLoPNaL7TZ+OpiH+FtPqfz9adJ
 9a6Pltz30iGgZ1bliwKhqAjZNB7O0OtywNP4m4tXlQQgNEAcg/pQsl+g4AnLxRiT9HV+8G3aW82
 skaM9H/cp1EP4P6c2imNwGWZpkDb3nUeAi6aYswxtZFPqhw5hc0KrNovv0g6mnb7BbVoPYWDsFN
 n2vPklzUDnCLp4nalKERGYH7cs09lrUlN64gW0XuEJY+MIkvz8Tfgmnsjy7Df8mQVc7dmzIxaUJ
 tw3QTgZeFeXMBGgWKD/3PM7GghpmUgJZm2UZ/5KuQCd4MBcSsaKLbR+FwMAZtl4iJDh67u9nsfr
 3mrUTFyDKCHFtXPDavj+D4CQuLU4sXDexewUAEanjYpvGTOTcWwC9owKgvnqqp1hxShLonC3zva
 hIZ7lVSuFK4pN2tw==
X-Received: by 2002:a05:600c:8211:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-47d849c5ccdmr18101235e9.0.1767775722613; 
 Wed, 07 Jan 2026 00:48:42 -0800 (PST)
X-Google-Smtp-Source: AGHT+IG8pMv3/0XIbqTXnCldxpubIlpGzAKdZlNGNz9EklT7EuK+iekpUQYEQWtP+mYVwdg9zsKF/g==
X-Received: by 2002:a05:600c:8211:b0:477:9fcf:3fe3 with SMTP id
 5b1f17b1804b1-47d849c5ccdmr18101005e9.0.1767775722096; 
 Wed, 07 Jan 2026 00:48:42 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f68f4ddsm89104195e9.2.2026.01.07.00.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 07 Jan 2026 00:48:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com
Subject: [PATCH 0/5] qobject: switch JSON parser to push
Date: Wed,  7 Jan 2026 09:48:35 +0100
Message-ID: <20260107084840.150843-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
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
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

This rewrites the json-parser to use a push parser aka state machine.
While push parsers are inherently more complex than recursive descent,
the grammar for JSON is simple enough that the parser remains readable.
There is therefore no need to use e.g. QEMU coroutines.

Unlike the suggestion in commit 62815d85aed ("json: Redesign the callback
to consume JSON values", 2018-08-24), I kept the json-streamer concept.
It helps in handling input limits, it performs error recovery, and it
converts the token-at-a-time push interface to callbacks---all things
that are more easily done in a separate layer to keep the parser clean.
However, there is no need anymore for it to store partial JSON objects
in tokenized form.

Another benefit is that QEMU can report the first parsing error
immediately, without waiting for delimiters to be balanced.

On top of the benefits intrinsic in the push architecture, it so happens
that it's really easy to add a location to JSON parsing errors now, so
do that as well.

Paolo


Paolo Bonzini (5):
  json-parser: pass around lookahead token, constify
  json-parser: replace with a push parser
  json-streamer: remove token queue
  json-streamer: do not heap-allocate JSONToken
  json-parser: add location to JSON parsing errors

 include/qobject/json-parser.h |  12 +-
 qobject/json-parser-int.h     |  13 +-
 qobject/json-lexer.c          |  11 +-
 qobject/json-parser.c         | 493 ++++++++++++++++------------------
 qobject/json-streamer.c       | 107 ++++----
 5 files changed, 310 insertions(+), 326 deletions(-)

-- 
2.52.0


