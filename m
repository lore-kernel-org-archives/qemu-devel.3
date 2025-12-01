Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78852D116F5
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 15:11:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ5Y1-0001LG-DA; Mon, 01 Dec 2025 10:10:41 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vQ5Xx-0001KQ-Iw
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:10:37 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vQ5Xv-0008LL-O9
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 10:10:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764601834;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bzhu2T068t6EGwedTqy+iUWsjXfKarsbWXCKPoemWj0=;
 b=JixEzZqbFGZFy9bjHkx0Ezh+ND2a2KSZhqHsd4GJrXjoXRACduIaExqW9KkVRozkRFvUTk
 M5UADCIIa3LPBF2yMDLrQnEHbKZDlGXCCEFNpqppsDI64XUeGFn8Gj+0kFz05e4LCvPEkf
 b4LE6TrwtaCR2iFSP1vIXWyWhF3hEh8=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-269-DGA6g0Y-MFW6oaFSMVayTg-1; Mon,
 01 Dec 2025 10:10:29 -0500
X-MC-Unique: DGA6g0Y-MFW6oaFSMVayTg-1
X-Mimecast-MFC-AGG-ID: DGA6g0Y-MFW6oaFSMVayTg_1764601825
Received: from mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.12])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 1ED2318001D1; Mon,  1 Dec 2025 15:10:25 +0000 (UTC)
Received: from localhost (dhcp-192-223.str.redhat.com [10.33.192.223])
 by mx-prod-int-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 0212419560A7; Mon,  1 Dec 2025 15:10:23 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, "Chalios, Babis"
 <bchalios@amazon.es>, "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: Re: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
In-Reply-To: <8e8ab56ce4f8f2a0f0c084bd4e48958a441b40f1.camel@infradead.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-4-bchalios@amazon.es> <87qztenykd.fsf@redhat.com>
 <196b8afa77ec3253006dcde712b07f4e9c70de30.camel@infradead.org>
 <87ldjmnwyt.fsf@redhat.com>
 <8e8ab56ce4f8f2a0f0c084bd4e48958a441b40f1.camel@infradead.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 01 Dec 2025 16:10:21 +0100
Message-ID: <87ikeqnspu.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.0 on 10.30.177.12
Received-SPF: pass client-ip=170.10.129.124; envelope-from=cohuck@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On Mon, Dec 01 2025, David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2025-12-01 at 14:38 +0100, Cornelia Huck wrote:
>> On Mon, Dec 01 2025, David Woodhouse <dwmw2@infradead.org> wrote:
>>=20
>> > On Mon, 2025-12-01 at 14:04 +0100, Cornelia Huck wrote:
>> > > On Mon, Dec 01 2025, "Chalios, Babis" <bchalios@amazon.es> wrote:
>> > >=20
>> > > > VMClock now supports a vm_generation_counter field in the struct it
>> > > > exposes to userspace. The field signals a disruption that happened=
 due
>> > > > to a guest loaded from a snapshot.
>> > > >=20
>> > > > Moreover, VMClock now optionally supports device notifications whe=
n the
>> > > > seq_count changes to a new even value.
>> > > >=20
>> > > > Signed-off-by: Babis Chalios <bchalios@amazon.es>
>> > > > ---
>> > > > =C2=A0include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++=
++++++++++
>> > > > =C2=A01 file changed, 20 insertions(+)
>> > >=20
>> > > Please either do a full linux-headers update against a specific Linux
>> > > kernel version, or mark this as a placeholder patch if the code is n=
ot
>> > > yet merged.
>> >=20
>> > The Linux patches are being posted simultaneously, so they'll be in
>> > Linux 6.20 (7.0?) at the earliest. We'll want to ingest the update
>> > before then.
>> >=20
>> > The intent is not for the Linux source to be the canonical definition
>> > of the data structure; we *are* working on publishing the spec, and
>> > Babis referenced the current draft. It isn't in the form of C source
>> > code though, so I suspect it makes sense to keep including the Linux
>> > header?
>>=20
>> Oh, including the Linux header sounds fine; but as long as the code has
>> not yet been merged there, this needs to be marked as not yet ready to
>> merge on the QEMU side. (And it needs to be updated by a full headers
>> update when merged.)
>
> That's exactly what we *don't* want, and why we say that the canonical
> definition of this structure is the actual specification. There's no
> need for QEMU to only ever follow Linux.
>
> In that case, probably best *not* to use the Linux header and instead
> to build our own specifically for QEMU based on the specification. It
> can be almost byte-for-byte identical, but just needs to live elsewhere
> rather than in <standard-headers/linux>

Yes, if you want to disentangle this, the header needs to go somewhere
else in QEMU. This is only my "someone changed something in
standard-headers without a headers sync" triggering ;)


