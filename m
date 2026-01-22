Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81063CA5FB6
	for <qemu-devel@archiver.kernel.org>; Thu, 22 Jan 2026 12:38:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vitwq-0002Xq-3Z; Thu, 22 Jan 2026 07:38:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vitwo-0002Xf-E0
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 07:38:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vitwl-0003Uo-SO
 for qemu-devel@nongnu.org; Thu, 22 Jan 2026 07:38:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769085477;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BxIR0F5EofnQnxxkpSm3a3a7oXbpa1iqxFgLbPatc1E=;
 b=TxKcnoeDVcEtAN9A85Bse8ZGwrPltyVLRaxUM95C7vdtC3yyjQF69x4Hzj6ol4Bb0Ks+qm
 0Bo60tz3lLJkzg2d5GNWZcJg3eEIQt/GRwtcAAwig4TIObN/nm8q6V1RcsT7N5NTyMwP9H
 8QWW8sRhUzlHGHAmXb3T2HOOLgaMFyc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-540-5ihFcu-OMdiyZAK9XyVczw-1; Thu, 22 Jan 2026 07:37:56 -0500
X-MC-Unique: 5ihFcu-OMdiyZAK9XyVczw-1
X-Mimecast-MFC-AGG-ID: 5ihFcu-OMdiyZAK9XyVczw_1769085475
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4801e3aab32so4623805e9.3
 for <qemu-devel@nongnu.org>; Thu, 22 Jan 2026 04:37:56 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1769085475; cv=none;
 d=google.com; s=arc-20240605;
 b=eJ9QGRotng3yMgOZvBsU5hNtkoZdEMajX3pAh14LkyBsbR/1ajG1ZXITQ0W6GVK48p
 6iqTQppX/T478I8V0kFuXPnNOyzZWyYSoloLrXNwAUYacgpo1oJRSqxeVbo+pjRFap8k
 oD6EEwKI4VkHT44HXIrOTNB0/Ec7sqlLPvxeh33hWdtaDRXuRjGtot4n4rwzueZW4Eg0
 m+n5z5vtbOQsLhqO5cZfWv6Hz/ydNCxfVkgPFelGnqRFQ/6u0eYZzScHKsSLFA8xs7CK
 /mrxyDAFL/2hH+abnI5Ck0kvaCq9xelvGdIo8pXCGxNDVNLZf57Ktt2oOXRmHYD/OOFI
 xCsQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=BxIR0F5EofnQnxxkpSm3a3a7oXbpa1iqxFgLbPatc1E=;
 fh=0RzcIwFimfBkgnFHDXsRN51GKRJBbsoa2EXtpgq3n8k=;
 b=aKp6oB51BKcEVupq5sNvesQNsfIKYNtBjTfyLZyEMTY9DEUMSbKobZGyGPe2N+oPVX
 kKF+OkCnahyQtcCLTTWu86N/QK89vflOSgxFT5EPSUdXMj3a3UHDA/DJgs6LKC667I/M
 SaVE2+xOdy0frpLbHCWr8igt9lESrXUFvvMp07hOgZSPEjFDASAMWmEHU4Nsj+tcXYcf
 PcN3lOyhOEICWoUjXLkgqhdirMZNXwsaqlnH3sh26RFgYEJfrLv0tdrka/RTdPvLibRn
 z6grkPiB45Df8u07vltaP+pVLn4Kci3tMqAM/9w/AYkHMFyocOSwwzZd+XdLqfiLUV3O
 UTsA==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769085475; x=1769690275; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=BxIR0F5EofnQnxxkpSm3a3a7oXbpa1iqxFgLbPatc1E=;
 b=VRZpToeVmfnDMjekD+f0bVUxSmTpGSn1+QcMLn5/i/ebg/Jx3LC5XwZHfqZsKNTTvs
 BybwBYB6mdqbYU7VZDNQFIs0OFiTGvsV4BZI+egDyg34Z+chNzug6l/TW5bZmqGOuFTX
 a0wnxSTgPE/99Sl64HPb2o6yV+8N0Ki0mWkKN4cpMDFsrAQFGL3syYViOZr4f4a0aDBO
 x2dg8a9797qao0ZRHkuvNnwrrr2uV/ZZ3h9BP6US6IPdwwVHbmSZuFHIep8UTOZ7aVVu
 1tCUDqZy7YSfpgT5WYrXoV7KxR/shJQMvjHnwIrSEoXZA2q12CTFo8BmrG0l6pkx8n7p
 tSZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769085475; x=1769690275;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BxIR0F5EofnQnxxkpSm3a3a7oXbpa1iqxFgLbPatc1E=;
 b=SBtkghdtblkYOQt/nmVEHVzb11tkrUxwONBQJ1Jk22NQ5u1w0SdZO0O3hIh/BRfFDU
 iK5qMuhsSYNI5f1N0st2iAL7EWANZ8gOAdOUiQjriOSiKgkC44HgTjja4l+cTaSGWykl
 WUnuZhljBbOSUH+ialumvWXImoJxU7tJadVPDICCb804bBUDRz1tMCyZoe/NS1b1BB4m
 Ir3nKOCBwCp1Fzx4JpAoat4ot4JhkoY0KsSDkJknOZSqDPREtlxWqPZiox/4xBqP2KjZ
 vv3NHvMXCOtDKFinFExctBBO2w4lAt1uEoPXOY2CnshbfZXAhLOBK4DZ2OQQqhNaNgAf
 Lagw==
