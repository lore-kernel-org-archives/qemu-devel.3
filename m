Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 625E3D24454
	for <qemu-devel@archiver.kernel.org>; Thu, 10 Oct 2024 21:24:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sz0dD-0007Vg-Q4; Thu, 10 Oct 2024 17:23:35 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sz0dA-0007VJ-RS
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:23:34 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1sz0d5-00020C-9f
 for qemu-devel@nongnu.org; Thu, 10 Oct 2024 17:23:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1728595406;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HE5RyJJvfKCHgzpy8RESqDHwV2aW/3Si54ESUGj/S9w=;
 b=OIzwCsIA1R5sVEE8M5a/JG9XzSv5kDDRBSNOXzZml74j7boyc8eS7Mi7YRWqTcay6i1NEK
 d3eOlNmhoKFHfvWJGoGeh8B8Q0AaDDo5rsOMMlcySwllZyxg+jrkmYuQmlY/PXxvG3Uiwu
 d7ypVKj85FN25UWYT6sU4kK63ZkPl3U=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-468-k6y4fjz6OOCpPjnNT8T2Uw-1; Thu, 10 Oct 2024 17:23:25 -0400
X-MC-Unique: k6y4fjz6OOCpPjnNT8T2Uw-1
Received: by mail-qk1-f197.google.com with SMTP id
 af79cd13be357-7afd01249f1so270713285a.3
 for <qemu-devel@nongnu.org>; Thu, 10 Oct 2024 14:23:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1728595404; x=1729200204;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=HE5RyJJvfKCHgzpy8RESqDHwV2aW/3Si54ESUGj/S9w=;
 b=m1Q3297ZXqrvtHSfNCpzAO0aGxHnWDohGmawmUH3df+OnBsRPyMe/nx5CnaO6fn2tq
 +UoXNJrmvlnDLvoTSyW1UgbQ+0vgRITlo7qv4kMgd6cgtfN3SklpaY+kkTNQPAs5vGJl
 3U4gzDWU/hAF6VxOFMcdu4NszwS40Moqv7/w57i8strJJHepsADInXqlrT+/nzaHIZ1v
 zOC9UtMnC3PyEMX4YKCqHHSVTcW6JJFFj+vtirPlrblwNtqf8cDgcIXOMi8sOjEeWySb
 pzMq0XcnljLci/Kqy/Wod+H8KE6DjYPZkGltey2XSnkHfrBda3aA9pvunZ4UXKv3g2ZO
 iSbw==
X-Forwarded-Encrypted: i=1;
 AJvYcCVXmKFxZmv+O26gfh4efHVrS0PXS+EvcVi4x8FH8S6AL/37g+9DvG8jqEVmI6mHcUhhOQNAhCYfl1P2@nongnu.org
X-Gm-Message-State: AOJu0Yz6O2kDTHfMXU9Av6GG9Edmt4a7WiJDsoMNeL7PvfIiGvzh8v+j
 gujC4RpXZTnaGpeQzCvQnXDThpSR1Yj0eq3r8/yMnRmgJZWYB2a3J3y0agp40x20Arn88Ha1joS
 yX0gX2A/LPp6eKwTMjzLkJoW/5ovwgDfhhj7EubYLoWPkqqpyhfab
X-Received: by 2002:a05:620a:4591:b0:7a9:d019:f2ee with SMTP id
 af79cd13be357-7b11a380aa4mr91571985a.23.1728595404667; 
 Thu, 10 Oct 2024 14:23:24 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFpKOutz2mTSLjRlNYd6L6rlOAKVQqUwAs5Cw2GcTpFa8p1szAear18JRriByeA/I54qgFrQQ==
X-Received: by 2002:a05:620a:4591:b0:7a9:d019:f2ee with SMTP id
 af79cd13be357-7b11a380aa4mr91568885a.23.1728595404354; 
 Thu, 10 Oct 2024 14:23:24 -0700 (PDT)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b1148d6413sm77585285a.43.2024.10.10.14.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Oct 2024 14:23:23 -0700 (PDT)
Date: Thu, 10 Oct 2024 17:23:20 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: Fabiano Rosas <farosas@suse.de>, qemu-devel@nongnu.org,
 David Hildenbrand <david@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Philippe Mathieu-Daude <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 "Daniel P. Berrange" <berrange@redhat.com>,
 Markus Armbruster <armbru@redhat.com>
Subject: Re: [PATCH V2 13/13] migration: cpr-transfer mode
Message-ID: <ZwhFyOQanyqWqr6I@x1n>
References: <eb41bce1-a776-4bb2-adb8-23fdc7cff1fb@oracle.com>
 <87ed4qtpo1.fsf@suse.de> <ZwV-NRICDNTajTRq@x1n>
 <877caitno5.fsf@suse.de> <ZwWMj4FYYpOSnPbe@x1n>
 <8b92a6ee-19f7-4483-9766-6b849cc04017@oracle.com>
 <ZwbUTXCxxl4heZYV@x1n>
 <95bfa06f-de5a-42cc-8078-c49fd617a73b@oracle.com>
 <ZwbpQiK7YWKpqHTk@x1n>
 <198913f5-32de-4771-98dc-02e73c4f0754@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <198913f5-32de-4771-98dc-02e73c4f0754@oracle.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.149,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Thu, Oct 10, 2024 at 04:06:13PM -0400, Steven Sistare wrote:
> vhost requires us to stop the vm early:
>   qmp_migrate
>     stop vm
>     migration_call_notifiers MIG_EVENT_PRECOPY_CPR_SETUP
>       vhost_cpr_notifier
>         vhost_reset_device - must be after stop vm
>                            - and before new qemu inits devices
>       cpr_state_save
>         unblocks new qemu which inits devices and calls vhost_set_owner
> 
> Thus config commands must be sent to the target during the guest pause interval :(

I can understand it needs VM stopped, but it can still happen after
cpr_save(), am I right (IOW, fd wont change in the notifier)?  I meant
below sequence:

  - src: cpr_save(), when running, NONE->SETUP_CPR, all fds synced

  - [whatever happens..]

  - src: finally decide to switchover, vm stop

  - vhost notifier invoked. PS: it doesn't require to be named SETUP_CPR
    notifiers here, but something else..

> 
> My new proposal addresses this.

Yes, we can discuss that first.

-- 
Peter Xu


