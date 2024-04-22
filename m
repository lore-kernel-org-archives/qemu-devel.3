Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B181C07C79
	for <qemu-devel@archiver.kernel.org>; Mon, 22 Apr 2024 15:04:07 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ryvCp-0000Dm-8y; Mon, 22 Apr 2024 11:03:43 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryvCf-0008Ud-6F
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:03:33 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1ryvCb-0006bN-Sv
 for qemu-devel@nongnu.org; Mon, 22 Apr 2024 11:03:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1713798209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdDc6WXJuq/j61tE7mxWaOSVj7MV2NeZEPjXCUBwqgo=;
 b=gXhDoCowIbJmzx090JdF1tphtnSGD+GbOcKj7w30BgvagwAYmzThCus6HaYQ2qgtbeSLrS
 jcZEG+gdgH9y1nKpZ8j4WW4cP+YD0RXZKdKzE7VzR9MPWhLfeqfuU7btiM+fqc0/g4wtQN
 /6VmYE1bKum1u0I9+oWPQTAcMnReflI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-130-rK0zSUoONgOEBjPZ-9xkJQ-1; Mon, 22 Apr 2024 11:03:22 -0400
X-MC-Unique: rK0zSUoONgOEBjPZ-9xkJQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com
 [10.11.54.6])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 25B62811008;
 Mon, 22 Apr 2024 15:03:22 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.247])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 01B1D2166B32;
 Mon, 22 Apr 2024 15:03:22 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 151A921E66C8; Mon, 22 Apr 2024 17:03:21 +0200 (CEST)
From: Markus Armbruster <armbru@redhat.com>
To: Daniel P. =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>
Cc: Michael Roth <michael.roth@amd.com>,  qemu-devel@nongnu.org,
 kvm@vger.kernel.org,  Tom Lendacky <thomas.lendacky@amd.com>,  Paolo
 Bonzini <pbonzini@redhat.com>,  Pankaj Gupta <pankaj.gupta@amd.com>,
 Xiaoyao Li <xiaoyao.li@intel.com>,  Isaku Yamahata
 <isaku.yamahata@linux.intel.com>,  Dov Murik <dovmurik@linux.ibm.com>
Subject: Re: [PATCH v3 43/49] qapi, i386: Move kernel-hashes to
 SevCommonProperties
In-Reply-To: <ZfrUiBlbEVHkMYl0@redhat.com> ("Daniel P. =?utf-8?Q?Berrang?=
 =?utf-8?Q?=C3=A9=22's?= message of
 "Wed, 20 Mar 2024 12:20:24 +0000")
References: <20240320083945.991426-1-michael.roth@amd.com>
 <20240320083945.991426-44-michael.roth@amd.com>
 <ZfrUiBlbEVHkMYl0@redhat.com>
Date: Mon, 22 Apr 2024 17:03:21 +0200
Message-ID: <87bk61cudi.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -27
X-Spam_score: -2.8
X-Spam_bar: --
X-Spam_report: (-2.8 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.669,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

Daniel P. Berrang=C3=A9 <berrange@redhat.com> writes:

> On Wed, Mar 20, 2024 at 03:39:39AM -0500, Michael Roth wrote:
>> From: Dov Murik <dovmurik@linux.ibm.com>
>>=20
>> In order to enable kernel-hashes for SNP, pull it from
>> SevGuestProperties to its parent SevCommonProperties so
>> it will be available for both SEV and SNP.
>>=20
>> Signed-off-by: Dov Murik <dovmurik@linux.ibm.com>
>> Signed-off-by: Michael Roth <michael.roth@amd.com>
>> ---
>>  qapi/qom.json     | 14 +++++++-------
>>  target/i386/sev.c | 44 ++++++++++++++++++--------------------------
>>  2 files changed, 25 insertions(+), 33 deletions(-)
>
> This change ought to be squashed into the earlier patch
> that introduce sev-guest-common.

Concur.

[...]


