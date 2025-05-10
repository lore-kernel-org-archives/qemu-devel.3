Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F8C9C3ABCB
	for <qemu-devel@archiver.kernel.org>; Sat, 10 May 2025 12:14:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uDj59-0007Eh-TZ; Sat, 10 May 2025 08:13:31 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uDj58-0007EU-S4; Sat, 10 May 2025 08:13:30 -0400
Received: from sender4-op-o12.zoho.com ([136.143.188.12])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1uDj56-0003qv-H0; Sat, 10 May 2025 08:13:30 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1746879175; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=CQqi0aQRkMyWKiBG9y86zueiHzyBoWZqTdb3ij3pG8We7Oz63UKphmty9iyppXAjOaR3Dr3u3sLcQ9A7dSj4oVSpcKNGwo2kE+1ZKku/6GUbPCV14trBRb3vBleTaRXQi+69VhHEUVhbopdgji6X5W8Ykq1qFlre+5Y5GLtMv8E=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1746879175;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=da87Gvfr92nTmRe9YFikUiBtrxbK9MwMgr9kg1RROaY=; 
 b=F2C1bYxeUEC1urcRyP1UPJz62kUBFOEP7IdQODVsJo7yLSDsoSALc6uKvH/uFVG0I4fJsL2OjMeDN4E4TeDh5H6CWIgKV/35Kh1kAZ8M9G/awMKXuj/5LdVHYStEdYRozFK3+zuGP5FUiUTKy6Ph0SeJZ8XEmCSZudLtBnVQ2g0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746879175; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=da87Gvfr92nTmRe9YFikUiBtrxbK9MwMgr9kg1RROaY=;
 b=NxwCYmm7eiB2fDVfMi7Ugvzij/zXWswkfpvC5dsuDY+f/6q4FMz302nNwLMRWE45
 HjIMfCzv2LI8oaqYJ2NHkJgcnhbGr01dwHAmPRyZevoYq2DylhXXyBIG84lrM/GGwFb
 86fSLBIPcOEpeV8WfR9FkPIlxRdqa96yTlsxVx+Y=
Received: by mx.zohomail.com with SMTPS id 1746879172685901.4554516787928;
 Sat, 10 May 2025 05:12:52 -0700 (PDT)
Message-ID: <d370ffec-f430-4377-80bc-323d5087834c@collabora.com>
Date: Sat, 10 May 2025 15:12:45 +0300
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 12/14] ui/gtk-gl-area: Remove extra draw call in refresh
To: Akihiko Odaki <akihiko.odaki@daynix.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>, qemu-devel@nongnu.org
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 David Hildenbrand <david@redhat.com>, Laurent Vivier <lvivier@redhat.com>,
 qemu-arm@nongnu.org, Mahmoud Mandour <ma.mandourr@gmail.com>,
 Markus Armbruster <armbru@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Peter Xu <peterx@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, John Snow <jsnow@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Thomas Huth <thuth@redhat.com>,
 Fabiano Rosas <farosas@suse.de>, Peter Maydell <peter.maydell@linaro.org>,
 Alexandre Iooss <erdnaxe@crans.org>, Dongwon Kim <dongwon.kim@intel.com>,
 Vivek Kasireddy <vivek.kasireddy@intel.com>
References: <20250506125715.232872-1-alex.bennee@linaro.org>
 <20250506125715.232872-13-alex.bennee@linaro.org>
 <d5a8cec1-f689-4d31-b6bb-b63eaa4ce2af@daynix.com>
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Content-Language: en-US
In-Reply-To: <d5a8cec1-f689-4d31-b6bb-b63eaa4ce2af@daynix.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
Received-SPF: pass client-ip=136.143.188.12;
 envelope-from=dmitry.osipenko@collabora.com; helo=sender4-op-o12.zoho.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 5/10/25 07:52, Akihiko Odaki wrote:
> On 2025/05/06 21:57, Alex Bennée wrote:
>> From: Dongwon Kim <dongwon.kim@intel.com>
>>
>> This partially reverts commit 77bf310084dad38b3a2badf01766c659056f1cf2
>> which causes some guest display corruption when gtk-gl-area
>> is used for GTK rendering (e.g. Wayland Compositor) possibly due to
>> simulataneous accesses on the guest frame buffer by host compositor
>> and the guest.
> 
> Simply reverting the part of the commit may re-introduce the problem the
> commit tried to solve, which will be a regression as the commit is
> already included in releases.
> 
> I guess the problem is that the gl_block callback of GraphicHwOps is not
> properly implemented and it is what should be fixed.

The reverted commit made QEMU GTK GUI unusable under Wayland. It was
fixing problem which requires very specific QEMU setup, while breaking
generic setups. The offending change should be reverted as it introduced
a bigger problem. A proper solution should be found, meanwhile QEMU GTK
under Wayland should be restored, IMO.

For the reference see [1]. First bug reports about a mirrored display
problem were made to me on IRC a year ago and the root of the problem
was identified only couple months ago.

[1]
https://lore.kernel.org/qemu-devel/5aedf1ad-d9b0-4edb-a050-f3d9bee9bccb@collabora.com/

As of today, the GTK problem isn't understood.

-- 
Best regards,
Dmitry

