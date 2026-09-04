Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 688CDC79F83
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 12:10:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2Sjn-0005Ai-Rn; Fri, 04 Sep 2026 08:09:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x2Sjm-0005AY-5V
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:09:42 -0400
Received: from mail-oi1-x22e.google.com ([2607:f8b0:4864:20::22e])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <marcandre.lureau@gmail.com>)
 id 1x2Sjk-0005qr-JO
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 08:09:41 -0400
Received: by mail-oi1-x22e.google.com with SMTP id
 5614622812f47-495b27007d0so756919b6e.1
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 05:09:39 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1788523779; cv=none;
 d=google.com; s=arc-20260327;
 b=GemXdqaAuatIijunN1qRfSfnzUpRxiqTwsQV+CthNoFmma9za8cF9RmS3956Mo4YzO
 FAu1kvn614MkCBfpB9cja0xx4gGGht/NSQjk4hrftKThIqJbbuBLFi3fX1fyP4gVpAw/
 ujQqvH6lBdJxZcUlqR6KI/0iP6v/GW9ut2XKhRpwZ7HU/c3zaAn+pPVSjWnOP8BBjv+e
 p9gsUQ2TKVo8JdEHgjb5n/JZ3EILup9iZJzh4FNFRfmTO/v+99Au3YzfGAgIValTzOdB
 Nt4jShqD8pULfAuIRB8B1ZUy6SumnaXzNuGfTaBjxKXYJchqRqS3gttQK6FADDyKZiG5
 WlqQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:dkim-signature;
 bh=Ss6EhY6148Ev2wFpeYa8q7E/HvV76CbjusMKvm7aHRY=;
 fh=6kJ3CohSxQ+7EgnARanNFMAgatAnP0uu5SOkx3O7QGs=;
 b=qitUEQ/5RgnJpO2onf7S1IE/kig3z1nZNAiIBX2LfQOGDWhBmhalxze6eJgm0s+cSN
 34tGTpKdOJ/MJFzc6cNl1GJ+jNkBYuu7cEeIPFQyt5v0i/TplEg/VS+6mBDd5hrESAT1
 oIo7mB8ZZoOPk7uOWwmO9zTvQAOyXUbrcYtWoS7AhmTNUCElPJohBpXFNq+jw0+BOgF1
 HGZsMX2GsA3Mj+G9sY4Jwr/MBV1pq97YBlmZpFZRy+1EteJmwhHxRHR7SkbZ5n+c7kyr
 Va0fEr/9YZ+s/Z5mI02SxGFU8UAUa2NXWYom7fcGPKqsComsVM0TEAnl+tvKHY2rPl+B
 2K7w==; darn=nongnu.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788523779; x=1789128579; darn=nongnu.org;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Ss6EhY6148Ev2wFpeYa8q7E/HvV76CbjusMKvm7aHRY=;
 b=HHAsmiYdKYcAbpAJkvK++FPoPU72NxJjy9vTGGDKYgIlRFWhMZsXS/94d5YgqG/zsN
 xgmQ4i/TWpKOpP4jKfkdd8WkgTcupfiA41LW6+eucoazFRJ7/szpvk3ITPsm3eLYtacw
 46tFO6qhPdg6sIC/SKaxgBY2K0D3unZmnYUmoGxmTWdXOLDXqYPtDzX216xYxmP9EEv2
 jGVe/UAMNFyYcMMxfc6ew9Fr0SOkyigfLQr94IpYdyxH9bnOxFhCkaw55etEWJbplug2
 D7STMRWoJud2vFxsO84o2zi9eiQbzFWtSODxByU0+ahUso88kb6MN1R16GankWB6UNxK
 MMlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788523779; x=1789128579;
 h=content-transfer-encoding:content-type:cc:to:subject:message-id
 :date:from:in-reply-to:references:mime-version:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=Ss6EhY6148Ev2wFpeYa8q7E/HvV76CbjusMKvm7aHRY=;
 b=pPPAjINUjb87PFwr5Muwig2AloQxeMYrS0P03zBPBxbm9U+1xO5sh7ZqCL40rkqV5t
 zp0LZhYe15XfwLSXJWMuLD2fiXbcBgXN4ErIHtKWYibcRN9FrtUk4J7srZqCl8ih1J95
 x0dNIjsz8P4LyA6xF+ZI2JlAA881RUWzelNNkisjPQ6YKvXGhatJYcvq5uXQAjqp8wAM
 L8Yei7pRfHkRzf1Ewx3dlSK12zZ0V5YDFxZgv2+BVrVpM7kNHauUTbUL2BwgcvTzFYIr
 dsdPK9+nSKecvDj0O91rDD6IxgDGOfBd+1yZI3V1iFXD/7X71h8Ctw1raIGd9K3H1kaT
 rcfQ==
X-Gm-Message-State: AFuF++n1r/1a4GBNvHzoQqnfK5XqkIj42q7HaFPrFpeT3AN2oGVvguSX
 MixVMipwv/dzaE0gvvYVWyqtmyevrNsSpDbNPv2mTWRmVYcsJebvqQzpciSvJq7T2Rhy8otQNoh
 xAC1b13c0wshiPpBrktIvOww50QmeMVg=
