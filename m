Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A786C2D0CD
	for <qemu-devel@archiver.kernel.org>; Wed, 21 May 2025 13:32:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uHjXX-0001KR-Ir; Wed, 21 May 2025 09:31:23 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHjXO-0001Hn-Cj
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:31:16 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uHjXJ-0003yN-Dd
 for qemu-devel@nongnu.org; Wed, 21 May 2025 09:31:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1747834265;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OJowd7GTAuSCrO4HpnLcLT1VaIPJBL9Vwplpc8VZE+U=;
 b=Stkqvz42h0A4kD83HdsBm2jFITPTgbZkcCycvTr9iaWjodETLA7zztMijELZCPNlIHdsTy
 dns2CE4bt9KMRf70ZPX11kBMmGfLEg5auPf/E0GuWpK+Jj1fLRfZnplIVwp11sYL0osmb0
 3YYzutWLzaLTQMJdBpnac8nYfXa2lQg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-Frk47T0gOVGofT2KfUAe3w-1; Wed, 21 May 2025 09:31:04 -0400
X-MC-Unique: Frk47T0gOVGofT2KfUAe3w-1
X-Mimecast-MFC-AGG-ID: Frk47T0gOVGofT2KfUAe3w_1747834264
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6f8df8d4585so53203606d6.3
 for <qemu-devel@nongnu.org>; Wed, 21 May 2025 06:31:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1747834263; x=1748439063;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OJowd7GTAuSCrO4HpnLcLT1VaIPJBL9Vwplpc8VZE+U=;
 b=oN+u0zfErPoHyX8GddOL9m5RPJiqBfe93SKAL+F0C5JWMym2LiInwvb8ku+REr8fwp
 KBWMUz2hRWgcG9K2d39zmNNHr5mQwiOw7EaGvJuU8fdCZcocFpmeD4qVaCSzeTl0lOhP
 6DZzgCsFKajdAzb8mI6SksEN7t5Bj66/MGN99Fpi1t4pud3yfBFogUOUTrYvduZ5rJVQ
 qi4Dr6PEg8hyeI0CmGhe7+zCdctwE4W8M4ZVooxl9852uuMttT9fLCL67r4pXtpFESCY
 U8DwY8e2FjUiYRBBPRS0WmeY8wm/9suYT1jtDaK8uAsLLLHp5Gy3itBjvgzSk1ZQV2AX
 7ysg==
X-Gm-Message-State: AOJu0YxQyKbbz7wPNJxMHjVoKUj2UT46fJkbrVtrUNZmQIjNtwF96jf1
 mUZYNtDDT/vR0Uui/HObnprhwnul88fOR1JoC8c+F6pMFbvxR093UwmZZqTgwI8U9wHEH3ayqSd
 PSL7yId/BX2Yy6BVEchd3VYJQHNJ+BiGEBWMiwdpxSWMSV5A8BiGDnFqdEvSomzvQ
X-Gm-Gg: ASbGncsXkHz7EASmJ/dXY3SMcL4ZhVZfVb5fjVTGSc0PqL2Qs5UkF2MY0lVB6jGONdn
 kVnbaNHNsLcNEHculh3rJI+SkIaleJ1RPiPIATI2q/nKr2rXfQWY/8W7L0VKtqzwsS0vNhGeMFs
 YtAWOhkGdhevvI0R5eWu6LK4YgSKSL0p+2/efXSConxfmvSa3TvABQg/RKoBsOpveVz7gDe5j9R
 0DjrOdAJl3UploFvypb+/vb5NReEz9NZHG0vqsrZzva51se7YuCgxDWxvD8//xWIaBkNGPXZ6hg
 OK8=
X-Received: by 2002:a05:6214:1c09:b0:6f8:9b78:1bf6 with SMTP id
 6a1803df08f44-6f8b087095fmr339857246d6.18.1747834263133; 
 Wed, 21 May 2025 06:31:03 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHgh//1KdFPt1LVZDqBM0u2hmPPA1CWEF3vwA+viNE7W8qX+2eAQPDW7dp5cd9rZwfkN0MgwA==
