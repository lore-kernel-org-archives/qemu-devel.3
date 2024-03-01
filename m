Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B96EAC48BF6
	for <qemu-devel@archiver.kernel.org>; Fri,  1 Mar 2024 01:48:38 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rfs0O-0007Va-6g; Thu, 29 Feb 2024 20:48:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfs0M-0007VS-Q7
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:48:06 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1rfs0I-000609-DU
 for qemu-devel@nongnu.org; Thu, 29 Feb 2024 20:48:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709257681;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=kbGQMcFMeBWWuyealmNHiPe6RyqLYu0Bx+tkh6h2PMk=;
 b=ZQcKA8jW8VwvdJZKoXG2r1lm+xBR0RlA4Fa9qIhFOIr6iPa3ymxU0hp9aSXant8jN63Spi
 0UcREmgp3D7eNaAKF9FWv805/5KZtyShv1ulDei1pDGm1b6WqYppRgOcd0MvxGjPTCEzxn
 LGoAT8M+9qABE+u0KiXuv6Xtilq2se8=
Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com
 [209.85.215.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-612-PxkmbDT_OIGb1NFNDajKig-1; Thu, 29 Feb 2024 20:47:59 -0500
X-MC-Unique: PxkmbDT_OIGb1NFNDajKig-1
Received: by mail-pg1-f197.google.com with SMTP id
 41be03b00d2f7-5cf53f904f9so322006a12.1
 for <qemu-devel@nongnu.org>; Thu, 29 Feb 2024 17:47:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1709257678; x=1709862478;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kbGQMcFMeBWWuyealmNHiPe6RyqLYu0Bx+tkh6h2PMk=;
 b=frTvNiUaTyVBB6hjGCLzlOXWzvwTv0la+tPBbULgiVRgjjk4S3+CE0Dkga0t/5v6HC
 9ms+hb6vxEeWGQReOHh7o3HxyQQCBw6HeHUYsqsmFL7mpVb0yn1IJMCJXetEBliwAoVh
 4roqIjLdEf6+W39M50Y1it5aB2iLf23v64X69jhGVNi+RB9VToNx5OXC4JK1DKQyv3dk
 NCbfcgdj8cbT73iMIDpxMQocBjzn6zrJ5z59QVJxm1eesj1SE6sCNxezLiwbVDjpQKeQ
 mn0P1AwWmKtVLueJAHFVHrmtipV0LAptzvmKaOTgXkP6RJHYnaztYIsgwsK46Qh0eJ7r
 pXiQ==
X-Gm-Message-State: AOJu0YyWogpsVXIptFh+iv9jL3PuYMTCadaeA9ZXhx5RvtY98eYvb3tY
 gCgxht+HIhg65jGYsCalk+55uVVt8TfAAjfXSm0sONOxfQHQlGDEULvLfFxXz2j4vrdfJs2WpBS
 jzQdd4e7FZfnrz1MlQyhsSn8Bs43Q+W4F/64uvqfcNkTb+HyIcnezs2cw1sII
X-Received: by 2002:a05:6a00:181f:b0:6e4:8870:66ef with SMTP id
 y31-20020a056a00181f00b006e4887066efmr470246pfa.2.1709257678446; 
 Thu, 29 Feb 2024 17:47:58 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEOY9F0AowiVspChwSorIQ1HNeas6C2UYesrJ4arn1LzZI0tssn86KLSsK46HygqWmOKB6JTQ==
X-Received: by 2002:a05:6a00:181f:b0:6e4:8870:66ef with SMTP id
 y31-20020a056a00181f00b006e4887066efmr470230pfa.2.1709257678105; 
 Thu, 29 Feb 2024 17:47:58 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 it18-20020a056a00459200b006e58120c241sm1900561pfb.191.2024.02.29.17.47.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 29 Feb 2024 17:47:57 -0800 (PST)
Date: Fri, 1 Mar 2024 09:47:50 +0800
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, berrange@redhat.com, armbru@redhat.com,
 Claudio Fontana <cfontana@suse.de>
Subject: Re: [PATCH v6 22/23] migration/multifd: Add mapped-ram support to
 fd: URI
Message-ID: <ZeEzxr1FKWF-Rx7S@x1n>
References: <20240229153017.2221-1-farosas@suse.de>
 <20240229153017.2221-23-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240229153017.2221-23-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.096,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 29, 2024 at 12:30:16PM -0300, Fabiano Rosas wrote:
> If we receive a file descriptor that points to a regular file, there's
> nothing stopping us from doing multifd migration with mapped-ram to
> that file.
> 
> Enable the fd: URI to work with multifd + mapped-ram.
> 
> Note that the fds passed into multifd are duplicated because we want
> to avoid cross-thread effects when doing cleanup (i.e. close(fd)). The
> original fd doesn't need to be duplicated because monitor_get_fd()
> transfers ownership to the caller.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


