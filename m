Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 77A14C35FFA
	for <qemu-devel@archiver.kernel.org>; Wed, 19 Mar 2025 09:38:51 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tuprm-0003V1-2w; Wed, 19 Mar 2025 05:37:38 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tuprg-0003T2-0K
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 05:37:32 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tupre-0001oD-2M
 for qemu-devel@nongnu.org; Wed, 19 Mar 2025 05:37:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1742377045;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=WianHyIFejyTIrnc7tnn6xgTKeM/Vg+0tvGeuHSz4kU=;
 b=WIC0H28sooGiJeNF/cWDyr2xcdHgSpTTAjDW3Rk3FVWY316kCtJIDVFNM6Z/obRLwTEOZh
 Yz5KiUIggVzFQ/Vv9ArIdPjg3XrH4ZVdlnE8aYJqQOi3GVN2yhI8gGMhJ6LeVGo1EL6Oq5
 90i4qZBaKmdhnNlyIKVJP4aG76nK9V4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-lbUsks7kPjuDFgcgjPjJKQ-1; Wed, 19 Mar 2025 05:37:24 -0400
X-MC-Unique: lbUsks7kPjuDFgcgjPjJKQ-1
X-Mimecast-MFC-AGG-ID: lbUsks7kPjuDFgcgjPjJKQ_1742377043
Received: by mail-ej1-f71.google.com with SMTP id
 a640c23a62f3a-ac3a9c3a8f7so116651766b.1
 for <qemu-devel@nongnu.org>; Wed, 19 Mar 2025 02:37:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1742377043; x=1742981843;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=WianHyIFejyTIrnc7tnn6xgTKeM/Vg+0tvGeuHSz4kU=;
 b=sYn/A/5YHyhPz8Rzm+vn1ZZEw3yVjlGeVKQWlS5sZhL5k7GvrDbgv4mjm8DISqEPLo
 /86L8YpUXEcTlDwlCWdMzUZ/Q07uN8793eiTnVGPUll1SDcUosMuOii+j5Pvrg1Sc2U7
 dD9PB91gRa0qEcR1e0sP5mTAv3u8K7HolA/uw000mq/BGh6+YkuPVmQNwmXlMLYtGe7o
 8avc631UYryiIrF6BVgpvUrZRSonOdFUkg9selDxc77yo4LPNlaRaK+C/9vJbrsqtNl5
 UgIS+j8Pi2etV/wGJpLO535oPaDZY/62b9RiCg2DRzA9hDAg1qGylcpFTpGzfaAOaI8L
 LoYQ==
X-Forwarded-Encrypted: i=1;
 AJvYcCUszbC2gHKaOvWFdCNqNJp+9xs3cBT8dC+4yPpkx8fwGRjiC/wJOc9BjR7Nex1K8D3E5gh9oUW0Chl3@nongnu.org
X-Gm-Message-State: AOJu0Yxt0MWj+2Nk13QXFS70c14dR12HTcyzaoAIgMX2kek3OI15K+ko
 hlwMpd1MjAUjDwmQNfRyKQ14VNRZmFVw/tkoPTbo4e29TDmvJ2NCm3WmPVPSe+IVWxS8w/VkJa2
 M73/LrWTw/fobhyHUnuZ0KPYkTVtRUIbcjILNNg3oqGXPLlh/wSYf
X-Gm-Gg: ASbGncuJpK9F+XemR9ZOXs58iGVSK7dd1Bqx8FORQ0k5yl5CQITZ00cAwddSnr/Wrfr
 xmi+hZRBFwvoQMh4NdQ+IIOuvGLvznL7dlsNc14AqgNiYIuHb5J4b3tXmyZbLs3TqNpX4W2U8eE
 6Z3s/pPJIj4NibgxN1E9gjkLg4epjQYEn7l121eiDiw0bGpoyEqzzzscETwqp1xmpy9+vZGSVan
 WoE9EWVS3F7LOs9WGJp4M3GtPgyQ3xDuV+jWlWB8c/VBzSRCfHxlWA8r3xvn0zoaCcZBQad2GoL
 JqegxP5lVKvFpNOjHjBGls75/v40VtmoAWk2HmzUWw==
