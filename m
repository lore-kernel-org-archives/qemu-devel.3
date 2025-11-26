Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7143D1039D
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 12:35:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOEjb-0004YU-9G; Wed, 26 Nov 2025 07:34:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOEja-0004Xy-4E
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:34:58 -0500
Received: from mail-pf1-x42f.google.com ([2607:f8b0:4864:20::42f])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOEjY-0001y1-HQ
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 07:34:57 -0500
Received: by mail-pf1-x42f.google.com with SMTP id
 d2e1a72fcca58-7bb710d1d1dso10125621b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 04:34:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764160495; x=1764765295; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=2OslEuSLHm8TR5n6qgPi3UkDFWebVf7JQYbC8JEywVM=;
 b=a6w9e9BCVEy5IJWKScN6PjzdrSJcPiad7+OiRl58ZSB+mF0MhD5h8qbizG57iKReI5
 EKg5TdMrxWTcAw15KCuJNHCGnf7TAnTXuDIUl2utn19RAlWJeXXXOrOgw6FfDIyZwT0b
 192qZwAmYk7Ey7mS4R9PxpcCWzny8aPwZj6ab9yBwV7tA4GHWR98vmhXr5jvKdvGt1pV
 6ZKFuC5AQRCUgiIFrNeyR5OOBZ2ktlUfcfORw5eqShD8Ye2pkkccReaRUNm8vtDbQ9Ob
 SZJcaf5ehyhNI7LYkVmdfb8ofKTuoFLgqcvwlQiRWIlzAnZaqhU67hR4XhcNxtHKwBS0
 T2IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764160495; x=1764765295;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2OslEuSLHm8TR5n6qgPi3UkDFWebVf7JQYbC8JEywVM=;
 b=FlLTAr8PG4GqJ6AXJNsRrebCedjb2RKwohohMxel6sjLC/4crpaaLjYJW9VTk1r5d8
 q+y9o0YfNZT1DDvh38/rfZJi2eexteB4D/XpvU9KCt2fIcBPWI0Icc0Aq3nkq77vgVIk
 z9E1+UgS7u2oZgaWP6ampjmQZZcLo/gQ1KCHKPm5HZHH93VmU17mE0DVfInFDQg302Zl
 fdN8iEZ80RoCsw3Vo06EJ3TY45Jzd27GXi02LBkghkWr0W/6Ojoo++2ECr0I2d9wfqaA
 IQJ5+Y2T1fDRjt7BcYKUr5VtcKKcz9FhN6gqajy4/8H9fHb7a/ile+yoJs6oLIFkAuuA
 nL3Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCXVJFNTm7ICUuEPd60JmOohU1+3CM23Ylpm9d7GQYG/bNpHAu4z83WxKXvyRJ5olL0HdKbbHbPsy6KO@nongnu.org
X-Gm-Message-State: AOJu0YxKhDP8zfTRWMo/fvD09sS5++pQW8nAeDlr//vj+E7P69T5c0VY
 S1cGIs4QvJpOm8ENdaVjcqMlCwDTrd1C7i5f6mYGtuEZuF7mMxLtUjAZ6L+y+X1/Z7unYWexY5h
 kh96T8NgctJfr+Vz1+gHwPJD612gLBkE=
X-Gm-Gg: ASbGncsKrV+K8+kv4uG7sDb/bmkuhZlYRJW1ulOrv+b7me/67G5HinXg5rxlaJbeR3M
 WmxTYPfwr/v8KJmgYaA0yrtPn7d3zE/bMmoTmwPnXwynuwA9TSGfI0r3slgbAssdoJIsOS1JKT+
 cbX/1p8cjub1WWiH6XmLkT84owmCUrcui/e7AjQzBqdAfo8ga5EbxiDNtJVgbuNK8u7GIB9Wl3T
 gpAgsU0uYdMASjAkfnpWgwpVFKikQMsNdpNdIOxo8lUDzIcptFO1YyOHiQrZslGGQReH7FiPRF2
 YpjsoQ==
X-Google-Smtp-Source: AGHT+IFv3bkCMXz51iSc1oNG1lS0gYbIR8PXyaLRSu4jr7VXehu4NXxSpumMkTAL7lQ9VqfoRr66IWSiwOzssugkuoE=
X-Received: by 2002:a05:7022:ec89:b0:11b:af12:b9f5 with SMTP id
 a92af1059eb24-11cb3ec36a4mr4340219c88.5.1764160494967; Wed, 26 Nov 2025
 04:34:54 -0800 (PST)
