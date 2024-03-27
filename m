Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57FF3C47DD9
	for <qemu-devel@archiver.kernel.org>; Wed, 27 Mar 2024 16:47:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rpWPc-000088-58; Wed, 27 Mar 2024 12:46:04 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpWPY-000076-W5
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:46:01 -0400
Received: from mail-wr1-x434.google.com ([2a00:1450:4864:20::434])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <anthony.perard@cloud.com>)
 id 1rpWPW-00078c-LV
 for qemu-devel@nongnu.org; Wed, 27 Mar 2024 12:46:00 -0400
Received: by mail-wr1-x434.google.com with SMTP id
 ffacd0b85a97d-3417a3151c5so4648363f8f.1
 for <qemu-devel@nongnu.org>; Wed, 27 Mar 2024 09:45:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=cloud.com; s=cloud; t=1711557956; x=1712162756; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=zBErRmkltSguH2d0/UJYPB7aHlGXWYjo+/5oLZJOopI=;
 b=hzqfcDQ9GU2BJIdTASR8c/h4N/tRuRHhJy+0Y1llYA/wHTnZ8EAQTR07h9QdrCqGbE
 FrmetuQF3AVEml830gDNMik1cAwgBj5njNEHblnEnUnMrEQTgcHUpdGnyNjU29353Qzr
 U/BIH59hi8YhqiHOx3ivNknjO5bpxW7GaNDdc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1711557956; x=1712162756;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=zBErRmkltSguH2d0/UJYPB7aHlGXWYjo+/5oLZJOopI=;
 b=aQzmSCekT6isgOppIIV6LWFFUOe0/RXk6wyOovs994BvK+f1JR4CDo1r4fiFrKG2EO
 8/WlFCOGx8h3GoNF9+r8WKWOTrcgji8UE5BHTwGqgZVfJW9uueIk8lGzqwsEYO5U3cyv
 naycdsf8fHJirC2J+Pc277WC4pXRI0meypAYVgPnDccVd6R9DZ++PVpx3fv31kJqoLvx
 QsBMjwWLT+dWl7qSk21ogmtqQBZjaOlId+yCGLUYEnusJ+f4mb9c+hteFhYfVyyHN90n
 ykPiBafVYJ0ecWSxXBmGedLdgOeTKKY7BtvNKVzPdR0SSd+W/QVuYgswC8MwPjsakuBq
 BNNQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCXwvhvn7Wu0qd7PFuW9yoOY00vqmyDTURI7+VCZfMrdGckeHPP8ODqGIZQSQdrAJdt53ZHQtdn9vqE9g05kpqVD29XNfAs=
X-Gm-Message-State: AOJu0YxxMzyIZmsLNmcW9V4vv14Ds4XC9EvdId6XJ91O/BeNxFhWi3qX
 WcjNYXu9Ziz5v8oBVg307L2rblXopwEuE2blQqocfl1FIKUGNT+CwgUaElh+yqM=
X-Google-Smtp-Source: AGHT+IGpIy3vGf4ZXnW5ibtGUcB1DXYHc9NeWjaOzQq8JTFfd0ipLrHkEfSGQkvsU8UA2GxqISwyxw==
X-Received: by 2002:a05:6000:92c:b0:342:86e9:b3c7 with SMTP id
 cx12-20020a056000092c00b0034286e9b3c7mr76883wrb.37.1711557956127; 
 Wed, 27 Mar 2024 09:45:56 -0700 (PDT)
Received: from perard.uk.xensource.com (default-46-102-197-194.interdsl.co.uk.
 [46.102.197.194]) by smtp.gmail.com with ESMTPSA id
 en7-20020a056000420700b0034174875850sm14015642wrb.70.2024.03.27.09.45.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Mar 2024 09:45:55 -0700 (PDT)
