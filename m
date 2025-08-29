Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E91ACA1000
	for <qemu-devel@archiver.kernel.org>; Sat, 30 Aug 2025 15:47:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1usN8d-0002WV-AK; Sat, 30 Aug 2025 11:05:07 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uruJS-0006on-D4
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:18:22 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uruJO-0004Cp-Gd
 for qemu-devel@nongnu.org; Fri, 29 Aug 2025 04:18:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756455495;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=zEuHs53QUt85W747xRdqJ01jyPgzr5038G6GZu/2NlI=;
 b=PSo/e8ug7BiZ0t0enMZXCTVmOYRuvqD7KlJI3ShpAx9c9kZkZCSJgNIFJgNKXSDi8Yvgf+
 cAvf71V3Np5yfNEStH36eu2iJAhNbDr4bbhH6kTdO2AU77g6xnBe7dfkbAOkhH6ocuDFjx
 rhHU13ZxCfJn5QV6DNYBN6Kh3v81ZOM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-552-ST0dhyjeMGOOTmja2aOklg-1; Fri, 29 Aug 2025 04:18:10 -0400
X-MC-Unique: ST0dhyjeMGOOTmja2aOklg-1
X-Mimecast-MFC-AGG-ID: ST0dhyjeMGOOTmja2aOklg_1756455489
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-45b71fe31ffso10454975e9.2
 for <qemu-devel@nongnu.org>; Fri, 29 Aug 2025 01:18:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756455489; x=1757060289;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=zEuHs53QUt85W747xRdqJ01jyPgzr5038G6GZu/2NlI=;
 b=kZGTD8LmZSETQYzTPUBdGk1rbmyBI9dptIJCtjwC8MLXAlH2oSIL9GsblGoTgAk19Q
 Q+E3AYshcHWp1gsaCg94wVw5t1388cMbDZyzp9AdMyyz2HmoXXJOzept2kx+lARNOGHF
 UFBCek6JH+YS75fk/gKIzZM+hfEoCd12h7y5HyivtsU4jhdBeKAGn/ORdQ09j85EdGor
 Og2QzC1mscbuD3Wgh/TB43NUG+xkLiw3rzzh+4OjcDEYTvq3P3g7up8ilv/2J/R6rH2A
 5TCuJE9D86otEme7ZJIC3WuyAMGcvR7xoj7G89XPB9pbxyx40SJK3uIAteU6W+W/Yw8y
 hjMA==
X-Gm-Message-State: AOJu0YxnsiQ5nCr7UHWxZv1y1Jy5UxZCNW+M9Zc3w9vI5ukvTECoE97i
 zYkyO3rHwLkQRdhCntcemHG9jfPpUA8ffcv+cy0SBCFjGh+IIPCl819jaqclV+9wqRhetasikLG
 AW3gkZ+Y6aHmSbDSqUBjXvL4pxk47Rh4jyNbRW5VcyDOA+qDPwPGd4iMV
X-Gm-Gg: ASbGncvOuhVRTjQteOoF3c5t7JUL0nlzmrSvRjjvxzJocaJ3BNVVprp6fQt2altklzg
 oXsbIFFBeXaPxUG2uU87Ki4AGp23oyfPHtdyCjp89XBaek9xFB3jsgR2PmdMvqhcuuwGl/Fq1wc
 cDRRlfXX/vv1oPyfmPspjk3qNSR3cemj6x46zhBz2L42GzaopTZivU3S9uvs6RVGASobZYuUPrm
 D5mPKUpJClVsPanX+bbgSh3FXJPzJ0JVUv8e+p3HJGwZ5Sb20Ih/yYZdEgUB2ERB8AWTJLWAwTy
 bZRsGySulJo6yzLSByBTsWvYH7XYEoFrW4f4gsso53lSUqQAI8RvffG2FZ1b4YdhYxOfxnjgBZm
 zN1Dal3O3hZHgZ8iRKyjScBd7YpwcQwLM4ycYQgzu858=
