Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EFF6CC02185
	for <qemu-devel@archiver.kernel.org>; Sat, 18 Jan 2025 21:32:04 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tZGPM-0006LA-9u; Sat, 18 Jan 2025 16:31:08 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1tZGPK-0006KR-C6; Sat, 18 Jan 2025 16:31:06 -0500
Received: from mailout06.t-online.de ([194.25.134.19])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <vr_qemu@t-online.de>)
 id 1tZGPF-0003Js-AS; Sat, 18 Jan 2025 16:31:06 -0500
Received: from fwd82.aul.t-online.de (fwd82.aul.t-online.de [10.223.144.108])
 by mailout06.t-online.de (Postfix) with SMTP id 6A36B7E7;
 Sat, 18 Jan 2025 22:30:06 +0100 (CET)
Received: from [192.168.211.200] ([79.208.16.102]) by fwd82.t-online.de
 with (TLSv1.3:TLS_AES_256_GCM_SHA384 encrypted)
 esmtp id 1tZGOK-4KVQqv0; Sat, 18 Jan 2025 22:30:05 +0100
Message-ID: <7a0e6469-fdfa-48e2-9951-595302467b4b@t-online.de>
Date: Sat, 18 Jan 2025 22:30:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vvfat: refresh writing long filename
To: Michael Tokarev <mjt@tls.msk.ru>, Kevin Wolf <kwolf@redhat.com>,
 Hanna Reitz <hreitz@redhat.com>
Cc: Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-devel@nongnu.org,
 qemu-block@nongnu.org, qemu-trivial@nongnu.org
References: <20250118182109.2695C19E94D@tsrv.corpit.ru>
 <fcd930c1-5071-47ce-a400-0a52ba673c20@t-online.de>
 <565c1712-0f20-4d24-b809-a4e18c827da7@tls.msk.ru>
Content-Language: en-US
From: =?UTF-8?Q?Volker_R=C3=BCmelin?= <vr_qemu@t-online.de>
In-Reply-To: <565c1712-0f20-4d24-b809-a4e18c827da7@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TOI-EXPURGATEID: 150726::1737235805-457F99EF-40CC8C6B/0/0 CLEAN NORMAL
X-TOI-MSGID: afab17d0-6fba-43a0-9e1e-d3f6dd0fe263
Received-SPF: pass client-ip=194.25.134.19; envelope-from=vr_qemu@t-online.de;
 helo=mailout06.t-online.de
X-Spam_score_int: -43
X-Spam_score: -4.4
X-Spam_bar: ----
X-Spam_report: (-4.4 / 5.0 requ) BAYES_00=-1.9, FREEMAIL_FROM=0.001,
 RCVD_IN_DNSWL_LOW=-0.7, RCVD_IN_MSPIKE_H2=-1.787,
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

Am 18.01.25 um 21:55 schrieb Michael Tokarev:
> 18.01.2025 23:32, Volker Rümelin wrote:
>
>> The rules are:
>> If the file name length in characters is a multiple of 13 you are done.
>> Otherwise the remaining unused LFN direntry name array elements have to
>> be filled with one 0x0000 (a 16 bit 0) and the rest with 0xffff.
>
> BTW, are we really okay with a single dirent if the name length is
> exactly
> 13 utf16 chars?  Don't it need a null terminator?
>

Yes, that's okay. A null terminator isn't allowed in this case. See page
28 at https://msdn.microsoft.com/en-us/windows/hardware/gg463080.aspx

With best regards,
Volker

