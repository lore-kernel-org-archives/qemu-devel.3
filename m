Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95CD6CA0EE4
	for <qemu-devel@archiver.kernel.org>; Mon, 18 Aug 2025 21:18:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uo7EX-0003ye-Op; Mon, 18 Aug 2025 17:17:37 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uo7EV-0003xs-M4
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:17:35 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1uo7ET-0000yc-Ga
 for qemu-devel@nongnu.org; Mon, 18 Aug 2025 17:17:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1755551851;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8ZQIBh445C+TAZqUq+EeViJ+YOzDMQzAntdQoy1tddE=;
 b=TncK4aC7ffWnMVA76pjL00T9PN4LMVi/T41wp0NgZEJKkJczw/NfXeKkZGwripO3Op/iAG
 z5ZVmv2dqb5GJLPBMnlXckMpe4ZRQHMWB8KJWZdVZlIq1bLwF7MF3xBpyTkXQ3dqf8ZMtI
 tKKGtvoKM8HXsTrprSUnTarp9bKbumo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-uyMWmkkVNJOjl-cwPsfCDQ-1; Mon, 18 Aug 2025 17:17:30 -0400
X-MC-Unique: uyMWmkkVNJOjl-cwPsfCDQ-1
X-Mimecast-MFC-AGG-ID: uyMWmkkVNJOjl-cwPsfCDQ_1755551849
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-3b9d41e5125so2738213f8f.0
 for <qemu-devel@nongnu.org>; Mon, 18 Aug 2025 14:17:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1755551849; x=1756156649;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=8ZQIBh445C+TAZqUq+EeViJ+YOzDMQzAntdQoy1tddE=;
 b=gT8pbIr9/UBADh8gRaOY9dXx0FaLJLVVQ+1lKHEstGA6GIk4WN3kYLZp35IG4M6mrv
 7aJRElg8j4jWghXY9TD8npQ5Z23vUl392GPXutT3vQKXmCY7HJIlyiwVcrU+/lYJYoN0
 5E7xVbG6ut2y2po2dHUqI3ls9NzuFnnoCVY4ZdZQucucbBqotINcpJhGRpGO1CXmq5to
 gKeoiChz5MhiPH3HeaKUrIFyKaTYiZrJ5RVl+qvh+wZjmAU/GClUVQEJUFhSJfPz02WG
 9I6fBBJALqaXzyzH9o0zQ5Psd81wtoNpGHZbw0W0wd3LNR0hrMfV0oZr94iyw3guCNo3
 Rz+w==
X-Forwarded-Encrypted: i=1;
 AJvYcCXbhhMfKLo03C1Zz0PNIKrNMx6e3JFdkbC++zbT5ugwSwGsHVwR8cD/JG/X6NLGBpui7gIgob4sMW2P@nongnu.org
X-Gm-Message-State: AOJu0YzpuVv0GX76VfQieESsoLAk+ZqJlTE06yzWdd8stfEPBnKVPdhq
 u5/oqCeOOXZs1uu9e2o48cFdj3i7t09K/EdRRftwuQjH2CX8YqyXJva7khlplO3u7OR093zOilP
 fyrU7RG83x5q/ZhGAbwmHnK6gqGGtqofMv3/dhnRSnJazvIH9FMYaGE+2SWSzJDyXvpikzE/jaI
 fsywKVaD9FKn1Bgkzr+/gdGLMUu5eGAgs=
X-Gm-Gg: ASbGnct1XVjNW5HblPz2umO9NDWcu7wmReggyAvBGxTGDw4O35R1tyIJbPEkIdERtu9
 11DykkveYR66N8jXTtwxmNL5lThOIl81VspWB+vqbFksxVQQTlw3/lBlxdLh/R8Zg2YZmuSASX4
 ZLwmwW7dNO9I1EhSaPHgW+VA==
X-Received: by 2002:a05:6000:40e0:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3c0ebbd1bd9mr108900f8f.38.1755551849059; 
 Mon, 18 Aug 2025 14:17:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHCrDj9ePfnGI6k08CVKR9TQ0o7K05DdYt3yq+TzaPI9jVMP661W/KlHJMF0CHj/qXFXfKscLYmxvjqgBWAxmc=
X-Received: by 2002:a05:6000:40e0:b0:3a5:8a09:70b7 with SMTP id
 ffacd0b85a97d-3c0ebbd1bd9mr108892f8f.38.1755551848686; Mon, 18 Aug 2025
 14:17:28 -0700 (PDT)
MIME-Version: 1.0
References: <CAAXNugBwiRuwiNHeuBV5U+HyrSisPSN-HL_7n6Pqc7oAOTX6Pw@mail.gmail.com>
 <c92d983d-0b89-467b-b5e2-b09fe61ff5b9@linaro.org>
 <CAAXNugAJAD=2aBenCJWR-xYt2HszJjEAguxfDBE=hNYZ+osu4w@mail.gmail.com>
