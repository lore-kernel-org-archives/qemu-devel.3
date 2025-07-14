Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15ABBC83F1B
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 10:36:28 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubGXL-0001y4-J5; Mon, 14 Jul 2025 06:35:57 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ubGXA-0001sW-W4
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:35:49 -0400
Received: from mail-wm1-x336.google.com ([2a00:1450:4864:20::336])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <shentey@gmail.com>) id 1ubGX8-0005jR-4X
 for qemu-devel@nongnu.org; Mon, 14 Jul 2025 06:35:44 -0400
Received: by mail-wm1-x336.google.com with SMTP id
 5b1f17b1804b1-4550709f2c1so17483775e9.3
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 03:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1752489339; x=1753094139; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fyhmpBhtu/dcZmXEZP88zisIC/3WBB2s7sZSZUR3Zbw=;
 b=l4hv2qcsqz9DjMJIeox6DhhK9lH/mR/RePvhCKS9JvV6iYWVl3iBFjJrCfh1631eb+
 wY15Ia97lfrJe+9umWE7OVHqzGwDrV+Gz9MAoT1sMDGnwQOn7yROahfu9SA7iaiUKarK
 YGtEKfocZJA8UEwe44STbYPEX94ymPlNX2Z9OBWCeP+th3+BkQX0XA2vVGCPLNO6ga2j
 JFTM+31c8+UX7MuusBZp43PpmdiMq9feJpby7RJd+t8ggyDe73QTggdf+GR/WaPaCX2O
 oCtgPhdNZGkBXTl6aq7TFzuE5lFI12FgjH8OxkP9Fbx+jGqDd9O2+4ZeifXxyMAhS7R8
 397w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752489339; x=1753094139;
 h=content-transfer-encoding:mime-version:message-id:references
 :in-reply-to:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=fyhmpBhtu/dcZmXEZP88zisIC/3WBB2s7sZSZUR3Zbw=;
 b=q5gPjYPVsrxOPXi/bJxy0lOOGumK8maXW7/S2Ibmn8C6g/l+Embg5tDi3SDRSB3jQv
 DapDIsbUHSHP8SHpTjBVw92Y4l21jz/4PQvkbpSkChrmMj+92eMxqQ8M0Pmx050XqMtC
 7GHC7diW+7mZfdJoRRNXrao6OLh9ABSqHI8JE7eVzL/GS9hA7to/e8B962dwM8MtGIN3
 Br7Eyb5YmRfWonJ4MhieoWSrE66gDDnREaWgUP0hohKUYBTFsWAju6FHCz6ezA9FAvJT
 I8jEISoOQEiaibBl4R6xcLo61jVUQOCqNqXkQTV0f2Fjc8KWrHSLEtRJW2D/4U+o8TK2
 dW9A==
X-Gm-Message-State: AOJu0Yzhx3EMoXwymmAtRFmzpaAgxnQOMpMBFz8iJQ7+vC6UUoy+BKu4
 3H/kEZT1bJvzRU6Uq3tfaoLsxl4iZ08gux7fo81tOi3cYDvq+u8+qNPr
X-Gm-Gg: ASbGncvkKEoSkV8mv87TyAuFdu1zfwKNCl/Cy2HWEe25gf37xRUCTiKe9nzMqwvBGd0
 dvPJh5GhrsYG14MZIk/uQP+yBmN6LQ/xUb1PxQFVQQu3VkCJkuX6AWqgCnT4j85YnC6ZxOPXF8d
 /QC40jJ9VTMQoT3eoINwfbLhrbB5s6CfGMcMjBH1cvP69PyX+huwZwia6fKzuxQVDcIKwa6Mc92
 VMNqEhgjdVKzsujZe3BAe213+af3zp24feZUGS00B9YGI1QFv6EoSe99EQhrSi26RpZwtb1yDoR
 CLnoDvdFHMbE/ymVziuc9V6VGX8jCI7ocu7Pz6FblBi5tAVs2bzuZlzWV+G85x/ZpeFFY0CYMwi
 ioZ/nH/ppVqbAqtyA
X-Google-Smtp-Source: AGHT+IFUqayIul5yGNi/zIzslnz+1SUoQCfEw+W8PEEuqDX92z1ObGRwYUfEMV9gy38bGFBQUOG+zA==
X-Received: by 2002:a05:600c:4f4e:b0:455:f380:32e2 with SMTP id
 5b1f17b1804b1-455f38034f0mr102318015e9.18.1752489338636; 
 Mon, 14 Jul 2025 03:35:38 -0700 (PDT)