X-Received: by 2002:a05:6214:1c09:b0:6f8:9b78:1bf6 with SMTP id
 6a1803df08f44-6f8b087095fmr339856876d6.18.1747834262619; 
 Wed, 21 May 2025 06:31:02 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6f8b0883ed6sm84930876d6.18.2025.05.21.06.31.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 May 2025 06:31:02 -0700 (PDT)
Date: Wed, 21 May 2025 09:31:00 -0400
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, devel@lists.libvirt.org,
 Fabiano Rosas <farosas@suse.de>
Subject: Re: [PATCH 2/4] qapi/migration: Deprecate migrate argument @detach
Message-ID: <aC3VlBLa0nmaXNLW@x1.local>
References: <20250521063711.29840-1-armbru@redhat.com>
 <20250521063711.29840-3-armbru@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250521063711.29840-3-armbru@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -22
X-Spam_score: -2.3
X-Spam_bar: --
X-Spam_report: (-2.3 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.184,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, May 21, 2025 at 08:37:09AM +0200, Markus Armbruster wrote:
> Argument @detach has always been ignored.  Start the clock to get rid
> of it.
> 
> Cc: Peter Xu <peterx@redhat.com>
> Cc: Fabiano Rosas <farosas@suse.de>
> Signed-off-by: Markus Armbruster <armbru@redhat.com>
> ---
>  docs/about/deprecated.rst |  5 +++++
>  qapi/migration.json       | 18 +++++++++---------
>  2 files changed, 14 insertions(+), 9 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 9665bc6fcf..ef4ea84e69 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -179,6 +179,11 @@ Use ``job-dismiss`` instead.
>  
>  Use ``job-finalize`` instead.
>  
> +``migrate`` argument ``detach`` (since 10.1)
> +''''''''''''''''''''''''''''''''''''''''''''
> +
> +This argument has always been ignored.
> +
>  ``query-migrationthreads`` (since 9.2)
>  ''''''''''''''''''''''''''''''''''''''
>  
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 8b9c53595c..ecd266f98e 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -1660,6 +1660,10 @@
>  #
>  # @resume: resume one paused migration, default "off".  (since 3.0)
>  #
> +# Features:
> +#
> +# @deprecated: Argument @detach is deprecated.
> +#
>  # Since: 0.14
>  #
>  # .. admonition:: Notes
> @@ -1668,19 +1672,14 @@
>  #        migration's progress and final result (this information is
>  #        provided by the 'status' member).
>  #
> -#     2. All boolean arguments default to false.

There's one more boolean ("resume") exists, but probably not a huge
deal.. All booleans if not mentioned should have a default-false semantics
at least to me.

Reviewed-by: Peter Xu <peterx@redhat.com>

> -#
> -#     3. The user Monitor's "detach" argument is invalid in QMP and
> -#        should not be used.
> -#
> -#     4. The uri argument should have the Uniform Resource Identifier
> +#     2. The uri argument should have the Uniform Resource Identifier
>  #        of default destination VM.  This connection will be bound to
>  #        default network.
>  #
> -#     5. For now, number of migration streams is restricted to one,
> +#     3. For now, number of migration streams is restricted to one,
>  #        i.e. number of items in 'channels' list is just 1.
>  #
> -#     6. The 'uri' and 'channels' arguments are mutually exclusive;
> +#     4. The 'uri' and 'channels' arguments are mutually exclusive;
>  #        exactly one of the two should be present.
>  #
>  # .. qmp-example::
> @@ -1724,7 +1723,8 @@
>  { 'command': 'migrate',
>    'data': {'*uri': 'str',
>             '*channels': [ 'MigrationChannel' ],
> -           '*detach': 'bool', '*resume': 'bool' } }
> +           '*detach': { 'type': 'bool', 'features': [ 'deprecated' ] },
> +           '*resume': 'bool' } }
>  
>  ##
>  # @migrate-incoming:
> -- 
> 2.48.1
> 

-- 
Peter Xu


