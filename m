Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 478E2D11180
	for <qemu-devel@archiver.kernel.org>; Wed, 26 Nov 2025 15:51:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vOHmw-0001LJ-5y; Wed, 26 Nov 2025 10:50:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOHmE-0008I4-Sv
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:49:56 -0500
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <pzmarzly0@gmail.com>)
 id 1vOHmC-0000fg-Dv
 for qemu-devel@nongnu.org; Wed, 26 Nov 2025 10:49:53 -0500
Received: by mail-pf1-x433.google.com with SMTP id
 d2e1a72fcca58-7ba55660769so6012247b3a.1
 for <qemu-devel@nongnu.org>; Wed, 26 Nov 2025 07:49:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1764172189; x=1764776989; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=WvPSGbtjkcFZ6Koak1PHrMD5nwRVvo0JZAwBau8zGS8=;
 b=LSbAatf40pZQlNph2XXukNhakIZvDodpYDo/+8QbwFuLcVWZuc3Jn6ChFEOu0Lgdsz
 bmC0FcCtyQRu4dDovQXj2n8IaYOsCVI2snJHJTQXePY0ZwDv7qt8g6dF4+u1flrGHhpR
 Cv6+MEOO9F1xHboziOhi4LyLUWbdpxqYXu7x+wNICk/zMOeuo2fKgpfCHjAyFqYzmiDK
 nPLwnuCopXAVTBhASIRdm9FSCXRMgq2In90gpPjm2OvfW1BKmZM7VJYJz5qZ9dzdmEY3
 rco4Uz2Ju6CZqUOv1Tth9LpBn/c8afbEODrc9K+9XH1RTM8fEs4JqEkNUPLdtAiXbn5b
 2spg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1764172189; x=1764776989;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=WvPSGbtjkcFZ6Koak1PHrMD5nwRVvo0JZAwBau8zGS8=;
 b=KZjeBYLMHu+WPM5N+loWiPUYafsFlTILo+GzruxjQejt3myqJZfmBVrPgyL8janXvO
 mmaHaKcFmLdgfUgqtNcZ7jQFW18C+4MvMQxLDzQJR+UZH1YQB1MpYY3D5+YID5jLW9gE
 G2OSIhbvSx/f5suRJzvmJ4XLAfp6qBflgKoEVfOmTXTGZXdRcSYDmBPCxZ3oBoEWzvlH
 Nsi/EKiXDbcE705/7ICyEwvT0kB1b4xB4/dewAgRwe+OY2a1bfkDg7r/G+mlPqFF7XQJ
 tRCNKSnCUGZWE2MeAEc8I7epU/UcmU5a44tjmHP7WWQE8dYMzBj3rrlOkLHvowrIadHe
 PxLg==
X-Forwarded-Encrypted: i=1;
 AJvYcCUSd+gNsWVj2fQE7tQfDu5yyHIvTFskWc3FES7p9V0Kgv5gHrGASqgtDl8Xoc9nhnRe30lWU4hywFhf@nongnu.org
X-Gm-Message-State: AOJu0Yxh76AFdKta8C2XZKlBaeF3j9XKq9I1JBWwF8FqeYcIWySBSRF4
 ruffP2sZZCB5zPWVyiGoubQSFpwuTXMzq9DkF65mdWkDz0GuIfBYzouPu5dCCJTLPNeS3a65+rm
 YA6GJ5ZXvl0WH2vCTxO8cAKHGWYuP9ql4RsGQ8wHeDQ==
X-Gm-Gg: ASbGncs1GwtbuorWTNjvF/H1sYU0PuvJj9wWjFmC2x5VgU0YZ4Uvqk/jdoOBoGSmjbO
 sbqMMJQP0bI1wGc2do1mflsU3Pkyi5xF/0DtZf8C4fyq4Iy9bx9KRnr/YkzCjFUuLRAgbYIWvzb
 KQ2Lm9ywfzZBICiMiAHlAfl4sJxXK0zwK57qTNi06ZXOQVSE3Qj7nTbRb6n93/k9qb6a7jyYW53
 je1iqueSBRNfn3Ox4GBYtgl8XF2jOHLhe3nGpx2n8WxGPjqGTD+oTJVXFH2kBbBTljPgyQ=
X-Google-Smtp-Source: AGHT+IF10s44T2dlUYXIcnnWoLVksPO3sdRD4Sj1doNXtij1jEpspuwhPwxjVUX01rASi5AXcJRyMAbQzapTIkkLJfw=
X-Received: by 2002:a05:7022:62a2:b0:11b:d4a8:d244 with SMTP id
 a92af1059eb24-11c9d811fa0mr14090737c88.16.1764172189267; Wed, 26 Nov 2025
 07:49:49 -0800 (PST)
MIME-Version: 1.0
References: <20251125174649.257457-1-pzmarzly0@gmail.com>
 <aSYE_rdMhH36KBxf@x1.local>
 <87tsyheqpv.fsf@suse.de> <aSYt4MUUESAcThrr@x1.local> <87o6opdksw.fsf@suse.de>
In-Reply-To: <87o6opdksw.fsf@suse.de>
From: =?UTF-8?B?UGF3ZcWCIFptYXJ6xYJ5?= <pzmarzly0@gmail.com>
Date: Wed, 26 Nov 2025 15:49:36 +0000
X-Gm-Features: AWmQ_bls71e8OqTe82xg3Eu3zE8_8D_tBrcW_5d-yJiCK7XERuQuzSbNwJSYWoI
Message-ID: <CAEZNvsuC3f_hsDHPTnp3hOeGsQPsG6MeVP_XWUTMpzYD-1sp6g@mail.gmail.com>
Subject: Re: [PATCH] migration: fix parsing snapshots with x-ignore-shared flag
To: Fabiano Rosas <farosas@suse.de>
Cc: Peter Xu <peterx@redhat.com>, qemu-devel@nongnu.org, michel@michel-slm.name
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=2607:f8b0:4864:20::433;
 envelope-from=pzmarzly0@gmail.com; helo=mail-pf1-x433.google.com
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

On Wed, 26 Nov 2025 at 12:45, Fabiano Rosas <farosas@suse.de> wrote:
>
> Should ram_save_setup() use RAMBLOCK_FOREACH_NOT_IGNORED instead of
> RAMBLOCK_FOREACH_MIGRATABLE? I don't immediately see why not...

I just submitted a new patch "migration: Fix writing mapped_ram +
ignore_shared snapshots" to skip ignored RAMBlocks. I think it may
still be useful to indicate their presence and record their sizes, so
I only skipped writing the contents, keeping the header. LMK what you
think.

