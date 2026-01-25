Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35682E63C90
	for <qemu-devel@archiver.kernel.org>; Sun, 25 Jan 2026 13:01:32 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vjzeS-0007OR-JE; Sun, 25 Jan 2026 07:55:37 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjzeO-0007MI-0n; Sun, 25 Jan 2026 07:55:32 -0500
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1vjzeK-0003Kc-UE; Sun, 25 Jan 2026 07:55:31 -0500
Received: from [192.168.10.110] (p865013-ipoe.ipoe.ocn.ne.jp [153.242.222.12])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 60PCsufE062082
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Sun, 25 Jan 2026 21:54:57 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=+j6ZU1j6RkEgBQgOwvB1Zr5h1NVXGrfPgz+v/VBoqpc=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=Message-ID:Date:Subject:To:From;
 s=rs20250326; t=1769345697; v=1;
 b=bQecPX4b/6fz20iPx3NaFDMlvqdwkPm9CJ+DEqfFLvABYkKtiCSv4FKIgH9W4dPu
 ohjGv4X0e31YKQKHQoMjuztAD7a84/M5UKZ2dxTeZyC0/qzWhn4sveyipnO3rlL3
 fcT4qA+QtdYQYJ8hylrRjtY7eWELGkbWsGeFBESFIZZZRmkvrNSwAl++YGI7FtA5
 8dsFbkFvpEXuF844ipbcgEcbwsBFgxoT4qoGCyVm+LP7OFN8c3zrZXR1U6RhNoXi
 jSysbHPGdopfzRyDb8kDwIvyAlEYLzQniuBfhEcHkBv1XwUbqLHEZxp0dzfpQFY0
 PzKWPxYw861tbwNJ1OQccA==
Message-ID: <25bc186a-950f-451c-9420-c7a60d1dcfa9@rsg.ci.i.u-tokyo.ac.jp>
Date: Sun, 25 Jan 2026 21:54:56 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 0/5] Fix use-after-free and make format overflow more
 difficult
To: BALATON Zoltan <balaton@eik.bme.hu>
Cc: qemu-devel@nongnu.org, Viktor Prutyanov <viktor.prutyanov@phystech.edu>,
 Alex Williamson <alex@shazbot.org>, =?UTF-8?Q?C=C3=A9dric_Le_Goater?=
 <clg@redhat.com>, Markus Armbruster <armbru@redhat.com>,
 Michael Roth <michael.roth@amd.com>, Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Keith Busch <kbusch@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 Jesper Devantier <foss@defmacro.it>, qemu-block@nongnu.org
References: <20260125-nvme-v1-0-0658c31fade9@rsg.ci.i.u-tokyo.ac.jp>
 <7e064157-1e88-dbfc-f7f6-97591222fb6c@eik.bme.hu>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <7e064157-1e88-dbfc-f7f6-97591222fb6c@eik.bme.hu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2026/01/25 20:55, BALATON Zoltan wrote:
> On Sun, 25 Jan 2026, Akihiko Odaki wrote:
>> nvme-ns has a use-after-free of a formatted string, so fix it by
>> embedding a fixed-length buffer to the object. Embedding a buffer lets
>> me avoid a chore to add a function to call g_free().
> 
> Isn't that where g_autofree would help?

Unfortunately no. It helps only if the lifetime is bound to a scope. In 
this case, the lifetime is bound to an object.

> 
>> But I don't want to worry about a buffer overflow, so let the compiler
>> check that the buffer won't overflow; C is so restrictive that it cannot
>> enforce the existence of g_free(). Compilers can check the length of
>> formatted string on the other hand.
>>
>> Then GCC started complaining about buffer overflow, so let's treat them.
>> Fortunately, the potential buffer overflows it detected are not
>> user-facing or very subtle. Treating them by growing buffers can improve
>> robustness with practically no cost.
> 
> This is useful but maybe there's a better fix for some of these than 
> arbitrarily enlarging buffers but I don't care enough about these to judge.

They can be fixed with g_autofree. I think either enlarging buffers or 
using g_autofree is fine; differences between them are insignificant.

Regards,
Akihiko Odaki

