Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E033C67861
	for <qemu-devel@archiver.kernel.org>; Sat,  6 Apr 2024 18:35:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rtAs1-000084-Br; Sat, 06 Apr 2024 14:34:29 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rtAs0-00007t-7C
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 14:34:28 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <crobinso@redhat.com>)
 id 1rtAry-00077Y-HZ
 for qemu-devel@nongnu.org; Sat, 06 Apr 2024 14:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1712428465;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=CXaYXIkv93d4a8fO003XRG5whRiFzlAlWuNFOB7UXqU=;
 b=Bsm621t0Z9Uw/nd6CLfJ3w6liGw7TfywFcWDk85OPgPgHbGLAbNC+rY1dP7Ap/pp/M5y2s
 ooWcqMGSh9MwTuuWxsam0o8iJdNUAF9HK34Mg2y4xAOVY7PVjIy1Zh4zLpj9XIpek53UrQ
 A5Z0ibf6VjR6Us62Epejx8/DQhtrxtY=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-650-xpD9Z6tLOpaKU7Vbu7NOzg-1; Sat, 06 Apr 2024 14:34:22 -0400
X-MC-Unique: xpD9Z6tLOpaKU7Vbu7NOzg-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A55841887315
 for <qemu-devel@nongnu.org>; Sat,  6 Apr 2024 18:34:22 +0000 (UTC)
Received: from [10.22.8.77] (unknown [10.22.8.77])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 4322D1C0F120;
 Sat,  6 Apr 2024 18:34:22 +0000 (UTC)
Message-ID: <2b229ef6-788c-4e37-8ba9-385a4266116c@redhat.com>
Date: Sat, 6 Apr 2024 14:34:21 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] pc-bios/optionrom: Fix pvh.img ld build failure on
 fedora rawhide
To: qemu-devel@nongnu.org
Cc: Paolo Bonzini <pbonzini@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>
References: <9c6c64ba1cb113176e755348cf207cb3130fe82b.1706808745.git.crobinso@redhat.com>
Content-Language: en-US
From: Cole Robinson <crobinso@redhat.com>
In-Reply-To: <9c6c64ba1cb113176e755348cf207cb3130fe82b.1706808745.git.crobinso@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=crobinso@redhat.com;
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
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

It doesn't appear this patch is neccessary to build on fedora rawhide
anymore, qemu 9.0.0-rc2 is building fine there

Thanks,
Cole

On 2/1/24 2:36 PM, Cole Robinson wrote:
> binutils 2.39 shows some warnings when building pvh.img
> 
> /usr/bin/ld: warning: pvh.o: missing .note.GNU-stack section implies executable stack
> /usr/bin/ld: NOTE: This behaviour is deprecated and will be removed in a future version of the linker
> /usr/bin/ld: warning: pvh.img has a LOAD segment with RWX permissions
> 
> The latter of which is fatal on Fedora rawhide for some reason.
> 
> This adds linker options to suppress the errors, if ld supports
> the new options.
> 
> Signed-off-by: Cole Robinson <crobinso@redhat.com>
> ---
> v2:
>     - Check if ld supports the options, they are fairly new.
>       Uses the same `ld -v $CHECKOPT` pattern as kernel.git uses
>       Stuffs the overrides in `config-ld.mak` similar to `config-cc.mak`
>       pattern
> 
>  pc-bios/optionrom/Makefile | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
> 
> diff --git a/pc-bios/optionrom/Makefile b/pc-bios/optionrom/Makefile
> index 30d07026c7..87cfc484c7 100644
> --- a/pc-bios/optionrom/Makefile
> +++ b/pc-bios/optionrom/Makefile
> @@ -38,6 +38,16 @@ config-cc.mak: Makefile
>  
>  override LDFLAGS = -nostdlib -Wl,--build-id=none,-T,$(SRC_DIR)/flat.lds
>  
> +ld-test = $(LD) -v $1 >/dev/null 2>/dev/null
> +ld-option = if $(call ld-test, $1); then \
> +    echo "$(TARGET_PREFIX)$1 detected" && echo "override LDFLAGS += -Wl,$1" >&3; else \
> +    echo "$(TARGET_PREFIX)$1 not detected" $(if $2,&& echo "override LDFLAGS += $2" >&3); fi
> +
> +config-ld.mak: Makefile
> +	$(quiet-@)($(call ld-option,--no-warn-rwx-segments); \
> +	    $(call ld-option,--no-warn-execstack)) 3> config-ld.mak
> +-include config-ld.mak
> +
>  pvh.img: pvh.o pvh_main.o
>  
>  %.o: %.S
> @@ -61,7 +71,7 @@ clean:
>  	rm -f *.o *.d *.raw *.img *.bin *~
>  
>  distclean:
> -	rm -f config-cc.mak
> +	rm -f config-cc.mak config-ld.mak
>  
>  # suppress auto-removal of intermediate files
>  .SECONDARY:

- Cole


