Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F59CD690EF
	for <qemu-devel@archiver.kernel.org>; Thu, 28 Nov 2024 10:19:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tGbbz-0004Zx-W5; Thu, 28 Nov 2024 05:19:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGbbx-0004ZY-MM
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:19:01 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1tGbbv-0004zw-Pp
 for qemu-devel@nongnu.org; Thu, 28 Nov 2024 05:19:01 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732789136;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=/JLf2w6cLMlLNL0mFX+BbTfeyhqbBt0ODC2WEyLqrmw=;
 b=KMAAUIVwP96QALXjkKrYwv1n7AIufMqL7H7kHksX96A05pNZ1EwUSkcD/NfUDz52gxJ0PA
 X9k5GmUDVAKBtYgk9wHkVCSrKLIOoOsiePz7Jlm/Smn5MLoooBs7Y/k7USFWjt46/7olmx
 0U5Ltn/KyC4rJdEqnTxIEOOR5mNhk10=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-678-JRsOUseLNd6a--SWYD_nuw-1; Thu, 28 Nov 2024 05:18:55 -0500
X-MC-Unique: JRsOUseLNd6a--SWYD_nuw-1
X-Mimecast-MFC-AGG-ID: JRsOUseLNd6a--SWYD_nuw
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-385b87aee0aso354866f8f.3
 for <qemu-devel@nongnu.org>; Thu, 28 Nov 2024 02:18:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732789134; x=1733393934;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=/JLf2w6cLMlLNL0mFX+BbTfeyhqbBt0ODC2WEyLqrmw=;
 b=h4r4ac0Kcg5+3nB/0QgliakUmEiYRvSKmTIk060oVXQJXx4BF/GJunvbwlwl8vlH8t
 3GCGW+eVNorx/BL6JIxjwgy5G9xbji94PbYQavfifeCNz/5rpOUMOqpzdhN0YkpbXY+l
 fOUnK6ZQMCcNwk7mdXOr8Mwh0TfYi3uUexbAsTZz89tCgu89TMRy5V2D/0i8J+1dulhW
 fc3y3IHZNDeGHO013DMtJCak5yYzko1KjLbhLFhDDli4S0nU40vJ5UJWDdisKO8FPipq
 4lUNNTu7WEmSnKQ7LelDmMfvs6FqrYlcJzOcTmnrlfiOyoT1779VHRQDVv7IYprvoUg1
 kaTA==
X-Gm-Message-State: AOJu0Ywm5Io6MwZqJ/sORt26O5bRFgpGxo9tvlUtBudn9e8aI5YQ7LxL
 sG9f+rSakVo3DvtgHPcEfeNjKNHWafOuAwYUS3ReY6UbXQBojsAgrapoi3onBhJtBm3RhDBfWgb
 OmPobO4mDAn2iXBV/RYqIo5++XKBSjnrTjQX5mLYaTR2fXCjKMEQQFEFdN2VSHvn9Qh/2e+7riY
 Hf71RupPy+uFVUTPUNxNnoWFZ6i5U=
X-Gm-Gg: ASbGncvw47PR96KNg/HdKix6cDXVvD1sZZKeDsAgF0OXwMC5f4V9rVukMp9ayIPIDvc
 9rzLB9mIZ9fEXThTsqbF3wgv/yNWcKNDsvQ==
X-Received: by 2002:a05:6000:400b:b0:382:5066:324c with SMTP id
 ffacd0b85a97d-385c6ef3a53mr5579002f8f.54.1732789133672; 
 Thu, 28 Nov 2024 02:18:53 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH93ZGUd5XKnefyML+kNuyRKOnzfzGOmIATVND/3m19EZU2KtFmaxefzv0BJWGUJuiKoUt5um/kIDFOkEIX1DM=
