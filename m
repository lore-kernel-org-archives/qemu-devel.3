Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEB47FD0049
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Mar 2026 08:59:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vwyzY-0006sz-KQ; Mon, 02 Mar 2026 03:51:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxQ-0003NX-I2
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:55 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vwyxO-0002GS-BK
 for qemu-devel@nongnu.org; Mon, 02 Mar 2026 03:48:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772441329;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2MmC+0Wc43ZwpOXcA9/m6B258VAHnxzeYte/HMHDPHo=;
 b=Ycj45CEDCg55pFnmtiaMWaCW8iaeBKBv5uOfcGMTRl8eP7RgBZz3n3TalAIbaJMF4Qp5iy
 tc29wzR3eiuZrqcMXOhvJR3N3WjueN6zBikPPwRpgEf5t4lyzpv5BiI2fdGckSWcbGXPnI
 TeDBWXz9mSedo3E5zCDDiyBsTvyzOxg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-505-PKM950rNOrqBGIqoQiEOjA-1; Mon, 02 Mar 2026 03:48:45 -0500
X-MC-Unique: PKM950rNOrqBGIqoQiEOjA-1
X-Mimecast-MFC-AGG-ID: PKM950rNOrqBGIqoQiEOjA_1772441324
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-48379489438so39519335e9.2
 for <qemu-devel@nongnu.org>; Mon, 02 Mar 2026 00:48:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772441323; x=1773046123; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2MmC+0Wc43ZwpOXcA9/m6B258VAHnxzeYte/HMHDPHo=;
 b=g6HI6Xu99DLUznXesWlRAgP+WSY09L8TqhdPPLrwD9Px8JUaGpcuz0Eq/E/LTAlcju
 BDzQYMK4OsMfEuH2cvWCA+aWg/HT+BW7TKSmMZV5cM700T0GMytwIoT9DmfB7BHxx/DP
 6iJNTp2Y3Sqt02ke2rAWsTtEXwNJbRQbRJCOlqs12Ii6fe8mcZ9wrhy/wAhgjdyLyE3j
 KKwUTZAKiujpOdQ+L78dyI6n+4sXoqqVB4bOCQHjjp+iwQzBez53M4xVxKA3go0dWFdW
 sy2ix/RrJacLlQbm30F0wQkl4x2cxcXrbpUSAOwrX3v8EkYvjloOuon0rkpA+Z+lu/yL
 wO+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772441323; x=1773046123;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2MmC+0Wc43ZwpOXcA9/m6B258VAHnxzeYte/HMHDPHo=;
 b=aCnYVDB39S5+9Mhqoq0NKHdTG8gYh28at688TtIS/ub9rky6EetB9cmvThpaQIMzQt
 zJJqXM/F4L6rVm60h74pSCm+M4bwUGvkFl/8r07RXEkYumQ65MThqbMRP/lkwynOusOe
 3oShk+gc0+qt2TyMCSZOKZzzp5iSCkrvRUOCzvbsu2QdERpv3noCHiiM8mRmOnJWmA1L
 HyzE25E0yw9g0zsOQgdIgRF+mR+ZBFLTCpzLfIT3PvJMtu+sVpkS3r+F4JnISJzqecv6
 5m9lv3rI3j0Dc7Q99KoBgAsp7B90eMiXqz2aTzI3UTSQ6HtXvn34efHj5tBo/uOi/gEY
 IQDw==
X-Gm-Message-State: AOJu0YxyiYQw3bjOKD2rll7sUvSh03V4kegTXjqO/2LEUopJYmcpz+NK
 E10lNzHTpHtcfucH8ylLIL8svMY1TravvNCp+Cv7E+BGY0gYTYPawjubGZqN+3+IZOTCFCnNOzR
 dxdwk8zRNmFCDM2qwf4gE7qbhrRNyp7+x9Wz4+RUMsvaCRimpist91ucfrHJqDfji8OU50vuCV4
 VPzNIQwoAQsqalaSYEwg1k9OEeRVUZkIu9bj2lr6kf
X-Gm-Gg: ATEYQzw8ssWKFv7rnx0oh4XQCTKHSC78gKAgRAFIjx1KYAZVuj0FTJK3PSYFW8yFAEb
 1kEScwUksUHrZKL259wQds/1NbAIEdoF62fkYYET+IBOpG98ss0MHu+fTiuyIXRz0HEmYJzGjxo
 tmpQc1GbygKIauKfdcHXj0xrrcIAnZ1Hkpr2oz5TSXC1ix4GTLZySbMdxFsMhCBvhu4RrCHwP5C
 2/1bG47dA7+jMLVQmgN1JIoFP3a/nzVxaLclVmO4S6S8xrK7e3A2A+0AcbtNITmaUHmoNf/CYC6
 IIzbCYniOSvIvqMoaoIVG1No7ZsB7o9nPg92nOK5JKuXdKvWdqTdlzXqq0A35E4qCG4Xj+k/A8I
 kedqtHfnSQM+WOmrVnT4XWqn0K6iDyE+DhupzjHh0salBc2edxOl2X6AC1Uf39Vlkv8yRxXhv8k
 SXbW6GUONcxk3Ip0aRmMZ2RF3r4xw=
X-Received: by 2002:a05:600c:3e12:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483c9bb1e09mr191438805e9.8.1772441323414; 
 Mon, 02 Mar 2026 00:48:43 -0800 (PST)
X-Received: by 2002:a05:600c:3e12:b0:477:9eb8:97d2 with SMTP id
 5b1f17b1804b1-483c9bb1e09mr191438415e9.8.1772441322954; 
 Mon, 02 Mar 2026 00:48:42 -0800 (PST)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-483bfb87067sm129197695e9.12.2026.03.02.00.48.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Mar 2026 00:48:41 -0800 (PST)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Ani Sinha <anisinha@redhat.com>,
 Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>,
 Thomas Huth <thuth@redhat.com>
Subject: [PULL 087/102] target/alpha: Reset CPU
Date: Mon,  2 Mar 2026 09:47:33 +0100
Message-ID: <20260302084749.474955-21-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260302084338.473368-1-pbonzini@redhat.com>
References: <20260302084338.473368-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -8
X-Spam_score: -0.9
X-Spam_bar: /
X-Spam_report: (-0.9 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.012, RCVD_IN_VALIDITY_RPBL_BLOCKED=1.188,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>

alpha_cpu_realizefn() did not properly call cpu_reset(), which
corrupted icount. Add the missing function call to fix icount.

Signed-off-by: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
Tested-by: Thomas Huth <thuth@redhat.com>
Link: https://lore.kernel.org/r/20260217-alpha-v1-1-0dcc708c9db3@rsg.ci.i.u-tokyo.ac.jp
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/alpha/cpu.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/target/alpha/cpu.c b/target/alpha/cpu.c
index e0e13d31e55..ff053043a38 100644
--- a/target/alpha/cpu.c
+++ b/target/alpha/cpu.c
@@ -124,6 +124,7 @@ static void alpha_cpu_realizefn(DeviceState *dev, Error **errp)
     }
 
     qemu_init_vcpu(cs);
+    cpu_reset(cs);
 
     acc->parent_realize(dev, errp);
 }
-- 
2.53.0


