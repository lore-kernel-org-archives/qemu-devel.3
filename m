Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B7DDCD8C92
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Jun 2026 13:21:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWwNd-0004vf-F7; Tue, 09 Jun 2026 09:20:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWwNW-0004vF-Q4
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:20:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1wWwNU-0000iu-So
 for qemu-devel@nongnu.org; Tue, 09 Jun 2026 09:20:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1781011221;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=XzF3cHrmNVDfg/i23yvmVZkqjmrC9+ZinVmltvevVSE=;
 b=OMqVHPnYcUu7xasCOY52mm8lf89AHFQpnWJyT4lEWVED25NViK2wjuZaaxQ5EMR4vFlxib
 qS2IGa+P03KtCqcXTkfqskXze7/vHsqOXMvRhXAuYVgtbVX2mYBJAz847+6GWCqaCdNZFa
 gzvExAOMC1eIyn08uNnekGdtVG2aTGU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-448-Ct-HTY3rOhatCsg5MFiUtQ-1; Tue, 09 Jun 2026 09:20:19 -0400
X-MC-Unique: Ct-HTY3rOhatCsg5MFiUtQ-1
X-Mimecast-MFC-AGG-ID: Ct-HTY3rOhatCsg5MFiUtQ_1781011218
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-490b3f53c81so25511735e9.3
 for <qemu-devel@nongnu.org>; Tue, 09 Jun 2026 06:20:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1781011217; x=1781616017; darn=nongnu.org;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:from:to:cc:subject:date:message-id:reply-to;
 bh=XzF3cHrmNVDfg/i23yvmVZkqjmrC9+ZinVmltvevVSE=;
 b=GeNh7zZdko9ldpyjAMQg5s0mM4XvU4P11F1VdnRbU8o8PCKcGCo1TU/eIEQy21A8lx
 iQjMu/his8dCxiKkoTxh7+kiCZ1S/XVLISy6BynClDX3UPkVIU5f1rbGS8c6vE5BS7JX
 7AyCRANvZhjZTntJT3crkkohTZvsBt9HIZGA5HL/FmmFU88qyJWrwt6CUa3TSSq7luNC
 xx0ArAWG4yWl48Ch4CLYkCuI4nGpgJgavJ/T3zyqW7CiBFbdN4P/fyVvpGuSKUsA+hWN
 7uYfwo5wJEv0NWnXFpg/rS94Z8zjkV3Vwl/f1Lt4rWfZ8xxxgFq5ml41Kr96roRc+RwK
 OndQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781011217; x=1781616017;
 h=cc:to:message-id:content-transfer-encoding:mime-version:subject
 :date:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XzF3cHrmNVDfg/i23yvmVZkqjmrC9+ZinVmltvevVSE=;
 b=sTR28xNxQ34WVvFbAhx7fpN3w/6aSS3sP1ZnK1sIxNYyiPWsvpU5OSMlt8IO26KpyG
 L41Na/DlPHXj/knBA2WGeA1X2NqLKMfJJeNDsNZ5zWucl/QW0Gxc3tRHrF5PkmZr5B1w
 aD5yjnerq1YsWzWGGTohWVwMr43bdx4BhXfFK4axgCcDMDN96CJdDuHOu/wlwQw1TpSf
 mmPTe+50XqQAB0spVN7RSoAy3OwqzGS7Y7ai/gIJFLRVRJjcppOEcpAcyzRweCGWhps2
 SrmiGu32UjIwbcBDRu9flKDehRb6q9cXj64QoelGBzo7ZkEqjJJvMQZU3wu1ryW0O47i
 YQMw==
X-Gm-Message-State: AOJu0YztBYFB3U3vhyxhCSwjx5pjldNxsqDpvpkau0K1P6pA9Gu3+OIC
 pmTXZjaI9PE/O5MWUZ326oGqE867XSCnGz8OGl0MoyMCj5Z45VFG8yAlT8SvUdO3bBpB6lr6gVX
 +YU/WD7Zp6s0IXCQuwcaKiYMKbqQBXeUgEX+g+5hNSjel7fu8ZVJhy1/A
