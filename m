Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E21EC43458
	for <qemu-devel@archiver.kernel.org>; Mon, 29 Jun 2026 16:28:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1weEqe-0003MZ-9f; Mon, 29 Jun 2026 12:28:40 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weEqH-0003FM-KE
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:28:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <peterx@redhat.com>) id 1weEqF-0004uo-In
 for qemu-devel@nongnu.org; Mon, 29 Jun 2026 12:28:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1782750493;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xnpa0XARCCK/z5iVOr8UpDGEsTS72ptQ/PES0WnvDwQ=;
 b=RCJH/AGprKjNKYdf7GsiJjNAlOqgXmQ+ZinYaY8b1Z4QxQJARJZ9sCV8eUpF0TXRyFdCgq
 vMazuEFMC+8IAuo3H2qBxVH6cd3zX8HgYYQPBko2qYTZDqwJWuQC9rSwJcsPQDWdn8kabt
 b+mVhSnCJ15fd6oL6jyB8mNC4N0qfMg=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-684-cenfvVR3PiGUxWbOgM_Ecw-1; Mon, 29 Jun 2026 12:28:11 -0400
X-MC-Unique: cenfvVR3PiGUxWbOgM_Ecw-1
X-Mimecast-MFC-AGG-ID: cenfvVR3PiGUxWbOgM_Ecw_1782750491
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-8efad04d884so32454156d6.0
 for <qemu-devel@nongnu.org>; Mon, 29 Jun 2026 09:28:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1782750491; x=1783355291; darn=nongnu.org;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=xnpa0XARCCK/z5iVOr8UpDGEsTS72ptQ/PES0WnvDwQ=;
 b=plSVxsmOvVKpe6Z8v6DP+/DLw0eQLTADZdkArYyRzef5JLhT3bbSqNUH6Cswi9BVXJ
 B26V7vc1ZgjUJTm6Yu79oDiZEAUrewBpE/83iNlj5AXWJcY4dcK45xverq1Ojq2qNgzS
 Auh1RUBjE3TrMENElWfRn5mWlufosd3DCLxV+ymBwJtOg4fFTrHY5JUW4n9opcqW63pj
 S5mxHqVFbAbOoHC314VdrOou2xD+jDHcDHBpGPFUoOT4KKTqVXGsQ2PZWe5GEXvKkMtk
 0BnL2fl3UsVbkHhnVw1ZFEJ01SZBpZv9bC/yQVIGHzEEKGLVGUsu5vsm5Cod+lvj4mKe
 4x4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782750491; x=1783355291;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :content-type:mime-version:references:message-id:subject:cc:to:from
 :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to:content-type;
 bh=xnpa0XARCCK/z5iVOr8UpDGEsTS72ptQ/PES0WnvDwQ=;
 b=GuqZXDvQB+QYfl4QsbFukEKgfnEAvPeDHyfjYTKfP6apiSvknQ/FJ3frTXhbvr4x+z
 yadxswGWn53uuFT71MXJASldJqo/yJ3Y5ovXZdluNa2ttUejf+Oj+YvMsRabf4ujVdxQ
 lbepZXiMKtzmVDE1/Mhfs+G+x2E5UOFzdv2sx+rHQXK1AhHjd1Wa06qPsnbl4CVKvi/1
 dkrBCMCmy4CaJ4QJ0sJ1JSwM6HB5ES+mWfo2kGPvvUfe3MxQBR6wfE9jko5LIGsNCVMq
 +5uXEtFT3OX1jWLroTuoPQ5QEcrnGXrGf49wZTWu8T4XnpadEkc693Znzxg/l42wfHmE
 TvvQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RrTY9oWjwjpIDeNUaUulvnhOka5YUd8QFvJttOgj9f0WrQNZwO8NNFRKF30/TgC9eMLoJR3chrOcMw1@nongnu.org
X-Gm-Message-State: AOJu0YzRDPI+lAq1LpV7UxMqbo13on8GTz0oMtcVKlF+Aa6dkqSNkLEH
 awyM8aAmnbDzZVoV8FecfFqJZT1zidtO9ZHjz4uFpy3M76TLnbkOBWpUW7d2WJIlQF/QjQQoX+q
 FjGYYo1Ae58BxQLPaMTIJsvssVeqK1PBXCxRtuS/1Pm52G4xs/kgbPAIt
X-Gm-Gg: AfdE7ckH8QyFWqb98McM39iD+rPOmHdDCUM8PuiPUdw8vcTD/9iaoXAn83p0FKjfLHe
 Wh1bqv7fw9wDBrySY5a6399WZvVBGqtz5KrpttTlINTztd2usR2Yv3oyAt0s0u8MIFaoLLEmZX4
 YUqpe+qhDG+Ebhu4mwdYpglznYmMXgIDKhLJtAvlD+pjgeUhWm4jxnYb1x3AhUdww8+DUy+YKwa
 ME60uqSmUbc65RkurpKVySyRsCqav+YuY+8sD26JaeYl1XS7/7fOY3nDrpNzeJ99aSJUfWlkIli
 ElJsB+Ig9+B6pRDTdEJM9j2JsHtqQ6mBxwyUOglwTWaKW73ilpGuVhMts9N+pL4bLupzNPRYQMY
 RNSQ=
