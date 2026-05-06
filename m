Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AC17FF8855
	for <qemu-devel@archiver.kernel.org>; Wed,  6 May 2026 13:24:50 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1wKcEG-0003sD-HI; Wed, 06 May 2026 09:23:56 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKcEE-0003rS-Jh
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:23:54 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1wKcED-0005qp-4L
 for qemu-devel@nongnu.org; Wed, 06 May 2026 09:23:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1778073831;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=g+UQ/stw0wvw54HpqwInoco668ZXqLWpi+iVjP0p1qY=;
 b=bHow2haTfRLe+RCWH+9sZzXyq7rKF+fm+IyqVCGG8SWwqjjxImnoa0P0uxhChW9Nb4LgD3
 hcF3qZcLr4twPBBlaXet8jK58l+IjaM5O5lUs/jKJ8LQlge0nlr+OxWOMo+Fzs42NVUmlf
 WuhI2vyCkqyGl6rfJbV8CjFbDeg6dsQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-627-Z3ea572xNSilGEr8Cd1lYg-1; Wed, 06 May 2026 09:23:50 -0400
X-MC-Unique: Z3ea572xNSilGEr8Cd1lYg-1
X-Mimecast-MFC-AGG-ID: Z3ea572xNSilGEr8Cd1lYg_1778073829
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-4411a1f9601so4714341f8f.0
 for <qemu-devel@nongnu.org>; Wed, 06 May 2026 06:23:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1778073829; x=1778678629; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to;
 bh=g+UQ/stw0wvw54HpqwInoco668ZXqLWpi+iVjP0p1qY=;
 b=FSFqoLXK+n8i3iCMCUmh+ImsuRQjeMZ3X5YCFhw3HnqwzVUPVPi7Lg+eO85pp91flw
 +3HXvdGAlZ5xlZcTDtiIgLSvHK05TsWJdbcjL7O8+se4eg2xAAnFXPhFpH2geOopwJcg
 Z5eq9JzINxj90yDLUXr9/SHTuXzHqgsObQFCPFCQqF61vtYJJKbyn+5zPfSGw7dIcHeX
 xbkvYTNefg9YFyKvF8tyaEMM3O7h3IFXWhoxbfUz0WvFktGO2fTVVZ+ZOBra4ke5LG1q
 ht7AnuMHaE8yI6iKYOl/i807v8nziT3Wq3naG5GIUamoAZfyuoAntEwpXguPWOcjfEEB
 YW9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778073829; x=1778678629;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=g+UQ/stw0wvw54HpqwInoco668ZXqLWpi+iVjP0p1qY=;
 b=fCn0Skv7KkMafjpTNpQv1KUjMgXXGHRp75ZTGcOqxZUIMJwLbGdyShV6BVMn3A5pAQ
 G5eyhQHrBr6KXyaw1IAjVy2Z/AcMwCGoZimGPT44C8ExQnhY+ZtUQgDJ1hJFfzC6oL7k
 UZu3+UdOweddE819JwF66Ke34iRAMa3vGV4G32KwQ0Es1UHdYxTyzc7YpSdRg0VSJzBr
 MJcnP/M7nyTON7k4tA/VxmqY5bFeMSSxJWqEYAlE0fxTKi1moJ2F6jHCKu6o28TUTY3P
 c7XTWBrgPc2n74Ky9cLMaYDv04bup1nu4MVJm4sRBp8OHJPdnPsZlIKO/u6TaPJz5GEb
 yA0g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/LiAXYnu/yLNl6/NinPQINtvA6hsCaBj/+ERD3khe/2Kc8q7EkB3keTm7MjKEQiU4HTC4gOQrjSqQN@nongnu.org