X-Gm-Gg: Acq92OHqIDsytcQp9ISY10zFst6tqxNtSIU/O7jbDLcFl9erju4y27iXvSz+u0JkwjS
 tFD+1CTIubhjMaDPSoYwRKUUrz8YI4ILNzr52cSUOUS2ffAl4sKwyO7924AfMqP5IbJXOROz8FD
 dmlInEmnqxCCn0qCJGN7Mx6E4vHIYgUnUMJkw2nINXzU5I2UX28ndUe3Ks3OizVqy2okmjVXJZr
 uJ6RX1h4BlTlLIJNymP0lsuyRaa/eSlvPNI+J0t5innN17T0v9oBN04KWIJOwg2YERuq1JEF7+i
 NkjOoKbWWyceq5w81nBW4H03YpqpLL6FCylm0AvkS+h6F7itRc3O1tCiNn7GZvs/Eei6OTe0/lL
 KwQ8YBchvCA30ZxZt3o57rAt2ZEnsDksmNGLl+4EnrdyrHWxLI8wPhd8cfR8C2ncxw75/D4TvEV
 QMYjM0shXZH43NxWDpEVPVgthL1j4=
X-Received: by 2002:a05:600d:8444:20b0:490:48b7:c1ff with SMTP id
 5b1f17b1804b1-490d72239damr26298075e9.17.1781011217603; 
 Tue, 09 Jun 2026 06:20:17 -0700 (PDT)
X-Received: by 2002:a05:600d:8444:20b0:490:48b7:c1ff with SMTP id
 5b1f17b1804b1-490d72239damr26297575e9.17.1781011217072; 
 Tue, 09 Jun 2026 06:20:17 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490bc3e5a00sm476859005e9.15.2026.06.09.06.20.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Jun 2026 06:20:16 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 09 Jun 2026 15:20:14 +0200
Subject: [PATCH] igvm: populate errp in stub functions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260609-igvm_stubs-v1-1-5f39d6e0db4a@redhat.com>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDMwNL3cz0stz44pLSpGLdFGMjA9M0E4tU00QDJaCGgqLUtMwKsGHRsbW
 1AGSP355cAAAA
X-Change-ID: 20260609-igvm_stubs-d3205f48e5a0
To: qemu-devel@nongnu.org
Cc: Gerd Hoffmann <kraxel@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, Ani Sinha <anisinha@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Use error_setg() to report that IGVM is not available, matching
the pattern used by other stubs in the tree.

Suggested-by: Stefano Garzarella <sgarzare@redhat.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 stubs/igvm.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/stubs/igvm.c b/stubs/igvm.c
index 9e9f683fc9..dfb85eb548 100644
--- a/stubs/igvm.c
+++ b/stubs/igvm.c
@@ -17,15 +17,18 @@ int qigvm_x86_get_mem_map_entry(int index,
                                 ConfidentialGuestMemoryMapEntry *entry,
                                 Error **errp)
 {
+    error_setg(errp, "IGVM not supported on this platform");
     return -1;
 }
 
 int qigvm_x86_set_vp_context(void *data, int index, Error **errp)
 {
+    error_setg(errp, "IGVM not supported on this platform");
     return -1;
 }
 
 int qigvm_directive_madt(QIgvm *ctx, const uint8_t *header_data, Error **errp)
 {
+    error_setg(errp, "IGVM not supported on this platform");
     return -1;
 }

---
base-commit: 29c042c6e9d4a09d4a0ac3fa54aeb7ee08ce0bdc
change-id: 20260609-igvm_stubs-d3205f48e5a0

Best regards,
-- 
Luigi Leonardi <leonardi@redhat.com>


