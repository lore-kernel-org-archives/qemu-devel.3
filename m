Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED539C44508
	for <qemu-devel@archiver.kernel.org>; Wed, 21 Jan 2026 17:37:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vic8m-0002jG-0M; Wed, 21 Jan 2026 12:37:12 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vic8N-0002bZ-5V
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:36:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vic8H-0003GT-WE
 for qemu-devel@nongnu.org; Wed, 21 Jan 2026 12:36:44 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1769017000;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=O8AMNXVxgRHV9d6/+iQFocctExWtovTgGRc2twzcjp0=;
 b=Z2CbUC297CFpKr0+0nXrH5iK/TfpAMzuyytur1dHr75QsRMJkHrAAhnaCztRMvYBA9GcQT
 9fzWdlZ77FvaeKB/3HY1h98Hh8Vl41EUq4HBO/cT6IxJK8bWvmZwUeucjo7ei+bPQ1HGU6
 8lASKDFDVPxZIksH7LyCNejLoFM+Pos=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-270-TjQGpJrwNJCV-0KWVuWiYw-1; Wed,
 21 Jan 2026 12:36:36 -0500
X-MC-Unique: TjQGpJrwNJCV-0KWVuWiYw-1
X-Mimecast-MFC-AGG-ID: TjQGpJrwNJCV-0KWVuWiYw_1769016994
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4CACF1800342; Wed, 21 Jan 2026 17:36:34 +0000 (UTC)
Received: from localhost (unknown [10.44.34.34])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id CEF8C30002D5; Wed, 21 Jan 2026 17:36:32 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>, Thomas Huth <thuth@redhat.com>
Cc: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org, Eduardo Habkost <eduardo@habkost.net>, Marcel
 Apfelbaum <marcel.apfelbaum@gmail.com>, qemu-devel@nongnu.org
Subject: Re: [PATCH] hw/arm: Move the "arm-cpu" compat settings out of
 hw/core/machine.c
In-Reply-To: <CAFEAcA_0xM47w6tLgGSrXZO2v1S+ncq92N_h3U=HQENapzyU9Q@mail.gmail.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260120122108.131708-1-thuth@redhat.com>
 <CAFEAcA8nzm+CEN_Dp+X+AggcTg57wAt8D43x-7oixLeNH4TDdA@mail.gmail.com>
 <791eac72-f4d2-48b5-9973-c64006e8ce13@redhat.com>
 <CAFEAcA_0xM47w6tLgGSrXZO2v1S+ncq92N_h3U=HQENapzyU9Q@mail.gmail.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Wed, 21 Jan 2026 18:36:30 +0100
Message-ID: <875x8uuau9.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.069,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On Tue, Jan 20 2026, Peter Maydell <peter.maydell@linaro.org> wrote:

> On Tue, 20 Jan 2026 at 14:15, Thomas Huth <thuth@redhat.com> wrote:
>>
>> On 20/01/2026 13.55, Peter Maydell wrote:
>> > On Tue, 20 Jan 2026 at 12:21, Thomas Huth <thuth@redhat.com> wrote:
>> >>
>> >> From: Thomas Huth <thuth@redhat.com>
>> >>
>> >> The hw_compat_* arrays in hw/core/machine.c should be used for generic
>> >> compat settings that might affect all (or at least multiple) machines.
>> >> Target specific settings should rather go into the target specific
>> >> source files instead. For arm/aarch64, the virt machine is the only
>> >> one that cares about compat settings, so move the "arm-cpu" related
>> >> switches to hw/arm/virt.c now.

FWIW, this is not the only arch-specific setting in there, and I don't
think it's really bothersome. There are many compat settings that might
not be applicable when you spin up a machine, and that's fine.

>> >
>> > I think it makes more sense for all the compat stuff to
>> > live in one place, rather than being scattered around,
>> > unless it is truly machine-specific (which this isn't).
>>
>> It's only used by the arm virt machine, so it's IMHO machine specific.
>> If we will ever get other versionized arm machines, they won't use these
>> config knobs, so this never will be shared with another machine.
>
> It happens to be only used by the virt board, but that's just
> a coincidence that we only have one versioned arm board right
> now. The config knob itself is not at all board specific:
> it applies to a device object that is used by many boards and
> sets a behaviour that would usefully apply to all of them.
> If we ever did have more arm versioned machines in the future
> we'd end up with a weird split where compat properties of the CPU
> object that happened to pre-date the addition of that second
> machine type would be in one place in the source code, and
> properties that happened to post-date the second machine
> type would be somewhere else.

I think there are only two options that really make sense:
- keep the compat setting where it is
- introduce an arm specific compat array that can be included by the
  virt machine and any future versioned arm machine

Not sure if the latter is actually worth the hassle.


