Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 961B1CFC516
	for <qemu-devel@archiver.kernel.org>; Sat, 22 Nov 2025 01:56:15 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vMcjE-0000H8-7L; Fri, 21 Nov 2025 20:47:58 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbSh-0006Cz-9g
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:26:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vMbSV-0003PM-St
 for qemu-devel@nongnu.org; Fri, 21 Nov 2025 19:26:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1763771173;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=2SVWp3UcHLJlx8vgRa9P5kdSxFYaBZ5YKy42Qimtdds=;
 b=aYcm1/pa/e2Kdb7OYRXpyKLIpCWUV36bDK6LbUBYm0sf3XVQiXdDPF37amaBKjwAd2vPJb
 JalzEPJf+KIeNPT5wCORWyuEbVBIqDX56lUDwSxSfCBREoIuJWZW9D+/8nXwp/5KaZ/W7+
 VrdubzfQ3JjXT1injujZEX7/61Kurok=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-146-i4BH3fQ3NuOqUqy74ErssQ-1; Fri, 21 Nov 2025 11:07:53 -0500
X-MC-Unique: i4BH3fQ3NuOqUqy74ErssQ-1
X-Mimecast-MFC-AGG-ID: i4BH3fQ3NuOqUqy74ErssQ_1763741273
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-8b2de6600c0so716866085a.1
 for <qemu-devel@nongnu.org>; Fri, 21 Nov 2025 08:07:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1763741273; x=1764346073; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=2SVWp3UcHLJlx8vgRa9P5kdSxFYaBZ5YKy42Qimtdds=;
 b=HqJA/AxlQr7IcNacgN4N9OmTvZI+TSlRi+IQMpaqkCQAt4btVnj7v3fIGov1Tw+GPV
 7nbR3tyYSP7hbUbySwXr7yc4GG7UELVTDehVXAFDlAA4kqXL9B1muPKiN2qxbaOPvV7X
 z8YX8289CdkLU5ptbTibPZwodE+GijS7uoMD1X5hCvff3vkDxUCtAOrbKSEOzzKziUk6
 b3VPLC7jNa0Cvt2UNF4oWoCVIJ1L+nqiZQbzeI7DEogNAnmwMVVG/8D5XXiD2Guq4Dmj
 Hrm8DkKO7LhzClIqd0foxLwHczPlRpjZuyuJ22iG3o5aVOz/BfEpBxM1i56m00nsiDa1
 RH+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1763741273; x=1764346073;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2SVWp3UcHLJlx8vgRa9P5kdSxFYaBZ5YKy42Qimtdds=;
 b=mBAHQuxz8O68gSxRINgnILvdD+KiLRRIgtdx0MpKjqwFQ1I3UomXJhGEU4qOiVcs3D
 krTnK0/tBCo1Erctcu0YtV2EKJZZvrOZyXqyboNU/tbQcGuM27O2dZ94aYjrZ5EMi3MD
 MGTJxZfA5mpJ8s49SmhlQ9bzUmxEx+NlfTFwU0zwO4GmGxbLUGXSCHKLIARsIunIIC2G
 uKcTIbrZCYkSOtF9GVX9BNDKAKpYYIc4Jb7P12D65y5TaMDaMZTuVP6qYHZOiMYuY3hp
 n7DV3V11mdSHCDgUX60kIhy0CRapwC5Ae+n5SkL0TqkPLqU91ggDTVhCFPtvE9iaQ4+Q
 RQfw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXw0YsZrz0q+fVfiBiw8uNdEQObvu1bC6a8j9VOGdTRvL6GEJ4pQ29remFmOd00323m+UIcuh7TPBPs@nongnu.org
X-Gm-Message-State: AOJu0YysnL7Hkl+PHsN8hQxc9rbpeS8OlwLpCBuWDTquInWEkoKGcXoJ
 LVVKEA66ord/ENoEeFC2CghCt/zqoBGYLKpifAFvXhU03/YFqjvKTpEhqFWc08f0jf0RK4rhydc
 OzLgDb14905S8bX73jCP8GEl1XSpTZD1uBRQKh5We7P+0/9iPWbAFo7hx
