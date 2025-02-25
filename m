Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74817C021B2
	for <qemu-devel@archiver.kernel.org>; Tue, 25 Feb 2025 20:18:39 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1tn1Na-0004wc-UJ; Tue, 25 Feb 2025 15:18:10 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn1NY-0004w0-Lb
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:18:08 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <thuth@redhat.com>) id 1tn1NW-0006p3-Sl
 for qemu-devel@nongnu.org; Tue, 25 Feb 2025 15:18:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1740514686;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=OinJVIUgxTpln0CJ8IN/ntRUCumf/6Jc8gocNXQpi80=;
 b=IKiEHUNzq76ppBQkCRupm2ZKaG6Xcjxc995vu01I84MgLnauvo9Im16RKvYaoOahqVIGGk
 d1lA5zL7HwcO57uxyVsPkA6cVroRvP/McVfemvRFyphb36mw9B+TWN0E6onPC0xTLnRxES
 vq0zZzOqwNq12Y5GCPgVt9RyonST4kc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-336-PZHm3114MkamZ8x4YkFRkg-1; Tue, 25 Feb 2025 15:18:03 -0500
X-MC-Unique: PZHm3114MkamZ8x4YkFRkg-1
X-Mimecast-MFC-AGG-ID: PZHm3114MkamZ8x4YkFRkg_1740514682
Received: by mail-wr1-f70.google.com with SMTP id
 ffacd0b85a97d-38f2ef5f0dbso2235537f8f.2
 for <qemu-devel@nongnu.org>; Tue, 25 Feb 2025 12:18:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1740514682; x=1741119482;
 h=content-transfer-encoding:in-reply-to:autocrypt:content-language
 :from:references:cc:to:subject:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=OinJVIUgxTpln0CJ8IN/ntRUCumf/6Jc8gocNXQpi80=;
 b=jfMFoinPNA/LQRDZu7/l8DujATjXNXR4J2ud8c3sIK4fdej2rYQ8GiBH1aHhPs+rkF
 vsUnOXb+uTq1gYBadHD4nWiD6MfNWRuIKeNNttCry3QmqoAod33cCJ/QvNbDI1v9u+Ek
 60xB3CZe+2qkg2bOBGkDNcxmK2jSmsr7aaLi/AFQhiPSBkCU/X1svAUtA+BPKFYxKOeL
 38fcgDBvNsrC105qip5Uycr35RNY9ERFrJOrrwoGmsB8faGqMweCglgg5EyKKX1bMfeE
 dimZplTimX6tIxTjRJFrokFvCw8mEWEZwuPoYilI0cyAVl5sqcZ+07k7IIHmzbd1YRgf
 3Asw==
X-Forwarded-Encrypted: i=1;
 AJvYcCW++udvInnOl+Wzd8hkxsyyKCPbRYdpCYABAkv+nmURmmF9ZrraVskWlOOKtjGXOsJzqIU6QJTmF2r+@nongnu.org
X-Gm-Message-State: AOJu0YzKOssH2r2eyWNLAigk0bMjaT4kGNLqj/Oz3WGDUTM0cFhTKosD
 AV/8d6PJiemGbUdPu32s+3ikftIRVuEVrxntwqff5sFoaITImATRZDf12UDISCTViHIA5pqkXYK
 /OtXHE1COwtqOWnK0G8WFSYZUN0ay1eVVbmnhydQtTImbIZsmY9dv
X-Gm-Gg: ASbGncvIWJ5qI1z7stMzjWTUTh+ac9qjARseXVjc2Ww78weuzJFBIYgnQD+SCbp3HdU
 GfeF48slKkzo9R9TsIbctf0hadiig8TW1Ddyp/4CEjPNddyhMssnf97SkkEwdhN26X8vnog3VOV
 qtfvoz9ukX3bIJUbIJjuYHqjOLfV7SfPB1XWfFvPmGYvnRphhdt+/AlyF6+h7PIVstJTNDTWhfx
 Ol+6BJOeAGb1wEpOAGA1i/eXeayHFr2J+y8+XXMaxij73yox2c1rk+0Z9Gy5+Zbk3PLdH2WnI/7
 SN5kOR4XAo/BnDV4I6/2+a6TLphS91U/uHo7/WRj6ugqv2E=
