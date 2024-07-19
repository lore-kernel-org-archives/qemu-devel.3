Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36266C3DA59
	for <qemu-devel@archiver.kernel.org>; Fri, 19 Jul 2024 08:18:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sUiox-0000bk-Qw; Fri, 19 Jul 2024 04:18:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUioq-0000ap-4H
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:18:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sUioo-0000NB-6d
 for qemu-devel@nongnu.org; Fri, 19 Jul 2024 04:18:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1721377101;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VOiIw1/dHx5iW+f2GUL8l7aZigI+L8JmU3pmcVv1VXc=;
 b=E5/1BmgKp16rZSFyGNYHbCcNrw7mHG8dFsO9GM5PQTGw4XRV1n0wfz/P6z6J3f5JjDLddl
 NVN+0BaxkqTf3gXGpzsmjz2YGHpRt4fsXQ65n0yT2UVlt94QsEYHKnuxqOPaPCjEMN348X
 diDwgW/1bH5Fudt4iScL0p853DmlEfE=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-98-Ha_Av6ZDOXuP3kgwwGdUvg-1; Fri,
 19 Jul 2024 04:18:14 -0400
X-MC-Unique: Ha_Av6ZDOXuP3kgwwGdUvg-1
Received: from mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.17])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A1C491955BEF; Fri, 19 Jul 2024 08:18:11 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.37])
 by mx-prod-int-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 73EC31955F40; Fri, 19 Jul 2024 08:18:08 +0000 (UTC)
Date: Fri, 19 Jul 2024 09:18:04 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: Song Gao <gaosong@loongson.cn>, qemu-devel@nongnu.org,
 richard.henderson@linaro.org, Xianglai Li <lixianglai@loongson.cn>,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>
Subject: Re: [PULL 3/3] hw/loongarch: Modify flash block size to 256K
Message-ID: <ZpohPHRh7gOeTV4o@redhat.com>
References: <20240719022604.781608-1-gaosong@loongson.cn>
 <20240719022604.781608-4-gaosong@loongson.cn>
 <a143257f-62c0-4c3a-9031-5f3e510f430d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a143257f-62c0-4c3a-9031-5f3e510f430d@linaro.org>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.17
Received-SPF: pass client-ip=170.10.133.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

On Fri, Jul 19, 2024 at 10:12:20AM +0200, Philippe Mathieu-Daudé wrote:
> On 19/7/24 04:26, Song Gao wrote:
> > From: Xianglai Li <lixianglai@loongson.cn>
> > 
> > loongarch added a common library for edk2 to
> > parse flash base addresses through fdt.
> > For compatibility with other architectures,
> > the flash block size in qemu is now changed to 256k.
> > 
> > Signed-off-by: Xianglai Li <lixianglai@loongson.cn>
> > Reviewed-by: Song Gao <gaosong@loongson.cn>
> > Message-Id: <20240624033319.999631-1-lixianglai@loongson.cn>
> > Signed-off-by: Song Gao <gaosong@loongson.cn>
> > ---
> >   include/hw/loongarch/virt.h | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/include/hw/loongarch/virt.h b/include/hw/loongarch/virt.h
> > index 8fdfacf268..603c1cebdb 100644
> > --- a/include/hw/loongarch/virt.h
> > +++ b/include/hw/loongarch/virt.h
> > @@ -20,7 +20,7 @@
> >   #define VIRT_FWCFG_BASE         0x1e020000UL
> >   #define VIRT_BIOS_BASE          0x1c000000UL
> >   #define VIRT_BIOS_SIZE          (16 * MiB)
> > -#define VIRT_FLASH_SECTOR_SIZE  (128 * KiB)
> > +#define VIRT_FLASH_SECTOR_SIZE  (256 * KiB)
> 
> Again, I believe this breaks machine migration. See the recent
> example Daniel explained to me:
> https://lore.kernel.org/qemu-devel/Zn6EQ39Q57KtmKPU@redhat.com/

Yes, changing flash size breaks migration compat, but note that loongarch
does not have any versioned machine types, so it has zero migration compat
right now regardles of this change. IOW, now is the right time to make the
change, before someone asks for versioned machines with loongarch.

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