X-Gm-Gg: ASbGnctetwqIMMPACfRJnPbCYmBOjHPMQqdUdcn4wqqcNVEU11uFgs/9y5GGVteAtFE
 pRuh/Y+GNbx5VxfBbtS2Zst1bfdOq9xsL0SkBWq71ugI/pWfq1F92I9a8Vh7P3pvMbOGmDYE33i
 jTn+btp1W0ZrFxR9t+mQBEPPko9mLpdct7o2inCzpVffDXooJMSAlq4Dl0G+FWxlFki7/PGAbcn
 qwXaYY/SK037/tYDBE3Ti5Fpvytx6MomK3b9TFC9dY61+AR0qFdIGzkL4pqd6vCmMgppL/NEJOw
 zxil80e9oJWcX1+hmLuh6fGtlFiOo+TwH/1xvuoEyviaepKOcv6UUxHFfUIIS0a7gcuX0CNjbGU
 4nhM=
X-Received: by 2002:a05:622a:594:b0:4ee:1676:faa6 with SMTP id
 d75a77b69052e-4ee58854020mr43460611cf.20.1763741272551; 
 Fri, 21 Nov 2025 08:07:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGxeLyAnN1PobIUBKAJvWUIt6z5UHPOlRiwhy03n29bh+9Vw1MSQpnPwZ0apZwyEdxIcKt3+Q==
X-Received: by 2002:a05:622a:594:b0:4ee:1676:faa6 with SMTP id
 d75a77b69052e-4ee58854020mr43458431cf.20.1763741270631; 
 Fri, 21 Nov 2025 08:07:50 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8b32e82eb0dsm346727085a.5.2025.11.21.08.07.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Nov 2025 08:07:50 -0800 (PST)
Date: Fri, 21 Nov 2025 11:07:48 -0500
From: Peter Xu <peterx@redhat.com>
To: Ben Chaney <bchaney@akamai.com>
Cc: berrange@redhat.com, farosas@suse.de, armbru@redhat.com,
 mark.kanda@oracle.com, qemu-devel@nongnu.org, johunt@akamai.com,
 mtottenh@akamai.com, nhudson@akamai.com
Subject: Re: [PATCH] migration: cpr socket permissions fix
Message-ID: <aSCOVNMJ-NK_9PuH@x1.local>
References: <20251120185733.141912-1-bchaney@akamai.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20251120185733.141912-1-bchaney@akamai.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
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

