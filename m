Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7AC17C369DC
	for <qemu-devel@archiver.kernel.org>; Wed, 30 Apr 2025 10:25:47 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uA4cf-0006yu-NE; Wed, 30 Apr 2025 06:25:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA4ce-0006yZ-BR
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:25:00 -0400
Received: from mail-ej1-x62c.google.com ([2a00:1450:4864:20::62c])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <alex.bennee@linaro.org>)
 id 1uA4cZ-0001Tn-9z
 for qemu-devel@nongnu.org; Wed, 30 Apr 2025 06:25:00 -0400
Received: by mail-ej1-x62c.google.com with SMTP id
 a640c23a62f3a-ac2a81e41e3so1270660166b.1
 for <qemu-devel@nongnu.org>; Wed, 30 Apr 2025 03:24:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1746008692; x=1746613492; darn=nongnu.org;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=70wPDudtxZWd8O7xrrNH7ut+OWcna54L1m8EMzwSQis=;
 b=JMALq2dAJMf4/joG3f9sRcr5sM3Fj39Ukfx6wnh356zI79wbsGcIRgxV/04MgdOfDV
 DoVnwhLjkDsNTGiMoCq8TdkrXM0/Rq9JtTmDJ3KEYlRURENg2f2PJxrpbtr4K9tu7n0n
 7j+JWKzmZupG/6q/6RfkKZAMi8feZzlVI/SwSyXYp7wLq7jRf4GQVZIuc/k/ehuwxjiV
 mZ5HqHav2tv2xae9vSxE7vpyFKJChf1fBeF/LrYtDh6CrfFnLd7LOKhefC9NSPCcjl+W
 tPG1pK05m9N99zrNNNCe+FAB1VV7uolBdLPIn1OvXDQJnUJgJDR46FjWr16xuIbgVUIf
 gwSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1746008692; x=1746613492;
 h=content-transfer-encoding:mime-version:message-id:date:user-agent
 :references:in-reply-to:subject:cc:to:from:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=70wPDudtxZWd8O7xrrNH7ut+OWcna54L1m8EMzwSQis=;
 b=pBE8wUlzrFT8R3ieinq5PwAeJMyjJIV8y/S0a3kgJkRxNm/m3g10L9Lb0vOgXnoaUu
 4bNc5lPOBSfuX76p7bbbgqkNm7BhaojkzdS8yr/2Zs/bSiEpg1G/nh+gzf1C8GkhgVlo
 e9T4S4D/dIn8WrdQno69PduDfu1xOrWqXkX/aGfSG/ta5XfbB44d4ZOeCEhIIPCTb4nb
 Qj0URlzfAryZljLDDOJZzzddn7329T4iCs3trI6Mnl00X/+WtNmxEs2cjujQmdhyeFHz
 +Gblqguclla+0imJqoVh3aAr53zknD3zU9nYrmVH0EHEhIWEuLWAo0iXMfs+tjmKL13K
 2dnw==
X-Gm-Message-State: AOJu0YzvQByzLGxRUhlYM29PUXMEmZLhKEMJ+ASqoFF3RuGybgtf7BP8
 r729dd0C3cE8TMj1hbeYZAg/+9qiiKSVYmzMR4a4PIkXlhiv+Nu1LLdNDWRGT/E=
X-Gm-Gg: ASbGncsa7Xq51szHrse9scAmqvg2g18MXlSyyliHwSBC230UjHRRw2oha9ieQGA6Eap
 y8Z6T7ykghLqZfPe/SxRUxw+ng3bDk9AHZuvYSVpA8KaBR8WkqWgo8pCoL23SNpR1DUrB8N71HD
 OD7rk2YH/Heqa/YR7oEkxOb7wVHWQubhVj8X2VMiAlSIvkFwCoQfI9BV4plY6KAPMEcFAqmKrQ5
 IE7+ChyBA0T0/dL/QB2p4HqSLxBf82r5p125M0KJlSLxcAPixLsTmJtCVageALQjjxSsVL0VpvO
 kzl53a9M5agLmukM156M9q2gfui4L917S87w6bTB8oQ=
X-Google-Smtp-Source: AGHT+IHastBKvkHMkiR/i/G94UgU2K8A33IOarZ7wd67lpmoKobWpYJTqSxWcdJ6ho4VSDqdGUThUg==
X-Received: by 2002:a17:907:3e12:b0:ace:52f6:8500 with SMTP id
 a640c23a62f3a-acedc6f2658mr303631566b.45.1746008692353; 
 Wed, 30 Apr 2025 03:24:52 -0700 (PDT)
