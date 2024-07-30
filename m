Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0D2A4C3DA7F
	for <qemu-devel@archiver.kernel.org>; Tue, 30 Jul 2024 20:04:22 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sYt4k-0003ux-QY; Tue, 30 Jul 2024 16:04:02 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYt4j-0003uR-Hm
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 16:04:01 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sYt4i-0000i3-4A
 for qemu-devel@nongnu.org; Tue, 30 Jul 2024 16:04:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722369839;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hCykBHPQtbFgqhMa8aLcTMwPvfiQJUzR6qRJmlZxXDY=;
 b=ZGzca9D4sBXqA7AYwC4Ya3OSnLc/Tgpxbrk9KOqCR/DI6Y2LA2hN97OdsLhk0EfclODstl
 cUY0UeJQO3d5i46H0iAfb3nTfrnLyTeVYdl3OJcyMsC+QWCdru7s5R7xLZdpHrC9f7Q1+8
 9wAcggmFT4xNIHiYaQSDXH6A2IOUNUw=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-404mGPPqNru8LbxvrqPFfg-1; Tue, 30 Jul 2024 16:03:57 -0400
X-MC-Unique: 404mGPPqNru8LbxvrqPFfg-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6b79ccc1504so6989556d6.3
 for <qemu-devel@nongnu.org>; Tue, 30 Jul 2024 13:03:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722369836; x=1722974636;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hCykBHPQtbFgqhMa8aLcTMwPvfiQJUzR6qRJmlZxXDY=;
 b=fITHXpHtvWd7RxKq3mBYxSMW5XssLA+fo8gkJm9K12To3EOKt8z0InvPUO+mvwA4e0
 lGQW8j31kXSPqJcu+kTkfGHc0ClXqamGx+f2WS/SrdTiVbv4jGDf44poawRpMeCABk/+
 pG5u8oBxkdPjNr5gjCoVdyUEoL+BBAErSlkXoCw7SX7s2UMqmlhyIN6eT2+jkZrHZoz5
 vOascV9cKd0baj2lATbVSccHICDITx/6A8Hp4Ii0jTe8F/mZ/T+jh3t9PM4iQONAGbGB
 5gJdb7BmuE/CMQIrri8wS6266OXKXkWqBPBE7mhA5ZxQ/a5l+/Ajw45Mu4sUzaQe4+x3
 OJTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXKAi3piQGXcsj004QPcfove2AfNFQhBik14RRbqQzAeWWSwi54NOs9e5ep4oaMgWerAh5RiDar35V0Z69ffmHVn5AWflo=
X-Gm-Message-State: AOJu0YwVw12/70Mu6AxctGYckPOmANEVaTWWJsxnnNuQuZBPKSVi96hc
 9krG8HAfh7do2I6+iSqmGpp2uyLigUkGgist9nwGKZwpjr0BKTkGVaWRJ2gB4vcxDUWI84OGJMI
 0+2aVRLRvPVGnysJhhBs/G5A5DVW+/9ZONzzJ2F1SP8Nz7PJMyDtJTc2dVMh9
X-Received: by 2002:a05:620a:44d0:b0:79f:44d:2b8a with SMTP id
 af79cd13be357-7a1d696513emr1435418885a.5.1722369836110; 
 Tue, 30 Jul 2024 13:03:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IF7yqZVffvJkmz1+yrE0VTUlo70P3gghbF/tF81Lh1XQxLoecLpFZeVvfWPXMFHJgCWEkxMjw==
X-Received: by 2002:a05:620a:44d0:b0:79f:44d:2b8a with SMTP id
 af79cd13be357-7a1d696513emr1435416085a.5.1722369835759; 
 Tue, 30 Jul 2024 13:03:55 -0700 (PDT)
Received: from x1n (pool-99-254-121-117.cpe.net.cable.rogers.com.
 [99.254.121.117]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7a1d745f404sm667323385a.131.2024.07.30.13.03.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Jul 2024 13:03:55 -0700 (PDT)
Date: Tue, 30 Jul 2024 16:03:53 -0400
From: Peter Xu <peterx@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <ZqlHKaQXzKGcnoBM@x1n>
References: <ZqO2HvFJ8v7hZFOd@x1n> <ZqO7cR-UiGpX2rk0@redhat.com>
 <ZqQLbGxEW3XT7qL-@x1n> <Zqe8C9AfaojKHM8A@redhat.com>
 <ZqfKrtQSSRVnEOGt@x1n> <ZqfQ0cGf8t2trEdl@redhat.com>
 <ZqktXwxBWjuAgGxZ@x1n> <Zqk09BGxlpdxMBMx@redhat.com>
 <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20240730151746-mutt-send-email-mst@kernel.org>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.125,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On Tue, Jul 30, 2024 at 03:22:50PM -0400, Michael S. Tsirkin wrote:
> This is not what we did historically. Why should we start now?

It's a matter of whether we still want migration to randomly fail, like
what this patch does.

Or any better suggestions?  I'm definitely open to that.

Thanks,

-- 
Peter Xu


