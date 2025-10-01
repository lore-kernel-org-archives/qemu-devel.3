Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 266DECAC5BB
	for <qemu-devel@archiver.kernel.org>; Wed,  1 Oct 2025 18:59:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1v420t-0004wI-Ix; Wed, 01 Oct 2025 14:57:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v420p-0004vP-2V
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:57:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1v420a-0001PP-NV
 for qemu-devel@nongnu.org; Wed, 01 Oct 2025 14:57:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1759345012;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Au/6S0gGSWaoAImOK+twcwc+6xlumU6Bi0fYmA/6ZDg=;
 b=QPWcA6fztjA79e/GPgc/5s6dgYcwkd0RseJ0bwtBQzMmtUMuhRCItFIEZKOuW0Yv4ZZMXP
 E9xDRFUrIGERWG5oQMPKZIAnTvPC5ishFrNrxqnIKWwJ3mYexQMJvKf70gWRPtTjRiXnZl
 UtorEcnt7f2wjdgwcEhN7n9044yF/mY=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-563-Ci6IBx2UPP-gZp1XlCvrfQ-1; Wed, 01 Oct 2025 14:56:50 -0400
X-MC-Unique: Ci6IBx2UPP-gZp1XlCvrfQ-1
X-Mimecast-MFC-AGG-ID: Ci6IBx2UPP-gZp1XlCvrfQ_1759345010
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4deb67c61caso5479971cf.2
 for <qemu-devel@nongnu.org>; Wed, 01 Oct 2025 11:56:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1759345010; x=1759949810;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Au/6S0gGSWaoAImOK+twcwc+6xlumU6Bi0fYmA/6ZDg=;
 b=QtqIOEygrmhY98oD8GhE7+tIXGZZAe2BgiA9sxevQ6mb/WMRt+y5QQho7LO5ZkZel1
 Ru2Lm5ebL+B/DWSwp+LyrDfSIuDws53caKkDLeh64wJmLdBC55DIFVmWkW5bDiT8LmwH
 /k7Cgjzq7h9J0pOSwV09mFuedqRqWP9UfycZeYkxp8ehMw/6hh/LRyXtm+yvO2ABtMWp
 taSwbVazetVnjp8WiuCZCzeIUUbYt0qrWJQeOlqTytS1NfyXQTB4g9d1G1zitBHWkPjH
 X1PAy9l41vjO3L/77C8hAig39KGBA5auN2hWlVlvuB5yC1aXZxzf0DbNg5f71lDc++0c
 TNVg==
X-Gm-Message-State: AOJu0Yz/gh0Hycj/lxFqIR9o0U53vGMpHMcl4ya6hgBB7TeRzBxpSf5y
 lwc0E5hZsI5MyjwIvu64phe3SDsN+eCan/ZosIqhZqh1TlgKWwsRuHyzTBxDXq42WYz3dJZJOm7
 afr4JZMRxxGnkYc4Y1lmC2k53cyqgNKUHXJo4iMiB8qDYZXaYYs8ARLUp
X-Gm-Gg: ASbGncuBsGPSfk0GRICB8Qwcv6GrC90V3XuwItj6D9PYvr4S5dayEd4kDSfA0npBQaT
 GWLGKy2LW7/ojAriBRhSDqS3EgePolX1LkbhZwRIJT6SpOc84Ds7CpQZg+c1Uk6p0cenT2FEs4m
 aR5zhjygFy1nNK6rBcStkXBeNU3vq6dxqD4dgyrQV0d46eJxIa09ZvEabFDP5pygR/Irnzaj9Rc
 IlymKUF7DY6vVi5j720vdBGTUp1v/dR65pJFWh1zfGe/Mcre7Xr18ezfzenQav95MtY0CeycPRz
 dHoOjLwp9KH3OdVh+GeiX6VJp/hX9uYoMEzKGA==
X-Received: by 2002:ad4:5d42:0:b0:7f8:6791:2076 with SMTP id
 6a1803df08f44-873a78f2a17mr53588636d6.64.1759345010203; 
 Wed, 01 Oct 2025 11:56:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHcunFjSOzcPSmPQMm4Xag/Ld0Z3iEdbPmADL2yZISW6QXpmSN7R2WSxgwm5swDepKjHwFZ3A==
X-Received: by 2002:ad4:5d42:0:b0:7f8:6791:2076 with SMTP id
 6a1803df08f44-873a78f2a17mr53588276d6.64.1759345009710; 
 Wed, 01 Oct 2025 11:56:49 -0700 (PDT)
Received: from x1.local ([142.188.210.50]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-878bb446e8esm3865456d6.18.2025.10.01.11.56.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 01 Oct 2025 11:56:49 -0700 (PDT)
Date: Wed, 1 Oct 2025 14:56:48 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Cedric Le Goater <clg@redhat.com>,
 Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH V5 00/19] Live update: cpr-exec
Message-ID: <aN15cNEwH4HBt7NU@x1.local>
References: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1759332851-370353-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.518,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Oct 01, 2025 at 08:33:52AM -0700, Steve Sistare wrote:
> This patch series adds the live migration cpr-exec mode.
> 
> The new user-visible interfaces are:
>   * cpr-exec (MigMode migration parameter)
>   * cpr-exec-command (migration parameter)
> 
> cpr-exec mode is similar in most respects to cpr-transfer mode, with the
> primary difference being that old QEMU directly exec's new QEMU.  The user
> specifies the command to exec new QEMU in the migration parameter
> cpr-exec-command.

It turns out I was right where I replied to patch 5; this fails the Windows
build.

Smallest fix is to wrap qemu_memfd_create() with a CONFIG_LINUX ifdef,
returning -1 to mfd otherwise.

A better one is we only include cpr*.c in meson.build if it's linux.
Personally I'm OK if we go with the smaller one as of now, however then it
would definitely be nice to have a follow up series to reach the better
solution, if that makes sense.

Feel free to use "make docker-test-build@fedora-win64-cross" for verifying
the changes.  I hope it'll work for you, even if for me currently it didn't
work due to a gitlab.com dns resolution pulling dtc src, where I didn't dig
deeper yet..

The other thing is, this series doesn't apply on master branch.  I didn't
feel confident to do it myself on the vfio change, please have a look on
both issues.

Thanks,

-- 
Peter Xu