Received: from draig.lan ([185.126.160.109]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace733aa401sm868915066b.35.2025.04.30.03.24.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Apr 2025 03:24:51 -0700 (PDT)
Received: from draig (localhost [IPv6:::1])
 by draig.lan (Postfix) with ESMTP id D0B675F8BB;
 Wed, 30 Apr 2025 11:24:50 +0100 (BST)
From: =?utf-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: qemu-devel@nongnu.org,  Akihiko Odaki <akihiko.odaki@daynix.com>,
 Thomas Huth <thuth@redhat.com>,  Alexandre Iooss <erdnaxe@crans.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,  David Hildenbrand <david@redhat.com>,  Pierrick
 Bouvier <pierrick.bouvier@linaro.org>,  qemu-arm@nongnu.org,  Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,  Peter Xu
 <peterx@redhat.com>,  Peter
 Maydell <peter.maydell@linaro.org>,  Mahmoud Mandour
 <ma.mandourr@gmail.com>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  qemu-stable@nongnu.org
Subject: Re: [PATCH 8/9] virtio-gpu: fix hang under TCG when unmapping blob
In-Reply-To: <33ae8cd5-cc5c-4bfd-9c0b-dd71b80dfc0b@collabora.com> (Dmitry
 Osipenko's message of "Wed, 30 Apr 2025 00:26:30 +0300")
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-9-alex.bennee@linaro.org>
 <8b123991-21f2-47b5-851d-6b53fbfaa691@collabora.com>
 <87o6we3bto.fsf@draig.linaro.org>
 <33ae8cd5-cc5c-4bfd-9c0b-dd71b80dfc0b@collabora.com>
User-Agent: mu4e 1.12.9; emacs 30.1
Date: Wed, 30 Apr 2025 11:24:50 +0100
Message-ID: <87ikmm2bgt.fsf@draig.linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2a00:1450:4864:20::62c;
 envelope-from=alex.bennee@linaro.org; helo=mail-ej1-x62c.google.com
X-Spam_score_int: 16
X-Spam_score: 1.6
X-Spam_bar: +
X-Spam_report: (1.6 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_SBL_CSS=3.335,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Dmitry Osipenko <dmitry.osipenko@collabora.com> writes:

> On 4/30/25 00:19, Alex Benn=C3=A9e wrote:
>>> This change makes QEMU to crash.
>> What is your command line to cause the crash?
>
> I applied this patch on top of native context v11, ran AMD nctx and
> got a crash on SDDM startup.

Did you also include the pre-cursor patch which splits MemoryRegion out
of the container struct. The aim here is to allow MemoryRegion counting
to be handled without worrying about other structure lifetimes.

>
> (gdb) bt
> #0  0x00007ffff5411b54 in __pthread_kill_implementation () at /lib64/libc=
.so.6
> #1  0x00007ffff53b8f9e in raise () at /lib64/libc.so.6
> #2  0x00007ffff53a0942 in abort () at /lib64/libc.so.6
> #3  0x00007ffff6cbf18c in g_assertion_message[cold] () at /lib64/libglib-=
2.0.so.0
> #4  0x00007ffff6d2ea07 in g_assertion_message_expr () at /lib64/libglib-2=
.0.so.0
> #5  0x0000555555a42820 in object_finalize (data=3D0x555557c9d290) at ../q=
om/object.c:732
> #6  object_unref (objptr=3D0x555557c9d290) at ../qom/object.c:1231
> #7  0x00005555559f3df3 in memory_region_unref (mr=3D<optimized out>) at .=
./system/memory.c:1854
> #8  0x0000555555a003a7 in phys_section_destroy (mr=3D0x555559ef5b60) at .=
./system/physmem.c:1035
> #9  phys_sections_free (map=3D0x555559c2dd80) at ../system/physmem.c:1048
> #10 address_space_dispatch_free (d=3D0x555559c2dd70) at ../system/physmem=
.c:2692
> #11 0x00005555559f1d33 in flatview_destroy (view=3D0x55555a54a720) at ../=
system/memory.c:295
> #12 0x0000555555c278cf in call_rcu_thread (opaque=3Dopaque@entry=3D0x0) a=
t ../util/rcu.c:301
> #13 0x0000555555c1cc68 in qemu_thread_start (args=3D0x555557993d30) at ..=
/util/qemu-thread-posix.c:541
> #14 0x00007ffff540fba8 in start_thread () at /lib64/libc.so.6
> #15 0x00007ffff5493b8c in __clone3 () at /lib64/libc.so.6

--=20
Alex Benn=C3=A9e
Virtualisation Tech Lead @ Linaro

