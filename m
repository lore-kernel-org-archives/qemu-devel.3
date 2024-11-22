Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 38244E65D2F
	for <qemu-devel@archiver.kernel.org>; Fri, 22 Nov 2024 08:09:25 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEOiQ-0001UE-DZ; Fri, 22 Nov 2024 03:08:34 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOiN-0001Tz-Mc
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:08:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1tEOiL-0006gq-5q
 for qemu-devel@nongnu.org; Fri, 22 Nov 2024 03:08:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732262906;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=LRgftvTBDhcefk4FeiYBaxplo0GnNs6y5n23lwk8ikQ=;
 b=QLj2HWUpKQeTKJIYLhgpOM/SzAD2+DxYkoFb3nmnD2tJ9nz854B340fvphq9lnPtLR2zfN
 tDEwn1gi9L+o0+JdYbauYImeaULwn0k3U9ft5XahzNJ6JO0iq+R1KJ1kKrf94Lw2iJcl6j
 P28dgee9ZJKiha2QMSXhmWUwuFS3kxU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-gT_fm5qqMVOWMv4DBjgvPg-1; Fri, 22 Nov 2024 03:08:25 -0500
X-MC-Unique: gT_fm5qqMVOWMv4DBjgvPg-1
X-Mimecast-MFC-AGG-ID: gT_fm5qqMVOWMv4DBjgvPg
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-38229779bf4so1133482f8f.0
 for <qemu-devel@nongnu.org>; Fri, 22 Nov 2024 00:08:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732262904; x=1732867704;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=LRgftvTBDhcefk4FeiYBaxplo0GnNs6y5n23lwk8ikQ=;
 b=QjO7xTtllq9zbU/bxbcnT69diSd/+YjploZ+Nc1/bclDcmivbNYUiQLtf0Now9p7dn
 fJ7tHxvTlpErrdd9TtD+HsxpCCV/4SiHtdHYxkT3iMcCSBiOhdOA1gtgoYBZlEXoeEll
 +hId9UUkNHOKV1y6o3/s3J3gq1c73/7GPABmdTcm48VAoRdzwQuduOb5eMdP4kNwxqy9
 WT5ELv/92QA533hrIEiwrsdSk+BxcbkMIFbWPRNjP0i6u/hkzDyHp3HN03PHxcSZAen9
 ufthmnZpqD+I2KwCFgSGXRFROv/5IHbKeC7imjJOdGXO/vzrX9uHrpRDWoR6QZGMaKBv
 v9cA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWjkkehYR+i+hoV9grVQZKJWrT2QWtXzFnGWaTz6+KvzLWSRKIpbhqyCgqnpZKMtfb+iIKJVHuP1O9o@nongnu.org
X-Gm-Message-State: AOJu0YxYjL6B80jvbxuB96g9QZZHKXpns3SOdEKeC6g/hhlD/iw0uUPV
 cZ3XkhMujXtDDVTmOyf0VGAyQ7v25jISz3rqk1RIebWKXzilfGQPJiSDAlqHyeuiMJzbbeT74gX
 vLJw7SjSuPhK8JaPfDwXg0JkQ8d0KTArl+IecMjLNIHefI/qRTSkDPWwROY2Tt5+Z1W7j6EDcTD
 kevfhpb+4CpyWTRknVQbYW88XB/Eo=
X-Gm-Gg: ASbGncsBPjnTWczCkNCCZaPu8GR4NrHXDdxND8jowPSl18cOJ+UIosfRDBxf/4S7Yun
 nbrWjQKjkm9bOcx1eftOy0DiCoG2eOO7k
X-Received: by 2002:a05:6000:1882:b0:382:4fd6:405e with SMTP id
 ffacd0b85a97d-38260b86b69mr1362219f8f.29.1732262904085; 
 Fri, 22 Nov 2024 00:08:24 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH9hSycLCM6Zzq88VAUy84zfXg1KHu5q5nfkpgaXC/DlIkbA2uKuDpUShla83eBrWYJyAL1rA9rksxk0LN2RvU=
X-Received: by 2002:a05:6000:1882:b0:382:4fd6:405e with SMTP id
 ffacd0b85a97d-38260b86b69mr1362195f8f.29.1732262903769; Fri, 22 Nov 2024
 00:08:23 -0800 (PST)
