Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28FAFCD13D2
	for <qemu-devel@archiver.kernel.org>; Wed, 29 Apr 2026 19:50:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wIAvC-0007g8-B6; Wed, 29 Apr 2026 15:50:10 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIAvA-0007fo-PD
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:50:08 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wIAv9-0006eY-4s
 for qemu-devel@nongnu.org; Wed, 29 Apr 2026 15:50:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1777492205;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=crC4JUtQ9M5kI39UaRKa2xM6KC+qt7UZjOOhFqFjfG4=;
 b=U9d2EtJa/8hzy8JD6Z2RGnOztSYk9ekIdOxO3bSDiMNv0XPj4ANIsrm8aJyUbvFPWzSjsA
 sMpswvIJzkqzBOPe0zLa2nvIjusMLDEGahuRwjWTgAbx1NlJzwacJsRjJ6nJELe4OEeGp1
 XueBb9gqg3cmhTIKDLBA3MQCgBmeHRA=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-193-3cSsxzZtOueWovnsrKXyQA-1; Wed, 29 Apr 2026 15:50:04 -0400
X-MC-Unique: 3cSsxzZtOueWovnsrKXyQA-1
X-Mimecast-MFC-AGG-ID: 3cSsxzZtOueWovnsrKXyQA_1777492204
Received: by mail-qt1-f197.google.com with SMTP id
 d75a77b69052e-50e67a4f642so2918941cf.0
 for <qemu-devel@nongnu.org>; Wed, 29 Apr 2026 12:50:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1777492204; x=1778097004; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=crC4JUtQ9M5kI39UaRKa2xM6KC+qt7UZjOOhFqFjfG4=;
 b=lXK/Ac822ZBtf0a38yecK366i4pzOuBETClKF1JSlmtFZIuyARqAJaZ0scVv7OBsdA
 0H/3SMcCAcYBA9wW9UZvCVY7L+7xFhQpYNPSPnIKe3zpmQ+1EYF82o9iwuQwBBLZwhXH
 4fJiSEPeJsUmfp1OzG+D+UVcG6nTf5fenxQWw695skoDcWDSllGcItbqUPn1d6Mskhzv
 SvxiNkJoRYav8i/8FkRCMYY96BBBX019x6MuCkBBrHZ6rUglqyNcP9MD7aiCAC4FMXRi
 6jTFaLP7wwNxbKlQUhqyHj+Ktx947RonNZTtw2fDvPpNfuC/TunxERbLVm4Ywn1Xsj9S
 H5rA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777492204; x=1778097004;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=crC4JUtQ9M5kI39UaRKa2xM6KC+qt7UZjOOhFqFjfG4=;
 b=DRP6Twb3iiA9no4ewGuEruEpntLo+0Rq1m/f2t5KX/EU1i6Lwf5s+Tqjg/9qg0QOly
 mwpYbByZcgZM1LFpPydqEF2Qyob2pmvbQ+wCyMZ41wll93t6H0ywfcxHKFetP57UHwi8
 zKBzA19GmdejrwNLfsV7QzZkvXipVjo8bt1weFew6nwhlyhNfpkqcsDkuiw2zZdxMu1j
 4m6S80NbDNLO48P+NQHnHF4fKVPYxCUlh9ikxozwCpk39yVJoZgO8KjqtsjFf3lMgI4i
 g05p2Gr51DaHOL2KtpViOq/Uvhkp7T/r6miyen9qdaei7+Cu6avgwkUrBRX/mv/wc4h7
 X/Hw==
X-Gm-Message-State: AOJu0Ywfy5lpe6U/OOMeFkMjaEoox1HE5IrNDBjvwM4RAb9JZJSN5rXn
 zSsrT4SIdOX2jRyr04rHaFyogYeUbncEkBubBW6fcykl0GsoBRR57O12PFZzn5/HVUTzqzyegQ3
 psqBWzYvXsSLLRn90++eVzyuaCv5FAiJPon/YkZpyAyIXgoeYUPwdD0ba
X-Gm-Gg: AeBDievvHEeXNQWesw60pmOAu2KACWykRPJQ3kAtEVxlKRixNX0hbWikr1aMOkfdOSk
 n/0NPagMUb9Ecs8ZdZx5xOkbkjjYSUxaqgvL9lVR3L1O/J+ksRZlmrYLbtjk04IPNi9tERgFdyX
 6EDjjYU0NP2N0KPEneP24xOaIKp/4XGpH7hF1mVlYCRuIKNbX6MO+1UuvzP4Ik3MGFvaJQXHQT1
 2gL2dUXKeKk8wuPSDv74GgHYvChjU6bitzpR4d9rE7G7uDm1WUcttyHEB/87eeFwR2i35D8BKx1
 vu97u61AbjJe0uFX0hldLb4zdfIIye6RhZPIIF2B+N+uiK/1LCuuBWqgZxzcnFFGUM9Rn0clJQG
 euTm3tcOHaLcjypvNzvd+aV3Hvl2CJzzftnvFMmE59VN2wOI3mZhu4ynnsQ==
X-Received: by 2002:a05:620a:2993:b0:8cf:bcf7:fcf4 with SMTP id
 af79cd13be357-8fa86db76demr29211785a.22.1777492203445; 
 Wed, 29 Apr 2026 12:50:03 -0700 (PDT)
