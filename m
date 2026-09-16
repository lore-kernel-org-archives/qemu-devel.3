Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C73B2C982C5
	for <qemu-devel@archiver.kernel.org>; Wed, 16 Sep 2026 15:11:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x6rHU-0004pw-8H; Wed, 16 Sep 2026 11:10:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x6rHG-0004ma-9Z
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1x6rH9-0004GZ-Tm
 for qemu-devel@nongnu.org; Wed, 16 Sep 2026 11:10:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789571415;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=2NkEtgKOWDst9bIExK9oubIOYm0vQRtXHvPelFD6VYc=;
 b=LYctQdkO/GYSrCBA+l7QH2Py+dxvbcZyq/hMWlQ1cVsHYoO7ScQp50FmZ4FO6Cf927nnH5
 opi1m8FI/KEqEUuP3faAOfGTURbktaE/esGGtDLyMw8F+P/hf4U3cgOX61haeA2AZl63dw
 1wG/f/EfGAKFNVZOn9OD9MiIcSUqmc4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-444-Q26smeQ0OBq72dyHIt7gLA-1; Wed, 16 Sep 2026 11:10:11 -0400
X-MC-Unique: Q26smeQ0OBq72dyHIt7gLA-1
X-Mimecast-MFC-AGG-ID: Q26smeQ0OBq72dyHIt7gLA_1789571410
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49cdc4080ddso13821865e9.1
 for <qemu-devel@nongnu.org>; Wed, 16 Sep 2026 08:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789571410; x=1790176210; darn=nongnu.org;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=2NkEtgKOWDst9bIExK9oubIOYm0vQRtXHvPelFD6VYc=;
 b=ZIgV6QlCgm3tu0hUlyPJAHjVR5poScu7xBb2CgBFVytQb+YSRINaoPAsRLLFSQt4mc
 HwxOMwg03ptlVN0upX30FaCohFkCX5ze/QOgj5pSSTFoxiMLizgXnufvpQrAMRGDNxCU
 DS7oY12ePl/tNXvepiMM9KeALknK8qCS9InuI9v/l4ph1/FtIVapjNOyyfgw5h2VsUaL
 5mTsC4Cii6jn3amJppAwSd5dUZ5uMi8NedCY2ibgPLY51G9PT5OMiaUZWmVi3hzLVSpp
 mqGgWt/cSYl1AVROEHGeDyjLyCeCanskA7mji7f3l1ss9N5bW5tM2kcrkAL2O6OM9kCt
 NR4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789571410; x=1790176210;
 h=cc:to:content-transfer-encoding:content-type:mime-version
 :message-id:date:subject:from:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=2NkEtgKOWDst9bIExK9oubIOYm0vQRtXHvPelFD6VYc=;
 b=Z3t1b+0b5I3UKB+WUP9rezALQtDWNgY9HOs506jc2uQFbK/gv+DUegrtBvvA8gEPZt
 rWjo74VNR/YI7/emoyo3WlUua29qaaJXYsg8Vb5mojnj2CddwcM1L1KWDejQezOvHh1e
 fDLfmoCjyVtWCWJAmGeCYUMFWv8WyO99eGYiz0dt+WHb50rgsTj4WIYiwI6BbchSWShh
 m2l9hd48Ian9vyg46U4KeTqyP17wU3T3ggFQtnY/mSEEcGKuEdRNjXRfawridty1lK1r
 Ki8uxmPDhKRRb1x150c4GG4qJkyTGT8TLanbbDhMMioDEwSqVCvwNJkKRyWFv1GKiW7E
 jApQ==
X-Gm-Message-State: AFuF++klVHKFSCZhVs4BDytVIxPD/FHQ36HF3+CIFqXokgH1Zx25oRNu
 IlxXNJetpLItQOc/1XkbYbBJ000obW6uTfhxYogBrWKsaiFxTuQFJt6OsMTw2d7DVqSSSHiROrD
 TWGwEUe57hm9fH5QHgUplIRUnxOXFFICge8zmJVCNMHVhiWK2Rq44o5VqiIxfzmVwySe1LJe3Ah
 tAB6PJ5k1o8hQf4EyOTCWebRRLhATJiimDopn682ercoU=
