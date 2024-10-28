Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A32A7D3398E
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Oct 2024 14:30:42 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1t5Ql9-0000Fl-6O; Mon, 28 Oct 2024 10:30:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkl-0000AX-P7
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:56 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1t5Qkg-0003iR-Su
 for qemu-devel@nongnu.org; Mon, 28 Oct 2024 10:29:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1730125790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=j+Vr9TnjLU2a58qM6D2/5EPfpLYLf3sVQLHOXY3Mmj8=;
 b=fsJ+z9SRyyqmiMPB9a7FnrX11RtJq1vhn3BoII0PXahw26gqYcKKQA60lOIYMWqXwR4ab/
 1RSzhtU7dgp7Qc6X+wyP4GX3W/eKplNnMOyQPLV1nxBHXW3Gl/30G6gFxuCctHsEnFFt+l
 kCRGDFd9di8BId6eRkxPqT5yQFZoy/M=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-xM5EpvVWNbC2N3jwXuMlKA-1; Mon, 28 Oct 2024 10:29:49 -0400
X-MC-Unique: xM5EpvVWNbC2N3jwXuMlKA-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-37d603515cfso2081151f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Oct 2024 07:29:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1730125786; x=1730730586;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=j+Vr9TnjLU2a58qM6D2/5EPfpLYLf3sVQLHOXY3Mmj8=;
 b=RQ9jLOCzb/Y9/PoBjtjcfjMOfl72HugUuOzdRRsls97OINeDZAnhPf4QDznQCj/ZzP
 hMGxcOvc17d5XaXV2kpdzM3MfYtvMASkXX1t/V2iM9c8AyvkNMefNbfSH83G5uLxPZRT
 kfOTPdsijen4HlcGnYGVh3ySj6dip0FyDC1D+FXkhMm2SdmRvqJJTCJ4mo5XJZf/gXNg
 8CCD6lKRAo6qgA2dv+JtJ1iXKA1ddXaD5O3NYGwj3EJoJrgHKR1/PE9yv+X5mSSw/cbg
 DnKo3jt6Y7qDkMxCJwlClglm0wCfIl9SbWm4oBljecNLmSD3WbErwx+GHKibZbjlgGDI
 KYow==
X-Gm-Message-State: AOJu0YyR3spXHAm33T9teSNAomwfaKGHYur8An2XXHK9yXCbwmNluFkk
 Vc/cYj371ED2+sICoSxz8R/J36JoV+GgQdcEiMiKOd3PBpZO1WzWL4UG7uMJcVrkZBQluq224aD
 fhDU6bAXWfWq8nhemIQpVeZtjzYfJ0ctcqcoZHSf95QBzkDYePA+nSJSlnpKat6MgVtmfgTljVH
 53ir04i46NaDr5FsfKsaEh6a2irhQkBeCKQZj83AE=
X-Received: by 2002:adf:e04d:0:b0:37d:509e:8742 with SMTP id
 ffacd0b85a97d-380610f81abmr6316738f8f.1.1730125786118; 
 Mon, 28 Oct 2024 07:29:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/CXwrMFQdSkB6/fmNR9k2EjB4T2i7dgE+/E7muL7rwJ0LrXajM490vFiP992I/0tYGDmuIw==
X-Received: by 2002:adf:e04d:0:b0:37d:509e:8742 with SMTP id
 ffacd0b85a97d-380610f81abmr6316724f8f.1.1730125785704; 
 Mon, 28 Oct 2024 07:29:45 -0700 (PDT)
Received: from [192.168.10.3] ([151.49.226.83])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38058b4a3cesm9562946f8f.63.2024.10.28.07.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Oct 2024 07:29:43 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>
Subject: [PULL 05/24] scripts: remove erroneous file that breaks git clone on
 Windows
Date: Mon, 28 Oct 2024 15:29:12 +0100
Message-ID: <20241028142932.363687-6-pbonzini@redhat.com>
X-Mailer: git-send-email 2.47.0
In-Reply-To: <20241028142932.363687-1-pbonzini@redhat.com>
References: <20241028142932.363687-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.373,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

From: Pierrick Bouvier <pierrick.bouvier@linaro.org>

This file was created by mistake in recent ed7667188 (9p: remove
'proxy' filesystem backend driver).

When cloning the repository using native git for windows, we see this:
Error: error: invalid path 'scripts/meson-buildoptions.'
Error: The process 'C:\Program Files\Git\bin\git.exe' failed with exit code 128
Link: https://lore.kernel.org/r/20241023073914.895438-1-pierrick.bouvier@linaro.org

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/meson-buildoptions. | 0
 1 file changed, 0 insertions(+), 0 deletions(-)
 delete mode 100644 scripts/meson-buildoptions.

diff --git a/scripts/meson-buildoptions. b/scripts/meson-buildoptions.
deleted file mode 100644
index e69de29bb2d..00000000000
-- 
2.47.0


