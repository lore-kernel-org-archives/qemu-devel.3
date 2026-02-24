Return-Path: <qemu-devel-bounces+qemu-devel=archiver.kernel.org@nongnu.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.gnu.org (lists.gnu.org [209.51.188.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61743F4BB63
	for <qemu-devel@archiver.kernel.org>; Tue, 24 Feb 2026 17:29:40 +0000 (UTC)
Received: from localhost ([::1] helo=lists1p.gnu.org)
	by lists.gnu.org with esmtp (Exim 4.90_1)
	(envelope-from <qemu-devel-bounces@nongnu.org>)
	id 1vuwDj-0001Q7-Pt; Tue, 24 Feb 2026 12:29:16 -0500
Received: from eggs.gnu.org ([2001:470:142:3::10])
 by lists.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuwDd-0001Oz-L7
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:29:10 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
 (Exim 4.90_1) (envelope-from <pbonzini@redhat.com>)
 id 1vuwDW-0001XR-Iu
 for qemu-devel@nongnu.org; Tue, 24 Feb 2026 12:29:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1771954135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=66/kj0p3LqDSHbvWB/4yLzeyq6l4dm9MLx1rsWxqgqQ=;
 b=Xl/QMr+OxknaMoMSJhRsxT16DzqN3hZO4fGt2eDtECAzR5KW6d4mb7DFesgP6oWMW+Id0N
 Xa37sP3DJESOvrPu8lmSyDPOxIar1scZxyT/MIU9Ihm3F6Ng5tEZWCw114PNVvMKGI4cHA
 MfY5S05ciGwsDjkl1de60NEUPqYoqfQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-223-kucCFmDBNMigf7gnGeRHTg-1; Tue, 24 Feb 2026 12:28:53 -0500
X-MC-Unique: kucCFmDBNMigf7gnGeRHTg-1
X-Mimecast-MFC-AGG-ID: kucCFmDBNMigf7gnGeRHTg_1771954132
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-48372facfedso317055e9.0
 for <qemu-devel@nongnu.org>; Tue, 24 Feb 2026 09:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=redhat.com; s=google; t=1771954132; x=1772558932; darn=nongnu.org;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :from:to:cc:subject:date:message-id:reply-to;
 bh=66/kj0p3LqDSHbvWB/4yLzeyq6l4dm9MLx1rsWxqgqQ=;
 b=mGj8zFN/eluW2CpafUlYqNJ21I8yHAiQjKCh6Tanu6mMFI4Kn7ezsBEEQr5JmdWZ+L
 Pqd7BcyRNvGvybcVDzCFjSZYb0vd7SbMHTI66c4kskmLNuWZ5xfgSvVSWdjIJEfKDGNd
 fLhkun34PYDAitPDQKBZcgjXygBBTDSernigUKM4lPYs1Hk0kGG5E0G6JzTELjMycnUW
 rgH53FPj7+R40uvJORKyBa9qtc2VTk0+ywzmqtFnnPhL/ovYDlbwtaV+p02fg2rcbtmF
 XhmBeqx/EuymLdD/jKD8FpHRtP/GVzYCdoGU02tgJBoGt/N/sUpaZ+AuNNFpqsqDx36X
 XfrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1771954132; x=1772558932;
 h=content-transfer-encoding:in-reply-to:content-language:from
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=66/kj0p3LqDSHbvWB/4yLzeyq6l4dm9MLx1rsWxqgqQ=;
 b=NC3ApDTht1cSQm1WITRjfe4lpUR/s1/DaQjGLOrRXZ7/F+EUECPzN3Z9KRfzH0BTpI
 2CZ2WDxahRyp7UYFBrdTj4S7ao/d2DQEeAx61id4bhhrTzmJyEc7Z8zhtPXF7/8dpwaF
 MOhsVBgdwtaNgyRkEPEMCkXnxzxaMTwt1AH3rkc4SuhofKo8tpIj0GvQFZEiqRfHVGLw
 zQLXVgyBlo+3RhvDHcFvCS5AzWBYZyFGcKmQJVBXKl6QsbxjyQWAkvt/ebaKLL02G8mB
 Cy3HSN7Q7VQi342/mIh5G0fNfikwRTiA2BBKo1hjFSHcd8zKs3EZ2jisFaK8rrAEx1yf
 8Qzg==
X-Gm-Message-State: AOJu0YxRSHKoOQJIgyLkteOwbFI0dsFh5dEtPIcs800OdAiuiwBsTLiA
 Mv0eZCCMMB2V29DE6+07UeLVvbbIDQboSBH2EhFTv/LXMAdyvVEqmShf8Kbh/2JsAY3T+pgryjQ
 dDe0+F01pXTHww97fvUYVroM1aXRCMLN+7Ij8LfPkEGGSpJi2dqr331Sy
X-Gm-Gg: AZuq6aL1benCOUvoFIKKxGaK9dDdkvlhJBflSGMvkc5vNvIrvCZ5WNmv1vjFnHskIG3
 Zy7NnbpPG2HiX82jhwtMNRB79BDJE9FU4O+5MoH16wNWJ7WFLpgHnyEuVSQsb1B34KSGlEPrYiC
 XNFJmbjqy+pTQtZ9UqBXLC3cL/X8VxjBxPRhuoXoLwgjZ/xaNGerKJGrTXcQ7afBAFs/6NUDKRk
 7YpBJqIYbJvnUYUu26N1txChct7YcvdMeTMkfQsbBuqzyw04qnD/e5KUhO/o8NYhSsAx3kRkGTP
 GUj4N4c57jGoz0gqq8+viu71pdONTG7SxiTO55ebiNZkbEEg0GQ7YoU3Fmkg6Yxyt2oQhWKGwOV
 O2WLneG9v+kyMHTVADWxozgLbgxyeiyT3N02K2sH3uDqrmLPvyyfnMGbHRPpfUWH6aDYlkyPqYl
 ekmpMqdiyn8+qfeSpoKxmhwh3qhQQ=
X-Received: by 2002:a05:600c:818d:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-483bd75e25fmr12197995e9.17.1771954131979; 
 Tue, 24 Feb 2026 09:28:51 -0800 (PST)
X-Received: by 2002:a05:600c:818d:b0:47d:6c36:a125 with SMTP id
 5b1f17b1804b1-483bd75e25fmr12197455e9.17.1771954131167; 
 Tue, 24 Feb 2026 09:28:51 -0800 (PST)
Received: from [192.168.10.81] ([151.95.144.138])
 by smtp.googlemail.com with ESMTPSA id
 5b1f17b1804b1-483bd68826asm22295365e9.0.2026.02.24.09.28.50
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Feb 2026 09:28:50 -0800 (PST)
Message-ID: <e9abc154-9219-4d7e-b711-0a68bfe62845@redhat.com>
Date: Tue, 24 Feb 2026 18:28:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/16] rust: QObject and QAPI bindings
To: Markus Armbruster <armbru@redhat.com>
Cc: qemu-devel@nongnu.org, =?UTF-8?Q?Marc-Andr=C3=A9_Lureau?=
 <marcandre.lureau@redhat.com>, qemu-rust@nongnu.org
References: <20260108131043.490084-1-pbonzini@redhat.com>
 <87tsv6z14w.fsf@pond.sub.org>
From: Paolo Bonzini <pbonzini@redhat.com>
Content-Language: en-US
In-Reply-To: <87tsv6z14w.fsf@pond.sub.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Received-SPF: pass client-ip=170.10.129.124; envelope-from=pbonzini@redhat.com;
 helo=us-smtp-delivery-124.mimecast.com
X-Spam_score_int: -10
X-Spam_score: -1.1
X-Spam_bar: -
X-Spam_report: (-1.1 / 5.0 requ) BAYES_00=-1.9, DKIMWL_WL_HIGH=-0.001,
 DKIM_SIGNED=0.1, DKIM_VALID=-0.1, DKIM_VALID_AU=-0.1, DKIM_VALID_EF=-0.1,
 RCVD_IN_DNSWL_NONE=-0.0001, RCVD_IN_MSPIKE_H4=0.001, RCVD_IN_MSPIKE_WL=0.001,
 RCVD_IN_VALIDITY_RPBL_BLOCKED=0.358, RCVD_IN_VALIDITY_SAFE_BLOCKED=0.659,
 SPF_HELO_PASS=-0.001, SPF_PASS=-0.001 autolearn=no autolearn_force=no
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

On 2/24/26 15:06, Markus Armbruster wrote:
> Paolo Bonzini <pbonzini@redhat.com> writes:
> 
>> This adds two related parts of the Rust bindings:
> 
> [...]
> 
>>   docs/devel/rust.rst                           |   1 +
>>   meson.build                                   |   4 +-
>>   include/qobject/qobject.h                     |   5 +-
>>   rust/util/wrapper.h                           |   8 +
>>   qapi/meson.build                              |   9 +
>>   rust/Cargo.lock                               |   2 +
>>   rust/Cargo.toml                               |   2 +
>>   rust/meson.build                              |   4 +
>>   rust/tests/meson.build                        |  21 +-
>>   rust/tests/tests/integration.rs               |   2 +
>>   rust/tests/tests/qapi.rs                      | 444 +++++++++++++
>>   rust/util/Cargo.toml                          |   2 +
>>   rust/util/meson.build                         |  30 +-
>>   rust/util/src/lib.rs                          |   4 +
>>   rust/util/src/qobject/deserialize.rs          | 134 ++++
>>   rust/util/src/qobject/deserializer.rs         | 371 +++++++++++
> 
> Are you sure having two source filenames differ in just one character is
> a good idea?
> 
>>   rust/util/src/qobject/error.rs                |  58 ++
>>   rust/util/src/qobject/mod.rs                  | 383 ++++++++++++
>>   rust/util/src/qobject/serialize.rs            |  59 ++
>>   rust/util/src/qobject/serializer.rs           | 585 ++++++++++++++++++
> 
> Likewise.

I feel and share your pain...  That's how serde calls the things ("-er" 
for the struct and verb for the trait) and I cannot really thing of a 
different naming for files.

I thought of renaming serializer.rs to to_qobject.rs, and 
deserializer.rs to from_qobject.rs.  However, that doesn't work out 
because I want  "qobject::to_object" to be the function, not the module 
containing to_qobject() and Serializer.

serde_json places the struct and trait in the same file (e.g. 
https://github.com/serde-rs/json/blob/master/src/value/ser.rs).  I can 
do that if you prefer it that way.

Paolo

> These caused a bit of friction in review already...
> 
> [...]
> 
> 
> 


