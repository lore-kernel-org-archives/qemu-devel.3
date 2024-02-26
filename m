Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CACE4C54E4A
	for <qemu-devel@archiver.kernel.org>; Mon, 26 Feb 2024 18:23:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1refdG-0003Ib-Mg; Mon, 26 Feb 2024 13:23:18 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1refdF-0003IN-Ne
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:23:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1refdD-0006lA-RO
 for qemu-devel@nongnu.org; Mon, 26 Feb 2024 13:23:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708971794;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QYe06vYw0fP04I4RbWNRQvjpLhqi8fxwB/mVvOm1HgI=;
 b=O816knOBegty2KNLCUxTPYMCgSDe4TOQLbUwDGy7VHAeJl262xGCO8PB2DV0z6lssYY8fI
 co9r6NZFUv3y36KxZkCwUBsbKOxRW/bDmE4swnjfo9oQ38zettwbUMJ8HSe0G0x+SUo17i
 lx3MuHbCEeXvKhpA+NMs1ld4vm7HGz0=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-194-BI9ESRrJPXWy3tPby193Ww-1; Mon,
 26 Feb 2024 13:23:12 -0500
X-MC-Unique: BI9ESRrJPXWy3tPby193Ww-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 7B0F42823802;
 Mon, 26 Feb 2024 18:23:12 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.127])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 6B0814024858;
 Mon, 26 Feb 2024 18:23:11 +0000 (UTC)
Date: Mon, 26 Feb 2024 18:23:09 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: qemu-devel@nongnu.org,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Thomas Huth <thuth@redhat.com>,
 Wainer dos Santos Moschetta <wainersm@redhat.com>,
 Beraldo Leal <bleal@redhat.com>
Subject: Re: [RFC PATCH] tests/vm: avoid re-building the VM images all the time
Message-ID: <ZdzXDSZTktuJnkEy@redhat.com>
References: <20240226174639.438987-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240226174639.438987-1-alex.bennee@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.2
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.014,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Mon, Feb 26, 2024 at 05:46:39PM +0000, Alex Bennée wrote:
> There are two problems.
> 
> The first is a .PHONY target will always evaluate which triggers a
> full re-build of the VM images. Drop the requirement knowing that this
> introduces a manual step on freshly configure build dirs.

For context, the background to this is:

   https://gitlab.com/qemu-project/qemu/-/issues/2118

dropping '$(VM_VENV)' is the fix for that bit, which is the real
killer bit.

> 
> The second is a minor unrelated tweak to the Makefile also triggers an
> expensive full re-build. Solve this be avoiding the dependency and
> putting a comment just above the bit that matters and hope developers
> notice the comment.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> 
> ---
> 
> This is hacky and sub-optimal. There surely must be a way to have our cake
> and eat it?
> ---
>  tests/vm/Makefile.include | 7 ++++---
>  1 file changed, 4 insertions(+), 3 deletions(-)
> 
> diff --git a/tests/vm/Makefile.include b/tests/vm/Makefile.include
> index bf12e0fa3c5..a109773c588 100644
> --- a/tests/vm/Makefile.include
> +++ b/tests/vm/Makefile.include
> @@ -88,10 +88,11 @@ vm-build-all: $(addprefix vm-build-, $(IMAGES))
>  vm-clean-all:
>  	rm -f $(IMAGE_FILES)
>  
> +# Rebuilding the VMs every time this Makefile is tweaked is very
> +# expensive for most users. If you tweak the recipe bellow you will
> +# need to manually zap $(IMAGES_DIR)/%.img to rebuild.
>  $(IMAGES_DIR)/%.img:	$(SRC_PATH)/tests/vm/% \
> -			$(SRC_PATH)/tests/vm/basevm.py \
> -			$(SRC_PATH)/tests/vm/Makefile.include \
> -			$(VM_VENV)
> +			$(SRC_PATH)/tests/vm/basevm.py
>  	@mkdir -p $(IMAGES_DIR)
>  	$(call quiet-command, \
>  		$(VM_PYTHON) $< \
> -- 
> 2.39.2
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


