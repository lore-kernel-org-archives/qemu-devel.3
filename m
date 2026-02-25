Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD999FD3779
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Feb 2026 17:31:05 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vvIiT-00037c-Ks; Wed, 25 Feb 2026 12:30:29 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvIiL-00030z-99
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:30:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vvIiJ-0000za-QG
 for qemu-devel@nongnu.org; Wed, 25 Feb 2026 12:30:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1772040617;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xXBwWwjhgRwGRlx5d7QrWiVJmzOpabC+Hw01kUy2WEI=;
 b=jA+B3t3jQtXVqbyrsMmBi4E9vOJc/xBKz16nfr1LThcWZ9OyuGfTrg/gvgyOdvhQfdmmkN
 UE277OJEozvdCVzKTDepBaod0Y7Dh3ZhsdEZRddhx7aFe947+vvru2jxBTTOn0Upc1uRA7
 y53H3MdDd9cR+IP703dFeCNn0S3ZXkM=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-287-n0ES1mgyMZmTAkOSCvORfw-1; Wed, 25 Feb 2026 12:30:12 -0500
X-MC-Unique: n0ES1mgyMZmTAkOSCvORfw-1
X-Mimecast-MFC-AGG-ID: n0ES1mgyMZmTAkOSCvORfw_1772040612
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-506b3fb32a1so661715901cf.0
 for <qemu-devel@nongnu.org>; Wed, 25 Feb 2026 09:30:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1772040612; x=1772645412; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=xXBwWwjhgRwGRlx5d7QrWiVJmzOpabC+Hw01kUy2WEI=;
 b=gH4QBSJx0CKz2d90RNT7H2Th4MOIzHWbq4z3Fy4qHgJqhDnofSeU1RVqx5/bcahuT4
 XBVIJ7iqoXtBpSC+pIR10meCS4Eyf1hwWuuul1UFsBQVR6CDFREHKof8MXgaOaWL+NSt
 dZxbJTM6gGMKeKiwx3GZ4EYNnX27IBrJove9cfEujjTnzEF7kDeln+kmpHo76MS/DDmW
 R2TexvVjGOQ1fos+QGL2KHFVHh6FsvycTDIZMKLC/1LkDYB31gp4VJmV5anXgQkrEi7w
 12ZaHigQumjakD/lwmPgr4BHivAKOxAdWy04DboWCJgnON1bPXV8AE+TnMEPZ+8oQ7Sq
 QVbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772040612; x=1772645412;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=xXBwWwjhgRwGRlx5d7QrWiVJmzOpabC+Hw01kUy2WEI=;
 b=PUOf+QOdNk6H1vUugM0hjMFJUrt9ce7b8f/uieu7n87aCgU6SfQkvmSjPHCmI2pFqN
 ZY9oOx/VPltmumADK6DJ315QfazsXswyKmQ2XZxt3pZdcuwN1reiiz3xVbLZ7cFTMQKt
 hFOMemtLNweI+16bqzXzzC6y1tG1XIpYfScWrvBhnWy7zqhslrFAp3+Ra9UbAY0uSw2c
 cob0SiHEY4bp94Qw61zLX7Mj5GWejS+LSwxIBPkOZ2qWsWMAad/YKNM2eCglU82n7QEN
 PH6U35WYD84/EC0gZ6ZRychqLORBt2s0wOU46hvyZ0nIafkusfyX6ZOzP3bqd3TVUIjl
 2tWg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXxIdsHQjSZwG975EfcTjhKSoZXnXp4BupvxldmrbKxYsBptRYQldEybYRdOb0+2E4N5N6mzqekPX8J@nongnu.org
X-Gm-Message-State: AOJu0YzkxdH2YRACqL7W5MVuW8/sYLKSo0bah1Bk4p9t0hY+rieTktuN
 hhe0vIqgXZEoe+4SCZ+92umxjqPT4/bw0LQSGf9K7MpAy5xx1Zd5lwY04wFiC9l2+jzPtfipzfD
 793219zx5L5FPI/5xRYil33c4Ty1ZPeXceyos02pVnWLIU7YeDYokj2+Z
