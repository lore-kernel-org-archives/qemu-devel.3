Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7681FE7716C
	for <qemu-devel@archiver.kernel.org>; Thu,  5 Dec 2024 15:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tJECs-0005Zm-EQ; Thu, 05 Dec 2024 10:55:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJECq-0005Z8-PC
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:55:56 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tJECp-0006da-AK
 for qemu-devel@nongnu.org; Thu, 05 Dec 2024 10:55:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733414154;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=7VH6aBVI0v2Utc5ls8KiwZY+aj9+fZ4f9uYnISwwCs4=;
 b=JG+EHEm6tzi3/J6U6IEhkz9wX1Eu0/IHaj3+YlwNS/gtewItv1OfXzd6wwj4DP6HQqINDP
 b58hT/oRYfYSkYoN3RX5doCKw2tNDJUGpMNw+D/mrA0n44/JWobimhZT2GBf/PBQ9epbca
 +UBr7EtuEFnn1xyjeVNMF/tCdTuiAB0=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-dC6VfU8eM7utE7Zl50Rzdw-1; Thu, 05 Dec 2024 10:55:49 -0500
X-MC-Unique: dC6VfU8eM7utE7Zl50Rzdw-1
X-Mimecast-MFC-AGG-ID: dC6VfU8eM7utE7Zl50Rzdw
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7b67a9aea08so173183085a.2
 for <qemu-devel@nongnu.org>; Thu, 05 Dec 2024 07:55:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733414149; x=1734018949;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=7VH6aBVI0v2Utc5ls8KiwZY+aj9+fZ4f9uYnISwwCs4=;
 b=dCi19LRd7ektdTcFQ0KrYSBoRO4+cxefidgF/TFQEH3Mfkm4bK4kNHeAs/9GDiCzcw
 flzqlkxpnaH39EssXKqt5nrp/r4SJLCxqsz/Lt4HRB+MD2oRUvQYQzCrimP9hvj8DagA
 w0TvFCTaQY00OAfSUDTJKob+4o+K2KXilK1lQx6Pqo56Bbsh77z0fC60X2r232s21x8N
 HxxXyDwlVtt7xvlBTgwC/eEi2W4IVfafX64AdhUEFV42c/myOeoB1Sr26qHBHjYGwZSN
 Fb1qKyREAjJmQSm9tTbT6jGoffEOMdDAMPgyhWilKFfKAIc2i2Q/+Wtau471jpifj35b
 P98A==
X-Gm-Message-State: AOJu0Ywv5oaD1STJ7M0lYpm8fswo3v1norPCdLU8hiQKbJx4DYTgK8o1
 SnTGZlOV9DVgwvg1dCLx15dO/X059uRdNlBjl6imqYp9n7TNy3RIT9XNgu9o3WglEqGRzqXDVOE
 2bfAnQxkDv64+L1duaSHMNBScWtsHw75CmfAtCw0iun0bmLJGO4mh
X-Gm-Gg: ASbGncsSTtlxObCqyex/kLuuxX6AX+q8TZNKES1hlNwTMMt9mYQ6435Zf6z11+8Degr
 nlBwKa2zx4cX6RlyY+kH/ItCWo9rE7G4oXDELqScHqoNZNPyTOVGhLlwXLsRv+MGNKmU0Q3Qg4R
 fUlT8pyE1fP4NFNOx/RS9AzsjwlP6ZVyFcRzqy/xgdNJzQQxpnIMVGnp/+ACkgQKNcTk78Ebn4X
 4jz8P1dzYKG2Sau9T0uoWz66723y8lx6Lfi3Is01j+K+HoVnF6/
X-Received: by 2002:a05:620a:4806:b0:7b6:7ac5:5de1 with SMTP id
 af79cd13be357-7b6a5d51ae1mr1558432685a.7.1733414149186; 
 Thu, 05 Dec 2024 07:55:49 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFxwWA8EKyzNa/fiZP1e7uBzZHteImkNVFYkfXtqTkkaiUD1cglyLAMwOfGKftfYkJQgd6zeA==
X-Received: by 2002:a05:620a:4806:b0:7b6:7ac5:5de1 with SMTP id
 af79cd13be357-7b6a5d51ae1mr1558429985a.7.1733414148887; 
 Thu, 05 Dec 2024 07:55:48 -0800 (PST)
Received: from [10.20.9.127] ([144.121.20.162])
 by smtp.googlemail.com with ESMTPSA id
 af79cd13be357-7b6b5a9e5c7sm71285685a.99.2024.12.05.07.55.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 Dec 2024 07:55:48 -0800 (PST)
