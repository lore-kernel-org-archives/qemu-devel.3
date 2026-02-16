Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61423E63F2A
	for <qemu-devel@archiver.kernel.org>; Mon, 16 Feb 2026 07:01:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vrsao-000091-GM; Mon, 16 Feb 2026 02:00:26 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vrsal-00008S-FB
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:00:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vrsaf-0001DA-1M
 for qemu-devel@nongnu.org; Mon, 16 Feb 2026 02:00:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771225212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=zJYeWhpgd6KHC/Y0C7tY5lHxgaaxpCTJy9D58dWyfas=;
 b=VYJ+uuOHxeQvd7cbZvLfyasobCYe3dDKZe35dO8mW5Oj6GNmXvXMT86XR6NWnlpqXXBj15
 yzs9C6NuneYgh+PgrvrVif39wqoNAvtBYx5VS0vKxRH96vTv53CPoTJo7LLXCrpYMU8cnz
 14sx95BqYhgC2BvZL9fJ5LYLFUJS0I4=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-616-7CBqOYFhOAe6IBcRxuqJOw-1; Mon, 16 Feb 2026 02:00:11 -0500
X-MC-Unique: 7CBqOYFhOAe6IBcRxuqJOw-1
X-Mimecast-MFC-AGG-ID: 7CBqOYFhOAe6IBcRxuqJOw_1771225210
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-4837bfcfe0dso10304045e9.1
 for <qemu-devel@nongnu.org>; Sun, 15 Feb 2026 23:00:10 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1771225209; cv=none;
 d=google.com; s=arc-20240605;
 b=B1DsJYZVbzQgi+F+17kUng6hl6UiJvRByCw++thyIGgusnEuFD9SrIBrWn+Ly8Ir2i
 ZSj4Ng8H67L2J/od28FlCPzmUDF5w8QJrFbjmWe8dw6lhY5rEsbblEAIY/7kT23LjNY9
 cAd7HUtxN0O6sUWTKmBQAjqs2129gSfGrjSRHSFZqI9/sROlWlKcTcTPbpn/hFBpTPlj
 Fv8RndGNovtIfZFYsMKL42WED0B73yOtpm/fWzxJLMpUzwxAuvZ4tL1M9LRB0AiDhklY
 AEEu/1wrtYsaMvikJPRBSHNWz5XEJ586a8fB/xKs9HJN+Ef/uGlNx8NlDsaE21qycjdN
 jPMg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20240605; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=zJYeWhpgd6KHC/Y0C7tY5lHxgaaxpCTJy9D58dWyfas=;
 fh=BBUr5Ap/sCcmjrRPv/rvpgy0x+9aasqFDcwH7HHT3hQ=;
 b=L5Uyq4WSuNYLlPYSmMaoDTDb/McOtPlIwhT/pYb3AbK/xLojp1eLM041wz1hT50RbG
 tfn2GErIZaMja7NddocThBbaCcm6kseJ0iZfrbdibb9tQ7hUiSeTZRldOvxbEH+G25fV
 apbSMR4xppdmBXIkpposBx6ylmg/s38hUC3Ha8SNQLbzU+6TQEjTtIigC7pxiPEyq12l
 l69mvn/jGAxLkyhIkrdiMQ5fs3sMx4Z6xwo9b4gOW+GLq6+oDOiQPN1WtNnmMJx+Y2Rg
 JNz4BaLzKI/Icc0DdgFRpO1QniraP2Lob/ycZO4P2/3WfGDRT2lCQp2DV96oZJ4H2QJ8
 Kf/A==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771225209; x=1771830009; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=zJYeWhpgd6KHC/Y0C7tY5lHxgaaxpCTJy9D58dWyfas=;
 b=to9MMuwrI80Q9HwFPCrhlDwe3XNrVCpv6IZPz1oLRYnLhcwEoWQ0hUmBPb+X3s3WED
 1h2o7ZxsN7BJdd9gVtrIhWoQyKC2QwJmBwlMhA/i7hejVzXyDYgMJ9nQOmwLuthtHa2Y
 VhmW0dFk4Q9o1EVt8VWk+ivIU4SLER3obKE1+W0d0scxpfVBRSizMxi1gvfRyBMpphO6
 iJGr2M4mIMbcHU72iAjbVBEP/czwxGegO8uKJUbnu+HK7aLKlPrF2zmr4gZrb1pBmZPQ
 agofDR8muIRFTBeAbC5T90raNILuyv0x0SOa52ZgBBRPYEVLwQPvOuJNr3U3qk4auIzX
 BaBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771225209; x=1771830009;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=zJYeWhpgd6KHC/Y0C7tY5lHxgaaxpCTJy9D58dWyfas=;
 b=BDBhI56dIAa5N8T5tuy1T+/vfE4oGzkoy6MvWh/wU3TWKC9eAjtEOi6AoaefCmqLPR
 b6HTDlxcB/14tNcJg/R4g83pSKMGQLNB+YHGsJ3+vZkDiOQYY423SFJtAD0bPnAKGvsl
 5Uiqa4dY1VwExjDQ8aDDA/OU+vbVRGkyJviUK9+fnyxFbaIfCnSXaJgUq/0GBQ8mhZoR
 Jemd5Od8GKMe61x9v/+plR4SLY4TTKFPk2+xmRlAJwH2/saKzUMqU/Bqv9I5Tl2DgdXt
 og58kdVDS2akFKNETKXaMW51nZZb43tS212woMtvp5iiUUBUxqp088Ljr9s+j3e/aW+4
 9N3Q==
