Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0AC0DE77197
	for <qemu-devel@archiver.kernel.org>; Thu,  9 Jan 2025 14:48:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tVtoj-0003cW-En; Thu, 09 Jan 2025 09:47:25 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtoh-0003bm-65
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:47:23 -0500
Received: from mail-wr1-x432.google.com ([2a00:1450:4864:20::432])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <philmd@linaro.org>) id 1tVtof-00086L-LC
 for qemu-devel@nongnu.org; Thu, 09 Jan 2025 09:47:22 -0500
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-385d7b4da2bso887025f8f.1
 for <qemu-devel@nongnu.org>; Thu, 09 Jan 2025 06:47:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1736434040; x=1737038840; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=LSAu0eGbckNHK6/2OkqkFFHUSWG0/y56W66fFy7INvM=;
 b=kKzOoeEYR062FLHGp86BdwK0pSAYD5IT7G+NE9aFfvz40iDeMp49BUfQYq1yMXldTA
 tyPE9bo14Y4VdJju7L9WCqrb5GlCHSGGRMhZMhRzXojwfHbMYNN0wadvaOLaU/h8eXwU
 z+6yXX+/QewDsN35GJ08JaMiqicvP/roZqzyG13Sj03Tn6zLt+iKo3lavqAwRiPRfWa2
 i4Yb0jiwaLZXRTwvdvB/KdszMimm1KzZ0inNENosSQjmSx2JD/BqO4X9qSlOWWAp6724
 Efqq+1KGaglJsacYRwNE39Xv4PumUMTY9FSY0hz6kfcvH/nzGDRJdrviDMPCTmtfND0h
 NyYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1736434040; x=1737038840;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=LSAu0eGbckNHK6/2OkqkFFHUSWG0/y56W66fFy7INvM=;
 b=EpuRvrxIyIFiAj+W/kj5Ols4ya87VcWweTyKPS+7dg18FHv73ZeebG23pU9YFMtf6z
 zbHMikSg/z8KfbMrMOz7GSq6g9CaEG8i4XZ1291rmwWSFvfGmXEfy6dYLuF3airJTzBA
 L/OJl+yxdjeIg9P8SzV+FnjgI9+5vEchlJ0U6QiCteu7tIlH0bkJwM0l2XPXk+lgqHy9
 vvKxuvAugqEGeviuHYbXlHVN/SOyetowO9r+NHaIj5b9yv2wgrCY6BFFUfjM53nxWOtt
 pYuHNeDarkI13I0hMRff55ILNpOS6LE71OkyUOPKTYBvIzMfmoAaSnqfajzi66lD2Dg1
 6GSg==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0GK0pKZczPt2IfKEZAjsf/+ZdyDoOe+k1U0N2ejL48UqzD2fJd+GVJO4oiyGmBZR2nXOO2rcr8F1v@nongnu.org
X-Gm-Message-State: AOJu0YyY5PbKzYu0eiYyj496olucIIDNbN9LouPaxElLbfinX0zqcQ8y
 zI6WvYNSfBsvix1WfWWFuzYj2sqhj/tsGwYpkeRO3RvV/OU76AF5I7ELVOrfu18=
X-Gm-Gg: ASbGnctRoucVQGyKWFzKVej+MmCEEJvCARScHui9uRJ9XQIqw/XDxg2q07+2FHQNEJn
 +n9MhpyUcg9rmdPjkX7eRqOn4Sr/BJpH7RSx2o96X6Xz5YsyrRj3hLEkKprx7s1F9fvnb+A8Yue
 WpZpNavX7tKvz/p0yPz5Jquaptz9fk9TtSgL67t/YawC5Z20FuLd2pxZ4wxNgKE0uSNK/ZqNWQi
 5+dUiLCMeY+QsYKuvD255uETm3r0LniVWA6aDmei/240wVNKsscKUwvqyssg9h/g3wcCOKf6fB2
 geNQkD3JtZgavxFIEafdcoczCBM=
X-Google-Smtp-Source: AGHT+IGH90ELeKTmHvKHQM4cCbyh4P/f90NGFDdqb4fNB6XC4QAwuXfQIfyTfMPyTd0ZSrlk+BtDHw==
X-Received: by 2002:a05:6000:4a06:b0:385:d7f9:f157 with SMTP id
 ffacd0b85a97d-38a87338df5mr6558980f8f.36.1736434039823; 
 Thu, 09 Jan 2025 06:47:19 -0800 (PST)
Received: from [192.168.1.74] (88-187-86-199.subs.proxad.net. [88.187.86.199])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-38a9407fd62sm192551f8f.92.2025.01.09.06.47.18
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 09 Jan 2025 06:47:19 -0800 (PST)
Message-ID: <12f26f53-8911-4f28-bbd8-0af5363a1c81@linaro.org>
Date: Thu, 9 Jan 2025 15:47:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] hw/ufs: Adjust value to match CPU's endian format
To: keosung.park@samsung.com, Jeuk Kim <jeuk20.kim@samsung.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "farosas@suse.de" <farosas@suse.de>,
 "lvivier@redhat.com" <lvivier@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>
References: <CGME20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
 <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Content-Language: en-US
From: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>
In-Reply-To: <20250107084356epcms2p2af4d86432174d76ea57336933e46b4c3@epcms2p2>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2a00:1450:4864:20::432;
 envelope-from=philmd@linaro.org; helo=mail-wr1-x432.google.com
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

On 7/1/25 09:43, Keoseong Park wrote:
> In ufs_write_attr_value(), the value parameter is handled in the CPU's
> endian format but provided in big-endian format by the caller. Thus, it
> is converted to the CPU's endian format. The related test code is also
> fixed to reflect this change.
> 
> Fixes: 7c85332a2b3e ("hw/ufs: minor bug fixes related to ufs-test")
> Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>
> Signed-off-by: Keoseong Park <keosung.park@samsung.com>
> ---
>   hw/ufs/ufs.c           | 2 +-
>   tests/qtest/ufs-test.c | 2 +-
>   2 files changed, 2 insertions(+), 2 deletions(-)
Patch queued, thanks.