X-Gm-Gg: AYBFou3WPu7ZoeaTy3wpjaI15vX6BWbsdZGgNvPrxTu9al64VpbeId+QdMwf1lNAArI
 z9c4RWRR0AnHdGfPA08rWgakREvCEQEIKOMNvfC2AIve5Qr2cltLvMgY7/K5lY50SM+TU542iUH
 mUgw4LDy/a2ax83Xb68w7BjHv52kvnTx/IbunooQA4iAKtJqK0Y43dR5ZGRExnREzXds9g9dZs0
 P0EiCD/GJP29H8sDN9SVJrCMJkhsw/Nsv0OTvmnyfiiQ+m6P1W8uhULMbc0COq15/7g+ETBof3F
 ev61qZTHdVWDKKGjTMBxpiSsoeUqPJGa1Dh6HI0GoAvWToR7rWrqKKeqM4c5wfCHbKPcA1p0AR7
 QAq5elOvoJGtU7sDd5Dqqkj1gQdQ3yNkAjMISYoNR5bzry+ofTBkBffF5yyaF091nkNKB
X-Received: by 2002:a05:600c:1f94:b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e9669fabamr32509795e9.11.1789571410398; 
 Wed, 16 Sep 2026 08:10:10 -0700 (PDT)
X-Received: by 2002:a05:600c:1f94:b0:49d:257c:a735 with SMTP id
 5b1f17b1804b1-49e9669fabamr32509065e9.11.1789571409684; 
 Wed, 16 Sep 2026 08:10:09 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([151.29.41.106])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fbd112455sm40865e9.12.2026.09.16.08.10.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Sep 2026 08:10:09 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Subject: [PATCH v5 0/2] igvm: fix byte_offset handling in parameter directives
Date: Wed, 16 Sep 2026 17:10:04 +0200
Message-Id: <20260916-fix_offset-v5-0-11cf8ef37854@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/23NQQ6DIBCF4asY1qUBBJWueo+maWBkKotKA8a0M
 d696Epjl2/I9zOR5KJ3iVyKiUQ3+uRDn4c6FQQ60z8d9W3eRDBRMc0ERf95BMTkBmpE1YDlwhg
 EksE7uvy6xm73vDufhhC/a3vky/VvZuSUUSYtb7BWWllxja7tzHCG8CJLZxRbK3dWZIvKWglYt
 dKygy23tt7ZMlsLiOAQmG7UwcqN5ft/JeW01G0tpa6hsns7z/MPIVHj1VkBAAA=
X-Change-ID: 20260902-fix_offset-a268cb12aafc
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>, 
 qemu-stable@nongnu.org, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

IGVM directives _can_ place their data at a byte_offset within a shared
parameter area, letting multiple parameters be packed into one area.

This offset was either ignored entirely or used without first checking it.

Patch 1 introduces checks and honors the offset.
Patch 2 cleanup patch (marks one function as static).

More details in commit messages.

Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
Changes in v5:
- Marked `qigvm_find_param_entry` as static [Stefano]
- Improved commit message [Stefano]
- Link to v4: https://lore.kernel.org/qemu-devel/20260914-fix_offset-v4-1-39d74497c6b5@redhat.com

Changes in v4:
- Squashed two commits in one.
- Removed one parameter from `qigvm_get_param_data` [Stefano]
- Removed some useless variables [Stefano]
- Rebased to latest upstream
- Link to v3: https://lore.kernel.org/qemu-devel/20260907-fix_offset-v3-0-bcffcefc0985@redhat.com

Changes in v3:
- Renamed the function to `qigvm_get_param_data`. [Stefano]
- `qigvm_get_param_data` now returns the data pointer directly [Stefano]
- Added fixes tags. [Stefano]
- Renamed variables to param_data and param_size [Stefano]
- Link to v2: https://lore.kernel.org/qemu-devel/20260904-fix_offset-v2-0-f5bb4cf6d4b0@redhat.com

Changes in v2:
- Inverted commit order: first I introduce the helper and use it where
  necessary, then in commit 2 I handle the `offset`. [Stefano]
- The helper now returns data and size, that already consider the byte
  offset [Stefano]
- Link to v1: https://lore.kernel.org/qemu-devel/20260902-fix_offset-v1-0-04b18f7595b2@redhat.com

---
Luigi Leonardi (2):
      igvm: validate and honor byte_offset in parameter directives
      igvm: mark qigvm_find_param_entry as static

 backends/igvm.c                | 91 +++++++++++++++++++++++++++++++-----------
 include/system/igvm-internal.h |  7 ++--
 target/i386/igvm.c             | 12 +++---
 3 files changed, 77 insertions(+), 33 deletions(-)
---
base-commit: 5f664cd37aec17e8145aa117d8da68f507edc8f1
change-id: 20260902-fix_offset-a268cb12aafc

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


