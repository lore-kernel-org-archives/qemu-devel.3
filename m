Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9219AEE0206
	for <qemu-devel@archiver.kernel.org>; Wed, 11 Sep 2024 16:56:37 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1soQdS-0004zp-90; Wed, 11 Sep 2024 12:56:06 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQdP-0004pu-QZ
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:56:03 -0400
Received: from mail-oa1-x33.google.com ([2001:4860:4864:20::33])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.90_1) (envelope-from <richard.henderson@linaro.org>)
 id 1soQdN-000419-Uc
 for qemu-devel@nongnu.org; Wed, 11 Sep 2024 12:56:03 -0400
Received: by mail-oa1-x33.google.com with SMTP id
 586e51a60fabf-27b55c4b35eso3125557fac.3
 for <qemu-devel@nongnu.org>; Wed, 11 Sep 2024 09:56:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=linaro.org; s=google; t=1726073760; x=1726678560; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=jT2yfHOKQil4uehZcIK/2WmRn/qwChXA7I64h0o8Rrg=;
 b=wt9zT+EISZIE355U9SkDQvKCBBtzJ7LUMsWR4ro2u17b4/ebn38y8gx3O5iEg6LQMO
 tUDeGO2QSo4/vSzudMbVC22qtKBS98y5wDIDv7FxqyY6Xpkox1z+dqhIOvs5VpJZVTP4
 n8eUPpL6SU+bqjYqRrUG2kPatsdsoAZBSu/3dkZear4KFQlepBVh9M3EAU1UJLn9nyBJ
 nR9O+F4XIr/X1xz1pdIQW5n1qM8881qF2LuL4itb/4Y1YNs6WtXzii8DaoYL1hSpLCN/
 OW5fYrXESJFHX6YwrXmbn+8YqlLv8QH8+mq2nIZ64aOTmZAcNSD3AuS/LB0gafGkZIXy
 rX5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1726073760; x=1726678560;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=jT2yfHOKQil4uehZcIK/2WmRn/qwChXA7I64h0o8Rrg=;
 b=DALpbFNfWARyTLXrx5jxDAaAYJvVhlM0NbiXP59zGKCm5SdUbCRXEusqelT5pFOFa+
 vkMVr06VWe+DLI3TzDoauWbOylTEw9mg9N5coGgYgAK5CMxX1sTq3HaxKzhQHr94Q8t0
 LePRJX0TkT5Jb4OYyvP2qkL099wG+y0y5kuHIpmBZ6POkVkzC/UjLSaXrmX5WMmg31aS
 nyp+hH7B95sYWJgErXMgPI6brqx1KQifzT4gXqIJ+KXAJvn5SYgFAFWHsWchyeg78Wvd
 r2JedrhN0olRb3d+1SYacWJOGMWbmd9rRFIPBxgHbUPzR2u8acs5ce2YSy5tHiZgnHVr
 GpBA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW2Ykx0ec5gg7YdprBhhwT/IHwfzC/MsOuvURw3f2zoUNYmCRI0zTSUhIOc0HjZyc9KUs8+1hTXcutp@nongnu.org
X-Gm-Message-State: AOJu0Ywqrx7OGLF0xKUTQ0M4jLsI4fUJwkgVht7rEHkEwQH0qzqHbh1z
 vDhAEG13RuKuVRyXEdnayrcSpbIHYyLvFaZ2eizFB3C6ywX8gwVrbOLTz0y0dpQ=
X-Google-Smtp-Source: AGHT+IHm6lZ+zYd6OLElv1nSKeE8E+EcYdnIUsM2//Be/MFCqecYcYkqJpKvjCJcxFiRHPU1Pk0c9g==
X-Received: by 2002:a05:6870:df48:b0:27b:b2e0:6a5 with SMTP id
 586e51a60fabf-27bb2e00bd5mr7219953fac.3.1726073760261; 
 Wed, 11 Sep 2024 09:56:00 -0700 (PDT)
Received: from [192.168.0.4] (174-21-81-121.tukw.qwest.net. [174.21.81.121])
 by smtp.gmail.com with ESMTPSA id
 41be03b00d2f7-7db1fbb5414sm210156a12.23.2024.09.11.09.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Sep 2024 09:55:59 -0700 (PDT)
Message-ID: <e9bac0e4-ee34-4634-a6a2-73854a45d7d6@linaro.org>
Date: Wed, 11 Sep 2024 09:55:57 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/39] docs/spin: replace assert(0) with
 g_assert_not_reached()
