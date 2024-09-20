Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3629ACF9C54
	for <qemu-devel@archiver.kernel.org>; Fri, 20 Sep 2024 15:35:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1srfes-0001Yp-TC; Fri, 20 Sep 2024 11:34:58 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srfer-0001YM-N6
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 11:34:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1srfeq-0006fI-6C
 for qemu-devel@nongnu.org; Fri, 20 Sep 2024 11:34:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1726846493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+v795IfUa4YZkDYjh8cFbupN6ATXvOdeH/S8wd3pHGQ=;
 b=Zho0SGWKJ5MTjBsf5V24XLGydAw/HDNhcqMRU8+ag9/WoG9ip8JDhzD8XD6Fq7fW6a/UWQ
 Nzi+iaIDU7i9mlt71+4E20BsOsLH5pNTAiQoo2FDjlLkxEDMdkV+Rsiz7Zmzg6//mqGf6l
 mbSr4u4Ez2BQdGnljN21W3zYKEqWti4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-346-6NN6RgaNMfa1saxgf6ua_g-1; Fri, 20 Sep 2024 11:34:52 -0400
X-MC-Unique: 6NN6RgaNMfa1saxgf6ua_g-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6c360967e53so37672926d6.0
 for <qemu-devel@nongnu.org>; Fri, 20 Sep 2024 08:34:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726846491; x=1727451291;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=+v795IfUa4YZkDYjh8cFbupN6ATXvOdeH/S8wd3pHGQ=;
 b=YHpIsdR+co3HQmoWmlE8Vz4eX3CJkPHfbTcbjjgyamFwFcnJxh2EEoN51kfdSKE3R6
 gzShnYzJHMBkvfza5Iw/RRR4cVVijY3u+OxxwvlJwf77jyGChgZxB2Yb8FAZxx3BdHBf
 /7+zN3BP2uXPcwEGd46pbacuUbqEQ0+eQwdDvXztGl9VlaEvyKMkmELeDO6+NZviJo9a
 ozNQRtjLbzUzxRPqu2gS5ORisP/YdpwGunaevtPTEk6XEV0K8nNfKd5oWc3cRZhIpcYy
 cTkXGDdKR33DwmM+adDcHP6IoX95G7/3hx2NkqTrZ/B0Rr4uvWIWTDWpLMpd62zo8hQF
 ooZA==
X-Forwarded-Encrypted: i=1;
 AJvYcCV02MxzTu+ZIYazuluxwVewBZMLdPEN+4xj5daLaNu3dm2h/Ca13Dfj0Xy5GfRfaZGYIQHQQk4shsZQ@nongnu.org
X-Gm-Message-State: AOJu0YyzznoKhX+Z/UYuIh4DZymeNRyEJNBZLw1kDrTo+DdgWqj+4XxP
 wm6sa+tNAnjnUSET42aT+VF3k0TGzzbvrHMt449+9C2MPHkvBpDwDfTvhnbA/9keqETZ/denZKY
 BlcH0isuw98A8UdZZTQq3N2lwTiHkyUunYGOmLkLROCXuSm7mrAH4
X-Received: by 2002:a05:6214:449b:b0:6c5:1666:c2d6 with SMTP id
 6a1803df08f44-6c7bc7373b7mr47981286d6.22.1726846491720; 
 Fri, 20 Sep 2024 08:34:51 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGkiiE2HzFPqR3Qm1Y4UNcJPwAO8dUf9y3/7a4B4/rqAztmPQeB8lZpw2/QfuZGMs0hJl8ZAw==
X-Received: by 2002:a05:6214:449b:b0:6c5:1666:c2d6 with SMTP id
 6a1803df08f44-6c7bc7373b7mr47981056d6.22.1726846491438; 
 Fri, 20 Sep 2024 08:34:51 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6c75e57a552sm19166066d6.121.2024.09.20.08.34.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Sep 2024 08:34:51 -0700 (PDT)
Date: Fri, 20 Sep 2024 11:34:49 -0400
From: Peter Xu <peterx@redhat.com>
To: dave@treblig.org
Cc: farosas@suse.de, eblake@redhat.com, armbru@redhat.com,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v2 0/7] Migration deadcode removal
Message-ID: <Zu2WGfCQSjyvWgL2@x1n>
References: <20240919134626.166183-1-dave@treblig.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240919134626.166183-1-dave@treblig.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Sep 19, 2024 at 02:46:19PM +0100, dave@treblig.org wrote:
> From: "Dr. David Alan Gilbert" <dave@treblig.org>
> 
>   This is a set of deadcode removal around migration
> found by looking for unused symbols.
> 
> v2
>    Don't remove the zero-blocks capability yet
>    add Fabiano's deprecation text patch.
>    Use the uffd helpers in postcopy rather than
>      removing most of them.
>    Remove one.
> 
> Dave
> 
> Dr. David Alan Gilbert (6):
>   migration: Remove migrate_cap_set
>   migration: Remove unused migrate_zero_blocks
>   migration: Remove unused socket_send_channel_create_sync
>   util/userfaultfd: Return -errno on error
>   migration/postcopy: Use uffd helpers
>   util/userfaultfd: Remove unused uffd_poll_events
> 
> Fabiano Rosas (1):
>   migration: Deprecate zero-blocks capability

Tentatively queued.  Markus/others, still feel free to comment or offer
tags, the PR will be at least a few days after people back from forum.

Thanks!

-- 
Peter Xu


