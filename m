Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 656C1C369BD
	for <qemu-devel@archiver.kernel.org>; Sat, 19 Apr 2025 08:41:03 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u63ko-0000hL-1h; Sat, 19 Apr 2025 04:40:50 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u63kl-0000gr-TS
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 04:40:47 -0400
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <akihiko.odaki@daynix.com>)
 id 1u63kk-0005Q3-3u
 for qemu-devel@nongnu.org; Sat, 19 Apr 2025 04:40:47 -0400
Received: by mail-pj1-x1031.google.com with SMTP id
 98e67ed59e1d1-2ff6e91cff5so2490192a91.2
 for <qemu-devel@nongnu.org>; Sat, 19 Apr 2025 01:40:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20230601.gappssmtp.com; s=20230601; t=1745052043; x=1745656843;
 darn=nongnu.org; 
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=07BNuBVAgTVcEVZo/zm54s6mDeI7JQFONlNRgG2TeSw=;
 b=ct1ZOTQJi1btbllF4JV9u2wHpqn11MMbMHu881gOE4FJ+rbX8cqVPjP4ANYNIyjid8
 csyAiIgt5fZUGT8WgIG0ncZredsfXZd5OovFYvdHiksI1Q0t+Jd+Wjo406jN2LgWtgLf
 9UzCwV/HYFfN4u7/AI5DCJKO+pAjnd96dh2dDrTWFWg3AT74DDj8v8ZsHw3v36XKx7/j
 Obi6KTjypbyT2UGRdJiKAheQ8bTiulcF5nVw4cSE2+VxrH9iWjNIH10AkYafjawwlz6+
 DmFZLyZ/eVcQt9E1TPNb7m28jZfYSgQ/M1zvgvRwmaLcLlg2yYOT/DQSNYqcHIyHbSL3
 2cnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745052043; x=1745656843;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=07BNuBVAgTVcEVZo/zm54s6mDeI7JQFONlNRgG2TeSw=;
 b=KZhOyJceMIZmQEClN5oZkccC/byl2XJqFvsIMKOOAQU6j5V5oNJGqYzZHmbZFM1kaj
 LXNAPflz+J7ocwgBENQw6knvAIlkFcnUw9FSNrWtHJigkjLNRCh8D9AoWytQrWfyRO1c
 V+0xjZuFSXDrQzAqspdQOt8KsCpLIcqeNucTwqhSWSX0xach/0OSEgnUmeGrvU75pQHz
 c4OhNXgP9g9Ld7us28KwBxG/Tt8ZpD2Osii+CUjgCP4r2i0ciy1MfabF6scWkaFsz+pV
 qGDGP8fseEH9SSHi3vUOs4LO1rklFC8SaT4lSXBxOsNoIJS4mJZ5dTTNzyRBTNx1//ab
 m6lQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCU9M8WcVdprgzUjzAXNTzQ0BVcCEe7dqKmRmAqDqQRhth6JMrSX8wWzncBXktVGhbeSK9kY4uBmDeoA@nongnu.org
X-Gm-Message-State: AOJu0YwsU4tSiO/YfV2r4dLr2/O42ogmQLjkP/NCiZhpEeLn1+gEpSTy
 kDcdoHcLiVnyNPUDJMoT0FYFp/sPhcKjOPM478txBSHzjW2HCZFsTOEi21k0YkQ=
X-Gm-Gg: ASbGncuGmN+MFJHRbHoiEgUgmK1grCewSWkJ0cTOfGpqEO4x6N6qw9IHUBs2iBwbAdW
 InEg2nOyeP0n720CY2nOYrCgog2OuuEh6saz89+43rvLPVozfPzJ8VRTMsl++IShqysUbTZ2jJx
 bXlWAyp1Rvigtuvthf9UDhgmWhwp4kNnwQ5ZLQnmVc3UQlvxoPQFMcAlTRVpS9df7KuZ/LwiKzG
 /W97mUWx/0B0/sZMcIeEbkb0oFumBKFtQHjOnsQMzK2mF4gR6/NSSBMt4CzaonKOAbtY48HGQ+g
 4aFViTR6Zg8637qcD+odJ/eaSqPttq3ilpCFHk02TgJXgp0+lxBAABDQNH+81subn6ctILlD+Eb
 82wRJfUkzaqynxZ5bI2s=
X-Google-Smtp-Source: AGHT+IGxZxVD6WvfH+Dax1CrFYhM5qVwnZWHmVUh6f0Q+3sgjXzaDCnldMY32eTyXFX/z/2ZgwEIbg==
X-Received: by 2002:a17:90b:2dc6:b0:2ef:114d:7bf8 with SMTP id
 98e67ed59e1d1-3087bb39b13mr7131705a91.6.1745052043669; 
 Sat, 19 Apr 2025 01:40:43 -0700 (PDT)
Received: from ?IPV6:2400:4050:b783:b00:9e36:5f4c:928c:4ec2?
 ([2400:4050:b783:b00:9e36:5f4c:928c:4ec2])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-22c50bf5398sm29378945ad.90.2025.04.19.01.40.41
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 19 Apr 2025 01:40:43 -0700 (PDT)
Message-ID: <f3fcbaff-cbb8-4caa-9226-a7c797951be0@daynix.com>
Date: Sat, 19 Apr 2025 17:40:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 4/7] tests/qtest/libquos/pci: Add migration fixup
 helper for pci devices
To: Nicholas Piggin <npiggin@gmail.com>, qemu-devel@nongnu.org
Cc: Fabiano Rosas <farosas@suse.de>, John Snow <jsnow@redhat.com>,
 Laurent Vivier <lvivier@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-block@nongnu.org
References: <20250411044130.201724-1-npiggin@gmail.com>
 <20250411044130.201724-5-npiggin@gmail.com>
Content-Language: en-US
From: Akihiko Odaki <akihiko.odaki@daynix.com>
In-Reply-To: <20250411044130.201724-5-npiggin@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2607:f8b0:4864:20::1031;
 envelope-from=akihiko.odaki@daynix.com; helo=mail-pj1-x1031.google.com
X-Spam_score_int: -18
X-Spam_score: -1.9
X-Spam_bar: -
X-Spam_report: (-1.9 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
 SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 2025/04/11 13:41, Nicholas Piggin wrote:
> Migration tests can create new QPCI devices for the destination
> machine which may need to take on some state of the source machine
> after destination is complete.
> 
> Add a migration fixup helper and call it from ahci migration tests.
> This is currently a noop and will be used subsequently.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Akihiko Odaki <akihiko.odaki@daynix.com>

