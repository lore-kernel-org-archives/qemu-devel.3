Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71B5D105A584
	for <qemu-devel@archiver.kernel.org>; Thu, 12 Mar 2026 11:06:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w0drK-0003x0-40; Thu, 12 Mar 2026 07:05:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqn-0003gn-QM
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1w0dqk-0000PS-Vj
 for qemu-devel@nongnu.org; Thu, 12 Mar 2026 07:05:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1773313506;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Z7y3DnvRDznMz/Ah8U2cmBDACH/S9nm1xE2yGkXpaTk=;
 b=E4HTtUc2ueUPlWtaS1GGsGNt0owWQY40YN+Nh0+8s5wAUBaxSlE9QxC5qb9w7FnoS2a9fg
 jQ4pQfImCvOGOt+QFHmTr9mLmi1xMN6zgjipSFvI4Os9PgrmFQoPvS/OZvKiBWCNRKiVGm
 9qJR+Y4NIPE3rMpPHJ3Gkmy9wLM/b5Q=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-356-VxHnweE-MK--9MkEjUGT9A-1; Thu, 12 Mar 2026 07:05:05 -0400
X-MC-Unique: VxHnweE-MK--9MkEjUGT9A-1
X-Mimecast-MFC-AGG-ID: VxHnweE-MK--9MkEjUGT9A_1773313504
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-439ab866bc1so858717f8f.2
 for <qemu-devel@nongnu.org>; Thu, 12 Mar 2026 04:05:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1773313503; x=1773918303; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Z7y3DnvRDznMz/Ah8U2cmBDACH/S9nm1xE2yGkXpaTk=;
 b=jc28SAxFtm5HUo0mnMoF6G2VBVLaBlxi+TQRwRpBR82xkh/T49Fl/kNxP1PTYUAIyb
 YL40ROevSXMDiC63wsNljKdGe8qSqR04yY10mHkA0jQZcUF/LxGitVwzrfK21fAFNpTn
 rQ3DkxhrzlLsEa9qlxMgHPpDGwfWkZBiRoFfLJB76x5W7ginJNs1Jq0KcOjcSHDMdpFN
 x/RZ7VlC0ygsXP4fusuRF6Bgd/kfv0MrlOgtBjqxEDfI2Xi7DM0eG0FlhWI9bKYFHGF9
 uDPd+zGlwSkZYCrhiSJGu+0npQRlvZATywDmuYUMRI1nZYk5Ds/aj5SR5fqHnoTAPgzf
 wnZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1773313503; x=1773918303;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Z7y3DnvRDznMz/Ah8U2cmBDACH/S9nm1xE2yGkXpaTk=;
 b=TCor9yxbrlOOsuUORb5kPHOfgRVRbxwcdnRFf8Mbegx3UtCpTWlZxxm2S+Jfkbj+dh
 jbSSncra/eIRXUw8Q7c9a8YGZlrG3jE2Ut349d9jFhT0tlSFMQmoVFpcDUNdAshy/eID
 WdCkSnndWRg0lX6WC0jQ9s96z41TGXqt0FrhuBBbzKEuaYBFY4HVBlqER5Rq6Fj94Ue1
 OHtLlTFhqcBOo92U4b6BpyssR+qlxgch1ikfEHCFCUDy0cNTLm276EEpKCAooG9PJNsC
 B8+Y55YWNi7vqv9ufb32JppDNmOth9HR5Pm9O3keRTrgvYw6fcratSpAP5Dyj+WxYOX8
 +HWQ==
X-Gm-Message-State: AOJu0YwNofjQMQ/uCXAdDRTSx5Nu8Ui0uL3ENpBeQtkyo1kv0dFdvf6v
 6OewHZEEC8wYw0ciz/5L4Rc9CBHkXEOYZsK6Ye8R5sxx/WgCZBMXKzWAZ1qGKnrIegDY1+wXufU
 NUeRW5vL/f7VUgozm9td9H57nHHmBDL5efD5xT9AQnjN1RXwiO+l2mXKTxnp46n328pvdohZpmN
 yQhWTo0mElLJb22gJJj8/omxDvNVgy42MMr29Rej+r
