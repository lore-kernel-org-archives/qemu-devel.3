Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54787C61DD6
	for <qemu-devel@archiver.kernel.org>; Fri,  4 Sep 2026 14:01:34 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x2UTo-00036M-Rf; Fri, 04 Sep 2026 10:01:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2UTf-00032w-Cr
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:01:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1x2UTb-0008Dg-Nt
 for qemu-devel@nongnu.org; Fri, 04 Sep 2026 10:01:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1788530466;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RDtfF8OFaheUu1FhdOA/gigFR4jwr3XRfGB8LD5xlOk=;
 b=L9U0JJSlwp530nlTTZGkGDTS+XHan0QJcMDhgSS4YF8BPxRG0kuYP7VLMrRMqSq2MH8f4r
 g34+BPeC644ZZsLaDl/rWaL4sDXsSrLv9us2vBZLehgGO05NBlBEfmD+PPl5dM2mpe2Hld
 9O16fVOqkdxrWxQoxooMgE54gKc21Vs=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-9Z4nS544MlqSUbeIuQdXKA-1; Fri, 04 Sep 2026 10:01:04 -0400
X-MC-Unique: 9Z4nS544MlqSUbeIuQdXKA-1
X-Mimecast-MFC-AGG-ID: 9Z4nS544MlqSUbeIuQdXKA_1788530464
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-52faa0dd18bso31598331cf.0
 for <qemu-devel@nongnu.org>; Fri, 04 Sep 2026 07:01:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1788530464; x=1789135264; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=RDtfF8OFaheUu1FhdOA/gigFR4jwr3XRfGB8LD5xlOk=;
 b=BX6xyP1uDq2Bz9wC0zEoSW01jVeDEfn35xcHNCMgeEbxtn+XyuvrfB2NxEdevH+tbO
 y2iJSj/vJg196tcJ39sS4NYhEEmOE+UzgGHCEJiaHXNMKSAJ/blsk4RK1a434tiXt/e4
 9/QMZGh+ksadK7fV9Rpi5iH4zDZU9RnsWNu1JaozB+CmVhnDk8/QTBwrlV0iH2Ws66uG
 FI5JQBKG2LxGdj8aNgWbb8Ok57spyJeAEN6B+8e+Kt5dTds5X61xztTwZrlbOstQy/VH
 s2ygc8nksM9RKEHgocTi9aTgHL2VW5yvbaFIw4rigB03INdlQi62QFElDUTpg2SHLejZ
 yEbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788530464; x=1789135264;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=RDtfF8OFaheUu1FhdOA/gigFR4jwr3XRfGB8LD5xlOk=;
 b=OQhdMmHLd8d8wJsOz23lW37/n/UcTF1HyrwsVYhGfTJqi+teI/J4V0oqALDdUm/TYD
 8KAlUFZ4wRYOQOXDmeU1JK/mI51TyNlmsdQbrso7C8O6JJSgSFvfev8n1bTq5hW6Q7I8
 ZYCIVe4xnAOk0dxEzjAX4qjmomAhpqiFuPVAk0XIJxKhguAS70T36MKzSbpKzWJ+ONdg
 ZHIUCr/R5TMzQ4XQ1FTJoGIrhm4JkpncblOw7oOWUCtCtYuzhRsym196FPDqMVUfay9r
 U3NFoYc5IHysPlBZT+HiL4y0nuMYUf7OJxgH5T2MDZCzroXIOZU/JJxUhBCiCfsK68n6
 GsXw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzwkEIrLw6dAjbfdxYTSP0svOtl0n9ARoLM33gY1LoEbjISyX24egSmUMvC2Ftuha17C4qK0h8qNLkU@nongnu.org
X-Gm-Message-State: AFuF++mW9JO1aLktYAybJZPGiclYJs1mHXieOTCrFNXq2NSRL2drAhoU
 oCans95AqxQ0UxUHadZKH2QahLB2gDpSNIZU6+z1L2+PvNg8KTxKshwkQWg+ViTOISfWD5/hRL/
 iuoMQOshJ8e26z15k2RC57iOpSOHCzqdyGTlMNgkprKgE9jjjMoD30Ly9
X-Gm-Gg: AYBFou2Eu0ni0Ok2Wk8DUohpCcl6cjyRuqpecY7k4/Q4138SkXCcUHmNyO7A/VIQ+Zg
 JNPdjVwykue6ErgW21a1kl5PY7bGLWK/hmFm/lbTcNVFvYd0sT2wzA/QMA0P0TEvCKUwDyqVIe9
 MoMWhbo78/VQkbEt50H5cEy4mzN7S6sbalUqorKXe87PiqLKWdms3+yxzTgBezgHyxtw91x4RKA
 i4VeAAanODyDOxTqKUdtovDORHBkIhpAWFhOmlVV1n4JN0SF9ywAgO78jp9wSVD2c8eJL6l6/aw
 EsWiFmB0UCPUjumYbZWH163wpWVBN061w6CMmcr1Sbg7ReRtyoK+Q7bmpYvmGD73L9cJwnxn
X-Received: by 2002:a05:622a:2616:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-5305482802cmr58597061cf.13.1788530459911; 
 Fri, 04 Sep 2026 07:00:59 -0700 (PDT)
