Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8E6CC78820
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 11:09:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srbV7-00066e-HM; Fri, 20 Sep 2024 07:08:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1srbV6-00065U-A9
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 07:08:36 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <imammedo@redhat.com>)
 id 1srbV4-00020J-LM
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 07:08:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726830512;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=smD9eCOnZM88D7I0IgFlPCKAkXelzu81bDUKs14qfbY=;
 b=EysKy0DPcPhLchK8NHp+/XldE2qeANO4zAWC+BqzYuS3CPnCcqNPXDImcN7sR3ld3xtpwG
 PSzcYB5O+R/dDuf5ReAMnBRPZeswLcLwEg0v1wdfPKMDgfu6V0ioGw8gS3MwHcuDyxIvYU
 PaX02FPETVMzv4qvDPLE8b88/61dTx4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-XQXMin4iPCSqRd08MPbTbw-1; Fri, 20 Sep 2024 07:08:31 -0400
X-MC-Unique: XQXMin4iPCSqRd08MPbTbw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-42cb0ed9072so17099935e9.1
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 04:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726830510; x=1727435310;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=smD9eCOnZM88D7I0IgFlPCKAkXelzu81bDUKs14qfbY=;
 b=XkkEkTiDa5SPWeaxjZtvktxcyRgL40gxa8o1lMnfadx2VBeAW/l8qDUx/otXx/tdNX
 gM//cNjVnvjHrJee5KaKEvFHuHMDtZumSErDSwV5nnhS9RXRD96y/5Sm2k2J4yfC9c5h
 H4qvCMG4PgljNfgg71d7dQfdGfFxGLyfuvNeitrJX3d1MFFd4ikQ0aew02/jbJMkQiNJ
 An7+Vqo9C/3362FCQxuRGnO0bQhIQHu82K3SJnwY5hfkvBU4sqD7699zvgID6Y2K+LHm
 jMlKY8f7QH5mUwy1UEQmpPJ71cOyuXAalgzpD/CgRG/r+S9JH5hnXgtyWbfFBP2p+SOQ
 vmQQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCVMeeg7QKv9TZX3yN4jteQ99KITN4emp5YuX8JznxpYD8wjWej3q2u4rD9MuXPwOZapH7CD0VU79Ps6@nongnu.org
X-Gm-Message-State: AOJu0YwkxdTfDDaXXkQTX6kWo+KTjf2gu2a2Sa+WSiq0wBuNeh0EB/p3
 0kIVi9P8K8sYFyV89ojwvvPwKrz7hnRPulo0GrsNkLt4wUkc9JQd2O4joyK3c5jU1wr9vMr7u3M
 VSCxwzg/zENJDMHqhwKsAS6sL+DbznEO5B/P6RTmzcysUjW6NC4+g
X-Received: by 2002:a05:600c:3b92:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42e7abf06b0mr25028825e9.8.1726830509793; 
 Fri, 20 Sep 2024 04:08:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG+bwLaJjYzYShCv/swht1nqHPz0+EEjKi34Z0cjI68xMjdRI1mXgPGClsHltVZglGLb+rNLw==
X-Received: by 2002:a05:600c:3b92:b0:426:5e1c:1ac2 with SMTP id
 5b1f17b1804b1-42e7abf06b0mr25028565e9.8.1726830509364; 
 Fri, 20 Sep 2024 04:08:29 -0700 (PDT)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-42e7afd8219sm19862135e9.29.2024.09.20.04.08.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 04:08:28 -0700 (PDT)
Date: Fri, 20 Sep 2024 13:08:27 +0200
From: Igor Mammedov <imammedo@redhat.com>
To: Zhao Liu <zhao1.liu@intel.com>
Cc: Chuang Xu <xuchuangxclwt@bytedance.com>, qemu-devel@nongnu.org,
 pbonzini@redhat.com, xieyongji@bytedance.com, chaiwen.cc@bytedance.com,
 qemu-stable@nongnu.org, Guixiong Wei <weiguixiong@bytedance.com>, Yipeng
 Yin <yinyipeng@bytedance.com>
Subject: Re: [PATCH v3] i386/cpu: fixup number of addressable IDs for
 logical processors in the physical package
Message-ID: <20240920130827.751ccfb1@imammedo.users.ipa.redhat.com>
In-Reply-To: <ZuxtmjZBGGwNaVwl@intel.com>
References: <20240918131815.8543-1-xuchuangxclwt@bytedance.com>
 <ZuxtmjZBGGwNaVwl@intel.com>