X-Gm-Gg: ATEYQzyLvSqCzziYqm31+ID0S4wIpgB/DA1RgMIDxaD0EW63Mu9L7uz2e6IQQsKMuoa
 OcxPDdNg6PM6l5GCx8GYlq2+Nj7c926U0yTtuXjso4ziILjBRywxyUqcE+0aL7LX70dVRICu/iQ
 9t3kfxEhCqjD6Lz2oniKUS2saicXC7me/dOAlCh/vDl17LIz9zwpIX1YP5qnkeK6uury+kwhDm9
 NIK/qD8XTqkOGN+8esCvts2KNjz3v0WyyPj9jLsYbSgPNUm8/dDAOxm246hVEUdRtrlCAuwJVhx
 Tv4pboYciv8VhAht5GND6mkYO0dc/pwZXyi84k7PZxRTuDmaeE9sdaXncLJEPR5K+J9m+kYdW85
 qqPwJixM4UFuzbQ==
X-Received: by 2002:ac8:5dce:0:b0:4ee:4a3a:bd1c with SMTP id
 d75a77b69052e-50741fcbb67mr17023481cf.63.1772040611750; 
 Wed, 25 Feb 2026 09:30:11 -0800 (PST)
X-Received: by 2002:ac8:5dce:0:b0:4ee:4a3a:bd1c with SMTP id
 d75a77b69052e-50741fcbb67mr17022731cf.63.1772040611177; 
 Wed, 25 Feb 2026 09:30:11 -0800 (PST)
Received: from x1.local ([174.91.117.149]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-5070d582c1esm130816391cf.15.2026.02.25.09.30.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Feb 2026 09:30:10 -0800 (PST)
Date: Wed, 25 Feb 2026 12:29:58 -0500
From: Peter Xu <peterx@redhat.com>
To: Ani Sinha <anisinha@redhat.com>
Cc: Fabiano Rosas <farosas@suse.de>, kraxel@redhat.com, pbonzini@redhat.com,
 ani@anisinha.ca, Prasad Pandit <pjp@fedoraproject.org>,
 qemu-devel@nongnu.org
Subject: Re: [PATCH v6 35/35] migration: return EEXIST when trying to add the
 same migration blocker
Message-ID: <aZ8xlrL2xQtoN9MI@x1.local>
References: <20260225035000.385950-1-anisinha@redhat.com>
 <20260225035000.385950-36-anisinha@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260225035000.385950-36-anisinha@redhat.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -5
X-Spam_score: -0.6
X-Spam_bar: /
X-Spam_report: (-0.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.734, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.78,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

Hi, Ani,

On Wed, Feb 25, 2026 at 09:19:40AM +0530, Ani Sinha wrote:
> Currently the code that adds a migration blocker does not check if the same
> blocker already exists. Return an EEXIST error code if there is an attempt to
> add the same migration blocker again. This way the same migration blocker will
> not get added twice.

Could you help explain why it will inject two identical errors in the first
place, and why the caller cannot make sure it won't be injected twice?

Thanks,

> 
> Suggested-by: Prasad Pandit <pjp@fedoraproject.org>
> Signed-off-by: Ani Sinha <anisinha@redhat.com>
> ---
>  migration/migration.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/migration/migration.c b/migration/migration.c
> index a5b0465ed3..1eb75fb7fb 100644
> --- a/migration/migration.c
> +++ b/migration/migration.c
> @@ -1702,6 +1702,10 @@ static int add_blockers(Error **reasonp, unsigned modes, Error **errp)
>  {
>      for (MigMode mode = 0; mode < MIG_MODE__MAX; mode++) {
>          if (modes & BIT(mode)) {
> +            if (g_slist_index(migration_blockers[mode],
> +                                 *reasonp) >= 0) {
> +                return -EEXIST;
> +            }
>              migration_blockers[mode] = g_slist_prepend(migration_blockers[mode],
>                                                         *reasonp);
>          }
> -- 
> 2.42.0
> 

-- 
Peter Xu


