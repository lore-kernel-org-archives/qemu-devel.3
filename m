Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DBF8C5AD55
	for <qemu-devel@archiver.kernel.org>; Mon, 10 Aug 2026 15:48:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wtSEz-0004KX-4T; Mon, 10 Aug 2026 11:48:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtSEx-0004KD-E0
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:48:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <jmarcin@redhat.com>)
 id 1wtSEv-0007rl-TD
 for qemu-devel@nongnu.org; Mon, 10 Aug 2026 11:48:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1786376915;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ckljxzQyE43TfOjBlFU9TNNE6C678xtuZYWh8Q43kvE=;
 b=QgfWnOs4szir/Tz+TrUS8r06sz89qknzBahC9xvgeaYhI4XXyplVy//g0kHMSxq43NBUM0
 vlxS/5krnu6O0SBFu5e9fnum/dhKK8dzsvTCkybSkFba1JDtj2vFGSqsMgajkKhq/SGLCf
 Ib3j84In5mUmYcV+BtV8qU0qB++0678=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-584-srgtbiT1P7m8JGWekSTMaQ-1; Mon, 10 Aug 2026 11:48:33 -0400
X-MC-Unique: srgtbiT1P7m8JGWekSTMaQ-1
X-Mimecast-MFC-AGG-ID: srgtbiT1P7m8JGWekSTMaQ_1786376912
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4996832e7b4so103585e9.1
 for <qemu-devel@nongnu.org>; Mon, 10 Aug 2026 08:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1786376912; x=1786981712; darn=nongnu.org;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ckljxzQyE43TfOjBlFU9TNNE6C678xtuZYWh8Q43kvE=;
 b=V8B10vT6IQqIcvmNR3X4zWW5pxcUXzaLZzX9ly8t6pjdkcDmhZC+/0UrEiuPjchx1v
 XG88lJ0/r8JlBfueLx3IWEngXGYrC1xq6Tmn6ZYz0fH+pogjrz2fF7iTG88Q/92G7SMz
 xZM99Z3IDJ4PPRsmlqt9u7l3FrTV4AtwEMqQJBf5qTVsO9K2IznEN/dogUDe1Kb7VSih
 oxVNsg3TWXm1gae9Dl2m3AbRH0afbHiWTdfkF4CZ6NkYuexGAW5whIa9jXi0k7Mftte0
 vqFPEbFovS6Y6Nbegh24/fGyqqj/pPRz4/Uh4wcRDUha56Mm+KUgMo3ykJUkqYTItGER
 XpPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786376912; x=1786981712;
 h=in-reply-to:content-disposition:content-type:mime-version
 :references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=ckljxzQyE43TfOjBlFU9TNNE6C678xtuZYWh8Q43kvE=;
 b=Eal2xjQRCt7/KWd0apoCD6Xfze43R1zHzA1664F1CUmADeF24Gosf8i+zvCHhgv82O
 L5QbDUauAnvZ9lTwyfEbLYtL2a1AvkHEXbfvhG6hOBNP0lmGVhVPUO0nBayjwj9Mn9yz
 kWXdal+XVool4T1h0I+QTip1S7CXRHabfRRqr3PE2t+u8w8rOocOqKas73AbKIrS/98R
 z6JETQaI/MEUmuwApAT3rWAKRf8zgR1BHFBI8Ps/dMD6dTU77Eb46WBV6aVVd4R4Mu/t
 9ebWVToxGGowBdsReYTpnviuMbVgvVhwjEUGsepC9bwjS1cAv500/+ROKv9dzDEYo9UP
 Ju4Q==
X-Gm-Message-State: AOJu0YxCkb8jC9bE5HZeYqP4SYdjbmuzXf5RZ0O+FxXjjMhlGcJUDgHC
 fJeW9FJ2PB71I1zeHO/5lbsiYUxErIGAKut4pTiDf5VSmCpo6Weijd7ybiZtNcZvzHbrkV1Cjau
 Ef+pUKcX8KpDK0mpzFa5GT0BfzNIi4w3pl5Z7kdshqjcExO0zUDfHdWOX
X-Gm-Gg: AR+sD12Te00gFkJs/TRZxCbL0dW1Dy2a4MKdbJIqo/nz/NtkQl2CIvXIlbDolximz67
 F6FlneBjVjnZ1fG+qJ2vxrJdxnUE6EHjX2fvoIYjZElDV68H/bwHl0eFmYWEO7ZmzGV2mv9TNZR
 vNRRYg+Ci50Aj3kIt4gU3y+DguHwYAFarh9RZS8zDvZRff19KE/VMRe6fCVEJ0Isxj8hToGu/Fz
 wZ7RUw9FunxL7h4uO6ovdoVs7YXx5N3VxZKMTGwwy0QwDR/ERW0br6vSqjXxIIqDmK2i7OssFiR
 dd439sLhJsw5kL8rDroLgToMvmpmz/eWXVQRjRXybOtTO6EBMOS5uQKA
