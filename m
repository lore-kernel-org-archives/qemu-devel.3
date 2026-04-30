Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5343BFF886F
	for <qemu-devel@archiver.kernel.org>; Thu, 30 Apr 2026 09:07:10 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wINLb-000880-5Z; Thu, 30 Apr 2026 05:06:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLP-00080i-5o
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:04 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1wINLN-00039W-PT
 for qemu-devel@nongnu.org; Thu, 30 Apr 2026 05:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777539961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YfM3ykU/X5hsW2yBakiqUkVOi+VtddjsDKcbCGz8Nts=;
 b=U17VUv4FjSlwlJwrEcAmOK9XWNjqQMcHuZpkDKay9+qe+17G3rpy5cq7c+aDBC4qbnv0lB
 qKenhlA1sGnpfEE9+duqHXwmbIYLcPDjhTS6NztX0c3cdQhZI3dAGyRkA4Z1MnsU5XxPZv
 eaips/Pahs2gD+ZRVzO95WDMgI9eKlY=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-q2g6f7rVNRqSB0v_wlvV9A-1; Thu, 30 Apr 2026 05:05:56 -0400
X-MC-Unique: q2g6f7rVNRqSB0v_wlvV9A-1
X-Mimecast-MFC-AGG-ID: q2g6f7rVNRqSB0v_wlvV9A_1777539955
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-488c2cc0cbaso6462555e9.3
 for <qemu-devel@nongnu.org>; Thu, 30 Apr 2026 02:05:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777539955; x=1778144755; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
 :reply-to; bh=YfM3ykU/X5hsW2yBakiqUkVOi+VtddjsDKcbCGz8Nts=;
 b=VFknH5FGLmw+QZx2pMjnTCBKQnpNA72qoSXnFHVOUXLSONMrMs7Qwtfrf5ibgI0G//
 fOVrhKBg2oANdnXX1B2/HpEdu6egKY0j/o1zkBd2/gY5FnVIk96lH0sL1OPiZt9WvH7Z
 0y+Sqrf86TEts1WL/A+5lmPW5JSSv593wq8XKQfcHXi+ce2DLDbd25L83dQbgMUJ0mhn
 0Qxret2bUBQg4t1OiZjmvC2euphetuutpYV/SYktF8SDS/79Aws+gH1N9BDvuHcMV739
 /ZAZ327fSmY71NQPTKdqOtcM22TFRT1++xD7ZzcBQ8FQRiRsmAapbnbz68LGxJxqQYC/
 wUmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777539955; x=1778144755;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=YfM3ykU/X5hsW2yBakiqUkVOi+VtddjsDKcbCGz8Nts=;
 b=ZQLe8nyhnJaL38mOOrhQuImdLKvQ+HuU18q7RLpKe8Mz+HC0NscznHr4foT4RzbDuR
 JgG+2Sjp4CA3Qi9zav6jTG4L8YlL28YfkOYHTpbTAjP83iBzWkrvmLUMMhMh6HnVUhmd
 egdFKQY9JEfnECsiYHq4o0oN1HdPXrQ+VIaS/bCdFEplZfk19zbUel3YExUUl9TL7DAZ
 WKZNQPnOz9T/KausLZtCQkRjtYvMZWhaKx49hLjsaFxqMGcY0iOjd0RZIZUFDUNlzfLX
 Xob/oE/FBejEC+bgVartUtaNjFHf0PUzLSexIfpKwD725YaU4wKOs5wwT5W3CG2NerWt
 tivg==
X-Gm-Message-State: AOJu0YwNQKgTwaJbT3cG1dZogqSYMrkWRBjZxtc00nFrTydfPOJtnZ9C
 wlSPEcoYExxybvIOUBpPv1kZZOk5OA5/h5i3avBIizSWNDOtzBF4QJLOuP5Ra++fV9D5xkJiESu
 rk/HMfZ5E2VzvEQbAkpGcaVjnehnEEMMwZRNHdEwEYxosQEHTdVEsNMtTiz/8geRa8F0gibVzA7
 KS5VXuvFJhPeZb0bdIvlP+Cz5+cdUSXop/Oj27g1MJ
X-Gm-Gg: AeBDievEdfP5impfSmp9PxIm6o/IY4azChmAbm/nrv96lIj1pRrpG+NW9aMzJDSQuLO
 y+/mAJSuRemM09MtNBhElQMq1CoFS3QArowQX2jkEhRnMruJA0ynNlUK43HJjkIOTThoppINIg/
 S+0nvq6qfYD2hSvbVNgASKilDfDNWsDF3YnEh57/XH9K14HiwIS6skPUOrH3j0IvgObcBbuN8dv
 KmueuU5YvYT0MJTbVje3GFfPgQV5kwCVbUg7R+Vb/jlFJZkoFrlebSHors/8M50eAEu9StwggUn
 cDJziu9/scWheVRTjl4m49D5kuObpSV9wqBYmorm+QOWPxTbm0lZH2ASUWITiu2mRzL91XJDI4K
 uZIx6o3/R2VcC72Mt0U6bqMdt8faJdlaJ7JuFct2WI0tDt8NOKLq5oIbFcc8Qp43UJNRSug5Nt4
 K3A/5s2jUWdFZDzPlPDqtc2qHZqDXUclrIvWo=
X-Received: by 2002:a05:600c:154d:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48a8452db0fmr34301475e9.25.1777539954946; 
 Thu, 30 Apr 2026 02:05:54 -0700 (PDT)
X-Received: by 2002:a05:600c:154d:b0:485:39b2:a47c with SMTP id
 5b1f17b1804b1-48a8452db0fmr34300935e9.25.1777539954378; 
 Thu, 30 Apr 2026 02:05:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.85.67])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a820c71c8sm86138485e9.4.2026.04.30.02.05.53
 for <qemu-devel@nongnu.org>
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Apr 2026 02:05:53 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Subject: [PATCH 10/13] minikconf: pull main program into a function
Date: Thu, 30 Apr 2026 11:05:31 +0200
Message-ID: <20260430090534.841894-11-pbonzini@redhat.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260430090534.841894-1-pbonzini@redhat.com>
References: <20260430090534.841894-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Avoid pulluting the global namespace.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/minikconf.py | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/scripts/minikconf.py b/scripts/minikconf.py
index 0806a92c14d..e14b80e3ae7 100644
--- a/scripts/minikconf.py
+++ b/scripts/minikconf.py
@@ -664,7 +664,7 @@ def scan_token(self, ch):
 
         return None
 
-if __name__ == '__main__':
+def main():
     argv = sys.argv
     mode = defconfig
     if len(sys.argv) > 1:
@@ -710,3 +710,6 @@ def scan_token(self, ch):
     for fname in data.previously_included:
         print ('%s: %s' % (argv[1], fname), file=deps)
     deps.close()
+
+if __name__ == '__main__':
+    main()
-- 
2.54.0


