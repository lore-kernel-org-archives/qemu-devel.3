Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF5EEC3ABDD
	for <qemu-devel@archiver.kernel.org>; Tue, 20 May 2025 10:54:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHKbm-0003b5-7R; Tue, 20 May 2025 06:54:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKbg-0003aY-Ay
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:54:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uHKbc-0000eK-EW
 for qemu-devel@nongnu.org; Tue, 20 May 2025 06:53:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747738434;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=p5ZKLbpvRKnZl4AMukJ/Mjjv8xoLVZmpaN9UeQIkVmw=;
 b=WXbC6yztYBhTvCCUnIzRncbpb5/jrJl3RnMDMwdZmQuikYKMAsOJc1jD4m3nSDuAMqaefK
 h9pdrdZcw1mq96kqXHk01jkL+jUaXG3sIecpTjB/Q12KsNlSMRZB8+5GZF2uI2P1IuNQkV
 FklKsiSVLqHxEdC3fd4GzF9uM2B8N24=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-327-VYWvx1taM0mpsImARWkNfw-1; Tue, 20 May 2025 06:53:53 -0400
X-MC-Unique: VYWvx1taM0mpsImARWkNfw-1
X-Mimecast-MFC-AGG-ID: VYWvx1taM0mpsImARWkNfw_1747738432
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ad55aac4ec6so269680966b.1
 for <qemu-devel@nongnu.org>; Tue, 20 May 2025 03:53:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747738432; x=1748343232;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=p5ZKLbpvRKnZl4AMukJ/Mjjv8xoLVZmpaN9UeQIkVmw=;
 b=cYQ0y6DI0HFzE3mWqVUjjnh8gF6QVv/ssgG+3uLSQvddjCT/FHSC4jBb/sj7EZp19Q
 zk+OzgY4fkXZaktb4lOjZo/e3uuUttffK3/D7Z2g+PW8LFSLdLHPG8EsIf347coIq5oL
 KW8dKG6x1PlVS9/faK9QC8h1nB0LuJt9YVC5j5A5g8Bi2qd7FV6c/5E05b/jGQ0/ZL7s
 e9B2gvAmk+mHW48e7PHYyya70EcYBLPFTTx6tJyp5VUjbR3BHEtaDva5BzflO9z/xd2J
 QYOwvSns4CKtnYkd78Cbp/kv32ig0EEeXwefjp1rimsn0kB4Ol5lc2/65bSDXnywX50z
 oySg==
X-Forwarded-Encrypted: i=1;
 AJvYcCVR7gbxFN9swfLYiPxSuYzev0SqR7tu0p/esPKXIKOK63V67gxB+nwaFhDo7nFU4CX9C2RRkbSgxRPg@nongnu.org
X-Gm-Message-State: AOJu0YwqX11tQTYVTsCNTJa8dsrA/rNZJLQZD9F8IZvJB3Q5dQKSlRqi
 szM0F4HV6TOtyxHMvmCKPnhJUj/SiHnbAw//Yo7LyOGH8LFdf+n/8ry1gML1JmscKjlzMuWzcPk
 f/LuQiRcaZlY21F6I4ojZdR+97cAyGG44gaLD4IQ0QoNHPgYcGx1FPwAR
X-Gm-Gg: ASbGncvjxcYZmLvwM2s8RMAEEPEGYmt9+n/8aqSkqyAkXLwdjUeQl5GyQzCDfK/7SR5
 x0nwdsUXFZrj9fhMmyYYgOUKk/eqQc50yHsSGDZ9ZI0kDjWTOVFL9SB0TpX7QJD8XJA49ay6XUC
 HgmrkYdsAZV4PlcpCWJYMm88VT+q3FtEeKLrOKjsKyfHrMBzIgEaFrFD46EVey8O/8PQ3lgF4ZE
 tXIQFmBe21/re+XQPWEawJSE6E3ozlTD0pxjumHiXRTLBePJz2dL+PFjcC+rywy2wo3/cK5jx1t
 uLQefwbVBaHhrQ==
