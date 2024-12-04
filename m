Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2A1CE7716B
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 14:51:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIqhm-000619-Kg; Wed, 04 Dec 2024 09:50:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIqhh-00060g-Ki
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 09:50:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIqhd-0005aE-8m
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 09:50:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733323804;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=cdNya+dxsSaFIBcHJAC6hs4tkQgQ6Qg8tsesH+Cc3Ms=;
 b=RtZ8KSunQnhG/UHB+6Ox2vZVM7PZLequRBc/yf/OAUUiNJ8AuF8obhvpOPlF4w64GbaotZ
 QJWD/7vj0xPaUpwFlT8bk64KEnpED5FeW+FLGRf8MwkdEn8f29DBxN28jop896KLTzS6x+
 6lXG+5XhIamjdxGrq/McaLeOchDdBLE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-257-rLushrUTMX2nGZvwtRrd_Q-1; Wed, 04 Dec 2024 09:50:00 -0500
X-MC-Unique: rLushrUTMX2nGZvwtRrd_Q-1
X-Mimecast-MFC-AGG-ID: rLushrUTMX2nGZvwtRrd_Q
Received: by mail-oi1-f197.google.com with SMTP id
 5614622812f47-3ea4cd22faaso4804192b6e.2
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 06:50:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733323799; x=1733928599;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=cdNya+dxsSaFIBcHJAC6hs4tkQgQ6Qg8tsesH+Cc3Ms=;
 b=XqFo449y3vj0JWz55mPgzRk4j2hyFicovHCZJbb+kmbXXFR2grX1IEmevxIiD/d3J4
 dEPhOfvWCJdreaY3kb1oC0yJHhBb2VLj2U1clZV2ZSNuOZAd+we9HICApbVlZ9OUBJXi
 7LMmMZMkP338ekoLWaIJ0AV5U/XNH2crWN/Oq+bW2njgnFIaLwTnFa07h60bjOdEcBZI
 FJKS1kylyRuVXpvEdmBRrHgaTtltNLvwUT+rl5nQ0JL04SsJQz0Afh8jDn+mKXHM6tKL
 4urwmQ7+gGCbeUMWxl1wB0N0Sy+qotnknvLR+cvjlykN5afddOQ5k5cVTwlViPv3Vaxv
 0cuw==
X-Gm-Message-State: AOJu0YwY9a+cmi4QOuuC68XUPRM9n/QK6/sNArseGv+e8eCxBk6Vhu4I
 GmqxnHAYKvVq5JpS1MmV3+mwlyJWyc/ioqAV3quni83fgXpfU+kugtUc0nJzXR5gGxkrXXZ6twE
 9M17ojd+bQeTBBfs0B9b5gjX8LbkPvV7B2OMKi2WAtSuyKSRmfpuborak2cAxqIX9swZODN8vb/
 32JyILtWjXp7Gw14M5voxiRV6yBdP0zL0yPQ==
X-Gm-Gg: ASbGnctGqwtf6YZ9MlFkvrnLlhAs6YbexjGSFaZL2wHniZSwr7lQlqa2Qi5Ha/76bj8
 EJvoUPK9MIgjNainfOZF8AVBTjZOuQ7WxcnbCicYXa0VquLqnRIZe052+Rid5SXVzAChYwEBysX
 4ZdDmoODBOISYwx7BtuVLo6hLpyiOYWfmLukxGsDBZW7Uu7SieBJydX0Tx4Mr3rrtcvTVMsPUS8
 8xQ51p4P1RoAHCT7EzixV0B0F/9V8MZbDZ9a0y/bz/es5fYh2SCP7+8LMOf69/JlufUF7CgwHMk
 IeujKF9daHU=
X-Received: by 2002:a05:6808:3095:b0:3ea:6785:2e3a with SMTP id
 5614622812f47-3eae4f3b7e3mr7413087b6e.18.1733323799293; 
 Wed, 04 Dec 2024 06:49:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQ89brgNFafgamWJtglOpzfhBCjx2q1a7+FkS+VKc3SiTW13Q57ijfmNSVckuuopuJyBCiRA==
X-Received: by 2002:a05:6808:3095:b0:3ea:6785:2e3a with SMTP id
 5614622812f47-3eae4f3b7e3mr7412932b6e.18.1733323797440; 
 Wed, 04 Dec 2024 06:49:57 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6d875195b55sm74205216d6.62.2024.12.04.06.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 06:49:57 -0800 (PST)
Date: Wed, 4 Dec 2024 09:49:55 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: qemu-block@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 Eric Blake <eblake@redhat.com>, Kevin Wolf <kwolf@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Andrey Drobyshev <andrey.drobyshev@virtuozzo.com>,
 Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH RFC 06/11] migration/block: Extend the migration_block_*
 API to dest side
Message-ID: <Z1BsE6AggPtkSGvC@x1n>
References: <20241204005138.702289-1-peterx@redhat.com>
 <20241204005138.702289-7-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241204005138.702289-7-peterx@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
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

On Tue, Dec 03, 2024 at 07:51:33PM -0500, Peter Xu wrote:
> diff --git a/migration/migration.c b/migration/migration.c
> index 8f7d09ca84..e01264168f 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -701,6 +701,12 @@ migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
>          return false;
>      }
>  
> +    /*
> +     * Newly setup QEMU, prepared for incoming migration.  Mark the block
> +     * active state to reflect that the src currently owns the disks.
> +     */
> +    migrate_get_current()->block_active = false;
> +
>      migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
>      return true;
>  }

I plan to move this over to the end of qmp_migrate_incoming(), which might
be easier to follow (where we updated "once"..), to say that we initialize
the value to FALSE once and for all for an incoming instance.

I don't think there's any functional change on the fixup.  The only
difference is when qemu_start_incoming_migration() can fail after
migration_incoming_state_setup().  I don't think it matter hugely on the
block_active flag itself.. as if that failure happens it means the next
qmp_migrate_incoming will overwrite the flag again with nobody being able
to touch it..  But still, if I'll post a new version I'll squash below into
this patch:

===8<===
diff --git a/migration/migration.c b/migration/migration.c
index 1a1c570c5b..bc3a29482a 100644
--- a/migration/migration.c
+++ b/migration/migration.c
@@ -701,12 +701,6 @@ migration_incoming_state_setup(MigrationIncomingState *mis, Error **errp)
         return false;
     }
 
-    /*
-     * Newly setup QEMU, prepared for incoming migration.  Mark the block
-     * active state to reflect that the src currently owns the disks.
-     */
-    migrate_get_current()->block_active = false;
-
     migrate_set_state(&mis->state, current, MIGRATION_STATUS_SETUP);
     return true;
 }
@@ -1892,6 +1886,12 @@ void qmp_migrate_incoming(const char *uri, bool has_channels,
         return;
     }
 
+    /*
+     * Newly setup incoming QEMU.  Mark the block active state to reflect
+     * that the src currently owns the disks.
+     */
+    migrate_get_current()->block_active = false;
+
     once = false;
 }

-- 
Peter Xu


