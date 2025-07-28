Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 87A15C83F17
	for <qemu-devel@archiver.kernel.org>; Mon, 28 Jul 2025 13:25:12 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1ugNq0-0001Gn-Cs; Mon, 28 Jul 2025 09:24:20 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugNPH-0004Qm-I3
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:56:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1ugNPF-0006Z2-Gy
 for qemu-devel@nongnu.org; Mon, 28 Jul 2025 08:56:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1753707399;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=GlSFz7iIDBDcM0HSFaJbuDtmgoPzXIw1wGlv6sltTos=;
 b=Zx3Vf45Sw3jvQsd5LF7eWIoFrK14VeyoBb6O9M7IZ+YvvFoFTnenpUNBemYKC271lRXcWw
 1xxFgN6a18aokt+E2djOe6FbuYY0GjAaSur4IDCgrUQbRXCP1GRGeH5ja0Zbhk4kM+HO0j
 J5FBESZ7tkZZo3fFfZrqWUW4ILaW+dA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-674-_mME__FqNO6-gL81fc1cjg-1; Mon, 28 Jul 2025 08:56:37 -0400
X-MC-Unique: _mME__FqNO6-gL81fc1cjg-1
X-Mimecast-MFC-AGG-ID: _mME__FqNO6-gL81fc1cjg_1753707396
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-3b7886bfc16so618409f8f.1
 for <qemu-devel@nongnu.org>; Mon, 28 Jul 2025 05:56:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1753707396; x=1754312196;
 h=content-transfer-encoding:in-reply-to:autocrypt:from
 :content-language:references:cc:to:subject:user-agent:mime-version
 :date:message-id:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GlSFz7iIDBDcM0HSFaJbuDtmgoPzXIw1wGlv6sltTos=;
 b=CLMshHNnioMtuRJ8VyResKyhUXTmViqVTXeFQ0Xs582Kaac8d754a26kShjExlaujh
 J3/AjHKK5S9o/PoL/IOS8G087jKszuLZzbNLFUnFFEpVN21HTgfxi37E2X3X2jjoDtsM
 JASMn38Iftjcoy6Bm2/bONBbi5KoC5A3LIWw3qUszlxTQoMg04pXnpczACWXfdVUs3my
 6n0AAAiBcMUntlmH0GfTHAMqSNoJWkq9E2DfX6gqbj4tjViT2Rlyf6WQsvLQcmPamHGD
 lM9lnmbrB8EHzLqvKnrVuUra7n9vEwCpWGIiI4inmzKSBFbMZTl1ZI+MKQECsts5RP8k
 JQPw==
X-Forwarded-Encrypted: i=1;
 AJvYcCWmmlmihV4E/USeoqv2Q2z3uG2aN5q2+LJsDcTeFlMhpVSQergxjKuR7Us9uhlKfNU78RE8iesm5Vl7@nongnu.org
X-Gm-Message-State: AOJu0YxesuY2nklYc64eA73f/hqtBdsYcK2PBSscEQPPlIOH+59AI/t1
 3F4D5oeQikMR2LIgAu3/tsXdVsdLavf/ysacC4Thy/h8knENSnbODxhqWIXqzAKHgNe1bX6aaRa
 GcUIGR7biM0oxdQ17Vz63/lolKBvxzgKvF17Ji8pt7vprABmIV2qsaIgx
X-Gm-Gg: ASbGnctZnCrRx8RdM1znq/+6bScA+zZRNJ3XJ9bECH2IFhIzg2NsDHuiIF+DeM5O1rt
 3nQv8tptbxxhZQy17iI50EsyYunOTbI74IEFQ4QCZMgcPC4uS5BcE2n3R0N7LGedDpvmhgnCYyp
 IX6JL9xJnxVGHy9VfDz28ENPWUOIYO6sevgF72hs9j+Nx+6WkLF5PtJlsDcBvCEXzKpVMDymIIq
 Q1/04/gOHUzAKYXg+8R1oXrr663sVn4scuyXUi9zw3CWQygDfxFIe2vbreqUEESv3IbDMGm4oJD
 XKlEnxRcIiWI6Lecfn33YP9NOpqIiLN6paWDkIrQBwpdscPATtCeAy55sBp1e8ImzZEVYdGrIjV
 n7Q==
