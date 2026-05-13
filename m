Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D875ECD37AC
	for <qemu-devel@archiver.kernel.org>; Wed, 13 May 2026 17:33:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wNDSi-0007Sc-N8; Wed, 13 May 2026 13:33:36 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNDSg-0007Pp-Qf
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:33:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wNDSe-0003bc-Sk
 for qemu-devel@nongnu.org; Wed, 13 May 2026 13:33:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778693609;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qx+MCH1jOirGA1rg4svkjHSeydIKhVIQalsTR40fxdo=;
 b=TI77u2dDSJMl3fJ7zFNLXr5VD4jQWRLU0unO0xLUJwOknwFqcduMi5ZU9+L5tPnCXAXOsn
 MmIDyKq2TeJLhAsI8i2eyYkSuWdwSvvlJr3aJyKNnf3pStjrCZhc7mDABw6mfMpamLyWhO
 Ous6XzDhXYKOjWDmDvrXNxoq4gGp7BI=
Received: from mail-qk1-f198.google.com (mail-qk1-f198.google.com
 [209.85.222.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-348-waV5ZfLJNEiKMaKrOEYxxA-1; Wed, 13 May 2026 13:33:28 -0400
X-MC-Unique: waV5ZfLJNEiKMaKrOEYxxA-1
X-Mimecast-MFC-AGG-ID: waV5ZfLJNEiKMaKrOEYxxA_1778693608
Received: by mail-qk1-f198.google.com with SMTP id
 af79cd13be357-90f74de8cbcso246126285a.3
 for <qemu-devel@nongnu.org>; Wed, 13 May 2026 10:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778693608; x=1779298408; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=qx+MCH1jOirGA1rg4svkjHSeydIKhVIQalsTR40fxdo=;
 b=ABd3TrnWU0fu9785C4lrl/+ZPl/CEingmU7O6VYQbgchdMAdnB+vqnIfMEsjB464Gh
 thFIGMOtRE+6hSurbe3WJpupmVXHQ/2B/SBF5Q9M7YcUXgnr0zgDpM3e5mVOeWfjbOg9
 Y7eNCzLh2vLfZEMyai3JscYSjlCKbC7XkdMlAIJWxBtY09RxUre5QVLYng/wpusBQKHR
 ZkDScFRmLlPMfmjsD8HSU1IL0oOr2FkeBKcPl6TwIiYU+p8W5XPk12PBkmnBgv35LdwM
 iqqUgYXy8BGmVvLSaj5+ZGfTLAFhFRt+M5/WrIMAAKNvBS58LBxu+6dU6zocxvZqQhaK
 FBbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778693608; x=1779298408;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qx+MCH1jOirGA1rg4svkjHSeydIKhVIQalsTR40fxdo=;
 b=BHRZpeXZRGSNzXuKv3fNUfhNJVdpeWex5tLQ3l5Mfr7u7ACHpC9dPYFzXYk0Ke1JZ1
 tQmmEaPgjVoODzg6fh2do5jZ3Y13YKOMOwcnwcg2n3jeEcuXHLDaOvbrmiPn68T69zks
 lTqcOjBKhUCs+AoQyF0H8W1gqvraKp1bgTnKex2lSq4CBd3TfiLtDOsUSB2GY8KIIMbB
 oQALQPQbFitGp7XuohXEG7ddHHulWDUhcWGlqqRX1Exwo0aZ3DatapdPIYZFkWPNorJk
 147m4KQjbWOCE3O4qkZzKgqzDs4uu6ZyO8tfiupWsL0Hmx1gFflr+aLYlQ7uPjy2v3tC
 UrBw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+KIjRIXC35dtV02Jckt9XfXny5WQiUtlWQmlm5qKsM4d7ilFizzjJwjBHwfMwQ1PBE1nWpi2ha+I5t@nongnu.org
X-Gm-Message-State: AOJu0YwkbztmvnK3kUgYXXMHrX3+W6Z0IiR59TVNh/2l7Jx2rXyeMz4/
 WsBOT1HkRy5vXpBKgQ995G7kUxEPYdbGEBVYYqfHvT78czz8trSftD13+kiua49b/gl+l1W7bMJ
 LXs2W9NPI5Lcr7RHecfI/fiY+ikPE7LIjE3EtgueOtn+ShyOM/2gBPFf1
X-Gm-Gg: Acq92OFfl86B1uu9SJaJSwaERS8pO1rs7Rh2ULn0ivG3DvsykYaEN9bu7hW2k92/Is1
 EOZR6X4EnZ2m3wN6HNd04tOUdrTghQoC+DvtAithYH9o3kYJTJKPxpazmf7k3G+hdEfdNZFarDz
 PlBOWiMn19LvHM6/QrCAJSnt0RfMF/XEsxHgHT+kk0MeRygRIr/0Ujo/1SD/2ZUcMyX3tTDhZJ9
 YaujkZknxoh/rsioDaPR+kKT/+MrBqMqmaKrYBlYZPvX2pNvFpdumh9aNXyyFbEI6vAX39JoAuU
 mA/RBttjLs5vQpDJYQW95NC5Zql+oCuY87A8m9TLwj7FsHiIZzzH606xG07P/3+oA3ktv9TOuYV
 hWyu3Uz3yWCJf8KBMaASPPjgpaqV2R9k5t6lQBi8G+HMkGNM=
X-Received: by 2002:a05:620a:1792:b0:8ec:9b8f:496a with SMTP id
 af79cd13be357-90f8ad0988cmr647812185a.51.1778693607784; 
 Wed, 13 May 2026 10:33:27 -0700 (PDT)
X-Received: by 2002:a05:620a:1792:b0:8ec:9b8f:496a with SMTP id
 af79cd13be357-90f8ad0988cmr647806185a.51.1778693607244; 
 Wed, 13 May 2026 10:33:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-910bd623819sm13190785a.43.2026.05.13.10.33.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 13 May 2026 10:33:26 -0700 (PDT)
Date: Wed, 13 May 2026 13:33:25 -0400
From: Peter Xu <peterx@redhat.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Fabiano Rosas <farosas@suse.de>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Mark Kanda <mark.kanda@oracle.com>, Ben Chaney <bchaney@akamai.com>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH] MAINTAINERS: Make Maciej CPR maintainer
Message-ID: <agS15W8pjLObplLz@x1.local>
References: <ebe67053f4bdf92eedab1e5839603b7137e36970.1778687091.git.maciej.szmigiero@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <ebe67053f4bdf92eedab1e5839603b7137e36970.1778687091.git.maciej.szmigiero@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Wed, May 13, 2026 at 05:46:10PM +0200, Maciej S. Szmigiero wrote:
> From: "Maciej S. Szmigiero" <maciej.szmigiero@oracle.com>
> 
> Since Steve has retired last year I will take the CPR maintainership - with
> kind help of Mark who remains a reviewer.
> 
> Cc: Mark Kanda <mark.kanda@oracle.com>
> Signed-off-by: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ad215eced84d..dacb332bb65d 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3177,6 +3177,7 @@ T: git https://gitlab.com/jsnow/qemu.git jobs
>  T: git https://gitlab.com/vsementsov/qemu.git block
>  
>  CheckPoint and Restart (CPR)
> +M: Maciej S. Szmigiero <maciej.szmigiero@oracle.com>
>  R: Peter Xu <peterx@redhat.com>
>  R: Fabiano Rosas <farosas@suse.de>
>  R: Mark Kanda <mark.kanda@oracle.com>

queued, thanks Maciej.

-- 
Peter Xu


