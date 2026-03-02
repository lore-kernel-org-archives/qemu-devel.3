Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9D42D58E7A
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:52:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwywu-0003EI-6M; Mon, 02 Mar 2026 03:48:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywX-0002xs-KH
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwywV-0002AZ-6u
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:47:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=1r9QLGln9C+4G2u5qGPmBL69tbd+QKIMWgbB8spqDOA=;
 b=DSKEhsuSJBRphOdD93PiRICTSdbPKX8+YIKj+lusxn+h7pOvrs8CFZBdFSUVQry0TOOwkM
 YHis9jrPOuMNv0B24OpzQUduTftjrAqBzYqPUKNcAyCkjBRNgjrPdfZ+snSYVSAqcJkTiG
 onP+BJwWSRDkVyj6knCcUR2ZK0OaCJA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-532-cRTb_gF8N3iLzBaLWCCj_A-1; Mon, 02 Mar 2026 03:47:52 -0500
X-MC-Unique: cRTb_gF8N3iLzBaLWCCj_A-1
X-Mimecast-MFC-AGG-ID: cRTb_gF8N3iLzBaLWCCj_A_1772441271
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-483bcfdaf7dso39989085e9.0
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:47:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441271; x=1773046071; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1r9QLGln9C+4G2u5qGPmBL69tbd+QKIMWgbB8spqDOA=;
 b=MR1wehTqUFee/z6PpBxC7jtNeoGbXYAkA+hAU8Qss858VjTKLVViHhV2UedapGoSan
 RIbSa/lS4JkAmPgZRFzDRGrUge20qnVkEK9OfnJfEbkT+kSpLqYrzDkN7eHL3DIDPJMn
 NIURxGmXCVeMdhY3C6bv7rbvBFSgFcKc1SJw3e2r/rPT1fn8tLaoVUyZMmJMeHgE4j7b
 xzfg/NjnyzYMRj39UucGBm4ZDTTXD8oJKpfFzsKdP0wkzAWU+pJwduweVhnrwaH1v5Mt
 s1ok0appBJJwTVqL/zyh7BJN30ayZaIN+eUJ9NhmHDl/XmY86D15wVEX1Fbo3OISbK+r
 Q6ZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441271; x=1773046071;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=1r9QLGln9C+4G2u5qGPmBL69tbd+QKIMWgbB8spqDOA=;
 b=Rata/VQ4d1dwl5f9BPE6nHLirrxXmAVUhtimy/46FDedIg9uZr+rho7eLVLwjKbNuM
 VWQtY2y3nRC6ku5TtVelbfU1cFRfKInuZVNEkZ3hbMaKci3GjPBkSzCGOvXRZ6S+GY/k
 ohtwAISjeP01MIUerqtpjGzvVgZ3UFkqBmfARrFQIhjxZu/W2qdcILTv7lkFQDiqevhr
 LbcmRaNeFZIWdXn/NEwkXbFkxKrV1/cb9XoXp3fy1y+nWWMNsWF5oruy+Y2HLhRiu88z
 Lq6zfNJc0t7WxkBaeH3ogy8QOgst+sqmbRffBR5BQrZZtvReBs/bjVrW/tHjZCQjby1Q
 kA4Q==
X-Gm-Message-State: AOJu0Yx5HicVAk02teXHRrVdT5biTUCLWc3ZMmV6w2jBiu+sRptXSaJS
 86JAV3NEpAUXAeU85LgWjxYrxih7uvcpXsrNdkmcpgiTdrJFJee8B84BlyOIYeww0N/0QfXmtDj
 //YNux2syOa572fppa7CbpZwDsWwK356F5bBUqX13YbbN8S/V7dXwIckhDNXIwkh/4Mlosp3CUV
 REhtl6GnUPiH4aLN7ijoOU4WToOjZvHbm/LhkZKdqj
X-Gm-Gg: ATEYQzxvgXJGmGRiWnGTu5jHTparyAfHKKluz9nBNUfmdAz2sM7uqQI7+/cth+KDFj2
 dp18sj2v8mGkPJrgnD0yiIZ+CRWSm67k5M45ZqjVhBCn6nYQi3V9SLVMJJewqeorD9X//TvMFuX
 wvLbgGNaA1+LXj2x5uh00ASCQckikF/R84aeU+4Zj9d2shn2ZsO95Ei5okdTgpFunQT4Y/bjQrj
 uCPr5tGKaStfu3IIYdz9SFMebyNOOKYggmPZKGqnrMyGK7I4/EN36uImIf0EnjWSJwaU0Am0um0
 uFXeLTxyBhFpLJ+A5YvZWSvipccSxyxGsSR6mDLreTR8rqQRQYShZvYnv72Rs05RJ4EoHY9XS70
 fqyB0+LauqhKQ9PUl500+SxmFxWKGPVbTNtPYo50LWGJinEhz8Z0ZnzuIQP2I+0pWUZqrMszk2R
 0MhtJi7J0IPHiinjM3X0PE4FFSZe8=
X-Received: by 2002:a05:600c:8b30:b0:483:afbb:a086 with SMTP id
 5b1f17b1804b1-483c9c0e31amr188224395e9.29.1772441270959; 
 Mon, 02 Mar 2026 00:47:50 -0800 (PST)
X-Received: by 2002:a05:600c:8b30:b0:483:afbb:a086 with SMTP id
 5b1f17b1804b1-483c9c0e31amr188223995e9.29.1772441270297; 
 Mon, 02 Mar 2026 00:47:50 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfcbf016sm199758555e9.5.2026.03.02.00.47.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:47:49 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>
Subject: [PULL 067/102] kvm/hyperv: add synic feature to CPU only if its not
 enabled
Date: Mon,  2 Mar 2026 09:47:13 +0100
Message-ID: <20260302084749.474955-1-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
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

From: Ani Sinha <anisinha@redhat.com>

We need to make sure that synic CPU feature is not already enabled. If it is,
trying to enable it again will result in the following assertion:

Unexpected error in object_property_try_add() at ../qom/object.c:1268:
qemu-system-x86_64: attempt to add duplicate property 'synic' to object (type 'host-x86_64-cpu')

So enable synic only if its not enabled already.

Signed-off-by: Ani Sinha <anisinha@redhat.com>
Link: https://lore.kernel.org/r/20260225035000.385950-27-anisinha@redhat.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/kvm/kvm.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/kvm/kvm.c b/target/i386/kvm/kvm.c
index 9d7a9ffceb8..7cfbc7832de 100644
--- a/target/i386/kvm/kvm.c
+++ b/target/i386/kvm/kvm.c
@@ -1761,7 +1761,7 @@ static int hyperv_init_vcpu(X86CPU *cpu)
             return ret;
         }
 
-        if (!cpu->hyperv_synic_kvm_only) {
+        if (!cpu->hyperv_synic_kvm_only && !hyperv_is_synic_enabled()) {
             ret = hyperv_x86_synic_add(cpu);
             if (ret < 0) {
                 error_report("failed to create HyperV SynIC: %s",
-- 
2.53.0