X-Received: by 2002:a05:622a:2616:b0:517:8d24:64d8 with SMTP id
 d75a77b69052e-5305482802cmr58590061cf.13.1788530454515; 
 Fri, 04 Sep 2026 07:00:54 -0700 (PDT)
Received: from localhost ([2605:8d80:6d61:1b95:5d7e:c15d:7429:70fd])
 by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-530541e0eb7sm20838071cf.25.2026.09.04.07.00.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 04 Sep 2026 07:00:52 -0700 (PDT)
Date: Fri, 4 Sep 2026 10:00:50 -0400
From: Peter Xu <peterx@redhat.com>
To: =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@gmail.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org
Subject: Re: [PATCH 3/3] migration: Free the JSON writer during snapshots
Message-ID: <aprPEvIxL7yc4LvK@x1.local>
References: <20260903220523.2849019-1-farosas@suse.de>
 <20260903220523.2849019-4-farosas@suse.de>
 <CAJ+F1CJqvPF9VoG4f6nSYaZ2hsnX6F6qbSyGiZHjxGThDMJ5wg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJ+F1CJqvPF9VoG4f6nSYaZ2hsnX6F6qbSyGiZHjxGThDMJ5wg@mail.gmail.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001, SPF_HELO_PASS=-0.001,
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

On Fri, Sep 04, 2026 at 04:09:26PM +0400, Marc-André Lureau wrote:
> Hi
> 
> 
> On Fri, Sep 4, 2026 at 2:06 AM Fabiano Rosas <farosas@suse.de> wrote:
> >
> > The JSON writer is created at migrate_init() and freed at
> > migration_cleanup(). The latter is not called for snapshots. Add a
> > call to migration_cleanup_json_writer() to make sure it doesn't leak:
> >
> > Indirect leak of 24 byte(s) in 1 object(s) allocated from:
> >     #0 0x55ca12aabca0 in malloc
> >     #1 0x7fd97d7e595d in g_malloc
> >     #2 0x7fd97d7ffe38 in g_slice_alloc
> >     #3 0x7fd97d8042e2 in g_string_sized_new
> >     #4 0x55ca1571dd6b in json_writer_new ../qobject/json-writer.c:36:24
> >     #5 0x55ca12e0de56 in migrate_init ../migration/migration.c:1718:21
> >     #6 0x55ca12ec8fe6 in qemu_savevm_state ../migration/savevm.c:1921:11
> >     #7 0x55ca12ec8b93 in save_snapshot ../migration/savevm.c:3380:11
> >
> > Signed-off-by: Fabiano Rosas <farosas@suse.de>
> > ---
> >  migration/migration.c | 2 +-
> >  migration/migration.h | 1 +
> >  migration/savevm.c    | 2 +-
> >  3 files changed, 3 insertions(+), 2 deletions(-)
> >
> > diff --git a/migration/migration.c b/migration/migration.c
> > index b413d28622..d0b864a760 100644
> > --- a/migration/migration.c
> > +++ b/migration/migration.c
> > @@ -1330,7 +1330,7 @@ void migrate_set_state(MigrationStatus *state, MigrationStatus old_state,
> >      }
> >  }
> >
> > -static void migration_cleanup_json_writer(MigrationState *s)
> > +void migration_cleanup_json_writer(MigrationState *s)
> >  {
> >      g_clear_pointer(&s->vmdesc, json_writer_free);
> >  }
> > diff --git a/migration/migration.h b/migration/migration.h
> > index e47ff4e3d1..683bc7bdd5 100644
> > --- a/migration/migration.h
> > +++ b/migration/migration.h
> > @@ -633,4 +633,5 @@ void migration_bitmap_sync_precopy(bool last_stage);
> >  void dirty_bitmap_mig_init(void);
> >  bool should_send_vmdesc(void);
> >
> > +void migration_cleanup_json_writer(MigrationState *s);
> >  #endif
> > diff --git a/migration/savevm.c b/migration/savevm.c
> > index 8d4bdc28ab..a31f34f25c 100644
> > --- a/migration/savevm.c
> > +++ b/migration/savevm.c
> > @@ -3404,7 +3404,7 @@ bool save_snapshot(const char *name, bool overwrite, const char *vmstate,
> >
> >   the_end:
> >      bdrv_drain_all_end();
> > -
> > +    migration_cleanup_json_writer(migrate_get_current());
> >      vm_resume(saved_state);
> >      return ret == 0;
> >  }
> 
> rather than exposing internal helper, can it be done where it calls init?
> 
> diff --git a/migration/savevm.c b/migration/savevm.c
> index e2aaedeab565..e08dc2e8c258 100644
> --- a/migration/savevm.c
> +++ b/migration/savevm.c
> @@ -1952,6 +1952,7 @@ static int qemu_savevm_state(QEMUFile *f, Error **errp)
>      }
>  cleanup:
>      qemu_savevm_state_cleanup();
> +    g_clear_pointer(&ms->vmdesc, json_writer_free);

IMHO migration_cleanup_json_writer() is fine to be available in whole
migration/, but I also agree qemu_savevm_state() seems to be the better
place.

-- 
Peter Xu