X-Mailer: Claws Mail 4.3.0 (GTK 3.24.43; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=imammedo@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 20 Sep 2024 02:29:46 +0800
Zhao Liu <zhao1.liu@intel.com> wrote:

> Hi Chuang and Igor,
> 
> Sorry for late reply,
> 
> On Wed, Sep 18, 2024 at 09:18:15PM +0800, Chuang Xu wrote:
> > Date: Wed, 18 Sep 2024 21:18:15 +0800
> > From: Chuang Xu <xuchuangxclwt@bytedance.com>
> > Subject: [PATCH v3] i386/cpu: fixup number of addressable IDs for logical
> >  processors in the physical package
> > X-Mailer: git-send-email 2.24.3 (Apple Git-128)
> > 
> > When QEMU is started with:
> > -cpu host,migratable=on,host-cache-info=on,l3-cache=off
> > -smp 180,sockets=2,dies=1,cores=45,threads=2
> > 
> > Try to execute "cpuid -1 -l 1 -r" in guest, we'll obtain a value of 90 for
> > CPUID.01H.EBX[23:16], while the expected value is 128. And Try to
> > execute "cpuid -1 -l 4 -r" in guest, we'll obtain a value of 63 for
> > CPUID.04H.EAX[31:26] as expected.
> > 
> > As (1+CPUID.04H.EAX[31:26]) round up to the nearest power-of-2 integer,
> > we'd beter round up CPUID.01H.EBX[23:16] to the nearest power-of-2
> > integer too. Otherwise we may encounter unexpected results in guest.
> > 
> > For example, when QEMU is started with CLI above and xtopology is disabled,
> > guest kernel 5.15.120 uses CPUID.01H.EBX[23:16]/(1+CPUID.04H.EAX[31:26]) to
> > calculate threads-per-core in detect_ht(). Then guest will get "90/(1+63)=1"
> > as the result, even though theads-per-core should actually be 2.
> > 
> > So let us round up CPUID.01H.EBX[23:16] to the nearest power-of-2 integer
> > to solve the unexpected result.
> > 
> > Signed-off-by: Guixiong Wei <weiguixiong@bytedance.com>
> > Signed-off-by: Yipeng Yin <yinyipeng@bytedance.com>
> > Signed-off-by: Chuang Xu <xuchuangxclwt@bytedance.com>
> > ---
> >  target/i386/cpu.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/target/i386/cpu.c b/target/i386/cpu.c
> > index 4c2e6f3a71..3710ae5283 100644
> > --- a/target/i386/cpu.c
> > +++ b/target/i386/cpu.c
> > @@ -6417,7 +6417,7 @@ void cpu_x86_cpuid(CPUX86State *env, uint32_t index, uint32_t count,
> >          }
> >          *edx = env->features[FEAT_1_EDX];
> >          if (threads_per_pkg > 1) {
> > -            *ebx |= threads_per_pkg << 16;
> > +            *ebx |= pow2ceil(threads_per_pkg) << 16;  
> 
> Yes, the fix is right.
> 
> About the "Maximum number of addressable IDs", the commit 88dd4ca06c83
> ("i386/cpu: Use APIC ID info to encode cache topo in CPUID[4]")
> introduced the new way to calculate.
> 
> The pow2ceil() works for current SMP topology, but may be wrong on
> hybrid topology, as the reason I listed in the commit message:
> 
> > The nearest power-of-2 integer can be calculated by pow2ceil() or by
> > using APIC ID offset/width (like L3 topology using 1 << die_offset [3]).  
> 
> > But in fact, CPUID.04H:EAX[bits 25:14] and CPUID.04H:EAX[bits 31:26]
> > are associated with APIC ID. For example, in linux kernel, the field
> > "num_threads_sharing" (Bits 25 - 14) is parsed with APIC ID. And for
> > another example, on Alder Lake P, the CPUID.04H:EAX[bits 31:26] is not
> > matched with actual core numbers and it's calculated by:
> > "(1 << (pkg_offset - core_offset)) - 1".  
> 
> Using APIC ID offset to calculate is the hardware's approach, so I tried
> to use APIC ID instead of pow2ceil() and replaced all pow2ceil() case.

Well, hybrid case needs some more explanation then.

'pow2ceil(threads_per_pkg) << 16' - does exactly what SDM says for CPUID.01H.EBX[23:16]

Can you point to a spec that confirms that above is wrong and
explain in more details how hybrid case is supposed to work
and where it's documented?
 


> 
> Hi Igor, do you agree? :-)
> 
> Best Regards,
> Zhao
> 