X-Gm-Message-State: AOJu0YxgzA2mV6gKfgUvI6OJpmIgEIYKwQ/h/NM7zGuCyQFNMr5U9Q3V
 37Dw5fiK++VhUDlwdxbU5T4u/TBxbj/4EPxEFj9fc4vYdsPFexM9akLYBjGatALSzo5+nrShqMS
 D3tzCBzDqgT5pa60yr9IT47P+m/zgUqqC2SHIufUjAwaPbNoZtakv5ZtV
X-Gm-Gg: AeBDietb/v1zfhlsWyZIkDg7/Mu3ri6I5VimzIZdCzRENIiOwveBOKzm5GfiKdxZDiG
 YEKuiYR3CyBCPWkMRW7LlHSS0KAC3iJ0ypS8sWcm16VstwlPK+xkKFymHGOmp3iQeSqSpYR6kTi
 nDvtSfcdWJCHWmahI6LDych78KUmDwRl32k5z9JzFUDxIETmPFLtTv1qTU5uzWlfCapS0FauIGR
 /YtmQ2ib+ZrripzI2mW7sJbdxUI3hYZvw2NdmIg8LHZPiYewyynHCjl94uCD9p+zwFvg6ZXiZJB
 HlsZgK4upTrQ2xXC6HhmGUsLXfH0jAiYXOqBEhwj6kdWd1uqs0hkWJIuxxZdH+eu0jKd5gCPVSD
 zMLGPgWQobAhRmjDI0L57eSQJzxGBUNkCAjc5RpLELMllpcMYR2+Ht2uIlQ==
X-Received: by 2002:a05:6000:24c9:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-4515c575364mr6134692f8f.21.1778073829253; 
 Wed, 06 May 2026 06:23:49 -0700 (PDT)
X-Received: by 2002:a05:6000:24c9:b0:43f:dc54:9493 with SMTP id
 ffacd0b85a97d-4515c575364mr6134623f8f.21.1778073828752; 
 Wed, 06 May 2026 06:23:48 -0700 (PDT)
Received: from [10.33.192.176] (nat-pool-str-t.redhat.com. [149.14.88.106])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45052a4878fsm12132317f8f.9.2026.05.06.06.23.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 06 May 2026 06:23:47 -0700 (PDT)
Message-ID: <a25ab197-ee75-4c9d-aac8-f7f4e36b5778@redhat.com>
Date: Wed, 6 May 2026 15:23:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: MAINTAINERS entries that aren't S: Orphan but maybe should be
To: Markus Armbruster <armbru@redhat.com>, qemu-devel@nongnu.org
Cc: qemu-riscv@nongnu.org, qemu-ppc@nongnu.org, qemu-block@nongnu.org,
 integration@gluster.org, Zhao Liu <zhao1.liu@intel.com>,
 Yoshinori Sato <yoshinori.sato@nifty.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Milan Zamazal <mzamazal@redhat.com>,
 Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
 Mark Kanda <mark.kanda@oracle.com>, Li Zhijian <lizhijian@fujitsu.com>,
 Glenn Miles <milesg@linux.ibm.com>, Gautam Menghani <gautam@linux.ibm.com>,
 Fabiano Rosas <farosas@suse.de>, Ben Chaney <bchaney@akamai.com>,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>,
 Pierrick Bouvier <pierrick.bouvier@oss.qualcomm.com>,
 =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
References: <87y0hwbvbp.fsf@pond.sub.org>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <87y0hwbvbp.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=unavailable autolearn_force=no
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

On 06/05/2026 14.01, Markus Armbruster wrote:
> I'm cc'ing reviewers and lists mentioned below, and frequent
> contributors to MAINTAINERS.
> 
> There are a number of MAINTAINERS entries with S: other than "Orphan"
> without M:
...
>      MAINTAINERS:4238: GLUSTER
>      L: qemu-block@nongnu.org
>      L: integration@gluster.org
>      S: Odd Fixes
The Gluster backend has been marked as deprecated in QEMU since v9.2 
already, and as far as I know, there was nobody complaining, so it's likely 
time to remove the code now?

  Thomas