X-Received: by 2002:a05:600c:64c7:b0:499:728c:a1c7 with SMTP id
 5b1f17b1804b1-499728ca1eemr38373795e9.5.1786376911611; 
 Mon, 10 Aug 2026 08:48:31 -0700 (PDT)
X-Received: by 2002:a05:600c:64c7:b0:499:728c:a1c7 with SMTP id
 5b1f17b1804b1-499728ca1eemr38373135e9.5.1786376911240; 
 Mon, 10 Aug 2026 08:48:31 -0700 (PDT)
Received: from fedora ([213.175.46.86]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4997402a89bsm2583795e9.0.2026.08.10.08.48.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 10 Aug 2026 08:48:30 -0700 (PDT)
Date: Mon, 10 Aug 2026 17:48:28 +0200
From: Juraj Marcin <jmarcin@redhat.com>
To: Aadeshveer Singh <aadeshveer07@gmail.com>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, farosas@suse.de, 
 pbonzini@redhat.com, philmd@mailo.com, lvivier@redhat.com, ayoub@saferwall.com,
 pierrick.bouvier@oss.qualcomm.com
Subject: Re: [PATCH v4 08/11] migration: add eager load thread and setup for
 fast snapshot load
Message-ID: <annyvWEfAcFLZIRi@fedora>
References: <20260801023628.22665-1-aadeshveer07@gmail.com>
 <20260801023628.22665-9-aadeshveer07@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260801023628.22665-9-aadeshveer07@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=jmarcin@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.746,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 2026-08-01 08:06, Aadeshveer Singh wrote:
> In fast snapshot load a thread is needed for actively loading in pages
> along with the fault path so that the guest is not dependent on fault
> thread indefinitely. Considering the difference from usual network
> postcopy where major chunk of RAM is already loaded here entire RAM
> needs to be loaded later. Existance of background pages which are not
> really accessed by the guest might never be loaded and system will be
> locked in migration for indefinite time. As there should be no
> assumption about how guest accesses memory, the load times can be
> indefinite.
> 
> Add postcopy_ram_eager_load_thread(), for the eager thread which
> iterates over all non ignored blocks calling ram_block_load_eager()
> on each. ram_block_load_eager then iterates to load in all pages using
> postcopy_mapped_ram_load_page(), with a different channel, which takes
> care of not loading in pages already loaded by fault thread. On
> completion the thread schedules postcopy_incoming_complete_bh() to
> destroy the incoming migration state.
> 
> Add postcopy_ram_eager_load_setup() to create the thread. Added joining
> logic in postcopy_incoming_cleanup().
> 
> Add tracepoints for entry and exit to eager load thread.
> 
> When both mapped-ram and postcopy-ram are set, divert from
> qemu_loadvm_state to run fast snapshot load
> 
> Initialize postcopy RAM state and register RAM Blocks with userfaultfd
> via ram_postcopy_incoming_init() and postcopy_ram_incoming_setup() in
> process_incoming_migration_co(). Fault thread needs to be launched
> before VM to serve faults for some hardwares emulation that need to read
> RAM (like vapic devices). Populate bitmaps and offset tables while
> reading file in qemu_loadvm_state_main.
> 
> Add function qemu_loadvm_run_fast_snapshot_load() which starts the VM
> using loadvm_postcopy_handle_run_bh() and launches eager load thread.
> 
> Skip scheduling process_incoming_migration_bh() in
> process_incoming_migration_co(), for fast snapshot load as the state
> cleanup is managed by eager load thread on completion.
> 
> Signed-off-by: Aadeshveer Singh <aadeshveer07@gmail.com>
> Reviewed-by: Peter Xu <peterx@redhat.com>
> ---
>  migration/migration.c    | 36 +++++++++++++++++++--
>  migration/migration.h    |  5 +++
>  migration/postcopy-ram.c | 69 ++++++++++++++++++++++++++++++++++++++++
>  migration/postcopy-ram.h |  2 ++
>  migration/savevm.c       | 16 ++++++++++
>  migration/savevm.h       |  2 ++
>  migration/trace-events   |  2 ++
>  7 files changed, 130 insertions(+), 2 deletions(-)

Reviewed-by: Juraj Marcin <jmarcin@redhat.com>


