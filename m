Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C80ADE77171
	for <qemu-devel@archiver.kernel.org>; Wed,  4 Dec 2024 20:05:36 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tIvcO-00043v-My; Wed, 04 Dec 2024 15:05:04 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIvcN-00042C-E9
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:05:03 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tIvcM-0003MC-1s
 for qemu-devel@nongnu.org; Wed, 04 Dec 2024 15:05:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733342701;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=n1SinKtDXuMdQYPr28oegc+WM+nzyg47B7ZbZEtDcGc=;
 b=Youy3e4M/g1SFMvrat6EN/OKGA4WReqpfOtK/JBclf0XLrCtwkgzksqwA6+MOmGWNBuzPF
 fMs6q0LEtZA2Qm/Ll02z638XxoCMP5F7lXXUnSa4m7TD5bCyJMw0/1yZQAc57Ic++9dnfM
 FL8d0PRCWzLnC7h8roJ2G7Noeyb+lk0=
Received: from mail-il1-f199.google.com (mail-il1-f199.google.com
 [209.85.166.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-454-Ix82q_fLPsWbv4dpLRBxPw-1; Wed, 04 Dec 2024 15:05:00 -0500
X-MC-Unique: Ix82q_fLPsWbv4dpLRBxPw-1
X-Mimecast-MFC-AGG-ID: Ix82q_fLPsWbv4dpLRBxPw
Received: by mail-il1-f199.google.com with SMTP id
 e9e14a558f8ab-3a7a1e95f19so836885ab.1
 for <qemu-devel@nongnu.org>; Wed, 04 Dec 2024 12:05:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733342699; x=1733947499;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=n1SinKtDXuMdQYPr28oegc+WM+nzyg47B7ZbZEtDcGc=;
 b=bTrg3pRbyefVonRccEAYM/NPOqkey7H6IZGGnwyiG+wiuniOvciw6tI0HoFkzoWlrH
 WWC4XBxRF18Vhg3WIU8QA0FvUHeKwypqZojIKIpHnPYuoTxxceMZKOYwm7irhUoMa6yM
 U4nceWvxTgCIkBABl+zangjqrq/3OXfIqQZQqfWCtfQdTokyJp7oUovmiA5rZoyU1I2g
 AlK+3nhHb3Zfyx/XiiEXuPwyfYuQUbcTNjJEgZoZjFGm1XwGLtQu2yqCoZcrkU7qzvkO
 hWEufN3pshnmQ19tyAWB5s2VtSBNIdOdhlAo1zZu3mbgpT9dgDaccFzsxV8vjG/lw/52
 M6OA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUX5opvnP1BeB54Ehkz0RBsjeDsnMr4BeQqVK5qH6HBAhSh0+iwhh7c3XJuuZFQ+m0hCdSfzEa3mmDg@nongnu.org
X-Gm-Message-State: AOJu0Yzoc5SMvEwnBkf2OApCa/zC9mFOlJ+e+cDMH74JcyVW2dTtvpe7
 EQ6zFV1rNqAuWh6VEKZ52OT2sV5ptav6GQXWWq2ShBDqghztPBlhgRmzQ+lHxClAaQBqEElYxLz
 /VOayTb9bZcJJ9QQgTN8Rekrr6jb158xuTd9X2k2KYki+1cF5LUot
X-Gm-Gg: ASbGncvQu0SJ96JIV2lBkBEEdEUKKmd3eO9lqWQpdBUuJ4mRUExGhPtvnwThkn3qZIO
 0pN1JjkRf3aEUIPB7xLf/bCOv+1ONqjvgXBc/y+VzU5e5wuK45eweGC5A6v7ffJAjukNGP02aer
 owH7dHfuA3LEgs1LhJEvSo+F6fEO+qaTUM1kUKXSuN/C7ZxQ4jmkC/qRMbZ+UxdkQICJC0iyq+z
 Y41oOCaJ8xQMttoEB4eQaYNYT4Vv+kgJIn1ErFNVlsC03TvxG//+r2xLohTC/QK1/1dILtVy6bO
 I4tvou1Lriw=
X-Received: by 2002:a05:6e02:1d1b:b0:3a7:a4ec:6cfc with SMTP id
 e9e14a558f8ab-3a7f9a3b6a5mr93951735ab.8.1733342699515; 
 Wed, 04 Dec 2024 12:04:59 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGlnY53XHpAQU0YORmKx5E0V+0kY+5ud30g2G5XD6I5dtlvrihQpoYkQG4ykkiHdmtJR0B3aQ==
X-Received: by 2002:a05:6e02:1d1b:b0:3a7:a4ec:6cfc with SMTP id
 e9e14a558f8ab-3a7f9a3b6a5mr93951435ab.8.1733342699192; 
 Wed, 04 Dec 2024 12:04:59 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a7dff088bbsm25864795ab.56.2024.12.04.12.04.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Dec 2024 12:04:58 -0800 (PST)
Date: Wed, 4 Dec 2024 15:04:56 -0500
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eric Blake <eblake@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Avihai Horon <avihaih@nvidia.com>,
 Joao Martins <joao.m.martins@oracle.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH v3 04/24] thread-pool: Implement generic (non-AIO) pool
 support
Message-ID: <Z1C16M7O1Ab_w7CK@x1n>
References: <cover.1731773021.git.maciej.szmigiero@oracle.com>
 <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <babda1bbe43024baaa4a9ac855f7930b6679f2b7.1731773021.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -50
X-Spam_score: -5.1
X-Spam_bar: -----
X-Spam_report: (-5.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.999,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Sun, Nov 17, 2024 at 08:19:59PM +0100, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Migration code wants to manage device data sending threads in one place.
> 
> QEMU has an existing thread pool implementation, however it is limited
> to queuing AIO operations only and essentially has a 1:1 mapping between
> the current AioContext and the AIO ThreadPool in use.
> 
> Implement generic (non-AIO) ThreadPool by essentially wrapping Glib's
> GThreadPool.
> 
> This brings a few new operations on a pool:
> * thread_pool_wait() operation waits until all the submitted work requests
> have finished.
> 
> * thread_pool_set_max_threads() explicitly sets the maximum thread count
> in the pool.
> 
> * thread_pool_adjust_max_threads_to_work() adjusts the maximum thread count
> in the pool to equal the number of still waiting in queue or unfinished work.
> 
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>

All the comments so far make sense to me too, so if you address all of
them, feel free to take this alone:

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


