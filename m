Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2372DECE579
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 14:56:44 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snfod-0007U5-2e; Mon, 09 Sep 2024 10:56:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfoZ-00078G-Kf
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:56:27 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1snfoY-0007Kc-8x
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 10:56:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1725893785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BuxrjxHGQTYa+u1Cw9dei7iRdM/WtZ08bIlmaNCMj08=;
 b=HZyE54FPjAW3HN8Z7gdr2INf75eDsOdZc9Yho/+7+4vCmueu6URQ6l6obR+deGxPsPcmwr
 yi+n1katNkdacMow5WEaoTeVUuLq+uUFyzIf1fwKnQqbpww2Cy1QSs+haJhZdZFaBtQZaG
 uIFdIyOQKhyILYj+qKZd3eJ+6gfBON8=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-_4K64KqgMzOqHsVQDaJmVQ-1; Mon, 09 Sep 2024 10:56:24 -0400
X-MC-Unique: _4K64KqgMzOqHsVQDaJmVQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46e09a7af769-7092fa5079eso3681141a34.2
 for <qemu-devel@nongnu.org>; Mon, 09 Sep 2024 07:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725893783; x=1726498583;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BuxrjxHGQTYa+u1Cw9dei7iRdM/WtZ08bIlmaNCMj08=;
 b=mwenDxrK0nP5KZ5QVOEwddaY2czNDtiP2QQ1zNoRPSx+7lzYDezDO64zaCBQQ1S0MV
 qPXZkORQjWaRFi7peDzpjyNTg6jl/rAK6LnUPgqL+EY1MFFPNXL6rEf8bsyOBTe2v2F5
 zkPBSl35x0IiqJBGFFQyBzsySB7bPBkf9NxXCVh9LbZQ5Cy08kSl5iFpFwRaN6wxNLm+
 dRWUgthYAFWH7NT8AaFMTui7PEMw9SQX/SWaoEhGp4mWpWcWc1GWSR++uuuxw/M/fBXO
 YuAILyvqh+Tbg4NWwLhu+gBBJPSd70YlRgMOVXoh5ccEd8cgvs5SypJxIeiAMCG6UUp5
 H4hA==
X-Forwarded-Encrypted: i=1;
 AJvYcCUprcUWyQ4b0mff68FFxBnK/ieW1Dy6RSgzhJ3CjmO2J9U+F7FOO+EJ7GDUg39Cd+0K6nuy0odtsAaj@nongnu.org
X-Gm-Message-State: AOJu0Yz1EUh69y1t0EXx80RKi+fajcNn/xxZjbAB3nXor2ClJFChekpI
 Cetu2eR8WIPdepA3VG1GRkbd/EwDjdO8sPdWjOKmiQ3Wp+riPpU9Vfcv2bOutqhzQ/QR/I8qAO8
 kmX2RCtAetluQS4+MS/DwaOOajT6MK3KPMJ4S+jqyT5OjjCBJTuyfP6ya5462sCk=
X-Received: by 2002:a05:6830:2d83:b0:710:db4f:8efd with SMTP id
 46e09a7af769-710db4f9120mr3627986a34.21.1725893783610; 
 Mon, 09 Sep 2024 07:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGdSRsTKXUhnMGuJ+2I1MrhtXfyGuMAZ/BfquaG4fN9wh7xvdjOHKToS73c18rB960UMQBESQ==
X-Received: by 2002:a05:6830:2d83:b0:710:db4f:8efd with SMTP id
 46e09a7af769-710db4f9120mr3627959a34.21.1725893783275; 
 Mon, 09 Sep 2024 07:56:23 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-45822e8ba52sm20936421cf.38.2024.09.09.07.56.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Sep 2024 07:56:22 -0700 (PDT)
Date: Mon, 9 Sep 2024 10:56:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Yichen Wang <yichen.wang@bytedance.com>
Cc: Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 =?utf-8?Q?Marc-Andr=C3=A9?= Lureau <marcandre.lureau@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Eric Blake <eblake@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Hao Xiang <hao.xiang@linux.dev>, "Liu, Yuan1" <yuan1.liu@intel.com>,
 "Zou, Nanhai" <nanhai.zou@intel.com>,
 "Ho-Ren (Jack) Chuang" <horenchuang@bytedance.com>,
 Xiaoning Ding <xiaoning.ding@bytedance.com>
Subject: Re: [PATCH v9 0/5] Implement QATzip compression method
Message-ID: <Zt8MlDBb5Kfn6v12@x1n>
References: <20240830232722.58272-1-yichen.wang@bytedance.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240830232722.58272-1-yichen.wang@bytedance.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Fri, Aug 30, 2024 at 04:27:17PM -0700, Yichen Wang wrote:
> v9:
> - Rebase changes on top of cec99171931ea79215c79661d33423ac84e63b6e;
> - Address comments and add Review-by in commit messages; 

queued, thanks.

-- 
Peter Xu


