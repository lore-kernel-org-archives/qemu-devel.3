Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 03105E7717D
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Dec 2024 22:11:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tLUuW-0001z0-T3; Wed, 11 Dec 2024 17:10:24 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLUuV-0001ym-CD
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:10:23 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1tLUuT-0001oA-54
 for qemu-devel@nongnu.org; Wed, 11 Dec 2024 17:10:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1733955018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3vg00XWmQ+B4ODRjsNPT3EAR3QAv9tOWFuRVVLKTvr8=;
 b=GqXfWr/Bcv2xrt6S/ywjZS8iC5AEwQq0BwuHBMnwsR+3w9wPoXbsMbBcppceKYKsrLDfha
 vJWG5Ef48YWoS/WDF0eEz0Wlo7WZ2ZbAKQPPiYgX+65ynAPYknkE1Ok3ULfl+CFAkkt8Xl
 aDzz2wmkkm3O2l5aNnfMzVkNvWh6tu4=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-398-ZcecctRDNGKG0onE2vRRcw-1; Wed, 11 Dec 2024 17:10:15 -0500
X-MC-Unique: ZcecctRDNGKG0onE2vRRcw-1
X-Mimecast-MFC-AGG-ID: ZcecctRDNGKG0onE2vRRcw
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6d8fe8a0371so78331286d6.1
 for <qemu-devel@nongnu.org>; Wed, 11 Dec 2024 14:10:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1733955015; x=1734559815;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3vg00XWmQ+B4ODRjsNPT3EAR3QAv9tOWFuRVVLKTvr8=;
 b=LQkkNdrMgn5//hnBwj2Vl/LCQ17h3ODw3QYJglCqJb0hkochdCN/3MS1PyQb75uN9V
 8ysFsrnbNFLXHSSpPnS7GXON36g8ymCtRDUwfmEkLV7Ejqey88tQ3tQzMhTU3u2yetI0
 ykGJ7P2eHXV80FbdXKVpUsV85b2X0ImBbe9evovOOJTzK7WsXYwOi+tnamhIRzkZKDDr
 5T2gM++jzgiHV7NBdOP0moF1YfVaAyni8/PFPmJl+/Zd3Y/H76hn9U9oK+7PnCUIFKFP
 GmuM8gcEEwXuRrG30Awy8Hi9Be9d6vDSP6JhbA4DZuM4S0EpffWsQKsjgIS3YG3xk7H/
 yFDg==
X-Forwarded-Encrypted: i=1;
 AJvYcCXEaS9+/K0Yja5LXjVT8+ZefW7IWKWdBn3RJx4DFmVrYl6EweczTzVSn11/7DveLxeLuL5bZ8d2gbqd@nongnu.org
X-Gm-Message-State: AOJu0YzvI9kCFH0sxQ8afjUQIzHWtWS55+0Xb0iOjRFUGkqix8FoWXGv
 5d95/bcNoQ7RDB5vYlBfKeSGYdzN/Y9CNPLHokbs8F2y/csyhuPlkK3LaxCtk75dzehQxJ4nQ4M
 HD+fOJy1eHgjDTaOxG+ZBTcNiEXrdu/xcKrzYOvnAg+Uxwqd/3G52
X-Gm-Gg: ASbGncurtD6fRY0OOM56GEpyZB1bdtb+s2X/RcZx8JHukUdO6QX4hP66/zHwDlojvzQ
 lXkd5iP7f3fw4FkR8sGMcz7xtDBG4c7y/zXB0t/g09knH1X1KxZzQaWNzhFxM743rPhXNcNE4kC
 4a94Xc7fKedyVwimqxDfJSToAh5GMeC7L7zxthkwzcsVLpKPS76ROfhwPJpKJLnDzuF5G0qLqx9
 zWdA98hLrFMC0/SBrM+sijmTNQIgdITVGSmLXALVqFTo2YmIXChX/Xh6wTUgTI7bi1htCBKTZWP
 DlLBRipvcMzzs/Q=
X-Received: by 2002:a05:6214:20e6:b0:6d8:accb:5a3d with SMTP id
 6a1803df08f44-6dae39b16c3mr16926556d6.34.1733955014865; 
 Wed, 11 Dec 2024 14:10:14 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH/+qdMrYQhF/BoB5pp+Uv6siRgRn+FW8nSpogMY3ydeoIDgO7yd90Zt/ExN1xEyKYb6tRVxQ==
X-Received: by 2002:a05:6214:20e6:b0:6d8:accb:5a3d with SMTP id
 6a1803df08f44-6dae39b16c3mr16925986d6.34.1733955014373; 
 Wed, 11 Dec 2024 14:10:14 -0800 (PST)
Received: from x1n (pool-99-254-114-190.cpe.net.cable.rogers.com.
 [99.254.114.190]) by smtp.gmail.com with ESMTPSA id
 af79cd13be357-7b6f0267f56sm58465485a.93.2024.12.11.14.10.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 11 Dec 2024 14:10:13 -0800 (PST)
