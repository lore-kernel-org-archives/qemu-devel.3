Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 465A3EA7942
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Feb 2026 19:11:11 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vniBx-0003ch-Ka; Wed, 04 Feb 2026 14:05:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniBI-00030v-80
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1vniB8-0008En-Ur
 for qemu-devel@nongnu.org; Wed, 04 Feb 2026 14:04:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770231882;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0m3fu01MzQJcwZ0QMeUZQcEMiRgauyETG8pOx1+H3bk=;
 b=H4B9qTxDuVp+Cbt1cI56bpxpCWVdkURAajqGJH/TxwY4d32kZOf1v+OMQQgWcldYBaVWSj
 nhggPO1RlDAr7v7I6nMyvTKcIHf+c4oH4yw7BEeuPSLmlQCq1uPy30rustRKVKCjtv/8ho
 wWr2HLE6cvHZtf+TsVQyTDbOd0DFU/s=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-mzLH6MvWNSehEmRLRfj0Ww-1; Wed, 04 Feb 2026 14:04:41 -0500
X-MC-Unique: mzLH6MvWNSehEmRLRfj0Ww-1
X-Mimecast-MFC-AGG-ID: mzLH6MvWNSehEmRLRfj0Ww_1770231879
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43591aacca2so156751f8f.1
 for <qemu-devel@nongnu.org>; Wed, 04 Feb 2026 11:04:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770231879; x=1770836679; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=0m3fu01MzQJcwZ0QMeUZQcEMiRgauyETG8pOx1+H3bk=;
 b=DBd5RF5g75rUhhkreqU3YD4klLsAeRLqsrbJmD9K3axTVaVrZ5PbEr4Bm31GCtL03i
 NORkXxILl5ZYk2I7vNgjMvyZNhmp3b+tSfZmGbglzy+COGM0jb5eY+dA3svmso1rj2fx
 OhOpn9I5u/qiUmEMHThYtWlRfy39/LHIWwLKE6eZxvkzJKrZdXlUEOv/LZw36/GPxCLa
 c8VdHoGx1ZdbadvgQOcb8bWYmX+X+9Q5nJKza0gb03cs1RHCvkQ7ONFyjQQRHGr23tmI
 kKL8kl1pn6WS81yKhs59nX21OEe1lQgo01DuVEWluU/nRk2GtnjXwNNoNouMRwMP9cG2
 q5Hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770231879; x=1770836679;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=0m3fu01MzQJcwZ0QMeUZQcEMiRgauyETG8pOx1+H3bk=;
 b=lh/q1eocpJvkK8LztbahWGrrdKRc8oIdPBvNIvT5tBtkn6QCYvkjDGNwpguW7fTjh8
 Z1EgdHLk9uOYkQXY6z3WB2trMJLIv7GGTpWyPBONUMpp+T00VYEJBbJKsea/Q6ezk5y6
 HhhUArPw8OFWnHhmwPBmKcZq5YeWY2M7Q3CFZ4hWHxPRmesCtljr5wtj7SGDO8C4MdGK
 iB5r8/gxlZaz2xdCuhxeECRin4+K5SMZVkXzwDWo/jheGQLAUXHdIcUb0wjSon8+n0g3
 Tfyo45WD7pwGn39ejOkWYerPgOTKRKr7B8g5c1sPcllZbYPnu6GYU3RyZVzmBZ1Fd8Vw
 lvhA==
X-Gm-Message-State: AOJu0Yydcl0bi46RQeK9BO+d9O+b3b61dMVQya2aUXU2+AGMbiVncZ6J
 xm5p30gtF7BSTt55hs0REU7lMj+rTcHM2dkFdWegIFDvPkg9n53Xj97C7VmuSULr4zUtoM5t9E7
 T/HTpUtxENW0QlY3jioRrJO6G2ixxAa5nms2hmAvsU8G5x76Om3ZETxbyLlb4lTCENCfwbgDBoU
 cOzkJgGaZqfRolN/KBWMrSdbpD4kAgZLXq8Q==
