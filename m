Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C152D46BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 28 Jan 2026 19:35:54 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vlBKC-0005R5-92; Wed, 28 Jan 2026 14:35:38 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vlBJt-0005M1-Pt
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:35:20 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vlBJr-0004jW-DS
 for qemu-devel@nongnu.org; Wed, 28 Jan 2026 14:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769628914;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BqRW8rBGiZUgNHc+MMOr3UyJhjSqh0N3us9XUX7nB9U=;
 b=U5phdIvPEJ6q9FnJdhPoyp0bFFmzdqTSOpdbMRFg1Y703qBZ96kp6piFhapvleA2uhb50o
 v6ynIiUC+2W5W+75MwTWlk+svNjPbAaAPaRdcUFnERbi/RD3lrwpU0K+2KObNfnlGrUmc5
 uKpft2kBn+xoBEln6DZ9eP6IWOTCzpc=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-632-DixW27QTNPum5rRqWEoltA-1; Wed, 28 Jan 2026 14:35:13 -0500
X-MC-Unique: DixW27QTNPum5rRqWEoltA-1
X-Mimecast-MFC-AGG-ID: DixW27QTNPum5rRqWEoltA_1769628913
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-502a4aca949so7156131cf.2
 for <qemu-devel@nongnu.org>; Wed, 28 Jan 2026 11:35:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769628912; x=1770233712; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=BqRW8rBGiZUgNHc+MMOr3UyJhjSqh0N3us9XUX7nB9U=;
 b=nC+01MeDPxr5nHKZD2t3DJFcPZXpzRfLwz55xOE+qcAJXizBZ2rkGGZgszp3h9+J3V
 xAseItfOm8DnOiBxG6LBxuNUUMUmUeTBHfXva7Ye+V11u0Craiwr+TcGEKqRuUd8D2eO
 4q4RouJjV/1wp1Cd9jtC/w16c55Mw3CBd7J15mbHsfOFHEpQLpYBlR3xHNLfNWZ1FQp2
 Mje3PBr5qK1Z48vk04SH04heUWj/noJPxDiGxTI/bVjsT1Ji4Br7l/qhhOcs+J3EVcDG
 3BTFeLZVDvtU57Qjcl0tm2Q5Dyf7Djf+tWM/50SYdWtiyOshmxVSC/l0gPsLj/O7ThTv
 uqiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769628912; x=1770233712;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=BqRW8rBGiZUgNHc+MMOr3UyJhjSqh0N3us9XUX7nB9U=;
 b=VnVy7EjRveGC2VOoUnz4WZzHVXenSVWgD/7Z74rGGl+Zi/WEPNUCoUe7tKEyaa2789
 bGinoiiSOqt/JfqhSxGX7jIo/K0bfLq3aQRVK9AFuRSZp3C7etBV4BSOxU3l1OIHmOcg
 6TSur+nOe5kEtXV3oNEXLkParzkBI3zTGfWjBnJZamKPPj43kUFcQFad8gAHaZckL0Ri
 A5OX+M6nX+OiVvaUUt0XrMi9leaxmYNwfwxLAtXllHDBtlB8dmn0ko9yFdzQDkMUYrLm
 r8seiscwzYYS4w8Yz8R9lPVSqLOg4wxhpbxOX5DtxHUoNMkvTLUfmYsh0eHsEzuSSgh/
 ZLKw==
X-Gm-Message-State: AOJu0YzcusPBSO6UEDfBJlSMbg+D7FrjRnqdi5u6lozBC9EHo3YKU9P8
 cyjVejd+7vpMo5fhh0clu9nz+d3nQU891vzDLey5PFRdZbLGria8wBLNKz2MshU3gybqOHbW3td
 RK0j/g2gWlJUizDkMMgE5BrWBH1YaL1dHIUOYcz7ORmTF+QsHwgBs4/5fONOD70eV
