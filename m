Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BEFEFEF4ECA
	for <qemu-devel@archiver.kernel.org>; Mon,  6 Apr 2026 11:53:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w9iVs-0002UY-2O; Mon, 06 Apr 2026 07:53:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9iVq-0002T0-38
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:53:02 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armenon@redhat.com>)
 id 1w9iVn-0002Lq-K7
 for qemu-devel@nongnu.org; Mon, 06 Apr 2026 07:53:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1775476377;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=zThpZTEm2BOIXiICjqzxb0BZkmkd4/Oeo2wTkaOtud8=;
 b=Q3rW8pnQ5kISM6VKzexpdc0hAdD6O7qrWtMHn2nXoo+NJXww3er4zwNpyQZfnyjbb5ZFvr
 1PnbCbcSxxNDpNMs7Mb+xhGL+npZsxyJqVczpPurLbMQi9hCY2vxjlm2kPZOSGvYArrHoR
 mS6SoGAdQ+RXXx+yjPGnmtRKU+atZ+Q=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-gi1fMrRRPzSu0XsmP1ljvw-1; Mon, 06 Apr 2026 07:52:56 -0400
X-MC-Unique: gi1fMrRRPzSu0XsmP1ljvw-1
X-Mimecast-MFC-AGG-ID: gi1fMrRRPzSu0XsmP1ljvw_1775476375
Received: by mail-pf1-f200.google.com with SMTP id
 d2e1a72fcca58-82cf0130d17so2311820b3a.3
 for <qemu-devel@nongnu.org>; Mon, 06 Apr 2026 04:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1775476375; x=1776081175; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=zThpZTEm2BOIXiICjqzxb0BZkmkd4/Oeo2wTkaOtud8=;
 b=ogyaT7oOd7yNVPDuBhEbe3VsuTVBh0ndMr9BdRH1l4iQNhuXJbUUzrraSgF+JA0kKU
 lWQwDdTiE3OfJ0/pH/HCeaZenVAH1HRCu4LJmIBw1QHr1+0hW9cDBLKEpgvFqkxcfRGV
 XKvjtY+VW4bGfjMWrgkZ/Jdcss95RE1oAbjVNL0zD8S2ObT9ihOj3Gi2FV3rP3vwY4Kg
 zex1UXV/KqGPUmFX+uOCy06ht+Usm1tkjo7KwKrUeWwmY3LQ0Bxg+8+qIjSuAUm8oSho
 9YMCj/346wqphbDZFGmMETHnGxaKXv1a+zJjBMZ9rB6PaK/8/PQ7Dz185SEdBEiXYGLY
 MmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1775476375; x=1776081175;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zThpZTEm2BOIXiICjqzxb0BZkmkd4/Oeo2wTkaOtud8=;
 b=aMC7uErfKV7A3RdXnRRxJr4YGZdpAkM+i/hH/CZfPmR3hFXauyh6hP2nFTrlVoanwE
 Wr58TZyNgckKGs/pCxyhnGPACLyh7Gz0UjqRBdn24SCK7zIkEI1IK2BJ16eun3iYRMQc
 ynFZOqIOBPdEQ+zbQSnaxHBH0rcR4ku0gRBi9NkBqiGxnxgyOqR/WDtfyLUuKH9Rm4yG
 WpjOInr6iCsL/j1j7Q/5mYLg0XhGQD6Ka3dSwBAuHO+bFUOhbMWsWEM9H1PQttfCl5DW
 gBmuXRczePsBk1NsmLuE8yN9GQ+/XOHquZQo+QWfZbm7f92I/AWE93GiIuH5/wBKl1qh
 LXjQ==
X-Gm-Message-State: AOJu0YyWCosiUCzp+MAiTgvk/qny65Ic5jhbGmlG4YqJBKNc8m57Lv9N
 HQQ7D9bINRhnnlbI1C84CwcS8TQ5XyX3usV8Bu5YXb/xqHaqI6Lay2cGJe7IzyHfFm7Jl33Ufzj
 DUdMYK+JxRo4zTN6Njxalpgv9LB7Mpt2AsQdXYHw6dKUtNIvdMv6JhLRhmr3JvHCi/VPVpLIfrp
 5ciMRnBMw+9NtFGGKFzdKeShngrv59HCp7klkHzSA=
