Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 494BDC83F17
	for <qemu-devel@archiver.kernel.org>; Tue, 15 Jul 2025 06:30:02 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ubZ4y-00070O-VU; Tue, 15 Jul 2025 02:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ3x-0006cb-Kw
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:22:57 -0400
Received: from mail-wm1-x330.google.com ([2a00:1450:4864:20::330])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1ubZ3v-0007rU-IL
 for qemu-devel@nongnu.org; Tue, 15 Jul 2025 02:22:49 -0400
Received: by mail-wm1-x330.google.com with SMTP id
 5b1f17b1804b1-4555f89b236so35290965e9.1
 for <qemu-devel@nongnu.org>; Mon, 14 Jul 2025 23:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1752560566; x=1753165366; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LEfmCgjfW5wdBi3tdD6kVKoEdzvru15ZdSgTN0/l8fE=;
 b=xWxZAU+ZsEnVbM0hcZdqf6/dfmNZYhnN/WTb9/RTh9/kDpKM6d4BdufqhrA3UPwu/2
 7jTTDt37+/Zu1FARqJAoylFTyHyTdLxoNthnlPkGKR3fYkavm9QkmjEcArpsJv4r+TP3
 ZVLquwM4c7HBBIpIMMB5YQkj2cERL9+3fI8kXjYNPPntMgxGNSn+sNsWl/Ap+LCkJQe6
 PpF50JbzS2L9HCmYUtpW30tvE8M8zHAL4fGGxTlzA/Sqds4CU0jfEIXz0qq8/qMD+Hed
 SCZJunNS/uq2M71wwaAGfP6ybIo3ZY0hywkBvumI9a5gvJtFxgWSxjV8KLIna6Se84B2
 kMNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752560566; x=1753165366;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LEfmCgjfW5wdBi3tdD6kVKoEdzvru15ZdSgTN0/l8fE=;
 b=SayCBWR4L3gIxD/RTPRv6I/p0bZ8ZW9Legt1EG5goXCIlWWtuXhUqyLpflwHbB1K2d
 DmgOTd5HqZwqweZJMYv/QfcTEQHYvUryyTSLL8pwUZc7uGA2q2vZnqgIXo+lBO6PRFHH
 g7I2Y/a2u+3HvwPNcqZjBVhBvm2BGYq3FeSnATn8CKutMK1bXw2TqJxTsI/kl17ZRXMY
 Hz8rze11pt+gewqza3dXOfpE/VcwfHs+d2gWDmOLfKJUW7YJk4UlOGvL4+CeV0/gEk8s
 S7ABxz6cNXK1pxPd6AlYPGl/KFHZHQkjIiwNV8Al0+PErLI11sSKMwA/Pi8hHHJddKkQ
 aV/Q==
X-Forwarded-Encrypted: i=1;
 AJvYcCWzMoHByCRpb8VMntuSXG5E5iSFgcOG0BinXQzooFjdeyB1Yo4IP1Xyb+jR6Injy6i9193q/XG5+NAt@nongnu.org
X-Gm-Message-State: AOJu0Yy01I1DJvLf82gRNqfYmIdi6IQBi9pVpSwB3EnXSrH7YI0DJDJc
 +GyihYEk21OSiyt3wCHW/r1upfembt2uOq8seK16IyXvKmXf8CrUX5kgFwIlynI4ndE=
X-Gm-Gg: ASbGncsq6Znj0/lHfhMvydq42ivaMLSrT7x2cE4jkpsPVQXckz8uRAPuaN3TJkakBd7
 ElVno5ar6731TxG0bEfkRYA3Ys8Yo1wWniTpZhrpyOUcnkQSdkf4ZXwdXxAQfCGNvLNnvdEhjv8
 IpM7NXLgjRJRMtTdnZYw2Km3muSMcVD9veDQCdquLehPY50xpJFXSI1tZjgOOt2ONQ9oPn1Pat7
 KREsVX2jjdZUN/boFuoZj2zemjltfyjukKabEPIZAuCoV1ydLU3FCGjGY15B3Jqc08SxWD9bxpf
 7Lr8VcMc9Dl0G4P3ovJkG4dyB08847PiclhLirNOwcplFkLbZJX0flML1y7qvNd2xuAYuHKHGHv
 gkLy+ip2lUVk1U+AvFI/c9Vr4p1T+R0R9rkqqwJ6wDKVqetjvKJWt9SYnilGSwS6JSg==
X-Google-Smtp-Source: AGHT+IGcbRN37pQ3lyhmlHU4NIojc3p8RHRP9Yaz5oLyPoNY6lSiZXt4zbW8kZ5GbcYBGUvgOQVJJA==
X-Received: by 2002:a05:600c:358f:b0:456:7cf:527a with SMTP id
 5b1f17b1804b1-45607cf57cbmr84097065e9.28.1752560565673; 
 Mon, 14 Jul 2025 23:22:45 -0700 (PDT)
Received: from [192.168.69.239] (88-187-86-199.subs.proxad.net.
 [88.187.86.199]) by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4561a052729sm55173695e9.33.2025.07.14.23.22.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 14 Jul 2025 23:22:45 -0700 (PDT)
Message-ID: <61709016-a8f9-4670-b5bd-3fb7f6105074@linaro.org>
Date: Tue, 15 Jul 2025 08:22:44 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] rust: bindings: allow any number of params
To: "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org
Cc: Manos Pitsidianakis <manos.pitsidianakis@linaro.org>, qemu-rust@nongnu.org
References: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <e41344bd22248b0883752ef7a7c459090a3d9cfc.1752560127.git.mst@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::330;
 envelope-from=philmd@linaro.org; helo=mail-wm1-x330.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001,
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

On 15/7/25 08:15, Michael S. Tsirkin wrote:
> We are going to be adding more parameters, and this makes
> rust unhappy:
>      Functions with lots of parameters are considered bad style and reduce
>      readability (“what does the 5th parameter mean?”). Consider grouping
>      some parameters into a new type.
> 
> Specifically:
> 
> error: this function has too many arguments (8/7)
>      --> /builds/mstredhat/qemu/build/rust/qemu-api/rust-qemu-api-tests.p/structured/bindings.inc.rs:3840:5
>       |
> 3840 | /     pub fn new_bitfield_1(
> 3841 | |         secure: std::os::raw::c_uint,
> 3842 | |         space: std::os::raw::c_uint,
> 3843 | |         user: std::os::raw::c_uint,
> ...    |
> 3848 | |         address_type: std::os::raw::c_uint,
> 3849 | |     ) -> __BindgenBitfieldUnit<[u8; 4usize]> {
>       | |____________________________________________^
>       |
>       = help: for further information visit https://rust-lang.github.io/rust-clippy/master/index.html#too_many_arguments
>       = note: `-D clippy::too-many-arguments` implied by `-D warnings`
>       = help: to override `-D warnings` add `#[allow(clippy::too_many_arguments)]`
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
>   rust/qemu-api/src/bindings.rs | 3 ++-
>   1 file changed, 2 insertions(+), 1 deletion(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>


