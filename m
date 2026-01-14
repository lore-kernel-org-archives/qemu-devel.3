Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47986D39011
	for <qemu-devel@archiver.kernel.org>; Wed, 14 Jan 2026 20:13:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vg7Dy-0005Zc-3V; Wed, 14 Jan 2026 15:12:14 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg7Dv-0005Uj-Uw
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 15:12:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vg7Du-0004Hj-2h
 for qemu-devel@nongnu.org; Wed, 14 Jan 2026 15:12:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768421527;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bPPoU7prOgWqNj7Xk4sAHVwSsSiXtEoBQbN02gN5Ytc=;
 b=XdNFZkyp1Qi7zWPWWAxu+ai7E8103cDENtT7DFSfX9G5VY+L/s351p8nqt6CetvwmrDb9y
 SIM+pMHCA0EGjB524ZJjkj+NEABaxS6h4pobnmZTTKfUurDsDlEv6P+uATLWkfnqIWcgQC
 HyFV0PPg9PvTIipuQpiFngaX0v+xF44=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-yI-uODIxP4yEoYbxBu9ZjQ-1; Wed, 14 Jan 2026 15:12:06 -0500
X-MC-Unique: yI-uODIxP4yEoYbxBu9ZjQ-1
X-Mimecast-MFC-AGG-ID: yI-uODIxP4yEoYbxBu9ZjQ_1768421525
Received: by mail-vs1-f72.google.com with SMTP id
 ada2fe7eead31-5eb810c80c4so4066871137.0
 for <qemu-devel@nongnu.org>; Wed, 14 Jan 2026 12:12:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768421525; x=1769026325; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:from:to
 :cc:subject:date:message-id:reply-to;
 bh=bPPoU7prOgWqNj7Xk4sAHVwSsSiXtEoBQbN02gN5Ytc=;
 b=JJrYV7l+8n5W19Ji0fiej7XPphCMA0W6t1u9Xw/wUtUps0RolIYx1+3ZbTIN2QTgO7
 edkfJ2++3fDV11meoHPOxfynHHN0TYGIfkxY9T7d7VbHi5LHsztqCf2uZapHhJTBnRWn
 Aa/f48Psj8OgJ/CcuK7VIypMmZvL2MkvNvAuguyaHiVxPM83HRWRaD553jks+XAVmklc
 kjl1TeCPs/EVRyAHpALvQPRD3s8jXBG2sYrO9y1edfINphzpm0txmJ8FVb0CQxH8ILFL
 LwSynIY2AaGwW+fWXtLpJChMEt/7P5dARopaJebsJwHlw4ORMiJdIbKvcKEbfgYkcuUq
 8Ssw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768421525; x=1769026325;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=bPPoU7prOgWqNj7Xk4sAHVwSsSiXtEoBQbN02gN5Ytc=;
 b=QUnj6u6Y9a8kk+IFbdkgfMKlZHjjeT3mG3Lc51+QQ41zQYmUO08Wc5MnsdGJGFcZqB
 ZXhatjsdY+9VJ9Jv7yp98bMaKUqODduG2ZD/ag+zdT3lT/jYlUVfR5s3FFOVQG6wkv4A
 MK8kifSF44VVK+YSN9zQIVU1rDB3HT9LVwEQtaUcba2DyHLzmniyQlg8hiS0+YsncSHV
 tsmMlL31nKXhZ/pzX45dyWkiMJCzEFwTUkIPsFYgAlMi1oKCFfkWfncUY6VPHizr2x05
 u3pf5VwCVHErpsL400Vlm7M2vouhPwHmgCRvEQBZ3VouhinBlMQlB8547EmJ8SmuG9WS
 sUPA==
X-Gm-Message-State: AOJu0Yw5W4P+UIiDr2zGZuhO3OonAymurZXhON1vlemwcS/h7nQwouHD
 x7pQPinzEqzrSaYcuQYmev5KKdrqzMV2C/f5qzFMHwDR4E5vrCvMTYLWG8iNc8KcJStdYwRl68x
 8+ldQVGIelXLY7rT7HFL3Q1xwWcppmEkU9Mk7kWspjIW1aqLNT0J+p1oGl4gN4w88arm+i/S4Ai
 g/uD8L/9bhv2wj5gY+fYufA1jjFxvcE/nshN5FwA==
X-Gm-Gg: AY/fxX5nqKW47D/4mdJhz+405DvEfOxU2IxgIgBIuy6bNYPMsbcYoOqaVxq0ANlA3UY
 ERXwf9n9GtSfXjiSGPLPMfE/BfH16Onv7cqLQ1JJGqHpdJpMPlDlK6GwmsHpn0QQxFQZdog6iMe
 p/kdqdYg1r35OpnQ337CXiJ+/MJzkCrhzYffBQ7KL85iP+Q8pHNkbSzN8ljNEsk4FJ9tgOZYoqG
 450UP7BBsPqmf8cxImHkv9T0Ta6yJ2Gl9F2TO2eZc8fLgjNdW8IKp1NHWEvUxi+YCReC6XE6Kcn
 T52knlVB8a8aWvjSg5he8LRG1EbGijSJvDKJsiVzLSAinoC98TjtvtPv+16XWYu0+gVx+ys3ZOB
 ppIc=
X-Received: by 2002:a05:6102:304b:b0:5ef:a24a:50b5 with SMTP id
 ada2fe7eead31-5f19253ba4amr360174137.18.1768421525014; 
 Wed, 14 Jan 2026 12:12:05 -0800 (PST)
