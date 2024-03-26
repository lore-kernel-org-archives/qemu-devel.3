Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3208CC6FD1F
	for <qemu-devel@archiver.kernel.org>; Tue, 26 Mar 2024 13:33:06 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rp6ul-0003vZ-Vk; Tue, 26 Mar 2024 09:32:32 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp6uk-0003vF-Ve
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:32:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rp6ui-0003aL-9i
 for qemu-devel@nongnu.org; Tue, 26 Mar 2024 09:32:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1711459946;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=JYLy1OCZ/WnjMGSmPadg1kQr5dKf8rmhteT200xQIug=;
 b=C8MkIQ7ieKCbPNDQyF5X2GFjgpQqcJWD2JeztFmfY/cL5IpoYlK+ShgcT4d8CbcUbbS/Ba
 nEZRw5AES4+6pfMyeJFlIhBIFAtR88SsVse0IOeeheM7/kRtdxqAw9WzCAcuZHSfXEb0fd
 d07ZpCj8lHPhGqdOhtiOmv/A37KeNi0=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-645-7ebkT3aZODGhrQ3OntrHZg-1; Tue, 26 Mar 2024 09:32:21 -0400
X-MC-Unique: 7ebkT3aZODGhrQ3OntrHZg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8047B101A58F;
 Tue, 26 Mar 2024 13:32:19 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.81])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40DD6107A8;
 Tue, 26 Mar 2024 13:32:18 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 27DA821E669D; Tue, 26 Mar 2024 14:32:13 +0100 (CET)
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
 Blake <eblake@redhat.com>,  Song Gao <gaosong@loongson.cn>,  Huacai Chen
 <chenhuacai@kernel.org>,  Aurelien Jarno <aurelien@aurel32.net>,  Jiaxun
 Yang <jiaxun.yang@flygoat.com>,  Aleksandar Rikalo
 <aleksandar.rikalo@syrmia.com>,  Nicholas Piggin <npiggin@gmail.com>,
 Daniel Henrique Barboza <danielhb413@gmail.com>,  Palmer Dabbelt
 <palmer@dabbelt.com>,  Alistair Francis <alistair.francis@wdc.com>,  Bin
 Meng <bin.meng@windriver.com>,  Weiwei Li <liwei1518@gmail.com>,  Liu
 Zhiwei <zhiwei_liu@linux.alibaba.com>
Subject: Re: [RFC PATCH-for-9.1 21/21] qapi: Make @query-cpu-definitions
 target-agnostic
In-Reply-To: <20240315130910.15750-22-philmd@linaro.org> ("Philippe
 =?utf-8?Q?Mathieu-Daud=C3=A9=22's?= message of "Fri, 15 Mar 2024 14:09:09
 +0100")
References: <20240315130910.15750-1-philmd@linaro.org>
 <20240315130910.15750-22-philmd@linaro.org>
Date: Tue, 26 Mar 2024 14:32:13 +0100
Message-ID: <87o7b1m84i.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.5
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -21
X-Spam_score: -2.2
X-Spam_bar: --
X-Spam_report: (-2.2 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.088,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_NONE=0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

> All targets use the generic_query_cpu_definitions() method,
> which is not target-specific. Make the command target agnostic
> by moving it to machine.json. Rename generic_query_cpu_definitions
> as qmp_query_cpu_definitions.
>
> This is an introspection change for the target that were not
> implementing qmp_query_cpu_definitions(): now query-cpu-definitions
> returns an their CPUs list.

Do you mean "returns their CPUs list"?

>
> Example with SH4 before:
>
>   { "execute": "query-cpu-definitions" }
>
>   { "error": {"class": "CommandNotFound", "desc": "The command query-cpu-=
definitions has not been found"} }
>
> and after:
>
>   { "execute": "query-cpu-definitions" }
>
>   { "return": [
>           {"name": "sh7751r", "typename": "sh7751r-superh-cpu", "static":=
 false, "deprecated": false},
>           {"name": "sh7750r", "typename": "sh7750r-superh-cpu", "static":=
 false, "deprecated": false},
>           {"name": "sh7785", "typename": "sh7785-superh-cpu", "static": f=
alse, "deprecated": false}
>       ]
>   }

Does the result make sense?  What do the callbacks add for the targets
that define them, and why do the other targets don't need them?

Conversion steps:

0. Create a generic version of the command, with optional callbacks
   [PATCH 14]

1. Turn the target-specific versions of the command into thin wrappers
   around the generic version one by one, supplying callbacks to
   preserve behavior [PATCH 15-20]

2. Peel off the wrappers [this patch]

3. Enable the command for all the other targets [also this patch]

Correct?

Split this patch?  Question, not a demand.

I think the commit messages of the step 1 patches should explain the
target-specific behavior, i.e. the difference between their callbacks
and the default behavior.

Obvious for cpu_list_compare(): sorted vs. unsorted.

Not obvious for add_definition().

> However this allows heterogeneous emulation to return a correct list.

Cryptic.  It made me go back to PATCH 14, where I discovered the loop
over the arch bits.

> Signed-off-by: Philippe Mathieu-Daud=C3=A9 <philmd@linaro.org>
> ---
> Well, not all target got converted, I left the s390x one for later :)

Haha!


