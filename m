Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5282BC3DA45
	for <qemu-devel@archiver.kernel.org>; Thu, 11 Jul 2024 17:06:19 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sRxEm-0005wv-GM; Thu, 11 Jul 2024 13:05:44 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRxEl-0005vX-7T
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 13:05:43 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1sRxEi-0007v4-GH
 for qemu-devel@nongnu.org; Thu, 11 Jul 2024 13:05:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1720717538;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:in-reply-to:in-reply-to:  references:references;
 bh=/pIjUuvBEBj2Yo68/QpOZHICYA+8RrGS3qplIda5JbE=;
 b=N7rWPHIVh1FtyTNpBcIkJbcx5QWhJ1pjlVhd5EEF8mfu8toF+cC3TemvjaBR4Hr8PwXLFc
 f2BulL3p30ezmGFHpvRPbs0kODLQWWab/may8gsajt4/C6C829Q0HWGd3JrzGNL52jHrJY
 LVbOUHvvSE+PjQszFvviTHC19AhVrRc=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-351-l1ygLPVlNSC8jux_Ft8E6w-1; Thu,
 11 Jul 2024 13:05:32 -0400
X-MC-Unique: l1ygLPVlNSC8jux_Ft8E6w-1
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D15AB1944D30; Thu, 11 Jul 2024 17:05:29 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.51])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CA43319560AE; Thu, 11 Jul 2024 17:05:26 +0000 (UTC)
Date: Thu, 11 Jul 2024 18:05:23 +0100
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: junjiehua <halouworls@gmail.com>
Cc: qemu-devel@nongnu.org, Akihiko Odaki <akihiko.odaki@daynix.com>,
 Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 junjiehua <junjiehua@tencent.com>
Subject: Re: [PATCH] contrib/elf2dmp: a workaround for the buggy
 msvcrt.dll!fwrite
Message-ID: <ZpAQ01k2JhOtSeRI@redhat.com>
References: <20240708112520.106127-1-junjiehua@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240708112520.106127-1-junjiehua@tencent.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.142,
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

On Mon, Jul 08, 2024 at 07:25:20PM +0800, junjiehua wrote:
> when building elf2dump with x86_64-w64-mingw32-gcc, fwrite is imported from
> msvcrt.dll. However, the implementation of msvcrt.dll!fwrite is buggy:
> it enters an infinite loop when the size of a single write exceeds 4GB.
> This patch addresses the issue by splitting large physical memory
> blocks into smaller chunks.
> 
> Signed-off-by: junjiehua <junjiehua@tencent.com>
> ---
>  contrib/elf2dmp/main.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/contrib/elf2dmp/main.c b/contrib/elf2dmp/main.c
> index d046a72ae6..1994553d95 100644
> --- a/contrib/elf2dmp/main.c
> +++ b/contrib/elf2dmp/main.c
> @@ -23,6 +23,8 @@
>  #define INITIAL_MXCSR   0x1f80
>  #define MAX_NUMBER_OF_RUNS  42
>  
> +#define MAX_CHUNK_SIZE (128 * 1024 * 1024)
> +
>  typedef struct idt_desc {
>      uint16_t offset1;   /* offset bits 0..15 */
>      uint16_t selector;
> @@ -434,13 +436,22 @@ static bool write_dump(struct pa_space *ps,
>  
>      for (i = 0; i < ps->block_nr; i++) {
>          struct pa_block *b = &ps->block[i];
> +        size_t offset = 0;
> +        size_t chunk_size;
>  
>          printf("Writing block #%zu/%zu of %"PRIu64" bytes to file...\n", i,
>                  ps->block_nr, b->size);
> -        if (fwrite(b->addr, b->size, 1, dmp_file) != 1) {
> -            eprintf("Failed to write block\n");
> -            fclose(dmp_file);
> -            return false;
> +
> +        while (offset < b->size) {
> +            chunk_size = (b->size - offset > MAX_CHUNK_SIZE)
> +                         ? MAX_CHUNK_SIZE
> +                         : (b->size - offset);
> +            if (fwrite(b->addr + offset, chunk_size, 1, dmp_file) != 1) {
> +                eprintf("Failed to write block\n");
> +                fclose(dmp_file);
> +                return false;
> +            }
> +            offset += chunk_size;
>          }
>      }

When reading the original ELF file, we don't actually fread() it,
instead we mmap it, using GMappedFile on Windows. Rather than
working around fwrite() bugs, we could do the same for writing
and create a mapped file and just memcpy the data across.


With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