X-Received: by 2002:a05:6000:4212:b0:3b7:8af8:b91d with SMTP id
 ffacd0b85a97d-3b78af8beefmr1599969f8f.35.1753707396036; 
 Mon, 28 Jul 2025 05:56:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGYQIx5qrK6DSQ5woQ+sUhRYZrxW18UqEZD9VwvD3u/dJVr8tQYW04SM8sUwUJ+Kqvn3uXpkQ==
X-Received: by 2002:a05:6000:4212:b0:3b7:8af8:b91d with SMTP id
 ffacd0b85a97d-3b78af8beefmr1599947f8f.35.1753707395565; 
 Mon, 28 Jul 2025 05:56:35 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-3b778f0c1b8sm8754092f8f.56.2025.07.28.05.56.34
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 28 Jul 2025 05:56:34 -0700 (PDT)
Message-ID: <1c4768ac-ba67-4a94-8137-02fc3167bc36@redhat.com>
Date: Mon, 28 Jul 2025 14:56:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] vfio/pci: Fix regression due to unexisting property
 use-legacy-x86-rom
To: "Duan, Zhenzhong" <zhenzhong.duan@intel.com>,
 "qemu-devel@nongnu.org" <qemu-devel@nongnu.org>
Cc: "alex.williamson@redhat.com" <alex.williamson@redhat.com>,
 "philmd@linaro.org" <philmd@linaro.org>,
 "wangyanan55@huawei.com" <wangyanan55@huawei.com>,
 "Liu, Zhao1" <zhao1.liu@intel.com>, "slp@redhat.com" <slp@redhat.com>,
 "pbonzini@redhat.com" <pbonzini@redhat.com>,
 "richard.henderson@linaro.org" <richard.henderson@linaro.org>,
 "mst@redhat.com" <mst@redhat.com>, "eduardo@habkost.net"
 <eduardo@habkost.net>,
 "marcel.apfelbaum@gmail.com" <marcel.apfelbaum@gmail.com>,
 "shahuang@redhat.com" <shahuang@redhat.com>,
 "Peng, Chao P" <chao.p.peng@intel.com>
References: <20250728122906.39703-1-zhenzhong.duan@intel.com>
 <424a42b6-5013-4b95-9d85-37d99ebdfe93@redhat.com>
 <IA3PR11MB9136873A48AC915500934D20925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Language: en-US, fr
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <IA3PR11MB9136873A48AC915500934D20925AA@IA3PR11MB9136.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -20
X-Spam_score: -2.1
X-Spam_bar: --
X-Spam_report: (-2.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=ham autolearn_force=no
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

On 7/28/25 14:53, Duan, Zhenzhong wrote:
> 
> 
>> -----Original Message-----
>> From: Cédric Le Goater <clg@redhat.com>
>> Subject: Re: [PATCH] vfio/pci: Fix regression due to unexisting property
>> use-legacy-x86-rom
>>
>> Hello Zhenzhong,
>>
>> On 7/28/25 14:29, Zhenzhong Duan wrote:
>>> TYPE_VFIO_PCI doesn't have property use-legacy-x86-rom, but
>>> TYPE_VFIO_PCI_NOHOTPLUG has. The compatibility config leads to
>>> SIGABRT on new QEMU.
>>>
>>> The default value of element use_legacy_x86_rom for TYPE_VFIO_PCI is
>>> already false, so no need extra processing.
>>>
>>> Fixes: d5fcf0d960d8 ("hw/i386: Add the ramfb romfile compatibility")
>>> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@intel.com>
>>
>>
>> Fix is here :
>>
>>
>> https://lore.kernel.org/qemu-devel/20250723062714.1245826-1-clg@redhat
>> .com/
> 
> Ah, thanks Cédric, good to see this, I should have checked vfio-next first.

I have been waiting a bit (too long) to send the fix upstream because
people were in vacations and I would like to possibly send Steve's
fixes too. I should send a PR today or tomorrow.


Thanks,

C.



