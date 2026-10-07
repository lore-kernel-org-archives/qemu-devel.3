Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 384E3CA5FFC
	for <qemu-devel@archiver.kernel.org>; Wed,  7 Oct 2026 14:02:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1xESDU-0002HS-Q7; Wed, 07 Oct 2026 10:02:01 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xES6I-0007zh-Ew; Wed, 07 Oct 2026 09:54:40 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1xES6C-0004hn-5V; Wed, 07 Oct 2026 09:54:28 -0400
Received: from [133.11.54.183] (h183.csg.ci.i.u-tokyo.ac.jp [133.11.54.183])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 697Ds6eS020812
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 7 Oct 2026 22:54:06 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=1IBd/9/SDAHgAEWr/Kfgv/TnENGfXJ42GiaPASCuZ3c=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1791381246; v=1;
 b=JdP74PAdRbuu+3GKl225yqnZWHT+4mz8ajqXj+SSYVI/Xk8s60WiV2Ak2YvKj8Qd
 0NMNvUYDQxKTcyzBC9Dt5KZh03LkCgLGFe8KiqSVcAWC0D/e/VxzSZTeQySc8vg0
 Vn8GpsjgO1vH5om7IqOxFD+IqppXqBXTZJ5+QvABd/lbf/WG4Ei+evoSNNRvUHQu
 zl+5tHGJ8dH7OQmTkrH8KufcFQ4gCHMY6STRrpcEfofaIpSGMicvVdj0ZOc9jejd
 /o48NCFAIw27E3l5EGqdkcEZYf1ejQzuUXHdOtbejCeiWQr5wWga5MfnZOS0ZsLe
 lWLRznfjX5sW0NesUVPpuw==
Message-ID: <5e701c06-b6b1-4e6a-ab41-002c399a7436@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 7 Oct 2026 22:54:05 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] hw/display/apple: Fix obsolete PGDevice function
To: Mohamed Mediouni <mohamed@unpredictable.fr>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@oss.qualcomm.com>,
 Yundi Xu <yundi.eric.xu@gmail.com>, qemu-devel@nongnu.org
Cc: Phil Dennis-Jordan <phil@philjordan.eu>, qemu-trivial@nongnu.org,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Dennis Mueller <dmueller@qualcomm.com>, Joelle van Dyne <j@getutm.app>
References: <1e5b1f1f-1d7f-43cf-8883-0e0ab2ec88ce@gmail.com>
 <b0bcfbaf-e49a-4005-b40d-4e64678031d5@oss.qualcomm.com>
 <b98c3cbc-6feb-4dda-8a76-88feeded65b0@oss.qualcomm.com>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <b98c3cbc-6feb-4dda-8a76-88feeded65b0@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=49.212.243.89;
 envelope-from=odaki@rsg.ci.i.u-tokyo.ac.jp; helo=www3579.sakura.ne.jp
X-Spam_score_int: -3
X-Spam_score: -0.4
X-Spam_bar: /
X-Spam_report: (-0.4 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 URIBL_SBL=1.623 autolearn=no autolearn_force=no
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

On 2026/10/07 18:40, Philippe Mathieu-Daudé wrote:
> On 2026-10-07 9:51, Philippe Mathieu-DaudÃ© wrote:
>> Hi,
>>
>> Cc'ing Akihiko and Marc-André.
>>
>> On 5/10/26 22:59, Yundi Xu wrote:
>>> PGNewDeviceWithDescriptor is obsolete. Replace with
>>> PGCreateDeviceWIthDescriptor.
>>
>> Joelle did a similar fix, can you compare?
>> https://github.com/helixml/qemu-utm/commit/ 
>> b795d6de88fc52cb6ff061e0e034be51d8e9c474
> 
> The mailing list seemed down and I started to receive new
> ones, in particular Peter pointing to another fix:
> https://patchew.org/QEMU/20260916100021.73825-1- 
> mohamed@unpredictable.fr/20260916100021.73825-6-mohamed@unpredictable.fr/
> 
> So please disregard my comments, sorry for the noise.

Adding Mohamed Mediouni to To.

There is one thing I noticed: we don't need the compatibility check at all.

docs/about/build-platforms.rst says:
 > Support for the previous major version will be dropped 2 years after
 > the new major version is released or when the vendor itself drops
 > support, whichever comes first.

macOS 15 is the oldest supported major version since it is released 
September 2024, which is over 2 years ago.

It also says:
 > Within each major release, only the most recent minor release is
 > considered.

macOS 15.8.1 is the oldest supported version since it is the most recent 
minor release of macOS 15. Compatibility checks for older versions are 
unnecessary.

Regards,
Akihiko Odaki

