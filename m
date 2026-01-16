Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A4C982CA
	for <qemu-devel@archiver.kernel.org>; Fri, 16 Jan 2026 15:34:59 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vglpg-0006c9-9P; Fri, 16 Jan 2026 10:33:52 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vglpe-0006aB-Bo
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 10:33:50 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vglpc-0004Fs-Bz
 for qemu-devel@nongnu.org; Fri, 16 Jan 2026 10:33:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1768577626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z7DSsGSwfG5zmPUsYyY6FYuKzt2JCK2PYvbg3P8jF28=;
 b=bggi/a/I8mhynk/S8dj+lxnTQgne1SU5AGGllgvzp7609gY/+lI5pvz3JjenZbIX9fjP7M
 jOO8n1nmhL5mUPPcxBK21DC2TDIaesHEW8rR2V5g5thHzvsCArYDPcN3IXWdSFPc4XUJFP
 VntzkJbPORhLGKjRc2ToQVTMuGEavQU=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-74-ZPW_0_5WNEiewpFQ4oTVfQ-1; Fri,
 16 Jan 2026 10:33:43 -0500
X-MC-Unique: ZPW_0_5WNEiewpFQ4oTVfQ-1
X-Mimecast-MFC-AGG-ID: ZPW_0_5WNEiewpFQ4oTVfQ_1768577622
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 6231619560A7; Fri, 16 Jan 2026 15:33:41 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.32])
 by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 26D183001DB9; Fri, 16 Jan 2026 15:33:40 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id B854121E692D; Fri, 16 Jan 2026 16:33:37 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Xu <peterx@redhat.com>
Cc: Zhang Chen <zhangckid@gmail.com>,  Lukas Straub <lukasstraub2@web.de>,
 qemu-devel@nongnu.org,  Juraj Marcin <jmarcin@redhat.com>,  Fabiano Rosas
 <farosas@suse.de>,  Daniel P . =?utf-8?Q?Berrang=C3=A9?=
 <berrange@redhat.com>,  Juan
 Quintela <quintela@trasno.org>,  "Dr. David Alan Gilbert"
 <dave@treblig.org>,  zhanghailiang@xfusion.com,  Li Zhijian
 <lizhijian@fujitsu.com>,  Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] migration/colo: Deprecate COLO migration framework
In-Reply-To: <aWpGY9Y1dPwlBuw3@x1.local> (Peter Xu's message of "Fri, 16 Jan
 2026 09:08:35 -0500")
References: <20260114195659.2543649-1-peterx@redhat.com>
 <20260114195659.2543649-2-peterx@redhat.com>
 <aWf4i7EOXtpAljGX@x1.local> <20260115224929.616aab85@penguin>
 <87ecnqt6nc.fsf@pond.sub.org>
 <CAK3tnvKUXk9yvvTKC6cJOKnMJrhZz6W_ZuKze=rqj8JHAREg1g@mail.gmail.com>
 <87ecnpyjw7.fsf@pond.sub.org> <aWpGY9Y1dPwlBuw3@x1.local>
Date: Fri, 16 Jan 2026 16:33:37 +0100
Message-ID: <87ldhxtvvy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
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

Peter Xu <peterx@redhat.com> writes:

> On Fri, Jan 16, 2026 at 10:41:28AM +0100, Markus Armbruster wrote:
>> Zhang Chen <zhangckid@gmail.com> writes:
>>=20
>> > On Fri, Jan 16, 2026 at 2:26=E2=80=AFPM Markus Armbruster <armbru@redh=
at.com> wrote:

[...]

>> >> I think we should deprecate COLO now to send a clear distress signal.
>> >> The deprecation notice should explain it doesn't work, and will be
>> >> removed unless people step up to fix it and to maintain it.  This will
>> >> ensure progress one way or the other.  Doing nothing now virtually
>> >> ensures we'll have the same discussion again later.
>> >>
>> >> "Broken for two releases without anyone noticing" and "maintainer abs=
ent
>> >> for more than four years" doesn't exacltly inspire hope, though.  We
>> >> should seriously consider removing it right away.
>> >>
>> >> Lukas, can you give us hope?
>> >>
>> >
>> > Hi Markus,
>> > Maybe you missed something?
>> > I think Lukas is ready to maintain this code in his previous emails.
>> > https://lore.kernel.org/qemu-devel/20260115224516.7f0309ba@penguin/T/#=
mc99839451d6841366619c4ec0d5af5264e2f6464
>>=20
>> Patch to MAINTAINERS or it didn't happen ;)
>
> I'd even say MAINTAINERS file is, in many cases, cosmetic..
>
> It definitely is helpful for people to do lookups or scripts to fetch
> information, but IMHO we need more than one single entry, and in some sen=
se
> that entry is less important than the activities.
>
> We need someone to be first familiar with a piece of code, spend time on
> it, actively reply to the relevant queries upstream, proper testing /
> gating to make sure the feature is usable as stated - either fully
> maintained or odd fixes or others, and more.

Yes, we need a maintainer not just in name, but for real.

(My one-liner was an attempt at a joke)

> I used to request Lukas help reviewing the loadvm threadify series [1,2]
> which definitely touches COLO, I didn't really get a respond.  That's also
> a sign I don't feel like Lucas cares enough about COLO, after I explicitly
> pointing out something might be changing and might be risky.
>
> It's like Hailiang is also in the MAINTAINERS file but Hailiang is
> unfortunately not active anymore recently over the years.

We're bad at updating the MAINTAINERS file when maintainers have
wandered off.

> Frankly, it was Zhijian and Chen that were always helping from that regar=
d.
> I would rather think anyone of both would be more suitable at least from
> all the discussions I had with COLO, but this is a promise I can't do.  I
> also still want to remove it as I proposed, in case it releases everyone.
>
> So an update in the file isn't even enough if we accept it.  We need
> activity corresponding to the file change.  That's also why I still think
> we should remove COLO regardless if 11.0 doesn't improve in this conditio=
n,
> as I stated in the other email.

Concur.

> [1] https://lore.kernel.org/qemu-devel/aSSx28slqi1ywg2v@x1.local
> [2] https://lore.kernel.org/all/20251022192612.2737648-1-peterx@redhat.com
>
> Thanks,


