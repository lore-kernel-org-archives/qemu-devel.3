Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E45FCA0FED
	for <qemu-devel@archiver.kernel.org>; Tue,  9 Sep 2025 15:26:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uw0DI-0007xd-Jp; Tue, 09 Sep 2025 11:24:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0DC-0007uh-RZ
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:24:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1uw0D1-0003oN-1f
 for qemu-devel@nongnu.org; Tue, 09 Sep 2025 11:24:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1757431471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3tziygtfCsUaA6kOHzi4sfHG7kmuI1h8v60LVGQfPoI=;
 b=XmlG7aJur2yx5DzXB2v9/0NJ/IqotgIX0KFotMphGYWAIPsVsZLEaMHwP95yNhJT2fPkJ4
 SMZM0tQHNXyh+y9bKhGMTQQP3CQEkqcPthKH8K5PT/VkbuQ4SuOnXy7B9NthTWtCt/ijVe
 rRIbk0WRhACtNYJ77kvWY09ov4eVHEU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-ow3edu_rMSyaAfbP4IMNEQ-1; Tue, 09 Sep 2025 11:24:27 -0400
X-MC-Unique: ow3edu_rMSyaAfbP4IMNEQ-1
X-Mimecast-MFC-AGG-ID: ow3edu_rMSyaAfbP4IMNEQ_1757431467
Received: by mail-qt1-f200.google.com with SMTP id
 d75a77b69052e-4b49715fdfbso227713171cf.2
 for <qemu-devel@nongnu.org>; Tue, 09 Sep 2025 08:24:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1757431467; x=1758036267;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3tziygtfCsUaA6kOHzi4sfHG7kmuI1h8v60LVGQfPoI=;
 b=Sa+NJMZf787Ooii3ZLviS5M/cY9IZB2mJgeF7ywTnlbCMjHy5ZmZC5nVSp//rl6N3j
 ufj5w5iYp/z12VhllU7VcczZJ10YhpU9TeNfDwDemGU1tVwC/j94pRRVj9p1ZGwqmScH
 G4SAV+qe+vdCIX0QLarrQJLl5iwHFhsKllGUIjM6oHBtbSuBDmGqejyXdt3yMa1ssAkN
 F0Jvjh+pV9PqD8BNIpamob5VA+aWN1ipLS6Lp781I/+y2ywqRTVYcRxhAnS6VOK175w6
 xwLO5T8CBrwgRXi3jK7MXen14OWPj+pmQQ3vxnsuP2EQpeM/yYDUlE4N1Wkbk97xr85g
 nKbw==
X-Gm-Message-State: AOJu0YwpJq1gm2yjnqRDk+jgDZ0Wnd42AEA0pPu0g8pa+3dRJHnjYA0r
 ISXAmsWlBbU+4cSSYLFi88SM5KAmA232Pb2OeJ7DOR62dxx8or7kHc1mm8dUijpSAiJsHEmXkII
 24YBmdl9Yk9ZufYSDFU03WZ5qI8rupk/2dJyZ/qQCzzyO0tWnzZwzZX+Y
X-Gm-Gg: ASbGncv+6XwBaTeubv3MF/XxbBKSTd72jRoezezsBa/ktcm6DVbymq+Cx1H/rKx41br
 SUTiarTHUSsVKpdL4xaX2uXThE9t1pmU+9ezV+HugAQ/kQqaF4/RfW47RdU1jpyBE/9f9uNCrQ7
 524jH5Cie+NhZ4AHQCAJM2uDmbNM2pQy6D8N6OnEVHrPPjeIXZhY5FmRbkfn45xVms4PxNIdhwG
 ztTPf5Is905+18JgswPCcxqeZ1nWO98RmHmDr2UldeHyaKutCqlitXEZsXHqbQJ9HMTk1a58OKR
 uEMhM0a74cxzNB0tCx7yjQdipMhqV3kz
X-Received: by 2002:a05:622a:1449:b0:4b5:eb27:c241 with SMTP id
 d75a77b69052e-4b5f836b286mr120175751cf.3.1757431466655; 
 Tue, 09 Sep 2025 08:24:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFPT4Aj/fpFkmhbVmFYVehgzRCic8ihfv0+xI68GoCJwfcvvpxH5V55yT5OYnLPsTpNoVNsIw==
X-Received: by 2002:a05:622a:1449:b0:4b5:eb27:c241 with SMTP id
 d75a77b69052e-4b5f836b286mr120174991cf.3.1757431465449; 
 Tue, 09 Sep 2025 08:24:25 -0700 (PDT)
