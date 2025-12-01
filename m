Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F1A3D116F3
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:39:30 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ47O-0005Vg-09; Mon, 01 Dec 2025 08:39:07 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vQ474-0005UJ-QX
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:38:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vQ472-0002GH-NG
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:38:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764596323;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Np+kZn/BP9ZiPIA8vAyelEGRiyinb/zdtSGf9KVAzQc=;
 b=RsL/2De/UAg0TsrfzPB4L7o1JNSTSPDuHNKT7tGCHeKnO0xVlG3R0qtQZOGCKAg9Zdr2Ul
 XjukH2NSEgxWy49RGnoAjg8n3FqhbdBCanS+ZNY9IJtTDDx/5bJpsb3mINC3gknJfszZZ9
 lRGQQIBGPdrxBWgcupqV0LuhY4Kw4iI=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-144-TY8z5uhtMQKXjMGdlOyQ_g-1; Mon,
 01 Dec 2025 08:38:40 -0500
X-MC-Unique: TY8z5uhtMQKXjMGdlOyQ_g-1
X-Mimecast-MFC-AGG-ID: TY8z5uhtMQKXjMGdlOyQ_g_1764596319
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id DBBB219560AF; Mon,  1 Dec 2025 13:38:38 +0000 (UTC)
Received: from localhost (dhcp-192-223.str.redhat.com [10.33.192.223])
 by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id BFCE51800367; Mon,  1 Dec 2025 13:38:37 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: David Woodhouse <dwmw2@infradead.org>, "Chalios, Babis"
 <bchalios@amazon.es>, "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "Graf (AWS), Alexander"
 <graf@amazon.de>, "mzxreary@0pointer.de" <mzxreary@0pointer.de>
Subject: Re: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
In-Reply-To: <196b8afa77ec3253006dcde712b07f4e9c70de30.camel@infradead.org>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-4-bchalios@amazon.es> <87qztenykd.fsf@redhat.com>
 <196b8afa77ec3253006dcde712b07f4e9c70de30.camel@infradead.org>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 01 Dec 2025 14:38:34 +0100
Message-ID: <87ldjmnwyt.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
Received-SPF: pass client-ip=170.10.133.124; envelope-from=cohuck@redhat.com;
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

On Mon, Dec 01 2025, David Woodhouse <dwmw2@infradead.org> wrote:

> On Mon, 2025-12-01 at 14:04 +0100, Cornelia Huck wrote:
>> On Mon, Dec 01 2025, "Chalios, Babis" <bchalios@amazon.es> wrote:
>>=20
>> > VMClock now supports a vm_generation_counter field in the struct it
>> > exposes to userspace. The field signals a disruption that happened due
>> > to a guest loaded from a snapshot.
>> >=20
>> > Moreover, VMClock now optionally supports device notifications when the
>> > seq_count changes to a new even value.
>> >=20
>> > Signed-off-by: Babis Chalios <bchalios@amazon.es>
>> > ---
>> > =C2=A0include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++++++=
++++++
>> > =C2=A01 file changed, 20 insertions(+)
>>=20
>> Please either do a full linux-headers update against a specific Linux
>> kernel version, or mark this as a placeholder patch if the code is not
>> yet merged.
>
> The Linux patches are being posted simultaneously, so they'll be in
> Linux 6.20 (7.0?) at the earliest. We'll want to ingest the update
> before then.
>
> The intent is not for the Linux source to be the canonical definition
> of the data structure; we *are* working on publishing the spec, and
> Babis referenced the current draft. It isn't in the form of C source
> code though, so I suspect it makes sense to keep including the Linux
> header?

Oh, including the Linux header sounds fine; but as long as the code has
not yet been merged there, this needs to be marked as not yet ready to
merge on the QEMU side. (And it needs to be updated by a full headers
update when merged.)


