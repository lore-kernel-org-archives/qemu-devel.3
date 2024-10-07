Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ADBFACF8870
	for <qemu-devel@archiver.kernel.org>; Mon,  7 Oct 2024 20:59:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1sxupO-00062O-MD; Mon, 07 Oct 2024 16:59:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxupN-00061i-Ay
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:59:37 -0400
Received: from sender4-pp-f112.zoho.com ([136.143.188.112])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <dmitry.osipenko@collabora.com>)
 id 1sxupL-0006kH-Qk
 for qemu-devel@nongnu.org; Mon, 07 Oct 2024 16:59:37 -0400
ARC-Seal: i=1; a=rsa-sha256; t=1728334758; cv=none; 
 d=zohomail.com; s=zohoarc; 
 b=mP3V8NrMJ7TEvPYJb7fyMdl/n0nJM7Yl0j02E89I+VsuVOpDgBCqnyTA6vNZ1ZLjSnhMbGpjFibd0+CxhO6AWSexUi0KI6kbeTyQ5IlECvuvtwH9F9yO6Fz8jS1Q4o5HG0+IqjeiJSfRfBwv1g1Qw13O5zz4XWkWAaARRrO/N6Y=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com;
 s=zohoarc; t=1728334758;
 h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To;
 bh=ohzwX1XdmzKRe7EXs6vFQ4IDrFV63PF96qPVg3gSWyg=; 
 b=VrdQkQpQNXnGKBqa9BeqGEby/R6akm7puC/YTb8gbCEc0CXUwXaor4UB+r/vj+8fZmEZ8MFCFmcNQkPyYGbJ85VCsf822fRbA47KWTNwz73R2yK8MoNGuuI0uQHf8agDDl5diqaWaJhkD9Kfy83UUBIV/6hCOtgDtD1bm/ems7c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
 dkim=pass  header.i=collabora.com;
 spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
 dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1728334758; 
 s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com; 
 h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
 bh=ohzwX1XdmzKRe7EXs6vFQ4IDrFV63PF96qPVg3gSWyg=;
 b=Sml6/f5xuun1lI7DeI98C12UiSzvfftiHVTDaR+X3Oxz3P6u2PD8oTmI6acovnrK
 o8vvBqQZI+9t18mLSSJzfqI7xEQCCFsbwLzTea9rlq/ydEWXnewwAKbQ8O/4FOAYpWF
 d74IofdAy90C90utRG78Ve2t/D2ZWO8orfT8a7YU=
Received: by mx.zohomail.com with SMTPS id 172833475645282.8920181119064;
 Mon, 7 Oct 2024 13:59:16 -0700 (PDT)
Message-ID: <da1e425d-cc3a-4121-ba89-baa6be706bca@collabora.com>
Date: Mon, 7 Oct 2024 23:59:12 +0300
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
 <55042480-6a12-41ca-a5dc-8f6dd5ff8c62@collabora.com>
 <94f02eeb-0c20-43fc-b5c5-7a3172630d8f@tls.msk.ru>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <94f02eeb-0c20-43fc-b5c5-7a3172630d8f@tls.msk.ru>
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

On 10/7/24 23:48, Michael Tokarev wrote:
> 07.10.2024 23:19, Dmitry Osipenko wrote:
>>> Is it a -stable material?  Myself I haven't seen this prob so far, so
>>> it might be not worth the effort.  Also, any idea when the prob has been
>>> introduced (or since when it has become real)?
>>
>> The problem is reproducible with a stable Qemu.  With SDL display it may
> 
> Which stable qemu do you mean? We've 4 currently active/supported stable
> series - 7.2.x, 8.2.x, 9.0.x, 9.1.x :)

I check only the v8, v7 shouldn't differ from v8 in regards to the
display code, AFAICT.

>> require many retries to repro, but with GTK display + vblank_mode=0 it
>> happens all the time.  Don't know when exactly it was introduced, but
>> will become much easier to hit it with the upcoming changes to Qemu.
> 
> what is vblank_mode=0 anyway, how to turn it on/off ?
> 
> Do you mean setting this variable in environment when launching qemu?

Yes, you'll need to set this env var

-- 
Best regards,
Dmitry