X-Gm-Message-State: AOJu0Yz0TjgNPa462HxKoe5dOgbpxqndQIOU9muOJ725XrG3uKX6VNdP
 C7saxrw0izUO4oVVAnDexbKm8RsF8x7db4A5FPBEZQoifatWrd5Q4gGLPi3Sr5sBaTkZlrzWuAU
 SUl1qVR5JEkBNagnQv7wrkexz01dTxEkC837KqZu3zM8qFPiIQl6PAKxwgvMSmx/Nvmb88GxG+x
 crUdzRsOROv7K3n+3RBQ7NbHI4pOiRzGte/1d6C9Bj9w==
X-Gm-Gg: AZuq6aL5jGF5X0d2wo4C4B7UzHZQrWBW1pu+ZoNjZX62vjXT5/1j3Veyy9iFWlaOyg1
 Yo+CCCIe9gTHyesr03k7ykm8Ravb8FfvGbuj4rzG5geRFK+efAC+lSyqZs7Dvw6OPBG18CRCq+i
 f8oiS1yRD3ilxc3rHU9HRPsSLcLpeH9luY38i2vKL031nRjGwyNcdLa/sZyA8QBxC2DRPEBRXG3
 89V9dPpp9VNgvQAatPsQKK2wWelM7QAOXrezmrrDElbqqKaKStSi3vYmdLeMwqiXsDz
X-Received: by 2002:a05:600c:6098:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-48379ba08a6mr115555295e9.12.1771225209100; 
 Sun, 15 Feb 2026 23:00:09 -0800 (PST)
X-Received: by 2002:a05:600c:6098:b0:477:b734:8c53 with SMTP id
 5b1f17b1804b1-48379ba08a6mr115554725e9.12.1771225208546; Sun, 15 Feb 2026
 23:00:08 -0800 (PST)
