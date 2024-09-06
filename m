Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06C01CE7AE0
	for <qemu-devel@archiver.kernel.org>; Fri,  6 Sep 2024 07:51:16 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1smTjz-0005BO-AW; Fri, 06 Sep 2024 03:50:47 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smTjr-0004ab-CY
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:50:41 -0400
Received: from mail-wr1-x431.google.com ([2a00:1450:4864:20::431])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1smTjo-00022b-Ne
 for qemu-devel@nongnu.org; Fri, 06 Sep 2024 03:50:39 -0400
Received: by mail-wr1-x431.google.com with SMTP id
 ffacd0b85a97d-374cacf18b1so1128507f8f.2
 for <qemu-devel@nongnu.org>; Fri, 06 Sep 2024 00:50:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1725609034; x=1726213834; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=KWXJlQODoW3Dlva+TLJt4h05G4FApj1jlcq9YVK/h5s=;
 b=WLKk3VUNOoC4xX8pUvqwvjWSKvAUF/Z5wwnygLiO64qMP0D1FOmki/Q/umxCH036mQ
 7x53zgC0bFv+j3C/3jXsIk51gjQvZ8phctgA3rlPFYyMxhOWWBc5kv7lsNAaVHPxe9j5
 PwaryybP9wznVNT3zmG+vWf38kDfL5RqfyGSn98mzIyWdCb4LVEb7RBqxjuRlgnw+v9+
 uDQpCb8ZUwkPsKPDXs67g4kSUvJZU0r9pI9MK/DB/VCvRNdn0HvCpD95fzhx4bhfBxc1
 K4zxQznMp/47lfPu/MYD183lUlQ3l/229r26KIT+mokYjxMHPsLTlg3ArR2sglP/4cWU
 kR3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1725609034; x=1726213834;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=KWXJlQODoW3Dlva+TLJt4h05G4FApj1jlcq9YVK/h5s=;
 b=ci7jjwcIBJw1weEEoLBcg1MSZtIiSKnMJtpkWmIZqq3SOq1vXR2b4zFDZJz5F+vM3c
 L+/U2IYyKNb3f08L72rn3Jp8hs2p9ZB+NYFgqtFMs6GExU8fDTxzhGBofFbhL40wsK5M
 8upvfzRlxQlMLRxgxBqAmF6hcqNyg0cptQsTSJeJ736tStLIBdg2mjMQsJd4EKrxybEW
 bh2HKabPhmetUCy7sD7Ts7sDd80EBR54g4ass9RI1P6g4ons3BdaISRuuP3UO+WepG/t
 QgsfZmD3NMoXzdB0iPxQyNL06XJ4iG77Y82dh/jhMPHQVTgF0ctjrfyyN7uj7znIsTRA
 5OEg==
X-Forwarded-Encrypted: i=1;
 AJvYcCV8zXiyaKYMfTCd8U0MxvQcsVHalPkbwDuEWhezcXgpb3kBlfNpXGIChVtKElfYTQ16Z2Q9pQ6LhemN@nongnu.org
X-Gm-Message-State: AOJu0YzZaJ/PP/e2eNdeXoadjsKfKRpHJGcYWlyEF2Kh1PnGpV00oJsQ
 YUlqSSNgWEVAaWRI2CPLW/Nsf0xlAFWpCrxNXXTgnkf/R0pXHtmuXdZmcQ7hzsQ=
X-Google-Smtp-Source: AGHT+IFRFsIklq/If21wqV9usrIs1D0HzpBAYCFw8hscrW2shi3NGLDOz2b/j6Pi2nY5aAo+hNWQDA==
X-Received: by 2002:adf:8b5a:0:b0:374:be8e:7325 with SMTP id
 ffacd0b85a97d-374be8e742fmr12541801f8f.51.1725609033595; 
 Fri, 06 Sep 2024 00:50:33 -0700 (PDT)
Received: from [192.168.1.67] ([78.196.4.158])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3749ee4a5edsm21208313f8f.1.2024.09.06.00.50.32
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 06 Sep 2024 00:50:33 -0700 (PDT)
Message-ID: <9abc2f6e-6352-4083-b396-250e1ac23fb0@linaro.org>
Date: Fri, 6 Sep 2024 09:50:32 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/8] tests/qtest/hd-geo-test: Check for availability of
 "pc" machine before using it
To: Thomas Huth <thuth@redhat.com>, qemu-devel@nongnu.org,
 Paolo Bonzini <pbonzini@redhat.com>
Cc: qemu-riscv@nongnu.org
References: <20240905191434.694440-1-thuth@redhat.com>
 <20240905191434.694440-5-thuth@redhat.com>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20240905191434.694440-5-thuth@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2a00:1450:4864:20::431;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x431.google.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIM_SIGNED=0.1,
 DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, SPF_HELO_NONE=0.001, SPF_PASS=-0.001,
 T_SCC_BODY_TEXT_LINE=-0.01 autolearn=unavailable autolearn_force=no
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

On 5/9/24 21:14, Thomas Huth wrote:
> In case QEMU has been configured with "--without-default-devices", the
> "pc" machine type might be missing in the binary. We should check for
> its availability before using it.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>   tests/qtest/hd-geo-test.c | 71 +++++++++++++++++++++------------------
>   1 file changed, 38 insertions(+), 33 deletions(-)
> 
> diff --git a/tests/qtest/hd-geo-test.c b/tests/qtest/hd-geo-test.c
> index d08bffad91..85eb8d7668 100644
> --- a/tests/qtest/hd-geo-test.c
> +++ b/tests/qtest/hd-geo-test.c
> @@ -1074,17 +1074,26 @@ int main(int argc, char **argv)
>           }
>       }
>   
> -    qtest_add_func("hd-geo/ide/none", test_ide_none);
> -    qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
> -    qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
> -    qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
> -    qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
> -    qtest_add_func("hd-geo/ide/device/mbr/blank", test_ide_device_mbr_blank);
> -    qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
> -    qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
> -    qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
> -    qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);
> -    if (have_qemu_img()) {
> +    if (qtest_has_machine("pc")) {
> +        qtest_add_func("hd-geo/ide/none", test_ide_none);
> +        qtest_add_func("hd-geo/ide/drive/mbr/blank", test_ide_drive_mbr_blank);
> +        qtest_add_func("hd-geo/ide/drive/mbr/lba", test_ide_drive_mbr_lba);
> +        qtest_add_func("hd-geo/ide/drive/mbr/chs", test_ide_drive_mbr_chs);
> +        qtest_add_func("hd-geo/ide/drive/cd_0", test_ide_drive_cd_0);
> +        qtest_add_func("hd-geo/ide/device/mbr/blank", test_ide_device_mbr_blank);
> +        qtest_add_func("hd-geo/ide/device/mbr/lba", test_ide_device_mbr_lba);
> +        qtest_add_func("hd-geo/ide/device/mbr/chs", test_ide_device_mbr_chs);
> +        qtest_add_func("hd-geo/ide/device/user/chs", test_ide_device_user_chs);
> +        qtest_add_func("hd-geo/ide/device/user/chst", test_ide_device_user_chst);

Just wondering, could a qtest_add_machine_func() method be helpful?
Maybe not if we want to check for multiple machines?

