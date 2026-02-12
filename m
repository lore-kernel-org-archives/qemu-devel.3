Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6828DEE368C
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Feb 2026 14:50:55 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vqXvl-0006t9-Fa; Thu, 12 Feb 2026 09:44:33 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvX-0006LG-OF
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:22 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vqXvW-0006Hk-3L
 for qemu-devel@nongnu.org; Thu, 12 Feb 2026 09:44:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770907457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/H8PR4Z+t+yD0VOfkreALdVOsHffEBJGMz/d0n5vsk=;
 b=SPz7Wh6EQDb2hWbaGykHQKvyyp+ujkjE4oZsr49uXGEKhfVBl6xe3xaAQ1wnnimNBtoyX/
 YyC4rXCLAVsBN2Ajl8hmKzVAOh8sic4ry+4f7uugRxFLubtw1VFFvtPyiYTmK5HyS89JyD
 /PuPYcK8S+MRBIZRxWMeeTjvPR2aELU=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-633-Hau3JWZYMN608ED3qJ8qPA-1; Thu, 12 Feb 2026 09:44:16 -0500
X-MC-Unique: Hau3JWZYMN608ED3qJ8qPA-1
X-Mimecast-MFC-AGG-ID: Hau3JWZYMN608ED3qJ8qPA_1770907455
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4806cfffca6so88971185e9.2
 for <qemu-devel@nongnu.org>; Thu, 12 Feb 2026 06:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1770907454; x=1771512254; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=R/H8PR4Z+t+yD0VOfkreALdVOsHffEBJGMz/d0n5vsk=;
 b=UihyS6cr9sXnu/VIDEELSC9ZHDoEuEZ44V/hmb8bU6TXfJL3kz/dyA+hbmS1qzkMbe
 /2iQdMuPIuPdnncKpwwFXPi7PTusIc3EP69eC5s6zm5UlMh2e+cJ7nPNnATSHOUtEf/z
 fUI6WIElvy7BaxARdPaTZ6SH4H/lVRYcYwSStWveBmxgsObtAuxYsU1wU/JNUVGAMbIZ
 jMrLLNYmf8kySACGq43sCTJyLUTFypqNo81nWASLfSd00MPe4vX2PBedDpEsi6HnqYhu
 GZrQB4pQOqo0sxO+DTZGvejiIBJsRGQOiZzw53mBRAJfdfq68Zxcu5IDwlEA5qo/Ydm4
 kf9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1770907454; x=1771512254;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=R/H8PR4Z+t+yD0VOfkreALdVOsHffEBJGMz/d0n5vsk=;
 b=QWgnFYZ+KNPEqXM/S3aJGJ+Eq6oYqQENLUtNWTPXdOnLZGRixvT+/K8FImZBs2ZUOP
 9RtbcBae5l6QYPBhPhcxFMk7p1k03qPIcHJvPqzHi9uq5wtM2ZK9NHUpEUrsKudsDfZN
 CBHDp+c50+8XYMZOKuoGMUYfwZt9beJqy8voxPJ8jSYvXJF5ytTdFQKj+x3oQSsxMPQO
 QEuGgNCwQkC2U96edSeZpONDF+IzYdNGkOFpk7QM6lmgpXVrM8A8M0zlSMJ5zo5LIfjp
 ETFpMw1sQAxncm4xwz2laFrDoofxFSWV/oeknZb3SZvGGsauq9WAuUKdQ86FODCBEMA1
 XgCw==
X-Gm-Message-State: AOJu0Yxgm8z3JHQxn26GeRMB/LB1Mrd4z/iO9nwpm20xIkj4IstJDdzE
 VbxudujfnJhOCV/efHjArDCgnngIFxTlzyKBoIfZb+E7KbErX1nDbboyUBLehgnzVRF2JJivLMy
 vXRrUGkndnX5iZroD76GvDTojK3SQCaAbZ1iL3p56WkZFKz+1lDtXHVKUnWs+HD0WaF4AQPh+ZK
 I66eC22E5K0V/9s3hNQIs4bJbJgK+EZdSiA8zzhe1n
X-Gm-Gg: AZuq6aKYPD2AJNFcIW6T5sLHvzZ8sll6cReFWNEOZXOUXf41sNUyMZY2YsvDg+Oh51B
 JhZyFr4GzKai5f6EBnZpd+YkjIFls8++lvdWjmtQpaWL3kKlow3mTi2rdQh0oWHYJF7XzjhGi4W
 arCn+JkepuDJ3HIVpCLpVwaTCjoawfYWBoS4XmWbN6k9tdo+co7f7OD6C2UHWkLF25NGtIrTJKX
 /DSDRNHBnxJ8XQvhJY9bPuPSovXEzCSQ/6asQj00nH03vZMass73MXLY49Vaj6vU1WQ0CYcUpGE
 w2VPuxcPC9TD4tBN2uqzLwbXM9yQyHUUSCAJC9QDjEsxlTw9jUesQlnlQOTS+HDS2gcc07ueOaB
 8t5+s/zfrYMe5yNbG0CQoDkl0LbcGMQ/UV4hC2lOV2T8DfjCnXpXit7BZqHRyTYJL9wCr4370Dj
 I1hYWKHTOHzvhLWnivpseUSJhaJd2QJPl1fffj3PQeVB3hXYNujnc=
X-Received: by 2002:a05:600c:888b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-48367184279mr23990745e9.32.1770907454325; 
 Thu, 12 Feb 2026 06:44:14 -0800 (PST)
X-Received: by 2002:a05:600c:888b:b0:477:5af7:6fa with SMTP id
 5b1f17b1804b1-48367184279mr23990425e9.32.1770907453808; 
 Thu, 12 Feb 2026 06:44:13 -0800 (PST)
Received: from [10.60.241.123] (nat-pool-mxp-t.redhat.com. [149.6.153.186])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4835ba1670fsm77374815e9.4.2026.02.12.06.44.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Feb 2026 06:44:10 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: =?UTF-8?q?Marc-Andr=C3=A9=20Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Berger <stefanb@linux.ibm.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PULL 38/41] qdev: make release_tpm() idempotent
Date: Thu, 12 Feb 2026 15:42:40 +0100
Message-ID: <20260212144244.22579-39-pbonzini@redhat.com>
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
Link: https://lore.kernel.org/r/20250429140306.190384-4-marcandre.lureau@redhat.com
Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>
Link: https://lore.kernel.org/r/20260108230311.584141-5-csomani@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 backends/tpm/tpm_util.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/backends/tpm/tpm_util.c b/backends/tpm/tpm_util.c
index a64e156f45f..264bff22a91 100644
--- a/backends/tpm/tpm_util.c
+++ b/backends/tpm/tpm_util.c
@@ -72,6 +72,7 @@ static void release_tpm(Object *obj, const char *name, void *opaque)
 
     if (*be) {
         tpm_backend_reset(*be);
+        *be = NULL;
     }
 }
 
-- 
2.52.0