X-Received: by 2002:a05:6214:dcf:b0:8ef:9806:ddaa with SMTP id
 6a1803df08f44-8ef9806ee0fmr96814426d6.49.1782750491047; 
 Mon, 29 Jun 2026 09:28:11 -0700 (PDT)
X-Received: by 2002:a05:6214:dcf:b0:8ef:9806:ddaa with SMTP id
 6a1803df08f44-8ef9806ee0fmr96813586d6.49.1782750490400; 
 Mon, 29 Jun 2026 09:28:10 -0700 (PDT)
Received: from x1.local ([174.91.117.74]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-8f1a27e64a9sm2263536d6.4.2026.06.29.09.28.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 29 Jun 2026 09:28:09 -0700 (PDT)
Date: Mon, 29 Jun 2026 12:27:57 -0400
From: Peter Xu <peterx@redhat.com>
To: Avihai Horon <avihaih@nvidia.com>
Cc: =?utf-8?Q?C=C3=A9dric?= Le Goater <clg@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org,
 Alex Williamson <alex@shazbot.org>, Fabiano Rosas <farosas@suse.de>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@mailo.com>,
 Zhao Liu <zhao1.liu@intel.com>, Halil Pasic <pasic@linux.ibm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Jason Herne <jjherne@linux.ibm.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Ilya Leoshkevich <iii@linux.ibm.com>, David Hildenbrand <david@kernel.org>,
 Eric Farman <farman@linux.ibm.com>,
 Matthew Rosato <mjrosato@linux.ibm.com>,
 Cornelia Huck <cohuck@redhat.com>, Eric Blake <eblake@redhat.com>,
 Vladimir Sementsov-Ogievskiy <vsementsov@yandex-team.ru>,
 John Snow <jsnow@redhat.com>, Maor Gottlieb <maorg@nvidia.com>
Subject: Re: [PATCH v4 07/14] migration: Make switchover-ack re-usable
Message-ID: <akKdDU7VOmPz-QFT@x1.local>
References: <20260622101214.25770-1-avihaih@nvidia.com>
 <20260622101214.25770-8-avihaih@nvidia.com>
 <87v7b520uo.fsf@pond.sub.org>
 <b997b3f7-0a95-4c21-bf18-c19bf8754936@nvidia.com>
 <9fa2038d-f75b-4d6a-a2fc-1bc871878b74@redhat.com>
 <675f8d2f-ca22-4b04-bc30-8fa7b6d3a6dd@nvidia.com>
 <4a3457d3-d892-494b-b8a9-556ad9a7912a@redhat.com>
 <59fa369a-b5a1-4484-bcb0-93b663fb0c44@redhat.com>
 <64207c96-affd-4895-a6ab-2cee7ac4347e@nvidia.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <64207c96-affd-4895-a6ab-2cee7ac4347e@nvidia.com>
Received-SPF: pass client-ip=170.10.133.124; envelope-from=peterx@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.445,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On Mon, Jun 29, 2026 at 06:53:48PM +0300, Avihai Horon wrote:
> 
> On 6/29/2026 5:57 PM, Cédric Le Goater wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > Avihai
> > 
> > On 6/28/26 18:29, Cédric Le Goater wrote:
> > > On 6/28/26 12:03, Avihai Horon wrote:
> > > > 
> > > > On 6/28/2026 12:00 PM, Cédric Le Goater wrote:
> > > > > External email: Use caution opening links or attachments
> > > > > 
> > > > > 
> > > > > On 6/28/26 10:16, Avihai Horon wrote:
> > > > > > 
> > > > > > On 6/26/2026 10:54 AM, Markus Armbruster wrote:
> > > > > > > External email: Use caution opening links or attachments
> > > > > > > 
> > > > > > > 
> > > > > > > Just spelling nitpickery this time.
> > > > > > > 
> > > > > > > Avihai Horon <avihaih@nvidia.com> writes:
> > > > > > > 
> > > > > > > > Switchover-ack is a mechanism to synchronize between source and
> > > > > > > > destination QEMU during migration to prevent the
> > > > > > > > source from switching
> > > > > > > > over prematurely.
> > > > > > > > 
> > > > > > > > VFIO uses switchover-ack to ensure switchover happens only after
> > > > > > > > destination side has loaded the precopy initial
> > > > > > > > bytes. This is important
> > > > > > > > for VFIO, as otherwise downtime could be impacted and be higher.
> > > > > > > > 
> > > > > > > > In its current state, switchover-ack is a
> > > > > > > > one-time mechanism, meaning
> > > > > > > > that switchover is acked only once and past that
> > > > > > > > another ACK cannot be
> > > > > > > > requested again. This was sufficient until now,
> > > > > > > > as VFIO precopy initial
> > > > > > > > bytes was defined to be monotonically
> > > > > > > > decreasing. Thus, when precopy
> > > > > > > > initial bytes reached zero for all VFIO devices,
> > > > > > > > a single ACK would be
> > > > > > > > sent and its validity would hold.
> > > > > > > > 
> > > > > > > > However, now the new VFIO_PRECOPY_INFO_REINIT
> > > > > > > > feature allows precopy
> > > > > > > > initial bytes to be re-initialized during precopy. Specifically, it
> > > > > > > > means that initial bytes can grow after reaching zero, which would
> > > > > > > > invalidate a previously sent switchover ACK.
> > > > > > > > 
> > > > > > > > To solve this, make switchover-ack reusable and
> > > > > > > > allow devices to request
> > > > > > > > switchover ACKs when needed via the
> > > > > > > > save_query_pending SaveVMHandler.
> > > > > > > > 
> > > > > > > > Since now switchover ACK can be requested for a
> > > > > > > > specific device and in
> > > > > > > > different times, make switchover ACK per-device
> > > > > > > > (instead of a single ACK
> > > > > > > > for all devices) and let source side do the
> > > > > > > > pending ACKs accounting.
> > > > > > > > 
> > > > > > > > Keep the legacy switchover-ack mechanism for
> > > > > > > > backward compatibility and
> > > > > > > > turn it on by a compatibility property for older
> > > > > > > > machines. Enable the
> > > > > > > > property until VFIO implements the new switchover-ack.
> > > > > > > > 
> > > > > > > > Acked-by: Markus Armbruster <armbru@redhat.com>
> > > > > > > > Reviewed-by: Peter Xu <peterx@redhat.com>
> > > > > > > > Signed-off-by: Avihai Horon <avihaih@nvidia.com>
> > > > > > > > ---
> > > > > > > >   qapi/migration.json                | 14 ++++----
> > > > > > > >   include/migration/client-options.h |  1 +
> > > > > > > >   include/migration/register.h       |  2 ++
> > > > > > > >   migration/migration.h              | 32 ++++++++++++++++--
> > > > > > > >   migration/savevm.h                 |  6 ++--
> > > > > > > >   migration/migration.c              | 37 ++++++++++++++-------
> > > > > > > >   migration/options.c                | 10 ++++++
> > > > > > > >   migration/savevm.c                 | 53
> > > > > > > > +++++++++++++++++++++++-------
> > > > > > > >   migration/trace-events             |  5 +--
> > > > > > > >   9 files changed, 123 insertions(+), 37 deletions(-)
> > > > > > > > 
> > > > > > > > diff --git a/qapi/migration.json b/qapi/migration.json
> > > > > > > > index 27a7970556..9b3070e494 100644
> > > > > > > > --- a/qapi/migration.json
> > > > > > > > +++ b/qapi/migration.json
> > > > > > > > @@ -508,14 +508,12 @@
> > > > > > > >   #     (since 7.1)
> > > > > > > >   #
> > > > > > > >   # @switchover-ack: If enabled, migration will
> > > > > > > > not stop the source VM
> > > > > > > > -#     and complete the migration until an ACK is received from the
> > > > > > > > -#     destination that it's OK to do so.  Exactly when this ACK is
> > > > > > > > -#     sent depends on the migrated devices that
> > > > > > > > use this feature. For
> > > > > > > > -#     example, a device can use it to make sure
> > > > > > > > some of its data is
> > > > > > > > -#     sent and loaded in the destination before doing switchover.
> > > > > > > Here, "switchover" is used as noun.  My dictionary
> > > > > > > is happy with that.
> > > > > > > 
> > > > > > > > -#     This can reduce downtime if devices that
> > > > > > > > support this capability
> > > > > > > > -#     are present.  'return-path' capability
> > > > > > > > must be enabled to use
> > > > > > > > -#     it.  (since 8.1)
> > > > > > > > +#     and complete the migration until the destination has
> > > > > > > > +#     acknowledged that it is OK to
> > > > > > > > switchover.  The acknowledgement
> > > > > > > 
> > > > > > > Here, it's used as verb.  I think it needs to be spelled "to switch
> > > > > > > over".
> > > > > > > 
> > > > > > > Same for code comments etc.
> > > > > > 
> > > > > > Sure, I can send a patch to fix those.
> > > > > 
> > > > > Can you please send the update as a follow up patch ?
> > > > 
> > > > I was planning to send it along with the bool return value
> > > > refactor in patch #1. Would that be fine?
> > > 
> > > OK. Nothing merged yet. Let's have a v5.
> > 
> > FYI, I plan to send vfio-next before the end the week. Initial plan was
> > tomorrow.
> 
> Hi Cedric,
> 
> Actually, I have plenty of things on my plate right now and I'm not sure if
> I'll be able to send it this week.
> 
> Would it be OK if you merge the series as is and I send those two patches
> separately early next week?
> (They are actually more related to migration core, so this question should
> be addressed to Peter/Fabiano I guess...)

I'm OK either way.

The simplest to me is you can provide a small fixup for Cédric to pick up
and squash into this patch (if it's only wording changes to doc and
comments, IMHO no re-test needed), as long as Cédric is comfortable with
it, then you can send a separate patch (or patches) if that'll be on
migration.

Thanks,

-- 
Peter Xu


