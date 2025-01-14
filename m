Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AC9AEE77188
	for <qemu-devel@archiver.kernel.org>; Tue, 14 Jan 2025 17:04:57 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tXkKg-0006Sm-JJ; Tue, 14 Jan 2025 12:04:02 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXkJT-0005a0-2u
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:02:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tXkJP-0002jK-7n
 for qemu-devel@nongnu.org; Tue, 14 Jan 2025 12:02:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1736874161;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yqTrnxGXKdYZ9X2hzZTkEOZLA9tQLfHs3mkMSQ1+XWw=;
 b=OscK7x56Jfqln+6zxoegaTOmUTAUYqzDt2lmk7S7z6V/54otkhX1qyo+Gts+1ocNkiMy3o
 CtRmSJ9+3RKYwBCMAh1FeNkzSUEDSiEKOiPpsfKADOM9szUV1yvXglEgW3cz1/j9JIf4r6
 wBdJTt9KB8LrX/9mp/rYRXXydQQodHY=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-153-GtvXd97OMF2BTg4ckj999w-1; Tue, 14 Jan 2025 12:02:37 -0500
X-MC-Unique: GtvXd97OMF2BTg4ckj999w-1
X-Mimecast-MFC-AGG-ID: GtvXd97OMF2BTg4ckj999w
Received: by mail-pl1-f197.google.com with SMTP id
 d9443c01a7336-2167141e00eso105100085ad.2
 for <qemu-devel@nongnu.org>; Tue, 14 Jan 2025 09:02:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736874157; x=1737478957;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yqTrnxGXKdYZ9X2hzZTkEOZLA9tQLfHs3mkMSQ1+XWw=;
 b=UGq9DOv6uLR3UZYU/EH+4YLImLpIeKAHNjR5HcJN/0lZXh+zMrpxiKDaFlYAYWomKd
 /DaGDoCm6QvrcnTNx6GQ09uAIQLj0Xx1CAFkFUli6FP5PayfKRhGfMvHhyCXSV0sMOG0
 U7LyD309EDt213xKw/AwIHSOOoikFceqXW41O8Rtvmy19sx/l7fsPi42p5DOTAHotikB
 Ebj54mg9FWzicBkgkcNPE7PTHj4DhUAM3T1spdEr0P8T43oMHPdGhsXJ/owBoHAyIVZ5
 iWfgFuxmQKou0IkIQAZsh/4hHLm7xI7WxPqGpp4Scy6/0AY7wLvNNrGPDxpISTOo1GT0
 kHbg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXuurguu4GV7x/gJddWhdfR3oeZGP7RuoWQv4BVRflXhje82JL3AGdo+LN0xGcJi6G8cw+UZWZICavz@nongnu.org
X-Gm-Message-State: AOJu0YyzELO2XguxcpOjtg/HA9Nut6VyjKt2ApqDrcP8nZ6dk/5xkTVm
 KKOomybFiJ+CS4A2omZOqNGB4NrreI2lY6/3GZ9hdvjIAkF4205ZQ8DZoeGwnrQBy8gUG3l+gqy
 QqG3SYss9kR26I2N3R/V7stU4ZiQGGmx1qkQWZn4awicHnvG5mktw
X-Gm-Gg: ASbGncu+n7r35LqWvKboFpMyYydG2zdluPLHRUQ4GvWttlnNQa/7Y6yWczllLonZpsr
 7G9QunR0KtwVj4PVbGjSx1fHCCOPn1/oMwewv0PipYS4xte40uOKfZ47rwxB69D/+tbzpg9zFw2
 jBzV1rcVCcwMBdUW7qpoAZImdQElYsla5vWQjnSLta1iWy6N8W5VK4sCT2K82DfqaIZLS2tdbCu
 U40TpoO4Gb6J49TGLIIgZESHHGQEurNG3R08zM+g7BRyE6v/wuBq5ZjDDc/Tx1895lSg02H90tp
 RJ/54EmthIMRJZSQyA==
X-Received: by 2002:a05:6a20:9c9a:b0:1e1:b329:3cd with SMTP id
 adf61e73a8af0-1e88cfd3f72mr38422768637.20.1736874156662; 
 Tue, 14 Jan 2025 09:02:36 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGaoLtfAdn2VDAJwa5cr1K3DONzyz/SPXdAjsCCAD0Ypwa68xfZMEeu837Tgd3Voaq+9+ppbw==
X-Received: by 2002:a05:6a20:9c9a:b0:1e1:b329:3cd with SMTP id
 adf61e73a8af0-1e88cfd3f72mr38422727637.20.1736874156312; 
 Tue, 14 Jan 2025 09:02:36 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-72d40681bd0sm7629721b3a.150.2025.01.14.09.02.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Jan 2025 09:02:35 -0800 (PST)
Date: Tue, 14 Jan 2025 12:02:30 -0500
From: Peter Xu <peterx@redhat.com>
To: Akihiko Odaki <akihiko.odaki@daynix.com>
Cc: BALATON Zoltan <balaton@eik.bme.hu>, Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Yanan Wang <wangyanan55@huawei.com>, John Snow <jsnow@redhat.com>,
 Jiaxun Yang <jiaxun.yang@flygoat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fabiano Rosas <farosas@suse.de>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Thomas Huth <thuth@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-ppc@nongnu.org, devel@daynix.com
Subject: Re: [PATCH v7 1/2] memory: Update inline documentation
Message-ID: <Z4aYpo0VEgaQedKp@x1n>
References: <20250109-san-v7-0-93c432a73024@daynix.com>
 <20250109-san-v7-1-93c432a73024@daynix.com>
 <59e70978-8895-f513-1b5e-1dc599e288ff@eik.bme.hu>
 <Z4AjkXbZeu3T94Y1@x1n> <Z4AldAcucTyqZ0HJ@x1n>
 <811633f6-6bf8-4a22-a21a-789e9a4747d7@daynix.com>
 <Z4E6TnKaUt8FMWIv@x1n>
 <9bb5f964-f930-4428-b800-8b589920fe1d@daynix.com>
 <Z4U30j9w1kPnKX9U@x1n>
 <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <5dc54c92-0382-4a70-9dad-588572698eed@daynix.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.063,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Tue, Jan 14, 2025 at 05:43:09PM +0900, Akihiko Odaki wrote:
> memory_region_finalize() is not a function to tell the owner is leaving, but
> the memory region itself is being destroyed.

It is when the lifecycle of the MR is the same as the owner.  That holds
true I suppose if without this patch, and that's why I don't prefer this
patch because it makes that part more complicated.

> It should not happen when a container is still referencing it. That is
> also why it has memory_region_ref(subregion) in
> memory_region_update_container_subregions() and assert(!mr->container) in
> memory_region_finalize().

Again, the line I added was sololy for what you said "automation" elsewhere
and only should work within MR-links within the same owner.  Otherwise
anyone referencing the MR would hold the owner ref then this finalize()
will never happen.

Now, if I could go back to your original purpose of this work, quotting
from your cover letter:

> I saw various sanitizer errors when running check-qtest-ppc64. While
> I could just turn off sanitizers, I decided to tackle them this time.
> 
> Unfortunately, GLib versions older than 2.81.0 do not free test data in
> some cases so some sanitizer errors remain. All sanitizer errors will be
> gone with this patch series combined with the following change for GLib:
> https://gitlab.gnome.org/GNOME/glib/-/merge_requests/4120

Is check-qtest-ppc64 the only one that will trigger this issue?  Does it
mean that most of the devices will do proper removal of device-owned
subregions (hence, not prone to circular reference of owner refcount)
except some devices in ppc64?

-- 
Peter Xu