On Thu, Nov 20, 2025 at 01:57:33PM -0500, Ben Chaney wrote:
> Fix an issue where cpr transfer fails when running with the
> -run-with user=$USERID with a permission denied error. This issue
> occurs because the destination host creates the transfer sockets before
> it drops permissions while the source host tries to connect after
> dropping permissions. Fix this by changing the ownership of the cpr
> socket to the lower level so it is accessible to both parties.
> 
> Resolves: https://lore.kernel.org/all/3D32B62F-29E2-4470-86A5-9A2B3B29E371@akamai.com/
> Signed-off-by: Ben Chaney <bchaney@akamai.com>
> ---
>  include/system/os-posix.h |  1 +
>  include/system/os-wasm.h  |  1 +
>  include/system/os-win32.h |  1 +
>  os-posix.c                | 12 ++++++++++++
>  stubs/meson.build         |  1 +
>  stubs/os-file.c           |  6 ++++++
>  util/qemu-sockets.c       |  6 ++++++
>  7 files changed, 28 insertions(+)
>  create mode 100644 stubs/os-file.c
> 
> diff --git a/include/system/os-posix.h b/include/system/os-posix.h
> index ce5b3bccf8..e4b69fc316 100644
> --- a/include/system/os-posix.h
> +++ b/include/system/os-posix.h
> @@ -54,6 +54,7 @@ void os_set_chroot(const char *path);
>  void os_setup_limits(void);
>  void os_setup_post(void);
>  int os_mlock(bool on_fault);
> +void os_set_socket_permissions(const char *path);
>  
>  /**
>   * qemu_alloc_stack:
> diff --git a/include/system/os-wasm.h b/include/system/os-wasm.h
> index 3abb3aaa03..eeac092183 100644
> --- a/include/system/os-wasm.h
> +++ b/include/system/os-wasm.h
> @@ -57,6 +57,7 @@ static inline int os_set_daemonize(bool d)
>  };
>  bool is_daemonized(void);
>  static inline void os_daemonize(void) {}
> +static inline void os_set_socket_permissions(const char *dummy) {};
>  
>  /**
>   * qemu_alloc_stack:
> diff --git a/include/system/os-win32.h b/include/system/os-win32.h
> index 22d72babdf..79e42ec297 100644
> --- a/include/system/os-win32.h
> +++ b/include/system/os-win32.h
> @@ -103,6 +103,7 @@ static inline void os_setup_post(void) {}
>  static inline void os_set_proc_name(const char *dummy) {}
>  void os_set_line_buffering(void);
>  void os_setup_early_signal_handling(void);
> +static inline void os_set_socket_permissions(const char *dummy) {};
>  
>  int getpagesize(void);
>  
> diff --git a/os-posix.c b/os-posix.c
> index 52925c23d3..bbd17ff2b9 100644
> --- a/os-posix.c
> +++ b/os-posix.c
> @@ -94,6 +94,18 @@ static struct passwd *user_pwd;    /*   NULL   non-NULL   NULL   */
>  static uid_t user_uid = (uid_t)-1; /*   -1      -1        >=0    */
>  static gid_t user_gid = (gid_t)-1; /*   -1      -1        >=0    */
>  
> +void os_set_socket_permissions(const char *path)
> +{
> +    uid_t uid = user_pwd ? user_pwd->pw_uid : user_uid;
> +    gid_t gid = user_pwd ? user_pwd->pw_gid : user_gid;
> +
> +    if (chown(path, uid, gid) < 0) {
> +        error_report("Failed to chown socket %s: %s", path, strerror(errno));
> +        exit(1);
> +    }
> +}
> +
> +
>  /*
>   * Prepare to change user ID. user_id can be one of 3 forms:
>   *   - a username, in which case user ID will be changed to its uid,
> diff --git a/stubs/meson.build b/stubs/meson.build
> index 0b2778c568..4a4342344b 100644
> --- a/stubs/meson.build
> +++ b/stubs/meson.build
> @@ -24,6 +24,7 @@ if have_block
>    stub_ss.add(files('ram-block.c'))
>    stub_ss.add(files('runstate-check.c'))
>    stub_ss.add(files('uuid.c'))
> +  stub_ss.add(files('os-file.c'))
>  endif
>  
>  if have_block or have_ga
> diff --git a/stubs/os-file.c b/stubs/os-file.c
> new file mode 100644
> index 0000000000..c32cbc7efa
> --- /dev/null
> +++ b/stubs/os-file.c
> @@ -0,0 +1,6 @@
> +/* SPDX-License-Identifier: GPL-2.0-or-later */
> +#include "qemu/osdep.h"
> +
> +void os_set_socket_permissions(const char *dummy)
> +{
> +}
> diff --git a/util/qemu-sockets.c b/util/qemu-sockets.c
> index 4773755fd5..77b2d9287b 100644
> --- a/util/qemu-sockets.c
> +++ b/util/qemu-sockets.c
> @@ -1026,6 +1026,12 @@ static int unix_listen_saddr(UnixSocketAddress *saddr,
>          error_setg_errno(errp, errno, "Failed to bind socket to %s", path);
>          goto err;
>      }
> +    /*
> +     * Change the permissions on the socket to match the permission of the
> +     * counterparty process
> +     */
> +    os_set_socket_permissions(un.sun_path);

QEMU's -run-with described user= as:

  user=username or user=uid:gid can be used to drop root privileges before
  starting guest execution. QEMU will use the setuid and setgid system
  calls to switch to the specified identity...

So it explicitly mentioned "before starting guest execution", hence at
least from that doc it's hard to say if unix socket should be created with
the privilege or after dropped..  Here I believe cpr socket should be the
case for latter, however when it's a generic change to unix listening
ports, I wonder if there's other unwanted side effects.

Considering unix socket itself doesn't really have a UID attached to it,
it's only the unix path that needs a chmod(), meanwhile the mgmt of course
knows both the right UID (as specified in -run-with) and the path, would it
make sense if the mgmt chmod() after it starts dest QEMU?  That'll reduce
the scope of impact to minimum.

Thanks,

> +
>      if (listen(sock, num) < 0) {
>          error_setg_errno(errp, errno, "Failed to listen on socket");
>          goto err;
> -- 
> 2.34.1
> 

-- 
Peter Xu