X-Gm-Gg: AeBDieuHuLFe01HhQoFst/+sBJDk78jaEn2zMjt4xbTwIXJSwXFHlkohCUpCOmMmrrQ
 8YfTr8HnSu7brMXM4+KowO2spb1PsPvivmjfUHKelkGSY42twO3VDEGovgul71ICqg7R5W80R4U
 Ys3uNMqg7vcg0gOsxXSeF8si+Ap/OQxWOCacWdIKUi9VYwaroAKkb5uZIeK2D2LTYik3iWSHPit
 m5VTKe6iBtLF80heXAQMxpXtC91zoV18liPa3DlAxoP4qZ5jnG4k8zq89byhJNEmyMqCOZPgcWK
 8rSBVa1wajv1NtbeAOGBMAnEg+utYkVUggcSzTvw1UW+QZwFQXOuugCu0OFq8o6mnx0eUzC4ab5
 QBg+aKnU5952uPusAqeoiTybwwLo+H9ev546yKv47exWM0v5OIZzgfwfGBGGTqX2ZN3ks
X-Received: by 2002:a05:6a00:2d12:b0:82a:6166:3a9c with SMTP id
 d2e1a72fcca58-82d0db71f37mr11762546b3a.29.1775476374950; 
 Mon, 06 Apr 2026 04:52:54 -0700 (PDT)
X-Received: by 2002:a05:6a00:2d12:b0:82a:6166:3a9c with SMTP id
 d2e1a72fcca58-82d0db71f37mr11762511b3a.29.1775476374327; 
 Mon, 06 Apr 2026 04:52:54 -0700 (PDT)
Received: from fedora.armenon-thinkpadp16vgen1.bengluru.csb ([152.59.100.215])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82d12218738sm11547849b3a.21.2026.04.06.04.52.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Apr 2026 04:52:54 -0700 (PDT)
From: Arun Menon <armenon@redhat.com>
To: qemu-devel@nongnu.org
Cc: Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Arun Menon <armenon@redhat.com>
Subject: [PATCH 0/2] migration/vmstate: Add VMState support to safely migrate
 GByteArray
Date: Mon,  6 Apr 2026 17:22:45 +0530
Message-ID: <20260406115247.4879-1-armenon@redhat.com>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armenon@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.54,
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

In GLib, GByteArray is an object managed by the library. Currently,
migrating a GByteArray requires treating it as a raw C struct and using
VMSTATE_VBUFFER_ALLOC_UINT32. For example, see vmstate_vdba in
ui/vdagent.c

QEMU cannot pretend that GByteArray is a C struct and simply use
VMS_ALLOC to g_malloc() the buffer. This is because, VMS_ALLOC blindly
overwrites the data pointer with a newly allocated buffer, thereby
leaking the previous memory. Besides, GLib tracks the array's capacity
in a hidden alloc field. Bypassing GLib APIs leave this capacity out of
sync with the newly allocated buffer, potentially leading to heap buffer
overflows during subsequent g_byte_array_append() calls.

This series adds a new VMState called VMSTATE_GBYTEARRAY, which will
directly use GLib library API calls to create, or resize the object.
This is then used in ui/vdaagent.c replacing the use of
VMSTATE_VBUFFER_ALLOC_UINT32.

Arun Menon (2):
  migration/vmstate: Add VMState support for GByteArray
  ui/vdagent: Use VMSTATE_GBYTEARRAY to safely migrate outbuf

 include/migration/vmstate.h | 10 ++++++++++
 migration/vmstate-types.c   | 37 +++++++++++++++++++++++++++++++++++++
 ui/vdagent.c                | 13 +------------
 3 files changed, 48 insertions(+), 12 deletions(-)

-- 
2.53.0


