Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 05FC1C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 14 Jul 2025 01:05:21 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ub7bz-000803-TF; Sun, 13 Jul 2025 21:04:08 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1ub7WA-0004aR-7o
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 20:58:06 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <gshan@redhat.com>) id 1ub7W8-0006Cq-56
 for qemu-devel@nongnu.org; Sun, 13 Jul 2025 20:58:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1752454682;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qUmVGWmiQ9qj6UDI8yyGeFapyi86on9NnjOakrMOqpk=;
 b=dRXJpggdnodJlRz4Gi43UWYC+u1IxD/tYIPF1Mzd5W1x0Ro8wxCrn/0LQkT4s7sWta/i5a
 W4PUReM5m/M3qMWxOGfa2qskh5QEulo2ZGjQIfjUHXzpZsojpoeMN5UEDqj91+/f2k+grx
 tFQJqToBqx/CL/CIxIYXwpfzuWvIDiw=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-178-FJZDbxLfPBKrcR4idqH2YA-1; Sun, 13 Jul 2025 20:56:41 -0400
X-MC-Unique: FJZDbxLfPBKrcR4idqH2YA-1
X-Mimecast-MFC-AGG-ID: FJZDbxLfPBKrcR4idqH2YA_1752454600
Received: by mail-pg1-f199.google.com with SMTP id
 41be03b00d2f7-b391a561225so2931410a12.1
 for <qemu-devel@nongnu.org>; Sun, 13 Jul 2025 17:56:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1752454600; x=1753059400;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=qUmVGWmiQ9qj6UDI8yyGeFapyi86on9NnjOakrMOqpk=;
 b=J5IXXgmHKwVaYAr7U4NaBgwBiIi5GlkW9lEWQWjmZpImj4JyMuC2EjdpIPox5b+B6z
 zw0sCiovuQ4zy2a7ZHXdd5mJkXXvVxW2E3XV3ToYY/eErSyY5VwN94W9spNZAq9upPJN
 AuatpZ3chhvrqrvZHDqMf3oMLpwEhYxVsLDTA0iGg2cOvg1k6L862COS8WzRZjQQlylN
 3U80R9335mS44TWnvKTGGhteQMqzpKkDJHuJCh8ojCaGTy+4PaInSbgYF/BPhka8NhyL
 +9eWEDdvFP7TDkVLQfjTqxzfXeIQxhCSx7pf5R7hneGTE20ZuR8PWwO3cdHGD+OhqNRH
 M/LA==
X-Forwarded-Encrypted: i=1;
 AJvYcCVA9VUE0eE2OjigB43vXXhLNfNtBnX93RdelY1Qso6eXSV8NT+7pArJZneJWSwQEm67lRkzRdHjawmW@nongnu.org
X-Gm-Message-State: AOJu0Yzkqf0loX010jfizEL9nl8MR7K7t21zoN+IV2QFF7mZrneE8N+6
 qVudd07l+fXLE1jiQJKOSzLW0vmlevTEuFxTkPZJ8/SmBInkglm0s8k+UljSz2qk/0X3aocQjmU
 ZsHQrHegEALeN4MdzZYUtlRX6iJH4ln/aS6BulhzWRP/toahS69JF3/wg
X-Gm-Gg: ASbGncuoQl8ARBtpFPpmszEpncpA2s0qMdwWhzoXvKAR4C9+2wevvDRuIPCzQrTyOM4
 +dVU2/dKweH2MsiVnv/Vx/bRl1oQkIPmMmHI/x1XcTexDU7Q7xtRT09i0xYtboG5cLv7ikBERrf
 Eprfuk91OhMAOHoMug9Go1DB1rNQ9ObbinytZz1dJdZ2ibhI92G7FBBfLzqYVJdhj7ZQRgIg7GQ
 bbAG3+NihLG5/YAnq8EMuNrdGzgk8aGoM2Z43eRAsz/Kzy2kGsK7VdS9rwroRyL1sNKVkpoXqzU
 AMgaT8f4HrT7ETmWA3C7bj45E1z3KVJeZT0okWUDgfLeJ5Rz6kDr+p1u0h98yYg7MgLcxYAQc0r
 UfKY=
X-Received: by 2002:a05:6a20:a108:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-2313504eae8mr16344004637.10.1752454599974; 
 Sun, 13 Jul 2025 17:56:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEuM+Zi92A0hbUgn10WrjgmwNif+FKdGvokkBLHmwp/rW6/7cd0fjnuie824/YWyiFVdE8dUA==
