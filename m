Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 872AAC54798
	for <qemu-devel@archiver.kernel.org>; Tue,  5 Mar 2024 14:44:48 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1rhW1F-0006NR-B4; Tue, 05 Mar 2024 09:43:49 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhW1E-0006NI-Al
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:43:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <armbru@redhat.com>) id 1rhW1C-0000ip-LW
 for qemu-devel@nongnu.org; Tue, 05 Mar 2024 09:43:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1709649824;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CNRYa9peycsNpT1IuZWuqtF9ZCyMJ8PXBEPEb3LTRps=;
 b=S/4keS0RC1WUoPtNjX+3lVZQuDicAUCRuBPg4vulnHAFl7xQ1MUfZu/M3+yfzlc70Wya9v
 kp9xqAerdYgleSImop2DI1VBq3sEXCTFo0b5eGfMVbf9mfCU2skzYnpuDRJnaoBZgjuZqG
 BHz0RWJMW0Jaq+Ef80YETkQL7bUE0ao=
Received: from mimecast-mx02.redhat.com (mx-ext.redhat.com [66.187.233.73])
 by relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-623-xgmUZfifMxGDL5V-g_75mQ-1; Tue,
 05 Mar 2024 09:43:43 -0500
X-MC-Unique: xgmUZfifMxGDL5V-g_75mQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com
 [10.11.54.4])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 8DB701C54025;
 Tue,  5 Mar 2024 14:43:42 +0000 (UTC)
Received: from blackfin.pond.sub.org (unknown [10.39.192.3])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 478C4200B01D;
 Tue,  5 Mar 2024 14:43:42 +0000 (UTC)
Received: by blackfin.pond.sub.org (Postfix, from userid 1000)
 id 1C76821E6A24; Tue,  5 Mar 2024 15:43:41 +0100 (CET)
From: Markus Armbruster <armbru@redhat.com>
To: Peter Maydell <peter.maydell@linaro.org>
Cc: Maksim Davydov <davydov-max@yandex-team.ru>,  qemu-devel@nongnu.org,
 vsementsov@yandex-team.ru,  jsnow@redhat.com,  philmd@linaro.org,
 armbru@redhat.com,
 Peter Xu <peterx@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?utf-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>
Subject: Re: [PULL 0/4] machine development tool
In-Reply-To: <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
 (Peter Maydell's message of "Tue, 5 Mar 2024 13:49:55 +0000")
References: <20240304135145.154860-1-davydov-max@yandex-team.ru>
 <CAFEAcA9acSfGP6PcErqp1rTmSd3G+AwUUx_aF-5KJy4iS6BqaQ@mail.gmail.com>
Date: Tue, 05 Mar 2024 15:43:41 +0100
Message-ID: <874jdkn3he.fsf@pond.sub.org>
User-Agent: Gnus/5.13 (Gnus v5.13)
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.4
Received-SPF: pass client-ip=170.10.129.124; envelope-from=armbru@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -26
X-Spam_score: -2.7
X-Spam_bar: --
X-Spam_report: (-2.7 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.568,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=ham autolearn_force=no
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

> On Mon, 4 Mar 2024 at 13:52, Maksim Davydov <davydov-max@yandex-team.ru> wrote:
>>
>> The following changes since commit e1007b6bab5cf97705bf4f2aaec1f607787355b8:
>>
>>   Merge tag 'pull-request-2024-03-01' of https://gitlab.com/thuth/qemu into staging (2024-03-01 10:14:32 +0000)
>>
>> are available in the Git repository at:
>>
>>   https://gitlab.com/davydov-max/qemu.git tags/pull-compare-mt-2024-03-04
>>
>> for you to fetch changes up to 7693a2e8518811a907d73a85807ee71dac8fabcb:
>>
>>   scripts: add script to compare compatibility properties (2024-03-04 14:10:53 +0300)
>>
>> ----------------------------------------------------------------
>> Please note. This is the first pull request from me.
>> My public GPG key is available here
>> https://keys.openpgp.org/vks/v1/by-fingerprint/CDB5BEEF8837142579F5CDFE8E927E10F72F78D4
>>
>> ----------------------------------------------------------------
>> scripts: add a new script for machine development
>>
>> ----------------------------------------------------------------
>
> Hi; I would prefer this to go through some existing submaintainer
> tree if possible, please.

Migration?  QOM?  Not sure.  Cc'ing the maintainers anyway.


