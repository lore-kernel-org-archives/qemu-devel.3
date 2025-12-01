Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2603AD116F1
	for <qemu-devel@archiver.kernel.org>; Mon,  1 Dec 2025 13:37:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vQ44q-0004pa-Rw; Mon, 01 Dec 2025 08:36:28 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vQ44k-0004ov-U1
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:36:24 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vQ44j-00026U-ET
 for qemu-devel@nongnu.org; Mon, 01 Dec 2025 08:36:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1764596180;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZGLrJyRuwHlPiztyThnIhS+d8bUTt+1tgf1Jl3CvMNM=;
 b=V/VQ5WSodv3mXH+urLJbkryPZejhQgcOu19nxPUAwlrz3jguJ+avtxUxHYw1tG6MOsYGEB
 AnKMVHq+S5vBhjrR8I+PfhHXbdacdu9x6RewK0Ftta99jp+CMY9cchcv5yMA+bjrOfjy7s
 KA8miE5cQF/Tx3k3En/lqOfkqNkyT3c=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-604-HvRQur9gP0KHJ7z3dPD-Cw-1; Mon,
 01 Dec 2025 08:36:18 -0500
X-MC-Unique: HvRQur9gP0KHJ7z3dPD-Cw-1
X-Mimecast-MFC-AGG-ID: HvRQur9gP0KHJ7z3dPD-Cw_1764596177
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id EB298180035F; Mon,  1 Dec 2025 13:36:16 +0000 (UTC)
Received: from localhost (dhcp-192-223.str.redhat.com [10.33.192.223])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id B395C180057F; Mon,  1 Dec 2025 13:36:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Babis Chalios <bchalios@amazon.es>, "mst@redhat.com" <mst@redhat.com>,
 "imammedo@redhat.com" <imammedo@redhat.com>, "pbonzini@redhat.com"
 <pbonzini@redhat.com>
Cc: "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>, "dwmw2@infradead.org"
 <dwmw2@infradead.org>, "Graf (AWS), Alexander" <graf@amazon.de>,
 "mzxreary@0pointer.de" <mzxreary@0pointer.de>, bchalios@amazon.es
Subject: Re: [RFC PATCH 2/4] hw/acpi: add new fields in VMClock ABI
In-Reply-To: <cb2e2892-3e11-4e1e-b0e4-7191a78cc497@amazon.es>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20251201125023.18344-1-bchalios@amazon.es>
 <20251201125023.18344-4-bchalios@amazon.es> <87qztenykd.fsf@redhat.com>
 <cb2e2892-3e11-4e1e-b0e4-7191a78cc497@amazon.es>
User-Agent: Notmuch/0.38.3 (https://notmuchmail.org)
Date: Mon, 01 Dec 2025 14:36:13 +0100
Message-ID: <87o6oinx2q.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Mon, Dec 01 2025, Babis Chalios <bchalios@amazon.es> wrote:

> On 12/1/25 14:04, Cornelia Huck wrote: 
>
>  
> On Mon, Dec 01 2025, "Chalios, Babis" <bchalios@amazon.es> wrote:
>
>  VMClock now supports a vm_generation_counter field in the struct it
> exposes to userspace. The field signals a disruption that happened due
> to a guest loaded from a snapshot.
>
> Moreover, VMClock now optionally supports device notifications when the
> seq_count changes to a new even value.
>
> Signed-off-by: Babis Chalios <bchalios@amazon.es>
> ---
>  include/standard-headers/linux/vmclock-abi.h | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
>
>
> Please either do a full linux-headers update against a specific Linux
> kernel version, or mark this as a placeholder patch if the code is not
> yet merged.
>
> Indeed, that's a placeholder. What's the process to mark this as a placeholder?

I think a simple "DO NOT MERGE" in the subject will do :)


