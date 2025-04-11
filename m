Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1EE4C36010
	for <qemu-devel@archiver.kernel.org>; Fri, 11 Apr 2025 16:34:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u3HJs-0004qK-Gy; Fri, 11 Apr 2025 12:33:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3HJn-0004nK-L8
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:33:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <eblake@redhat.com>) id 1u3HJk-0004r7-VZ
 for qemu-devel@nongnu.org; Fri, 11 Apr 2025 12:33:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1744389203;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=+rMsmzsVChofULFlaScDnlkm7h9HEgut+4e9/gQA2LA=;
 b=Sn/7znaTJpbLLmPujhyiY5RGpD0nSKOpvdJHXn5TAUG1h0YcwwQrbeHN6HaD6TijenGVBw
 LN5JoLXNofUmSulI2/WfxFZjzahsysxHLHLfaP1M3ca3pQBIvlyyOhPWnRtF/3tt6rpuRb
 FeePO5KT8NegvnryXeH7lerQk42GhQk=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-22-wdSANvviPGC0qD8E8OgGuw-1; Fri,
 11 Apr 2025 12:33:16 -0400
X-MC-Unique: wdSANvviPGC0qD8E8OgGuw-1
X-Mimecast-MFC-AGG-ID: wdSANvviPGC0qD8E8OgGuw_1744389195
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id A19AC180899B; Fri, 11 Apr 2025 16:33:14 +0000 (UTC)
Received: from redhat.com (unknown [10.2.16.33])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 666543001D15; Fri, 11 Apr 2025 16:33:12 +0000 (UTC)
Date: Fri, 11 Apr 2025 11:33:09 -0500
From: Eric Blake <eblake@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: qemu-devel@nongnu.org, Fam Zheng <fam@euphon.net>, 
 qemu-block@nongnu.org, Hanna Czenczek <hreitz@redhat.com>, 
 Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH 1/2] file-posix: probe discard alignment on Linux block
 devices
Message-ID: <yioauqg25egnwn24a5fitput2vedfc43b4bykscfqohxapr6rt@h2tn4uew5qmn>
References: <20250409182914.4725-1-stefanha@redhat.com>
 <20250409182914.4725-2-stefanha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250409182914.4725-2-stefanha@redhat.com>
User-Agent: NeoMutt/20250113
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=eblake@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.681,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Wed, Apr 09, 2025 at 02:29:13PM -0400, Stefan Hajnoczi wrote:
> Populate the pdiscard_alignment block limit so the block layer is able
> align discard requests correctly.
> 
> Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
> ---
>  block/file-posix.c | 56 +++++++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/block/file-posix.c b/block/file-posix.c
> index 56d1972d15..2a1e1f48c0 100644
> --- a/block/file-posix.c
> +++ b/block/file-posix.c
> @@ -1276,10 +1276,10 @@ static int get_sysfs_zoned_model(struct stat *st, BlockZoneModel *zoned)
>  }
>  #endif /* defined(CONFIG_BLKZONED) */
>  
> +#ifdef CONFIG_LINUX
>  /*
>   * Get a sysfs attribute value as a long integer.
>   */
> -#ifdef CONFIG_LINUX
>  static long get_sysfs_long_val(struct stat *st, const char *attribute)

Random change to pull the comment inside of the #if, but tangentially
related so I don't mind keeping it here.

>  {
>      g_autofree char *str = NULL;
> @@ -1299,6 +1299,30 @@ static long get_sysfs_long_val(struct stat *st, const char *attribute)
>      }
>      return ret;
>  }
> +
> +/*
> + * Get a sysfs attribute value as a uint32_t.
> + */
> +static int get_sysfs_u32_val(struct stat *st, const char *attribute,
> +                             uint32_t *u32)
> +{
> +    g_autofree char *str = NULL;
> +    const char *end;
> +    unsigned int val;
> +    int ret;
> +
> +    ret = get_sysfs_str_val(st, attribute, &str);
> +    if (ret < 0) {
> +        return ret;
> +    }
> +
> +    /* The file is ended with '\n', pass 'end' to accept that. */
> +    ret = qemu_strtoui(str, &end, 10, &val);
> +    if (ret == 0 && end && *end == '\0') {
> +        *u32 = val;
> +    }
> +    return ret;
> +}
>  #endif

May be worth amending this line to "#endif /* CONFIG_LINUX */" now
that it is further from the opening #if.

Reviewed-by: Eric Blake <eblake@redhat.com>

-- 
Eric Blake, Principal Software Engineer
Red Hat, Inc.
Virtualization:  qemu.org | libguestfs.org