MIME-Version: 1.0
References: <20260209132303.717784-1-ppandit@redhat.com>
In-Reply-To: <20260209132303.717784-1-ppandit@redhat.com>
From: Prasad Pandit <ppandit@redhat.com>
Date: Mon, 16 Feb 2026 12:29:52 +0530
X-Gm-Features: AaiRm52AQf7gglvRtLPju8sc2e3jnQ9iTCFr6eD9KegN14nivh1FgGHZjjGCxoQ
Message-ID: <CAE8KmOzuUqK9EYhWt8RyR2B9jA79MuHeUSxJUGDiMQRsk++1=g@mail.gmail.com>
Subject: Re: [PATCH v1] migration: introduce MIGRATION_STATUS_FAILING
To: qemu-devel@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, Prasad Pandit <pjp@fedoraproject.org>
Content-Type: text/plain; charset="UTF-8"
Received-SPF: pass client-ip=170.10.133.124; envelope-from=ppandit@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Mon, 9 Feb 2026 at 18:55, Prasad Pandit <ppandit@redhat.com> wrote:
> When migration connection is broken, the QEMU and libvirtd(8)
> process on the source side receive TCP connection reset
> notification. QEMU sets the migration status to FAILED and
> proceeds to migration_cleanup(). Meanwhile, Libvirtd(8) sends
> a QMP command to migrate_set_capabilities().
>
> The migration_cleanup() and qmp_migrate_set_capabilities()
> calls race with each other. When the latter is invoked first,
> since the migration is not running (FAILED), migration
> capabilities are reset to false, so during migration_cleanup()
> the QEMU process crashes with assertion failure.
>
> Introduce a new migration status FAILING and use it as an
> interim status when an error occurs. Once migration_cleanup()
> is done, it sets the migration status to FAILED. This helps
> to avoid the above race condition and ensuing failure.
>
> Interim status FAILING is set wherever the execution moves
> towards migration_cleanup():
>   - postcopy_start()
>   - migration_thread()
>   - migration_cleanup()
>   - multifd_send_setup()
>   - bg_migration_thread()
>   - migration_completion()
>   - migration_detect_error()
>   - bg_migration_completion()
>   - multifd_send_error_propagate()
>   - migration_connect_error_propagate()
>
> The migration status finally moves to FAILED and reports an
> appropriate error to the user.
>
> Interim status FAILING is _NOT_ set in the following routines
> because they do not follow the migration_cleanup() path to the
> FAILED state:
>   - cpr_exec_cb()
>   - qemu_savevm_state()
>   - postcopy_listen_thread()
>   - process_incoming_migration_co()
>   - multifd_recv_terminate_threads()
>   - migration_channel_process_incoming()
>
> Signed-off-by: Prasad Pandit <pjp@fedoraproject.org>
> ---
>  migration/migration.c                 | 34 +++++++++++++++++----------
>  migration/multifd.c                   |  4 ++--
>  qapi/migration.json                   |  8 ++++---
>  tests/qtest/migration/migration-qmp.c |  3 ++-
>  tests/qtest/migration/precopy-tests.c |  3 ++-
>  5 files changed, 32 insertions(+), 20 deletions(-)
>
> v1:
>  - Rebase patch on the latest upstream version
>  - Add list of functions where interim state FAILING is set
>    and where it is not changed.
>
> 67/67 qtest+qtest-x86_64 - qemu:qtest-x86_64/migration-test                 OK             113.97s   84 subtests passed
> 68/68 qemu:qtest+qtest-x86_64 / qtest-x86_64/migration-test                 OK             107.20s   84 subtests passed
>
> v0:
>  - https://lore.kernel.org/qemu-devel/20251222114822.327623-1-ppandit@redhat.com/T/#u
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b103a82fc0..16c71e502a 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1016,6 +1016,7 @@ bool migration_is_running(void)
>      case MIGRATION_STATUS_DEVICE:
>      case MIGRATION_STATUS_WAIT_UNPLUG:
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_COLO:
>          return true;
>      default:
> @@ -1158,6 +1159,7 @@ static void fill_source_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +    case MIGRATION_STATUS_FAILING:
>          /* TODO add some postcopy stats */
>          populate_time_info(info, s);
>          populate_ram_info(info, s);
> @@ -1210,6 +1212,7 @@ static void fill_destination_migration_info(MigrationInfo *info)
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
>      case MIGRATION_STATUS_POSTCOPY_RECOVER:
>      case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_COLO:
>          info->has_status = true;
>          break;
> @@ -1331,6 +1334,9 @@ static void migration_cleanup(MigrationState *s)
>      if (s->state == MIGRATION_STATUS_CANCELLING) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_CANCELLING,
>                            MIGRATION_STATUS_CANCELLED);
> +    } else if (s->state == MIGRATION_STATUS_FAILING) {
> +        migrate_set_state(&s->state, MIGRATION_STATUS_FAILING,
> +                          MIGRATION_STATUS_FAILED);
>      }
>
>      type = migration_has_failed(s) ? MIG_EVENT_PRECOPY_FAILED :
> @@ -1383,7 +1389,7 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
>
>      switch (current) {
>      case MIGRATION_STATUS_SETUP:
> -        next = MIGRATION_STATUS_FAILED;
> +        next = MIGRATION_STATUS_FAILING;
>          break;
>
>      case MIGRATION_STATUS_POSTCOPY_PAUSED:
> @@ -1397,9 +1403,10 @@ void migration_connect_error_propagate(MigrationState *s, Error *error)
>          break;
>
>      case MIGRATION_STATUS_CANCELLING:
> +    case MIGRATION_STATUS_FAILING:
>          /*
> -         * Don't move out of CANCELLING, the only valid transition is to
> -         * CANCELLED, at migration_cleanup().
> +         * Keep the current state, next transition is to be done
> +         * in migration_cleanup().
>           */
>          break;
>
> @@ -1547,6 +1554,7 @@ bool migration_has_failed(MigrationState *s)
>  {
>      return (s->state == MIGRATION_STATUS_CANCELLING ||
>              s->state == MIGRATION_STATUS_CANCELLED ||
> +            s->state == MIGRATION_STATUS_FAILING ||
>              s->state == MIGRATION_STATUS_FAILED);
>  }
>
> @@ -2472,7 +2480,7 @@ static int postcopy_start(MigrationState *ms, Error **errp)
>          if (postcopy_preempt_establish_channel(ms)) {
>              if (ms->state != MIGRATION_STATUS_CANCELLING) {
>                  migrate_set_state(&ms->state, ms->state,
> -                                  MIGRATION_STATUS_FAILED);
> +                                  MIGRATION_STATUS_FAILING);
>              }
>              error_setg(errp, "%s: Failed to establish preempt channel",
>                         __func__);
> @@ -2635,7 +2643,7 @@ fail_closefb:
>      qemu_fclose(fb);
>  fail:
>      if (ms->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&ms->state, ms->state, MIGRATION_STATUS_FAILING);
>      }
>      migration_block_activate(NULL);
>      migration_call_notifiers(MIG_EVENT_PRECOPY_FAILED, NULL);
> @@ -2828,7 +2836,7 @@ fail:
>      }
>
>      if (s->state != MIGRATION_STATUS_CANCELLING) {
> -        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, s->state, MIGRATION_STATUS_FAILING);
>      }
>  }
>
> @@ -2865,7 +2873,7 @@ static void bg_migration_completion(MigrationState *s)
>
>  fail:
>      migrate_set_state(&s->state, current_active_state,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>  }
>
>  typedef enum MigThrError {
> @@ -3066,7 +3074,7 @@ static MigThrError migration_detect_error(MigrationState *s)
>           * For precopy (or postcopy with error outside IO, or before dest
>           * starts), we fail with no time.
>           */
> -        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILED);
> +        migrate_set_state(&s->state, state, MIGRATION_STATUS_FAILING);
>          trace_migration_thread_file_err();
>
>          /* Time to stop the migration, now. */
> @@ -3297,7 +3305,7 @@ static void migration_iteration_finish(MigrationState *s)
>          migrate_start_colo_process(s);
>          s->vm_old_state = RUN_STATE_RUNNING;
>          /* Fallthrough */
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          if (!migration_block_activate(&local_err)) {
> @@ -3356,7 +3364,7 @@ static void bg_migration_iteration_finish(MigrationState *s)
>      switch (s->state) {
>      case MIGRATION_STATUS_COMPLETED:
>      case MIGRATION_STATUS_ACTIVE:
> -    case MIGRATION_STATUS_FAILED:
> +    case MIGRATION_STATUS_FAILING:
>      case MIGRATION_STATUS_CANCELLED:
>      case MIGRATION_STATUS_CANCELLING:
>          break;
> @@ -3541,7 +3549,7 @@ static void *migration_thread(void *opaque)
>      if (ret) {
>          migrate_error_propagate(s, local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +                          MIGRATION_STATUS_FAILING);
>          goto out;
>      }
>
> @@ -3664,7 +3672,7 @@ static void *bg_migration_thread(void *opaque)
>      if (ret) {
>          migrate_error_propagate(s, local_err);
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                          MIGRATION_STATUS_FAILED);
> +                          MIGRATION_STATUS_FAILING);
>          goto fail_setup;
>      }
>
> @@ -3727,7 +3735,7 @@ static void *bg_migration_thread(void *opaque)
>  fail:
>      if (early_fail) {
>          migrate_set_state(&s->state, MIGRATION_STATUS_ACTIVE,
> -                MIGRATION_STATUS_FAILED);
> +                MIGRATION_STATUS_FAILING);
>          bql_unlock();
>      }
>
> diff --git a/migration/multifd.c b/migration/multifd.c
> index ad6261688f..178c6b3350 100644
> --- a/migration/multifd.c
> +++ b/migration/multifd.c
> @@ -431,7 +431,7 @@ static void multifd_send_error_propagate(Error *err)
>              s->state == MIGRATION_STATUS_DEVICE ||
>              s->state == MIGRATION_STATUS_ACTIVE) {
>              migrate_set_state(&s->state, s->state,
> -                              MIGRATION_STATUS_FAILED);
> +                              MIGRATION_STATUS_FAILING);
>          }
>      }
>  }
> @@ -986,7 +986,7 @@ bool multifd_send_setup(void)
>
>  err:
>      migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                      MIGRATION_STATUS_FAILED);
> +                      MIGRATION_STATUS_FAILING);
>      return false;
>  }
>
> diff --git a/qapi/migration.json b/qapi/migration.json
> index f925e5541b..903c1d9618 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -158,7 +158,9 @@
>  #
>  # @completed: migration is finished.
>  #
> -# @failed: some error occurred during migration process.
> +# @failing: error occurred during migration, clean-up underway.
> +#
> +# @failed: error occurred during migration, clean-up done.
>  #
>  # @colo: VM is in the process of fault tolerance, VM can not get into
>  #     this state unless colo capability is enabled for migration.
> @@ -181,8 +183,8 @@
>    'data': [ 'none', 'setup', 'cancelling', 'cancelled',
>              'active', 'postcopy-device', 'postcopy-active',
>              'postcopy-paused', 'postcopy-recover-setup',
> -            'postcopy-recover', 'completed', 'failed', 'colo',
> -            'pre-switchover', 'device', 'wait-unplug' ] }
> +            'postcopy-recover', 'completed', 'failing', 'failed',
> +            'colo', 'pre-switchover', 'device', 'wait-unplug' ] }
>
>  ##
>  # @VfioStats:
> diff --git a/tests/qtest/migration/migration-qmp.c b/tests/qtest/migration/migration-qmp.c
> index 5c46ceb3e6..8279504db1 100644
> --- a/tests/qtest/migration/migration-qmp.c
> +++ b/tests/qtest/migration/migration-qmp.c
> @@ -241,7 +241,8 @@ void wait_for_migration_fail(QTestState *from, bool allow_active)
>      do {
>          status = migrate_query_status(from);
>          bool result = !strcmp(status, "setup") || !strcmp(status, "failed") ||
> -            (allow_active && !strcmp(status, "active"));
> +            (allow_active && !strcmp(status, "active")) ||
> +            !strcmp(status, "failing");
>          if (!result) {
>              fprintf(stderr, "%s: unexpected status status=%s allow_active=%d\n",
>                      __func__, status, allow_active);
> diff --git a/tests/qtest/migration/precopy-tests.c b/tests/qtest/migration/precopy-tests.c
> index a5423ca33c..f17dc5176d 100644
> --- a/tests/qtest/migration/precopy-tests.c
> +++ b/tests/qtest/migration/precopy-tests.c
> @@ -1247,7 +1247,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>      }
>
>      /* ensure new status don't go unnoticed */
> -    assert(MIGRATION_STATUS__MAX == 16);
> +    assert(MIGRATION_STATUS__MAX == 17);
>
>      for (int i = MIGRATION_STATUS_NONE; i < MIGRATION_STATUS__MAX; i++) {
>          switch (i) {
> @@ -1259,6 +1259,7 @@ void migration_test_add_precopy(MigrationTestEnv *env)
>          case MIGRATION_STATUS_POSTCOPY_PAUSED:
>          case MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP:
>          case MIGRATION_STATUS_POSTCOPY_RECOVER:
> +        case MIGRATION_STATUS_FAILING:
>              continue;
>          default:
>              migration_test_add_suffix("/migration/cancel/src/after/",
> --


Ping..!
---
  - Prasad