Received: from x1.local ([174.89.135.121]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-81b5ee68b49sm131884085a.53.2025.09.09.08.24.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Sep 2025 08:24:24 -0700 (PDT)
Date: Tue, 9 Sep 2025 11:24:12 -0400
From: Peter Xu <peterx@redhat.com>
To: Steven Sistare <steven.sistare@oracle.com>
Cc: qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Markus Armbruster <armbru@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 "Dr. David Alan Gilbert" <dave@treblig.org>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>
Subject: Re: [PATCH V3 0/9] Live update: cpr-exec
Message-ID: <aMBGnHXieiXpBCqF@x1.local>
References: <1755191843-283480-1-git-send-email-steven.sistare@oracle.com>
 <aLsUQWjW8gyZjySs@x1.local>
 <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <fd56205a-11c1-4297-898d-603f1836bdad@oracle.com>
Received-SPF: pass client-ip=170.10.129.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
 SPF_PASS=-0.001, T_SPF_HELO_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On Tue, Sep 09, 2025 at 10:36:16AM -0400, Steven Sistare wrote:
> On 9/5/2025 12:48 PM, Peter Xu wrote:
> > Add Vladimir and Dan.
> > 
> > On Thu, Aug 14, 2025 at 10:17:14AM -0700, Steve Sistare wrote:
> > > This patch series adds the live migration cpr-exec mode.
> > > 
> > > The new user-visible interfaces are:
> > >    * cpr-exec (MigMode migration parameter)
> > >    * cpr-exec-command (migration parameter)
> > > 
> > > cpr-exec mode is similar in most respects to cpr-transfer mode, with the
> > > primary difference being that old QEMU directly exec's new QEMU.  The user
> > > specifies the command to exec new QEMU in the migration parameter
> > > cpr-exec-command.
> > > 
> > > Why?
> > > 
> > > In a containerized QEMU environment, cpr-exec reuses an existing QEMU
> > > container and its assigned resources.  By contrast, cpr-transfer mode
> > > requires a new container to be created on the same host as the target of
> > > the CPR operation.  Resources must be reserved for the new container, while
> > > the old container still reserves resources until the operation completes.
> > > Avoiding over commitment requires extra work in the management layer.
> > 
> > Can we spell out what are these resources?
> > 
> > CPR definitely relies on completely shared memory.  That's already not a
> > concern.
> > 
> > CPR resolves resources that are bound to devices like VFIO by passing over
> > FDs, these are not over commited either.
> > 
> > Is it accounting QEMU/KVM process overhead?  That would really be trivial,
> > IMHO, but maybe something else?
> 
> Accounting is one issue, and it is not trivial.  Another is arranging exclusive
> use of a set of CPUs, the same set for the old and new container, concurrently.
> Another is avoiding namespace conflicts, the kind that make localhost migration
> difficult.
> 
> > > This is one reason why a cloud provider may prefer cpr-exec.  A second reason
> > > is that the container may include agents with their own connections to the
> > > outside world, and such connections remain intact if the container is reused.
> > 
> > We discussed about this one.  Personally I still cannot understand why this
> > is a concern if the agents can be trivially started as a new instance.  But
> > I admit I may not know the whole picture.  To me, the above point is more
> > persuasive, but I'll need to understand which part that is over-commited
> > that can be a problem.
> 
> Agents can be restarted, but that would sever the connection to the outside
> world.  With cpr-transfer or any local migration, you would need agents
> outside of old and new containers that persist.
> 
> With cpr-exec, connections can be preserved without requiring the end user
> to reconnect, and can be done trivially, by preserving chardevs.  With that
> support in qemu, the management layer does nothing extra to preserve them.
> chardev support is not part of this series but is part of my vision,
> and makes exec mode even more compelling.
> 
> Management layers have a lot of code and complexity to manage live migration,
> resources, and connections.  It requires modification to support cpr-transfer.
> All that can be bypassed with exec mode.  Less complexity, less maintainance,
> and  fewer points of failure.  I know this because I implemented exec mode in
> OCI at Oracle, and we use it in production.

I wonders how this part works in Vladimir's use case.

> > After all, cloud hosts should preserve some extra memory anyway to make
> > sure dynamic resources allocations all the time (e.g., when live migration
> > starts, KVM pgtables can drastically increase if huge pages are enabled,
> > for PAGE_SIZE trackings), I assumed the over-commit portion should be less
> > that those.. and when it's also temporary (src QEMU will release all
> > resources after live upgrade) then it looks manageable. >>
> > > How?
> > > 
> > > cpr-exec preserves descriptors across exec by clearing the CLOEXEC flag,
> > > and by sending the unique name and value of each descriptor to new QEMU
> > > via CPR state.
> > > 
> > > CPR state cannot be sent over the normal migration channel, because devices
> > > and backends are created prior to reading the channel, so this mode sends
> > > CPR state over a second migration channel that is not visible to the user.
> > > New QEMU reads the second channel prior to creating devices or backends.
> > > 
> > > The exec itself is trivial.  After writing to the migration channels, the
> > > migration code calls a new main-loop hook to perform the exec.
> > > 
> > > Example:
> > > 
> > > In this example, we simply restart the same version of QEMU, but in
> > > a real scenario one would use a new QEMU binary path in cpr-exec-command.
> > > 
> > >    # qemu-kvm -monitor stdio
> > >    -object memory-backend-memfd,id=ram0,size=1G
> > >    -machine memory-backend=ram0 -machine aux-ram-share=on ...
> > > 
> > >    QEMU 10.1.50 monitor - type 'help' for more information
> > >    (qemu) info status
> > >    VM status: running
> > >    (qemu) migrate_set_parameter mode cpr-exec
> > >    (qemu) migrate_set_parameter cpr-exec-command qemu-kvm ... -incoming file:vm.state
> > >    (qemu) migrate -d file:vm.state
> > >    (qemu) QEMU 10.1.50 monitor - type 'help' for more information
> > >    (qemu) info status
> > >    VM status: running
> > > 
> > > Steve Sistare (9):
> > >    migration: multi-mode notifier
> > >    migration: add cpr_walk_fd
> > >    oslib: qemu_clear_cloexec
> > >    vl: helper to request exec
> > >    migration: cpr-exec-command parameter
> > >    migration: cpr-exec save and load
> > >    migration: cpr-exec mode
> > >    migration: cpr-exec docs
> > >    vfio: cpr-exec mode
> > 
> > The other thing is, as Vladimir is working on (looks like) a cleaner way of
> > passing FDs fully relying on unix sockets, I want to understand better on
> > the relationships of his work and the exec model.
> 
> His work is based on my work -- the ability to embed a file descriptor in a
> migration stream with a VMSTATE_FD declaration -- so it is compatible.
> 
> The cpr-exec series preserves VMSTATE_FD across exec by remembering the fd
> integer and embedding that in the data stream.  See the changes in vmstate-types.c
> in [PATCH V3 7/9] migration: cpr-exec mode.
> 
> Thus cpr-exec will still preserve tap devices via Vladimir's code.
> > I still personally think we should always stick with unix sockets, but I'm
> > open to be convinced on above limitations.  If exec is better than
> > cpr-transfer in any way, the hope is more people can and should adopt it.
> 
> Various people and companies have expressed interest in CPR and want to explore
> cpr-exec.  Vladimir was one, he chose transfer instead, and that is fine, but
> give people the option.  And Oracle continues to use cpr-exec mode.

How does cpr-exec guarantees everything will go smoothly with no failure
after the exec?  Essentially, this is Vladimir's question 1.  Feel free to
answer there, because there's also question 2 (which we used to cover some
but maybe not as much).

The other thing I don't remember if we discussed, on how cpr-exec manages
device hotplugs. Say, what happens if there are devices hot plugged (via
QMP) then cpr-exec migration happens?

Does cpr-exec cmdline needs to convert all QMP hot-plugged devices into
cmdlines and append them?  How to guarantee src/dst device topology match
exactly the same with the new cmdline?

> 
> There is no downside to supporting cpr-exec mode.  It is astonishing how much
> code is shared by the cpr-transfer and cpr-exec modes.  Most of the code in
> this series is factored into specific cpr-exec files and functions, code that
> will never run for any other reason.  There are very few conditionals in common
> code that do something different for exec mode.
> > We also have no answer yet on how cpr-exec can resolve container world with
> > seccomp forbidding exec.  I guess that's a no-go.  It's definitely a
> > downside instead.  Better mention that in the cover letter.
> The key is limiting the contents of the container, so exec only has a limited
> and known safe set of things to target.  I'll add that to the cover letter.

Thanks.

-- 
Peter Xu