MIME-Version: 1.0
References: <CAP52u7a_CA-PEw2gMgc32rCKGt8mqsjCkEedkzTgOosazrTs-w@mail.gmail.com>
 <Zz99VtNtZCx-P5Mx@redhat.com>
 <CABgObfY8fmSjQBU34NVhn-de5iWeWTBJr18u_GgFZpJXjL3NzQ@mail.gmail.com>
 <CAP52u7ZdRxATBfopYB90fgWheuqnxJ1R6p-WK0CX0Nrk7Z4jeQ@mail.gmail.com>
In-Reply-To: <CAP52u7ZdRxATBfopYB90fgWheuqnxJ1R6p-WK0CX0Nrk7Z4jeQ@mail.gmail.com>
From: Paolo Bonzini <pbonzini@redhat.com>
Date: Fri, 22 Nov 2024 09:08:06 +0100
Message-ID: <CABgObfbPK=fNLkQ8esRz0nd1m=ZcMHAV5s7EHgVUNrt67te8Fw@mail.gmail.com>
Subject: Re: QEMU patches for native windows support through clang-cl
To: Erwin Jansen <jansene@google.com>
Cc: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>, 
 Roque Arcudia Hernandez <roqueh@google.com>,
 =?UTF-8?Q?Philippe_Mathieu=2DDaud=C3=A9?= <philmd@linaro.org>, 
 sw@weilnetz.de, lvivier@redhat.com, 
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Patrick Leis <venture@google.com>, 
 Nabih Estefan <nabihestefan@google.com>, Danny Rosen <dannyrosen@google.com>, 
 JP Cottin <jpcottin@google.com>, qemu-devel <qemu-devel@nongnu.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=170.10.133.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Nov 21, 2024 at 10:43=E2=80=AFPM Erwin Jansen <jansene@google.com> =
wrote:
>
> Would a good next step be to work out some more details in a document tha=
t outlines what process we are using, what we are planning to do and includ=
e a set of suggestions as a starting point to see if we can upstream some o=
f the changes to the larger community?

Yes, you can write it at https://wiki.qemu.org/Features/ClangCL. I'll
send you credentials off list.

Paolo

> We currently don't have a proper solution for packing. We are tracking th=
e issue here https://issuetracker.google.com/issues/380295845. All our code=
 is public and development is happening on the emu-dev repository: https://=
android.googlesource.com/platform/external/qemu/+/emu-dev
>
> Greetings,
> Erwin.
>
>
>
>
>
> On Thu, Nov 21, 2024 at 10:47=E2=80=AFAM Paolo Bonzini <pbonzini@redhat.c=
om> wrote:
>>
>> > NB As a general point, we actively block use of clang with Windows
>> > builds (more strictly in 9.2 now), because it lacks support for the
>> > 'gcc_struct' annotation that we rely on to guarantee correct ABI for
>> > structs exposed to guests in particular.
>>
>> Ah, good point. This is
>> https://github.com/llvm/llvm-project/issues/24757 for the general
>> tracking issue, and https://github.com/llvm/llvm-project/pull/71148
>> for a recent PR that attempts to implement this.
>>
>> Using -mno-ms-bitfields globally is unsafe because there are probably
>> Windows API structs that implement it.
>>
>> One solution is to add `QEMU_BUILD_BUG_ON(sizeof(...) =3D=3D ...)` to al=
l
>> structs in QEMU that use bitfields. That will prove very quickly if
>> there are issues or not.
>>
>> Paolo
>>
>> > Many people try to simply remove that #ifdef, mistakenly assuming that
>> > because the code compiles without warnings, it must be correct. Did
>> > you have solution for this, as it would be a blocker for enabling
>> > clang on Windows currently ?
>> >
>> > With regards,
>> > Daniel
>> > --
>> > |: https://berrange.com      -o-    https://www.flickr.com/photos/dber=
range :|
>> > |: https://libvirt.org         -o-            https://fstop138.berrang=
e.com :|
>> > |: https://entangle-photo.org    -o-    https://www.instagram.com/dber=
range :|
>> >
>>


