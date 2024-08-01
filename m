Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 667FBC3DA64
	for <qemu-devel@archiver.kernel.org>; Thu,  1 Aug 2024 05:35:35 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sZOSX-0002Xc-Jd; Thu, 01 Aug 2024 01:34:41 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOSV-0002WH-EN
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:34:39 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <mst@redhat.com>) id 1sZOST-0005VL-FD
 for qemu-devel@nongnu.org; Thu, 01 Aug 2024 01:34:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1722490476;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GMrgDhMfc9CKt2gVVjNvRvfVLKwiESGIuWn3Ez2J56A=;
 b=iiK1DFR3QdyuksoRs3CP0RpuB3o5w3t1ncLuhK3ROqfcY262mgy0g+6G0807OnWVRnplQF
 t15aIRRfZzMydRUQPUoaf0KaV5P7U4RQPmcgvpN+dyV3aNH3SB1bN9656Qyw9W3G9iOn9m
 1mLnQyCKgK2taCooXa+Okmd2CxDgnCA=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-597-tKWfv9NqN02hsx77SYNTjw-1; Thu, 01 Aug 2024 01:34:34 -0400
X-MC-Unique: tKWfv9NqN02hsx77SYNTjw-1
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-a7d2f42df2dso227980366b.1
 for <qemu-devel@nongnu.org>; Wed, 31 Jul 2024 22:34:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1722490473; x=1723095273;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GMrgDhMfc9CKt2gVVjNvRvfVLKwiESGIuWn3Ez2J56A=;
 b=Mz49ivN2cawz24+whqiQzudxos/0pyJdLQdQSLkhZ9UWh4U32bq1XqjzfmpzqxxA+/
 dp4TUOOrRojPUiu+Sa7UZF4LM38ODS+seaIqr8x/CPbusjCiCcVRoE9G7ENfnaCjrYkS
 xnBZv1S9rRBnq2bCsjc9vXbknQxqBJJljHAnAFSTa3z+MG9VxCIgIX1HQJh5g1oFcIyz
 +a4DP5iPSCYrYafsrEUeFdWccroPavfhOwGw9MT740kgqpFUpxOXvE3ughPEVfo346Rd
 Q0f/8hjvlsoQV/YVMRuI3kLk2MTtADsfEfXKsqRuM0IU6YLWwGknDl5CktOcNvHIIdcn
 6elw==
X-Forwarded-Encrypted: i=1;
 AJvYcCU65JMnDcflcdz9WNvz9vyFiyZceByPDSfxc48AOAkDW9Ykj4d6m081zOUDJFPgtK81HLiHcqoKw7dF6O6he+4htT3ul7Q=
X-Gm-Message-State: AOJu0Yz9Aee8f1cGnPXZs10/eZ5FsWXyqPE+kGRcByry+FpgdF9z171U
 uGBR5btI9BWULXBlbmQ33cqsTGuZ1tRRn00jNdAfVTavecWVOSi0Eh5W6iu+nHQlhdVmj96n2bB
 TRpNzmpiZzZ2osD3F65wceZSDMaIgb8S2vLmW2efB0uHzw7fBDiiZ
X-Received: by 2002:a17:907:6e87:b0:a7a:b26d:fb5 with SMTP id
 a640c23a62f3a-a7dbcc28512mr16630666b.19.1722490472925; 
 Wed, 31 Jul 2024 22:34:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoksaLjNM5+JVeONY/yIZsg8LYpulT3X6jto6/mRvGLG7FbFONsGhL53/tU9yuM2bW3cEiMA==
X-Received: by 2002:a17:907:6e87:b0:a7a:b26d:fb5 with SMTP id
 a640c23a62f3a-a7dbcc28512mr16628366b.19.1722490472097; 
 Wed, 31 Jul 2024 22:34:32 -0700 (PDT)
Received: from redhat.com ([2.55.44.248]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a7acab23125sm848450966b.1.2024.07.31.22.34.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Jul 2024 22:34:31 -0700 (PDT)
Date: Thu, 1 Aug 2024 01:34:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Daniel =?iso-8859-1?Q?P=2E_Berrang=E9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>,
 Yuri Benditovich <yuri.benditovich@daynix.com>, eduardo@habkost.net,
 marcel.apfelbaum@gmail.com, philmd@linaro.org,
 wangyanan55@huawei.com, dmitry.fleytman@gmail.com,
 akihiko.odaki@daynix.com, jasowang@redhat.com,
 sriram.yagnaraman@est.tech, sw@weilnetz.de, qemu-devel@nongnu.org,
 yan@daynix.com, Fabiano Rosas <farosas@suse.de>, devel@lists.libvirt.org
Subject: Re: [PATCH v2 4/4] virtio-net: Add support for USO features
Message-ID: <20240801012923-mutt-send-email-mst@kernel.org>
References: <ZqfQ0cGf8t2trEdl@redhat.com> <ZqktXwxBWjuAgGxZ@x1n>
 <Zqk09BGxlpdxMBMx@redhat.com> <Zqk6x2nd3Twz--75@x1n>
 <20240730151746-mutt-send-email-mst@kernel.org>
 <ZqlHKaQXzKGcnoBM@x1n>
 <20240730172148-mutt-send-email-mst@kernel.org>
 <Zqnh-AJC4JPl5EkS@redhat.com>
 <20240731033803-mutt-send-email-mst@kernel.org>
 <Zqo00Na1MZpksY9A@x1n>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Zqo00Na1MZpksY9A@x1n>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=mst@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.126,
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

On Wed, Jul 31, 2024 at 08:57:52AM -0400, Peter Xu wrote:
> > 
> > The right solution is to have a tool that can query
> > backends, and that given the results from all of the cluster,
> > generate a set of parameters that will ensure migration works.
> > Kind of like qemu-img, but for migration.
> 
> This is adding extra work, IMHO.

Agreed that it's a lot of work.

> If we stick with "qemu cmdline as guest ABI" concept, I think we're all
> fine, as that work is done by QEMU booting up first on both sides,
> including dest.  Basically Libvirt already plays this role of the new tool
> without any new code to be added at all: what captured on the boot failure
> log will be the output of that tool if we write it.

However, this means we can never add new features without
also teaching libvirt to enable them.


How about we add some kind of command on source qemu
to return description of all working features?
Then when qemu is started on destination, this data can be passed in,
and validated.

Hmm?

-- 
MST


