Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18768E92734
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Dec 2025 16:40:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vaGHV-00006N-Ud; Mon, 29 Dec 2025 11:39:43 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGHM-0008WS-MM
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:39:32 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vaGHK-0008N7-Oq
 for qemu-devel@nongnu.org; Mon, 29 Dec 2025 11:39:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1767026369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6Vv0kzW/OBZtkZeFJwtFPl861a0tnJnouUTswpexiN0=;
 b=DqDWtomJ9FIWOj9TtJLVvxbhopumXQhCfXLmc9FnM+hOpX5nS60dF2i3g/cQv0DEFgUSiF
 YG0rkKyh8TebKMk4znPFHG+0vSdbMZJEELQdRmWyixkOufZ7kpjWoVHKsyqsnfNDfmvwH1
 tOYNw3Hn0GFEgF34y5nmf2xWHAJ/t+0=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-138-jeq_40GGPt2GYcoO7jhAnw-1; Mon, 29 Dec 2025 11:39:27 -0500
X-MC-Unique: jeq_40GGPt2GYcoO7jhAnw-1
X-Mimecast-MFC-AGG-ID: jeq_40GGPt2GYcoO7jhAnw_1767026367
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-8c2a3a614b5so48506285a.0
 for <qemu-devel@nongnu.org>; Mon, 29 Dec 2025 08:39:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1767026367; x=1767631167; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=6Vv0kzW/OBZtkZeFJwtFPl861a0tnJnouUTswpexiN0=;
 b=TA7Jwb2BcYA0ELfyGGzJvm5CA1QkadPUSGD0LEJesPSkkguVq5ZBHCQgTF4RuGaWKB
 FG45v1VMJ4uSeDDkbug30XfMI1YQWTSEgFP1C+4IYLLLOnGSO/dOAEGHBGy3vaoO2VlC
 uXpevO9+P7yvvzlUA9g2EPxP/d8z2ZNCdQUAVabcCEjsFDRNBOG+5BAjs0grAG/CKPFl
 yV6RYMduzDbv15roSYfEfNIMMURxdYLk9Q/ZZyCUk8pleqZuoxPIxI1cVQ17nOCRxeT+
 OWiwFBdzemshHA7fHjrYFKNFVbyv3kDgF9qAhXpOxQLArU5Rc1GnkTFFehaPvpWw+JqD
 hziw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1767026367; x=1767631167;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=6Vv0kzW/OBZtkZeFJwtFPl861a0tnJnouUTswpexiN0=;
 b=ie+y1o0DDn7Kord2YB2VRYRXJAtFxo+bIk0SDbJihvFNxOukuQ6yGbghfU3jKx2npS
 ODgmewq0kDgk4hqQOMHsSW8cNcn/tYMY9rVR27At/p3cIHOQJJ7xuxgAP38l25oCeKmv
 kwYZzlvplVxMS5clYOh4Lfs7tdSxyWReLelcoXiH65rJmempmbvQGcFxHritfCOqb++G
 uWegd+U6cpPsiDMzC62flEQMOEBgANJfCyvpJJ0UWxYq/HV8JHylPDsJ7mHvGKPn7T4H
 Cg25VkwtlVB5crcXx/dlK2013Jv1FP1LvQRd3XWUTkoiP95SyiB3pO5LpLPe3rSwh05o
 LsJA==
X-Gm-Message-State: AOJu0Yy7r70pL2niT3yqzo4fiFjkqO40qkaE19hHsi1PKWIVjX6arxOf
 JMebT506PGzNPE8d+DUOXWKoGN84K1n8stYdgads2V29HyJ1x86sZ7jS7fTZrwPZ9ieNzAk1TmN
 c8VuyWPmmRqFKMD+N4btZzJ4CxYrmzJ9l4v89dw11UZMunmIsKCYHwzkM
