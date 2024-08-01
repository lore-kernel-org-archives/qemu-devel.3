Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43DE6C3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 15:17:09 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZXXL-0001pe-4B; Thu, 01 Aug 2024 11:16:16 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXX9-0001l7-1R
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:16:03 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZXX5-0004Ud-1T
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 11:16:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722525356;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rRoDzwBktkh0UDgck2YVOkgDajJoaVTGlX/1qv/sUSQ=;
 b=SPjP4QQ2V1GIvvdEoFikv96pbRnJ8GXqxtjYtvm4szShP+RlbYcAfunmlKikCh6CSi381u
 ooQq3gEhkC/pLvqQWwdT342SI/b7daCu4VosqRvePDWCOHvw6yXk2P1tWfB2/F2m9LknIx
 u5qmm5AQOrde4u2wccfkh9LWhqGQZh4=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-628-EDzrzY63ME6PEvVPkdeAZg-1; Thu, 01 Aug 2024 11:15:54 -0400
X-MC-Unique: EDzrzY63ME6PEvVPkdeAZg-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-a7d63fbf4afso497066766b.2
 for <qemu-devel@nongnu.org>; Thu, 01 Aug 2024 08:15:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722525354; x=1723130154;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rRoDzwBktkh0UDgck2YVOkgDajJoaVTGlX/1qv/sUSQ=;
 b=cswGAW4C2yE1T7iqZafnvkmtC0MbrWNntPM1fAyRxNXwT+Jauo3wx5iuqrhQq1nRcv
 Co2T2e5RRTf85t0jPIPrzTfeDGbBdsc0wzK0TpFWfAvlzqZXlMZ7lRu2qydHi/Qhm7Pu
 NER/KeUdf17gU3pbeYEHrXYz/pbOliwP62lSPiPtBAg6zFX72UAoEr7cgosh/bI1oJdW
 2YtEbbgw3DicEuNxEqva9UwDuaDjX4bs4FgIa3eSK0RwmqRykV4G/B0Zzy7j3Z6Ah7qd
 FZN479ZcHwLqSmXV42QNWBRd8a66IUhkwXbuKZt+Ssog0ad8PzB7+ybAAM8VSbw3/y0r
 UULw==
X-Forwarded-Encrypted: i=1;
 AJvYcCXjIUraccM7vhkHAcf1PMfD8Zk6ttFRnEeA37dXbH2U+hpbD6yaiHLO79B1PPoddkMlHNydAmyx3LX3uMmhr2I0Et1OKMU=
X-Gm-Message-State: AOJu0YxkAbp2i7fLZA3DUnB9qqHXD4JQ4rxF3WmK6VVOVLuCHW8qSNKI
 N9+FKhEo2nSqbtlkI21xhJzHiwBBAL27UZEu57SM1PY2FURX2hc7kCTyBaR3dfSa9DruMzau3cx
 o7bUUKFweKygk9shU3B0ZG7hCT17Qu0JwHAbGg3Gg2G3YJmIwgpKL
X-Received: by 2002:a17:907:9410:b0:a7a:8522:5eec with SMTP id
 a640c23a62f3a-a7dc509fd36mr41435966b.53.1722525353698; 
 Thu, 01 Aug 2024 08:15:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGJgOzbUCnPrqX6J13qM4Mx4p+alU2Z2Tpr224FZMTcjDb66YQ1aeUGXjHczFRlL3hJZ57SXg==
X-Received: by 2002:a17:907:9410:b0:a7a:8522:5eec with SMTP id
 a640c23a62f3a-a7dc509fd36mr41431666b.53.1722525352826; 
 Thu, 01 Aug 2024 08:15:52 -0700 (PDT)
Received: from redhat.com ([2a02:14f:176:b4e2:f32f:7caa:572:123e])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acad41616sm912539566b.137.2024.08.01.08.15.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Aug 2024 08:15:52 -0700 (PDT)
Date: Thu, 1 Aug 2024 11:15:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801111435-mutt-send-email-mst@kernel.org>
References: <ZqO7cR-UiGpX2rk0@redhat.com> <ZqQLbGxEW3XT7qL-@x1n>
 <Zqe8C9AfaojKHM8A@redhat.com> <ZqfKrtQSSRVnEOGt@x1n>
 <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <39a8bb8b-4191-4f41-aaf7-06df24bf3280@daynix.com>
 <ZqumIZcs1tCNTpRE@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZqumIZcs1tCNTpRE@x1n>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.131,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Aug 01, 2024 at 11:13:37AM -0400, Peter Xu wrote:
> Do we really concern about users not enabling features that much?  I
> thought users always can manually change the XML and add whatever they
> need, and device properties do not like too special here to me.  I mean, we
> have bunch of "features" exported as new "-devices" and users must opt-in
> for them by changing the XML.  We never worried on user not using them.  I
> doubt whether we worried too much on user not opt-in, especially for
> performance features, because they're, IMHO, targeting advanced users.

What I do not like, is pushing the knowledge of what good defaults
are to libvirt.

-- 
MST