MIME-Version: 1.0
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
 <aSYE_rdMhH36KBxf@x1.local>
 <87tsyheqpv.fsf@suse.de> <aSYt4MUUESAcThrr@x1.local>
In-Reply-To: <aSYt4MUUESAcThrr@x1.local>
From: =?UTF-8?B?UGF3ZcWCIFptYXJ6xYJ5?= <pzmarzly0@gmail.com>
Date: Wed, 26 Nov 2025 12:34:43 +0000
X-Gm-Features: AWmQ_bnqxgnPBRlK-bQakD4YM4F4PJFR0BkMkQA4_TTUL7zMI0_atxQOJpTHHsc
Message-ID: <CAEZNvss0C0KaqgEJx3-_6XwagXGNe3S1QwTpKrMxg8irjRn9ig@mail.gmail.com>
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
To: Peter Xu <peterx@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 michel@michel-slm.name
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::42f;
 envelope-from=pzmarzly0@gmail.com; helo=mail-pf1-x42f.google.com
X-Spam_score_int: -17
X-Spam_score: -1.8
X-Spam_bar: -
X-Spam_report: (-1.8 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 FREEMAIL_ENVFROM_END_DIGIT=0.25, FREEMAIL_FROM=0.001,
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

On Tue, 25 Nov 2025 at 22:29, Peter Xu <peterx@redhat.com> wrote:
> On Tue, Nov 25, 2025 at 06:40:12PM -0300, Fabiano Rosas wrote:
> > Peter Xu <peterx@redhat.com> writes:
> >
> > > Thanks for the patch, though the u64 was parsed in parse_ramblock()
> > > instead.  Would you consider refactoring that function instead?

Refactored in V2.

> (1) When mapped-ram is enabled, do we actually need to setup those
>     ramblocks in mapped_ram_setup_ramblock()?
>
>     That is, when a ramblock returns migrate_ram_is_ignored()==true, IIUC
>     we don't need to allocate bitmap or page chunks for it?
>
>     We likely don't need to change this easily, because this will change
>     file format.. I'm also not sure if this is a major issue, logically
>     when ignore-shared is used we normally shouldn't need mapped-ram.. vice
>     versa.  So I may need to better understand the use case first on
>     enabling the two..

Re "when ignore-shared is used we normally shouldn't need mapped-ram" : since
memory-backend-file + numa only affect pc.ram and the rest of RAMBlocks are
serialized as usual, I can imagine someone may want to use mapped-ram format
for these remaining RAMBlocks for minor gains. This is hypothetical though, as
currently the memory-backend-file + numa + mapped-ram + ignore-shared
combination
causes QEMU to fail to write migration to disk:

    $ build/qemu-system-x86_64 \
        -m 1024 \
        -nographic \
        -object
memory-backend-file,id=ram0,size=1G,mem-path=/home/pzmarzly/repos/qemu-data/mem.img,align=1M,share=on
\
        -numa node,memdev=ram0
    (qemu) migrate_set_capability x-ignore-shared on
    (qemu) migrate_set_capability mapped-ram on
    (qemu) migrate -d file:/home/pzmarzly/repos/qemu-data/vm-shared.state
    (qemu) qemu-system-x86_64: Failed to write bitmap to file: Unable
to write to file: Bad address

Seems like another bug, I'll give it a shot.

> (2) Is the check proper on validating mr->addr didn't change?
>
>     This is a question on the check itself when ignore-shared enabled,
>     with/without mapped-ram enabled.  That is, I question whether this
>     check is useful or valid at all:
>
>     if (migrate_ignore_shared()) {
>         hwaddr addr = qemu_get_be64(f);
>         if (migrate_ram_is_ignored(block) &&
>             block->mr->addr != addr) {
>             error_report("Mismatched GPAs for block %s "
>                          "%" PRId64 "!= %" PRId64, block->idstr,
>                          (uint64_t)addr, (uint64_t)block->mr->addr);
>             return -EINVAL;
>         }
>     }
>
>     In the error, it said "GPA", but mr->addr isn't GPA.. it's the offset
>     of the MR within the MR's parent container MR..  So if the parent is
>     the root MR / system_memory, then it is the GPA, however I don't see it
>     guaranteed..

I only understand some of these words, having only started to dig into
QEMU codebase.
Feel free to change/remove this check as you wish.

