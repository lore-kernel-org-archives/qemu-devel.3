Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24D9CF9936B
	for <qemu-devel@archiver.kernel.org>; Thu, 23 Apr 2026 10:32:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wFrKn-00013r-TF; Thu, 23 Apr 2026 06:31:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJk-0000Z8-Ut
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:30:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wFrJj-0005NM-GU
 for qemu-devel@nongnu.org; Thu, 23 Apr 2026 06:29:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1776940194;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rdylYCYaibZL9hnF4r7zw4wbjkS++okPS4qty1yblkg=;
 b=FvD+oDoOxL1QoQJnRP+hfhMSoomTi5f0lzGT2G08Lia0qpKTrWlMxinEAEWN7Nllzw1gIH
 MphH+AcoM2WF6ixDBu7/C4p2hwcQMcUjSznCuWp3lrxYanAXXRXfId11T1RICAZ47kv/86
 6YNqUz+6/Xz4JfkBFcdTBItPpWVv0xg=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-42-35Y2LagMM7qmxg6n7MoK8w-1; Thu, 23 Apr 2026 06:29:53 -0400
X-MC-Unique: 35Y2LagMM7qmxg6n7MoK8w-1
X-Mimecast-MFC-AGG-ID: 35Y2LagMM7qmxg6n7MoK8w_1776940192
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-43d77286244so4296446f8f.1
 for <qemu-devel@nongnu.org>; Thu, 23 Apr 2026 03:29:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1776940191; x=1777544991; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rdylYCYaibZL9hnF4r7zw4wbjkS++okPS4qty1yblkg=;
 b=l+YfKlnFnhem7RG6mxJ4dl0KTQfknhwpSuhqYMnzmgRQ9YIwnMtF/Ir+uWEYlzgwjF
 Z8a0gp8SOU/b4gc4k8glzHIorffKDtmctce1ivD7zugs+aVLXBlSOTw67r8TgbICmfwG
 amECgh5N2oZloEsr1RFINSotyCFJBon2N5oW8D8EfJGZNzpnhcQJqayz0JjEsFkim2X0
 ZypbdnwHxxLiXNNAN9p214a/bhX5BObt7DKMvxxywushuJ3Hms/TqLweCYDNYX+3dckW
 WxPp1ZmwEiqNwiTU+6n0diaAPY2i9y6FtqJoFYZZKIfIwrXr57Qh31VtFqWopEXSMxCc
 sA9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776940191; x=1777544991;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rdylYCYaibZL9hnF4r7zw4wbjkS++okPS4qty1yblkg=;
 b=NTCmPfkislSQJeYsAcUR1QzCC7IGoPgwBjbMMge0GiQrMs9JQX1Y86X2e3LpPj6Z/H
 coFE9Aupb/V0tQiPv//DWrhZiBO0hZ48etVZ5qumfnYsS2yzSFnfmevZgqGl2zWf+RBf
 8+FzfOMBz5JSatmJUsI3DrjIQ9mb7Y/iov2ogG0kRRX3XVab+sX++2U8BhglpUjs+KXV
 dmd98affSGRYlxQJ5FwaIjr1hEh2lQ9V1Kg5EBTWooAMPr9oW9jRZ0V2kzGslcq7cJZv
 +ajfcD9V+n+dno84SfpEy8wM6e/XwaJV57Am2z9rqwiYbY/M/R6rDdH0xsdLyoZt0KoK
 3FuA==
X-Gm-Message-State: AOJu0YxHtFWZ1YjLmyPs+/vrLCME4hGIJcUQZRKsYFDAC7M66wfm+t2Q
 efFBdOPCYxmXwg3DkIXgjzshy/54TP7af+1Mshq3c6ZdLQGGPwYegY6g6ngW9BILek6Vyc5OMvf
 6bdhtoHrmmZaoi9RtK1LaHUigB4GnwrDHkFdI0EsIHlmS/7ZWzFRImKCBN2gmAyjqSz5AfQxilf
 YH0iG1GErQwOncz7ng9cxdyzHAPpRf/ocNxcdQGPWI
X-Gm-Gg: AeBDiev6ynvFCPhvSSBEHRLUIG7Ap20Gpnyjz7b4PFQuJn0Cy+N4TY6x5bRBV7f1Fi3
 z3iOVzf43ZIfIIDu7p+Pzb8Gc041rF9WgAUMAHlCwJwb7PVN0SPr9eMJ9idaV07Ie+bZueo7Vtv
 5CsYRB6/9/TGYzX12cFDIVhp/oQEFlC2QYClRPqImkV6xuqBu15OhoxM3h+ME7MJPAkzvCxSwwW
 oP+HfGhr5iPKschkPMnLTAl0LlwTPXuHclgWT/2lCY1JZm2csoKyMyUn1OwLyU8pJxq3mDVxHdd
 WSI7TCMrGDOiPLxCOIwoDHNwR7XT5T7l1/jmIdbIsVXeJzcvfIj/fAuuLqefksG1kvpqK9Kou3D
 CeW/b9RxMdLwfAraW25Gra6AKYvAhXqrXV1Zg0BOPm+l+vcWvy1rGk6TqKxB5gRR/uX/3zssS8A
 rkFDWEZZdQQxVJt3H1D+/0k11pFAspk33Bjl8=
X-Received: by 2002:a05:600c:46cb:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488fb744fbemr375426855e9.7.1776940191410; 
 Thu, 23 Apr 2026 03:29:51 -0700 (PDT)
X-Received: by 2002:a05:600c:46cb:b0:488:a723:ea53 with SMTP id
 5b1f17b1804b1-488fb744fbemr375426385e9.7.1776940190887; 
 Thu, 23 Apr 2026 03:29:50 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc10019bsm524458115e9.4.2026.04.23.03.29.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Apr 2026 03:29:48 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Kostiantyn Kostiuk <kkostiuk@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: [PULL 10/25] target/ppc: Use glib2 instead of strcasecmp/strncasecmp
Date: Thu, 23 Apr 2026 12:29:07 +0200
Message-ID: <20260423102922.443639-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260423102922.443639-1-pbonzini@redhat.com>
References: <20260423102922.443639-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

From: Kostiantyn Kostiuk <kkostiuk@redhat.com>

This is a change in semantics. g_ascii_strcasecmp() doesn't honour
locale but strcasecmp() does. But this is OK for at least one reason:
 (1) QEMU always runs with the C locale so there's not an actual
     behaviour change here

Signed-off-by: Kostiantyn Kostiuk <kkostiuk@redhat.com>
Reviewed-by: Peter Maydell <peter.maydell@linaro.org>
Link: https://lore.kernel.org/r/20260327134401.270186-9-kkostiuk@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/ppc/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/ppc/kvm.c b/target/ppc/kvm.c
index 41bd03ec2a2..25c28ad089c 100644
--- a/target/ppc/kvm.c
+++ b/target/ppc/kvm.c
@@ -2653,7 +2653,7 @@ static int kvm_ppc_register_host_cpu_type(void)
      */
     dc = DEVICE_CLASS(ppc_cpu_get_family_class(pvr_pcc));
     for (i = 0; ppc_cpu_aliases[i].alias != NULL; i++) {
-        if (strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
+        if (g_ascii_strcasecmp(ppc_cpu_aliases[i].alias, dc->desc) == 0) {
             char *suffix;
 
             ppc_cpu_aliases[i].model = g_strdup(object_class_get_name(oc));
-- 
2.53.0


