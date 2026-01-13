Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 68356D2D0E4
	for <qemu-devel@archiver.kernel.org>; Tue, 13 Jan 2026 12:33:56 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vfdae-0008QC-Cj; Tue, 13 Jan 2026 07:33:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfdaZ-0008PM-70
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:33:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <ppandit@redhat.com>)
 id 1vfdaX-0005Yw-JZ
 for qemu-devel@nongnu.org; Tue, 13 Jan 2026 07:33:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768307612;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ufj9mX4Nvm4IBsEydu80SvMYJVeXfWlIGqVCC5v223Q=;
 b=TyqULEoa92kpbuROYbnwyWwg6zAmnVGSn/eN/51DNqVJcolW5YiyVOEFVt7gCPEcJFxmIS
 iE9gyCKSxdj0Cs9eyWi6qlewc1BmjlrcfqqzkvVMACwSRPvCtIDJcKVTunjtioypLIX3Rj
 +pC8vfeJvGFjW9/RPE0A08Y9bxAJgNM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-pUHZTzERN7OmHcO1OOtHZg-1; Tue, 13 Jan 2026 07:33:30 -0500
X-MC-Unique: pUHZTzERN7OmHcO1OOtHZg-1
X-Mimecast-MFC-AGG-ID: pUHZTzERN7OmHcO1OOtHZg_1768307610
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-477771366cbso57891625e9.0
 for <qemu-devel@nongnu.org>; Tue, 13 Jan 2026 04:33:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768307609; x=1768912409; darn=nongnu.org;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=Ufj9mX4Nvm4IBsEydu80SvMYJVeXfWlIGqVCC5v223Q=;
 b=Xqdjyl57IZmQ56SbLMUdLRmqVoTWEg2m+CpS5FqipdCEqXUX0CdQqjLCbcYXsgOir2
 h6EVB55HakZZENeIyS2X1nF2+3mAKbwF2U2EwfeDNxJQ9NNVsEPH/ETGsfSDz1quR7EI
 /im6qdu5urxrZyfTPkukpRBlltl5XqKAY3eGZRdTLT4I8BuMvhoPi025BlSzRkI/cGrA
 MZ2jYw55WP0Cb/ht/pqdQBSF60ny504g4eStK0TleF093c5MUD5LX/SfSb3Ydlx4rNZN
 yEF4P2us13ekHoSobEJ65eIAwNyAL6YdDQo+Tvw5oeVEzo/Dtb4uZXbgN4sRSoeXm8Q6
 +r6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768307609; x=1768912409;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ufj9mX4Nvm4IBsEydu80SvMYJVeXfWlIGqVCC5v223Q=;
 b=H6dL+qVdyzKDsnEq2PM7oH8mVSs4BCab3ry5UvfcoW+18G2tfZxOyNRu4ZO8XHUv/2
 7gki2ibjgGohgwq8fl/S3doHECYpnQ/qjmtoXHWzt4KBgqijEyV5+1qlDkL6D8LSoXqe
 OL+/QmJJsEHWgQdBOLEFwp/h3C/9/Wpmh9ZEV/84k0jwOM+ew1JSJ699R/cblhjCEYQr
 XwFAqWQxzu2iWmLuzTv0dDfUWOkQMgbSup5BsGEzbxFjXYK8WMAJl2xdCyW+ZUx5sQI7
 4LFQPmSAMVpqdYOqNV+kwHBuU5UXx3rJYHLdS/ByGDYZHWAvvCywAcdtdWQGVa5tYIrD
 u4Xw==
X-Gm-Message-State: AOJu0YzdokoiO9mxjHUsbQWfh+xlldrq3zmpqJkeLX+P9hgPrrdgcpp7
 sBdY7SrCACg/aa/kQoDQ4wKrZMEFaeT2k7qjuZDstomQ0Lm+0vygQfkzHDxyt5tWEgajazgd615
 zYRmyARzNgxUJS+s+vXamwur1TpJyLYzTQbdNeKrLoGWgGSvDxopaOtMY2tJALjZMzu0Z+dWqpG
 7jEtko0O3Rn9xQg/JL2mmwJNk7xnUKgk8=
