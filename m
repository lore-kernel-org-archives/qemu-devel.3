Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A35B8CA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:45:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0Va-0005PA-Mb; Tue, 09 Sep 2025 11:43:51 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0VV-0005OY-7o
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:43:45 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0VQ-000656-GO
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:43:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757432614;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IKjHZVd0N0YGMeSmA6CcXuyuGFJ15sXGrNxR+rharrc=;
 b=RZdEiOdC5jHFWojtaW2tkk8cFR8YZjOHPqAKsRLkqtIcf2rMQyJcO2GvM0urcmPS0pdQzv
 /Ov01AY33OKtjQUX1q6dQLgQKzEapjjFJ5g6bxDUSBZv1kRLRhOxN6DGhX/Yug/zdOz560
 OzTCG1jjUfXGdyxVft+BHPJ1RBl6Ol8=
Received: from mail-vs1-f70.google.com (mail-vs1-f70.google.com
 [209.85.217.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-NjJXlTBCPY-R8CazEUoc-A-1; Tue, 09 Sep 2025 11:43:32 -0400
X-MC-Unique: NjJXlTBCPY-R8CazEUoc-A-1
X-Mimecast-MFC-AGG-ID: NjJXlTBCPY-R8CazEUoc-A_1757432612
Received: by mail-vs1-f70.google.com with SMTP id
 ada2fe7eead31-52f9b4adc59so10604662137.1
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 08:43:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757432612; x=1758037412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=IKjHZVd0N0YGMeSmA6CcXuyuGFJ15sXGrNxR+rharrc=;
 b=w2duO5S8SESHG9EGwA0DBppGxYxK2Ff57lKCb5v4R3Cz6yfpn9BGQnbw6/+kFqG17W
 a1dX/BYchwO5B7k0QlhYej7RIlkN4e5YFU70jOSG3Slf8mFWOgYfUE7/CahPlaVRJq5+
 w0qLeVwqR0vVG4R1UgOCfDzTkNvmsFBQIaG9Y3TCXjJCHsw4u06CXFavozEtF4TfoFoh
 wnkloaVdfXma9RqgCHvHHx+ZSw9kwOMAxxzkCNcQi5gp5lCLTPjC/bbdx0BZeZ+SZi/G
 Vmbm2wDIhDGdk8q/8TFLAOyYEdKF+6ytXmWHfxSSh85iCdl/ILmkI0DfernatwlP2Lt6
 eW/A==
X-Gm-Message-State: AOJu0YzTIWw2dUWMdFrY3laPpUp1prnnrqYujDDZB22ADlNqw75Df9zl
 eT0aT1GVE7l3h058iYoAMJvaCtKtwyFMWKai7IFwytqNnwp10DW0DoMJfUurDvRSCYJKyL3BRHX
 6PTC11JOTdE6Pf/WAsqp43qfZ5RP95AKotDxKaJFIqg/O8YWvz6V4Z7yo
X-Gm-Gg: ASbGncsWUOtMmlvst7iaWCn+tj6CJGIZu2QEMmDcU7MIxzonGpPPEAebTBgxfjPnusM
 vk4Zx8Xt1ORE4L/3icrph01aXlDsOguJ09A0SvHAN7IsME1EWdbfB25ai5xT5fMPkDIbCkn9CWs
 Ty7RDBbN4byFf0XjJi7BadC67x5ovri3NxuOCdle3W0fkImCFyBwYUQBv1pAMm8KPm7bCsYG0lg
 ic5ubvSPJt5DmKaQY4QPRLWuhedd9lqNiqG7kccUIGdoeWeYVULGuDXiHOM4JT/kkHwf0KBGIer
 18NPWrRzl/pwYviliLnDLPRRQK2chn0AiXNSoD2XW/UQCY4CVZT+JmrQUd8AeR1chcizLIJ00xG
 WSHu1JfTdAkkk0tAvIjfxbg==
X-Received: by 2002:a05:6102:160e:b0:528:ce0c:880d with SMTP id
 ada2fe7eead31-53d791e640amr3945525137.0.1757432612311; 
 Tue, 09 Sep 2025 08:43:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFyu9ekS3/zI08Pj4NOhjGEo5Q4Go8NBWsEif7GDdnKsYIy756XT9wwk1ArBaIPXx4mE7nsuA==
X-Received: by 2002:a05:6102:160e:b0:528:ce0c:880d with SMTP id
 ada2fe7eead31-53d791e640amr3945517137.0.1757432611915; 
 Tue, 09 Sep 2025 08:43:31 -0700 (PDT)
Received: from x1.local
 (bras-base-aurron9134w-grc-11-174-89-135-121.dsl.bell.ca. [174.89.135.121])
 by smtp.gmail.com with ESMTPSA id
 ada2fe7eead31-52af1e46f50sm11076153137.14.2025.09.09.08.43.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 08:43:31 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:43:28 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>
Subject: Re: [PATCH V3 1/9] migration: multi-mode notifier
Message-ID: <aMBLIJU6i7yzObjP@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <1755191843-283480-2-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755191843-283480-2-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Aug 14, 2025 at 10:17:15AM -0700, Steve Sistare wrote:
> Allow a notifier to be added for multiple migration modes.
> To allow a notifier to appear on multiple per-node lists, use
> a generic list type.  We can no longer use NotifierWithReturnList,
> because it shoe horns the notifier onto a single list.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>
> ---
>  include/migration/misc.h | 12 ++++++++++
>  migration/migration.c    | 60 +++++++++++++++++++++++++++++++++++++-----------
>  2 files changed, 59 insertions(+), 13 deletions(-)
> 
> diff --git a/include/migration/misc.h b/include/migration/misc.h
> index a261f99..592b930 100644
> --- a/include/migration/misc.h
> +++ b/include/migration/misc.h
> @@ -95,7 +95,19 @@ void migration_add_notifier(NotifierWithReturn *notify,
>  void migration_add_notifier_mode(NotifierWithReturn *notify,
>                                   MigrationNotifyFunc func, MigMode mode);
>  
> +/*
> + * Same as migration_add_notifier, but applies to all @mode in the argument
> + * list.  The list is terminated by -1 or MIG_MODE_ALL.  For the latter,
> + * the notifier is added for all modes.
> + */
> +void migration_add_notifier_modes(NotifierWithReturn *notify,
> +                                  MigrationNotifyFunc func, MigMode mode, ...);

Would it be more common to pass in a bitmask instead (rather than n
parameters, plus a ending -1)?

-- 
Peter Xu