Received: from [127.0.0.1] ([62.214.191.67]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b5e8dc2131sm11798352f8f.29.2025.07.14.03.35.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 03:35:38 -0700 (PDT)
Date: Mon, 14 Jul 2025 10:35:36 +0000
From: Bernhard Beschow <shentey@gmail.com>
To: Peter Maydell <peter.maydell@linaro.org>
CC: qemu-devel@nongnu.org, Paolo Bonzini <pbonzini@redhat.com>,
 =?ISO-8859-1?Q?Daniel_P=2E_Berrang=E9?= <berrange@redhat.com>,
 =?ISO-8859-1?Q?Philippe_Mathieu-Daud=E9?= <philmd@linaro.org>,
 =?ISO-8859-1?Q?Marc-Andr=E9_Lureau?= <marcandre.lureau@redhat.com>
Subject: Re: [PATCH] meson: Add most 3rd-party includes as system includes
In-Reply-To: <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
References: <20250617203435.41490-1-shentey@gmail.com>
 <CAFEAcA_cfg5je7Nx-qsQoB=cY7KRYan1+wXhWztoLydnjpg15Q@mail.gmail.com>
Message-ID: <34C24785-7D0B-4C31-B303-90DBC7E9D05B@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::336;
 envelope-from=shentey@gmail.com; helo=mail-wm1-x336.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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



Am 11=2E Juli 2025 10:45:08 UTC schrieb Peter Maydell <peter=2Emaydell@lin=
aro=2Eorg>:
>On Tue, 17 Jun 2025 at 21:35, Bernhard Beschow <shentey@gmail=2Ecom> wrot=
e:
>>
>> When compiling QEMU against fuse3-3=2E17=2E1 with --enable-werror the b=
uild fails
>> with:
>>
>>   In file included from =2E=2E/src/block/export/fuse=2Ec:33:
>>   /usr/include/fuse3/fuse=2Eh:959:5: error: redundant redeclaration of =
=E2=80=98fuse_main_real_versioned=E2=80=99 [-Werror=3Dredundant-decls]
>>     959 | int fuse_main_real_versioned(int argc, char *argv[],
>>         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>>   /usr/include/fuse3/fuse=2Eh:885:5: note: previous declaration of =E2=
=80=98fuse_main_real_versioned=E2=80=99 with type =E2=80=98int(int,  char *=
*, const struct fuse_operations *, size_t,  struct libfuse_version *, void =
*)=E2=80=99 {aka =E2=80=98int(int,  char **, const struct fuse_operations *=
, long unsigned int,  struct libfuse_version *, void *)=E2=80=99}
>>     885 | int fuse_main_real_versioned(int argc, char *argv[],
>>         |     ^~~~~~~~~~~~~~~~~~~~~~~~
>>   cc1: all warnings being treated as errors
>>
>> That is, a fuse header triggers a warning within itself=2E Since QEMU a=
dds the
>> fuse3 include path via `-I`, the compiler thinks that the header is par=
t of the
>> QEMU project, and thus raises a warning=2E The compiler can be told to =
ignore
>> warnings within 3rd party headers by adding these paths via `-isystem`=
=2E Fix the
>> above build failure by marking fuse as system dependency=2E While at it=
 mark
>> every 3rd-party dependency as system dependency to prevent similar issu=
es in the
>> future but skip glib since that results in glib include paths to be omi=
tted from
>> bindgen in case of a Rust build=2E
>
>The problem with this is that -isystem does not only do "suppress
>warnings in these headers" -- it also alters the search order
>for includes, in a way that can sometimes cause problems:
>https://gcc=2Egnu=2Eorg/bugzilla/show_bug=2Ecgi?id=3D70129
>So this isn't completely risk-free, though I think meson tries to
>avoid some of this by doing something a bit more complex than a
>pure 's/-I/-isystem/'=2E
>
>We would also lose the warnings about e=2Eg=2E use of deprecated
>functions in our dependencies=2E

AFAIU the include_type parameter only affects how QEMU itself is built but=
 doesn't affect Meson subprojects=2E Therefore, we should still see depreca=
tion warnings from dependencies in our own code=2E

Best regards,
Bernhard

>
>All that said, this might still be the best tradeoff=2E
>
>thanks
>-- PMM

