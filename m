Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B036BC3ABCC
	for <qemu-devel@archiver.kernel.org>; Wed, 14 May 2025 10:56:43 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1uF9m2-0000dK-Ph; Wed, 14 May 2025 06:55:42 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uF9lt-0000Ro-UI
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:55:35 -0400
Received: from anarch128.org ([2001:4801:7825:104:be76:4eff:fe10:52ae])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <michael@anarch128.org>)
 id 1uF9ls-00072x-9G
 for qemu-devel@nongnu.org; Wed, 14 May 2025 06:55:33 -0400
Received: from [192.168.1.4] (dynamic-cpe-pool.orcon.net.nz [121.99.116.25]
 (may be forged)) (authenticated bits=0)
 by anarch128.org (8.15.2/8.15.2/Debian-22+deb11u3) with ESMTPSA id
 54EAtLaL1197372
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
 Wed, 14 May 2025 10:55:24 GMT
Authentication-Results: anarch128.org; auth=pass;
 dkim=pass (2048-bit rsa key sha256) header.d=anarch128.org
 header.i=@anarch128.org header.b=kdfT4QXn header.a=rsa-sha256 header.s=100003;
 x-return-mx=pass header.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org); 
 x-return-mx=pass smtp.domain=anarch128.org policy.is_org=yes (MX Records
 found: mail.anarch128.org)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=anarch128.org;
 s=100003; t=1747220126;
 bh=ducN0SIjp2rZ3Qy32F6bgqVAqUmOsH/lGlc4DSjN3+Q=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=kdfT4QXnJ1foT6Sni2w5rnB7OqDqSi3pmCYXRyYD/6zdKQds9dVOxh5FGsUeuL1dm
 QX5cm+3CUSPe2KmLymFWpwZOULSiTaXdviKvtffk/H0Fhg1Bx1fTfEwGY4uNLphz+6
 8M3AI613sMdGZZP8BTm4reecH+N4SAjiy7W5CWVr96lmR/uthYI2mh38mBGNfOpiWc
 L0pQB1x7kenSIWwFbevdR2dQMPRTzGXmmd8sbzB39Q7huzOs1ILcPdkrg+wB3ThSDi
 W/1jxP2k7TgImYChvpJBAjGYrMIjqWYhip7Lt64jbdLDLCytZHJn0qoftjOgKawNfi
 hUOja+Tf4UG+A==
Message-ID: <b7c26314-0167-4cbe-a838-8e8f3a8b6acc@anarch128.org>
Date: Wed, 14 May 2025 22:55:16 +1200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] x86-disas: add x86-mini disassembler implementation
To: =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 qemu-devel@nongnu.org, Richard Henderson <richard.henderson@linaro.org>,
 Eduardo Habkost <eduardo@habkost.net>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhao Liu <zhao1.liu@intel.com>
References: <20250514073927.2735727-1-michael@anarch128.org>
 <20250514073927.2735727-5-michael@anarch128.org>
 <1cf86288-8dc0-45b0-a3b8-ba3fce1db8bf@linaro.org>
Content-Language: en-US
From: Michael Clark <michael@anarch128.org>
In-Reply-To: <1cf86288-8dc0-45b0-a3b8-ba3fce1db8bf@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=2001:4801:7825:104:be76:4eff:fe10:52ae;
 envelope-from=michael@anarch128.org; helo=anarch128.org
X-Spam_score_int: -16
X-Spam_score: -1.7
X-Spam_bar: -
X-Spam_report: (-1.7 / 5.0 requ) BAYES_00=-1.9, DKIM_INVALID=0.1,
 DKIM_SIGNED=0.1, SPF_HELO_PASS=-0.001,
 SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 5/14/25 22:25, Philippe Mathieu-Daudé wrote:
> Hi Michael,
> 
> Minor comments inline.
> 
> On 14/5/25 09:39, Michael Clark wrote:

[snipped]

>> +
>> +static void x86_print_row(size_t count, x86_table_col *cols)
>> +{
>> +    printf("|");
>> +    for (size_t i = 0; i < count; i++) {
>> +        printf(" %-*s |", cols[i].width, cols[i].data);
>> +        g_free(cols[i].data);
>> +    }
>> +    printf("\n");
> 
> Shouldn't we use info->fprintf_func() in disas/ ?

this could be dead code which I could possibly remove from the patch.
the upstream has a metadata table tool that prints out metadata. an
alternative approach is to add the metadata table tools as utilities.

>> +}
> 
> const

the const changes all seem to make sense.


