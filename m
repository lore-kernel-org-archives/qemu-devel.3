Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C227FCD8C9D
	for <qemu-devel@archiver.kernel.org>; Mon,  8 Jun 2026 14:12:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wWahT-0001Ws-OV; Mon, 08 Jun 2026 10:11:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wWahS-0001Wk-EH
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:11:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1wWahQ-0002Dd-Je
 for qemu-devel@nongnu.org; Mon, 08 Jun 2026 10:11:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1780927890;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=g2E1yzVjQdZt5mMJhYiQtIgevOZflG2f5CK5r+3uOTk=;
 b=gzaBRvQzOu7OVZEE/H1Kdfld7kZ2rbarZISOiIwoN+7GOQProTmwF98ZhBs7m8cr42PK1e
 9ubY6OTSm3wed8T/DJ5ubyR1W5vpx7zvdx3qRTeCqvFcD6FcASrIO+QtnZZwv2eKnyEME9
 XOPSllI/6StnWsXf/ymqxA19L0y7ILw=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-xy95vglcM8qPsvXxOPb7DA-1; Mon, 08 Jun 2026 10:11:28 -0400
X-MC-Unique: xy95vglcM8qPsvXxOPb7DA-1
X-Mimecast-MFC-AGG-ID: xy95vglcM8qPsvXxOPb7DA_1780927888
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-8ccd77414afso58818306d6.3
 for <qemu-devel@nongnu.org>; Mon, 08 Jun 2026 07:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1780927888; x=1781532688; darn=nongnu.org;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
 bh=g2E1yzVjQdZt5mMJhYiQtIgevOZflG2f5CK5r+3uOTk=;
 b=T8zLURJjExRhzpzN0ZawwZp4xothBpDw7CDazoy8Bf8Z1DuNzEV9aX7cs1G0T8DMz0
 tjehBSYUgeULZF8+jY7JSy60o7UPBSPuY9mOpf4d0xKV/hD7Vxt1fWtZV6/TYlraA+Yg
 9xJRLxz7mkHnlyiy99rXv08BgK8tHbRitZOaI+0hYdUuhAp6ud78lzCcj+jyCNDR7Ekd
 R18V87z2sV9JQlYRQ9CmFtF68foUDxF5z22VBij0/Fx10J8nQHoNoH3hlYB5mcmVmIbd
 nouaXGE+c8Ju7KlEV/FLPJ51ucY0HkXWL/v1hQ25/+ir5Y7rNbp4SrAKpw3QZSCPR9aN
 +IuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780927888; x=1781532688;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g2E1yzVjQdZt5mMJhYiQtIgevOZflG2f5CK5r+3uOTk=;
 b=Em2d6Wd4cSeJUYwLkO7jKCbHNvkd1lTNHbXr1tKDNTHnQMG1odP7ZJk2JX8spuof7q
 VYNEZY0hDrgzVlrFwW7mkG2Dfr4kXqC2OHJxtDSUizh/pDllq6sOVNACUyK+8SIlmSjU
 y1OvAebV7NsTZj+K3XEfGNTkxCyoJ3QVdPLo//K1uCBeJbFWQk8PJiha3EFBi3AuWnEb
 iPLSqjsfMFlS5kqrx8aqt7KctXEFDxgmDZgjGY7d3AV2qeRylRF28p/N7q2eernBPQ1c
 7g4Y92wrvJme3HEjn7ZKol7ao0CTVsoR1punsyiGuUgab3OLXlH5a1FqonIyIHQh/iaP
 Ra0A==
X-Gm-Message-State: AOJu0Yyk4IUWukvm91aHAxoL7hBIwgK0UkzCv5ZxahDsUSVjhY9HVHAa
 HTsAPCwVzeQ8fDfrrAIAP3THkXAqz5T+5Cc8ua4pNJsTnHAfjp9PQoxWW8xoXaMzJY//a+mPChR
 ll5kOtGqMht4u9Mtus3z7YgyFKxBADNo72k05pt3Gev3ZbeWDwTf+eDtF
