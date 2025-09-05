Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9251BCA0FED
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Sep 2025 16:50:23 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uuZcB-0001av-0l; Fri, 05 Sep 2025 12:48:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuZc8-0001Zs-3O
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:48:41 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uuZbw-0002Co-Ji
 for qemu-devel@nongnu.org; Fri, 05 Sep 2025 12:48:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757090896;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0vCE51+XIfrJhb4Pkygain3vb274ws/kWbslRDirvYQ=;
 b=Ao6d9RJQHoCPxkvEa41sTL1zV9x2ubifvPf9h4QFf4A3hCT6sFvZ3XEoztL22Q2RJR3kiY
 1qqPFsPyfQNNjZLtjlqDg+q3h8V+wBylqBchm0DUWkNUQKaAeqr1uP/cuWQZclBRVPcn2a
 vr0PrMTnbjOorqQ03e1adyVNiHe11b0=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-185-pPo9AsiiPe2rkihXbYw23g-1; Fri, 05 Sep 2025 12:48:14 -0400
X-MC-Unique: pPo9AsiiPe2rkihXbYw23g-1
X-Mimecast-MFC-AGG-ID: pPo9AsiiPe2rkihXbYw23g_1757090894
Received: by mail-qv1-f70.google.com with SMTP id
 6a1803df08f44-7211f13bc24so43800996d6.1
 for <qemu-devel@nongnu.org>; Fri, 05 Sep 2025 09:48:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757090894; x=1757695694;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0vCE51+XIfrJhb4Pkygain3vb274ws/kWbslRDirvYQ=;
 b=SDegGuSUxXFV0Thsm9JFL9wxZFnqfvG7iFH/mheED7bAPvwL/ky5lihpg3F5DOr+FZ
 jGg2vyhxguDtabi2y4QFaRWPRMf8m4wq2Ti80mcW5XG7ZKiQ9uN/DGB7dZ7H0BPYI0XH
 8u8HRxrmCiNB8A2snSaKrSl9edZbv60JCY6iDoXidKazZ+TH8XGOQIdXvaqNwMR4iBCr
 VcA2g5is6ijIzOC8SN0j9tEbaLfxx3y6QYQwmMnUSP87sVbciD2+uY9vlfLWkToqiSzJ
 lbyoYBPuA7uWywCW7xRFopPS+DmYpkV01kpivNOFOwY2gws32wHviYi2ps1rB559MYtr
 4tUg==
X-Gm-Message-State: AOJu0YynW7cVZ3IAXAu3ykzt2dc5WiotUPbz5+jUduMODQo6s3U+Kcy5
 Zj7HNnUbv6i+wqRbtd3zua0+kE4Pls0yfgbaOccseCmk1led+uiqR6blGZDDmM8sZXjopA+uNMp
 p9lQFQQ8eO48jI8TJx/3i2xLgv75uYqRSaCDd+v2EABgDqlR1YVU7fZbn
X-Gm-Gg: ASbGncsicxQ26DYTLfLcaxoaQlbBUHGjFwFiR6vP3GLTkDwF2ccB+DCfgr/QtOrYGel
 Odc/k5Q7EdZ2BcR7phTqm3rEcpk4GZmBtNiu3p4vg8jnUlOMglnx/bUwV6640E2e9uvki3FCd8G
 lub53Ti/4TPC/ALSlwGtYDxVy5b8tT5ReXbKQlhVSsEYCm+kfcIgXvxxoyMSE10Rs8Z/Zm4sKDF
 e0LVWMyd3afJNYzuPmbUjC0Xo5zLwYug/4yVEuTpLKH78TbLB/T4FclaO7Q7d/nGpTuMwAJcGsy
 ZnP6QeCQ5qJcqlrtfxn3m+ZIAl5JuXek
X-Received: by 2002:a05:6214:f2e:b0:722:970:3af1 with SMTP id
 6a1803df08f44-72209703bb6mr148844246d6.22.1757090893924; 
 Fri, 05 Sep 2025 09:48:13 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGpxic57AL2EGQdNQAsQqvNDfPAuVAecEQCnlKlu6014lo1nLunDSj247VQyV8B8As1QlIdDA==