In-Reply-To: <CAAXNugAJAD=2aBenCJWR-xYt2HszJjEAguxfDBE=hNYZ+osu4w@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Mon, 18 Aug 2025 23:17:15 +0200
X-Gm-Features: Ac12FXx91L-7OgKfAHcQP7I8ZNPJ7Lq6tEvrALZZinEsyyy1eJmmFHv_O-fLH44
Message-ID: <CABgObfZK6HnOkqVdrrT3w4nnaWuxSV4XqBcQfr5PiqUvjxatAA@mail.gmail.com>
Subject: Re: [PATCH] i386/tcg/svm: fix incorrect canonicalization
To: Zero Tang <zero.tangptr@gmail.com>
Cc: =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 qemu-devel@nongnu.org, richard.henderson@linaro.org, eduardo@habkost.net, 
 Lara Lazier <laramglazier@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Aug 18, 2025 at 5:44=E2=80=AFPM Zero Tang <zero.tangptr@gmail.com> =
wrote:
>
> Hi Philippe,
>
> Thanks for your review comment! But if the patch is already
> queued, is it too late to apply it?

I can adjust it too, no problem.

Paolo

> Kind regards,
> Zero Tang
>
> On Mon, Aug 18, 2025 at 8:16=E2=80=AFPM Philippe Mathieu-Daud=C3=A9 <phil=
md@linaro.org> wrote:
>>
>> Hi Zero,
>>
>> On 6/8/25 09:58, Zero Tang wrote:
>> >   Replaces "long" with "int64_t" during canonicalization.
>> >
>> >   ---
>> >   In Linux GCC, "long" has 8 bytes. However, in msys2 GCC, "long" has =
4
>> >   bytes. In this case, canonicalization would set all high bits to 1 w=
hen
>> >   the segment base is bigger than 0x7FFF (assuming 48-bit linear addre=
ss).
>> >
>> >   This is why QEMU-TCG in Windows cannot boot a bluepill-like hypervis=
or
>> >   in UEFI, in that the guest IDT and GDT bases are above 0x7FFF, there=
by
>> >   resulting in incorrect bases. When an interrupt arrives, it would
>> >   trigger a #PF exception; the #PF would trigger again, resulting in a=
 #DF
>> >   exception; the #PF would trigger for the third time, resulting in
>> >   triple-fault, and eventually causes the shutdown VM-Exit to the
>> >   bluepill hypervisor right after it boots.
>> >
>> >   In summary, this patch replaces "long" with "int64_t" in order to en=
force
>> >   the canonicalization with 64-bit signed integers.
>> >
>> >   Signed-off-by: Zero Tang <zero.tangptr@gmail.com
>> > <mailto:zero.tangptr@gmail.com>>
>> >   ---
>> >    target/i386/tcg/system/svm_helper.c | 2 +-
>> >    1 file changed, 1 insertion(+), 1 deletion(-)
>> >
>> >   diff --git a/target/i386/tcg/system/svm_helper.c b/target/i386/tcg/
>> > system/svm_helper.c
>> >   index b27049b9ed..1ccfccf419 100644
>> >   --- a/target/i386/tcg/system/svm_helper.c
>> >   +++ b/target/i386/tcg/system/svm_helper.c
>> >   @@ -49,7 +49,7 @@ static void svm_save_seg(CPUX86State *env, int
>> > mmu_idx, hwaddr addr,
>> >    static inline void svm_canonicalization(CPUX86State *env,
>> > target_ulong *seg_base)
>> >    {
>> >        uint16_t shift_amt =3D 64 - cpu_x86_virtual_addr_width(env);
>> >   -    *seg_base =3D ((((long) *seg_base) << shift_amt) >> shift_amt);
>> >   +    *seg_base =3D ((((int64_t) *seg_base) << shift_amt) >> shift_am=
t);\
>>
>> Alternatively:
>>
>>           *seg_base =3D sextract64(*seg_base, 0, 64 -
>> cpu_x86_virtual_addr_width(env));
>>
>> >    }
>> >
>> >    static void svm_load_seg(CPUX86State *env, int mmu_idx, hwaddr addr=
,
>> >
>> >   ---
>> >   base-commit: e0006a86615baa70bc9d8b183e528aed91c1ac90
>> >   change-id: 20250806-fix-tcg-svm-canon-adbea9508073
>> >
>> >   Best regards,
>> >   --
>> >   Zero Tang <zero.tangptr@gmail.com <mailto:zero.tangptr@gmail.com>>
>>


