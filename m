Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D32CFE7DF13
	for <qemu-devel@archiver.kernel.org>; Mon,  2 Feb 2026 17:26:27 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vmxgB-0002E9-QJ; Mon, 02 Feb 2026 12:25:39 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vmxgA-0002Dh-0x
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:25:38 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <cohuck@redhat.com>) id 1vmxg8-00039g-KH
 for qemu-devel@nongnu.org; Mon, 02 Feb 2026 12:25:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1770053135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tj0a5l8PHONvhg9c4bGkq+FVR2kg83UNz+hZ9hhftLw=;
 b=Uu8x+zdJm/NAuOmrFe9Kcysqlq+DMzhdDmvzooY4SH0ZleYBfVYmnkKKOjV9dxXtVnZXKU
 Q7w6TWtmcrzOBwylvqFTMLQTEv1ZjqA/MpLd0kDblxU+J+Kzz36lCl2bkLHzsKGjh7KESC
 6KJjT/Krw4+sWbn0GuLQiky2ibast6U=
Received: from mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-641-Op5xz384MSCT9Dd0NjyYFw-1; Mon,
 02 Feb 2026 12:25:17 -0500
X-MC-Unique: Op5xz384MSCT9Dd0NjyYFw-1
X-Mimecast-MFC-AGG-ID: Op5xz384MSCT9Dd0NjyYFw_1770053116
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com
 (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by mx-prod-mc-05.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 13A6619560A2; Mon,  2 Feb 2026 17:25:16 +0000 (UTC)
Received: from localhost (dhcp-192-192.str.redhat.com [10.33.192.192])
 by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS
 id 3D4E51800577; Mon,  2 Feb 2026 17:25:15 +0000 (UTC)
From: Cornelia Huck <cohuck@redhat.com>
To: Mark Cave-Ayland <mark.caveayland@nutanix.com>, Peter Maydell
 <peter.maydell@linaro.org>, Richard Henderson
 <richard.henderson@linaro.org>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org
Subject: Re: [PULL 00/21] Plugins patches for 2026-01-29
In-Reply-To: <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
Organization: "Red Hat GmbH, Sitz: Werner-von-Siemens-Ring 12, D-85630
 Grasbrunn, Handelsregister: Amtsgericht =?utf-8?Q?M=C3=BCnchen=2C?= HRB
 153243,
 =?utf-8?Q?Gesch=C3=A4ftsf=C3=BChrer=3A?= Ryan Barnhart, Charles Cachera,
 Avril Crosse O'Flaherty"
References: <20260129173811.138036-1-pierrick.bouvier@linaro.org>
 <2d69de6e-da9f-4f90-b805-9553bb72c78d@linaro.org>
 <7ac8fe1f-8098-4417-a97b-1a82c0fd23ca@linaro.org>
 <CAFEAcA_zghZeA0PzivCY9vCcFk6rVLwvP3in35rA=bF8yrdeyQ@mail.gmail.com>
 <878qdbtam7.fsf@redhat.com>
 <23be2c83-01ea-495d-b14e-496bd3e0a687@nutanix.com>
User-Agent: Notmuch/0.39 (https://notmuchmail.org)
Date: Mon, 02 Feb 2026 18:25:13 +0100
Message-ID: <875x8ft5vq.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
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

On Mon, Feb 02 2026, Mark Cave-Ayland <mark.caveayland@nutanix.com> wrote:

> On 02/02/2026 15:42, Cornelia Huck wrote:
>
>> On Mon, Feb 02 2026, Peter Maydell <peter.maydell@linaro.org> wrote:
>> 
>>> On Mon, 2 Feb 2026 at 04:04, Richard Henderson
>>> <richard.henderson@linaro.org> wrote:
>>>>
>>>> On 1/30/26 04:41, Pierrick Bouvier wrote:
>>>>> On 1/29/26 9:37 AM, Pierrick Bouvier wrote:
>>>>>>         contrib/plugins: add empty cpp plugin
>>>
>>> Hi; this fails to build for me on Linux (Ubuntu 24.04) with clang:
>>>
>>> In file included from ../../contrib/plugins/cpp.cpp:33:
>>> /usr/bin/../lib/gcc/x86_64-linux-gnu/14/../../../../include/c++/14/coroutine:38:3:
>>> error: "the <coroutine> header requires -fcoroutines"
>>>     38 | # error "the <coroutine> header requires -fcoroutines"
>>>        |   ^
>>> 1 error generated.
>> 
>> Fails for me as well on Fedora 42 (x86_64) with gcc:
>> 
>> In file included from ../qemu/contrib/plugins/cpp.cpp:33:
>> /usr/include/c++/15/coroutine:43:3: error: #error "the <coroutine> header requires -fcoroutines"
>>     43 | # error "the <coroutine> header requires -fcoroutines"
>>        |   ^~~~~
>> 
>> (It works for me on an aarch64 RHEL 9 system.)
>
> Is this with a clean build? I had exactly the same error message 
> earlier, but I was able to fix it by destroying my build/ directory, 
> then re-running configure followed again by make.

Rebuilding with a fresh build dir looks promising so far ('make clean'
is not enough.) I'm wondering if we're missing some rebuild trigger (and
I'm also wondering why I didn't see this problem on my RHEL 9 aarch64
box.)


