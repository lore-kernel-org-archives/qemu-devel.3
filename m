Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BB857CCF9E3
	for <qemu-devel@archiver.kernel.org>; Fri, 24 Oct 2025 13:41:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vCI2k-0000rQ-K9; Fri, 24 Oct 2025 09:41:22 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCI2h-0000nM-5u
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:41:19 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1vCI2e-0000FN-BN
 for qemu-devel@nongnu.org; Fri, 24 Oct 2025 09:41:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1761313274;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JQ8uVIxocZv5A1dzBFS8FmytxEHoj/uCugF1QlAGDbc=;
 b=MUdc/jDnJjn8ctf/hqE4+JwsA3zc/Vng31jT0RCoFPpTXT67Nv5+Uq7QszURriYL0GbhUF
 NFOE4bSXWznGLTe9zPsOg/L79RgtaiSNWjlH8e0Z4B+tmQ22xYA+BZ4CjuJqSuisdS5qfM
 YhDI1NFu365RZQwTf6lFC54NPIw6iJM=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-14-lXwG8sTIMlOR4UpzDK0eWA-1; Fri,
 24 Oct 2025 09:41:11 -0400
X-MC-Unique: lXwG8sTIMlOR4UpzDK0eWA-1
X-Mimecast-MFC-AGG-ID: lXwG8sTIMlOR4UpzDK0eWA_1761313270
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 2C03A19540E3; Fri, 24 Oct 2025 13:41:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.45.242.24])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id D2E3B1800353; Fri, 24 Oct 2025 13:41:09 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 6901B21E6A27; Fri, 24 Oct 2025 15:41:07 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Bin Guo <guobin@linux.alibaba.com>,  qemu-devel@nongnu.org,
 peterx@redhat.com,  farosas@suse.de
Subject: Re: [PATCH] migration: Don't free the reason after calling
 migrate_add_blocker
In-Reply-To: <aPtim8ZACUWyje2o@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Fri, 24 Oct 2025 12:27:23 +0100")
References: <20251024092821.82220-1-guobin@linux.alibaba.com>
 <87o6pw1rfn.fsf@pond.sub.org> <aPtim8ZACUWyje2o@redhat.com>
Date: Fri, 24 Oct 2025 15:41:07 +0200
Message-ID: <874irozabw.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Fri, Oct 24, 2025 at 01:15:40PM +0200, Markus Armbruster wrote:
>> Bin Guo <guobin@linux.alibaba.com> writes:
>>=20
>> > Signed-off-by: Bin Guo <guobin@linux.alibaba.com>
>> > ---
>> >  hw/intc/arm_gicv3_kvm.c | 1 -
>> >  target/i386/sev.c       | 1 -
>> >  2 files changed, 2 deletions(-)
>> >
>> > diff --git a/hw/intc/arm_gicv3_kvm.c b/hw/intc/arm_gicv3_kvm.c
>> > index 66b0dddfd4..6f311e37ef 100644
>> > --- a/hw/intc/arm_gicv3_kvm.c
>> > +++ b/hw/intc/arm_gicv3_kvm.c
>> > @@ -841,7 +841,6 @@ static void kvm_arm_gicv3_realize(DeviceState *dev=
, Error **errp)
>> >          error_setg(&kvm_nv_migration_blocker,
>> >                     "Live migration disabled because KVM nested virt i=
s enabled");
>> >          if (migrate_add_blocker(&kvm_nv_migration_blocker, errp)) {
>> > -            error_free(kvm_nv_migration_blocker);
>> >              return;
>> >          }
>> >=20=20
>> > diff --git a/target/i386/sev.c b/target/i386/sev.c
>> > index 1057b8ab2c..fd2dada013 100644
>> > --- a/target/i386/sev.c
>> > +++ b/target/i386/sev.c
>> > @@ -1661,7 +1661,6 @@ sev_snp_launch_finish(SevCommonState *sev_common)
>> >      ret =3D migrate_add_blocker(&sev_mig_blocker, &local_err);
>> >      if (local_err) {
>> >          error_report_err(local_err);
>> > -        error_free(sev_mig_blocker);
>> >          exit(1);
>> >      }
>> >  }
>>=20
>> Does this fix use-after-free bugs?
>
> I don't think so, because when migrate_add_blocker() returns error,
> the Error for the blocker will have been propagated into the errp
> parameter, and then set to NULL. So these two error_free calls
> should be a no-op.
>
> But wow, the migrate_add_blocker API design is unpleasant with its
> pair of "Error **" parameters - it is practically designed to
> maximise confusion & surprise.

It's quite a sight, isn't it?

I'll give it a quick Friday afternoon try.