Message-ID: <75edc6e5-e65f-40c0-90ee-6ac1fa018f5c@redhat.com>
Date: Thu, 5 Dec 2024 16:55:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 03/13] rust/cell: add get_mut() method for BqlCell
To: Zhao Liu <zhao1.liu@intel.com>, "Michael S . Tsirkin" <mst@redhat.com>,
 Manos Pitsidianakis <manos.pitsidianakis@linaro.org>,
 Junjie Mao <junjie.mao@hotmail.com>, =?UTF-8?Q?Alex_Benn=C3=A9e?=
 <alex.bennee@linaro.org>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org, qemu-rust@nongnu.org
References: <20241205060714.256270-1-zhao1.liu@intel.com>
 <20241205060714.256270-4-zhao1.liu@intel.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
Autocrypt: addr=pbonzini@redhat.com; keydata=
 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
In-Reply-To: <20241205060714.256270-4-zhao1.liu@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.996,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On 12/5/24 07:07, Zhao Liu wrote:
> The get_mut() is useful when doing compound assignment operations, e.g.,
> *c.get_mut() += 1.
> 
> Implement get_mut() for BqlCell by referring to Cell.

I think you can't do this because the BQL might be released while the owner has a &mut.  Like:

    let mtx = Mutex<BqlCell<u32>>::new();
    let guard = mtx.lock();
    let cell = &mut *guard;
    let inner = cell.get_mut(cell);
    // anything that releases bql_lock
    *inner += 1;

On the other hand I don't think you need it.  You have just two uses.

First, this one:

+        if set && self.is_int_level_triggered() {
+            // If Timer N Interrupt Enable bit is 0, "the timer will
+            // still operate and generate appropriate status bits, but
+            // will not cause an interrupt"
+            *self.get_state_mut().int_status.get_mut() |= mask;
+        } else {
+            *self.get_state_mut().int_status.get_mut() &= !mask;
+        }

Where you can just write

     self.get_state_ref().update_int_status(self.index,
         set && self.is_int_level_triggered())

and the HPETState can do something like

     fn update_int_status(&self, index: u32, level: bool) {
         self.int_status.set(deposit64(self.int_status.get(), bit, 1, level as u64));
     }

For hpet_fw_cfg you have unsafe in the device and it's better if you do:

-        self.hpet_id.set(unsafe { hpet_fw_cfg.assign_hpet_id() });
+        self.hpet_id.set(fw_cfg_config::assign_hpet_id());

with methods like this that do the unsafe access:

impl fw_cfg_config {
     pub(crate) fn assign_hpet_id() -> usize {
         assert!(bql_locked());
         // SAFETY: all accesses go through these methods, which guarantee
         // that the accesses are protected by the BQL.
         let fw_cfg = unsafe { &mut *hpet_fw_cfg };

         if self.count == u8::MAX {
             // first instance
             fw_cfg.count = 0;
         }

         if fw_cfg.count == 8 {
             // TODO: Add error binding: error_setg()
             panic!("Only 8 instances of HPET is allowed");
         }

         let id: usize = fw_cfg.count.into();
         fw_cfg.count += 1;
         id
     }
}

and you can assert bql_locked by hand instead of using the BqlCell.

Paolo

> Signed-off-by: Zhao Liu <zhao1.liu@intel.com>
> ---
>   rust/qemu-api/src/cell.rs | 25 +++++++++++++++++++++++++
>   1 file changed, 25 insertions(+)
> 
> diff --git a/rust/qemu-api/src/cell.rs b/rust/qemu-api/src/cell.rs
> index 07b636f26266..95f1cc0b3eb5 100644
> --- a/rust/qemu-api/src/cell.rs
> +++ b/rust/qemu-api/src/cell.rs
> @@ -324,6 +324,31 @@ impl<T> BqlCell<T> {
>       pub const fn as_ptr(&self) -> *mut T {
>           self.value.get()
>       }
> +
> +    /// Returns a mutable reference to the underlying data.
> +    ///
> +    /// This call borrows `BqlCell` mutably (at compile-time) which guarantees
> +    /// that we possess the only reference.
> +    ///
> +    /// However be cautious: this method expects `self` to be mutable, which is
> +    /// generally not the case when using a `BqlCell`. If you require interior
> +    /// mutability by reference, consider using `BqlRefCell` which provides
> +    /// run-time checked mutable borrows through its [`borrow_mut`] method.
> +    ///
> +    /// [`borrow_mut`]: BqlRefCell::borrow_mut()
> +    ///
> +    /// # Examples
> +    ///
> +    /// ```
> +    /// use qemu_api::cell::BqlCell;;
> +    ///
> +    /// let mut c = BqlCell::new(5);
> +    /// *c.get_mut() += 1;
> +    ///
> +    /// assert_eq!(c.get(), 6);
> +    pub fn get_mut(&mut self) -> &mut T {
> +        self.value.get_mut()
> +    }
>   }
>   
>   impl<T: Default> BqlCell<T> {


