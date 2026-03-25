Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1802E106B50C
	for <qemu-devel@archiver.kernel.org>; Wed, 25 Mar 2026 12:21:14 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1w5NE1-0005yM-Fq; Wed, 25 Mar 2026 08:20:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5NDy-0005xv-OM; Wed, 25 Mar 2026 08:20:38 -0400
Received: from www3579.sakura.ne.jp ([49.212.243.89])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <odaki@rsg.ci.i.u-tokyo.ac.jp>)
 id 1w5NDv-0004HK-Pm; Wed, 25 Mar 2026 08:20:38 -0400
Received: from [133.11.54.205] (h205.csg.ci.i.u-tokyo.ac.jp [133.11.54.205])
 (authenticated bits=0)
 by www3579.sakura.ne.jp (8.16.1/8.16.1) with ESMTPSA id 62PCK9Lr021409
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
 Wed, 25 Mar 2026 21:20:09 +0900 (JST)
 (envelope-from odaki@rsg.ci.i.u-tokyo.ac.jp)
DKIM-Signature: a=rsa-sha256; bh=7qEUEgh9Pt11woJfLwJx0CiIokoPoqp0TDwXaflTVWM=; 
 c=relaxed/relaxed; d=rsg.ci.i.u-tokyo.ac.jp;
 h=From:Message-ID:To:Subject:Date;
 s=rs20250326; t=1774441209; v=1;
 b=L3SN9HuAv1pPZoe2hIxcSQqzjGkTbamYSBqY2Hr/q4ro+vEcSl9qYMq2Inj7uSi2
 iJgIMFeHYVze7yS/187qmWJFscZhGV57n9CnWvhZehCPZf+CAWEzW2s/nBJMbb0/
 fAWvJeym2o+qgxADBhhenZSyYf7COajkcKSn7fu1XugiZBIl49tKjPxkyLHAr3xI
 fQwjgogEfN3aDMKtHiMIsZRJ0AoRhgsFCITxK4OGPIlDqNNdlsw4lxcL55YppCdQ
 dLUQehGdeoIU7aseqvnL7KN5yH7KFCR7gAtD4S3vpp/klcjDWaTTtfIqxIR1kXJU
 C46bf1J1TebKQnh73ayX0w==
Message-ID: <a273d3e3-4fcf-4969-b43c-4dadb94ea2c9@rsg.ci.i.u-tokyo.ac.jp>
Date: Wed, 25 Mar 2026 21:20:09 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH v7 7/7] hvf: do not merge: enable private ISA
To: Mohamed Mediouni <mohamed@unpredictable.fr>
Cc: qemu-devel@nongnu.org, qemu-arm@nongnu.org,
 Peter Maydell <peter.maydell@linaro.org>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Paolo Bonzini <pbonzini@redhat.com>, Phil Dennis-Jordan
 <phil@philjordan.eu>, Peter Xu <peterx@redhat.com>,
 Mads Ynddal <mads@ynddal.dk>, Roman Bolshakov <rbolshakov@ddn.com>,
 Alexander Graf <agraf@csgraf.de>
References: <20260324204855.29759-1-mohamed@unpredictable.fr>
 <20260324204855.29759-8-mohamed@unpredictable.fr>
 <9cf3d5c9-32eb-4944-8fbf-4775e1cccecb@rsg.ci.i.u-tokyo.ac.jp>
 <78785F86-CA85-4187-93A6-1D9852263964@unpredictable.fr>
Content-Language: en-US
From: Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp>
In-Reply-To: <78785F86-CA85-4187-93A6-1D9852263964@unpredictable.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
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

On 2026/03/25 20:21, Mohamed Mediouni wrote:
> 
>> On 25. Mar 2026, at 12:07, Akihiko Odaki <odaki@rsg.ci.i.u-tokyo.ac.jp> wrote:
>>
>> On 2026/03/25 5:48, Mohamed Mediouni wrote:
>>> Booting macOS Tahoe.
>>> There in the series to show that's all it takes, but not
>>> mergable as is. Testing this requires SIP to be disabled
>>> and AMFI to be bypassed to be able to launch the executable.
>>
>>
>> This is interesting. Do you have any idea what is the private ISA?
>>
>> Regards,
>> Akihiko Odaki
> 
> Hello,
> 
> For the macOS vmapple target:
> 
> Apple PAC is paravirtualised and not trappable by the VMM without
> patching the “hvc #0” to something else.
> 
> That’s the only private ISA bit being used there needed for boot.
> 
> The documentation for those HVCs:
> https://github.com/matteyeux/darwin-xnu/blob/master/doc/vmapple_pac.md
> 
> Apple briefly pushed that there, and open-source XNU has that code present.
> 
> When private ISA is disabled, instead of the VMM being able to process those
> HVCs, they return an error code and the guest dutifully goes into a infinite
> loop.
> 
> For the vresearch1 target used for PCC VRE and iOS:
> 
> Bunch of private ISA used there, including GXF. Private ISA level 3 isn’t
> enough to boot those, it wants private ISA level 4.

It’s fascinating to learn about these Apple-specifics. The insight 
regarding the GXF requirement for PCC VRE and iOS is also very 
intriguing. Thanks for sharing the information.

Regards,
Akihiko Odaki

