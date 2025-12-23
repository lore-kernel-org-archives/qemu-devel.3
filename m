Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D00DE6B272
	for <qemu-devel@archiver.kernel.org>; Tue, 23 Dec 2025 11:19:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vY0PH-0003bX-EE; Tue, 23 Dec 2025 06:18:23 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vY0PB-0003a2-6B
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 06:18:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vY0P9-0002lO-C4
 for qemu-devel@nongnu.org; Tue, 23 Dec 2025 06:18:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1766488693;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1JYnpgPBaJRiVeyTd2Kg/nue1JcmuXDwX31okD4swp4=;
 b=e9+gCFG4/mmHppStN9lOpNbZ06dPTFQ0GWxTdxFv+XV977p/5JPSYDeu0J0bpmu0Z5XbOJ
 xe9bkioZ8DyllV93fYnriO1Huo8eA3ya0XYv6eytKwgHexS396g4Cq6c4fNFhTaNc1dZHc
 KMR5iozDMndvdPefs9Mpc6jkWNk8S2U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-90-vQhQ2WN0Njy_maTgELTByA-1; Tue, 23 Dec 2025 06:18:12 -0500
X-MC-Unique: vQhQ2WN0Njy_maTgELTByA-1
X-Mimecast-MFC-AGG-ID: vQhQ2WN0Njy_maTgELTByA_1766488691
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4779b3749a8so35490455e9.1
 for <qemu-devel@nongnu.org>; Tue, 23 Dec 2025 03:18:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1766488691; x=1767093491; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=1JYnpgPBaJRiVeyTd2Kg/nue1JcmuXDwX31okD4swp4=;
 b=T8ehqjc1ZsIE62BReW3x/K1KIeF0UtyzmPYOkI5YYPTTtN/xLUDLWa3GgbEf/AcaHv
 JBg2b8mutUFiZ4ddQ0Lu6ejBieZZV1lzG6bRcST2n15gp7rMm8BsKyuiL2/mDUeBRzXu
 34yrwLGW57t4L/qIAAUtAimr0Zt3Yy2frkOw7ItKrCr7JAzV7OWE5dLXZLAqkUZHu0Ep
 L1HRgB8IW9rFrcI0p8OwRlm/ZDYsYKLq/1HI/yhq2L24ehzKbGxS8aAV3+1bIpnvuQh0
 q2MfJuFLRregmYfeCUtHFkzDAZmNHARfItNpWoJrYgoRd6YWZyRBJD3DVTnteB6lYIsR
 6gVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1766488691; x=1767093491;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=1JYnpgPBaJRiVeyTd2Kg/nue1JcmuXDwX31okD4swp4=;
 b=AjNIpxfHd9YGgMgbg65ynz1tfl9UW3GOaJx0ZpUs7WWO5GBBxj4ZzRXLWxYoH9qLqz
 nAep2bHlyoxa3rNliQD9JAqGlS15y7daRuZQ5xi+UEZW1wGjyJcLj9QRDlPylSEvtoUc
 iJxVzTP3mDeQxsH/0oux2x8xWBSe7ttq1ELQBhvy94+6ay41Oq3xLp1R0dhfpL9CM3X1
 vdUZ00dToKPEazYdlXU6nDLKg2O/ZeCMCo1S4K3s2v+fay3R0Ld9aXctvyggKjtFPQsv
 dae3Jk5fj7Fe3KBAsVxhax6Xoh7neE931yNzXRLmb9oxyOMEFM/saN9vTR7MFRBB5oBD
 xYjw==
X-Gm-Message-State: AOJu0Yy6ATlUE8sOMHQHEvQA9T2lZWlqLh2RtFQp4bFKkJe7gLyk2CNb
 /jQbIcpop3p7sD6h6vrp1C7lBKrmQpEy9LHSaDNzJBeYu83wPMuPrCq4q4Xh/nOZwelzeRswUrj
 3uvHnYsgMh4RwG+4cEZIXrP9V1x+CsvCWHKcmOGHepkU39+jK18gVIFuOngHLPmV2YPuYyd4OAM
 RrlUuo9Do4t0ROc5UY4/YLEaDTNb8kXmo=
X-Gm-Gg: AY/fxX58Bc0I8un0TCZTzWQBjXgg1uvPrT5Zj+qRObt4xDctXaB+WKSGVw+pTq/saJP
 4h/Tllat+n454X6fE2HaVDR8572RtpGMUJHMqMvgLGYiclFkoIuV1pn4bnRxQ4vTNcLRpYPDDAN
 qmUrATp31sK9YiSUXCvJuZ8NF8MhtRYvWIJOFR/bQC2OOjDC46cS1vz8mnSa38ZKI3mcWI
X-Received: by 2002:a05:600c:4e0d:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d195495d4mr138877225e9.9.1766488690915; 
 Tue, 23 Dec 2025 03:18:10 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF9TY5uWP/Cc6PbXavmdUqCI+9VY4mxSGHM4Znu24xSKWrpg38pix5ypVok8aBLtXH1uIy5bTOnBoXiJJBsBxo=
