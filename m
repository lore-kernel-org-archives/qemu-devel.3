Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2126AC35FE0
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:20:41 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxuDH-0002Z8-Ol; Mon, 07 Oct 2024 16:20:15 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxuDF-0002Yj-LR
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:20:13 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxuDC-0002fw-0O
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:20:13 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728332390; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=O/TtqnhCOQmYQTWT6LNd33se4OWD/kT83pxEnW3zR+XNeFohe/WxL0OPxLtjyrrPQAdTD46TZbnxKW0a/zQ3TvkGHLgE2UsNdcdw9wPCCUhW55eAoWNxu4i23Zg2vJXt2aEJfETcrnodHX52YVfScbufUGcTPYCAuR/tqF6PEf8=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728332390;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=imrnYD1pp26rf1n3HLOTWJV8xX/kWyqNZSLq/kxzfLY=; 
 b=NIOa9V4uEZ5FKVOTY1kN7jXQwumXNRXZ8JFGB+1Xxsrlcp5rYNIc9VQ8ZLC12SNQNeee2VBd6XZsvMKff/RDEfpwM7f9jKphhvHiQl8ZLQbyuYOF6I17ivfhSGwOrphxL+PSbcqVEIlKk3yLWqGuK71eQgKOxHQJlN+NXw+IFNs=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728332390; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=imrnYD1pp26rf1n3HLOTWJV8xX/kWyqNZSLq/kxzfLY=;
 b=ckhdnJvOCpJsDih2ZboK3XHmH9gQIMPZzLy46+bUa79J58xJV5Ag0T6uHJLBDFmN
 fabahQflc35C6ruArP4gCd1bAAsrfFbBXags7e72IbMxh3vBada1GEp93pOJzgnq3SW
 yLAA/5Xu1cLmlwQSIicLGZ1vkyUE6BKts0wZ5isc=
Received: by mx.zohomail.com with SMTPS id 172833238805299.32471808713547;
 Mon, 7 Oct 2024 13:19:48 -0700 (PDT)
Message-ID: <55042480-6a12-41ca-a5dc-8f6dd5ff8c62@collabora.com>
Date: Mon, 7 Oct 2024 23:19:43 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 0/2] GTK/SDL fixes for a black screen displayed by
 virtio-gpu
To: Michael Tokarev <mjt@tls.msk.ru>, Akihiko Odaki
 <akihiko.odaki@daynix.com>, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Gerd Hoffmann <kraxel@redhat.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>
Cc: Gert Wollny <gert.wollny@collabora.com>, qemu-devel@nongnu.org,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
References: <20241006234353.3201037-1-dmitry.osipenko@collabora.com>
 <94066700-2a07-4d5f-bf0a-be7c1ce7bc62@tls.msk.ru>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <94066700-2a07-4d5f-bf0a-be7c1ce7bc62@tls.msk.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.112;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-pp-f112.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 10/7/24 22:26, Michael Tokarev wrote:
> 07.10.2024 02:43, Dmitry Osipenko wrote:
>> Hi,
>>
>> This patchset fixes black screen displayed by Qemu using virtio-gpu.
>> There is a race condition bug with a timer that disables display output
>> after it has been enabled by virtio-gpu. The problem is reproducible
>> by running Qemu with a disabled GL vsync. Note vsync is disabled for
>> SDL display by default.
>>
>> Dmitry Osipenko (2):
>>    ui/sdl2: Don't disable scanout when display is refreshed
>>    ui/gtk: Don't disable scanout when display is refreshed
> 
> Is it a -stable material?  Myself I haven't seen this prob so far, so
> it might be not worth the effort.  Also, any idea when the prob has been
> introduced (or since when it has become real)?

The problem is reproducible with a stable Qemu.  With SDL display it may
require many retries to repro, but with GTK display + vblank_mode=0 it
happens all the time.  Don't know when exactly it was introduced, but
will become much easier to hit it with the upcoming changes to Qemu.
Judging by the git blame, problem always existed, perhaps nobody payed
attention to it in the past.  Up to maintainers to decide whether it's
worth having these patches in stable, to me it's not worthwhile because
normally nobody would run Qemu with vblank_mode=0.  And you won't notice
the problem if you're running desktop session in the guest because it
will re-enable scanout on startup.

-- 
Best regards,
Dmitry