X-Gm-Gg: ATEYQzzbQP3Bc9CpWX7hQkiWQJCN7Z5WLRDNRcINjiAL5GUPcCt2cBa8c2VS+2I2ySA
 948dmAXURduHS6CKf2xPW/2pvJQjlxm2voxP1ZPOb13gt1uqk51oydD/9gRouwQJZupm/YUfRgV
 zHFis/K9mYz3OLt2WY2Zwvy660q0Am+5G1Q52sXtAbDOKtu1K8hIdzQ3EgoYwqTk/f7uo0jR1ZD
 aFjAriFKLmOQdCHNfDM+bDtJGDyXbAYgW4Ckgem338v2YK1qOnrA2ZoQi2GfHWZfGXUTEnmx+GL
 eBLI3BzZX4iFwXyhN4LbV8pN7yQTZz6/C0fONAYgDSOUf24S6LLutjgBCzFJKGKZ05sm+oaXJiD
 qeH1rjM1i/0jyR/zHvbJXm5EkltInNbBDNBlILpBMBNtZcvQ1g44EZdJ39ZtHJW8kNjY4AopieA
 leomIiTmD0LCmA2ca7sH7ROhgcxJQ=
X-Received: by 2002:a05:6000:144c:b0:439:b486:ba7f with SMTP id
 ffacd0b85a97d-439f8220ad0mr11380566f8f.49.1773313503039; 
 Thu, 12 Mar 2026 04:05:03 -0700 (PDT)
X-Received: by 2002:a05:6000:144c:b0:439:b486:ba7f with SMTP id
 ffacd0b85a97d-439f8220ad0mr11380490f8f.49.1773313502493; 
 Thu, 12 Mar 2026 04:05:02 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.144.138])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-439fe19ad9asm8081714f8f.7.2026.03.12.04.05.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Mar 2026 04:05:01 -0700 (PDT)
From: Paolo Bonzini <pbonzini@redhat.com>
To: qemu-devel@nongnu.org
Cc: Zhao Liu <zhao1.liu@intel.com>
Subject: [PULL 03/14] i386/cpu: Rename AMX mirror feature words with -alias
 suffix
Date: Thu, 12 Mar 2026 12:04:35 +0100
Message-ID: <20260312110451.685161-4-pbonzini@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260312110451.685161-1-pbonzini@redhat.com>
References: <20260312110451.685161-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.819, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.903,
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

From: Zhao Liu <zhao1.liu@intel.com>

The commit 956b8f0fc38a ("i386/cpu: Add CPUID.0x1E.0x1 subleaf for AMX
instructions") names amx-int8/amx-bf16/amx-complex-amx-fp16 in CPUID
0x1E.1.EAX with "-mirror" suffix.

To align with the naming style of corresponding macros, rename these
feature words with "-alias" suffix.

Since the commit 956b8f0fc38a is merged in v11.0 development cycle,
it's safe to modify the names of feature words (before v11.0 is
released).

Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
Link: https://lore.kernel.org/r/20260310140819.1563084-3-zhao1.liu@intel.com
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 target/i386/cpu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/target/i386/cpu.c b/target/i386/cpu.c
index e35701b93ba..08450a9142e 100644
--- a/target/i386/cpu.c
+++ b/target/i386/cpu.c
@@ -1314,7 +1314,7 @@ FeatureWordInfo feature_word_info[FEATURE_WORDS] = {
     [FEAT_1E_1_EAX] = {
         .type = CPUID_FEATURE_WORD,
         .feat_names = {
-            "amx-int8-mirror", "amx-bf16-mirror", "amx-complex-mirror", "amx-fp16-mirror",
+            "amx-int8-alias", "amx-bf16-alias", "amx-complex-alias", "amx-fp16-alias",
             "amx-fp8", NULL, "amx-tf32", "amx-avx512",
             "amx-movrs", NULL, NULL, NULL,
             NULL, NULL, NULL, NULL,
-- 
2.53.0


