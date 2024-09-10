Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 559C7ECE582
	for <qemu-devel@archiver.kernel.org>; Tue, 10 Sep 2024 09:33:49 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1snxFK-00044S-23; Tue, 10 Sep 2024 05:33:14 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1snxFG-00042A-Gh
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:33:11 -0400
Received: from mail-pg1-x536.google.com ([2607:f8b0:4864:20::536])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1snxFE-0006sq-B4
 for qemu-devel@nongnu.org; Tue, 10 Sep 2024 05:33:10 -0400
Received: by mail-pg1-x536.google.com with SMTP id
 41be03b00d2f7-7dafd9df795so437466a12.1
 for <qemu-devel@nongnu.org>; Tue, 10 Sep 2024 02:33:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1725960786; x=1726565586;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=2HSmuzeo7rM9e6xfSVs6r/wcZxccLMH6wYFGEW+e9Cs=;
 b=qLnEVUy4tZj8v367M3g6T6Q3SfycyUVD+Qu9t4QRkB0Z/lhg6P4qvc3ZsHH7lO7Jq3
 XMxwdzgy/cD0bvc/7SB9yfgzDhLoOFVcypFUN6D28Cl4jVN6hm5OusrgSlf/mWG5fpsR
 opMKeBLQcMjimN52mczwQDSc/ZpIumL7HwDoit8ag0A7YrPL8UXMZaCeV2w3tvqpbXUx
 vtsCOZUAb7/cIZechHjJngxONHB3utSWHJIApogVT8o351A/5Eb23zl5vdfUnomIsJKj
 YTsHyMTsztavGW0GJegz32ocYxdFAz2CMw1PSEzvdMwkJGVYp5ALOOL1I1h4MXfe6ouU
 G5Yw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725960786; x=1726565586;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=2HSmuzeo7rM9e6xfSVs6r/wcZxccLMH6wYFGEW+e9Cs=;
 b=ENGWb9QO/kAoWcHXag2zCgcYaDa1mh5l9q/rG8arccTb/1LdLxxBVjZUwerqOX5X4t
 MgYDWw/uXfmuQHYPQN0EUBktOiYKVJ4n/KZ3a/5+1+HXUFdaZANQCdtpDO7vP2B1n7G4
 5p8EeJlCCVJIz9m4l2aj/z/vuscnjIa++M5IhnvNOh4UfcxeBGr5OzMHFUxo5Hkh8Q51
 DTbBXA6INDwARPCx7doZsd+71leYuZNrlPXtAaVIL9Xxiy3rJDdWxzPO0R+hQvR4UDKo
 uEJ0LILV/+QOQ1dd2DXOki71j0MX5sQYZtqqB/R66k7iS4So4yIXiolTjH145cF8GBVK
 iVYA==
X-Forwarded-Encrypted: i=1;
 AJvYcCWSgM+YZ5Udyvbz9RIMQUlBKySwk/wlAyyIEr4zsDeAq6utTh5qT++dZNJjVASV2h2KT6MNUBZ9Nm+8@nongnu.org
X-Gm-Message-State: AOJu0YzTYxSTy8mV7gFZ9XnXeQj0zFHmkw2oVtmNcmSLwOt0TcS40N7O
 6Wy8outU8UWUmTIPk9CS1yzSFDp1RJbJU0eIdPAQRCR1exGDruSFK3CdHiNaLmI=
X-Google-Smtp-Source: AGHT+IE936hCO51tgXO9NN35t3kKjrQs/Csk51yb6jyMWCLF0telZhQ4OHFOH7PSVApBqrYMaYQIjg==
X-Received: by 2002:a05:6a21:478b:b0:1cc:eba0:e7d9 with SMTP id
 adf61e73a8af0-1cf5e1abe86mr131281637.39.1725960785926; 
 Tue, 10 Sep 2024 02:33:05 -0700 (PDT)
Received: from [157.82.204.48] ([157.82.204.48])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-20710f33210sm45370955ad.278.2024.09.10.02.33.02
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 10 Sep 2024 02:33:05 -0700 (PDT)
Message-ID: <08975798-2484-4aac-a032-5ab8a6475bde@daynix.com>
Date: Tue, 10 Sep 2024 18:33:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for-9.2 v15 00/11] hw/pci: SR-IOV related fixes and
 improvements
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Alex Williamson <alex.williamson@redhat.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?=
 <berrange@redhat.com>, Eduardo Habkost <eduardo@habkost.net>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Jason Wang <jasowang@redhat.com>, Keith Busch <kbusch@kernel.org>,
 Klaus Jensen <its@irrelevant.dk>, Markus Armbruster <armbru@redhat.com>,
 qemu-devel@nongnu.org, qemu-block@nongnu.org
References: <20240823-reuse-v15-0-eddcb960e289@daynix.com>
 <20240910052046-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20240910052046-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: none client-ip=2607:f8b0:4864:20::536;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pg1-x536.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_NONE=0.001 autolearn=ham autolearn_force=no
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

On 2024/09/10 18:21, Michael S. Tsirkin wrote:
> On Fri, Aug 23, 2024 at 02:00:37PM +0900, Akihiko Odaki wrote:
>> Supersedes: <20240714-rombar-v2-0-af1504ef55de@daynix.com>
>> ("[PATCH v2 0/4] hw/pci: Convert rom_bar into OnOffAuto")
>>
>> I submitted a RFC series[1] to add support for SR-IOV emulation to
>> virtio-net-pci. During the development of the series, I fixed some
>> trivial bugs and made improvements that I think are independently
>> useful. This series extracts those fixes and improvements from the RFC
>> series.
>>
>> [1]: https://patchew.org/QEMU/20231210-sriov-v2-0-b959e8a6dfaf@daynix.com/
>>
>> Signed-off-by: Akihiko Odaki <akihiko.odaki@daynix.com>
> 
> I don't think Cédric's issues have been addressed, am I wrong?
> Cédric, what is your take?

I put the URI to Cédric's report here:
https://lore.kernel.org/r/75cbc7d9-b48e-4235-85cf-49dacf3c7483@redhat.com

This issue was dealt with patch "s390x/pci: Check for multifunction 
after device realization". I found that s390x on QEMU does not support 
multifunction and SR-IOV devices accidentally circumvent this 
restriction, which means igb was never supposed to work with s390x. The 
patch prevents adding SR-IOV devices to s390x to ensure the restriction 
is properly enforced.

Regards,
Akihiko Odaki