X-Received: by 2002:a17:907:60d2:b0:ad5:54ec:6b3c with SMTP id
 a640c23a62f3a-ad554ec711bmr1008107766b.27.1747738432363; 
 Tue, 20 May 2025 03:53:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF3zk3dVc6fgxKHTRecMva/9tuNCX/BgIoAIy8x1G+L/UOn4Ym78+V1l4MG/EgqGWXgwkXcBA==
X-Received: by 2002:a17:907:60d2:b0:ad5:54ec:6b3c with SMTP id
 a640c23a62f3a-ad554ec711bmr1008105966b.27.1747738431907; 
 Tue, 20 May 2025 03:53:51 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.46.79])
 by smtp.googlemail.com with ESMTPSA id
 a640c23a62f3a-ad52d4ca654sm704183066b.158.2025.05.20.03.53.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 20 May 2025 03:53:51 -0700 (PDT)
Message-ID: <51356014-b645-4e86-b338-0d097bf80260@redhat.com>
Date: Tue, 20 May 2025 12:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH RFC] target: riscv: Fix satp mode initialization based on
 profile
To: =?UTF-8?B?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 Alexandre Ghiti <alexghiti@rivosinc.com>, Palmer Dabbelt
 <palmer@dabbelt.com>, Alistair Francis <alistair.francis@wdc.com>,
 Bin Meng <bin.meng@windriver.com>, Weiwei Li <liwei1518@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>, qemu-riscv@nongnu.org,
 qemu-devel@nongnu.org
References: <20250516122319.4100121-1-alexghiti@rivosinc.com>
 <87y0usiz22.fsf@all.your.base.are.belong.to.us>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <87y0usiz22.fsf@all.your.base.are.belong.to.us>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.13,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 5/19/25 14:07, Björn Töpel wrote:
> When realizing the cpus, the first cpu calls riscv_cpu_add_profiles()
> all profiles are disabled, whereas for the other cpu calls to
> riscv_cpu_add_profiles() have some profiles enabled. Having some
> profiles enabled, will issue a call to cpu_set_profile() that will
> enforce the satp code that Alex removes in this patch.
Ah so the problem is that *parent* profiles are not enabled until
riscv_cpu_add_profiles().

With my patches to introduce RISCVCPUDef, it's a pretty easy fix:

diff --git a/target/riscv/cpu.c b/target/riscv/cpu.c
index 629ac37501e..04b929af41c 100644
--- a/target/riscv/cpu.c
+++ b/target/riscv/cpu.c
@@ -1083,6 +1083,19 @@ static bool riscv_cpu_is_dynamic(Object *cpu_obj)
      return object_dynamic_cast(cpu_obj, TYPE_RISCV_DYNAMIC_CPU) != NULL;
  }
  
+static void riscv_cpu_enable_profile(RISCVCPU *cpu,
+                                     RISCVCPUProfile *profile)
+{
+    profile->enabled = true;
+
+    if (profile->u_parent) {
+        riscv_cpu_enable_profile(cpu, profile->u_parent);
+    }
+    if (profile->s_parent) {
+        riscv_cpu_enable_profile(cpu, profile->s_parent);
+    }
+}
+
  static void riscv_cpu_init(Object *obj)
  {
      RISCVCPUClass *mcc = RISCV_CPU_GET_CLASS(obj);
@@ -1121,7 +1134,7 @@ static void riscv_cpu_init(Object *obj)
      cpu->cfg.max_satp_mode = -1;
  
      if (mcc->def->profile) {
-        mcc->def->profile->enabled = true;
+        riscv_cpu_enable_profile(cpu, mcc->def->profile);
      }
  
      env->misa_ext_mask = env->misa_ext = mcc->def->misa_ext;

Since they're all reviewed and Alistair has flushed his queue, I'll
send them in my next pull request.

On top of them, probably profiles should also be converted to use
RISCVCPUCfg and riscv_cpu_enable_profile() can then enable all the
flags with riscv_cpu_cfg_merge().

In general a lot (if not all) of the profile code should be moved out
of tcg-cpu.c and into riscv_cpu_class_base_init().  I didn't do that
because I didn't want to balloon an already-large series, but it's a
pretty obvious extension of the RISCVCPUDef concept to include all
profile features.

Paolo


