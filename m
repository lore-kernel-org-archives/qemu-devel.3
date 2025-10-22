Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 86822CCD1BB
	for <qemu-devel@archiver.kernel.org>; Wed, 22 Oct 2025 15:27:33 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vBak8-0000RD-PN; Wed, 22 Oct 2025 11:27:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBak1-0000Ok-NL
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:27:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <leonardi@redhat.com>)
 id 1vBajy-0003OS-NH
 for qemu-devel@nongnu.org; Wed, 22 Oct 2025 11:27:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761146824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EQdg7L7Qzdrzwh58aH961jrH5pZkPkCtRRFctHkHpDY=;
 b=EfCRk0rcpcWbZSgiCNHuEbM2ABfzUls03P2hYEuzh/ttcNK40Bim3tYjagI+cqwcFvMWtq
 XUtHOonkItbQgoHDMqRcPoXqsqKEo/G8yxgRVRwnnE6M2y9/GZYr1XqsZRQZUPn8iMk1Te
 1/D66OB6rvikN/QQaoDhPyT8MbcfIwY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-vjkL4krmO0OBkaFDto51ew-1; Wed, 22 Oct 2025 11:27:03 -0400
X-MC-Unique: vjkL4krmO0OBkaFDto51ew-1
X-Mimecast-MFC-AGG-ID: vjkL4krmO0OBkaFDto51ew_1761146823
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-87c1cc5a75dso343469876d6.0
 for <qemu-devel@nongnu.org>; Wed, 22 Oct 2025 08:27:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1761146823; x=1761751623;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=EQdg7L7Qzdrzwh58aH961jrH5pZkPkCtRRFctHkHpDY=;
 b=MwQqQKF7UgZzjMvZyDdwUF2/XqV15Yg99BNY6k+OhWMxI08zODDfYzuA9F4c9McomR
 B9CyYD8dUeCgBETr7b12H4V3atuw8fLqoypJKvo2k53vc/eQ7NS0yxgN72Me2WAwyV24
 vl40GsHgV66aMEjVHYNS2yz52L09uYT6ltCZeqhj5szurs6V1wM8adfUfOGuDDMz7VdD
 WToyO+F0vKqi3ImoFy4SJM/xUNYYwDbFnZwnyCEXv/F6dl+dHT/SU/zbv6JCkTjUq368
 LGNW0SYierW7yOgA+f0ExfldlRBs3iHR/l0BNJx7n2eIKnVwjyAESv8Nn76arJ++HBzq
 CSeQ==
X-Gm-Message-State: AOJu0YzivRkj2Z1lLqFhh9GG2LHLguMP68FDMYQdsyx1MVKpG1Cvu9eQ
 hhKXxJeMRfBozp4KAixiCSMcGKO/k++1DE+X5zZ/Vww6spKwFkUgwYCzSgFzK5sk60FL0fVyCVx
 3f9RLcffR52Wn3rlE8fQoM6CNaorOxpZUIfgQCaKy4uqwMDig3tBc154T
X-Gm-Gg: ASbGncvw8XWOzr1Pp6HKDMigDCXXgXnLDWhWzNCAoMc/LuNe4qNixS6NjaPqIta/mVo
 XuwAT2Dam0lx7YE3Gn1IUkAJMIAr5BHoBrWHGuSPz2si3s6IGCaSuFQ+bVIsA2u0E+0ECfh77bZ
 M9nu3ACKWj5n3hEc0dRD2sNgje5nbnqPhpZZ0hsc6fOGhVEZpw8Wpa3TUG2cvBPRAofHTIBSB82
 LFwALqrAQKVnnmB4JD1fuby82Dqg2px9HQ0ivNUaBDc03+eH9CD/lwozSxDIHuFOOvl10Dd4Ii0
 87LvO/fiBb/tBgmo59OgP35GduvnZpSJiZR62oVdU/XqxG0GmrljvTYS0AULKTadrMK30KeCtNv
 G6c0=