X-Received: by 2002:a05:6000:400b:b0:382:5066:324c with SMTP id
 ffacd0b85a97d-385c6ef3a53mr5578978f8f.54.1732789133322; Thu, 28 Nov 2024
 02:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20241126115748.118683-1-ppandit@redhat.com>
 <20241126115748.118683-4-ppandit@redhat.com>
 <87ed2xn16y.fsf@suse.de>
 <CAE8KmOwfzFyBWfq_Vhr-hjT4jGQQqi6_gZwkNGtd8SVLxhi0QQ@mail.gmail.com>
 <875xo8n4ue.fsf@suse.de>
In-Reply-To: <875xo8n4ue.fsf@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Thu, 28 Nov 2024 15:48:36 +0530
Message-ID: <CAE8KmOzfaxzxTCMoF6miOG5fYFaikmz7sm9UeuAe6u1Optz8fg@mail.gmail.com>
Subject: Re: [PATCH v1 3/4] migration: refactor ram_save_target_page functions
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com, 
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
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Wed, 27 Nov 2024 at 19:42, Fabiano Rosas <farosas@suse.de> wrote:
> From e9110360eb0efddf6945f37c518e3cc38d12b600 Mon Sep 17 00:00:00 2001
> From: Fabiano Rosas <farosas@suse.de>
> Date: Wed, 27 Nov 2024 11:03:04 -0300
> Subject: [PATCH] migration: Rationalize multifd flushes from ram code
>
> We currently have a mess of conditionals to achieve the correct
> combination of multifd local flushes, where we sync the local
> (send/recv) multifd threads between themselves, and multifd remote
> flushes, where we put a flag on the stream to inform the recv side to
> perform a local flush.
>
> On top of that we also have the multifd_flush_after_each_section
> property, which is there to provide backward compatibility from when
> we used to flush after every vmstate section.
>
> And lastly, there's the mapped-ram feature which always wants the
> non-backward compatible behavior and also does not support extraneous
> flags on the stream (such as the MULTIFD_FLUSH flag).
>
> Move the conditionals into a separate function that encapsulates and
> explains the whole situation.
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/ram.c | 198 ++++++++++++++++++++++++++++++++++++++----------
>  1 file changed, 157 insertions(+), 41 deletions(-)
>
> diff --git a/migration/ram.c b/migration/ram.c
> index 05ff9eb328..caaaae6fdc 100644
> --- a/migration/ram.c
> +++ b/migration/ram.c
> @@ -1277,6 +1277,149 @@ static int ram_save_page(RAMState *rs, PageSearchStatus *pss)
>      return pages;
>  }
>
> +enum RamMultifdFlushSpots {
> +    FLUSH_SAVE_SETUP,
> +    FLUSH_SAVE_ITER,
> +    FLUSH_DIRTY_BLOCK,
> +    FLUSH_SAVE_COMPLETE,
> +
> +    FLUSH_LOAD_POSTCOPY_EOS,
> +    FLUSH_LOAD_POSTCOPY_FLUSH,
> +    FLUSH_LOAD_PRECOPY_EOS,
> +    FLUSH_LOAD_PRECOPY_FLUSH,
> +};
> +
> +static int ram_multifd_flush(QEMUFile *f, enum RamMultifdFlushSpots spot)
> +{
> +    int ret;
> +    bool always_flush, do_local_flush, do_remote_flush;
> +    bool mapped_ram = migrate_mapped_ram();
> +
> +    if (!migrate_multifd()) {
> +        return 0;
> +    }
> +
> +    /*
> +     * For backward compatibility, whether to flush multifd after each
> +     * section is sent. This is mutually exclusive with a
> +     * RAM_SAVE_FLAG_MULTIFD_FLUSH on the stream
> +     */
> +    always_flush = migrate_multifd_flush_after_each_section();
> +
> +    /*
> +     * Save side flushes
> +     */
> +
> +    do_local_flush = false;
> +
> +    switch (spot) {
> +    case FLUSH_SAVE_SETUP:
> +        assert(!bql_locked());
> +        do_local_flush = true;
> +        break;
> +
> +    case FLUSH_SAVE_ITER:
> +        /*
> +         * This flush is not necessary, only do for backward
> +         * compatibility. Mapped-ram assumes the new scheme.
> +         */
> +        do_local_flush = always_flush && !mapped_ram;
> +        break;
> +
> +    case FLUSH_DIRTY_BLOCK:
> +        /*
> +         * This is the flush that's actually required, always do it
> +         * unless we're emulating the old behavior.
> +         */
> +        do_local_flush = !always_flush || mapped_ram;
> +        break;
> +
> +    case FLUSH_SAVE_COMPLETE:
> +        do_local_flush = true;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    if (do_local_flush) {
> +        ret = multifd_ram_flush_and_sync();
> +        if (ret < 0) {
> +            return ret;
> +        }
> +    }
> +
> +    /*
> +     * There's never a remote flush with mapped-ram because any flags
> +     * put on the stream (aside from RAM_SAVE_FLAG_MEM_SIZE and
> +     * RAM_SAVE_FLAG_EOS) break mapped-ram's assumption that ram pages
> +     * can be read contiguously from the stream.
> +     *
> +     * On the recv side, there's no local flush, even at EOS because
> +     * mapped-ram does its own flush after loading the ramblock.
> +     */
> +    if (mapped_ram) {
> +        return 0;
> +    }
> +
> +    do_remote_flush = false;
> +
> +    /* Save side remote flush */
> +    switch (spot) {
> +    case FLUSH_SAVE_SETUP:
> +        do_remote_flush = !always_flush;
> +        break;
> +
> +    case FLUSH_SAVE_ITER:
> +        do_remote_flush = false;
> +        break;
> +
> +    case FLUSH_DIRTY_BLOCK:
> +        do_remote_flush = do_local_flush;
> +        break;
> +
> +    case FLUSH_SAVE_COMPLETE:
> +        do_remote_flush = false;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    /* Put a flag on the stream to trigger a remote flush */
> +    if (do_remote_flush) {
> +        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> +        qemu_fflush(f);
> +    }
> +
> +    /*
> +     * Load side flushes.
> +     */
> +
> +    do_local_flush = false;
> +
> +    switch (spot) {
> +    case FLUSH_LOAD_PRECOPY_EOS:
> +    case FLUSH_LOAD_POSTCOPY_EOS:
> +        do_local_flush = always_flush;
> +        break;
> +
> +    case FLUSH_LOAD_PRECOPY_FLUSH:
> +    case FLUSH_LOAD_POSTCOPY_FLUSH:
> +        do_local_flush = true;
> +        break;
> +
> +    default:
> +        break;
> +    }
> +
> +    if (do_local_flush) {
> +        multifd_recv_sync_main();
> +    }
> +
> +    return 0;
> +}
> +
>  static int ram_save_multifd_page(RAMBlock *block, ram_addr_t offset)
>  {
>      if (!multifd_queue_page(block, offset)) {
> @@ -1323,19 +1466,10 @@ static int find_dirty_block(RAMState *rs, PageSearchStatus *pss)
>          pss->page = 0;
>          pss->block = QLIST_NEXT_RCU(pss->block, next);
>          if (!pss->block) {
> -            if (migrate_multifd() &&
> -                (!migrate_multifd_flush_after_each_section() ||
> -                 migrate_mapped_ram())) {
> -                QEMUFile *f = rs->pss[RAM_CHANNEL_PRECOPY].pss_channel;
> -                int ret = multifd_ram_flush_and_sync();
> -                if (ret < 0) {
> -                    return ret;
> -                }
> -
> -                if (!migrate_mapped_ram()) {
> -                    qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> -                    qemu_fflush(f);
> -                }
> +            int ret = ram_multifd_flush(rs->pss[RAM_CHANNEL_PRECOPY].pss_channel,
> +                                        FLUSH_DIRTY_BLOCK);
> +            if (ret < 0) {
> +                return ret;
>              }
>
>              /* Hit the end of the list */
> @@ -3065,18 +3199,13 @@ static int ram_save_setup(QEMUFile *f, void *opaque, Error **errp)
>      }
>
>      bql_unlock();
> -    ret = multifd_ram_flush_and_sync();
> +    ret = ram_multifd_flush(f, FLUSH_SAVE_SETUP);
>      bql_lock();
>      if (ret < 0) {
>          error_setg(errp, "%s: multifd synchronization failed", __func__);
>          return ret;
>      }
>
> -    if (migrate_multifd() && !migrate_multifd_flush_after_each_section()
> -        && !migrate_mapped_ram()) {
> -        qemu_put_be64(f, RAM_SAVE_FLAG_MULTIFD_FLUSH);
> -    }
> -
>      qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
>      ret = qemu_fflush(f);
>      if (ret < 0) {
> @@ -3209,12 +3338,10 @@ static int ram_save_iterate(QEMUFile *f, void *opaque)
>
>  out:
>      if (ret >= 0 && migration_is_running()) {
> -        if (migrate_multifd() && migrate_multifd_flush_after_each_section() &&
> -            !migrate_mapped_ram()) {
> -            ret = multifd_ram_flush_and_sync();
> -            if (ret < 0) {
> -                return ret;
> -            }
> +
> +        ret = ram_multifd_flush(f, FLUSH_SAVE_ITER);
> +        if (ret < 0) {
> +            return ret;
>          }
>
>          qemu_put_be64(f, RAM_SAVE_FLAG_EOS);
> @@ -3283,7 +3410,7 @@ static int ram_save_complete(QEMUFile *f, void *opaque)
>          }
>      }
>
> -    ret = multifd_ram_flush_and_sync();
> +    ret = ram_multifd_flush(f, FLUSH_SAVE_COMPLETE);
>      if (ret < 0) {
>          return ret;
>      }
> @@ -3797,14 +3924,11 @@ int ram_load_postcopy(QEMUFile *f, int channel)
>              }
>              break;
>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
> -            multifd_recv_sync_main();
> +            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_FLUSH);
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> -            if (migrate_multifd() &&
> -                migrate_multifd_flush_after_each_section()) {
> -                multifd_recv_sync_main();
> -            }
> +            ram_multifd_flush(f, FLUSH_LOAD_POSTCOPY_EOS);
>              break;
>          default:
>              error_report("Unknown combination of migration flags: 0x%x"
> @@ -4237,19 +4361,11 @@ static int ram_load_precopy(QEMUFile *f)
>              }
>              break;
>          case RAM_SAVE_FLAG_MULTIFD_FLUSH:
> -            multifd_recv_sync_main();
> +            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_FLUSH);
>              break;
>          case RAM_SAVE_FLAG_EOS:
>              /* normal exit */
> -            if (migrate_multifd() &&
> -                migrate_multifd_flush_after_each_section() &&
> -                /*
> -                 * Mapped-ram migration flushes once and for all after
> -                 * parsing ramblocks. Always ignore EOS for it.
> -                 */
> -                !migrate_mapped_ram()) {
> -                multifd_recv_sync_main();
> -            }
> +            ram_multifd_flush(f, FLUSH_LOAD_PRECOPY_EOS);
>              break;
>          case RAM_SAVE_FLAG_HOOK:
>              ret = rdma_registration_handle(f);
> --
> 2.35.3
>

* This does not seem to solve for complexity. When reading/following
code, it is easier to see 3-4 conditions and work them to check if the
full expression is 'true' or 'false', that is not doable here.

* fflush(1) is just flushing buffered content into (or out of) the
stream IIUC, why do we have to tie it to a specific spot? At any time
it is going to do the same thing: flush available data to (or out of)
the stream.

* Could we separate out send side fflush(1) from the receive side
fflush(1) operations? Writing a flag in the stream on the send side to
trigger fflush(1) on the receive side is weird; Data stream need not
say when to fflush(1). Let the sender and receiver decide when they
want to fflush(1) and fsync(1) data, no? Maybe that'll help to
reduce/solve the complexity of long conditionals? ie. if we are able
to fflush(1) and fsync(1) without any condition?

Thank you.
---
  - Prasad