X-Gm-Gg: AY/fxX7ggH8EkmV1PNER9gbtLShF1XjlukP5kTYFf/oyVHXknJL4R2Q/mbnMsrn31ww
 yIifyYj9U27A1wPc4X+eISe1Kf4LDq266vSF1NhQO1SPxlzjSKNrIROYEjxrxaoQRpMAnW+4RQ8
 BghuFP+BtUof0oZI30/4WmucMrGdvjPmRZCl3meWCwhMRpvkSDRplrtnwuwufoIHexMEs/oZFrL
 lvPaHQHQNSmaLTfDuZaDOjPJLmybnD8fFc5cCa8wWZP4ZvU8Hige7knE/QsEzmypj5dLFA1qapY
 L8GjW+UwqWrKGiDAFU4eg+yBeOPGTixwpB4zBT5D9nLkzf73BC5YTkcHspC9EewMTevIEvk3WvW
 xS6Y=
X-Received: by 2002:a05:620a:4686:b0:891:e10a:9d3f with SMTP id
 af79cd13be357-8c08fc0e898mr4145764885a.10.1767026366864; 
 Mon, 29 Dec 2025 08:39:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGbvyjUPMjIjS+EXl1cWez40BimhqYGu3VdCQIgMy9LHr8NUXbRcqP4sjoUQWNl6au5UKWEEQ==
X-Received: by 2002:a05:620a:4686:b0:891:e10a:9d3f with SMTP id
 af79cd13be357-8c08fc0e898mr4145761385a.10.1767026366368; 
 Mon, 29 Dec 2025 08:39:26 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c0971ee182sm2392772185a.33.2025.12.29.08.39.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Dec 2025 08:39:26 -0800 (PST)
Date: Mon, 29 Dec 2025 11:39:25 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 08/25] migration: Free the error earlier in the
 resume case'
Message-ID: <aVKuvS54yhtAY0Is@x1.local>
References: <20251226211930.27565-1-farosas@suse.de>
 <20251226211930.27565-9-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251226211930.27565-9-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
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

On Fri, Dec 26, 2025 at 06:19:10PM -0300, Fabiano Rosas wrote:
> Freeing the error at migration_connect() is redundant in the normal
> migration case. The freeing already happened at migrate_init():
> 
> qmp_migrate()
> -> migrate_prepare()
>    -> migrate_init()
> -> qmp_migrate_finish()
>    -> *_start_outgoing_migration()
>    -> migration_channel_connect()
>       -> migration_connect()
> 
> For the resume case, migrate_prepare() returns early and doesn't reach
> migrate_init(). Move the extra migrate_error_free() call to
> migrate_prepare() along with the resume check.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

We could also use migrate_error_free() in migrate_init(), to be clear on
when the error can be erased.

> ---
>  migration/migration.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 4b1afcab24..a56f8fb05e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2088,6 +2088,13 @@ static bool migrate_prepare(MigrationState *s, bool resume, Error **errp)
>          migrate_set_state(&s->state, MIGRATION_STATUS_POSTCOPY_PAUSED,
>                            MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>  
> +        /*
> +         * If there's a previous error, free it and prepare for
> +         * another one. For the non-resume case, this happens at
> +         * migrate_init() below.
> +         */
> +        migrate_error_free(s);
> +
>          /* This is a resume, skip init status */
>          return true;
>      }
> @@ -4016,13 +4023,6 @@ void migration_connect(MigrationState *s, Error *error_in)
>      bool resume = (s->state == MIGRATION_STATUS_POSTCOPY_RECOVER_SETUP);
>      int ret;
>  
> -    /*
> -     * If there's a previous error, free it and prepare for another one.
> -     * Meanwhile if migration completes successfully, there won't have an error
> -     * dumped when calling migration_cleanup().
> -     */
> -    migrate_error_free(s);
> -
>      s->expected_downtime = migrate_downtime_limit();
>      if (error_in) {
>          migration_connect_error_propagate(s, error_in);
> -- 
> 2.51.0
> 

-- 
Peter Xu


