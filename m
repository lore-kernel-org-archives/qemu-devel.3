Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B69A0CA100F
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Sep 2025 15:49:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v0imp-0006vQ-QI; Mon, 22 Sep 2025 11:49:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imn-0006v4-Q9
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:49:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v0imi-0003Wm-KZ
 for qemu-devel@nongnu.org; Mon, 22 Sep 2025 11:49:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758556137;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wye6QrTOk34nowyShYCSXQPYfifX+ttPbSclwNSugHI=;
 b=CwJphzwCHp+ms6BeWsLacjOxSUI5EOaX2N1VfysC/615SPrCFsNV8fqjhzyYcSiW7dD1zM
 a6PUmhIMNJnQ4z6coP7maQZvV2V1PD/9WLrlodMaXJr8hhSMrEVianniLsnosm3BLCrjB8
 UG2vdDvW57fNKkVn8LTSjM4bUUmKqhg=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-137-ZuSQS9_4PZmHSLdp7d_-0Q-1; Mon, 22 Sep 2025 11:48:55 -0400
X-MC-Unique: ZuSQS9_4PZmHSLdp7d_-0Q-1
X-Mimecast-MFC-AGG-ID: ZuSQS9_4PZmHSLdp7d_-0Q_1758556134
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3ee10a24246so3141491f8f.3
 for <qemu-devel@nongnu.org>; Mon, 22 Sep 2025 08:48:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758556133; x=1759160933;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=wye6QrTOk34nowyShYCSXQPYfifX+ttPbSclwNSugHI=;
 b=GlOkVwQ2DWb1ETiutNzJo0ArFOENBp1FulsnQUdY09vyRI3wxQYvYTM00/PzsbuKB9
 VNWCnq/i1kAPLdobg1qDxqUIrTdYbUQUMDhHFE+i6frbNdeKRpe3xsVRMsK8WpwfM3KV
 phC7hsERZCXBRtt8IDyJIdPlxAAXgKOTyUL1FPKi+vbyjCrdfF/db50xnLibKtPlW6Mi
 XtegqpyRnMnJFxN2CzDPMoUxQ67WIT0LkaeHDsZLD5sOwz96/1F4qb60soen+1O90TeA
 OP0tctVGWJm93Vf11VZVhLplv1ChdOX0cLxYm1KpPFsTatMbg6XySbpzVkEU0FPkf1w9
 aD1g==
X-Gm-Message-State: AOJu0Yw21nbWdjRqhliMIYD88tpvPf6h/ew6e8dE0Md1UD0c5hZBg3GT
 0GiL2Ee7coF605vewex75ps4MwRWacHy5wy0gNZ+IRekDQdSON1US18wPdWmMbWJ7QbysJFnJjl
 qxM2xBH/r0FqzYSEolOZuL+6FH3Ry8OT2rF3Le91qIbms5LrjLYq16sgK2Z5tZVn9AAfzrDjN6F
 aozou6CE8DfF1EbFWzLjJIPLUcNa2GfnWDs8PVafkx
X-Gm-Gg: ASbGnctge1UEoRwx4Ss6+efdasJvJIqyQA46nOTCP+bijWIa4P7ojPvGIx9rdff5PkK
 jUHNQrhVmqCJGqaizak12NgKLQp8hYAjOJrjPRH1fI6KkrVL6dL6RTBljxYfLTil4woBucDho1R
 /+/6/YlGeFc4opLcMDpcypMekgECHB+xWnAtfEab6lSleZTmb1HmgpkNHVZh5+VDlI4nJh2d+Wv
 awP8XNYXSGMF48IXEd+9Guf/iIjT2N103Foz2HZW4K+lrVSie6oOqXE06CMua+kTc1PGtSqNNl/
 b9XjrtqC/ddY5vTSQtXubLyHRt7I2RXwDxWeS6tQkSYMRNb05QFxVuW66QVueQnr79upAzitBMc
 867g2FOnXr6MSU9AFwDcYQCpvnyE6sGZfXNFyo0eoHIU=
X-Received: by 2002:a05:6000:4029:b0:3ec:2ef7:2134 with SMTP id
 ffacd0b85a97d-3ee7d0c83b9mr10878041f8f.18.1758556133328; 
 Mon, 22 Sep 2025 08:48:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFs2rsTd1PUTg8hjzb0yT3D7qzXaQZN3W71uMZ89neRadHMZ18hh0UDpxfNkd5qUGxpijY1Wg==
X-Received: by 2002:a05:6000:4029:b0:3ec:2ef7:2134 with SMTP id
 ffacd0b85a97d-3ee7d0c83b9mr10878019f8f.18.1758556132831; 
 Mon, 22 Sep 2025 08:48:52 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.47.123])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3ee07407d33sm20543222f8f.18.2025.09.22.08.48.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Sep 2025 08:48:50 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 =?UTF-8?q?Daniel=20P=20=2E=20Berrang=C3=A9?= <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH 3/3] docs/code-provenance: AI exceptions are in addition to DCO
Date: Mon, 22 Sep 2025 17:48:42 +0200
Message-ID: <20250922154843.60233-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250922154843.60233-1-pbonzini@redhat.com>
References: <20250922154843.60233-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

Using phrasing from https://openinfra.org/legal/ai-policy (with just
"commit" replaced by "submission", because we do not submit changes
as commits but rather emails), clarify that the contributor remains
responsible for its copyright or license status.

[This is not my preferred phrasing.  I would prefer something lighter
like "the "Signed-off-by" label in the contribution gives the author
responsibility".  But for the sake of not reinventing the wheel I am
keeping the exact words from the OpenInfra policy.]

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index 103e0a97d76..41062f29639 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -341,3 +341,9 @@ or more general revisions. This can be done by contacting the qemu-devel
 mailing list with details of a proposed tool, model, usage scenario, etc.
 that is beneficial to QEMU, while still mitigating the legal risks to the
 project.  After discussion, any exception will be listed below.
+
+Exceptions do not remove the need for authors to comply with all other
+requirements for contribution.  In particular, the "Signed-off-by"
+label in a patch submissions is a statement that the author takes
+responsibility for the entire contents of the patch, including any parts
+that were generated or assisted by AI tools or other tools.
-- 
2.51.0


