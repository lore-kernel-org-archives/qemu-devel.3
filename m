Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E8B5C44500
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 22:22:58 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vigbD-0001Lb-DR; Wed, 21 Jan 2026 17:22:51 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigbB-0001JT-Rg
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:22:49 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1vigb9-0004Oi-6Z
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 17:22:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769034166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMxDlM9yUXOYKiCdeXwepCDs8XDjh+ewttYohU5KrKc=;
 b=BLbzbhRYttqKhVZReJt2XkfR9Wz20tgjTlOzRSjGWYH1mXeNqyi8KCTjurfr6ky2DRZo3a
 9OmGMazyPiVYN+7/AYPO0Z2EsXts/ynXnHLti6HjIpTSjXnevXJGzVOL97NLPRLQEUhQqK
 jF9d34kPUeDSYcRsMDnOjRgS0ye1yzc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-522--cFw5vAyMLaZIOTSSHHc7w-1; Wed, 21 Jan 2026 17:22:44 -0500
X-MC-Unique: -cFw5vAyMLaZIOTSSHHc7w-1
X-Mimecast-MFC-AGG-ID: -cFw5vAyMLaZIOTSSHHc7w_1769034164
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-8c6a87029b6so123688685a.1
 for <qemu-devel@nongnu.org>; Wed, 21 Jan 2026 14:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1769034164; x=1769638964; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=mMxDlM9yUXOYKiCdeXwepCDs8XDjh+ewttYohU5KrKc=;
 b=FhPYGsB6SCnfbS7ZsNLvdBW9pLR//PGot4flXnuZKtOSkQ5XZCXY1QfPVhDekQfdAV
 TLO3U4PqKFWVR385C+YhHkDK2WO0r+xYvYlWxd0fmW7JvjSS5eq1WAkQfUoRfV1mYhmy
 OHKdQVGaC7Qut3F9V8Nziv4mPocYfAnZN76cJw3Z4R6mn4WE7C76K9cZXR6/3aUXXePs
 V30WbA0OycU866qnqv7JLsWyAfApCp/zIHSNErK0UUIfhJ3P18aWG6nvlmFXMEzNWmrF
 7UOOc9E5FwTx8gc2mvxwuN/nm2GY8zN1m7eCzV18iKhM3PeL1Jnh3N6taQpsdPWoa48b
 7peQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1769034164; x=1769638964;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=mMxDlM9yUXOYKiCdeXwepCDs8XDjh+ewttYohU5KrKc=;
 b=MsxqtrnXLPnk+/WwW97YrMX4hyn2QclFGob7PrXvnFbDBri6ZYLievae4oyzx1ufM3
 NOYbDMy8wfsbu+Q+UD7GEawv9wkhXH64X6AOTFxBGFu3g39j6bjeLu22YsG76nbS0zxH
 LXVrdXpON8IYsLij/geFfI67IoD2rVsAmX1JCzwZ8ZdcsQe2ayZACiRnmTJ1Bq0F5F0k
 xKrm6RhFxsgcBKiMIDt/WvHNooUO4tR0Ej5MvNY71+LLsX0+I/fxiT9wH6esiaf0qWD5
 Gc4CcK6Tq89rbrmt/vEelULe66erwUn4LAHm4zL9wAeNB7S3nh02tPanQ/0EycMS5wyw
 02TQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU+9tQygzAFJXcgqC24aHyPALFuxVSbc3cUXJfmcWxn7BCHya094/m3NNuVm6KoH6tTiXcsCXwN92Nm@nongnu.org
X-Gm-Message-State: AOJu0YwbNWoS6lEyucu+VBcRvu1FvXpXP192EByEOyhYv0tsZtb7UmUy
 9YZfW5X65vNA6VKffM+adgY3hUd2PFfECgWXSrBcILhLUuMQ60QsqFS+1q6CGyCaEKmz93XwPSG
 4bRlW1bCdqhuLp8TxGKnMd6xMfZ7Ibu6G+DpVnMmHo2xXQjFtqUH4yCst
