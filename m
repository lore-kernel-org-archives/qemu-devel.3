Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41521CA1009
	for <qemu-devel@archiver.kernel.org>; Tue,  2 Sep 2025 13:05:29 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1utQfe-00037E-5n; Tue, 02 Sep 2025 09:03:34 -0400
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1utQfa-00036m-Qo
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:03:30 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <clg@redhat.com>) id 1utQfS-0003JU-TC
 for qemu-devel@nongnu.org; Tue, 02 Sep 2025 09:03:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1756818193;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=oVQIU7Yab6wFvHp6gQIBVuParFRUA85qIcwdW39GhUI=;
 b=JTKAYlAA+cnDQc96P8vs0FLN6O4FXNxNQr55FicR1YaqH4YYaOU6P9OOIVGAVN7PeaWDYL
 X6pwQx099AcaVh8yySLDB/kgZkHV2upARQH78QtF4YHs9tgZbamzF6a5cmvH5DbkhcVwSW
 ytj+K5CK7OGoyYx8WX15FJyra0PYcVs=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-P8I22D-kOk-4NnpYob2J4g-1; Tue, 02 Sep 2025 09:03:10 -0400
X-MC-Unique: P8I22D-kOk-4NnpYob2J4g-1
X-Mimecast-MFC-AGG-ID: P8I22D-kOk-4NnpYob2J4g_1756818190
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-45b8a2b9fcaso18666125e9.0
 for <qemu-devel@nongnu.org>; Tue, 02 Sep 2025 06:03:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1756818189; x=1757422989;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=oVQIU7Yab6wFvHp6gQIBVuParFRUA85qIcwdW39GhUI=;
 b=Xx89dNV1YX8JTuNkscRf+PWZJRILQifJ/RGFMyfs7toa5bdJ4IrCeJ2JkYZ9adKX0U
 22ZqjNhgRECCwUpD+TC7MtXG8yZ3xBCZcjyVOnSda260Nk3znfibYIHR9aSClvxbk3fY
 XumDuJj5GuPm+nxFR4LsTi2F9UokOvRE0dfBK0n+f0u24h/QDfJkTTSDgNkkeguXYCOe
 rBc2dRUAbo7E9FOIzRdLxtm5tXzfefWZMx0SwR09RRox/fUxT1ZSQAQRdjaDWaeiSiFq
 MUYOtK7YKAVq+NX5O1Enn3NDXsGMzSgQgKXwcU+0nSBFw+z8Saf00UF4xRBzwzn//d8Y
 JBkA==
X-Gm-Message-State: AOJu0YwR5PfCEcpwrhSDki5kzoHveqPE4OuapT70B6xrEjFBFlNESowX
 6bp9131dla1yfzWkYDENR9HvtUplbeI1T8DImDRZzWlwhT6BhkX2dTNAeQ6WjFEghmLPFwEBUGf
 MtZO+uGSODtkbZUKJK7EsISCwExaKFBXbY6Zrw3ZKrA7FnOkvnPDlWW9O
X-Gm-Gg: ASbGncsLV9duiEixm/DfoV+xyh0r1gkS2x8+DCHvfbvgcmOsV2V1AOKGdmhSbFLr3om
 muOSd3CZsrUJ8WAvgTe65xFkv96BUAelyeQ9oiGFe36IMZvkEb58G7HMjPMHZVr7Xsv+NKd+4H4
 L32fJhvngnOzw7Tz6Fh7JljK408rYUJaATUTHLEhNFvjyPxgxZy7McmzU79/+9MlfSkub3Sj4u4
 tDffcU+Ym5l/ZD8GmAa5AgVzlDXQO45YkHuqTFQS6tgmDUCVVHIHkFPdYzKa4Ss9Fa5vRm4nVY2
 IEjsLOPTJ0w41Ys/dCWKuLQdPFIRVy4Rkdx+DUumNA1I84BBwAs4ieju+ZEgg2B9DzVg0vGSy7L
 o0HQ=
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id
 5b1f17b1804b1-45b87bf56e3mr94451395e9.9.1756818189640; 
 Tue, 02 Sep 2025 06:03:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFnZITDHExdjkUmALhnFZmYxIZlVghmMpc6oC+UEkYdN4SBG8n8Dz8mBweldbH8wqBYpNG4lg==
X-Received: by 2002:a05:600c:4f0b:b0:459:d821:a45b with SMTP id
 5b1f17b1804b1-45b87bf56e3mr94450645e9.9.1756818188951; 
 Tue, 02 Sep 2025 06:03:08 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:280:24f0:576b:abc6:6396:ed4a?
 ([2a01:e0a:280:24f0:576b:abc6:6396:ed4a])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-45b74950639sm248369605e9.17.2025.09.02.06.03.06
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 02 Sep 2025 06:03:07 -0700 (PDT)
Message-ID: <35efa228-cfdd-4105-9939-ad23c7692afd@redhat.com>
Date: Tue, 2 Sep 2025 15:03:06 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 0/3] vfio-user client functional test
To: John Levon <john.levon@nutanix.com>
Cc: qemu-devel@nongnu.org, Zhao Liu <zhao1.liu@intel.com>,
 =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 Thomas Huth <thuth@redhat.com>, =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?=
 <philmd@linaro.org>, Paolo Bonzini <pbonzini@redhat.com>,
 Thanos Makatos <thanos.makatos@nutanix.com>
References: <20250828100555.1893504-1-john.levon@nutanix.com>
 <0d030541-e533-489f-bc0c-82ee2c7fcd70@redhat.com> <aLa6297F4kdr2qYH@lent>
From: =?UTF-8?Q?C=C3=A9dric_Le_Goater?= <clg@redhat.com>
Content-Language: en-US, fr
Autocrypt: addr=clg@redhat.com; keydata=
 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
 uVKe8BVz4atMOoktmt0GWTOC8P4=
In-Reply-To: <aLa6297F4kdr2qYH@lent>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=clg@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -19
X-Spam_score: -2.0
X-Spam_bar: --
X-Spam_report: (-2.0 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H5=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_CERTIFIED_BLOCKED=0.001, RCVD_IN_VALIDITY_RPBL_BLOCKED=0.001,
 SPF_HELO_PASS=-0.001, TRACKER_ID=0.1,
 T_SPF_TEMPERROR=0.01 autolearn=ham autolearn_force=no
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

On 9/2/25 11:37, John Levon wrote:
> On Tue, Sep 02, 2025 at 11:25:46AM +0200, Cédric Le Goater wrote:
> 
>> On 8/28/25 12:05, John Levon wrote:
>>> Add a basic functional test for the vfio-user client, along with a couple of
>>> test framework extensions to support it.
>>>
>>> John Levon (2):
>>>     tests/functional: return output from cmd.py helpers
>>>     tests/functional: add vm param to cmd.py helpers
>>>
>>> Mark Cave-Ayland (1):
>>>     tests/functional: add a vfio-user smoke test
>>>
>>>    MAINTAINERS                                   |   1 +
>>>    tests/functional/qemu_test/cmd.py             |  65 ++-
>>>    tests/functional/x86_64/meson.build           |   1 +
>>>    .../x86_64/test_vfio_user_client.py           | 407 ++++++++++++++++++
>>>    4 files changed, 462 insertions(+), 12 deletions(-)
>>>    create mode 100755 tests/functional/x86_64/test_vfio_user_client.py
>>>
>>
>> The test is failing :
> 
> What is the parent commit you tried this with?

91589bcd9fee0e66b241d04e5f37cd4f218187a2

C.


