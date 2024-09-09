Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6D7CE7AB0
	for <qemu-devel@archiver.kernel.org>; Mon,  9 Sep 2024 06:13:18 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snXdX-0007HR-8S; Mon, 09 Sep 2024 02:12:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1snXdV-0007GY-Pu
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:12:29 -0400
Received: from mailout05.t-online.de ([194.25.134.82])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1snXdU-00030O-4E
 for qemu-devel@nongnu.org; Mon, 09 Sep 2024 02:12:29 -0400
Received: from fwd78.aul.t-online.de (fwd78.aul.t-online.de [10.223.144.104])
 by mailout05.t-online.de (Postfix) with SMTP id 89CE315FA4;
 Mon,  9 Sep 2024 08:12:24 +0200 (CEST)
Received: from [192.168.211.200] ([93.236.144.183]) by fwd78.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1snXdQ-0EA1A10; Mon, 9 Sep 2024 08:12:24 +0200
Message-ID: <ae9b2c56-dab2-4b8f-bb5e-2087e9ccaa92@t-online.de>
Date: Mon, 9 Sep 2024 08:12:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Stefan Weil <sw@weilnetz.de>
Cc: Howard Spoelstra <hsp.cat7@gmail.com>,
 Bernhard Beschow <shentey@gmail.com>, qemu-devel@nongnu.org
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
Subject: SDL2 keyboard fixes on Windows
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1725862344-1B7FC56E-B14DFFA7/0/0 CLEAN NORMAL
X-TOI-MSGID: 96dcb756-5bcb-4cda-8de7-53cd525dea8d
Received-SPF: pass client-ip=194.25.134.82; envelope-from=vr_qemu@t-online.de;
 helo=mailout05.t-online.de
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

The Windows keys do not work properly with the SDL backend on Windows.
Patch 1/3 improves the situation. However, it's impossible to solve the
problem completely, as there is no way to grab the Windows keys. The
Windows keys are reserved for the operating system. In addition to
Ctrl-Alt-Del, there are other key combinations such as Win-Space or
Win-L where it's not possible to prevent the operating system from
executing the corresponding functions.

The other two patches prevent stuck modifier keys and unexpected text
input on Windows.

Volker Rümelin (3):
  ui/sdl2: reenable the SDL2 Windows keyboard hook procedure
  ui/sdl2: release all modifiers
  ui/sdl2: ignore GUI keys in SDL_TEXTINPUT handler

 include/ui/sdl2.h   |  2 ++
 ui/sdl2-input.c     |  5 ++++
 ui/sdl2.c           | 71 ++++++++++++++++++++++++++++-----------------
 ui/win32-kbd-hook.c |  3 ++
 4 files changed, 55 insertions(+), 26 deletions(-)

-- 
2.35.3