X-Gm-Gg: AZuq6aKhPL/Tq3Fw1LiNfhWAoyKAH+N7/BKqbAvAzSOod7C+XT0HP+PzknWLgrYIkXc
 PRK0GJeU7xk0uZjbccr9dGg7zKKGOEuI08IozVRWBaEwOzMsGMowl0vtdmXjW4CIqxaI9oyYs6W
 r2qhQOZxEsc74CXIILD9BixLdf+klKyivvQ7l8NiZdUTjiZG0ryuOW30SyqGg1EG1rnE1DNOBnT
 jaRh7jQyTVqOT4pQZAPfHEwVhRYuAlahTylyrSn5XbK7fwD4o4inWuvuiEG21X2xD92aEywtVjj
 HHHhV/wjVJS5LbKkqQOB5I8Q1BPQO3U1yxrgqmWGkDpZHdrI1ZlNLhkdr9ZrIU7deNzaT6pjGQ8
 GgLc=
X-Received: by 2002:a05:620a:4109:b0:8c5:33bf:524f with SMTP id
 af79cd13be357-8c6cce50090mr880338585a.59.1769034164070; 
 Wed, 21 Jan 2026 14:22:44 -0800 (PST)
X-Received: by 2002:a05:620a:4109:b0:8c5:33bf:524f with SMTP id
 af79cd13be357-8c6cce50090mr880336385a.59.1769034163647; 
 Wed, 21 Jan 2026 14:22:43 -0800 (PST)
Received: from x1.local ([142.188.210.156]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-8c6a71ab272sm1375826085a.2.2026.01.21.14.22.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Jan 2026 14:22:43 -0800 (PST)
Date: Wed, 21 Jan 2026 17:22:41 -0500
From: Peter Xu <peterx@redhat.com>
To: "Dr. David Alan Gilbert" <dave@treblig.org>
Cc: Lukas Straub <lukasstraub2@web.de>, qemu-devel@nongnu.org,
 Juraj Marcin <jmarcin@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Daniel P =?utf-8?B?LiBCZXJyYW5nw6k=?= <berrange@redhat.com>,
 =?utf-8?B?THVrw6HFoQ==?= Doktor <ldoktor@redhat.com>,
 Juan Quintela <quintela@trasno.org>,
 Zhang Chen <zhangckid@gmail.com>, zhanghailiang@xfusion.com,
 Li Zhijian <lizhijian@fujitsu.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
Message-ID: <aXFRsTwcXRC8U0Fh@x1.local>
References: <aW6xNcsz3RIqHeE5@x1.local> <20260120110811.7df19a6c@penguin>
 <aW-mCye_eFmy5f4B@x1.local> <aW_Rqbc2Swg8vkXY@gallifrey>
 <aW_ccMSY4xJlRVn2@x1.local> <aXArDHMRAohmUt51@gallifrey>
 <aXEG73I8tJyhpn69@x1.local> <aXENdA6DP5j0ETIU@gallifrey>
 <aXE1i9xJ81EWokYz@x1.local> <aXFFsfqusBQtd5DI@gallifrey>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <aXFFsfqusBQtd5DI@gallifrey>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Jan 21, 2026 at 09:31:29PM +0000, Dr. David Alan Gilbert wrote:
> * Peter Xu (peterx@redhat.com) wrote:
> > On Wed, Jan 21, 2026 at 05:31:32PM +0000, Dr. David Alan Gilbert wrote:
> > > Right that's true for postcopy; but then the only way to load the stream into
> > > that buffer is to load it all at once because of the vmstate problem above.
> > > (and because in the original postcopy we needed the original fd free
> > > for page requests; you might be able to avoid that with multifd now)
> > 
> > Only until now, I recognized that COLO wants to make sure the checkpoint is
> > either completely applied or none applied.
> > 
> > So the specialty is COLO does loadvm on top of a running VM, meanwhile COLO
> > may decide to not loadvm afterwards if checkpoint wasn't correctly
> > received.
> 
> Oh yes; because if your secondary is running happily, your primary could
> fail while it was sending you a new snapshot - and then the secondary
> has to be able to carry on.
> 
> > And yes, to cache all device states with current section header definition
> > in the stream, we'll likely need a size.  We can still parse the stream as
> > you pointed out previously, but I agree a special SIZE header still makes
> > sense.
> 
> Well, *can't* parse the stream as I said; because of the get()/put() stuff
> without rewriting that.

Ah, yes..

-- 
Peter Xu