X-Gm-Gg: AZuq6aLibtY5bnqgYb9j9rRDKOJPB5h/uHY57nvRQLhhUFS8J4rMPzEaiTyfTFq1RMu
 Ks4ZKZIOewIRqZwnhY/K++t4RSRHd2blLTCKn20fr3OuAj28EDZDr01hsE6oYuuiJvYlTTux0JA
 N0nFMTGGsCJTRxKWTDp60OGsn3aDWbUHguLERD5ZX55MwIyF88HGgzOgc2sZrKobtWbmgKlGnM8
 FWRfhFk8ckIbnQuFkOpauGXVqit3126gg9vZhUM8BjW9mxmJ1ByoBnFiS6eJ7fjdx3YovSYCFg+
 R99f784vnuBfSxJLjyxMH2E/Ak/bvj6Rp2YqgKBbwAK2F6hHF92z4PojKOSK5+mkmemgNpxDehu
 dHOM=
X-Received: by 2002:a05:622a:2d5:b0:502:f291:615e with SMTP id
 d75a77b69052e-5032f8f119dmr88987121cf.52.1769628912131; 
 Wed, 28 Jan 2026 11:35:12 -0800 (PST)
X-Received: by 2002:a05:622a:2d5:b0:502:f291:615e with SMTP id
 d75a77b69052e-5032f8f119dmr88986731cf.52.1769628911674; 
 Wed, 28 Jan 2026 11:35:11 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-50337bbb66dsm20686281cf.29.2026.01.28.11.35.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 28 Jan 2026 11:35:11 -0800 (PST)
Date: Wed, 28 Jan 2026 14:35:10 -0500
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH 2/3] tests/functional/migration: Accept vm objects in
 do_migrate
Message-ID: <aXpk7m4LXpAdMOb8@x1.local>
References: <20260128142829.25326-1-farosas@suse.de>
 <20260128142829.25326-3-farosas@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260128142829.25326-3-farosas@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 28, 2026 at 11:28:28AM -0300, Fabiano Rosas wrote:
> Allow MigrationTest.do_migrate() to receive objects for virtual
> machines already created. This will allow MigrationTest to provide the
> migration functionality for tests that are defined in a separate
> module and require extra setup (e.g. arch-specific) to the virtual
> machines before migration.
> 
> The next patches will instantiate MigrationTest from another test
> class.
> 
> Signed-off-by: Fabiano Rosas <farosas@suse.de>
> ---
>  tests/functional/migration.py | 21 ++++++++++++++-------
>  1 file changed, 14 insertions(+), 7 deletions(-)
> 
> diff --git a/tests/functional/migration.py b/tests/functional/migration.py
> index 0aa873edba..ac6feeeefb 100644
> --- a/tests/functional/migration.py
> +++ b/tests/functional/migration.py
> @@ -40,15 +40,22 @@ def assert_migration(self, src_vm, dst_vm):
>          self.assertEqual(dst_vm.cmd('query-status')['status'], 'running')
>          self.assertEqual(src_vm.cmd('query-status')['status'],'postmigrate')
>  
> -    def do_migrate(self, dest_uri, src_uri=None):
> -        dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
> -        dest_vm.add_args('-nodefaults')
> -        dest_vm.launch()
> +    def do_migrate(self, dest_uri, src_uri=None, source_vm=None, dest_vm=None):

Nit: maybe good to always have dst, then src, or vice versa.

> +        if dest_vm:
> +            dest_vm.qmp('migrate-incoming', uri=dest_uri)
> +        else:
> +            dest_vm = self.get_vm('-incoming', dest_uri, name="dest-qemu")
> +            dest_vm.add_args('-nodefaults')
> +            dest_vm.launch()

Maybe this is a chance to switch to -incoming defer and always use
"migrate-incoming" QMP?

Then we can have _do_migrate() (or some better name..) do the real
migration commands, always taking VMs + URIs, making do_migrate() only
create two VMs and pass it over.

> +
> +        if not source_vm:
> +            source_vm = self.get_vm(name="source-qemu")
> +            source_vm.add_args('-nodefaults')
> +            source_vm.launch()
> +
>          if src_uri is None:
>              src_uri = dest_uri
> -        source_vm = self.get_vm(name="source-qemu")
> -        source_vm.add_args('-nodefaults')
> -        source_vm.launch()
> +
>          source_vm.qmp('migrate', uri=src_uri)
>          self.assert_migration(source_vm, dest_vm)
>  
> -- 
> 2.51.0
> 

-- 
Peter Xu


