Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C926AE7719C
	for <qemu-devel@archiver.kernel.org>; Fri, 10 Jan 2025 21:33:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tWMcT-0007wd-6o; Fri, 10 Jan 2025 16:32:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tWMcR-0007wQ-Bl
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:32:39 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <kwolf@redhat.com>) id 1tWMcP-0004pU-Nf
 for qemu-devel@nongnu.org; Fri, 10 Jan 2025 16:32:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736544750;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=K4106GMTUJ0/alW2jtOkYC93r7QRMay1HUCXwwWfnbY=;
 b=QMBnRgVGNJIpf5iHli1tgAOrsF+UoN+g4VmoStKbmTtFVQY368nkFcoacLMsoRQdubTDuk
 QctqiAESeqUDrfKGqOxZfxlQ7M+Y8iKWVXDuSxemhf7kE5RsE2l9FHrwDEHGQP0nt/gQxx
 BfBUKsqEuz0GJfQZ0NzHNZJ+JEw/mKU=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-130-RgFK6RprOWaYR_F9ACkNHA-1; Fri,
 10 Jan 2025 16:31:20 -0500
X-MC-Unique: RgFK6RprOWaYR_F9ACkNHA-1
X-Mimecast-MFC-AGG-ID: RgFK6RprOWaYR_F9ACkNHA
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id F130919560BB
 for <qemu-devel@nongnu.org>; Fri, 10 Jan 2025 21:31:19 +0000 (UTC)
Received: from redhat.com (unknown [10.39.193.248])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id E8EB130001BE; Fri, 10 Jan 2025 21:31:18 +0000 (UTC)
Date: Fri, 10 Jan 2025 22:31:16 +0100
From: Kevin Wolf <kwolf@redhat.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-devel@nongnu.org
Subject: Re: [PULL 02/38] rust: add --check-cfg test to rustc arguments
Message-ID: <Z4GRpOqXOka2f8Up@redhat.com>
References: <20250110184620.408302-1-pbonzini@redhat.com>
 <20250110184620.408302-3-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250110184620.408302-3-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=kwolf@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.432,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Am 10.01.2025 um 19:45 hat Paolo Bonzini geschrieben:
> rustc will check that every reachable #[cfg] matches a list of
> the expected config names and values.  Recent versions of rustc are
> also complaining about #[cfg(test)], even if it is basically a standard
> part of the language.  So, always allow it.
> 
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

error: invalid `--check-cfg` argument: `test`
  |
  = note: expected `cfg(name, values("value1", "value2", ... "valueN"))`
  = note: visit <https://doc.rust-lang.org/nightly/rustc/check-cfg.html> for more details

>  scripts/rust/rustc_args.py | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/scripts/rust/rustc_args.py b/scripts/rust/rustc_args.py
> index 5525b3886fa..d79dc6d81f1 100644
> --- a/scripts/rust/rustc_args.py
> +++ b/scripts/rust/rustc_args.py
> @@ -215,6 +215,8 @@ def main() -> None:
>  
>      if rustc_version >= (1, 80):
>          if args.lints:
> +            print("--check-cfg")
> +            print("test")

Should this be print("cfg(test)")?

>              for cfg in sorted(cargo_toml.check_cfg):
>                  print("--check-cfg")
>                  print(cfg)

Kevin


