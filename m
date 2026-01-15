Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 447CED4662F
	for <qemu-devel@archiver.kernel.org>; Thu, 15 Jan 2026 22:40:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vgW0K-0002Sp-Ji; Thu, 15 Jan 2026 17:39:48 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgW0I-0002ST-Rw
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:39:47 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vgW0H-0005RN-Ab
 for qemu-devel@nongnu.org; Thu, 15 Jan 2026 17:39:46 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768516782;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=NY+2aCMh3NYlRsGa9SEjnigGHfPfupg6xjuyMyhdeWI=;
 b=SQDZBHKx+eu27PXr+o2CqvWFhi4qH3iFIA/694OCwSqCFKiu6hzSr0GZvP6bB9tp/UHD5+
 o8w2sQ1NraDWfeyO9/blOxTUD/UOKDmwV5m70CfOrrflgn4V3mHwK2swYpdLlBL6hZBKAO
 CyzDMUWD0zCu8DR/2Mk787/qpFQZ4Z4=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-241-iE0y1n67PZyu8G8WGM6qpw-1; Thu, 15 Jan 2026 17:39:41 -0500
X-MC-Unique: iE0y1n67PZyu8G8WGM6qpw-1
X-Mimecast-MFC-AGG-ID: iE0y1n67PZyu8G8WGM6qpw_1768516781
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-8c5296c7e57so541209485a.1
 for <qemu-devel@nongnu.org>; Thu, 15 Jan 2026 14:39:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1768516781; x=1769121581; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=NY+2aCMh3NYlRsGa9SEjnigGHfPfupg6xjuyMyhdeWI=;
 b=ccsoFL+/HToNoeTmtHtZS7b1otSDRbwwC00lxrgpphEPU7JhFbeElG9Yu3DXiGRK7a
 gEW/XZw0TOHaIpMDUKCgiEB7I3g4FdAw1pV9kl9eKLS0h+ItWa7Aipj9d+yCGe1ZtQoP
 Q+TM6ldWBbtU0H7UsxlI0sqt5fveDKq31OHMA8ZWZDWVwa6vZBFkgqK7sLwBLM61wdh0
 vpuAwg8lUVryiPRwyU8wNDN+9qbfaK9a2be9wUyHB0empw848u1v1Sa3U5rsqxtHWtXS
 h2VhewN1lKJq4ErpewtbVTzi3TMxuIdV71Mc0njtAQ6fbQ7Q1ycAJWADiUXk4ELG5Fr6
 r5+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1768516781; x=1769121581;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=NY+2aCMh3NYlRsGa9SEjnigGHfPfupg6xjuyMyhdeWI=;
 b=XF7x/tHCo+tb9hRIB9iOtl7guBIzAezDpYy7Dx5RDyaEr0hPf01YtQ30FDzklxCxs/
 QlTJmCnqubMfAlUpqDK9air5Clc2FRWUm6UsR1WT2Bs+hHjna5sFSaSC29PtC+oiTRjh
 +YZT7lLiSkEBnE9Bk1y9kVMwaKDZ+Cwny5J5foyn5SVq5lPFeH0lt0CF0UsD684CwnpI
 +k5HwAMN/7efzO7tf4XRsxoulgr3q86HAuHxMuft3hg9wB01Kgd3fHAU+bVmc26mxoXw
 aIvB8k/Ll4p9pqOcip2+KU7k0ecjuuQibuCDSjMp6T1pZPmXcENH6dIXH5mVI/Qu87vv
 fNHQ==
X-Gm-Message-State: AOJu0YxRjsTEyHW/1O08NtiLuIQqvafub5s0rhieNLVcW1Bm+l8LN/F5
 4VGyKx1ZPn2vH/2fjubc5SnyvAddQRQSZcjhkqbJHYHMmh3148Qh8p5WXij1wW/5jRIE/Wtj+Y8
 UjGHRgBevh+BXYtHb2LRpveFdQaCpQ9ci4+/CGBlHr7frlQwoSGmV9JTj
X-Gm-Gg: AY/fxX4avNN0ga5S1uxPdNIi6hcm4mr/lz2HvBlslJhcCkppqrYvBZrUd6yQhBNB5Lz
 XGknkE8pJ3iOnOAYEwWohnpACquoV+BIacSY9h4poSOMOTP1wHWlJ/HBgHtalOYD6i4+40EIfJd
 n8pA4Y4D82U0bsMyn3ddYtD+4cMpgi0yks2wWYB7AtMK8Hi5NQAN1R5mNkb3y16BcmcfTaMe3Nh
 WDycfEjYHx96uzmpf6v327TSycZutFoivSnRh5kS2vnHePNfAZoCQIG9+ohMsGlnozjcPKvaa+Y
 GiI5gzuUO17KhMlyTrvFesfAU20/Sd99Q7quSU7umiKU5dG+EXVhhQv5XJ/EluA0rH9aoqpP+UN
 NdrE=
X-Received: by 2002:a05:620a:710c:b0:8b2:edc8:13d0 with SMTP id
 af79cd13be357-8c6a68ec805mr153658485a.17.1768516780828; 
 Thu, 15 Jan 2026 14:39:40 -0800 (PST)
X-Received: by 2002:a05:620a:710c:b0:8b2:edc8:13d0 with SMTP id
 af79cd13be357-8c6a68ec805mr153656085a.17.1768516780399; 
 Thu, 15 Jan 2026 14:39:40 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71ab272sm70740885a.2.2026.01.15.14.39.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Jan 2026 14:39:39 -0800 (PST)
Date: Thu, 15 Jan 2026 17:39:31 -0500
From: Peter Xu <peterx@redhat.com>
To: Lukas Straub <lukasstraub2@web.de>
Cc: qemu-devel@nongnu.org, Juraj Marcin <jmarcin@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aWlso1w39cQnEh2t@x1.local>
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260115224929.616aab85@penguin>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

On Thu, Jan 15, 2026 at 10:49:29PM +0100, Lukas Straub wrote:
> Nack.
> 
> This code has users, as explained in my other email:
> https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#mc99839451d6841366619c4ec0d5af5264e2f6464

Please then rework that series and consider include the following (I
believe I pointed out a long time ago somewhere..):

- (Working) unit test for COLO migration

- Some form of justification of why multifd needs to be enabled for COLO.
  For example, in your cluster deployment, using multifd can improve XXX
  by YYY.  Please describe the use case and improvements.

- Maintainer file to replace Hailiang in his role (unless Hailiang could
  reply before you send it)

- Please consider converting COLO-FT.txt to .rst, and maybe we should also
  move it over to devel/migration/, then add an index in the index.rst.

IMHO we should either merge a series at least covers above in 11.0, or we
drop it.

Thanks,

-- 
Peter Xu