X-Gm-Gg: AYBFou0ZTEb8aFVejII3LPVb3CtKjQXrK2GYRJ2nAlB43NkokwkJNCuB0uwhzeBxP8a
 o4SvhThfJ9gitu7MmGvE0QE9k/DvhJtA+VeI21MQ6qCFu6cEzdqeqrQ/QbFjhKzyXhp+gSYMjAp
 vCCyiKBgUVPQ/tG/88KsWyUkP9BmwLDv66Q4D8v7MHcZfl0cVjahFkAozJ66BdKA4xCiuBk/wRg
 x4rn5F+05S0/xJGDqcLVQ5e8XRdGGqwrYu7PdgLyXXMUbiQjxUhx2ADqlbobo/IpNH91296BzjL
 NGF6tXN0rzypFlEXWiavRlAL2rpbUIgaZx9TkPDo6voRzmuWyV/of62KbgB3/c6FEHvQoMkLiZn
 f/feJFC7VJZs=
X-Received: by 2002:a4a:edc4:0:b0:6b7:8415:d793 with SMTP id
 006d021491bc7-6b78415d8efmr1398504eaf.62.1788523778778; Fri, 04 Sep 2026
 05:09:38 -0700 (PDT)
MIME-Version: 1.0
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-4-farosas@suse.de>
In-Reply-To: <20260903220523.2849019-4-farosas@suse.de>
From: =?UTF-8?B?TWFyYy1BbmRyw6kgTHVyZWF1?= <marcandre.lureau@gmail.com>
Date: Fri, 4 Sep 2026 16:09:26 +0400
X-Gm-Features: AcwNN1UMm1kOiuyzlkDl_K5VFKck6L935E7S7dogZ02raFYoreevazq-COG__fI
Message-ID: <CAJ+F1CJqvPF9VoG4f6nSYaZ2hsnX6F6qbSyGiZHjxGThDMJ5wg@mail.gmail.com>
Subject: Re: [PATCH 3/3] migration: Free the JSON writer during snapshots
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Xu <peterx@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Received-SPF: pass client-ip=2607:f8b0:4864:20::22e;
 envelope-from=marcandre.lureau@gmail.com; helo=mail-oi1-x22e.google.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1, FORGED_GMAIL_RCVD=1,
 FREEMAIL_FROM=0.001, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi


On Fri, Sep 4, 2026 at 2:06=E2=80=AFAM Fabiano Rosas <farosas@suse.de> wrot=
e:
>
> The JSON writer is created at migrate_init() and freed at
> migration_cleanup(). The latter is not called for snapshots. Add a
> call to migration_cleanup_json_writer() to make sure it doesn't leak:
>
> Indirect leak of 24 byte(s) in 1 object(s) allocated from:
>     #0 0x55ca12aabca0 in malloc
>     #1 0x7fd97d7e595d in g_malloc
>     #2 0x7fd97d7ffe38 in g_slice_alloc
>     #3 0x7fd97d8042e2 in g_string_sized_new
>     #4 0x55ca1571dd6b in json_writer_new ../qobject/json-writer.c:36:24
>     #5 0x55ca12e0de56 in migrate_init ../migration/migration.c:1718:21
>     #6 0x55ca12ec8fe6 in qemu_savevm_state ../migration/savevm.c:1921:11
>     #7 0x55ca12ec8b93 in save_snapshot ../migration/savevm.c:3380:11
>
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  migration/migration.c | 2 +-
>  migration/migration.h | 1 +
>  migration/savevm.c    | 2 +-
>  3 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/migration/migration.c b/migration/migration.c
> index b413d28622..d0b864a760 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1330,7 +1330,7 @@ void migrate_set_state(MigrationStatus *state, Migr=
ationStatus old_state,
>      }
>  }
>
> -static void migration_cleanup_json_writer(MigrationState *s)
> +void migration_cleanup_json_writer(MigrationState *s)
>  {
>      g_clear_pointer(&s->vmdesc, json_writer_free);
>  }
> diff --git a/migration/migration.h b/migration/migration.h
> index e47ff4e3d1..683bc7bdd5 100644
> --- a/migration/migration.h
> +++ b/migration/migration.h
> @@ -633,4 +633,5 @@ void migration_bitmap_sync_precopy(bool last_stage);
>  void dirty_bitmap_mig_init(void);
>  bool should_send_vmdesc(void);
>
> +void migration_cleanup_json_writer(MigrationState *s);
>  #endif
> diff --git a/migration/savevm.c b/migration/savevm.c
> index 8d4bdc28ab..a31f34f25c 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -3404,7 +3404,7 @@ bool save_snapshot(const char *name, bool overwrite=
, const char *vmstate,
>
>   the_end:
>      bdrv_drain_all_end();
> -
> +    migration_cleanup_json_writer(migrate_get_current());
>      vm_resume(saved_state);
>      return ret =3D=3D 0;
>  }

rather than exposing internal helper, can it be done where it calls init?

diff --git a/migration/savevm.c b/migration/savevm.c
index e2aaedeab565..e08dc2e8c258 100644
--- a/migration/savevm.c
+++ b/migration/savevm.c
@@ -1952,6 +1952,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **err=
p)
     }
 cleanup:
     qemu_savevm_state_cleanup();
+    g_clear_pointer(&ms->vmdesc, json_writer_free);


--
Marc-Andr=C3=A9 Lureau