X-Gm-Message-State: AOJu0YzbFSQGzUn3XEv97Eq7j13WVDYvweM1djTCTL0YYlHX2A2hq8M2
 CZ13MiTSPb8WqjQl3rkrtjVhi7ipkFxA6HD5bLbluF3gr0fvN9rnloPWatNqpa5vAz5GTqR2QN4
 DwK/XRwsLhwWoh5dJm4CBhAC3LYQ6Tt1tWaVKK9VGwzuRgwKeasdxeRtTet2vjY9/zvXGPmFHQw
 ME5OJcWWcKJ1hJ9OlczJzEheHtrFhPOZo=
X-Gm-Gg: AZuq6aLChClVkcnIU8fMfp0397KEers6BYiESU5znIBVw6Xv/+nBvkloOm+KfdRiYf3
 /eSsrg0a1G4a1oameQewRBF2h1AWq8Mbl1/Q8r0PZKx0R55zkI12WLiX/4gSenSp5t6bA3wP45P
 m9SK/nTxJuPSofhvMqMt87WY9Ly7quroJzMCjR0n/9WNwv6/9pPMscG1vz0rPNIp1Fc9acTYfzO
 yAtEVjKDRM8uIC4vTbYVJ4uA7VuHcdJerI4/giaNnV57obA1YcEUGvR
X-Received: by 2002:a05:600c:354a:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-4801e3503c2mr279593295e9.37.1769085474982; 
 Thu, 22 Jan 2026 04:37:54 -0800 (PST)
X-Received: by 2002:a05:600c:354a:b0:479:3a86:dc1f with SMTP id
 5b1f17b1804b1-4801e3503c2mr279593065e9.37.1769085474556; Thu, 22 Jan 2026
 04:37:54 -0800 (PST)
MIME-Version: 1.0
References: <20260114132309.5832-1-farosas@suse.de>
 <20260114132309.5832-3-farosas@suse.de>
 <CAE8KmOx-HbzqDGt12mMxNHcTocq2rWSrksgrns-PdHWCPDJacg@mail.gmail.com>
 <87a4y7kugt.fsf@suse.de>
In-Reply-To: <87a4y7kugt.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 22 Jan 2026 18:07:37 +0530
X-Gm-Features: AZwV_QjeumyjpV9yrSmOakU0MR3YVhdFD3_m-r1AOpMCtLqczPNA0DZ4eTHJ1cA
Message-ID: <CAE8KmOzaP2HTU2b4aBqhFZ1VCv6mRO94-MzQA4Ua0o2F6L8EbA@mail.gmail.com>
Subject: Re: [PATCH 2/5] migration: Use QAPI_CLONE_MEMBERS in
 migrate_params_apply
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, armbru@redhat.com
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.07,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
X-Spam_action: no action
X-BeenThere: qemu-devel@nongnu.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: qemu development <qemu-devel.nongnu.org>
List-Unsubscribe: <https://lists.nongnu.org/mailman/options/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=unsubscribe>
List-Archive: <https://lists.nongnu.org/archive/html/qemu-devel>
List-Post: <mailto:qemu-devel@nongnu.org>
List-Help: <mailto:qemu-devel-request@nongnu.org?subject=help>
List-Subscribe: <https://lists.nongnu.org/mailman/listinfo/qemu-devel>,
 <mailto:qemu-devel-request@nongnu.org?subject=subscribe>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Wed, 21 Jan 2026 at 18:12, Fabiano Rosas <farosas@suse.de> wrote:
> In general, I think that whenever we determine what protects a data
> structure from concurrent access we should make it obvious.
>
> So this assert is here to provide _some_ assurance that this routine is protected.

* Yes, but it is not obvious that we are checking bql_locked() to
protect from concurrent access to the global MigrationState object.
Secondly for concurrent access, other threads should be running.
===
Thread 1 "qemu-system-x86" hit Breakpoint 1, migrate_params_apply
(params=0x7ffcb6627840) at ../migration/options.c:1392
1392    {
(gdb) n
1393        MigrationState *s = migrate_get_current();
(gdb) p bql_locked()
$3 = true
(gdb) p migration_is_running()
$4 = false
(gdb)

Thread 1 "qemu-system-x86" hit Breakpoint 1, migrate_params_apply
(params=0x7ffcb6627840) at ../migration/options.c:1392
1392    {
(gdb) n
1393        MigrationState *s = migrate_get_current();
(gdb) p bql_locked()
$5 = true
(gdb) p migration_is_running()
$6 = false
(gdb)
===
* migrate_params_apply() is called twice:
    1. At the beginning when libvirtd(8) initiates migration
    2. To reset migration options if we kill migration on the
destination side by killing VM or connection.
Both times it is called from the main Thread-1, BQL is locked and
other migration threads are not running.

* If we are trying to futureproof this function so that no one should
be able to call migrate_params_apply() from other threads without bql
- that seems like a long shot. Because it is reachable only from
qmp_migrate_set_parameters(), which is invoked by an external QMP
user. Ie. someone would have to explicitly send
qmp_migrate_set_parameters() command while migration is running, but
even then it'll still be invoked by the main thread-1, with
bql_locked=true. no?

* I'm thinking maybe we can skip assert(bql_locked()) and related
header inclusion.

Thank you.
---
  - Prasad


