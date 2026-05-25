Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63CF5CD5BC9
	for <qemu-devel@archiver.kernel.org>; Mon, 25 May 2026 22:35:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wRdsK-00008L-Ev; Mon, 25 May 2026 18:34:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRdsI-00008B-W7
 for qemu-devel@nongnu.org; Mon, 25 May 2026 18:34:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1wRdsG-0006H2-Do
 for qemu-devel@nongnu.org; Mon, 25 May 2026 18:34:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1779748454;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=k3HumZO25GxEBVCnpQ/++l9O/5WVYPW7FUeLJOLuQP0=;
 b=GD78p3vmGT6KwaZfBGmsce/qW0+yYvGtPvvkBcUc1nR4Igzxah6g1ZDDiIDLQphW9xyBLu
 d/S4yRdyx6yXBE0SLExWYqY8NTBtlY32cUkjrRhisp9087ei+n9ynwtsqGMTGao6K/YVJ9
 w8lxaLaMzF7V/ZlQp0zGafmqmXTDVOM=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-H2v0Qv-kPYSA-5GGu6mbvQ-1; Mon, 25 May 2026 18:34:12 -0400
X-MC-Unique: H2v0Qv-kPYSA-5GGu6mbvQ-1
X-Mimecast-MFC-AGG-ID: H2v0Qv-kPYSA-5GGu6mbvQ_1779748451
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d789cebcfso6871826f8f.1
 for <qemu-devel@nongnu.org>; Mon, 25 May 2026 15:34:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1779748451; x=1780353251; darn=nongnu.org;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :from:to:cc:subject:date:message-id:reply-to;
 bh=k3HumZO25GxEBVCnpQ/++l9O/5WVYPW7FUeLJOLuQP0=;
 b=q7wB3UGbx8+D8wjO2tIsDUke1FX7WkPJOyFYt6keGOh2ZKIUPLWT48CjNLaCnMMZva
 NOsjgTFCkeFhLpvlUe1IikdE6725dh3P6mEJxET3Lxd4XXY33IGqK+MFPjJ5+fIgEETO
 ffn0AxC294jBwUfTJK+kDWXLE0oGyQ/dVNyMjxem8ewyeMg4izLqLsZjU/kP8qmARhhq
 usdvQT4bT/Qvunz9W2O7Qt16PwSPhKU++EnBCTS6l54ew+d2sEH87w6gDmmHoEktbCL/
 9pxnLAvmgZfrk+KAhomIVdVh74XPqndxBUUXPmBjYXmJtfQ9iQZ5aD94mDQNNnhIQy0u
 HNHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779748451; x=1780353251;
 h=content-disposition:mime-version:message-id:subject:cc:to:from:date
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=k3HumZO25GxEBVCnpQ/++l9O/5WVYPW7FUeLJOLuQP0=;
 b=rEYciRYxtUOkZWfYJ7Ak3VIgOePIIgFZjsz2hLNReuKdf9zGChGWrKGJCjAM38YYEB
 0qjoV3sTNs44b7GWjiFNm4L8jW6ythYM/IXlcIFvKiCziiRbEU9qhrLStX5884ttBZrm
 Cqp4d3aNfYW1YuJOfxjXM6pYQf4xAEXPsC4xUr0uJb6aWAAcvXFB6i+9lhUvNpL5uVJg
 QntlbC1pP/PlqbT11yfARpVw3urFoNcubnZtcep5pVPBytC0Jqam8J167+95gAmefY4u
 El0JqYvTf6Y8179wbjxoY8z1L8BbVzaiWiInbKSgCzZsXf26oEBv8T71uE8rDT3Fzz/d
 uj8A==
X-Gm-Message-State: AOJu0Yxb4gMZeXaRyTczNAnrH+Koxxcg/uwe3VIaeBKIfHVx7XdbQfCt
 t3FSU/eHdfSCP34VR7NLmpJiVC65Fi1XAKOUm8Qutzn5KilJVpybcuSlmLuzO4NbelHJg0xCUMR
 1vkLa8vvzIocI5kUiEeyqPmQiRcfuDQhGq20yWLnuz4Lvxv8bj5RuJiASAG9+PsR1c0BJgBd08/
 oxo6FoTpSV6aYAzwfQ6GZ5Z0WJfx+C783jHQ==
X-Gm-Gg: Acq92OHiM+weUr0Ywvd3/+DoyksOO8yizDt/bKNv3YgCnH4qathenVmQ1czgAnXT6Te
 RxQbpgPnpJJ2VxbTn/ZwyaaUh2wOaTAnlBKRLI/wRn9145EZL+mn+Ah+cDpeD0Q5k4+/njsEMRv
 cHKm0uAjE8pCIO8RyVGzJW1aKbzxV1p6PogNu9olTo4xY1WzRVaC6WakFX7uUVE0dQgo61usqYO
 1pWCOtQ9QbN25GqTE7QDPcw/Jcw8Z/JXAauSD/XeaKK/sAmODmiNb6meCzDCZE1C58KYS7lGSyB
 pplE8u8WnlVvfbLeDmay7hNPTOgUgLXEFzjAyoO/ksvLysXsCgOsajduIkk5trdSCUeqCjXT6SD
 rKv6QZ1y8dPHDtG4+ob5JuzJRvYtd9xzJ+i+FKfPFCaANnSPcyP/t
X-Received: by 2002:a05:6000:40cc:b0:44f:b82f:2d18 with SMTP id
 ffacd0b85a97d-45ea315cf27mr33996284f8f.11.1779748451052; 
 Mon, 25 May 2026 15:34:11 -0700 (PDT)
X-Received: by 2002:a05:6000:40cc:b0:44f:b82f:2d18 with SMTP id
 ffacd0b85a97d-45ea315cf27mr33996254f8f.11.1779748450534; 
 Mon, 25 May 2026 15:34:10 -0700 (PDT)
Received: from redhat.com (bzq-79-177-147-143.red.bezeqint.net.
 [79.177.147.143]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45eb6cd1780sm32386441f8f.16.2026.05.25.15.34.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 May 2026 15:34:09 -0700 (PDT)
Date: Mon, 25 May 2026 18:34:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 pbonzini@redhat.com, stefanha@redhat.com, imp@bsdimp.com,
 alex.bennee@linaro.org
Subject: [PATCH] code-provenance: add exceptions
Message-ID: <0bb3f577eff40a6a834d14db94a1612a2108ec67.1779748353.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

As a first step towards moving with the times, let's add
exceptions. Let's also do what linux does and ask for tags
on ai generated code.

This is not going far enough imho but will hopefully be
noncontroversial.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 docs/devel/code-provenance.rst | 19 +++++++++++++++++++
 1 file changed, 19 insertions(+)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 4e6a9afe0d..c3ed7f5e69 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -347,3 +347,22 @@ requirements for contribution.  In particular, the "Signed-off-by"
 label in a patch submission is a statement that the author takes
 responsibility for the entire contents of the patch, including any parts
 that were generated or assisted by AI tools or other tools.
+
+1. When AI generated part of the contribution is not creative in nature
+   (so not even copyrighteable).
+
+2. When the creative part of the contribution is clearly QEMU-specific
+   (so derived from the prompt).
+
+
+Attribution
+^^^^^^^^^^
+
+AI agents must not add Signed-off-by tags. Instead,
+contributions should include an Assisted-by tag, like this:
+
+  Assisted-by: AGENT_NAME:MODEL_VERSION
+
+For example:
+
+  Assisted-by: Claude:claude-opus-4-6
-- 
MST