X-Received: by 2002:a05:600c:4f4b:b0:45b:7692:b47 with SMTP id
 5b1f17b1804b1-45b76920d55mr53926165e9.29.1756455488836; 
 Fri, 29 Aug 2025 01:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyyGsBkttgeS7BzmFC4J/AwQDLZRqKtpp1oQ0UIIvSXx9XcNpUWRnzJGxKQUGtrddvV2Oinw==
X-Received: by 2002:a05:600c:4f4b:b0:45b:7692:b47 with SMTP id
 5b1f17b1804b1-45b76920d55mr53925725e9.29.1756455488377; 
 Fri, 29 Aug 2025 01:18:08 -0700 (PDT)
Received: from [192.168.10.48] ([151.95.56.250])
 by smtp.googlemail.com with ESMTPSA id
 ffacd0b85a97d-3cf33add85bsm2449026f8f.31.2025.08.29.01.18.05
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 29 Aug 2025 01:18:07 -0700 (PDT)
Message-ID: <33661ea1-b0aa-45b3-8923-0b47a40dcea8@redhat.com>
Date: Fri, 29 Aug 2025 10:18:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/8] add cpu_test_interrupt()/cpu_set_interrupt()
 helpers and use them tree wide
To: Igor Mammedov <imammedo@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, mst@redhat.com,
 mtosatti@redhat.com, richard.henderson@linaro.org, riku.voipio@iki.fi,
 thuth@redhat.com, pasic@linux.ibm.com, borntraeger@linux.ibm.com,
 david@redhat.com, jjherne@linux.ibm.com, shorne@gmail.com,
 eduardo@habkost.net, marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, peter.maydell@linaro.org, agraf@csgraf.de,
 mads@ynddal.dk, mrolnik@gmail.com, deller@gmx.de, dirty@apple.com,
 rbolshakov@ddn.com, phil@philjordan.eu, reinoud@netbsd.org,
 sunilmut@microsoft.com, gaosong@loongson.cn, laurent@vivier.eu,
 edgar.iglesias@gmail.com, aurelien@aurel32.net, jiaxun.yang@flygoat.com,
 arikalo@gmail.com, chenhuacai@kernel.org, npiggin@gmail.com,
 rathc@linux.ibm.com, harshpb@linux.ibm.com, yoshinori.sato@nifty.com,
 iii@linux.ibm.com, mark.cave-ayland@ilande.co.uk, atar4qemu@gmail.com,
 qemu-s390x@nongnu.org, qemu-arm@nongnu.org, qemu-ppc@nongnu.org
References: <20250814160600.2327672-7-imammedo@redhat.com>
 <20250821155603.2422553-1-imammedo@redhat.com> <aKyBFlCtnxnP9kt/@intel.com>
 <20250825171912.1bc7b841@fedora> <aK1mHGan+n9NSAOk@intel.com>
 <20250826104731.1440e3ed@fedora>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20250826104731.1440e3ed@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On 8/26/25 10:47, Igor Mammedov wrote:
> While overhead might be issue, it's better to have correcteness 1st.
> (that's why blanket tree wide change to make sure we don't miss places that
> set/test interrupts).

Looking more at it, I found at least one place that sets interrupts
without bql:

     if (ctl_has_irq(env)) {
         cpu_set_interrupt(cs, CPU_INTERRUPT_VIRQ);
     }

I'm going to squash this in:

diff --git a/include/hw/core/cpu.h b/include/hw/core/cpu.h
index 1dee9d4c76e..5c3397fe108 100644
--- a/include/hw/core/cpu.h
+++ b/include/hw/core/cpu.h
@@ -959,12 +959,13 @@ static inline bool cpu_test_interrupt(CPUState *cpu, int mask)
   * @cpu: The CPU to set pending interrupt(s) on.
   * @mask: The interrupts to set.
   *
- * Sets interrupts in @mask as pending on @cpu.
+ * Sets interrupts in @mask as pending on @cpu.  Unlike @cpu_interrupt,
+ * this does not kick the vCPU.
   */
  static inline void cpu_set_interrupt(CPUState *cpu, int mask)
  {
-    qatomic_store_release(&cpu->interrupt_request,
-        cpu->interrupt_request | mask);
+    /* Pairs with cpu_test_interrupt(). */
+    qatomic_or(&cpu->interrupt_request, mask);
  }
  
  /**


