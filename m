Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A6BCD98E4
	for <qemu-devel@archiver.kernel.org>; Wed, 17 Jun 2026 14:33:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wZrIO-0006fu-7A; Wed, 17 Jun 2026 10:31:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIM-0006f2-7u
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wZrIK-0007jV-PS
 for qemu-devel@nongnu.org; Wed, 17 Jun 2026 10:31:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781706668;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EH6vLQx69LKkn/UoQpajyvXS20+hjihuCDTQ5EJvEOg=;
 b=FxO1XhNWRfn+5fhpeuWdnzOUUuUkhTK+iLZZrOI3jSzobDpN0y+XEz66IHpPLiHfA8PisH
 1sMEqNMVnbl0HNnOoyjKtVHD6Rj/hR5jXXqyi0isy1e2A1OdjoWtmT8HlGW4RcH3VacY8k
 YZYoY9mwuh3k5ZvbvypOzvxd+FBZL9I=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-449-xDkSRNmmMiOBxM49ZgyG0w-1; Wed, 17 Jun 2026 10:31:05 -0400
X-MC-Unique: xDkSRNmmMiOBxM49ZgyG0w-1
X-Mimecast-MFC-AGG-ID: xDkSRNmmMiOBxM49ZgyG0w_1781706664
Received: by mail-ed1-f72.google.com with SMTP id
 4fb4d7f45d1cf-68d23404bd2so4531294a12.2
 for <qemu-devel@nongnu.org>; Wed, 17 Jun 2026 07:31:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781706664; x=1782311464; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EH6vLQx69LKkn/UoQpajyvXS20+hjihuCDTQ5EJvEOg=;
 b=LR8M9DA4gG6e3OQEzHQrOWaUxMRg3YfATDmMvNln7RBE+c4Qv3qK1eoRAslU+wF/Hb
 3LXOit2dVe2rEkY/keADyi06ry/B9el1f/ZZKXo5IeKpufGoiyi4bLQEUMox3xh/2+5w
 MQhZV1uExQG9SFG8348I93aODDzIwhQrKKx1PYcUCOI/B09WhYZe1rz5GUKQFV/DxH8H
 Wp2jpBmh05lDSwt6Uc8mIMy0/0cdrVW0g+ckrKQEytQ5Oa938LZ6G9FW0EkNCYc1dBwI
 vfGcedq+L1UsCaBjOZcyBCB1zF4bXP7NTcwJl6HuabDxx7/Yw9pW+R8/Ua+/dZhVs7Qi
 XtlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781706664; x=1782311464;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=EH6vLQx69LKkn/UoQpajyvXS20+hjihuCDTQ5EJvEOg=;
 b=lWr2Px/dpvxLW2MA0g3Ll8DiJjoWVqkQeu2PyG/qf4dPnAnBLVLatdkcVmnXvI2OTq
 mE1FQ519b7E65ZKfPpPWS1sQutK2quDKlvD7gs7xPYWlSr4c3MlkHBNVgRec+AsvfnRx
 SE1A+1Fq53dxTTykJHroQIb11jL68vtBKR/yoKigOrZvawF1ITXSbrRrpaE6f1qedB/O
 sV4BrKgfe/tkAEjbT5t/qLascmn5eI+PpUunHJ5ehcdHRLkIdW9Lgh88auHFGExYfjGr
 Q/ytZzU2cOYN8hd+pgSGZVAfRU31zzwEiB1XjIzIgVzyGNsdVE1OaE/NUY3rBF1t8JW6
 DuJA==
X-Gm-Message-State: AOJu0Yx5lirMiOHxenWeLL5iPVSlON2UQbH+SWulQKa2EYhE39CLUYFZ
 qCbMEqVA/X6h1tcidl1c+blIMgCaJcxlEh1cCB2BMTTN4Dhv7lVvFUXib3/SdpeeR+G0L/GLttw
 IOZjggiQq6cL/DNV83N7MkZ5fTIUAeLf5CZHyXKc7ay/wq3XX0ZZGSYeIdcZMxutVexAjcAeWSW
 fyxouWms8DyRqIEpZOm8f+fa3cyF90IMEfAEAT6o64
X-Gm-Gg: AfdE7cnYxnFbLIwTLWz5UBr+5/mFLEp+//si5lo3F3ihfkFIW98s3zTf+UgqQi+nyJ9
 OCa+WZOSPrEgiLkvzNntW8OzuNr2FaLS7d6WqYP8GYspGkbDSoJ9pUVhUmahjSX0snyMygUWprs
 lIpaFipRoirchvhAjZbb3jIYYkdGj0xDH0C9gwN2Ot/QzMVoSwRqQ1AdjW3Xd0M5WskuNabAjl3
 iuGWB+ixzdBjLbs1CwFY3gJUcNiUwfMlwX24klJSC5KNnlQcxtVMOcQfHqK5Zfl2mDr0T/UQhQ9
 3XzrL8pia89ellsQk54U3G0+DNI4Dwlnk2wBu2vhdfGkoPuO5vzoooir4Y9klUr6JUTun8yDw2b
 RdN+gJ3USG5q4+YiCMvC4YXZBfJk1ynpjpVluijmOQAQjezvhzimgG3cm8UxSmm31uBUdyRTlaI
 Bml3Fx2KwFsncrlxn0
X-Received: by 2002:a05:6402:40f:b0:695:b7da:10f5 with SMTP id
 4fb4d7f45d1cf-695b7da674fmr142623a12.28.1781706664298; 
 Wed, 17 Jun 2026 07:31:04 -0700 (PDT)
X-Received: by 2002:a05:6402:40f:b0:695:b7da:10f5 with SMTP id
 4fb4d7f45d1cf-695b7da674fmr142578a12.28.1781706663543; 
 Wed, 17 Jun 2026 07:31:03 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.156.160])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4606f2b0d4fsm58960463f8f.24.2026.06.17.07.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 07:31:02 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Damien Zammit <damien@zamaudio.com>
Subject: [PULL 06/16] Add GNU/Hurd host_os=gnu
Date: Wed, 17 Jun 2026 16:30:36 +0200
Message-ID: <20260617143046.445322-7-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260617143046.445322-1-pbonzini@redhat.com>
References: <20260617143046.445322-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

From: Damien Zammit <damien@zamaudio.com>

Signed-off-by: Damien Zammit <damien@zamaudio.com>
Link: https://lore.kernel.org/r/20260208055858.2166524-3-damien@zamaudio.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 configure | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/configure b/configure
index d786d3a7c9b..bf728d6d993 100755
--- a/configure
+++ b/configure
@@ -371,6 +371,8 @@ elif check_define __APPLE__; then
 elif check_define EMSCRIPTEN ; then
   host_os=emscripten
   cross_compile="yes"
+elif check_define __GNU__; then
+  host_os=gnu
 else
   # This is a fatal error, but don't report it yet, because we
   # might be going to just print the --help text, or it might
-- 
2.54.0


