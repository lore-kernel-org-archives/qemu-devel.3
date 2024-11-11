Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F08ED2E9D5
	for <qemu-devel@archiver.kernel.org>; Mon, 11 Nov 2024 10:38:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tARny-0006lG-Ei; Mon, 11 Nov 2024 05:37:59 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tARnq-0006kw-R1
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:37:51 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tARno-0006ra-9M
 for qemu-devel@nongnu.org; Mon, 11 Nov 2024 05:37:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1731321463;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=StgbyrGnLx9oiuhXzO0YBAyvHcpMZsHwzc1Bvdy2iLA=;
 b=CqnkrziBl2eYsqVR0xz6wxDDpGJ14MyVzMoIk7qmsgVYdbIIaY6AcMaE+w8auAlSwZPClL
 e7BR+UA6PVMDTfREErZ/yGQur2gRZHgVmcV5xh6crtfh6LyYiTMvThULd+n+WGX7B8Oxlt
 3y9SuNMql8JC8jMFSahUsQKnO0Lq86g=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-383-zuaJuxmtO-2mQbpvQK-TPg-1; Mon, 11 Nov 2024 05:37:40 -0500
X-MC-Unique: zuaJuxmtO-2mQbpvQK-TPg-1
X-Mimecast-MFC-AGG-ID: zuaJuxmtO-2mQbpvQK-TPg
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-a9adb271de7so378495666b.0
 for <qemu-devel@nongnu.org>; Mon, 11 Nov 2024 02:37:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1731321459; x=1731926259;
 h=content-transfer-encoding:in-reply-to:autocrypt:cc:content-language
 :from:references:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=StgbyrGnLx9oiuhXzO0YBAyvHcpMZsHwzc1Bvdy2iLA=;
 b=o01Rc2+Zf2DnSaY3CeaCNKME6fUfDkONLTbE9fcLAlLFj1ZXW2EV7sPP5QJhkxOL3Q
 spPHAx4vK9We1mhcwus8UTDjL36JcLCmW+QyuLoj9Avt2rQF7C9aKWjggPIv21MsghXe
 jUW5XwvhUyPWhiLjK7+WPBjyk1zoVTCC77sOrWFPAVwpuweQHsp8gyTh8EC1Hfwcm9LK
 IEcqUY0drTXXAg8HCyz3hip/0xybW22Ba3k4Bhc2ByR+8Tsul7Pzx4X3NPsNijK/Q6lm
 kbr46od+kl4M8sbWCyYqgT1pCp7igi80vBNSinVcc3eBNGSVvEIVryw7gVtP5HAB2koy
 Abiw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWJ0IWdpIzWXOD0w8OtAv4rgZqlClscH/jMkjc0+uxGXQHzyENC50GZQgfMYd6NKSLfTJnVkPMIpPD/@nongnu.org
X-Gm-Message-State: AOJu0YzQWhkOeQg9D8UDTtErCxhA5+BBQ+SnIqxlgUgmfF5IHIsByVnU
 sSreGTZFC8bQ1Oh4EMjX94Yy/cmuliJrWmx2wTPOJoMUKtAmxYgK+eLMAFZFbtRqXaKvORkNsBD
 C1obfw0omOCLPKBZIRSrVoX9VKy312WaHAo0bh40ERlVLteff2lWr
X-Received: by 2002:a17:907:3d90:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a9eefebd4b5mr1231223266b.11.1731321459495; 
 Mon, 11 Nov 2024 02:37:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEfVbzAbIKoJLIZUXL1Ws2Y8GAoaUG44M69KPA/WzySn8a79G4ymOb3AV4DATBS75EYgTspZw==
X-Received: by 2002:a17:907:3d90:b0:a86:8e3d:86e2 with SMTP id
 a640c23a62f3a-a9eefebd4b5mr1231221366b.11.1731321459097; 
 Mon, 11 Nov 2024 02:37:39 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-51-55.web.vodafone.de. [109.42.51.55])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-a9ee0a4ab5esm579737966b.54.2024.11.11.02.37.38
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 11 Nov 2024 02:37:38 -0800 (PST)
Message-ID: <f2405acc-693f-415f-9f36-cd56bc472c75@redhat.com>
Date: Mon, 11 Nov 2024 11:37:36 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test harness hang running functional test
To: Peter Maydell <peter.maydell@linaro.org>,
 QEMU Developers <qemu-devel@nongnu.org>
References: <CAFEAcA-4cf+yub8bsgtsdFOJD_9HziY3tekCN5s=+JcWEpw3Nw@mail.gmail.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Cc: John Snow <jsnow@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <CAFEAcA-4cf+yub8bsgtsdFOJD_9HziY3tekCN5s=+JcWEpw3Nw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -29
X-Spam_score: -3.0
X-Spam_bar: ---
X-Spam_report: (-3.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.118,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=-0.743,
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

On 07/11/2024 17.09, Peter Maydell wrote:
> I was trying to track down why one of the functional tests was
> hanging, so I tried running it directly:
> 
> UBSAN_OPTIONS=halt_on_error=1:abort_on_error=1
> QEMU_TEST_QEMU_BINARY=build/clang/qemu-system-loongarch64
> PYTHONPATH=./build/clang/pyvenv:./python time
> ./build/clang/pyvenv/bin/python3
> ./tests/functional/test_loongarch64_virt.py
> 
> (This is with a QEMU built with the undefined-behaviour
> sanitizer.)
> 
> Mostly this seems to succeed, but this time it's hung. Looking
> at the process tree:
> 
> petmay01 3616444  0.0  0.0   4768  1124 pts/2    S+   15:53   0:00
>   \_ time ./build/clang/pyvenv/bin/python3
> ./tests/functional/test_loongarch64_virt.py
> petmay01 3616445 99.8  0.0  38480 23620 pts/2    R+   15:53  13:20
>       \_ ./build/clang/pyvenv/bin/python3
> ./tests/functional/test_loongarch64_virt.py
> petmay01 3616448  0.0  0.0      0     0 pts/2    Z+   15:53   0:00
>           \_ [qemu-system-loo] <defunct>
> 
> The QEMU process itself has exited, but the test harness has
> not yet noticed or reaped the zombie process. Instead it's sitting
> there eating CPU. Presumably this is a bug in the test harness?

Sounds like either a bug in the test harness or in the "python/qemu" module 
... I'll try to look at it, but maybe not in the next two weeks (I'm 
currently quite busy with other stuff), so if someone else wants to have a 
look already, that would be great!

  Thomas