X-Received: by 2002:a05:6102:304b:b0:5ef:a24a:50b5 with SMTP id
 ada2fe7eead31-5f19253ba4amr360148137.18.1768421524445; 
 Wed, 14 Jan 2026 12:12:04 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 a1e0cc1a2514c-944122d3040sm23063638241.4.2026.01.14.12.11.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Jan 2026 12:12:03 -0800 (PST)
Date: Wed, 14 Jan 2026 15:11:55 -0500
From: Peter Xu <peterx@redhat.com>
To: qemu-devel@nongnu.org
Cc: Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>,
 Lukas Straub <lukasstraub2@web.de>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWf4i7EOXtpAljGX@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260114195659.2543649-2-peterx@redhat.com>
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

On Wed, Jan 14, 2026 at 02:56:57PM -0500, Peter Xu wrote:
> COLO was broken for QEMU release 10.0/10.1 without anyone noticed.  One
> reason might be that we don't have an unit test for COLO (which we
> explicitly require now for any new migration feature).  The other reason
> should be that there are just no more active COLO users, at least based on
> the latest development of QEMU.
> 
> I don't remember seeing anything really active in the past few years in
> COLO development.
> 
> Meanwhile, COLO migration framework maintainer (Hailiang Zhang)'s last
> email to qemu-devel is in Dec 2021 where the patch proposed an email
> change (<20211214075424.6920-1-zhanghailiang@xfusion.com>).
> 
> We've discussed this for a while, see latest discussions here (our thoughts
> of deprecating COLO framework might be earlier than that, but still):
> 
> https://lore.kernel.org/r/aQu6bDAA7hnIPg-y@x1.local/
> https://lore.kernel.org/r/20251230-colo_unit_test_multifd-v1-0-f9734bc74c71@web.de
> 
> Let's make it partly official and put COLO into deprecation list.  If
> anyone cares about COLO and is deploying it, please send an email to
> qemu-devel to discuss.
> 
> Otherwise, let's try to save some energy for either maintainers or
> developers who is looking after QEMU. Let's save the work if we don't even
> know what the work is for.
> 
> Cc: Lukáš Doktor <ldoktor@redhat.com>

My apologize, I copied the wrong email.

Cc: Lukas Straub <lukasstraub2@web.de>

> Cc: Juan Quintela <quintela@trasno.org>
> Cc: Dr. David Alan Gilbert <dave@treblig.org>
> Cc: Zhang Chen <zhangckid@gmail.com>
> Cc: zhanghailiang@xfusion.com
> Cc: Li Zhijian <lizhijian@fujitsu.com>
> Cc: Jason Wang <jasowang@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  docs/about/deprecated.rst | 6 ++++++
>  qapi/migration.json       | 5 ++---
>  migration/options.c       | 4 ++++
>  3 files changed, 12 insertions(+), 3 deletions(-)
> 
> diff --git a/docs/about/deprecated.rst b/docs/about/deprecated.rst
> index 7abb3dab59..b499b2acb0 100644
> --- a/docs/about/deprecated.rst
> +++ b/docs/about/deprecated.rst
> @@ -580,3 +580,9 @@ command documentation for details on the ``fdset`` usage.
>  
>  The ``zero-blocks`` capability was part of the block migration which
>  doesn't exist anymore since it was removed in QEMU v9.1.
> +
> +COLO migration framework (since 11.0)
> +'''''''''''''''''''''''''''''''''''''
> +
> +To be removed with no replacement, as the COLO migration framework doesn't
> +seem to have any active user for a while.
> diff --git a/qapi/migration.json b/qapi/migration.json
> index 201dedd982..3c868efe38 100644
> --- a/qapi/migration.json
> +++ b/qapi/migration.json
> @@ -531,8 +531,7 @@
>  #
>  # @unstable: Members @x-colo and @x-ignore-shared are experimental.
>  #
> -# @deprecated: Member @zero-blocks is deprecated as being part of
> -#     block migration which was already removed.
> +# @deprecated: Member @zero-blocks and @x-colo are deprecated.
>  #
>  # Since: 1.2
>  ##
> @@ -540,7 +539,7 @@
>    'data': ['xbzrle', 'rdma-pin-all', 'auto-converge',
>             { 'name': 'zero-blocks', 'features': [ 'deprecated' ] },
>             'events', 'postcopy-ram',
> -           { 'name': 'x-colo', 'features': [ 'unstable' ] },
> +           { 'name': 'x-colo', 'features': [ 'unstable', 'deprecated' ] },
>             'release-ram',
>             'return-path', 'pause-before-switchover', 'multifd',
>             'dirty-bitmaps', 'postcopy-blocktime', 'late-block-activate',
> diff --git a/migration/options.c b/migration/options.c
> index 9a5a39c886..318850ba94 100644
> --- a/migration/options.c
> +++ b/migration/options.c
> @@ -580,6 +580,10 @@ bool migrate_caps_check(bool *old_caps, bool *new_caps, Error **errp)
>          warn_report("zero-blocks capability is deprecated");
>      }
>  
> +    if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
> +        warn_report("COLO migration framework is deprecated");
> +    }
> +
>  #ifndef CONFIG_REPLICATION
>      if (new_caps[MIGRATION_CAPABILITY_X_COLO]) {
>          error_setg(errp, "QEMU compiled without replication module"
> -- 
> 2.50.1
> 

-- 
Peter Xu


