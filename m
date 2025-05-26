Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 977F9C5AD49
	for <qemu-devel@archiver.kernel.org>; Mon, 26 May 2025 13:10:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uJXaU-0005TG-QV; Mon, 26 May 2025 09:09:54 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJXaR-0005Sq-IA
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:09:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uJXaP-0006ql-32
 for qemu-devel@nongnu.org; Mon, 26 May 2025 09:09:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1748264985;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hkSoRY3EBwp5HF9z5hIgQXHuHrxZ1VI6o6Kei/2BAEY=;
 b=HDHrzlMmKLDnlbi4CBVWJ0Ol7A9QGYLbmWAPNLf6ysHM2JuZw22rreWWiKcr9V57TTAuBz
 9Fse6mvgeIzu/z5QIHBi407O67V63ozpsoP3yW3kCgNIZpJMoqrZEqU1cNqIvoru/k5CF1
 4pjfKdQuD/NtIvRRujieiR1c7zIkFik=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-8-06B7uXHMNlihkdESQPi6Ow-1; Mon, 26 May 2025 09:09:44 -0400
X-MC-Unique: 06B7uXHMNlihkdESQPi6Ow-1
X-Mimecast-MFC-AGG-ID: 06B7uXHMNlihkdESQPi6Ow_1748264984
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-6f8d47383f3so38111766d6.1
 for <qemu-devel@nongnu.org>; Mon, 26 May 2025 06:09:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1748264984; x=1748869784;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hkSoRY3EBwp5HF9z5hIgQXHuHrxZ1VI6o6Kei/2BAEY=;
 b=NXThGWkY6ikityjljyWBjS602JT63LXDcwq47yEHab9hpINt5nsA8d08D/de+FSlBM
 iWe6vPKRZebHeW/AOyNInIMyww4ZzVty4v3j3tdOZ6sagq/R51QzvC3Ms0DTr29/4K2K
 DJf0A3BY/Hlth/BgKoES2k/lemyh0C4defN8/IqSgPa4BsjoIG8193nX83XK2pOfeVMj
 PH0baP/C0X/SfVdzRj5fxiadwVK4OgZiSXPWche5l3FeZTwfrNTfyfz87rUVkoHFRAy7
 cvPLv0Zu3ifC1a2UKPn/evhOpdkwiNoTlXcNZqTwdaTr8wSv4s++j/yByu80NvFDYczA
 iVqQ==
X-Gm-Message-State: AOJu0YzodexPtA8WlB65esL4R/3eoJ6NU45Li6PTabnhJDCyY3/vYK/f
 cae5rTyXDq9Wsk3JpQea5a6vU4AdNJvUF/avGHl0DEBfefWIgzRsnjH3BViqvaQtKAWnjBSkCaz
 TxcRw87HMcLlnfPjfEuc4K4UlfobOG/QPMz51xnKL6bmrqBul28ARQEst
X-Gm-Gg: ASbGncv/H0W5xflsoZhr6FiIf+2DAkuNu8PrZAAEn6jKsUTVon2lm3ffn5VfjLSIq0/
 pilBR1MhUajQijElJXfK05pzCaHXiN2K7ue2zGpOqwZcXtpXHoHik8IOgjMEXx/NCJAHIPC2qPc
 NzLP5B1ChAoyZzCGUxikMmrBRuDtwGvXZYLiHdnK7aWrm5p6cgq2MUFGkziwFbo3gJi5I251zZU
 aoZa7zca8mmo6yI4CdoNtbX4/7FGryq7IhrbXQJyaw85IU0NzqQZM37XCIJNFogjeCbfimbG/ex
 6gs=
X-Received: by 2002:a05:6214:da3:b0:6f8:c2b9:b1f7 with SMTP id
 6a1803df08f44-6fa9d016529mr157729596d6.13.1748264983768; 
 Mon, 26 May 2025 06:09:43 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEZo8VGJ2MttjmTX5ob4JxU+Kmzz74fgpalud7cydTeHZsJh4YzbrbhJ/ZwAYo0eZ8uywYZmA==
X-Received: by 2002:a05:6214:da3:b0:6f8:c2b9:b1f7 with SMTP id
 6a1803df08f44-6fa9d016529mr157729286d6.13.1748264983414; 
 Mon, 26 May 2025 06:09:43 -0700 (PDT)
Received: from x1.local ([85.131.185.92]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-6faa317b357sm26029926d6.23.2025.05.26.06.09.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 May 2025 06:09:42 -0700 (PDT)
Date: Mon, 26 May 2025 09:09:40 -0400
From: Peter Xu <peterx@redhat.com>
To: Fabiano Rosas <farosas@suse.de>
Cc: qemu-devel@nongnu.org, Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>
Subject: Re: [RFC PATCH 04/13] migration: Fix parameter validation
Message-ID: <aDRoFH-oXq_AiJCP@x1.local>
References: <20250411191443.22565-1-farosas@suse.de>
 <20250411191443.22565-5-farosas@suse.de>
 <aCZVolkNMBZb5KvC@x1.local> <87r00g61n5.fsf@suse.de>
 <87o6vk5yu3.fsf@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <87o6vk5yu3.fsf@suse.de>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -49
X-Spam_score: -5.0
X-Spam_bar: -----
X-Spam_report: (-5.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-2.903,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, May 22, 2025 at 02:39:48PM -0300, Fabiano Rosas wrote:
> Actually, this doesn't work...
> 
> The migrate-set-* commands have optional fields, so we need some form of
> checking has_* to know which fields the user is setting. Otherwise
> MigrationSetParameters will have zeros all over that will trip the
> check.
> 
> Then, we need some form of checking has_* to be able to enventually get
> the values into s->config (former s->parameters/capabilities), otherwise
> we'll overwrite the already-set values with the potentially empty ones
> coming from QAPI.
> 
> Then there's also the issue of knowing whether a value is 0 because the
> user set it 0 or because it was never set.
> 
> We also can't apply an invalid value to s->config and validate it after
> because some parameters are allowed to be changed during migration.

What I meant was we only conditionally ignore the has_* fields in below:

  (1) migrate_params_check(), so that QEMU always checks all parameters in
      the MigrationParameters* specified when invoking the function.

  (2) MigrationState.parameters, so that as long as the parameters are
      applied (it should only happen after sanity check all pass..) then we
      ignore these has_* fields (until MigrationState.parameters can have a
      better struct to not include these has_* fields).

We can keep the has_* checks in migrate_params_test_apply() and
migrate_params_apply(), so that we won't touch the ones the user didn't
specify in the QMP commands as you said.

The benefits of having above 1/2 ignoring has_* is some code removal where
we assume has_* always are TRUEs.

This can be still a bit confusing, but at least we don't need to init has_*
fields in migrate_params_init() anymore as they'll be all ignored, then
there's no chance we forget set TRUEs to any new params either.

-- 
Peter Xu