To: Pierrick Bouvier <pierrick.bouvier@linaro.org>,
 "Richard W.M. Jones" <rjones@redhat.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Eric Blake <eblake@redhat.com>, qemu-devel@nongnu.org,
 Zhao Liu <zhao1.liu@intel.com>, Joel Stanley <joel@jms.id.au>,
 Kevin Wolf <kwolf@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 qemu-arm@nongnu.org, Corey Minyard <minyard@acm.org>,
 Eric Farman <farman@linux.ibm.com>, Thomas Huth <thuth@redhat.com>,
 Keith Busch <kbusch@kernel.org>, WANG Xuerui <git@xen0n.name>,
 Hyman Huang <yong.huang@smartx.com>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 Michael Rolnik <mrolnik@gmail.com>,
 Alistair Francis <alistair.francis@wdc.com>,
 =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?= <marcandre.lureau@redhat.com>,
 Markus Armbruster <armbru@redhat.com>,
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>,
 Palmer Dabbelt <palmer@dabbelt.com>, qemu-riscv@nongnu.org,
 Ani Sinha <anisinha@redhat.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jesper Devantier <foss@defmacro.it>, Laurent Vivier <laurent@vivier.eu>,
 Peter Maydell <peter.maydell@linaro.org>, Igor Mammedov
 <imammedo@redhat.com>, kvm@vger.kernel.org,
 =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 Fam Zheng <fam@euphon.net>, qemu-s390x@nongnu.org,
 Hanna Reitz <hreitz@redhat.com>, Nicholas Piggin <npiggin@gmail.com>,
 Eduardo Habkost <eduardo@habkost.net>, Laurent Vivier <lvivier@redhat.com>,
 Rob Herring <robh@kernel.org>, Marcel Apfelbaum
 <marcel.apfelbaum@gmail.com>, qemu-block@nongnu.org, qemu-ppc@nongnu.org,
 Daniel Henrique Barboza <danielhb413@gmail.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Harsh Prateek Bora <harshpb@linux.ibm.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Nina Schoetterl-Glausch <nsg@linux.ibm.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Fabiano Rosas <farosas@suse.de>,
 Helge Deller <deller@gmx.de>, Dmitry Fleytman <dmitry.fleytman@gmail.com>,
 Daniel Henrique Barboza <dbarboza@ventanamicro.com>,
 Akihiko Odaki <akihiko.odaki@daynix.com>,
 Marcelo Tosatti <mtosatti@redhat.com>,
 David Gibson <david@gibson.dropbear.id.au>,
 Aurelien Jarno <aurelien@aurel32.net>,
 Liu Zhiwei <zhiwei_liu@linux.alibaba.com>,
 Yanan Wang <wangyanan55@huawei.com>, Peter Xu <peterx@redhat.com>,
 Bin Meng <bmeng.cn@gmail.com>, Weiwei Li <liwei1518@gmail.com>,
 Klaus Jensen <its@irrelevant.dk>,
 Jean-Christophe Dubois <jcd@tribudubois.net>,
 Jason Wang <jasowang@redhat.com>
References: <20240910221606.1817478-1-pierrick.bouvier@linaro.org>
 <20240910221606.1817478-2-pierrick.bouvier@linaro.org>
 <zkyoryho5alnyirnl7ulvh5y6tkty6koccgeygmve42uml7glu@37rkdodtlx4f>
 <bwo43ms2wi6vbeqhlc7qjwmw5jyt2btxvpph3lqn7tfol4srjf@77yusngzs6wh>
 <10d6d67a-32f6-40fc-aba9-c62a74d9d98d@maciej.szmigiero.name>
 <20240911125126.GS1450@redhat.com>
 <6818337d-ba58-4051-8105-05f679f71b88@linaro.org>
Content-Language: en-US
From: Richard Henderson <richard.henderson@linaro.org>
In-Reply-To: <6818337d-ba58-4051-8105-05f679f71b88@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=2001:4860:4864:20::33;
 envelope-from=richard.henderson@linaro.org; helo=mail-oa1-x33.google.com
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

On 9/11/24 08:25, Pierrick Bouvier wrote:
> On 9/11/24 05:51, Richard W.M. Jones wrote:
>> Although it's unlikely to be used on any compiler that can also
>> compile qemu, there is a third implementation of g_assert_not_reached
>> that does nothing, see:
>>
>> https://gitlab.gnome.org/GNOME/glib/-/blob/927683ebd94eb66c0d7868b77863f57ce9c5bc76/ 
>> glib/gtestutils.h#L269
>>
>> Rich.
>>
> 
> Interesting.
> At least gcc, clang and msvc are covered, this should be ok for most of the builds.

All of that is inside #ifdef G_DISABLE_ASSERT, which we will never set.


r~

