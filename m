Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3546C19F32
	for <qemu-devel@archiver.kernel.org>; Wed,  5 Mar 2025 06:45:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tpiVS-0005zU-P2; Wed, 05 Mar 2025 01:45:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tpiVQ-0005yr-GT; Wed, 05 Mar 2025 01:45:24 -0500
Received: from mail-pj1-x102a.google.com ([2607:f8b0:4864:20::102a])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <npiggin@gmail.com>)
 id 1tpiVH-0002qx-1Q; Wed, 05 Mar 2025 01:45:24 -0500
Received: by mail-pj1-x102a.google.com with SMTP id
 98e67ed59e1d1-2febaaf175fso8288868a91.3; 
 Tue, 04 Mar 2025 22:45:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1741157112; x=1741761912; darn=nongnu.org;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNxzV75d6Xdkq9b6SOMn3N6MWQ48/MYIwGTkLwqlFRQ=;
 b=ex2yUw+1X4KmLn5jQE7YfFj68yvCK0OVhc3KrduK5+taL/Ixa2B7q2B070yhkwYEjV
 PkS1+jZZCJIWcnfHji29BInOIKQE2qKLl2QXD7V4UHh46b2GZ++i3WJRlYIHoBl5Lyuc
 sZq3Mfs3uvCZ/QfXAAJehAWor+Erb3/rToCxEHRQfFp87yVh0mnyKb0V5+Su78FddwB8
 dSJ2Wb6h8lA2X9T4sn3b0s4mclyPh6JOrIhb7lJEu9OcMq52/AUjqt5G6NhZoCO05PLH
 OFXOqL5Qt3ERua7DRk7WAmxHojLHzdtY6DmhFPY/9VFPOv8TbGATcpOdgQF/NtvrFrKD
 JtOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1741157112; x=1741761912;
 h=in-reply-to:references:to:from:subject:cc:message-id:date
 :content-transfer-encoding:mime-version:x-gm-message-state:from:to
 :cc:subject:date:message-id:reply-to;
 bh=aNxzV75d6Xdkq9b6SOMn3N6MWQ48/MYIwGTkLwqlFRQ=;
 b=Xu8GBDsoRqD75AWxbA+ywRfTrklKo0u678WbdZqSDTzMHy5QunX37zNC3kwdiRgM/G
 zxzRmEn5pgvSf+2ijc+cR8t3AfRdxJWev3NQw3M28ifqB/fNTaMGxltpNyA6hYGWM7Of
 Uv9jdLyAZ4oVJk8pEuX07IZYUZNY8tXl2YJ7Z37kDH2sSCNJrNxXt6Hmf90jpJP5Qsy6
 0BJvFfWT2nkybzxAXIXDdeXw4esb+U7N0wzsM4CRU/ZQiylMk7fsUIh7RqRtJ+2RAqUd
 VnBjrIeDQzt2YuUIYC2Xc8p75y1B0eb2Xq/EXvHGxqNto3c6sk4ASAmWk81p+viqbEMo
 60ig==
X-Forwarded-Encrypted: i=1;
 AJvYcCUu5AwiA8B3ZO6ZYRFRZyts0wglrjBZO6w2Rec87bjjHmViOmWohRd8IxuiALDQSbunWczaw1FJuMHV@nongnu.org
X-Gm-Message-State: AOJu0YxZny3IrsqWCHcrE/rrifnTDb4HX0+DYabiRoVa7Q99+JaWn3wx
 Qg7TwkEJC3BhRJFHowHlPnr4lP6LLhD/S/I01yPU8c8nw8abM1Et4wIPfAXc
X-Gm-Gg: ASbGnct7V9T7AwlM1BGGz+1ZXCP2t9Idr4quyOI5tdk44mNtdPR4coeo1aNodu/N1o5
 jEnoSDxYmqoeThFeLDaJQbYpl9hMULXX0CND6l4rcJwchGNl1YBeLh0MnxXrEtdops+P4UWbkjx
 LgrF8n6SnOjVxJs6c0Z9yhQqS+YTdbZXV1aXjrHHOv2AVg0kajbPXL+ZkrywbGh8KMmeOkf0taB
 tVwPW7PVxyddjRL6jmaJF1Lrmn5XOBfCuv+eAKxUQjH9qJ9I+opxrtZHJW1c0MkBKvdHBUzNEz2
 9NmKFdcgRwBOHeyj9/xpaMseATB4TUOVhqk=