Date: Wed, 11 Dec 2024 17:10:11 -0500
From: Peter Xu <peterx@redhat.com>
To: Markus Armbruster <armbru@redhat.com>
Cc: Daniel =?utf-8?B?UC4gQmVycmFuZ8Op?= <berrange@redhat.com>,
 qemu-devel@nongnu.org, Fabiano Rosas <farosas@suse.de>,
 Igor Mammedov <imammedo@redhat.com>, Juraj Marcin <jmarcin@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 "Dr . David Alan Gilbert" <dave@treblig.org>,
 =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>
Subject: Re: [PATCH 0/4] QOM: Singleton interface
Message-ID: <Z1oNw7m8yS06HfM_@x1n>
References: <20241024165627.1372621-1-peterx@redhat.com>
 <87h690my2w.fsf@pond.sub.org> <Zxuy5CjKNlK49TUL@x1n>
 <ZyC8MmM7k6df2Awi@redhat.com> <ZyD1BarDJUSA7Nen@x1n>
 <ZyEHoj3Mrm3OGtnX@redhat.com> <ZyEVwFaTbqtw2Vx6@x1n>
 <87o71iy6ln.fsf@pond.sub.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87o71iy6ln.fsf@pond.sub.org>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.472,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

On Wed, Dec 11, 2024 at 09:19:32AM +0100, Markus Armbruster wrote:
> Looked at this thread again to refresh my memory on the proposed
> singleton interface, and found I have something to add.
> 
> Peter Xu <peterx@redhat.com> writes:
> 
> > On Tue, Oct 29, 2024 at 04:04:50PM +0000, Daniel P. Berrangé wrote:
> >> I tend to feel that having MigrationState exist for the whole lifetime
> >> of QEMU is a bug, forced on us by the unfortunate need to call
> >> migrate-set-parameters/capabilities separately from the migrate
> >> command, and by the need to query migrate info an arbitrary amount of
> >> time after it finishes.
> >> 
> >> This puts libvirt in the awkward position of having to manually reset
> >> all migration parameters, just to ensure earlier settings don't
> >> accidentally affect a future migration operation :-( This is a design
> >> that encourages mistakes.
> >
> > I think it would still be easy to add "cap" & "params" arguments support
> > for the "migrate" QMP command without breaking the current API, iff that
> > helps in whatever form.  When present, it simply applies the caps and/or
> > param list first before invoking the migrate command, fail the command if
> > cap / param check fails.
> >
> > But I'm not sure whether that's a concern at all for Libvirt, if what
> > Libvirt currently does is having separate "migrate-set-*" commands prior to
> > the "migrate".  I may have overlooked the real issue behind on how that
> > could complicate Libvirt.
> 
> I think Daniel's point is that the interface's reliance on global state
> makes it awkward to use.
> 
> Migration configuration is global state.  It's split into "capabilities"
> and "parameters", but that's detail.  We have commands to query and
> change this state.
> 
> When Libvirt connects to a QEMU process, it has no idea what the global
> migration configuration is.  To get it into a known state, it has to set
> *everything*.  It cannot rely on defaults.
> 
> It even has to set things it doesn't know!  When we add a new parameter
> to QEMU, libvirt needs to be updated to reset it to its default even
> when libvirt has no need for it.  When you use a version of libvirt that
> lacks this update, it remains whatever it was.  The migration interface
> becomes accidentally stateful at the libvirt level, which is
> undesirable.
> 
> Compare this to the more modern interface we have for other long-running
> tasks: jobs.
> 
> There is a job-specific command that creates the job: blockdev-backup,
> block-commit, blockdev-mirror, block-stream, blockdev-create,
> snapshot-save, snapshot-load, snapshot-delete, ...  Each command takes
> the entire job configuration as arguments.  Libvirt does not need
> updating for new parameters: these simply remain at their default
> values.
> 
> Bonus: there are generic commands to control and monitor jobs:
> job-pause, job-resume, job-cancel, job-complete, job-dismiss,
> job-finalize, query-jobs.

Yes, migration is state-ful from that regard.  IMHO it is still ok because
unlike most jobs, migration task cannot have more than one.

Reusing jobs interface may work, but migation existed for so long a time
with its own APIs, I am not sure we'll get real benefit by reusing them.
At the meantime it may not 100% map to what migration wants (e.g.,
migrate_start_postcopy, postcopy recoveries, etc.).

OTOH, we definitely don't want to use the internal impl of jobs, because we
don't want to add either AIO or more coroutines into migration core - we
need to still use coroutine on dest QEMU but that's mostly only because of
legacy reasons.. and besides that and some very corner use case
(e.g. channel setups), migration is almost thread-based now.  A mixture of
threads and coroutines is too error prone and undebuggable, IMHO.

Going back to the "allow migrate QMP command take caps / parameters", we
still try to do that at some point.  But I recall we discussed about this
offlist (between Dan, probably Peter Krempa and myself), I believe the
conclusion is it'll make the API cleaner, but without no real benefit yet
so far.  Meanwhile there're some parameters that must be still stateful,
like a few max*-bandwidth or downtime_limit parameters.  They need to be
able to be changed on the fly, especially during migration task running.

Thanks,

-- 
Peter Xu


