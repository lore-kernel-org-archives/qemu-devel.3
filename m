Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 889FECCFA13
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Nov 2025 15:52:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vIU8p-0005qV-Mf; Mon, 10 Nov 2025 10:49:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8n-0005kI-L8
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:13 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <hreitz@redhat.com>) id 1vIU8m-0000qq-4Y
 for qemu-devel@nongnu.org; Mon, 10 Nov 2025 10:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1762789751;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=af5GtFfITY+8ZJcw7D4xylDZ0e1hu3v0nZGeQF4gDhk=;
 b=NFyCJ5ig4fwyb6VTZ6A5SYmAthyE84NFYRIOjoz52qmTdK2Ib1XBjiYLo23Q0k4T7NIqao
 C2AALIVgzFVB81tpSZUPc2kjcEsOrbX6uR+DykWlOD1cwLjCoOud5b+m6Xqy2Yybt4gwaJ
 3lSfAbJdb+/UacxaiIRa+h0cLsCee4o=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-691-4so3lHFlNzKiPhjlx0vr4A-1; Mon, 10 Nov 2025 10:49:09 -0500
X-MC-Unique: 4so3lHFlNzKiPhjlx0vr4A-1
X-Mimecast-MFC-AGG-ID: 4so3lHFlNzKiPhjlx0vr4A_1762789749
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-475dabb63f2so14605085e9.3
 for <qemu-devel@nongnu.org>; Mon, 10 Nov 2025 07:49:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1762789748; x=1763394548; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=af5GtFfITY+8ZJcw7D4xylDZ0e1hu3v0nZGeQF4gDhk=;
 b=tdE9juEstvN8ZrgtEbv7JtV9KLE54OFl9vbLlPjXJItNBdzBYLA7uAXZLvr02Tjmq4
 IQD2a9Wwt4GCOUyVxp6/8H+l6Zg70Eam8g6K+5tRM9JEOmhR6Z++UUJwy/3y9Rm/2zhC
 iiJ7zaqtBKXcHLAOYcONE3XO9LrKdZQQQxBtMxDl9ncc/T3BrDVgfqA8Oumt3Zt523ob
 Ec8IT430zYISahcUys100Ou/l07WxmckuGhUcqLNroDgWylUQyK7idkEVleEFhc7lnHu
 8XcUuIFQfyoY9Rq5z6vmOnsjwsf5EZyP66chQVObr7r79FAPlRIEPeM315oz+j1QYri2
 9PMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1762789748; x=1763394548;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=af5GtFfITY+8ZJcw7D4xylDZ0e1hu3v0nZGeQF4gDhk=;
 b=Bn277hGPl/vnU2wkS9RXl+fsHqinTQalsz+sXJv2ofaZsP3c53YY2U9zBxYNIkmU8W
 2mODrU0hJjP+hJuKw98MvK5LzIfiwadfczTV5QrFAy2D+YMaCDNMSdJ5GVjDnMDrMMin
 Uh9OTUVfuGnOR7j8zaC8UASQQL8ajw3wdxVbaQUPoUdD2cyRoUaLIdOiDg0VQs/IDGX/
 F8eecDL/H82ZFKbx3ipHsEpimA7AiSNp//XXnz5iSt/ufSgepSeBQqxPvAlnLDOgXhmY
 4GgVAV/6jAjsLzDpLRlbHIWukkmJpg/eV3N3kuFLyRQDrE6mXw3eAKHOxeqUDU6MGbvr
 6DzA==
X-Gm-Message-State: AOJu0Yw7PWV0XwdjnHveKXBLQKPRl/cXZNVIrCG7R0gG0Jiji5jYYLnV
 lXcnltA+C1QP+5VEyf60uLjqfugClWhGullsqy+e+aymLTdTUqusv3Ya6y9gmQ8jarFJ1tdggFG
 G2C0MWbaSLGRmozuow/gFZj40nTIyqndcqRBxEfuNR+HCvWwD+NHC6rWE