X-Google-Smtp-Source: AGHT+IERSfWfkMy+FV4Ev1iYVXINH9bpsSYq4a2jSOJekbKZSY4ObQ3rvlnBcLzM3xZbJ+CG68zUOg==
X-Received: by 2002:a05:6a21:7016:b0:1f3:3916:8722 with SMTP id
 adf61e73a8af0-1f34959498fmr3992632637.27.1741157112440; 
 Tue, 04 Mar 2025 22:45:12 -0800 (PST)
Received: from localhost ([1.146.6.174]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-73628edceffsm9340827b3a.2.2025.03.04.22.45.09
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 04 Mar 2025 22:45:11 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 05 Mar 2025 16:45:06 +1000
Message-Id: <D884OKIYGHJ4.2NBBKSTCAE7NX@gmail.com>
Cc: <qemu-ppc@nongnu.org>, <qemu-devel@nongnu.org>
Subject: Re: [RFC PATCH] target/ppc: Do not set HPTE R/C bits on
 !guest_visible xlate
From: "Nicholas Piggin" <npiggin@gmail.com>
To: "BALATON Zoltan" <balaton@eik.bme.hu>
X-Mailer: aerc 0.19.0
References: <20250303104755.584897-1-npiggin@gmail.com>
 <caad84f0-d3dc-dd89-14d0-498a9246772b@eik.bme.hu>
In-Reply-To: <caad84f0-d3dc-dd89-14d0-498a9246772b@eik.bme.hu>
Received-SPF: pass client-ip=2607:f8b0:4864:20::102a;
 envelope-from=npiggin@gmail.com; helo=mail-pj1-x102a.google.com
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

On Mon Mar 3, 2025 at 8:58 PM AEST, BALATON Zoltan wrote:
> On Mon, 3 Mar 2025, Nicholas Piggin wrote:
>> Perform !guest_visible memory accesses without modifying R/C bits.
>>
>> It's arguable whether !guest_visible memory accesses should modify
>> R/C bits. i386 seems to set accessed/dirty bit updates for "probe"
>> accesses, but ppc with radix MMU does not. Follow the ppc/radix
>> lead and perform the accesses without updating R/C bits.
>>
>> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
>> ---
>> target/ppc/mmu-hash32.c | 27 ++++++++++++++-------------
>> target/ppc/mmu-hash64.c | 27 ++++++++++++++-------------
>> 2 files changed, 28 insertions(+), 26 deletions(-)
>>
>> diff --git a/target/ppc/mmu-hash32.c b/target/ppc/mmu-hash32.c
>> index 1f791a7f2f7..b8d7f87507b 100644
>> --- a/target/ppc/mmu-hash32.c
>> +++ b/target/ppc/mmu-hash32.c
>> @@ -410,19 +410,20 @@ bool ppc_hash32_xlate(PowerPCCPU *cpu, vaddr eaddr=
, MMUAccessType access_type,
>>     qemu_log_mask(CPU_LOG_MMU, "PTE access granted !\n");
>>
>>     /* 8. Update PTE referenced and changed bits if necessary */
>> -
>> -    if (!(pte.pte1 & HPTE32_R_R)) {
>> -        ppc_hash32_set_r(cpu, pte_offset, pte.pte1);
>> -    }
>> -    if (!(pte.pte1 & HPTE32_R_C)) {
>> -        if (access_type =3D=3D MMU_DATA_STORE) {
>> -            ppc_hash32_set_c(cpu, pte_offset, pte.pte1);
>> -        } else {
>> -            /*
>> -             * Treat the page as read-only for now, so that a later wri=
te
>> -             * will pass through this function again to set the C bit
>> -             */
>> -            prot &=3D ~PAGE_WRITE;
>> +    if (guest_visible) {
>
> Are these unlikely() ? Not sure if that makes a difference but if we know=
=20
> it may help some compilers.

Yes it probably is. Although we don't tend to use unlikely very much. I
guess we have to start somewhere.

Thanks,
Nick