X-Received: by 2002:a05:600c:4e0d:b0:47b:df60:8a14 with SMTP id
 5b1f17b1804b1-47d195495d4mr138877005e9.9.1766488690503; Tue, 23 Dec 2025
 03:18:10 -0800 (PST)
MIME-Version: 1.0
References: <20251222114822.327623-1-ppandit@redhat.com>
 <87h5tilhcq.fsf@suse.de>
In-Reply-To: <87h5tilhcq.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 23 Dec 2025 16:47:53 +0530
X-Gm-Features: AQt7F2oXqKEpNPkYMtIeTneUV1asezl-1-VkXLMehy92l6KhPukZZbm-HvnG2Ec
Message-ID: <CAE8KmOweak15R4Ji6F50b_za67q=un_GDSEMGCRTYeQKod7zQA@mail.gmail.com>
Subject: Re: [PATCH] migration: introduce MIGRATION_STATUS_FAILING
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>, 
 Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
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

Hello Fabiano,

* Thanks so much for the quick comments.

On Mon, 22 Dec 2025 at 20:00, Fabiano Rosas <farosas@suse.de> wrote:
> This doesn't look like it's caused by set-capabilities. Seems like:
> Please clarify, there might be some other bug lurking around, such as a
> locking issue with qemu_file_lock or even the BQL.
>
> Also, if possible provide an upstream backtrace, or at least mention the
> code path based on upstream code. It's ok to keep the downstream
> backtrace, but point that out in the commit message.

* Right, migrate_fd_cleanup was renamed to migration_cleanup() in
    -> https://gitlab.com/qemu-project/qemu/-/commit/4bbadfc55e6ec608df75911b4360e6e995daa28c
===
libvirtd(8) 19:03:07.260+0000: 396587: error :
qemuMigrationJobCheckStatus:2056 : operation failed: job 'migration
out' failed: Unable to write to socket: Connection reset by peer
libvirtd(8) 19:03:07.261+0000: 396587: info : qemuMonitorSend:836 :
QEMU_MONITOR_SEND_MSG: mon=0xffffa000e010
msg={"execute":"migrate-set-capabilities","arguments":


qemu-system-aarch64:initiating migration
qemu-system-aarch64: migrate_fd_cleanup: to_dst_file: 1: 0xaaaaccce0110
qemu-system-aarch64: migrate_fd_cleanup: before multifd_send_shutdown:
0   <== multifd disabled
qemu-system-aarch64: migrate_fd_cleanup: to_dst_file: 2: (nil)
qemu-system-aarch64: Unable to write to socket: Connection reset by peer
qemu-system-aarch64: ../util/yank.c:107: yank_unregister_instance:
Assertion `QLIST_EMPTY(&entry->yankfns)' failed.
qemu-system-aarch64:shutting down, reason=crashed
===
* As seen above, when connection is reset
     1) libvirtd(8) sends the migrate-set-capabilities command to QEMU
to reset the migration options to false(0). This leads to resetting of
s->capabilities[MIGRATION_CAPABILITY_MULTIFD]  to false.
     2) When migration_cleanup (earlier migrate_fd_cleanup) is called
after above reset
          migration_cleanup
           -> multifd_send_shutdown
            -> if (!migrate_multifd()) {
                     return;   <== returns because _CAPABILITY_MULTIFD
is reset to false(0).
                }
         when _CAPABILITY_MULTIFD is reset to false,
multifd_send_shutdown() returns without really doing its multifd
cleanup, ie. multifd objects still stay alive, are not freed.

* And that leads to the said assert(3) failure in
     migration_cleanup()
     {
         ...
         multifd_send_shutdown()  <== does not cleanup
         ...
         yank_unregister_instance(MIGRATION_YANK_INSTANCE);   <==
assert(3) failure
     }

> I'm fine with the general idea:
>
> i) FAILED and CANCELLED are terminal states. It makes sense to not have
> work happen after they're set.
>
> ii) Using an intermediate state, assuming locking/atomic are correct is
> a suitable fix for the issue.
>
> iii) Using a FAILING status seems appropriate.
>
> However,
>
> It would be great if we could stop exposing implementation details via
> QAPI. Does the user really need to see events for CANCELLING and
> FAILING?

* Not really; libvirtd(8)/user only needs to know about the success OR
failure and appropriate reasons.

> This is a good example where having MigrationStatus makes the code more
> complicated. This could be exiting=true, running=false, etc. It
> shouldn't matter why this routine failed.

* True, it is rather complicated. Though currently we have 17-18
migration states defined, going by the functions
migration_is_running(), migration_is_active(), and
migration_has_failed(), migration process really has only 3-4 states:
      0 -> stopped (non-active, not-started-yet)
      1 -> running/active (sending-receive migration data)
      2 -> paused/active (not-running, not-send-recv-migration-data)
      3 -> stopped/failed/completed (non-active, not-running)
Other interim states of initiating/setting connections OR
cancelling/failing etc. could be tracked differently.


Thank you.
---
  - Prasad


