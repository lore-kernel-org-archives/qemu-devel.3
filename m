Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists1p.gnu.org (lists1p.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9FB5C982E1
	for <qemu-devel@archiver.kernel.org>; Mon, 21 Sep 2026 08:15:13 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists1p.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1x8ZAp-0006SF-DJ; Mon, 21 Sep 2026 04:14:53 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists1p.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8ZAZ-0006R6-Bn
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 04:14:38 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1x8ZAW-0000mG-UI
 for qemu-devel@nongnu.org; Mon, 21 Sep 2026 04:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1789978471;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=Xo08G/VkCZYraEuYnKrmTxachj9LDupxEFwZY0i9+lI=;
 b=VaAYrLmhPthM2TUBk71TdJrtVQ7CmkK+aD2LH1YNxh7Fdo/Avm3RH84pKw9RtptEFFLUj3
 rjPqeOP02fNkU6k2MdEb6FEgmhy3et9L3zcL/5rcuTEUtytF3WF8TnpRIBomklQ3S4XTrW
 m8g/PZccNDA4hhtV0sWu+oejYjEz1gQ=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-654-tfzH79O0PYqIqRfe9ee1nA-1; Mon, 21 Sep 2026 04:14:30 -0400
X-MC-Unique: tfzH79O0PYqIqRfe9ee1nA-1
X-Mimecast-MFC-AGG-ID: tfzH79O0PYqIqRfe9ee1nA_1789978469
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-49e823c4868so21472975e9.0
 for <qemu-devel@nongnu.org>; Mon, 21 Sep 2026 01:14:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1789978469; x=1790583269; darn=nongnu.org;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Xo08G/VkCZYraEuYnKrmTxachj9LDupxEFwZY0i9+lI=;
 b=RvyM3C2ysh1l6z9P2I79yc1ZxHy9Rx0aa/32X6w4B6wXFmSFl89gWGWKpP+OEicqCQ
 F82CJ9E+p3kqKfE4lYTHVil8RvavMwdnad14sqwdky2DuzNCc6bCWMqXAZ7fyR4KgYeZ
 mDB2qjlKY5XCCo+9kgpjwdEhKoQ7KONl5+E8WBJqilHNHD0ZvFyfKMXerH13KS+0lP8F
 QEhXrHC18llYQfN/dvu2wWYpDQSr3gmBBg0Mddg1x8hv8vMEjsVOqBZ1aDHMbXsYvVy1
 TngpidmxLCe1RATK1eD09MV0v/2tExSw3cKnVe4D+3RQSyWw7aVQ9und5xkooVy0+pV0
 +EGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789978469; x=1790583269;
 h=content-transfer-encoding:content-type:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Xo08G/VkCZYraEuYnKrmTxachj9LDupxEFwZY0i9+lI=;
 b=CaNWDZUgtlu02CCq0UW99t8O3nWIJwPXtJmb8KAN+xWv8XWDv16L+Wocr+Jkw0ikZg
 iaQ53TXgoMsqHEJ/YdralO2LuuaxiEGRK2jT4urAVmCFMF1i9w+s+/FRp6OSz9sbTi7n
 RoGH6z5PCoaX84TdEGwlrLsFKcV3iqtYbMRga2zuTwq2oOgonJLdtvsc8poZ+T1XfdtB
 3LtbVS/99dZgrHTxQspg5JQ6XfzHb5UD4FbKSM4WlwnIGV5ZVpPzddNLXcAMRxpspWw9
 aJaDxkiWItNj5+1nQgoBqWswMLMuTQfphyPdRbfaVr5b4/7efyarNmiorpzyCVhKsjSI
 /ZEw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwYhD51iPYsYpR4TuJxU72lRPwGZInOPnQNv273CPzkv5q1skbr9moJZi6jQXgq36P2W/VUEbPYlqTG@nongnu.org
X-Gm-Message-State: AFuF++kNMYo2iB7+C4rvN9SXCnhyB3llK9nbrHy4VdrPtpL1KbC8OE4m
 26JcCj7UFgEXFlcaf2rv141u64ptGcCnpywKpPlPq+k4jr2x18dDSi7PcZVxIc6dE7qHtuS5A7Y
 rnx015JXFWI02jRFLa4a96C97uBAVwmFHmgaNNqYNugN1HOvMnNgfkZUs
X-Gm-Gg: AYBFou14gSqs0ta+BCg/Q15t8nFtbfKrEk6BcuvvhB1F0i11hNqxUe3ZcUWNg1QBzPx
 QBCZkOC6OWqceNzNO8CqSG832vZQR7S17Vfsg8VYKSIonsWcJKkovC74g0WEmjnIwS4tWL6juvL
 okc1qCff2SMQ0vTaOZcxCkwjbkvJ/sNykovNEGgnzJp0h34AWPHrRWes4rHvtFjVWigkGEScRxA
 vq/uiaGDLYhHSFdBt6OpFiRoPjdY2pPp9kAEWLttDMxC32VksGFXvqkTmciYOc4eaRSUatuMYGt
 DOmyG8e5nONTjg/GI2V1LtmOKm1Hc5fyuCPn3qPtMt0h2oyc+PKeBHvTYu2bU0zUSADXgJw7cw=
 =
X-Received: by 2002:a05:600c:3150:b0:49f:ce78:3561 with SMTP id
 5b1f17b1804b1-49fce783619mr78072255e9.18.1789978468773; 
 Mon, 21 Sep 2026 01:14:28 -0700 (PDT)
X-Received: by 2002:a05:600c:3150:b0:49f:ce78:3561 with SMTP id
 5b1f17b1804b1-49fce783619mr78072035e9.18.1789978468419; 
 Mon, 21 Sep 2026 01:14:28 -0700 (PDT)
Received: from [192.168.0.9] ([47.64.112.181])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49fcd10d174sm221845435e9.11.2026.09.21.01.14.26
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Sep 2026 01:14:27 -0700 (PDT)
Message-ID: <bfd8f1e2-5790-40ee-a312-e221d81b55f6@redhat.com>
Date: Mon, 21 Sep 2026 10:14:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/2] tests/functional/ppc64: extend pseries migration
 tests
