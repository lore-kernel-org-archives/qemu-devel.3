Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A817C87FCA
	for <qemu-devel@archiver.kernel.org>; Thu,  7 Aug 2025 13:39:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uk0pj-0008Hi-F5; Thu, 07 Aug 2025 09:39:03 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uk0ph-0008Ef-Ro
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:39:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uk0pf-0006aG-8C
 for qemu-devel@nongnu.org; Thu, 07 Aug 2025 09:39:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1754573938;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=eajPJ0jM75i14E/4uSBoOxv9vy6PstDXgr8ThgCRvCc=;
 b=IA1Vwo4Sr2L+30kj6gCI77wu7Ci/+fV7d445nzpYF7+RbQkHP97WdGsaJplzZeGRiQw0m+
 nwxbtQV//JpdYB+GbcWY3TsdafkwVppV0xM5EentnMiwoYl2t3JgPojc8WWBXoahRFgNA0
 /98NKfyNBknABxT5Xbjduc3jxwed2Lk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-222-wFirG2hJOC6of2rvtytRKg-1; Thu, 07 Aug 2025 09:38:57 -0400
X-MC-Unique: wFirG2hJOC6of2rvtytRKg-1
X-Mimecast-MFC-AGG-ID: wFirG2hJOC6of2rvtytRKg_1754573936
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-3b8d5fc4f94so469078f8f.3
 for <qemu-devel@nongnu.org>; Thu, 07 Aug 2025 06:38:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1754573935; x=1755178735;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=eajPJ0jM75i14E/4uSBoOxv9vy6PstDXgr8ThgCRvCc=;
 b=TuVs0FzZc0sesBit5d0ZwjL1wqiVeZFQ0534i6/b3ZOjicBnDIW+ymo1D5WjKsscZ2
 Vs2Pa4Y+ZUSgD0dzybLSlT30qIqcx6psZ7xYS0+6MXWXtoFzWjlw4WuXOu1akl1/h7Jc
 mU0StVOH2DlmwfpLYaHlkIHjQbN6cf4co5xFsweuWeivi1PkF9m1ucKTpYiUw+YNxu7i
 J7BQJCSbUbJ0SNEFKEZHiV7pg35S4lrCAYjPdsMP07L9XtpERhmYAGv4fqw1+mDQrUkR
 ODeD84mCClkzTENa790MfwKbAQFmkb7GRF7VwSuHkkogvzFRaQmbB6r3GoWagYuuBPB/
 2aTQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCX9F3eq2i1CwU19fP/XkVY+cxFJ/H+zIoqe42KiCAs8PT1bhEe/AhNmmp+ABPfT7ufm9+udVDZE+2K9@nongnu.org
X-Gm-Message-State: AOJu0Yy7PjiUh7zDDv1SHADPsg1i2DapUl54JXVuIIkKOe4Cxo0uQpHU
 7Pv37TRkw5w6Waqr7CVqJk+gAgbvYeEQs6nSN69I/mVh9LLbHmEsO5mvBWXCb6Lr9nl2/TrC1TF
 iA4MkavAIE+uJFX8V00z2OiB1V5E+UEBKuaPBIj8IEj7PgwCjWz/mzmTW/Vb9usm4
X-Gm-Gg: ASbGncudMzmFybgCxHLHUVnvIafNEH/RUmbyHCNm6OrFryznadMpFt1ddMx4na9STEU
 Qw3UIYCAsZAga/jC9Gh4FATp1WAOyLb7MpxRVLm/ihZVKAvcL3Hb5EemEUmh6+ABlrbIIRFBc9A
 3Loa+x2BUV5+Fhrlkxw5NqwpJ6dKc0e0/0eMXwP1BBixyAUnbvUdCntijeuZqvEvdZBki7JAVfz
 mwromBDOn7C2G97NCVOXEtOV5Gy9QDukFqwGX02z1CXT1bVSHJYierbiBgWLpIOTX57JYqzfiKp
 69bmSnWksRB0Cmf/o/bXcJCFYHz2BDL6O8Yxiy5OJNks
