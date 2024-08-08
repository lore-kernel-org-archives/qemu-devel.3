Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE40AC52D6F
	for <qemu-devel@archiver.kernel.org>; Thu,  8 Aug 2024 14:16:00 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sc3vi-0002cc-QV; Thu, 08 Aug 2024 10:15:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sc3vf-0002bP-01
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:15:47 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sc3vd-00044q-4J
 for qemu-devel@nongnu.org; Thu, 08 Aug 2024 10:15:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1723126543;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JORsPlFcMhn9vgCv/UrVhc1Aj5vpJP+Xjno/2xfw22Q=;
 b=Bw8kwOeg7sRZBMWjznhCImrMxaR4xor0ORfSv1UEOCGXHFrM3oPX209YQiz27ynG2tFJGV
 VPkzZ+WLbXHDeOCg6TriG8x7hjlUqXhj0r1bex6U2s1Hv+e2yC0mwTs/ob36uEZHnNJW6C
 nOuYPHZbvEuTj2FZPCgzYlG+nzaNP0E=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-392-wXxCKOqFN061MUqp2GTMYA-1; Thu, 08 Aug 2024 10:15:42 -0400
X-MC-Unique: wXxCKOqFN061MUqp2GTMYA-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-44fe05a4b61so887991cf.0
 for <qemu-devel@nongnu.org>; Thu, 08 Aug 2024 07:15:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1723126540; x=1723731340;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=JORsPlFcMhn9vgCv/UrVhc1Aj5vpJP+Xjno/2xfw22Q=;
 b=ux8iosLP7FodKZ1Szgqs0OadVzm1U2iX7rnDMWxj7rPxJqs+JMH1W3xQj8+VYal9TF
 yqLsiZPSORE80rCmkZ5ZLdg7OwtpyPSpHMOSbzC7HIPF4j9JJuMj75KY/iRJCpld6/HQ
 BBloMEtMoWOLb59zJGdqOVI54n+a0qrwjtlvdLqRSCl2UEQiXmtEBmEPEAN9ao/1gkXo
 8/kv24FuiaBG0N3ouOlvSLzOuklp87GbfRdHSoq97/yV/pMwHfuYYXQa4qGIlMwSBvor
 F8WpaAoARAyKlWJAOUpDnHKBpJ0y7lPyP523l07tKI+7Exk3hjt3UqebwixixVQb6eYu
 yyXg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV1DjOppF/xvXfvQr72TpoShTfgqSUblSLsidPWRCcl5JIBJs2ucy+mfcgws8JDbshl2a9KW5Uv9gM1@nongnu.org
X-Gm-Message-State: AOJu0Yw8f/E+7WceLSnKgrABcvmkj7ZtkOwAD/s8txXDCdeyZnrAFwTR
 so2BSjU9Yj4NcduHlwSksvEWtjDQHnIXi4Ngq2WPgtYALTHl95iDIlOGG+sgVJ3Cb1n+kn2b5Wo
 7Wlp6YMd0o3eYobJKnRJwjrWLoyheY4ILyFgEMMmpbAPV5yUnDv6o
X-Received: by 2002:a05:622a:1883:b0:44f:d7b5:a665 with SMTP id
 d75a77b69052e-451d41fddd7mr11453151cf.1.1723126540388; 
 Thu, 08 Aug 2024 07:15:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGsPl3rDj8lNcMR0YhvaUXqXW2HxEklprAxMAS/21EhyE2JXVya5OnsFFsLzXgI51pIEMU7fw==
X-Received: by 2002:a05:622a:1883:b0:44f:d7b5:a665 with SMTP id
 d75a77b69052e-451d41fddd7mr11452861cf.1.1723126539970; 
 Thu, 08 Aug 2024 07:15:39 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 d75a77b69052e-451c87f6fcesm13510841cf.89.2024.08.08.07.15.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 08 Aug 2024 07:15:39 -0700 (PDT)
Date: Thu, 8 Aug 2024 10:15:36 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Akihiko Odaki <akihiko.odaki@daynix.com>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 jasowang@redhat.com, sriram.yagnaraman@est.tech, sw@weilnetz.de,
 qemu-devel@nongnu.org, yan@daynix.com,
 Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZrTTCIpXLmW8c5Kv@x1n>
References: <cb71a6de-eb7a-402b-a58a-89198b4343f5@daynix.com>
 <20240805041650-mutt-send-email-mst@kernel.org>
 <c7447c6c-0562-4e0f-bc1b-61a1430c9852@daynix.com>
 <20240805060544-mutt-send-email-mst@kernel.org>
 <2b62780c-a6cb-4262-beb5-81d54c14f545@daynix.com>
 <20240806092822-mutt-send-email-mst@kernel.org>
 <890f9d0a-3ded-488d-b274-8be9c38b5df3@daynix.com>
 <20240808065339-mutt-send-email-mst@kernel.org>
 <274ccd97-a473-4937-a57b-0029a18069c9@daynix.com>
 <20240808070912-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240808070912-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.141,
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

On Thu, Aug 08, 2024 at 07:12:14AM -0400, Michael S. Tsirkin wrote:
> This is too big of a hammer. People already use what you call "cross
> migrate" and have for years. We are not going to stop developing
> features just because someone suddenly became aware of some such bit.
> If you care, you will have to work to solve the problem properly -
> nacking half baked hacks is the only tool maintainers have to make
> people work on hard problems.

IMHO this is totally different thing.  It's not about proposing a new
feature yet so far, it's about how we should fix a breakage first.

And that's why I think we should fix it even in the simple way first, then
we consider anything more benefitial from perf side without breaking
anything, which should be on top of that.

Thanks,

-- 
Peter Xu


