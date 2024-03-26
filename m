Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0131CD11DD
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 12:12:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp5f9-0003w0-UE; Tue, 26 Mar 2024 08:12:19 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp5f8-0003sa-48
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:12:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp5f6-0003JI-BR
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 08:12:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711455135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JK7PxkLrpc8p4rqT0olFI4lkMD6HLzYQkR7E4sD9yko=;
 b=YvYBBhUSdpf3XcddxRtnNZsyMZhDd0dHt0hFrNxhPf2QNHHNhxtzHDJ2RHoSaEpwD11k00
 YhkBkNPFH2QAcQkHAkUhPTqDRH70YmhTIl8gyzzfHU5CWsiixVYcRzKXnVHq44qzjJbL0m
 lfuXLoe8Mhtb1jIyBn3sWbqVSPj85kk=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-140-mYzH5MSJMiuocBk96IiVjQ-1; Tue,
 26 Mar 2024 08:12:11 -0400
X-MC-Unique: mYzH5MSJMiuocBk96IiVjQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com
 [10.11.54.7])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BE0F31C01B20;
 Tue, 26 Mar 2024 12:12:10 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 2F5B01C060D6;
 Tue, 26 Mar 2024 12:12:10 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 110F821E669D; Tue, 26 Mar 2024 13:12:05 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Philippe =?utf-8?Q?Mathieu-Daud=C3=A9?= <philmd@linaro.org>
Cc: qemu-devel@nongnu.org,  qemu-riscv@nongnu.org,  Anton Johansson
 <anjo@rev.ng>,  qemu-s390x@nongnu.org,  qemu-ppc@nongnu.org,  Daniel P .
 =?utf-8?Q?Berrang=C3=A9?= <berrange@redhat.com>,  Paolo Bonzini
 <pbonzini@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>,  Claudio Fontana
 <cfontana@suse.de>,  Richard Henderson <richard.henderson@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,  Alex =?utf-8?Q?Benn=C3=A9e?=
 <alex.bennee@linaro.org>,  Manos Pitsidianakis
 <manos.pitsidianakis@linaro.org>,  Zhao Liu <zhao1.liu@intel.com>,
 qemu-arm@nongnu.org,  Thomas Huth <thuth@redhat.com>,  Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>,  Yanan Wang <wangyanan55@huawei.com>,  Eric
 Blake <eblake@redhat.com>,  Michael Roth <michael.roth@amd.com>,  David
 Hildenbrand <david@redhat.com>,  Ilya Leoshkevich <iii@linux.ibm.com>
Subject: Re: [PATCH-for-9.1 09/21] qapi: Merge machine-common.json with
 qapi/machine.json
In-Reply-To: <20240315130910.15750-10-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 15 Mar 2024 14:08:57
 +0100")
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-10-philmd@linaro.org>
Date: Tue, 26 Mar 2024 13:12:05 +0100
Message-ID: <874jctp4yy.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.7
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
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

Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org> writes:

> machine-common.json declares a single type, which isn't
> restricted to a particular target. Move this type in
> machine.json.
>
> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>

Previous discussion at
https://lore.kernel.org/qemu-devel/875y45kt8i.fsf@pond.sub.org/

CpuS390Entitlement is specific to s390x.  We need it for
set-cpu-topology and the s390x-specific part of query-cpus-fast.  The
former is conditional on TARGET_S390X, and therefore must be in
machine-target.json.  The latter is not conditional, and in
machine.json.  If I remember correctly, I briefly explored making it
conditional, but it was too messy to be worth the bother.

Anyway.  We have a target-specific type we want to use both in
machine.json and machine-target.json.  Neither of the two includes the
other.  Target-independent machine.json cannot include target-specific
machine-target.json.  Two solutions:

1. Define the type in machine.json, have machine-target.json include
machine.json.  Ugly: even more target-stuff in machine.json.
Potentially slow: including qapi/qapi-*-machine-target.h now includes
more.

2. Define the type in a submodule both include.  Since nothing they
include is a fitting home for the type, create one: machine-common.json.
Ugly & potentially slow: yet another submodule.

Nina chose to do 2.

I figure I'd leave it as is until we get to the point where we can get
rid of the *-target.json entirely.


