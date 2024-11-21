Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 658D2E65D00
	for <qemu-devel@archiver.kernel.org>; Thu, 21 Nov 2024 23:00:26 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tEG9p-0006fy-Im; Thu, 21 Nov 2024 18:00:17 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEG9l-0006fX-Ao
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 18:00:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tEG9i-00078D-90
 for qemu-devel@nongnu.org; Thu, 21 Nov 2024 18:00:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1732230008;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YXesgyda8r4lI2v1wiqJDpqBeAjmQDPigDnGHQsHt68=;
 b=DO9nuJ4ZbgYdWwkMQPS7kHye1czHoaMCnDoX33sww5IEzyNS866EKFB0wINCn532yZBprP
 JC2Dn+mvSFkXMgKroXDTJiNWHd9O0n38EQCUwFXxHG4JwSciU/yCpANZxmcCZixYJlTehp
 JP6NWGBD5ad4M51xKG3XuzpnDwj8IWg=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-86-N47TKy15PkKqDIKG5nGxhQ-1; Thu, 21 Nov 2024 18:00:07 -0500
X-MC-Unique: N47TKy15PkKqDIKG5nGxhQ-1
X-Mimecast-MFC-AGG-ID: N47TKy15PkKqDIKG5nGxhQ
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-3a77a0ca771so10329835ab.0
 for <qemu-devel@nongnu.org>; Thu, 21 Nov 2024 15:00:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1732230006; x=1732834806;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YXesgyda8r4lI2v1wiqJDpqBeAjmQDPigDnGHQsHt68=;
 b=lo10vRswFa2EP6O7b+uc3eIGXPwuKCAo3C+XKuXXWUW0Idhq+PqsUQf1MveU661lpE
 hYrJG8X+Hubjqmg5y9DVCXf0Hj+1JmLaRQiX7MnLhV4Hnx4ocTLdXIJPmz4u815eNsyG
 u5opbPO3HgcRs4kGORn52wTyYJ3mz1xD0Ax2VwwsnVowlbFrWZmxGWrnxGQwgnP9DjKh
 Nr7rdx5EHaHultALCjL4MCE+QgSdHok7DYuO15upeqA0wt8mPFDYGVPHidfuN/Oc0Wcg
 ajiy5p/qQarHDELI6QojXKq0+NtpR2HPmrrQ4wEC9IjpvuwyetAR46NB+4zswbKiJ2rr
 zL+w==
X-Gm-Message-State: AOJu0YxucRosgaZczugCjFyf15AWyUQmWO2HB2wGfyr8bQ0tGmjmDMH/
 rkRHP1Qy7aLMyEZKlv7AjH3DtAu1K3V/Ipb1yYwZmvx71vqZqLzEP9ZogJWdV9ZG9vzMETLIvFz
 0t8eBDfQ1bkdSZUopucQdE9GE9KJXhffIiGFqFekjno5KdNi1AcAz
X-Gm-Gg: ASbGnctB1+jrlcPZrSofWa3sU/mDJU/DxEwxZBRLe8RCGLzato5cxVEZDlJP5dBk/qd
 QuRs4FMNFVlWHHCzpk7oOAettMx+fYJAU0REboN1wX414Y23RrFkrhPeL+MwVFA010yHvIcJ3/D
 srud4luYbbCX4RCGVv+0c4nVFXfZg5Oyg0nGITC3dUn+wiiU0uP2UG1YKh1avDyIU7H/vsO/8nL
 5XwxLbbpird+wkem/PyR2fkCvgUnRtb0Qvwh6Goc2gOcwjhOcbwm3APa8slp9O4rqLK72K5LTwZ
 ZZiBj23fFZI=
X-Received: by 2002:a05:6e02:1a2b:b0:3a7:8320:a6e with SMTP id
 e9e14a558f8ab-3a79ae3ef5dmr8791655ab.11.1732230006351; 
 Thu, 21 Nov 2024 15:00:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH57SJ5vnUDjXcM1mWz/mghIC98ag/WquTo5Rj+xxsDAf2FAeYMh+vL5yYu+SsjyiDAIm/kZg==
X-Received: by 2002:a05:6e02:1a2b:b0:3a7:8320:a6e with SMTP id
 e9e14a558f8ab-3a79ae3ef5dmr8791535ab.11.1732230005951; 
 Thu, 21 Nov 2024 15:00:05 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 e9e14a558f8ab-3a79ac4b7fasm2166855ab.48.2024.11.21.15.00.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 21 Nov 2024 15:00:05 -0800 (PST)
Date: Thu, 21 Nov 2024 18:00:02 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Peter Maydell <peter.maydell@linaro.org>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH v2 06/22] tests/qtest/migration: Move qmp helpers to a
 separate file
Message-ID: <Zz-7cvnWzpZHt6f1@x1n>
References: <20241113194630.3385-1-farosas@suse.de>
 <20241113194630.3385-7-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20241113194630.3385-7-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.14,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, Nov 13, 2024 at 04:46:14PM -0300, Fabiano Rosas wrote:
> We current have a bunch of non-test functions in migration-test.c and
> some others in migration-helpers.c. In order to split migration-test.c
> into separate test binaries, these helpers need to go somewhere
> else.
> 
> To avoid making migration-helpers even larger, move all QMP-related
> functions into a new migration-qmp.c file and put it under the
> qtest/migration/ directory.
> 
> The new file holds everything that has as its main responsibility to
> call into QMP.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/qtest/meson.build               |   1 +
>  tests/qtest/migration-helpers.c       | 250 +------------
>  tests/qtest/migration-helpers.h       |  18 +-
>  tests/qtest/migration-test.c          | 237 +------------
>  tests/qtest/migration/migration-qmp.c | 485 ++++++++++++++++++++++++++
>  tests/qtest/migration/migration-qmp.h |  44 +++
>  tests/qtest/virtio-net-failover.c     |   1 +
>  7 files changed, 540 insertions(+), 496 deletions(-)
>  create mode 100644 tests/qtest/migration/migration-qmp.c
>  create mode 100644 tests/qtest/migration/migration-qmp.h
> 
> diff --git a/tests/qtest/meson.build b/tests/qtest/meson.build
> index 16823a9202..ca199b9491 100644
> --- a/tests/qtest/meson.build
> +++ b/tests/qtest/meson.build
> @@ -333,6 +333,7 @@ tpmemu_files = ['tpm-emu.c', 'tpm-util.c', 'tpm-tests.c']
>  migration_files = [files(
>    'migration-helpers.c',
>    'migration/bootfile.c',
> +  'migration/migration-qmp.c',
>  )]

Not relevant to this patch alone, but ... this looks like a nested list.  I
assume meson does some auto-flatten things.

Reviewed-by: Peter Xu <peterx@redhat.com>

-- 
Peter Xu


