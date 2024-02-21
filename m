Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DD3CC48BF6
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Feb 2024 15:20:46 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rcoNo-0008IT-51; Wed, 21 Feb 2024 10:19:40 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcoKe-0000nB-RC
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 10:16:25 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <berrange@redhat.com>)
 id 1rcklm-00058u-AY
 for qemu-devel@nongnu.org; Wed, 21 Feb 2024 06:28:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1708514886;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ieCsZuSkBI0B+XEaiJ6sclcbNAWk7AmKo+YpAjPn4LY=;
 b=ZqibYyg6Y1SAIW5ZCe9G77Uvcp+b+ewUfWxuuDguB6mvcEtpRIAa6M6PdCd66U/Q+ljGfQ
 cjBrHq+jjrlPkwQw04W8N9z55HN+jSeBJKqlh1Bl07ldsNAa4BhkCMCeg862xm2JGyivjR
 cSEUx16b+AcSfA0a5B+FsFL8RM4JVNE=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-tUB8WiofMWu-3jX_tMuIgQ-1; Wed,
 21 Feb 2024 06:28:03 -0500
X-MC-Unique: tUB8WiofMWu-3jX_tMuIgQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 978E5282D3C6;
 Wed, 21 Feb 2024 11:28:02 +0000 (UTC)
Received: from redhat.com (unknown [10.42.28.53])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id E58882166B32;
 Wed, 21 Feb 2024 11:28:01 +0000 (UTC)
Date: Wed, 21 Feb 2024 11:28:00 +0000
From: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
To: Michael Vogt <michael.vogt@gmail.com>, Laurent Vivier <laurent@vivier.eu>
Cc: qemu-devel@nongnu.org
Subject: Re: [PATCH] linux-user: Add FIFREEZE and FITHAW ioctls
Message-ID: <ZdXeQIK9Cm9AwWJu@redhat.com>
References: <20240220105726.8852-1-michael.vogt@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240220105726.8852-1-michael.vogt@gmail.com>
User-Agent: Mutt/2.2.12 (2023-09-09)
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.129.124; envelope-from=berrange@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.05,
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
Reply-To: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Errors-To: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org
Sender: qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org

Adding the linux-user maintainer to the CC list

On Tue, Feb 20, 2024 at 11:57:21AM +0100, Michael Vogt wrote:
> Add missing FIFREEZE and FITHAW ioctls.
> 
> Signed-off-by: Michael Vogt <michael.vogt@gmail.com>
> ---
>  linux-user/ioctls.h       | 6 ++++++
>  linux-user/syscall_defs.h | 3 +++
>  2 files changed, 9 insertions(+)

Reviewed-by: Daniel P. Berrangé <berrange@redhat.com>

> 
> diff --git a/linux-user/ioctls.h b/linux-user/ioctls.h
> index 071f7ca253..1aec9d5836 100644
> --- a/linux-user/ioctls.h
> +++ b/linux-user/ioctls.h
> @@ -134,6 +134,12 @@
>       IOCTL(FICLONE, IOC_W, TYPE_INT)
>       IOCTL(FICLONERANGE, IOC_W, MK_PTR(MK_STRUCT(STRUCT_file_clone_range)))
>  #endif
> +#ifdef FIFREEZE
> +     IOCTL(FIFREEZE, IOC_W | IOC_R, TYPE_INT)
> +#endif
> +#ifdef FITHAW
> +     IOCTL(FITHAW, IOC_W | IOC_R, TYPE_INT)
> +#endif
>  
>       IOCTL(FIGETBSZ, IOC_R, MK_PTR(TYPE_LONG))
>  #ifdef CONFIG_FIEMAP
> diff --git a/linux-user/syscall_defs.h b/linux-user/syscall_defs.h
> index 77ba343c85..744fda599e 100644
> --- a/linux-user/syscall_defs.h
> +++ b/linux-user/syscall_defs.h
> @@ -943,6 +943,9 @@ struct target_rtc_pll_info {
>  #define TARGET_FICLONE    TARGET_IOW(0x94, 9, abi_int)
>  #define TARGET_FICLONERANGE TARGET_IOW(0x94, 13, struct file_clone_range)
>  
> +#define TARGET_FIFREEZE    TARGET_IOWR('X', 119, abi_int)
> +#define TARGET_FITHAW    TARGET_IOWR('X', 120, abi_int)
> +
>  /*
>   * Note that the ioctl numbers for FS_IOC_<GET|SET><FLAGS|VERSION>
>   * claim type "long" but the actual type used by the kernel is "int".

> -- 
> 2.43.0
> 
> 

With regards,
Daniel
-- 
|: https://berrange.com      -o-    https://www.flickr.com/photos/dberrange :|
|: https://libvirt.org         -o-            https://fstop138.berrange.com :|
|: https://entangle-photo.org    -o-    https://www.instagram.com/dberrange :|