X-Received: by 2002:a05:6214:f2e:b0:722:970:3af1 with SMTP id
 6a1803df08f44-72209703bb6mr148844006d6.22.1757090893481; 
 Fri, 05 Sep 2025 09:48:13 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-7220f78b9bfsm58861186d6.64.2025.09.05.09.48.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Sep 2025 09:48:12 -0700 (PDT)
Date: Fri, 5 Sep 2025 12:48:01 -0400
From: Peter Xu <peterx@redhat.com>
To: Steve Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
Message-ID: <aLsUQWjW8gyZjySs@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

Add Vladimir and Dan.

On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
> This patch series adds the live migration cpr-exec mode.  
> 
> The new user-visible interfaces are:
>   * cpr-exec (MigMode migration parameter)
>   * cpr-exec-command (migration parameter)
> 
> cpr-exec mode is similar in most respects to cpr-transfer mode, with the 
> primary difference being that old QEMU directly exec's new QEMU.  The user
> specifies the command to exec new QEMU in the migration parameter
> cpr-exec-command.
> 
> Why?
> 
> In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> container and its assigned resources.  By contrast, cpr-transfer mode
> requires a new container to be created on the same host as the target of
> the CPR operation.  Resources must be reserved for the new container, while
> the old container still reserves resources until the operation completes.
> Avoiding over commitment requires extra work in the management layer.

Can we spell out what are these resources?

CPR definitely relies on completely shared memory.  That's already not a
concern.

CPR resolves resources that are bound to devices like VFIO by passing over
FDs, these are not over commited either.

Is it accounting QEMU/KVM process overhead?  That would really be trivial,
IMHO, but maybe something else?

> This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> is that the container may include agents with their own connections to the
> outside world, and such connections remain intact if the container is reused.

We discussed about this one.  Personally I still cannot understand why this
is a concern if the agents can be trivially started as a new instance.  But
I admit I may not know the whole picture.  To me, the above point is more
persuasive, but I'll need to understand which part that is over-commited
that can be a problem.

After all, cloud hosts should preserve some extra memory anyway to make
sure dynamic resources allocations all the time (e.g., when live migration
starts, KVM pgtables can drastically increase if huge pages are enabled,
for PAGE_SIZE trackings), I assumed the over-commit portion should be less
that those.. and when it's also temporary (src QEMU will release all
resources after live upgrade) then it looks manageable.

> 
> How?
> 
> cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> and by sending the unique name and value of each descriptor to new QEMU
> via CPR state.
> 
> CPR state cannot be sent over the normal migration channel, because devices
> and backends are created prior to reading the channel, so this mode sends
> CPR state over a second migration channel that is not visible to the user.
> New QEMU reads the second channel prior to creating devices or backends.
> 
> The exec itself is trivial.  After writing to the migration channels, the
> migration code calls a new main-loop hook to perform the exec.
> 
> Example:
> 
> In this example, we simply restart the same version of QEMU, but in
> a real scenario one would use a new QEMU binary path in cpr-exec-command.
> 
>   # qemu-kvm -monitor stdio
>   -object memory-backend-memfd,id=ram0,size=1G
>   -machine memory-backend=ram0 -machine aux-ram-share=on ...
> 
>   QEMU 10.1.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
>   (qemu) migrate_set_parameter mode cpr-exec
>   (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
>   (qemu) migrate -d file:vm.state
>   (qemu) QEMU 10.1.50 monitor - type 'help' for more information
>   (qemu) info status
>   VM status: running
> 
> Steve Sistare (9):
>   migration: multi-mode notifier
>   migration: add cpr_walk_fd
>   oslib: qemu_clear_cloexec
>   vl: helper to request exec
>   migration: cpr-exec-command parameter
>   migration: cpr-exec save and load
>   migration: cpr-exec mode
>   migration: cpr-exec docs
>   vfio: cpr-exec mode

The other thing is, as Vladimir is working on (looks like) a cleaner way of
passing FDs fully relying on unix sockets, I want to understand better on
the relationships of his work and the exec model.

I still personally think we should always stick with unix sockets, but I'm
open to be convinced on above limitations.  If exec is better than
cpr-transfer in any way, the hope is more people can and should adopt it.

We also have no answer yet on how cpr-exec can resolve container world with
seccomp forbidding exec.  I guess that's a no-go.  It's definitely a
downside instead.  Better mention that in the cover letter.

Thanks,

-- 
Peter Xu


