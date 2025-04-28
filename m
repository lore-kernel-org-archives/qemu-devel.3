Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9B88C369D5
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Apr 2025 14:02:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1u9P3k-0007Iq-26; Mon, 28 Apr 2025 10:02:12 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9P3i-0007ID-2B
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:02:10 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1u9P3g-0004Cq-Ax
 for qemu-devel@nongnu.org; Mon, 28 Apr 2025 10:02:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1745848927;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oVDaO+qTXn+ujDK2ncQx+yn7CcEGLmLQc2GUBGf+VUE=;
 b=hLu5jGe/F62Jjyv++HPR0olPUA8B6nVDMSJHbqiU0soNJYpksvn/L5Uvq+JeU4xrqLjTp5
 LjmuveMN6FJcLz2GCRV7HPma9bZcCl71DsPbnwp9RNdjPkypOVNDSMLm91Bx1EbP9XgMBI
 b3qYymt4yPudLVADIN2tbpXBgsvWieQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-244-LoVN3MlKPgO1L2dQgWlVOA-1; Mon, 28 Apr 2025 10:02:01 -0400
X-MC-Unique: LoVN3MlKPgO1L2dQgWlVOA-1
X-Mimecast-MFC-AGG-ID: LoVN3MlKPgO1L2dQgWlVOA_1745848921
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-acb98b5b0bdso433981266b.1
 for <qemu-devel@nongnu.org>; Mon, 28 Apr 2025 07:02:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1745848920; x=1746453720;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVDaO+qTXn+ujDK2ncQx+yn7CcEGLmLQc2GUBGf+VUE=;
 b=v4MSx7ivH9FOa7XNQOJOVVEAjY6TrB4tzbpyVDED3xcs0aRuU1/XpTZFNDVp90KY/y
 KKC97IOY43T4vWvOama8sUXn1CCHn8qukRVlaChJAbDnNzhuayF4QLFGKAv1ds+0lTi9
 KMT5mlDWxp/6ooSVKZ2kwtmCp6ouOBKXziuH1dEa4NKhitZBgsG40PB5iH1wBV1Fd5jb
 ZMlztvM82kgG+NlzZW+WNnkGYbAUsBcj7Mbx6lIG+gRPjXALqjJEq+x6KIwVPoI4caTD
 P+swUAhIBF88nF9rZduhfM7rAv52T+UGz9xZUN3Xff5JFgtsMYDWloJOSBhrxrsnW1qX
 5UTg==
X-Forwarded-Encrypted: i=1;
 AJvYcCWrJWj9eoPusS68NpTIDtrDVgSUFsxo+YaxM8XpMVcTygeN3iFPuch09sm5hD2ShC16JMkP08Zns2jh@nongnu.org
X-Gm-Message-State: AOJu0YzrBonjak2r7ECE+iRslnR31uc/MsB4RYCITNcdx2ltA0W1zx3p
 tFj/Xgtl/KpZxflatIfy+fO2nJOgiR31XiAquR4u9Gd6dEPUQ1t2Nb73rDDDLcTb5g1YpncxvNg
 0dp6ZFCYhCC/jTEQohe9EwjCAPT24crqIIkQNYaRq93aLxUABnuD3
X-Gm-Gg: ASbGncuyeNyVvth0mhiWeCpvNBZunGFjT0Vzl2yP00sDsDxATlALip6L41r/ulfxHu8
 j3yNZAeaRTwNQAPeZDQUVlVMbC/u1zsEqbgEH8Lqdr4Pi2nYMxKi9bqX8W/KuihoTHbWDUcxu5R
 DKtJKQf7gpubmZyFSWW93LEsTBpTNpE4r1eWKZ9CGRGyNXV1tHjIv10C6hgnwWbh2iQWtOXPnmm
 790cQYxN3QLglz21kH174/MJ86VQD6qjSX8OHUZywHtt+gLNW74NkNwrJ2mT9+5pdnUUqsj8t6P
 Vjhyf1vps3TrNmhOlOmEfr9Wfm7IJVZ23pMaSzwz4fp3Wg==
X-Received: by 2002:a17:907:3ea3:b0:ac1:ecb5:7207 with SMTP id
 a640c23a62f3a-ace7111e569mr1044832466b.29.1745848920373; 
 Mon, 28 Apr 2025 07:02:00 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHpQ2A59x4luIYuijd4eK/UCx5XlvMVMe+kGUR42Kos1u8T673GCTD3ZcRVKEoVz1ZeH1tQJw==
X-Received: by 2002:a17:907:3ea3:b0:ac1:ecb5:7207 with SMTP id
 a640c23a62f3a-ace7111e569mr1044825466b.29.1745848919721; 
 Mon, 28 Apr 2025 07:01:59 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-43-178-177.web.vodafone.de.
 [109.43.178.177]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ace6edafec7sm626447466b.165.2025.04.28.07.01.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Apr 2025 07:01:59 -0700 (PDT)
Message-ID: <294fd9b9-6880-477f-a2b4-773f1e5274c8@redhat.com>
Date: Mon, 28 Apr 2025 16:01:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/9] gitlab: disable debug info on CI builds
To: =?UTF-8?Q?Alex_Benn=C3=A9e?= <alex.bennee@linaro.org>,
 qemu-devel@nongnu.org
Cc: Alexandre Iooss <erdnaxe@crans.org>, "Michael S. Tsirkin"
 <mst@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 David Hildenbrand <david@redhat.com>,
 Pierrick Bouvier <pierrick.bouvier@linaro.org>, qemu-arm@nongnu.org,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Xu <peterx@redhat.com>, Peter Maydell <peter.maydell@linaro.org>,
 Mahmoud Mandour <ma.mandourr@gmail.com>
References: <20250428125918.449346-1-alex.bennee@linaro.org>
 <20250428125918.449346-3-alex.bennee@linaro.org>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250428125918.449346-3-alex.bennee@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -25
X-Spam_score: -2.6
X-Spam_bar: --
X-Spam_report: (-2.6 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.484,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
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

On 28/04/2025 14.59, Alex Bennée wrote:
> Our default build enables debug info which adds hugely to the size of
> the builds as well as the size of cached objects. Disable debug info
> across the board to save space and reduce pressure on the CI system.
> We still have a number of builds which explicitly enable debug and
> related extra asserts like --enable-debug-tcg.
> 
> Signed-off-by: Alex Bennée <alex.bennee@linaro.org>
> ---
>   .gitlab-ci.d/buildtest-template.yml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.gitlab-ci.d/buildtest-template.yml b/.gitlab-ci.d/buildtest-template.yml
> index d4f145fdb5..d9e69c3237 100644
> --- a/.gitlab-ci.d/buildtest-template.yml
> +++ b/.gitlab-ci.d/buildtest-template.yml
> @@ -24,6 +24,7 @@
>       - ccache --zero-stats
>       - section_start configure "Running configure"
>       - ../configure --enable-werror --disable-docs --enable-fdt=system
> +          --disable-debug-info

Do we have any jobs that might show stack traces in the console output ? 
build-oss-fuzz comes to my mind, but that uses a separate script, so we 
should be fine there?

So assuming there are no other jobs around that might need it:

Reviewed-by: Thomas Huth <thuth@redhat.com>