X-Gm-Gg: Acq92OHh2WapjTa5bAY8fVpL/m2HzW5PfDT/ozqXu1Re5A14lR7Mv31X9xJf/2ShJJt
 BYSjwYcFihckpi4Mr7iAM1IH/ehhLw3GV1JSzVHYbU7gJCNrooCPLAZkLPY48CRPGZQSB96lhzY
 nyM2CfmiQJQGT1+YmtJqj62TtxayxW5+euNNt0/ys/RF2s3G6fejPePKJ4ldF/vDJvhzFyCIQMS
 9qXPWB33A5fg1Vey7zPlVe+XmZb1+1EiiRnTmBCQ3YppNWZ6oe71EOYhvHnhJWPB6TBjYnIf+lc
 YJNcSV458SaF35A/52GcJBLmCHd/sEJhz3MjVrQidnTOCopc08d0rsQUS1q3HV86kyrwupyFqDT
 fFxeLsXpjjxJ5YJty9vLSH9TMpg==
X-Received: by 2002:a0c:e9ce:0:b0:8ce:d557:74df with SMTP id
 6a1803df08f44-8cee611fbfamr194052876d6.22.1780927888096; 
 Mon, 08 Jun 2026 07:11:28 -0700 (PDT)
X-Received: by 2002:a0c:e9ce:0:b0:8ce:d557:74df with SMTP id
 6a1803df08f44-8cee611fbfamr194052046d6.22.1780927887494; 
 Mon, 08 Jun 2026 07:11:27 -0700 (PDT)
Received: from x1.local ([142.189.10.167]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8ceccdb9bd6sm181581746d6.13.2026.06.08.07.11.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 08 Jun 2026 07:11:27 -0700 (PDT)
Date: Mon, 8 Jun 2026 10:11:25 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: qemu-devel@nongnu.org, Alex Williamson <alex@shazbot.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Maor Gottlieb <maorg@nvidia.com>, Gavin Shan <gshan@redhat.com>,
 Wei Wang <wei.w.wang@intel.com>
Subject: Re: [PATCH v2 02/13] migration: Run final save_query_pending at
 switchover
Message-ID: <aibNja4cvhmgaioj@x1.local>
References: <20260602092621.382-1-avihaih@nvidia.com>
 <20260602092621.382-3-avihaih@nvidia.com>
 <aiCJHa-lT9Ycf6jq@x1.local> <aiCWynDFLoxtcctK@x1.local>
 <722fb01a-988b-4b21-9cca-aca1de2858db@nvidia.com>
 <aiGzVgatc_0Df21z@x1.local>
 <f27b2f9d-b72b-4fab-acc7-b560d29c95af@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <f27b2f9d-b72b-4fab-acc7-b560d29c95af@nvidia.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 08, 2026 at 03:07:32PM +0300, Avihai Horon wrote:
> > > 2. It calls migration_bitmap_sync and not migration_bitmap_sync_precopy,
> > > i.e., without precopy_notify calls.
> > This is another thing I feel like got overlooked in the free page hint
> > feature.  The only notifiers registered is that balloon device, logically I
> > think we need these notifiers in postcopy too to make sure we properly stop
> > the free page hints seeing BEFORE_BITMAP_SYNC, then don't start it
> > (vm_running=false) in AFTER_BITMAP_SYNC:
> > 
> > virtio_balloon_free_page_hint_notify():
> > 
> >      case PRECOPY_NOTIFY_BEFORE_BITMAP_SYNC:
> >          virtio_balloon_free_page_stop(dev);
> >          break;
> >      case PRECOPY_NOTIFY_AFTER_BITMAP_SYNC:
> >          if (vdev->vm_running) {
> >              virtio_balloon_free_page_start(dev);
> >              break;
> >          }
> 
> Actually, looking more closely in the code, I see that it's not used if
> postcopy is enabled [1].
> So calling the precopy notifiers in postcopy switchover is basically a
> no-op.
> 
> Then it seems fine to call migration_bitmap_sync_precopy from postcopy
> switchover flow.
> 
> [1] See commit fd51e54fa102 ("virtio-balloon: don't start free page hinting
> if postcopy is possible")

Yes, thanks for the pointer.  So it relies on the DONE event rather than
stop() to really stop the reporting.. good to know it was already bypassed
for postcopy, I definitely forgot that change.  For now, we can add another
trivial comment if we want.  So what we really need is final=true for
postcopy.

From a notifier semantics POV, IIUC it's also correct to notify here in
postcopy_start(), because at this stage it is still precopy.  Source QEMU
will move to postcopy stage (starting from POSTCOPY_DEVICE state) only if
postcopy_start() succeeded.  So a precopy notifier, no matter the analysis
of balloon use case, should theoretically apply here as well.

Thanks,

-- 
Peter Xu


