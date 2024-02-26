Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8DF3C47DD9
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 02:10:01 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1reQQd-0005qA-Le; Sun, 25 Feb 2024 21:09:15 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQQY-0005pg-A8
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:09:11 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1reQQW-0001kT-RY
 for qemu-devel@nongnu.org; Sun, 25 Feb 2024 21:09:10 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708913347;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=fGLOcjUFp6/mstOgqbiE3h2279sD4Bo0vhbGnvsxzSo=;
 b=ZJQkAD+1xTa0w6AMMRvh74Vy68hjXRV83x0ZhQe7KzdFRD+GSdk9QJ7iRUtjmkmwLlPVAm
 eEZVMCuDmOLidTkamUwQBQ296/9tsXzCWsaUBRYAk2GnsUlQfWM0wOswWl2TdEGokwQiwR
 moNTneq8J8LXlye3xqsWODsBuhy5eKE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-359-B5dP7aBAOUGawX3EfxDgdg-1; Sun, 25 Feb 2024 21:09:05 -0500
X-MC-Unique: B5dP7aBAOUGawX3EfxDgdg-1
Received: by mail-pf1-f197.google.com with SMTP id
 d2e1a72fcca58-6db0e05548fso954864b3a.1
 for <qemu-devel@nongnu.org>; Sun, 25 Feb 2024 18:09:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1708913344; x=1709518144;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fGLOcjUFp6/mstOgqbiE3h2279sD4Bo0vhbGnvsxzSo=;
 b=hg07JEeX2rFXq5rKMdXr5WgmfT6UEZWpemWB5V7jqFLvrOfXjhc6m9UQXjEXZKt3Um
 H+K5QFSDd6+mXd0zoSss6m6F3mR53YTLEKcrDF7Mpay06oo34t+Gk39S9toCAYaMk9f3
 lN/6aiflNfve69r9rL+m1PLwW3QpO093H3hGioVfOOyCajYp4tgZHA/DXmhRK1YikGt0
 pgwZNJM3LCdWdi0jqQolFGUkaLPEfH2ha+bRXmezq/mvnU7eC5BrvovXJTDSnD1RdJ/c
 wFZnkBBhRSCrU6XTzEpO56GUAEGbq90OEN49BzjbRj8eMv+dtEGOYU7JWQ6C31gRbTtK
 mCvg==
X-Gm-Message-State: AOJu0YyybPxEwSU1dDur++7Sq5zUrqYcUzaktGOjXxZGyAn6lt4jVUqu
 oNofpQRRAX+JEdXbIcQoglGWtbyzRNofVsjLuktsf0m1FIaaYugvCD9/6sNpkfxB+U9+DIajjUO
 +e/r/eOjCQeMEZinlz6+xsw9NCk96xi2/6VTWVFc9Z03DCreKA6dO
X-Received: by 2002:aa7:8b05:0:b0:6e5:35a7:5333 with SMTP id
 f5-20020aa78b05000000b006e535a75333mr308171pfd.2.1708913344322; 
 Sun, 25 Feb 2024 18:09:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IErr8v5Z2xKC5kQcCW6DNXbxAdOmw0A/hldpX7avQdxXBVLRAX/kPP5geMcUZ4fucjUxMaDag==
X-Received: by 2002:aa7:8b05:0:b0:6e5:35a7:5333 with SMTP id
 f5-20020aa78b05000000b006e535a75333mr308153pfd.2.1708913343979; 
 Sun, 25 Feb 2024 18:09:03 -0800 (PST)
Received: from x1n ([43.228.180.230]) by smtp.gmail.com with ESMTPSA id
 fk17-20020a056a003a9100b006e043d3e5c2sm2857689pfb.162.2024.02.25.18.09.01
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 25 Feb 2024 18:09:03 -0800 (PST)
Date: Mon, 26 Feb 2024 10:08:57 +0800
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 Cedric Le Goater <clg@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Marc-Andre Lureau <marcandre.lureau@redhat.com>,
 David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V4 10/14] migration: stop vm for cpr
Message-ID: <ZdvyuazPp6Lrn5Mr@x1n>
References: <1708622920-68779-1-git-send-email-steven.sistare@oracle.com>
 <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1708622920-68779-11-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.097,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001, T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

On Thu, Feb 22, 2024 at 09:28:36AM -0800, Steve Sistare wrote:
> When migration for cpr is initiated, stop the vm and set state
> RUN_STATE_FINISH_MIGRATE before ram is saved.  This eliminates the
> possibility of ram and device state being out of sync, and guarantees
> that a guest in the suspended state remains suspended, because qmp_cont
> rejects a cont command in the RUN_STATE_FINISH_MIGRATE state.
> 
> Signed-off-by: Steve Sistare <steven.sistare@oracle.com>

Reviewed-by: Peter Xu <peterx@redhat.com>

cpr-reboot mode keeps changing behavior.

Could we declare it "experimental" until it's solid?  Maybe a patch to
document this?

Normally IMHO we shouldn't merge a feature if it's not complete, however
cpr-reboot is so special that the mode itself is already merged in 8.2
before I started to merge patches, and it keeps changing things.  I don't
know what else we can do here besides declaring it experimental and not
declare it a stable feature.

-- 
Peter Xu


