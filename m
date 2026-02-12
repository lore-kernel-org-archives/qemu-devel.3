Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 786D1EE3696
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:54:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvs-00077S-Av; Thu, 12 Feb 2026 09:44:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvW-0006GE-7m
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:18 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvT-0006HG-Q0
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907455;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=fQVJ9LSUskFrc7hUqy6BdTg9X2ZnsHe1rHSqlbLzkvM=;
 b=hJJvu666UVQEZXo5D76R4Oy1fDbEbZ7mAn2X7opZthMYAJgymxjGME9xM7ptzNIbAKy6EV
 erxlgNi3avKVJtRQlgbtriwsQaOLvehLPR+JZT8psQqQAdoiVmVu394oi1xUrSm7FPyLjZ
 /aAOObt6Rmn0oEgVQmJ/iXxYlLSJV4o=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-113-AJoXVwE5Ol-QfL5vU7IsNQ-1; Thu, 12 Feb 2026 09:44:13 -0500
X-MC-Unique: AJoXVwE5Ol-QfL5vU7IsNQ-1
X-Mimecast-MFC-AGG-ID: AJoXVwE5Ol-QfL5vU7IsNQ_1770907452
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43591aacca2so2610104f8f.1
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907450; x=1771512250; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fQVJ9LSUskFrc7hUqy6BdTg9X2ZnsHe1rHSqlbLzkvM=;
 b=aB+gWfBg4jlW19ff8r4iU31BXmnu73Dqryhv1myK0ue66nosrDx0ZDrd0b31sMc1b0
 88HNj1UA2VtHnBsQUGOXqECjpWq8kXYjSqWlCEK8jrxh3TTwDQ4blg8fE6SVAf32HW4r
 R6lrWwt1IsqoeaTLM9x7bu69mAMFslI2aNh20MyGgk3qPdB/STN4h+bXB34PZEergisZ
 j/8wDfaEi0+yXrl1+sPHhJv+kNLwS5/F7/ruvLB1iOoVyrYqEN9+86wI5oPkto8zoZan
 ThaNsAa/4T7hL55FGSR2+T9UYsp6DivFjxPuMaQGbKuzw+eyWq7oJanTW9jE8oNCWFZJ
 rBZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907450; x=1771512250;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fQVJ9LSUskFrc7hUqy6BdTg9X2ZnsHe1rHSqlbLzkvM=;
 b=dI/RqV1EnOunml7itKwGnnEoPnPoxxIt7PxrxIrjT8OA+LCcirEI57M3YbizmOBNNT
 E6P0ze3vtviQl6e66AxOq4GScAsCnorCZ87QwnTRDP7w/9MhYAHzFcnt5eQq9RZpj30G
 P1gev8vWXF3JFuloVz54c5Q1bVbkPWDTMzWKywhB606btqnNAbE8HMcR5E9QN7Z5HsV0
 lcLxcJrsGqwRtmuzFu2jMHYZSCmpP77WBXXh2ntk37qHnRLETo+0rnRCqmERWjDl1YV4
 10V6Jq7dhKMdj6aP4CHRYykorusxZIFBbMDGTOcWJZn/VMZvMwwD2tJS3fNEasd4DUGF
 /l/w==
X-Gm-Message-State: AOJu0YyV4CBwOW1vWoqow2sWd+jWvN7fb3w24usZUQ/fOVjEiXpUo378
 EOtR76ykqnddpYbyUWfy58awM8OT5iEoUF2ExFTng9o1ufq/oZ0uz9l8wGyq5WRQJCloFiPA7Bb
 lB8/g3y53CmGZRLbkZqgNR5I7PuMsiSUrdCTTqxxknDKiDMVsyiNkJNcc5H7JAE0YwdnqQX6DAh
 koqIxk766eS2ae7ZNpcMLHK9qpR79CZVDInm1unKd9
X-Gm-Gg: AZuq6aIMiFyHX3DCUpdgdzOxFPj+PEUrDtbyEEJlfZYawzKBKfG9EAZeQ3DkICukV17
 rbmTZYn4V+u218vDM9aP3cl0PpFfKnY/IC6NsVh6ui8T9Dkz9FcZh/1L7Tirw4WAWUx+NFRdCnF
 bKVPuUSnlF81avvm7tihEdt0ruyJsZ0qe10ZYxsNVn/6zRyv+acRSLFLJaa8WOTUtdi73aGmHAz
 rn9efNhlUt8CIKVW3L7J8J9MG2Egd2kN6NDpU/56EVM//nEDWWdcsDYV+HdP/BPtKwI1r6EBT6Q
 if2sL5FJOvEv2rYKl1EtM4L2hlIys5KQzu06tONatPRNSeMZSoTg6AKy/Ki57L5Bf3Qi+n61VGF
 TD1rxbsoGBXdTNseNZ3O7vkzB/hXp8mPGZFaETCAcTbOXsbWE7v2ds2Oy7Y3lP1Pfv/BjtSOw5X
 DylESTfLTVZuY+A8TRPIcmGY9iMJEB/aZ6lIZ2Oyl9Z2BHaj9qCEY=
X-Received: by 2002:a05:6000:2311:b0:436:2356:47c4 with SMTP id
 ffacd0b85a97d-4378f178dccmr4336204f8f.35.1770907450233; 
 Thu, 12 Feb 2026 06:44:10 -0800 (PST)
X-Received: by 2002:a05:6000:2311:b0:436:2356:47c4 with SMTP id
 ffacd0b85a97d-4378f178dccmr4336149f8f.35.1770907449716; 
 Thu, 12 Feb 2026 06:44:09 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43783d34657sm14576178f8f.6.2026.02.12.06.44.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:09 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 37/41] qdev: make release_drive() idempotent
Date: Thu, 12 Feb 2026 15:42:39 +0100
Message-ID: <20260212144244.22579-38-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260212144244.22579-1-pbonzini@redhat.com>
References: <20260212144244.22579-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

From: Marc-André Lureau <marcandre.lureau@redhat.com>

So it can eventually be called multiple times safely.

Signed-off-by: Marc-André Lureau <marcandre.lureau@redhat.com>
Reviewed-by: Stefan Berger <stefanb@linux.ibm.com>
Link: https://lore.kernel.org/r/20250429140306.190384-3-marcandre.lureau@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260108230311.584141-4-csomani@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 hw/core/qdev-properties-system.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/hw/core/qdev-properties-system.c b/hw/core/qdev-properties-system.c
index fe5464c7da1..a402321f42c 100644
--- a/hw/core/qdev-properties-system.c
+++ b/hw/core/qdev-properties-system.c
@@ -232,6 +232,7 @@ static void release_drive(Object *obj, const char *name, void *opaque)
     if (*ptr) {
         blockdev_auto_del(*ptr);
         blk_detach_dev(*ptr, dev);
+        *ptr = NULL;
     }
 }
 
-- 
2.52.0