X-Received: by 2002:a17:907:2d25:b0:ac2:9e1a:bf81 with SMTP id
 a640c23a62f3a-ac3b7d7c57dmr168000566b.21.1742377042833; 
 Wed, 19 Mar 2025 02:37:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEO+uK6I4UgnQV6u/He3lzlGOm+N9c6FGuGOq3OFRMH205/SWjRTtnZqnP89nkc2nq5lav0+Q==
X-Received: by 2002:a17:907:2d25:b0:ac2:9e1a:bf81 with SMTP id
 a640c23a62f3a-ac3b7d7c57dmr167998766b.21.1742377042358; 
 Wed, 19 Mar 2025 02:37:22 -0700 (PDT)
Received: from [192.168.0.7] (ip-109-42-50-2.web.vodafone.de. [109.42.50.2])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-ac32c6de6ecsm886138366b.173.2025.03.19.02.37.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 Mar 2025 02:37:21 -0700 (PDT)
Message-ID: <6220a804-0442-4270-8326-b4573d68c9db@redhat.com>
Date: Wed, 19 Mar 2025 10:37:20 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: test_migration.py not working with netcat-traditional
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>
Cc: Matheus Tavares Bernardino <quic_mathbern@quicinc.com>,
 qemu-devel@nongnu.org, farosas@suse.de, philmd@redhat.com,
 bcain@quicinc.com, quic_mliebel@quicinc.com
References: <85909195b99964081ae01d9999384cc3b7a3fada.1742331648.git.quic_mathbern@quicinc.com>
 <8b749710-a5bf-4da9-a6af-160ccb0bbcc5@redhat.com>
 <Z9qGwgEvRHJQt1rJ@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <Z9qGwgEvRHJQt1rJ@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -23
X-Spam_score: -2.4
X-Spam_bar: --
X-Spam_report: (-2.4 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.332,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H2=0.001,
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

On 19/03/2025 09.57, Daniel P. Berrangé wrote:
> On Wed, Mar 19, 2025 at 08:49:53AM +0100, Thomas Huth wrote:
>> On 18/03/2025 22.13, Matheus Tavares Bernardino wrote:
>>> Hi,
>>>
>>> tests/functional/test_migration.py says "The test works for both
>>> netcat-traditional and netcat-openbsd packages." But when I run it for
>>> qemu-system-aarch64 on an Ubuntu 22.04 container with netcat-traditional
>>> installed, I get the following error:
>>>
>>> TAP version 13
>>> Traceback (most recent call last):
>>>     File "/pwd/tests/functional/test_migration.py", line 97, in test_migration_with_exec
>>>       self.do_migrate(dest_uri, src_uri)
>>>     File "/pwd/tests/functional/test_migration.py", line 72, in do_migrate
>>>       self.assert_migration(source_vm, dest_vm)
>>>     File "/pwd/tests/functional/test_migration.py", line 40, in assert_migration
>>>       self.assertEqual(src_vm.cmd('query-migrate')['status'], 'completed')
>>> AssertionError: 'failed' != 'completed'
>>> - failed
>>> + completed
>>>
>>> not ok 1 test_migration.MigrationTest.test_migration_with_exec
>>> ok 2 test_migration.MigrationTest.test_migration_with_tcp_localhost
>>> ok 3 test_migration.MigrationTest.test_migration_with_unix
>>> 1..3
>>>
>>> With netcat-openbsd (the default), it runs fine. Perhaps the test is no
>>> longer compatible with netcat-traditional?
>>>
>>> QEMU was configured and built with:
>>> ../configure --without-default-features --target-list=aarch64-softmmu
>>
>> For me it works with both flavors of "nc", the ncat and the netcat one...
>> but I'm also running on Fedora.
> 
> There are three flavour os 'nc' - the traditional netcat, openbsd netcat
> and nmap netcat.

Oh, there is even a third one? ... TIL, I wasn't aware of that yet.

> IMHO rather than debug differences in these, we'd be better off just
> rewriting the test to use socat so we have 1 single impl to think about
> instead of 3.

That's a good idea. Alternatively we could also limit the test to "ncat", 
AFAICT that name is not used by the other twos, is it?

  Thomas