X-Received: by 2002:a05:6a20:a108:b0:1f5:95a7:8159 with SMTP id
 adf61e73a8af0-2313504eae8mr16343960637.10.1752454599481; 
 Sun, 13 Jul 2025 17:56:39 -0700 (PDT)
Received: from [192.168.68.51] (n175-34-62-5.mrk21.qld.optusnet.com.au.
 [175.34.62.5]) by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-b3bbe727e33sm9168382a12.68.2025.07.13.17.56.30
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 13 Jul 2025 17:56:38 -0700 (PDT)
Message-ID: <05605650-2dd2-4abf-b0a5-f727753db7f5@redhat.com>
Date: Mon, 14 Jul 2025 10:56:28 +1000
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 (RESEND) 00/20] Change ghes to use HEST-based offsets
 and add support for error inject
To: Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Igor Mammedov <imammedo@redhat.com>, "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>,
 Shiju Jose <shiju.jose@huawei.com>, qemu-arm@nongnu.org,
 qemu-devel@nongnu.org, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Ani Sinha <anisinha@redhat.com>,
 Dongjiu Geng <gengdongjiu1@gmail.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Peter Maydell <peter.maydell@linaro.org>,
 Shannon Zhao <shannon.zhaosl@gmail.com>, Yanan Wang
 <wangyanan55@huawei.com>, Zhao Liu <zhao1.liu@intel.com>,
 kvm@vger.kernel.org, Cleber Rosa <crosa@redhat.com>,
 Eduardo Habkost <eduardo@habkost.net>, Eric Blake <eblake@redhat.com>,
 John Snow <jsnow@redhat.com>, Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 Markus Armbruster <armbru@redhat.com>, Michael Roth <michael.roth@amd.com>,
 linux-kernel@vger.kernel.org
References: <cover.1749741085.git.mchehab+huawei@kernel.org>
Content-Language: en-US
From: Gavin Shan <gshan@redhat.com>
In-Reply-To: <cover.1749741085.git.mchehab+huawei@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=gshan@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -30
X-Spam_score: -3.1
X-Spam_bar: ---
X-Spam_report: (-3.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=-1, RCVD_IN_MSPIKE_WL=-0.01,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.001,
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

Hi Mauro,

On 6/13/25 1:17 AM, Mauro Carvalho Chehab wrote:
> Hi Michael,
> 
> This is v10 of the patch series, rebased to apply after release
> 10.0. The only difference against v9 is a minor confict resolution.
> 
> I sent already the patch with conflicts, but, as you didn't pick,
> I'm assuming you're opting to see the entire series again, as it
> could make easier for you to use b4 or some other script you may
> use to pick patches. So, let me resend the entire series.
> 
> It is nearly identical to v9 which addressed 3 issues:
> 
> - backward compatibility logic moved to version 10.0;
> - fixed a compilation issue with target/arm/kvm.c (probably
>    caused by some rebase - funny enough, incremental
>    compilation was fine here);
> - added two missing SPDX comments.
> 
> As ghes_record_cper_errors() was written since the beginning
> to be public and used by ghes-cper.c. It ended being meged
> earlier because the error-injection series become too big,
> so it was decided last year to split in two to make easier for
> reviewers and maintainers to discuss.
> 
> This series change the way HEST table offsets are calculated,
> making them identical to what an OSPM would do and allowing
> multiple HEST entries without causing migration issues. It open
> space to add HEST support for non-arm architectures, as now
> the number and type of HEST notification entries are not
> hardcoded at ghes.c. Instead, they're passed as a parameter
> from the arch-dependent init code.
> 
> With such issue addressed, it adds a new notification type and
> add support to inject errors via a Python script. The script
> itself is at the final patch.
> 
> ---
> 
> v10:
> - rebased on the top of current upstream:
>    d9ce74873a6a ("Merge tag 'pull-vfio-20250611' of https://github.com/legoater/qemu into staging")
> - solved a minor conflict
> 

[...]

Just head up to check if this series has been merged? I don't see those patches
show up in the latest upstream QEMU yet. The reason why I'm asking is the subsequent
fix [1], which depends on this series.

[1] https://lists.nongnu.org/archive/html/qemu-devel/2025-05/msg06433.html

Thanks,
Gavin