Date: Wed, 27 Mar 2024 16:45:54 +0000
From: Anthony PERARD <anthony.perard@cloud.com>
To: Philippe =?iso-8859-1?Q?Mathieu-Daud=E9?= <philmd@linaro.org>
Cc: David Woodhouse <dwmw@amazon.co.uk>, qemu-devel@nongnu.org,
 Alex =?iso-8859-1?Q?Benn=E9e?= <alex.bennee@linaro.org>,
 Paul Durrant <paul@xen.org>, qemu-arm@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>, David Woodhouse <dwmw2@infradead.org>,
 Stefano Stabellini <sstabellini@kernel.org>,
 Richard Henderson <richard.henderson@linaro.org>,
 xen-devel@lists.xenproject.org, qemu-block@nongnu.org,
 kvm@vger.kernel.org, Thomas Huth <thuth@redhat.com>
Subject: Re: [RFC PATCH-for-9.0 v2 13/19] hw/xen: Remove use of
 'target_ulong' in handle_ioreq()
Message-ID: <3a2da257-87f7-4d3f-9ef2-8450bc7b2742@perard>
References: <20231114143816.71079-1-philmd@linaro.org>
 <20231114143816.71079-14-philmd@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20231114143816.71079-14-philmd@linaro.org>
Received-SPF: pass client-ip=2a00:1450:4864:20::434;
 envelope-from=anthony.perard@cloud.com; helo=mail-wr1-x434.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Nov 14, 2023 at 03:38:09PM +0100, Philippe Mathieu-Daudé wrote:
> Per commit f17068c1c7 ("xen-hvm: reorganize xen-hvm and move common
> function to xen-hvm-common"), handle_ioreq() is expected to be
> target-agnostic. However it uses 'target_ulong', which is a target
> specific definition.
> 
> Per xen/include/public/hvm/ioreq.h header:
> 
>   struct ioreq {
>     uint64_t addr;          /* physical address */
>     uint64_t data;          /* data (or paddr of data) */
>     uint32_t count;         /* for rep prefixes */
>     uint32_t size;          /* size in bytes */
>     uint32_t vp_eport;      /* evtchn for notifications to/from device model */
>     uint16_t _pad0;
>     uint8_t state:4;
>     uint8_t data_is_ptr:1;  /* if 1, data above is the guest paddr
>                              * of the real data to use. */
>     uint8_t dir:1;          /* 1=read, 0=write */
>     uint8_t df:1;
>     uint8_t _pad1:1;
>     uint8_t type;           /* I/O type */
>   };
>   typedef struct ioreq ioreq_t;
> 
> If 'data' is not a pointer, it is a u64.
> 
> - In PIO / VMWARE_PORT modes, only 32-bit are used.
> 
> - In MMIO COPY mode, memory is accessed by chunks of 64-bit

Looks like it could also be 8, 16, or 32 as well, depending on
req->size.

> - In PCI_CONFIG mode, access is u8 or u16 or u32.
> 
> - None of TIMEOFFSET / INVALIDATE use 'req'.
> 
> - Fallback is only used in x86 for VMWARE_PORT.
> 
> Masking the upper bits of 'data' to keep 'req->size' low bits
> is irrelevant of the target word size. Remove the word size
> check and always extract the relevant bits.

When building QEMU for Xen, we tend to build the target "i386-softmmu",
which looks like to have target_ulong == uint32_t. So the `data`
clamping would only apply to size 8 and 16. The clamping with
target_ulong was introduce long time ago, here:
https://xenbits.xen.org/gitweb/?p=xen.git;a=commitdiff;h=b4a663b87df3954557434a2d31bff7f6b2706ec1
and they were more IOREQ types.
So my guess is it isn't relevant anymore, but extending the clamping to
32-bits request should be fine, when using qemu-system-i386 that is, as
it is already be done if one use qemu-system-x86_64.

So I think the patch is fine, and the tests I've ran so far worked fine.

> Signed-off-by: Philippe Mathieu-Daudé <philmd@linaro.org>

Reviewed-by: Anthony PERARD <anthony.perard@citrix.com>

Thanks,

-- 
Anthony PERARD