To: Aniket Sahu <asahu1x@linux.ibm.com>, qemu-devel@nongnu.org,
 qemu-ppc@nongnu.org
Cc: peterx@redhat.com, farosas@suse.de, npiggin@gmail.com,
 adityag@linux.ibm.com, milesg@linux.ibm.com, harshpb@linux.ibm.com,
 rathc@linux.ibm.com, anushree.mathur@linux.ibm.com, misanjum@linux.ibm.com,
 gautam@linux.ibm.com, amachhiw@linux.ibm.com
References: <20260921081010.31778-1-asahu1x@linux.ibm.com>
 <20260921081010.31778-2-asahu1x@linux.ibm.com>
Content-Language: en-US
From: Thomas Huth <thuth@redhat.com>
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20260921081010.31778-2-asahu1x@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H3=-0.01, RCVD_IN_MSPIKE_WL=-0.01,
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

On 21/09/2026 10.10, Aniket Sahu wrote:
> The existing test_migration.py exercises all three migration transport
> paths (TCP, UNIX, exec) but only against the mac99 machine type.
> A regression in pseries-specific vmstate save/restore handlers would
> not be caught by migrating a mac99 guest.
> 
> Switch the UNIX socket and exec (socat) migration tests from mac99 to
> pseries so that these transport paths are exercised against the pseries
> vmstate.  The TCP test is left on mac99 since pseries TCP migration is
> already covered by test_ppc64_linux_migration in test_pseries.py.
> 
> Signed-off-by: Aniket Sahu <asahu1x@linux.ibm.com>
> ---
>   tests/functional/ppc64/test_migration.py | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/tests/functional/ppc64/test_migration.py b/tests/functional/ppc64/test_migration.py
> index 7d49ee175b..e1d51551b8 100755
> --- a/tests/functional/ppc64/test_migration.py
> +++ b/tests/functional/ppc64/test_migration.py
> @@ -15,11 +15,11 @@ def test_migration_with_tcp_localhost(self):
>           self.migration_with_tcp_localhost()
>   
>       def test_migration_with_unix(self):
> -        self.set_machine('mac99')
> +        self.set_machine('pseries')
>           self.migration_with_unix()
>   
>       def test_migration_with_exec(self):
> -        self.set_machine('mac99')
> +        self.set_machine('pseries')
>           self.migration_with_exec()
Reviewed-by: Thomas Huth <thuth@redhat.com>


