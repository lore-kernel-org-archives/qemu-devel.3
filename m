Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 515CDC36000
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 19:10:08 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuynC-0004EL-Rq; Wed, 19 Mar 2025 15:09:30 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuynA-0004Df-VI
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:09:29 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1tuyn9-0006Xn-5e
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 15:09:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742411364;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=hT0nJlaOCrbOPwOEE//XgmVIDV2qVrfgUiIsc2e2eCk=;
 b=Egovyqq7rRw1WMdcckb97JEz9XrCXrm9qileBfr6Udldt7uEUOaJNKOQA+YajDyl8rO3aJ
 OPm0duE4EFNwli7m9Mn3FKU/sbMGM9R4TsOjwGu/U9Ko9FylDXDdWgJSh9QV8EmgUwFYUi
 C8JrY6gyJbON17FnZtuNPYKBGhcQXVM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-652-OT-48SD6Pzizfm3IzlnXhg-1; Wed,
 19 Mar 2025 15:09:19 -0400
X-MC-Unique: OT-48SD6Pzizfm3IzlnXhg-1
X-Mimecast-MFC-AGG-ID: OT-48SD6Pzizfm3IzlnXhg_1742411358
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 4661E1800EC5; Wed, 19 Mar 2025 19:09:18 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.22.74.4])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 87C1918001D4; Wed, 19 Mar 2025 19:09:17 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id CEAA221E66C5; Wed, 19 Mar 2025 20:09:13 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: qemu-devel@nongnu.org,  Aleksandar Rikalo <arikalo@gmail.com>
Subject: Re: [PATCH 0/3] Cleanups around returns
In-Reply-To: <CAFEAcA9zQ-T2bbJcxFM23TFkNb8-fROx0_bkCWHjZ50_ybS79w@mail.gmail.com>
 (Peter Maydell's message of "Wed, 19 Mar 2025 16:21:54 +0000")
References: <20250319152126.3472290-1-armbru@redhat.com>
 <CAFEAcA9zQ-T2bbJcxFM23TFkNb8-fROx0_bkCWHjZ50_ybS79w@mail.gmail.com>
Date: Wed, 19 Mar 2025 20:09:13 +0100
Message-ID: <87tt7okfc6.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
Received-SPF: pass client-ip=170.10.133.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.337,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
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

Peter Maydell <peter.maydell@linaro.org> writes:

> On Wed, 19 Mar 2025 at 15:23, Markus Armbruster <armbru@redhat.com> wrote:
>>
>> Markus Armbruster (3):
>>   cleanup: Re-run return_directly.cocci
>>   cleanup: Drop pointless return at end of function
>>   cleanup: Drop pointless label at end of function
>>
>
>>  .../user/ase/msa/bit-count/test_msa_nloc_b.c  |  9 +++----
>>  .../user/ase/msa/bit-count/test_msa_nloc_d.c  |  9 +++----
>>  .../user/ase/msa/bit-count/test_msa_nloc_h.c  |  9 +++----
>
> I notice that most of the files modified here are these
> ones in the MIPS TCG test suite.
>
> Are the files under tests/tcg/mips/user/{ase,isa} ours
> to make style cleanups on, or are they imports of
> third-party code which we should leave as is in the
> expectation that we might be doing further imports
> in future and don't want to drift away from whatever
> the "upstream" for those files is ?

I don't know!  Neither the files nor initial commit messages provide
clues.