X-Gm-Gg: AZuq6aIVd7FlAEZnuLFrUDEPuR+e3k4CKJouP57emSlnWdw5aBvHeU9Anoc8qTUEMd7
 j4iMOzy5mHkHn1Wupgfz7YpbmTA6AvD7VeBuZokuhMaCOYgTxdbqFvKgjjeCPwK/I9xBfitnkU8
 I1kmk4ZhkCbhHo02NaAaNgbJaoaV9f7spSLYtDXgtDim/uycecChU6Xq+ZeVLgMKvEeA3Tv2WUq
 BXMtzKxeqq+TGgd5fQjn8vdQeqmODWW4HI67k/h0/ZHZ747HUS2iKXzkG9D+WnpCz0J4crFtOdt
 BBaeJ9HwfwqTzSdj7Y7IXY1XPEhre7a3Yv05HIIXNjgkakWCaoGO79zz56gYCQxDXyWMP+00xaA
 CmFXujtkmZla6Z5C7Y5D5Fmutz8sbX+q76Q==
X-Received: by 2002:a05:6000:18a3:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-43618061f74mr6087433f8f.60.1770231878890; 
 Wed, 04 Feb 2026 11:04:38 -0800 (PST)
X-Received: by 2002:a05:6000:18a3:b0:432:7d2a:2be4 with SMTP id
 ffacd0b85a97d-43618061f74mr6087371f8f.60.1770231878317; 
 Wed, 04 Feb 2026 11:04:38 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-43618057f93sm8046826f8f.24.2026.02.04.11.04.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Feb 2026 11:04:37 -0800 (PST)
Date: Wed, 4 Feb 2026 14:04:36 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Maydell <peter.maydell@linaro.org>,
 Alexandr Moshkov <dtalexundeer@yandex-team.ru>,
 Peter Xu <peterx@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Fabiano Rosas <farosas@suse.de>
Subject: [PULL 47/51] vmstate: introduce VMSTATE_VBUFFER_UINT64
Message-ID: <12e2242ea717e1f4ecadba290988d13e7acd1fd2.1770231744.git.mst@redhat.com>
References: <cover.1770231744.git.mst@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1770231744.git.mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
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

From: Alexandr Moshkov <dtalexundeer@yandex-team.ru>

This is an analog of VMSTATE_VBUFFER_UINT32 macro, but for uint64 type.

Signed-off-by: Alexandr Moshkov <dtalexundeer@yandex-team.ru>
Acked-by: Peter Xu <peterx@redhat.com>
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Reviewed-by: Michael S. Tsirkin <mst@redhat.com>
Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Message-Id: <20260115081103.655749-4-dtalexundeer@yandex-team.ru>
---
 include/migration/vmstate.h | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/include/migration/vmstate.h b/include/migration/vmstate.h
index ed9095a466..89f9f49d20 100644
--- a/include/migration/vmstate.h
+++ b/include/migration/vmstate.h
@@ -706,6 +706,16 @@ extern const VMStateInfo vmstate_info_qlist;
     .offset       = offsetof(_state, _field),                        \
 }
 
+#define VMSTATE_VBUFFER_UINT64(_field, _state, _version, _test, _field_size) { \
+    .name         = (stringify(_field)),                             \
+    .version_id   = (_version),                                      \
+    .field_exists = (_test),                                         \
+    .size_offset  = vmstate_offset_value(_state, _field_size, uint64_t),\
+    .info         = &vmstate_info_buffer,                            \
+    .flags        = VMS_VBUFFER | VMS_POINTER,                       \
+    .offset       = offsetof(_state, _field),                        \
+}
+
 #define VMSTATE_VBUFFER_ALLOC_UINT32(_field, _state, _version,       \
                                      _test, _field_size) {           \
     .name         = (stringify(_field)),                             \
-- 
MST


