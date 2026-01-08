Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99C63D185F1
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Jan 2026 13:12:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vdpnQ-0007gR-GR; Thu, 08 Jan 2026 08:11:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnO-0007fi-Ma
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vdpnN-00082i-3f
 for qemu-devel@nongnu.org; Thu, 08 Jan 2026 08:11:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767877880;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kzld2q5RlJkN3vtzdl66CcPbGlXEZCEofO8swei4zsY=;
 b=LmOAflH3ME9g1E59rSX+Yl/x13SN0ErmjNWXKLPdQXJsFY4pNGipc1UNKUv5LokgrDJh+6
 gNJB/PExd+PHW68gh6htBL5g7GzHI4bslAvqEmucK0tTgkg1gY4ju15CVWTw0lUFU3gvRa
 fImAJ/B2UMfPZzREKM+tH/Wz4rhi/Y0=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-139-Jf9TNhVFPmqM1bZ24GDLKQ-1; Thu, 08 Jan 2026 08:11:19 -0500
X-MC-Unique: Jf9TNhVFPmqM1bZ24GDLKQ-1
X-Mimecast-MFC-AGG-ID: Jf9TNhVFPmqM1bZ24GDLKQ_1767877878
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-477563e531cso23867535e9.1
 for <qemu-devel@nongnu.org>; Thu, 08 Jan 2026 05:11:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767877877; x=1768482677; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kzld2q5RlJkN3vtzdl66CcPbGlXEZCEofO8swei4zsY=;
 b=SeG6K/UMNfjZtIX7eFBAepYP8o0btdA2Q5LcVyEQImFqt3osLhARFAGCp260sU97J1
 kq/ESFEtmpFpTkoL2xo3+6KyWJh/EeelmB/RlBtshzYBkTMjuhXufjxXh2ynoSL4nEYZ
 edbgOB6pQuFvpKL4CSYWkPSFEDyHwCZ38PEA6+gu+PyDiRZVUtBbGKMvzJd2HXIliGwJ
 PIGeqb17zEQ2BRRjUliHQS1RMtx6ElX6tXmI+zv0ljdF+wO7dwfnK/eanFfH1SYJlije
 6MkiXH2OMi9mnApemq30o+UiVx64CjocbZVQN8yQhNhCS+geYCIH2LhOChSgMpouW4EC
 wP4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767877877; x=1768482677;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kzld2q5RlJkN3vtzdl66CcPbGlXEZCEofO8swei4zsY=;
 b=gK+XbxEAqeu8OkLTde3hCVYhPgK32q8sVeMiTfcYYT5UNzpFcGvRw4Ad4WdSigOBc9
 +4YDMTr6GPYXPvwjM/zEJDMXBiA4DLIt+DICGJAvg7qyOUyIhHPjFWdHPpCk0xJS9KFo
 ycQl8wIT60qcWQ/dgdhOL7/2dlOy3Vna9sNhPAGXwNp4i+842dqTWpvqN1XlmSQY6BDQ
 N/xELhIc0ppjgNIzi+Cj2OSpYlzsXLLGinIS0sUPvlldZZkcal9r0KH8jb3AMygZOcSb
 HogoH0bEY5u9y2XKomi7PhD1WggPBAX6nEJPCUHw3CUWq36SFdKq6KE58fY2GJqBwVtO
 aopw==
X-Gm-Message-State: AOJu0Yw5Vgt+g+NW5AZ/bpAqjVbxgeIPRQ7C9LlqvqleqdgFmvPg2Yig
 qVqF6Fq4+Ur9Dam2+6+L/NIJPP7ZRop2UJT603dS+eQHD8t/z31dklctCM+LQ/aBDHvAn0y6vnZ
 wgMU7ETwXchJqTvD2DoBNiehoH/AylH1dGC4PEUnHqCEKxTOcEL7INol6wz2upMpcrGlInqxcKd
 vvquK6s5APYCoxpw4DzDkMWQBmBcVylYb8G00SjT0+
X-Gm-Gg: AY/fxX44V4MmuHmb53VcxElgImMGRflzBy6vVJRcv60zKLA6OspzYzNXZTkv+w/QvK+
 kAho6jHHr6uliby3linTPj7hlxxsAzDc0l2xrLWudWpBRiNYsabSr8hLm7K7ZWIHpEtTV5cXBtI
 Xr/Wzo1aTXqvXAVA1GJAQ8pYCpSJgcsvDpB8m4PWvuaCPjY8O5TPMHzmF3n8UdbRkKzyMbxz7II
 LNUT3P3+xVeNx/Zv9RcEfqD+tZ8n3kq5bQ9OBB0U2GuFliD9Vz5aUSuJIjiYWuQ6bp0BytDJfcz
 fGQ+tsoVthrcnNr24qFyNDG0YkVLrjbuXarJ28iPpNhmWyXgxR+hr5yTbWx1p+xlewTaMiOR5yt
 6ISWsPMsG0wGwM/Igx0KAfuEolc9ospc6gtB7vOWtgooaV7RH27RAQPP4+MUDmfKOfLew4s6v4b
 LsWKI3uEr/uljUwg==
X-Received: by 2002:a05:600c:4e13:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-47d84b32f30mr79824975e9.17.1767877876994; 
 Thu, 08 Jan 2026 05:11:16 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHb/egjF3zBUGVDoYK29auPfPeGuQmD2Zgs5XazD5fX4zjGL6AyDI72+ZkzZ1E03v51m+S4kA==
X-Received: by 2002:a05:600c:4e13:b0:47d:25ac:3a94 with SMTP id
 5b1f17b1804b1-47d84b32f30mr79824625e9.17.1767877876629; 
 Thu, 08 Jan 2026 05:11:16 -0800 (PST)
Received: from [192.168.10.48] ([151.61.26.160])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-47d7f69e802sm155710765e9.8.2026.01.08.05.11.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Jan 2026 05:11:15 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: armbru@redhat.com,
 =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 qemu-rust@nongnu.org
Subject: [PATCH v2 11/16] scripts/qapi: pull c_name from camel_to_upper to
 caller
Date: Thu,  8 Jan 2026 14:10:38 +0100
Message-ID: <20260108131043.490084-12-pbonzini@redhat.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260108131043.490084-1-pbonzini@redhat.com>
References: <20260108131043.490084-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

Allow using it for other languages too.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 scripts/qapi/common.py | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/scripts/qapi/common.py b/scripts/qapi/common.py
index 14d5dd259c4..c75396a01b5 100644
--- a/scripts/qapi/common.py
+++ b/scripts/qapi/common.py
@@ -61,7 +61,7 @@ def camel_to_upper(value: str) -> str:
         ret += ch
         upc = ch.isupper()
 
-    return c_name(ret.upper()).lstrip('_')
+    return ret.upper()
 
 
 def c_enum_const(type_name: str,
@@ -75,7 +75,7 @@ def c_enum_const(type_name: str,
     :param prefix: Optional, prefix that overrides the type_name.
     """
     if prefix is None:
-        prefix = camel_to_upper(type_name)
+        prefix = c_name(camel_to_upper(type_name)).lstrip('_')
     return prefix + '_' + c_name(const_name, False).upper()
 
 
-- 
2.52.0