X-Received: by 2002:a5d:5587:0:b0:385:e1eb:a7af with SMTP id
 ffacd0b85a97d-390cc638c91mr3318738f8f.48.1740514681661; 
 Tue, 25 Feb 2025 12:18:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFeLbIq/SQDYMbILQNAXjPW9uyH6LWjD2PzUgmaAoQQK9SLG7cls9ukROOcLDaeGJLzVKVZtQ==
X-Received: by 2002:a5d:5587:0:b0:385:e1eb:a7af with SMTP id
 ffacd0b85a97d-390cc638c91mr3318721f8f.48.1740514681322; 
 Tue, 25 Feb 2025 12:18:01 -0800 (PST)
Received: from [192.168.0.7] (ip-109-42-49-245.web.vodafone.de.
 [109.42.49.245]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-390cd88300bsm3449946f8f.54.2025.02.25.12.17.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 25 Feb 2025 12:18:00 -0800 (PST)
Message-ID: <99ae1715-687d-4d29-88bf-fd7bad15b497@redhat.com>
Date: Tue, 25 Feb 2025 21:17:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] docs/about/removed-features: auto-generate a note for
 versioned machine types
To: =?UTF-8?Q?Daniel_P=2E_Berrang=C3=A9?= <berrange@redhat.com>,
 qemu-devel@nongnu.org
Cc: Eduardo Habkost <eduardo@habkost.net>,
 Marcel Apfelbaum <marcel.apfelbaum@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Zhao Liu <zhao1.liu@intel.com>,
 Yanan Wang <wangyanan55@huawei.com>,
 =?UTF-8?Q?Philippe_Mathieu-Daud=C3=A9?= <philmd@linaro.org>,
 Peter Maydell <peter.maydell@linaro.org>
References: <20250225200423.2350471-1-berrange@redhat.com>
 <20250225200423.2350471-4-berrange@redhat.com>
From: Thomas Huth <thuth@redhat.com>
Content-Language: en-US
Autocrypt: addr=thuth@redhat.com; keydata=
 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
In-Reply-To: <20250225200423.2350471-4-berrange@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Received-SPF: pass client-ip=170.10.133.124; envelope-from=thuth@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -24
X-Spam_score: -2.5
X-Spam_bar: --
X-Spam_report: (-2.5 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.443,
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

On 25/02/2025 21.04, Daniel P. Berrangé wrote:
> We remove versioned machine types on a fixed schedule. This allows us
> to auto-generate a paragraph in the removed-features.rst document that
> always has accurate version info.
> 
> Signed-off-by: Daniel P. Berrangé <berrange@redhat.com>
> ---
>   docs/about/removed-features.rst | 10 ++++++----
>   docs/conf.py                    |  2 ++
>   2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/docs/about/removed-features.rst b/docs/about/removed-features.rst
> index 156c0c253c..c120d9ff4f 100644
> --- a/docs/about/removed-features.rst
> +++ b/docs/about/removed-features.rst
> @@ -972,10 +972,12 @@ from Linux in 2021, and is not supported anymore by QEMU either.
>   System emulator machines
>   ------------------------
>   
> -Note: Versioned machine types that have been introduced in a QEMU version
> -that has initially been released more than 6 years before are considered
> -obsolete and will be removed without further notice in this document.
> -Please use newer machine types instead.
> +Versioned machine types (aarch64, arm, i386, m68k, ppc, ppc64, s390x, x86_64)
> +'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
> +
> +In accordance with our versioned machine type deprecation policy, all machine
> +types with version |VER_MACHINE_DELETION_VERSION|, or older, have been
> +removed.
>   
>   ``s390-virtio`` (removed in 2.6)
>   ''''''''''''''''''''''''''''''''
> diff --git a/docs/conf.py b/docs/conf.py
> index 421ece1024..8b567787ce 100644
> --- a/docs/conf.py
> +++ b/docs/conf.py
> @@ -130,6 +130,7 @@
>           minor += 1
>   
>   ver_machine_deprecation_version = "%d.%d.%d" % (major - 3, minor, micro)
> +ver_machine_deletion_version = "%d.%d.%d" % (major - 6, minor, micro)

As in the previous patch, I think micro=0 would be better here.

  Thomas


