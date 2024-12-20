Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B15A6E7718B
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Dec 2024 16:32:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tOfuw-0001yl-ME; Fri, 20 Dec 2024 11:31:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOfuu-0001yW-W7
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:31:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tOfut-0002kn-Ln
 for qemu-devel@nongnu.org; Fri, 20 Dec 2024 11:31:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1734712310;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8bgs5wnVXI5C5pnXBZted1q3mpL09HY25i04ZJKomDk=;
 b=BzzlXte8SLMaRJKf1I4YfEWNrV+5nVd+oP+124v3t33a2ndb/wjt46ZoqLF9ChY4NutSIp
 3ePQmgPIacAsEnDF/FZGNfUOmqyWFQTIXJ/9NJ88bXTD3AKav07R3ftWSRQnKSZ0ZUzMoZ
 5u3i/6DH666HlSUh63HYKX3LhJVoWTg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-562-mGOjQ0-UMgyD6E2E_8oTGQ-1; Fri, 20 Dec 2024 11:31:47 -0500
X-MC-Unique: mGOjQ0-UMgyD6E2E_8oTGQ-1
X-Mimecast-MFC-AGG-ID: mGOjQ0-UMgyD6E2E_8oTGQ
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-6d8f6b89dcdso36362416d6.3
 for <qemu-devel@nongnu.org>; Fri, 20 Dec 2024 08:31:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1734712306; x=1735317106;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8bgs5wnVXI5C5pnXBZted1q3mpL09HY25i04ZJKomDk=;
 b=Z3D5JUqMpRg9NS28IXmba4STcviBJqyM80tfIgomVk6gOXzFlt2UQ/4D9sqZb9pSaA
 wFRt4TiUSDzx9q9m10p0Gmcwm6TfmC8Dkog7G6jhvmNTpzK+0TOa92iecik2zqhJG/m4
 R96E5sxVfTai54IBPVVKCPcIfcTWoMxBrfAeopFmbLGRitjPX5xyQ1e+Cgpq43uz6lVb
 ClrAdMdcT/j0o0nSWjhD86WbyRt0Qu/IsaYyEJatuw7MYkodhV8o6ov9lRnY1B9OFkrc
 qOzLKQedt6UD4yUu4WBB7Z9a15gznmDefauEeCf5RwQQaFFEL8/8hJ1/CtCRCVCdkFSq
 +VFw==
X-Gm-Message-State: AOJu0Yz5/5PRVzNhOyyR5h0ywvavCj41DRfltTB0pAwd+a9PODOqHe6M
 tFpK5tAAmLcGZxMGGkbdw2TWb/IGsW9+atawbgKmrSaLBfMLBnPTPNjGklTd75bzo1jZKsN4uM/
 eQ3vdtEyqZGt5Goqn+HIX/Gf1BBnACMeEIa+7jYyT8nOQZCVIRmOf
X-Gm-Gg: ASbGncuzQDevLyjSwX7xVyWMLH2rgWqZXKoXsYm2PcrIPewQkyvPoofDROhSi60Ht4I
 T5SEPGffLdX3hkXx7gnAPbjN4t5NydItopXU9Y5Ytp/etdV/cSCXiICcfBRkOv+t6C0GiFoWm5+
 PGyks7HC+HUgPCFh2/iMVGwAZuc5mBlKV4w7QLABY3eadMmfTumFqMJRYDdfhKIu078zGWsAAO1
 RuDZGQpOXVAApCMs2x2ITMDK2TXj9Co05Upap/7ILammMZnipV2H0SjJ4bR1i06f2ee4nn/9kXe
 sl1JWPZVDxphrluU2g==
X-Received: by 2002:a05:6214:4014:b0:6d8:ab3c:5c8 with SMTP id
 6a1803df08f44-6dd233b83e8mr59775786d6.49.1734712306204; 
 Fri, 20 Dec 2024 08:31:46 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGqZiBIDxYA+EC7+4I9zqTeKqUmBMaXRyVrWSgq/IlU072ihAzJ+qp/FOggyJGNYAQNyyBzpw==
X-Received: by 2002:a05:6214:4014:b0:6d8:ab3c:5c8 with SMTP id
 6a1803df08f44-6dd233b83e8mr59775186d6.49.1734712305813; 
 Fri, 20 Dec 2024 08:31:45 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6dd22f025ebsm9666026d6.82.2024.12.20.08.31.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Dec 2024 08:31:45 -0800 (PST)
Date: Fri, 20 Dec 2024 11:31:41 -0500
From: Peter Xu <peterx@redhat.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: qemu-devel@nongnu.org, qemu-block@nongnu.org,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Kevin Wolf <kwolf@redhat.com>, Hanna Reitz <hreitz@redhat.com>,
 Pavel Dovgalyuk <pavel.dovgaluk@ispras.ru>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Fam Zheng <fam@euphon.net>,
 Ronnie Sahlberg <ronniesahlberg@gmail.com>,
 John Snow <jsnow@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Fabiano Rosas <farosas@suse.de>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>
Subject: Re: [PATCH 01/17] replay: Fix migration use of clock for statistics
Message-ID: <Z2Wb7T8oH0xbk576@x1n>
References: <20241220104220.2007786-1-npiggin@gmail.com>
 <20241220104220.2007786-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241220104220.2007786-2-npiggin@gmail.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -31
X-Spam_score: -3.2
X-Spam_bar: ---
X-Spam_report: (-3.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-1.129,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Fri, Dec 20, 2024 at 08:42:03PM +1000, Nicholas Piggin wrote:
> Migration reads CLOCK_HOST when not holding the replay_mutex, which
> asserts when recording a trace. These are not guest visible so should
> be CLOCK_REALTIME like other statistics in MigrationState, which do
> not require the replay_mutex.

Irrelevant of the change, should we document such lock implications in
timer.h?

> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  migration/migration.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index 8c5bd0a75c8..2eb9e50a263 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -3433,7 +3433,7 @@ static void *migration_thread(void *opaque)
>  {
>      MigrationState *s = opaque;
>      MigrationThread *thread = NULL;
> -    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    int64_t setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      MigThrError thr_error;
>      bool urgent = false;
>      Error *local_err = NULL;
> @@ -3504,7 +3504,7 @@ static void *migration_thread(void *opaque)
>          goto out;
>      }
>  
> -    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
>  
>      trace_migration_thread_setup_complete();
>  
> @@ -3584,7 +3584,7 @@ static void *bg_migration_thread(void *opaque)
>  
>      migration_rate_set(RATE_LIMIT_DISABLED);
>  
> -    setup_start = qemu_clock_get_ms(QEMU_CLOCK_HOST);
> +    setup_start = qemu_clock_get_ms(QEMU_CLOCK_REALTIME);
>      /*
>       * We want to save vmstate for the moment when migration has been
>       * initiated but also we want to save RAM content while VM is running.
> @@ -3629,7 +3629,7 @@ static void *bg_migration_thread(void *opaque)
>          goto fail_setup;
>      }
>  
> -    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_HOST) - setup_start;
> +    s->setup_time = qemu_clock_get_ms(QEMU_CLOCK_REALTIME) - setup_start;
>  
>      trace_migration_thread_setup_complete();
>  
> -- 
> 2.45.2
> 

-- 
Peter Xu


