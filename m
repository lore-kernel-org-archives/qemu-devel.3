Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF88DE77188
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 16:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWIIN-0007pq-NV; Fri, 10 Jan 2025 11:55:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWIIL-0007pc-KP
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:55:37 -0500
Received: from mail-ej1-x62a.google.com ([2a00:1450:4864:20::62a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1tWIIJ-00038Z-3e
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 11:55:36 -0500
Received: by mail-ej1-x62a.google.com with SMTP id
 a640c23a62f3a-ab2bb0822a4so460168166b.3
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 08:55:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736528133; x=1737132933; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yzzEZTgfduG/CeAvlW5mBOtPqbO5BPsp7pfI5wi7b+Y=;
 b=p2JJrps7D8wEI/IPvjti1P2cNZuREpKbQA8OGNVJpDxHhfDZ8QE7H+deg4dkZIjxhd
 vHXaQENbVUqMy4naU9pYv903gasdzYI0+f0zmZKwnQsPOkuy9/4umnCBXOJDBxf/VUOX
 YV/+ThNfKqz1rqGeSUOlPJ7sZMtUwUpw0DyYNvoaG4NhYY8pgX5S4uuaFYckELLiuGdu
 h0Y9ToP5yxJ0L32Ge5rLina2wjH5UxiQBLHpzeBDHx3yQMuZHTZsey0MKcSujAFbnKj/
 xxL8KdkDkN50c0DqamK7BUWB1ZsScmQWR4NCzXY3k5UzKr3tEMjrGqhYDqoCZy3yYYnk
 HTFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736528133; x=1737132933;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yzzEZTgfduG/CeAvlW5mBOtPqbO5BPsp7pfI5wi7b+Y=;
 b=QqLPxcL8h4zHkNqledV+gCaLJQXZdGit/cFfWuXW1ZUg4Ra5X9lMEd4kCDVzCvQcld
 KXsobJKe8p74gsIfWL6uFX4e7NtGqnUUa4iCOB8fhoZboEzR9SAY+MnvWgHkDBUulDK8
 f8KNoPVWlZ+Ya4r/GtKCm1PAflN/YFFeqcwPApUYWbk/ARyxhJxKu2q8EIrPx0DegGCX
 oD72o0EDeKn8kqRRrJc4QFJfpPKZcTk0Yaedvv/tQqs4RCtAgBaFw8cyl4EslZu59b7F
 m50igGbZ2gf7KXPei6YAy54rfV3uCP6RS/O03k8v5/Sk8N+0CNHZ4e2zJLdCc/BDd9xw
 n/8Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXDtOlAlvzPWsBnLrD4fE0iwYNF0qEaC5lp5uHD1PuvGsd8DBhMKPSNy1crOANwaccAUcwzbzQFowa0@nongnu.org
X-Gm-Message-State: AOJu0YyvpVJIvPgkzZ4L8uzwFGth3BleRTONAGncPrTCdVmOUaeOMSzB
 dWmOLdqPnfcGl0nlA0AmwVRRjZxyvQ5GnmBNpd64aeRazucOHlNH73P34f23FDY=
X-Gm-Gg: ASbGncsAeCM0cWrv/jNlY11UJixkmKPCn8AKYFfZHB6cr5YL37Co9z5NOyyLN9FeqIK
 A4T6hbSBB0GXReDgYBocErjx15i6bSvWjHp1RM8mRkgl6qHLhmOXncgiSGIyamYXcePvXtWxXtB
 5sTScTwD2DYdDnBhPhhZ1atBs3Y+NqFDLfSS1fHcokB90FYzT9uLnOEC3sZ4cCta/6QBT30nhkX
 nU2TGs3KgtfXTrS3a0Ewiw7edGccnIYqZBRes4Uf1drm3Roum5RARI=
X-Google-Smtp-Source: AGHT+IHFNDixPvgE4PSOkilMHFB18QoIg6QBcUEcjBlifDX6eO1BVw+Ku58or/HVVFrm3TSkEEJbiA==
X-Received: by 2002:a17:906:1196:b0:ab2:eb1a:9471 with SMTP id
 a640c23a62f3a-ab2eb1a9d1cmr155792466b.48.1736528133096; 
 Fri, 10 Jan 2025 08:55:33 -0800 (PST)
Received: from draig.lan ([85.9.250.243]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ab2c95b09b2sm184706966b.146.2025.01.10.08.55.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Jan 2025 08:55:32 -0800 (PST)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id 80D445F8C8;
 Fri, 10 Jan 2025 16:55:31 +0000 (GMT)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: David Hildenbrand <david@redhat.com>,  Stefan Zabka <git@zabka.it>,
 qemu-devel@nongnu.org,  Paolo Bonzini <pbonzini@redhat.com>,  Peter Xu
 <peterx@redhat.com>,  Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>,  Richard Henderson <richard.henderson@linaro.org>
Subject: Re: [PATCH v2] physmem: allow cpu_memory_rw_debug to write to MMIO
 devices
In-Reply-To: <CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com>
 (Peter Maydell's message of "Fri, 10 Jan 2025 15:44:51 +0000")
References: <20241220195923.314208-1-git@zabka.it>
 <a9313931-a41e-46e1-b8b9-d2cc83cd663c@redhat.com>
 <44f99f89-edb6-4007-a367-f7f3b9e10b7b@zabka.it>
 <b36f85c4-4f1b-4721-bab5-56e89550f421@redhat.com>
 <f1d67bea-7389-40c3-a304-6cec459a2f49@zabka.it>
 <4aa676ea-331f-4c8b-be1d-208804ede674@redhat.com>
 <CAFEAcA_2CEJKFyjvbwmpt=on=GgMVamQ5hiiVt+zUr6AY3X=Xg@mail.gmail.com>
User-Agent: mu4e 1.12.8; emacs 29.4
Date: Fri, 10 Jan 2025 16:55:31 +0000
Message-ID: <871pxa4ni4.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62a;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62a.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 8 Jan 2025 at 20:10, David Hildenbrand <david@redhat.com> wrote:
>>
>> On 08.01.25 19:35, Stefan Zabka wrote:
>> > On 21/12/2024 15:55, David Hildenbrand wrote:
>> >   > Let's wait for opinions from others first.
>> >
>> > <https://www.qemu.org/docs/master/devel/submitting-a-patch.html#if-you=
r-patch-seems-to-have-been-ignored>
>> > states that two weeks is a reasonable amount of time for follow-up.
>> >
>> > Should I also ping the original patch? I thought pinging the thread
>> > would be more appropriate, as it contains relevant information.
>> >
>>
>> I just pushed a compiling version of the attrs.debug approach to:
>>
>>         https://github.com/davidhildenbrand/qemu/tree/debug_access
>
> I think this approach (having a 'debug' attribute in the MemTxAttrs
> seems reasonable. I do note that if we allow this kind of access
> to write to MMIO devices then we are also permitting ELF (and other)
> image loads to write to MMIO devices where currently we ignore those.
> That means there's probably a class of guest images (of dubious
> correctness) which will start writing junk (likely zeroes) into
> device model registers; we previously would silently ignore any
> such bogus ELF sections.
>
> Q: should we suggest behaviour for device models if they see a
> 'debug =3D 1' transaction, e.g. "don't update your internal state
> for a debug read if you have clear-on-read or similar kinds of
> register fields" ?

What do we do for device models that want to know which CPU things are
coming from, as per:

  https://gitlab.com/qemu-project/qemu/-/issues/124

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

