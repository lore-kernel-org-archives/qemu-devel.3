Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88C27CD6E7C
	for <qemu-devel@archiver.kernel.org>; Fri,  5 Jun 2026 16:47:53 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wVXhR-0001ZG-5n; Fri, 05 Jun 2026 12:47:13 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wVXhO-0001YX-Rx
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:47:11 -0400
Received: from zero.eik.bme.hu ([2001:738:2001:2001::2001])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <balaton@eik.bme.hu>)
 id 1wVXhL-00028d-1B
 for qemu-devel@nongnu.org; Fri, 05 Jun 2026 12:47:08 -0400
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 21EB859694F;
 Fri, 05 Jun 2026 18:47:02 +0200 (CEST)
X-Virus-Scanned: amavis at eik.bme.hu
Received: from zero.eik.bme.hu ([127.0.0.1])
 by localhost (zero.eik.bme.hu [127.0.0.1]) (amavis, port 10028) with ESMTP
 id G9oC4CjDTOgt; Fri,  5 Jun 2026 18:47:00 +0200 (CEST)
Received: by zero.eik.bme.hu (Postfix, from userid 432)
 id 102F4596945; Fri, 05 Jun 2026 18:47:00 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
 by zero.eik.bme.hu (Postfix) with ESMTP id 0E3935968DE;
 Fri, 05 Jun 2026 18:47:00 +0200 (CEST)
Date: Fri, 5 Jun 2026 18:47:00 +0200 (CEST)
From: BALATON Zoltan <balaton@eik.bme.hu>
To: ~rongyichang <rongyichang@xiaomi.com>
cc: qemu-devel@nongnu.org, marcandre.lureau@redhat.com, armbru@redhat.com, 
 eblake@redhat.com
Subject: Re: [PATCH qemu] ui/sdl2: add grab-on-tablet option for absolute
 input devices
In-Reply-To: <178065435170.20548.15372728064868431795-0@git.sr.ht>
Message-ID: <f54a2b09-f144-abc3-6163-563908c336a3@eik.bme.hu>
References: <178065435170.20548.15372728064868431795-0@git.sr.ht>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII; format=flowed
Received-SPF: pass client-ip=2001:738:2001:2001::2001;
 envelope-from=balaton@eik.bme.hu; helo=zero.eik.bme.hu
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On Fri, 5 Jun 2026, ~rongyichang wrote:
> From: rongyichang <rongyichang@xiaomi.com>
>
> When using absolute coordinate input devices (e.g. virtio-tablet-device),
> the SDL display backend implements a "soft grab" where the mouse is
> automatically grabbed when it enters the window interior and ungrabbed
> when it hits the window edge. This edge-ungrab behavior causes problems
> in embedded emulation scenarios:
>
> 1. Mouse escapes the SDL window at edges
> 2. SDL does not deliver BUTTONUP events for the escaped mouse
> 3. The guest gets stuck in a pressed/touch-down state
> 4. First click back into the window is silently dropped
>
> This issue is confirmed as a known SDL limitation (SDL issue #5301).
>
> Add a new -display sdl,grab-on-tablet=on option that makes absolute
> coordinate devices use the same grab behavior as relative (mouse)
> devices: user must click to grab, Ctrl+Alt+G to release, and no
> automatic grab on window enter or edge-based ungrab/regrab.

Maybe it's better to name the option click-to-grab or grab-on-click or 
something similar as that's what it changes and not specific to tablets.

Regards.
BALATON Zoltan

