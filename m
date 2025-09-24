Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C78CAC5B5
	for <qemu-devel@archiver.kernel.org>; Wed, 24 Sep 2025 09:32:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v1LqM-0006ja-6z; Wed, 24 Sep 2025 05:31:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpW-0005wD-3x
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1v1LpN-00055r-FY
 for qemu-devel@nongnu.org; Wed, 24 Sep 2025 05:30:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1758706218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o3Vto+snCtjNXaumgbXK+T8T39rA/AJYllmWXUTaf0k=;
 b=bIlf1MCz1G4F+ZpMPK7jJL+DKr2hIsNTulllt7I8FMcZhNzQVsC9hLuHTvZ+69ISdNygxH
 VAxCTxbTZetM2a1Dfl+ofBuUH7HwQkCEhmHJDgcu6cA005WJKN2ZE45RGO1Hs/RbmBDEti
 CELAdhrAb9HZkUYXYmcRUQDv7OzIzMA=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-477-N0Uuu8ETN1GUCvw3GkErpA-1; Wed, 24 Sep 2025 05:30:16 -0400
X-MC-Unique: N0Uuu8ETN1GUCvw3GkErpA-1
X-Mimecast-MFC-AGG-ID: N0Uuu8ETN1GUCvw3GkErpA_1758706215
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-b2fca156551so75438866b.1
 for <qemu-devel@nongnu.org>; Wed, 24 Sep 2025 02:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1758706214; x=1759311014;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=o3Vto+snCtjNXaumgbXK+T8T39rA/AJYllmWXUTaf0k=;
 b=HohaZuVIh0B3Cjk3Xq9cYVodRAIBITf+d/VVjfyc9Le0BJ9snvzBLyXrgTK6iXMBsF
 a519DhOCfsuymkPwZ1zpzOY+MOD73tqy49HC6uY85fEdX6FVMs79tGAMlzNkHOd07TXB
 FJ7s4CrwPWP+UZPLq2t2vtjsSu01NFAAT1smy3lUba+aHep2L5k18GZg9rCMxPJyo9hr
 4OWv8lqUU0wcLGxZCqpmFQDMKHfBuz1PZJhkesezYKgW/GepBJztBw+vwu5mlK744C8Y
 xroYinHXFAFJ7VXdaLtsD6HVug7zFtcQoDOYbedD3U5D/+ZF0RBVqpX+iBNT75sQ5kth
 krpQ==
X-Gm-Message-State: AOJu0YymYzapBivjFNApRDsCYx6SfLaPETC6gOM/5qGdDq/2H6EdRopr
 YtUaMRwnAssHMzZHa/67PzwiDC2z0qwg4jxfVLUjJabt0s3j4ioHMgCK0cKWALnz2guJGAtcOQw
 Rhp7Drf9Ae0TeQ7sjT7gg8PcqiX4ij/hjgrJpIk9alaafuO3acDbW7yev1YEKXlyZlAxvDhOzko
 lmlcfM3OBbSPqUCEoVVJqthlmspFvcAPuu20e1cTBP
X-Gm-Gg: ASbGncvsf3AaJIgcd+/LZ8/rJuIKFpYiYFW5gmDzyrx9rSvjdJkTGnRbZCVi7L6PkDa
 rMh5RTOslu7r2nOSRGAkhzNZ8asyQZaFNXJq0e/bp5H3zppmK+m+2eVXz5oRK4WzJwHo15qIW5d
 yQG4O/Df3z8AVXid+TA0EI5z7NvJWmFZ/qJ8/R7PtquxzSXiiDyXVXvrjUKiMjRpRZlkp/8yuru
 3G/ebdmkrol1E6SSr5WRTIZBdhCJtuKrffx6G9Fsn4ntmJMfY8UTUCHHz4zxVA9o/uo+pLWIxgL
 Nopj5OuE9zgnZzMXfXDKf/+eKFJAvAPLS3jlOudycviAWJpkwaDWXwrzpJxfUlfBM5B0v6AOYZ8
 BJUAxVrCS6RbZaXq3BjVCn7lES3z4LWVN/z1q/kOcdsyo/Q==
X-Received: by 2002:a17:906:c114:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b32ca37f1aamr206054166b.16.1758706214355; 
 Wed, 24 Sep 2025 02:30:14 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH28+ROajyM4RrVwHCB7tj1EZOrG6XKTMXPV2YrkUMJ6Zop5uSYSlridsC3Js59JYpLc7U29A==
X-Received: by 2002:a17:906:c114:b0:b07:87f1:fc42 with SMTP id
 a640c23a62f3a-b32ca37f1aamr206049666b.16.1758706213738; 
 Wed, 24 Sep 2025 02:30:13 -0700 (PDT)
Received: from [192.168.10.48] ([176.206.127.188])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-b2cfdcc2d12sm623801066b.60.2025.09.24.02.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Sep 2025 02:30:10 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Daniel=20P=2E=20Berrang=C3=A9?= <berrange@redhat.com>
Subject: [PULL 28/29] docs/code-provenance: make the exception process more
 prominent
Date: Wed, 24 Sep 2025 11:28:48 +0200
Message-ID: <20250924092850.42047-29-pbonzini@redhat.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250924092850.42047-1-pbonzini@redhat.com>
References: <20250924092850.42047-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.442,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

QEMU's AI generated content policy does not flesh out the exception
process yet.  Do it, while at the same time keeping things informal: ask
contributors to explain what they would like to use AI for, and let them
reach a consensus with the project on why it is credible to claim DCO
compliance in that specific scenario.

In other words, exceptions do not "solve the AI copyright problem".  They
take a position that a reasonable contributor could have, and assert that
we're comfortable with the argument.

Suggested-by: Daniel P. Berrangé <berrange@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 docs/devel/code-provenance.rst | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/docs/devel/code-provenance.rst b/docs/devel/code-provenance.rst
index dc3524ac177..6968d54be8a 100644
--- a/docs/devel/code-provenance.rst
+++ b/docs/devel/code-provenance.rst
@@ -331,8 +331,13 @@ ChatGPT, Anthropic's Claude, and Meta's Code Llama, and code/content
 generation agents which are built on top of such tools.
 
 This policy may evolve as AI tools mature and the legal situation is
-clarifed. In the meanwhile, requests for exceptions to this policy will be
-evaluated by the QEMU project on a case by case basis. To be granted an
-exception, a contributor will need to demonstrate clarity of the license and
-copyright status for the tool's output in relation to its training model and
-code, to the satisfaction of the project maintainers.
+clarified.
+
+Exceptions
+^^^^^^^^^^
+
+The QEMU project welcomes discussion on any exceptions to this policy,
+or more general revisions. This can be done by contacting the qemu-devel
+mailing list with details of a proposed tool, model, usage scenario, etc.
+that is beneficial to QEMU, while still mitigating issues around compliance
+with the DCO.  After discussion, any exception will be listed below.
-- 
2.51.0