X-Gm-Gg: AY/fxX6GaVuG42uiIvk9J9MKx6BlUiq4NPwIlNKWDmUcFyGqfW2CBqgB1hMpC/2sNuA
 jg3eib3qsfX3mslktHHQpqm3eJ20VDEJe0HTG/dj7F/nTCeyzm3qykj11DpruUD+tWDNSzqkdPd
 O4yGVLnrMHd3aGhlk5m0sXR208UfF6S7EYaLHJWmHEDFUUe3/lGrHQ2kmLzs75Uxyd9Lyaclg+8
 w+vcKeGQBpbhjJfYrZ8Eazc8ZUExM0X4MHlmAaG/VNx0aU59DawSKTj
X-Received: by 2002:a05:600c:3493:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-47d84b3471fmr249241605e9.17.1768307609613; 
 Tue, 13 Jan 2026 04:33:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH2z0Vkt4H0+IaS1wCwLtq6S/b+Dy9gfs53V6fgtqvPOPGhMe3H7GjjW0R6dob2zd5AMKZTm2i534C67YQpX2I=
X-Received: by 2002:a05:600c:3493:b0:477:333a:f71f with SMTP id
 5b1f17b1804b1-47d84b3471fmr249241305e9.17.1768307609251; Tue, 13 Jan 2026
 04:33:29 -0800 (PST)
MIME-Version: 1.0
References: <20260109124043.25019-1-farosas@suse.de>
 <20260109124043.25019-2-farosas@suse.de>
In-Reply-To: <20260109124043.25019-2-farosas@suse.de>
From: Prasad Pandit <ppandit@redhat.com>
Date: Tue, 13 Jan 2026 18:03:12 +0530
X-Gm-Features: AZwV_QhkFxHWRNj0S0Tsxmgwy6ONa1ed6r9jfBS2nNlC3u3Gu7ZoAnHVWy5PfSk
Message-ID: <CAE8KmOwVC=ncz3mriwrwXT_AAxxCBbkR2gYLskBNCKN12x71Xw@mail.gmail.com>
Subject: Re: [PATCH v3 01/25] migration: Remove redundant state change
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, peterx@redhat.com, berrange@redhat.com
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

On Fri, 9 Jan 2026 at 18:11, Fabiano Rosas <farosas@suse.de> wrote:
> If local_err is set, migration_connect_error_propagate() will be
> called and that function already has a state transtion from SETUP to
> FAILED.

* transtion -> transition.

> diff --git a/migration/migration.c b/migration/migration.c
> index 9d1bf5d276..c45393f40e 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -2326,8 +2326,6 @@ static void qmp_migrate_finish(MigrationAddress *addr, bool resume_requested,
>          file_start_outgoing_migration(s, &addr->u.file, &local_err);
>      } else {
>          error_setg(&local_err, "uri is not a valid migration protocol");
> -        migrate_set_state(&s->state, MIGRATION_STATUS_SETUP,
> -                          MIGRATION_STATUS_FAILED);
>      }

* Maybe we could remove this last '} else {' block altogether? The
'addr->transport == ' check could be moved to the
migrate_transport_compatible() function (OR near there), which is
called after addr = channel->addr.

* Saying that - "uri is invalid" - in qmp_migrate_finish() raises a
question - how did we reach till _migrate_finish() if uri was invalid?
Is qmp_migrate_finish() called by libvirtd(8) OR external users via
QMP? If not, if it is an internal only function to just start
migration, it could be renamed appropriately without qmp_ prefix -
migrate_start() OR begin_migration() something to the effect that says
it starts migration, rather than finish it. migrate_finish() function
calling  *_start_outgoing_migration() reads contradictory/opposite.

(I'm going through the rest of the patches in this series.)

Thank you.
---
  - Prasad