X-Received: by 2002:a05:620a:2993:b0:8cf:bcf7:fcf4 with SMTP id
 af79cd13be357-8fa86db76demr29204685a.22.1777492202741; 
 Wed, 29 Apr 2026 12:50:02 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8b3ef70a6e6sm25614666d6.15.2026.04.29.12.50.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Apr 2026 12:50:02 -0700 (PDT)
Date: Wed, 29 Apr 2026 15:50:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Juraj Marcin <jmarcin@redhat.com>
Cc: qemu-devel@nongnu.org, Jan Kiszka <jan.kiszka@siemens.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [RFC PATCH] migration: Synchronize CPUs sooner in postcopy
 switchover phase
Message-ID: <afJg6VzsaslzZQW1@x1.local>
References: <20260423154525.10292-1-jmarcin@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260423154525.10292-1-jmarcin@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Apr 23, 2026 at 05:45:20PM +0200, Juraj Marcin wrote:
> From: Juraj Marcin <jmarcin@redhat.com>
> 
> Previously, the post init CPU synchronization with the accelerator, like
> KVM, was performed in the bottom half of the POSTCOPY_RUN command
> handler. However, this causes several problems.
> 
> First issue is that if CPU synchronization fails, the destination QEMU
> crashes. However, it is too late to recover the source side as the
> response to special PING has been already sent, and both sides are
> already in the POSTCOPY_ACTIVE state.
> 
> By moving synchronization before responding, if the machine crashes, the
> response is never sent and the source side can resume from the
> POSTCOPY_DEVICE state.
> 
> Second issue is caused when migration is paused due to a network
> failure or user command right after transitioning to the POSTCOPY_ACTIVE
> state and the CPU synchronization causes a page fault. This page fault
> blocks the CPU and the main QEMU threads and cannot be resolved until
> postcopy migration is recovered. However, as libvirt also tries to
> execute 'cont' QMP command at this time (destination side transitions
> from POSTCOPY_DEVICE to POSTCOPY_ACTIVE), it will also halt waiting for
> the response from the blocked main QEMU thread, unaware of the fact that
> the migration is paused and needs to be recovered. Thus, it will wait
> indefinitely and never report postcopy migration error.
> 
> When the CPU synchronization happens sooner, and the network fails
> during it, the source side can transition from POSTCOPY_DEVICE to FAILED
> state and resume safely. If migration is paused later, the main thread
> won't be blocked by CPU synchronization and can respond to libvirt.
> 
> Signed-off-by: Juraj Marcin <jmarcin@redhat.com>
> ---
> I am posting this as RFC to discuss the point at which the CPU
> synchronization should happen.
> 
> For the POSTCOPY_DEVICE state to be effective, this synchronization must
> happen before the destination machine responds to the special PING
> command. This leaves us with 2 options:
> 
> 1) In the PING command handler before responding to the specific
>    request, as proposed in this patch.
> 
> 2) After loading CPU VMSD, for example in the post_load hook.
> 
> The first solution limits the number of places where synchronization
> needs to happen, however, having it in the PING command handler feels
> somewhat hacky.

Yes.

> 
> I have also tested the second solution, and while it seems natural to
> synchronize the CPU after its data is loaded in the post_load, there are
> multiple CPU types and VMSDs and each one would need to call
> synchronization in its post_load hook. This would basically revert Jan
> Kiszka's commit [1] which refactored CPU synchronization and united it
> to one place.

What I was thinking is not reverting all of it, but only removing the
migration relevant paths for post_init().

For example, we have different reasons to sync CPU, and we have two
directions to do that (from/to kernel, in KVM's context). For migration,
what used to be confusing is why we need to have CPU specific post_init()
hooks when each CPU has VMSD and post_load() on its own.

The other one is on savevm side (cpu_synchronize_all_states()) and we can
at least keep it as-is for now, simplify the discussion.

So if we want to move this into any of such post_load(), it means removal
of three call sites of post_init() only in migration/savevm.c, then do
per-CPU's post_init() in its post_load() hook.

I don't know the real answer of this one; I recall you tried it out but hit
some ARM specific issue.  Just to want to make sure we're on the same page
on what you have experimented.

Said that, I do see some complexity over such a change already.  For
example, cpu_vmstate_register() seems to be able to register more than one
VMSDs for each vCPU.  I don't know if it means at least we can't simply put
it into post_load() of vmstate_cpu_common, as when reaching there it is not
guaranteed that all vCPUs' registers are uptodate..

Besides..

I do have another thought, though, to avoid the hacky part of this patch
and looks pretty safe: dest QEMU does not reply directly to the
QEMU_VM_PING_PACKAGED_LOADED ping, instead it sets a flag. Then we move the
conditional PONG into loadvm_postcopy_handle_run().

With that, we can move post_init() into loadvm_postcopy_handle_run()
altogether.

  loadvm_postcopy_handle_run():
    ...
    cpu_synchronize_all_post_init();
    if (package_loaded_ping_received) {
        send_pong();
    }
    migrate_set_state(POSTCOPY_DEVICE, POSTCOPY_ACTIVE);
    migration_bh_schedule(mis);

Would this work?

-- 
Peter Xu