X-Received: by 2002:a05:6000:2004:b0:3b5:dc07:50a4 with SMTP id
 ffacd0b85a97d-3b8f418b286mr6079774f8f.2.1754573934728; 
 Thu, 07 Aug 2025 06:38:54 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFE0ZIjqHS/eIqY3HrroZIdY8WRWawmXq1zwhUh6yxr8Vx4HA2BsznnI5IFH1AHOUbYTmQ9Kw==
X-Received: by 2002:a05:6000:2004:b0:3b5:dc07:50a4 with SMTP id
 ffacd0b85a97d-3b8f418b286mr6079748f8f.2.1754573934243; 
 Thu, 07 Aug 2025 06:38:54 -0700 (PDT)
Received: from [192.168.10.48] ([151.49.253.173])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-459e5c84b8csm47925475e9.4.2025.08.07.06.38.53
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 Aug 2025 06:38:53 -0700 (PDT)
Message-ID: <c641dbf2-a2e7-4c44-b231-fc872df1fe69@redhat.com>
Date: Thu, 7 Aug 2025 15:38:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 13/26] rust: Add RCU bindings
To: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>
Cc: Peter Xu <peterx@redhat.com>, David Hildenbrand <david@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Thomas Huth <thuth@redhat.com>, Junjie Mao <junjie.mao@hotmail.com>,
 qemu-devel@nongnu.org, qemu-rust@nongnu.org,
 Dapeng Mi <dapeng1.mi@linux.intel.com>,
 Chuanxiao Dong <chuanxiao.dong@intel.com>
References: <20250807123027.2910950-1-zhao1.liu@intel.com>
 <20250807123027.2910950-14-zhao1.liu@intel.com>
 <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <CAAjaMXZ9XbEmcJVg1-8uFhnkG-qUF+sB5g26e0W3HhxK_-NFwg@mail.gmail.com>
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
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 8/7/25 14:29, Manos Pitsidianakis wrote:

>> +//! Bindings for `rcu_read_lock` and `rcu_read_unlock`.
>> +//! More details about RCU in QEMU, please refer docs/devel/rcu.rst.
>> +
> 
> How about a RAII guard type? e.g. RCUGuard and runs `rcu_read_unlock` on Drop.

Clippy says Rcu not RCU.  :)

You're right, not just because it's nice but also because it bounds the 
dereference of the FlatView.  Something like this build on top of the 
guard object:

pub struct RcuCell<T> {
     data: AtomicPtr<T>
}

impl<T> RcuCell {
     pub fn raw_get(&self) -> *mut T {
         self.data.load(Ordering::Acquire)
     }

     pub fn get<'g>(&self, _: &'g RcuGuard) -> Option<&'g T> {
         unsafe {
             self.raw_get().as_ref()
         }
     }
}

Using this is a bit ugly, because you need transmute, but it's isolated:

impl AddressSpace {
    pub fn get_flatview(&self, rcu: &'g Guard) -> &'g FlatView {
        let flatp = unsafe {
            std::mem::transmute::<&*mut FlatView, &RcuCell<FlatView>>(
                &self.0.as_ptr().current_map)
        };
        flatp.get(rcu)
    }
}

impl GuestAddressSpace for AddressSpace {
     fn memory(&self) -> Self::T {
         let rcu = RcuGuard::guard();
         FlatViewRefGuard::new(self.get_flatview(rcu))
     }
}

> Destructors are not guaranteed to run or run only once, but the former
> should happen when things go wrong e.g. crashes/aborts. You can add a
> flag in the RCUGuard to make sure Drop runs unlock only once (since it
> takes &mut and not ownership)

Yeah I think many things would go wrong if Arc could run its drop 
implementation more than once.

Paolo