X-Gm-Gg: ASbGnctDRfOf/ViZJjs08cCd3IriAglc66ijrBQXKCJ0JyhDgUBR5E5z02co95StHoI
 nnp5im+HMqtaw1WxS/v6RXCO0p6kbqZwM4A6VXyv424oR4OjVOsxl0xzyfGjr5eZ6YF1uLQ1Lqp
 HfBgjWhwILLkfOs46G3FQpSOnmv+7/zwWVizR7e47QqsoBeUsYmJmw1D2XFyRn6E7rws7Mja8zO
 XM3mJ2JeyH8Fp4dSgscaozUpbjLSpI8WtonqMoV7G55voUFbvB7DZDPaLbs6gPKjc0tTVfUr4c7
 FKR02Dm2U1B2P5xOwBcxA+DX/OZCDZHyp0rZwp4OS+UKpqZIFA+ZoGtzigerBaGdApM2JDYBBS6
 x8NS+DNNWdHc5N/KC7XTjiuZ46KsZ/1GstmysRBZTCRwF2fAU24SP9R30/g==
X-Received: by 2002:a05:600c:4fc6:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-4777323abc7mr72005465e9.13.1762789748381; 
 Mon, 10 Nov 2025 07:49:08 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFUryoMUhmFhoOOUE3VcFLEoKVase1d+znZ1gkmToF/zXhqxQiybwwalxUqff+P2lxc7JuPRA==
X-Received: by 2002:a05:600c:4fc6:b0:475:daba:d03c with SMTP id
 5b1f17b1804b1-4777323abc7mr72005245e9.13.1762789747972; 
 Mon, 10 Nov 2025 07:49:07 -0800 (PST)
Received: from localhost
 (p200300cfd7171f537afd31f3f827a45e.dip0.t-ipconnect.de.
 [2003:cf:d717:1f53:7afd:31f3:f827:a45e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-42b422494easm409021f8f.38.2025.11.10.07.49.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Nov 2025 07:49:06 -0800 (PST)
From: Hanna Czenczek <hreitz@redhat.com>
To: qemu-block@nongnu.org
Cc: qemu-devel@nongnu.org, Hanna Czenczek <hreitz@redhat.com>,
 Kevin Wolf <kwolf@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Richard W . M . Jones" <rjones@redhat.com>,
 Ilya Dryomov <idryomov@gmail.com>, Peter Lieven <pl@dlhnet.de>,
 =?UTF-8?q?Philippe=20Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, Ronnie Sahlberg <ronniesahlberg@gmail.com>
Subject: [PATCH v2 01/19] block: Note on aio_co_wake use if not yet yielding
Date: Mon, 10 Nov 2025 16:48:36 +0100
Message-ID: <20251110154854.151484-2-hreitz@redhat.com>
X-Mailer: git-send-email 2.51.1
In-Reply-To: <20251110154854.151484-1-hreitz@redhat.com>
References: <20251110154854.151484-1-hreitz@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=hreitz@redhat.com;
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

aio_co_wake() is generally safe to call regardless of whether the
coroutine is already yielding or not.  If it is not yet yielding, it
will be scheduled to run when it does yield.

Caveats:
- The caller must be independent of the coroutine (to ensure the
  coroutine must be yielding if both are in the same AioContext), i.e.
  must not be the same coroutine
- The coroutine must yield at some point

Make note of this so callers can reason that their use is safe.

Signed-off-by: Hanna Czenczek <hreitz@redhat.com>
---
 include/block/aio.h | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/include/block/aio.h b/include/block/aio.h
index 99ff48420b..6ed97f0a4c 100644
--- a/include/block/aio.h
+++ b/include/block/aio.h
@@ -650,6 +650,21 @@ void coroutine_fn aio_co_reschedule_self(AioContext *new_ctx);
  * aio_co_wake may be executed either in coroutine or non-coroutine
  * context.  The coroutine must not be entered by anyone else while
  * aio_co_wake() is active.
+ *
+ * If `co`'s AioContext differs from the current AioContext, this will call
+ * aio_co_schedule(), which makes this safe to use even when `co` has not
+ * yielded yet.  In such a case, it will be entered once it yields.
+ *
+ * In contrast, if `co`'s AioContext is equal to the current one, it is
+ * required for `co` to currently be yielding.  This is generally the case
+ * if the caller is not in `co` (i.e. invoked by `co`), because the only
+ * other way for the caller to be running then is for `co` to currently be
+ * yielding.
+ *
+ * Therefore, if there is no way for the caller to be invoked/entered by
+ * `co`, it is generally safe to call this regardless of whether `co` is
+ * known to already be yielding or not -- it only has to yield at some
+ * point.
  */
 void aio_co_wake(Coroutine *co);
 
-- 
2.51.1