X-Received: by 2002:a05:6214:2dc2:b0:87c:208b:9539 with SMTP id
 6a1803df08f44-87c208b97c9mr325339386d6.28.1761146822719; 
 Wed, 22 Oct 2025 08:27:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGDsJ4wLh9DTrdGB/rRaQMLbfy+kNCHT774VLw+9h0uhzrzfhULC78uOhB+w+j3dIzbqbRbZA==
X-Received: by 2002:a05:6214:2dc2:b0:87c:208b:9539 with SMTP id
 6a1803df08f44-87c208b97c9mr325339036d6.28.1761146822371; 
 Wed, 22 Oct 2025 08:27:02 -0700 (PDT)
Received: from leonardi-redhat ([151.29.47.252])
 by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-87d01efa7e0sm90861706d6.36.2025.10.22.08.27.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Oct 2025 08:27:01 -0700 (PDT)
Date: Wed, 22 Oct 2025 17:26:57 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Stefano Garzarella <sgarzare@redhat.com>, 
 Paolo Bonzini <pbonzini@redhat.com>, Ani Sinha <anisinha@redhat.com>,
 Zhao Liu <zhao1.liu@intel.com>, Roy Hopkins <roy.hopkins@randomman.co.uk>
Subject: Re: [PATCH v4 4/5] igvm: add support for initial register state load
 in native mode
Message-ID: <72idlxesghjbccqtu7ljkcokhhxqavjjmwg7otwb4gt7k5uqsu@bmpipofiuc4c>
References: <20251022084439.242476-1-kraxel@redhat.com>
 <20251022084439.242476-5-kraxel@redhat.com>
 <ijrybqltievczxvugi4hhnftqqeg42o6vshhnirrz2ugeotplf@cq62mc5seswc>
 <5pt6iktxt7fjegov2axrrux3woywuze3cqqmiptwdzayl6vvam@fjm6yyypscrg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <5pt6iktxt7fjegov2axrrux3woywuze3cqqmiptwdzayl6vvam@fjm6yyypscrg>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=leonardi@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Gerd,

On Wed, Oct 22, 2025 at 04:37:33PM +0200, Gerd Hoffmann wrote:
>  Hi,
>
>> > +struct IgvmNativeVpContextX64 {
>> > +    uint64_t rax;
>> > +    uint64_t rcx;
>> > +    uint64_t rdx;
>> > +    uint64_t rbx;
>> > +    uint64_t rsp;
>> > +    uint64_t rbp;
>> > +    uint64_t rsi;
>> > +    uint64_t rdi;
>> > +    uint64_t r8;
>> > +    uint64_t r9;
>> > +    uint64_t r10;
>> > +    uint64_t r11;
>> > +    uint64_t r12;
>> > +    uint64_t r13;
>> > +    uint64_t r14;
>> > +    uint64_t r15;
>> > +    uint64_t rip;
>> > +    uint64_t rflags;
>> > +    uint64_t idtr_base;
>> > +    uint16_t idtr_limit;
>> > +    uint16_t reserved[2];
>> > +    uint16_t gdtr_limit;
>> > +    uint64_t gdtr_base;
>> > +
>> > +    uint16_t code_selector;
>> > +    uint16_t code_attributes;
>> > +    uint32_t code_base;
>> > +    uint32_t code_limit;
>> > +
>> > +    uint16_t data_selector;
>> > +    uint16_t data_attributes;
>> > +    uint32_t data_base;
>> > +    uint32_t data_limit;
>> > +
>> > +    uint64_t gs_base;
>> > +    uint64_t cr0;
>> > +    uint64_t cr3;
>> > +    uint64_t cr4;
>> > +    uint64_t efer;
>> > +};
>
>> IIUC `R_TR` and `R_LDTR` are used by HVF in QEMU. Is there a reason 
>> why you
>> didn't add them here?
>
>They are not present in IgvmNativeVpContextX64, so you can't set them
>via igvm for the initial vcpu state.  Of course the guest can set them
>later on.
>

Thanks for the clarification.

Reviewed-by: Luigi Leonardi <leonardi@redhat.com>

>take care,
>  Gerd
>


